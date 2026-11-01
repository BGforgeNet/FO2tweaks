// Healing revision's Doctor and First Aid logic, shared by the scripts that apply it.
// Each script that imports this calls healing_init() once per game load.

import {
    critter_heal,
    critter_state,
    CritterPtr,
    display_msg,
    dude_obj,
    game_ticks,
    game_time_advance,
    get_critter_stat,
    get_day, give_exp_points,
    has_trait,
    ndebug,
    obj_name, obj_pid,
    random,
    SfallList,
    SKILL
} from "folib";
import {
    add_extra_msg_file, array_push, clear_array,
    critter_skill_level, critter_uninjure,
    DAM_BLIND, DAM_CRIP_ARM_LEFT, DAM_CRIP_ARM_RIGHT, DAM_CRIP_LEG_LEFT, DAM_CRIP_LEG_RIGHT,
    floor2, get_sfall_global_int,
    is_critter_dead, is_in_array, load_create_array,
    message_str_game, mstr_skill, parse_str_2,
    PERK_healer,
    set_sfall_global, sprintf,
    STAT, TRAIT_PERK,
} from "folib/sfall";
import { get_party_skill_level, in_party } from "../fo2tweaks";

const all_disabilities = (DAM_CRIP_ARM_LEFT | DAM_CRIP_ARM_RIGHT | DAM_CRIP_LEG_LEFT | DAM_CRIP_LEG_RIGHT | DAM_BLIND);

function is_disabled(x: CritterPtr): boolean {
    return (critter_state(x) & all_disabilities) != 0;
}

// Saved lists of patients treated today, keyed by pid: object pointers change on load and map change, so critters
// sharing a prototype share one daily treatment. Engine object ids are unique only within a map (party members keep
// theirs across maps), so a per-critter key would be the id for the party and map plus id for everyone else.
const doctor_used_array = "g_doctor_used";
const fa_used_array = "g_fa_used";

const doctor_skill_name = 107;
const fa_skill_name = 106;

const msg_file = "g_healing_revision.msg";
const msg_heal_disabilities = 1;
const msg_fail_disabilities = 2;
export const msg_not_in_combat = 3;
const msg_no_chance = 4;
const msg_healthy = 5;
const msg_already_used = 6;
const msg_fail = 7;
export const msg_living_anatomy = 8;
export const msg_living_anatomy_2 = 9;
const msg_got_xp = 10;
const msg_healed_for = 11;
const msg_dead = 12;
const msg_fa_disabilities = 13;

let doctor_used: SfallList<number>;
let fa_used: SfallList<number>;
const doctor_min = 20;
const doctor_mult = 10;
const fa_mult = 5;
const heal_max = 15;
let msg: number;

/**
 * Loads the healing state shared through saved arrays, and the message file.
 */
export function healing_init(): void {
    doctor_used = load_create_array(doctor_used_array, 0);
    fa_used = load_create_array(fa_used_array, 0);
    msg = add_extra_msg_file(msg_file);
}

/**
 * Gets message `x` from **game** message file `msg`
 */
export function mymsg(x: number): string {
    return message_str_game(msg, x);
}

/**
 * Displays message `x` from **game** message file `msg`
 */
export function display_mymsg(x: number): void {
    display_msg(mymsg(x));
}

/**
 * The player and party members act for the player: the engine hands the player's Skilldex heal to the companion best
 * at the skill.
 */
function is_player_side(user: CritterPtr): boolean {
    return user == dude_obj || in_party(user);
}

/**
 * The player's side heals with the party's best skill; any other critter with its own.
 */
function user_skill(user: CritterPtr, skill: SKILL): number {
    if (is_player_side(user)) {
        const best: [CritterPtr, number] = get_party_skill_level(skill); // SSL cannot index a call result
        return best[1];
    }
    return critter_skill_level(user, skill);
}

/**
 * Shows a healing message only for the player's side: a script making another critter heal stays silent.
 */
function tell(user: CritterPtr, text: string): void {
    if (is_player_side(user)) display_msg(text);
}

/**
 * @returns true if the treatment was rolled, false if the skill gave no chance
 */
function heal_disabilities(user: CritterPtr, target: CritterPtr, effective_skill: number, interactive: boolean): boolean {
    const chance = effective_skill - doctor_min; // percentage
    ndebug("user " + user + ", target " + target + ", eff. doctor " + effective_skill);
    ndebug("chance " + chance + " eff. skill " + effective_skill + " min. doctor " + doctor_min);
    if (chance < 1) {
        // Rest and travel retry every party member at each heal: the refusal only answers an explicit treatment.
        if (interactive) tell(user, mymsg(msg_no_chance));
        return false;
    }
    const r = random(1, 100);
    if (r < chance) {
        tell(user, mymsg(msg_heal_disabilities));
        critter_uninjure(target, all_disabilities);
    } else {
        tell(user, mymsg(msg_fail_disabilities));
    }
    return true;
}

export function is_healthy(target: CritterPtr): boolean {
    const max_hp = get_critter_stat(target, STAT.max_hp);
    const cur_hp = get_critter_stat(target, STAT.current_hp);
    if (cur_hp >= max_hp && !is_disabled(target)) {
        return true;
    } else {
        return false;
    }
}

function get_healed_hp(user: CritterPtr, target: CritterPtr, doctor_level: number, fa_level: number): number {
    const mhp = missing_hp(target);
    let healed = 0;
    if (doctor_level > 100) doctor_level = 100;
    if (fa_level > 100) fa_level = 100;
    healed = (doctor_level / 100.0) * (fa_level / 100.0) * doctor_mult + random(-1, 1);
    if (user == dude_obj) healed = healed + 2 * has_trait(TRAIT_PERK, dude_obj, PERK_healer);
    if (healed < 0) healed = 0;
    const healed_str = sprintf("%f", healed);
    ndebug("missing " + mhp + " doctor_level " + doctor_level + " fa_level " + fa_level + " healed " + healed_str
        + " max: " + heal_max + " |" + fa_mult + "|" + doctor_mult);
    healed = floor2(healed);
    if (healed > mhp) healed = mhp;
    return healed;
}

function get_fa_healed(target: CritterPtr, fa_level: number): number {
    const mhp = missing_hp(target);
    let healed = 0;
    if (fa_level > 100) fa_level = 100;
    healed = fa_mult * fa_level / 100.0 + random(-1, 1);
    if (healed < 0) healed = 0;
    const healed_str = sprintf("%f", healed);
    ndebug("missing " + mhp + " fa_level " + fa_level + " healed " + healed_str + " | " + fa_mult);
    healed = floor2(healed);
    if (healed > mhp) healed = mhp;
    return healed;
}

function missing_hp(target: CritterPtr): number {
    const max_hp = get_critter_stat(target, STAT.max_hp);
    const cur_hp = get_critter_stat(target, STAT.current_hp);
    const mhp = max_hp - cur_hp;
    return mhp;
}

export function doctor_used_today(target: CritterPtr): boolean {
    return is_in_array(obj_pid(target), doctor_used);
}

export function fa_used_today(target: CritterPtr): boolean {
    return is_in_array(obj_pid(target), fa_used);
}

/**
 * @returns true if a treatment was attempted, whatever its outcome; false if it was refused
 */
export function use_doctor(user: CritterPtr, target: CritterPtr, skill_bonus: number, interactive: boolean = true): boolean {
    const doctor_level = user_skill(user, SKILL.DOCTOR);
    const fa_level = user_skill(user, SKILL.FIRST_AID);
    const effective_doctor = doctor_level + skill_bonus;
    let attempted = false;

    ndebug("doctor level " + doctor_level + ", skill bonus " + skill_bonus + ", effective " + effective_doctor);

    if (interactive) {
        if (is_critter_dead(target)) {
            tell(user, mymsg(msg_dead));
            return false;
        }
        if (is_healthy(target)) { // healthy, nothing to do
            tell(user, obj_name(target) + mymsg(msg_healthy));
            return false;
        } else {
            if (doctor_used_today(target)) {
                const skill_name = get_skill_name(SKILL.DOCTOR);
                tell(user, parse_str_2(mymsg(msg_already_used), obj_name(target), skill_name));
                return false;
            }
        }
    }

    ndebug("user " + user + ", target " + target + ", eff. doctor " + effective_doctor);
    ndebug("critter state " + sprintf("%d", critter_state(target)));

    if (is_disabled(target)) attempted = heal_disabilities(user, target, effective_doctor, interactive);

    if (missing_hp(target) > 0) {
        const name = obj_name(target);
        const hp = get_healed_hp(user, target, effective_doctor, fa_level);
        ndebug("trying to heal " + name);
        attempted = true;

        if (hp < 1) {
            tell(user, mymsg(msg_fail));
        } else {
            critter_heal(target, hp);
            tell(user, parse_str_2(mymsg(msg_healed_for), obj_name(target), hp));
            if (is_player_side(user)) grant_xp(hp, SKILL.DOCTOR);
        }
    }
    // A treatment of crippled limbs alone also counts as today's, and takes an hour.
    if (attempted) {
        array_push(doctor_used, obj_pid(target));
        set_sfall_global("g_heal_d", get_day);
        if (is_player_side(user)) game_time_advance(game_ticks(3600));
    }
    return attempted;
}

/**
 * @returns true if a treatment was attempted, whatever its outcome; false if it was refused
 */
export function use_first_aid(user: CritterPtr, target: CritterPtr, skill_bonus: number, interactive: boolean = true): boolean {
    const fa_level = user_skill(user, SKILL.FIRST_AID);
    const effective_fa = fa_level + skill_bonus;
    ndebug("fa level " + fa_level + ", skill bonus " + skill_bonus + ", effective " + effective_fa);
    ndebug("userfa " + user + " target " + target);

    if (interactive) {
        if (is_critter_dead(target)) {
            tell(user, mymsg(msg_dead));
            return false;
        }
        if (is_healthy(target)) { // healthy, nothing to do
            tell(user, obj_name(target) + mymsg(msg_healthy));
            return false;
        } else {
            if (fa_used_today(target)) {
                const skill_name = get_skill_name(SKILL.FIRST_AID);
                tell(user, parse_str_2(mymsg(msg_already_used), obj_name(target), skill_name));
                return false;
            }
        }
    }

    // First Aid treats hit points only: a crippled target at full hp gets nothing.
    if (missing_hp(target) <= 0) {
        if (interactive) tell(user, mymsg(msg_fa_disabilities));
        return false;
    }

    const name = obj_name(target);
    const hp = get_fa_healed(target, effective_fa);
    ndebug("trying to heal " + name);

    array_push(fa_used, obj_pid(target));
    set_sfall_global("g_heal_d", get_day);

    if (is_player_side(user)) game_time_advance(game_ticks(1800));
    if (hp < 1) {
        tell(user, mymsg(msg_fail));
        return true;
    }
    critter_heal(target, hp);
    tell(user, parse_str_2(mymsg(msg_healed_for), obj_name(target), hp));
    if (is_player_side(user)) grant_xp(hp, SKILL.FIRST_AID);
    return true;
}

function reset_heal_arrays(): void {
    ndebug("resetting heal arrays");
    clear_array(fa_used);
    clear_array(doctor_used);
}

export function update_heal_arrays(): void {
    const last_day = get_sfall_global_int("g_heal_d");
    ndebug("Last day " + last_day);
    if (last_day == 0) return;
    if (get_day != last_day) reset_heal_arrays();
}

function get_skill_name(skill: SKILL): string {
    let skill_name: string;
    if (skill == SKILL.DOCTOR) {
        skill_name = mstr_skill(doctor_skill_name);
    } else {
        skill_name = mstr_skill(fa_skill_name);
    }
    return skill_name;
}

function grant_xp(hp: number, skill: SKILL): void {
    const xp = hp * 10;
    const skill_name = get_skill_name(skill);
    give_exp_points(xp);
    display_msg(parse_str_2(mymsg(msg_got_xp), xp, skill_name));
}

/**
 * Applies Doctor or First Aid to the target.
 * @returns true if a treatment was attempted, whatever its outcome
 */
export function use_skill(user: CritterPtr, target: CritterPtr, skill: SKILL, skill_bonus: number): boolean {
    update_heal_arrays();
    ndebug("user1 " + user + " target " + target);
    if (skill == SKILL.DOCTOR) return use_doctor(user, target, skill_bonus);
    if (skill == SKILL.FIRST_AID) return use_first_aid(user, target, skill_bonus);
    return false;
}
