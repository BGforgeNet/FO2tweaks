// fo2tweaks library - TypeScript implementation

import {
    ObjectPtr, ItemPtr, CritterPtr, SceneryPtr, ContainerPtr, DoorPtr, SKILL, LEFT_HAND,
    dude_obj, obj_item_subtype, obj_type, obj_pid, obj_name, proto_data,
    critter_inven_obj, critter_state, use_obj_on_obj, float_msg, ndebug,
    SfallList, SfallMap
} from "folib";
import {
    // Functions
    active_hand, atoi, critter_inven_obj2, critter_skill_level,
    get_array, get_game_mode, get_ini_section, get_ini_setting, get_ini_string,
    get_light_level, get_proto_data, get_weapon_ammo_pid, inven_ptr, is_in_array,
    len_array, list, map, party_member_list_critters, set_array, set_ini_setting, set_self,
    temp_array_map,
    // Array helpers
    array_append, array_push, string_split_ints,
    // Constants
    COMBAT, CRITTER_IS_DEAD, DIALOG, FLOAT_MSG_WARNING,
    INVEN_TYPE_LEFT_HAND, INVEN_TYPE_RIGHT_HAND, INVEN_TYPE_WORN, INVENTORY,
    it_type, item_type_ammo, item_type_armor, item_type_container, item_type_weapon,
    OBJ_TYPE_CRITTER, OBJ_TYPE_ITEM, OBJ_TYPE_SCENERY, PROTO_WP_ANIM,
    WPN_ANIM_BIG_GUN, WPN_ANIM_MINIGUN, WPN_ANIM_PISTOL, WPN_ANIM_RIFLE,
    WPN_ANIM_ROCKET_LAUNCHER, WPN_ANIM_SMG,
} from "folib/sfall";

// ============================================================================
// Constants
// ============================================================================

/** fo2tweaks INI file path */
export const fo2tweaks_ini = "mods\\fo2tweaks.ini";

/** Main section name */
export const sec_main = "main";

// ============================================================================
// INI Functions
// ============================================================================

/**
 * Get a numeric setting from fo2tweaks.ini
 * @param section INI section name
 * @param setting Setting key name
 * @returns The numeric value of the setting
 */
export function fo2tweaks_setting(section: string, setting: string): number {
    return get_ini_setting(fo2tweaks_ini + "|" + section + "|" + setting);
}

/**
 * Get a string setting from fo2tweaks.ini
 * @param section INI section name
 * @param setting Setting key name
 * @returns The string value of the setting
 */
export function fo2tweaks_string(section: string, setting: string): string {
    return get_ini_string(fo2tweaks_ini + "|" + section + "|" + setting);
}

// ============================================================================
// Object Type Checks
// ============================================================================

/**
 * Check if an object is a weapon
 * @param obj Item pointer to check
 * @returns True if the object is a weapon
 */
export function is_weapon(obj: ItemPtr): boolean {
    return obj_item_subtype(obj) == item_type_weapon;
}

/**
 * Check if a prototype ID is a weapon
 * @param pid Prototype ID to check
 * @returns True if the PID is a weapon
 */
export function is_weapon_pid(pid: number): boolean {
    return proto_data(pid, it_type) == item_type_weapon;
}

/**
 * Check if an object is ammo
 * @param obj Item pointer to check
 * @returns True if the object is ammo
 */
export function is_ammo(obj: ItemPtr): boolean {
    return obj_item_subtype(obj) == item_type_ammo;
}

/**
 * Check if a prototype ID is ammo
 * @param pid Prototype ID to check
 * @returns True if the PID is ammo
 */
export function is_ammo_pid(pid: number): boolean {
    return proto_data(pid, it_type) == item_type_ammo;
}

/**
 * Check if an object is armor
 * @param obj Item pointer to check
 * @returns True if the object is armor
 */
export function is_armor(obj: ItemPtr): boolean {
    return obj_item_subtype(obj) == item_type_armor;
}

/**
 * Check if a prototype ID is armor
 * @param pid Prototype ID to check
 * @returns True if the PID is armor
 */
export function is_armor_pid(pid: number): boolean {
    return proto_data(pid, it_type) == item_type_armor;
}

/**
 * Check if an object is a critter
 * @param obj Object pointer to check
 * @returns True if the object is a critter
 */
export function is_critter(obj: ObjectPtr): obj is CritterPtr {
    return obj_type(obj) == OBJ_TYPE_CRITTER;
}

/**
 * Check if an object is an item
 * @param obj Object pointer to check
 * @returns True if the object is an item
 */
export function is_item(obj: ObjectPtr): obj is ItemPtr {
    return obj_type(obj) == OBJ_TYPE_ITEM;
}

/**
 * Check if an object is scenery
 * @param obj Object pointer to check
 * @returns True if the object is scenery
 */
export function is_scenery(obj: ObjectPtr): obj is SceneryPtr {
    return obj_type(obj) == OBJ_TYPE_SCENERY;
}

/**
 * Check if a critter is dead
 * @param critter_obj Critter object pointer
 * @returns True if the critter is dead
 */
export function is_dead(critter_obj: CritterPtr): boolean {
    return critter_state(critter_obj) == CRITTER_IS_DEAD;
}

/**
 * Check if an object is a container
 * @param obj Item pointer to check
 * @returns True if the object is a container
 */
export function is_container(obj: ItemPtr): obj is ContainerPtr {
    if (obj_type(obj) != OBJ_TYPE_ITEM) return false;
    if (obj_item_subtype(obj) != item_type_container) return false;
    return true;
}

/**
 * Check if a container or critter inventory is empty
 * @param container_or_critter_obj Object to check
 * @returns True if empty
 */
export function is_empty(container_or_critter_obj: ObjectPtr): boolean {
    if (inven_ptr(container_or_critter_obj, 0)) return false;
    return true;
}

// ============================================================================
// Game Mode Checks
// ============================================================================

/**
 * Check if currently in combat mode
 * @returns True if in combat
 */
export function in_combat(): boolean {
    return (get_game_mode() & COMBAT) != 0;
}

/**
 * Check if currently in inventory mode
 * @returns True if in inventory
 */
export function in_inventory(): boolean {
    return (get_game_mode() & INVENTORY) != 0;
}

/**
 * Check if currently in dialog mode
 * @returns True if in dialog
 */
export function in_dialog(): boolean {
    return (get_game_mode() & DIALOG) != 0;
}

/**
 * Check if a game mode just ended
 * @param mode_to_check Mode flag to check
 * @param old_mode Previous game mode
 * @param new_mode Current game mode
 * @returns True if the mode ended
 */
export function mode_ended(mode_to_check: number, old_mode: number, new_mode: number): boolean {
    if ((old_mode & mode_to_check) > 0 && (new_mode & mode_to_check) == 0) return true;
    return false;
}

/**
 * Check if a game mode just started
 * @param mode_to_check Mode flag to check
 * @param old_mode Previous game mode
 * @param new_mode Current game mode
 * @returns True if the mode started
 */
export function mode_started(mode_to_check: number, old_mode: number, new_mode: number): boolean {
    if ((old_mode & mode_to_check) == 0 && (new_mode & mode_to_check) > 0) return true;
    return false;
}

// ============================================================================
// Weapon Functions
// ============================================================================

/**
 * Get the active weapon for an attacker
 * @param attacker Critter object pointer
 * @returns The weapon object pointer, or 0 if no weapon
 */
export function get_active_weapon(attacker: CritterPtr): ItemPtr {
    let item: ItemPtr;
    if (attacker == dude_obj && active_hand() == LEFT_HAND) {
        item = critter_inven_obj2(attacker, INVEN_TYPE_LEFT_HAND) as ItemPtr;
    } else {
        item = critter_inven_obj2(attacker, INVEN_TYPE_RIGHT_HAND) as ItemPtr;
    }
    if (item && is_weapon(item)) return item;
    return 0 as ItemPtr;
}

/**
 * Get the dude's inactive hand weapon
 * @returns The weapon object pointer, or 0 if no weapon
 */
export function get_dude_inactive_weapon(): ItemPtr {
    let item: ItemPtr;
    if (active_hand() == LEFT_HAND) {
        item = critter_inven_obj2(dude_obj, INVEN_TYPE_RIGHT_HAND) as ItemPtr;
    } else {
        item = critter_inven_obj2(dude_obj, INVEN_TYPE_LEFT_HAND) as ItemPtr;
    }
    if (item && is_weapon(item)) return item;
    return 0 as ItemPtr;
}

/**
 * Get the prototype ID of the active weapon
 * @param attacker Critter object pointer
 * @returns The weapon PID, or 0 if no weapon
 */
export function get_active_weapon_pid(attacker: CritterPtr): number {
    const weapon = get_active_weapon(attacker);
    if (weapon) return obj_pid(weapon);
    return 0;
}

/**
 * Get the ammo PID of the active weapon
 * @param attacker Critter object pointer
 * @returns The ammo PID, or 0 if no ammo
 */
export function get_active_ammo_pid(attacker: CritterPtr): number {
    const weapon = get_active_weapon(attacker);
    if (!weapon) return 0;
    const ammo_pid = get_weapon_ammo_pid(weapon);
    if (ammo_pid == -1) return 0;
    return ammo_pid;
}

/**
 * Get the ammo PID of the dude's inactive weapon
 * @returns The ammo PID, or 0 if no ammo
 */
export function get_dude_inactive_ammo_pid(): number {
    const weapon = get_dude_inactive_weapon();
    if (!weapon) return 0;
    const ammo_pid = get_weapon_ammo_pid(weapon);
    if (ammo_pid == -1) return 0;
    return ammo_pid;
}

/**
 * Check if a weapon is a ranged gun (uses ranged animation)
 * @param obj Weapon object pointer
 * @returns True if the weapon is a gun
 */
export function is_gun(obj: ItemPtr): boolean {
    /** RPU additional rifle animation */
    const WPN_ANIM_RIFLE_EXTRA = 13;
    const ranged_codes = list(
        WPN_ANIM_PISTOL,
        WPN_ANIM_SMG,
        WPN_ANIM_RIFLE,
        WPN_ANIM_BIG_GUN,
        WPN_ANIM_MINIGUN,
        WPN_ANIM_ROCKET_LAUNCHER,
        WPN_ANIM_RIFLE_EXTRA,
    );
    if (!is_weapon(obj)) return false;
    const anim_code = get_proto_data(obj_pid(obj), PROTO_WP_ANIM);
    ndebug("anim_code = " + anim_code);
    return is_in_array(anim_code, ranged_codes);
}

/**
 * Get the armor worn by a critter
 * @param obj Critter object pointer
 * @returns The armor object pointer, or 0 if no armor
 */
export function obj_armor(obj: CritterPtr): ItemPtr {
    const armor = critter_inven_obj(obj, INVEN_TYPE_WORN);
    if (!armor || !is_armor(armor)) return 0 as ItemPtr;
    return armor;
}

// ============================================================================
// Party Functions
// ============================================================================

/**
 * Check if an object is in the player's party
 * @param obj Object pointer to check
 * @returns True if in party
 */
export function in_party(obj: ObjectPtr): boolean {
    if (is_in_array(obj as CritterPtr, party_member_list_critters())) return true;
    return false;
}

// ============================================================================
// Utility Functions
// ============================================================================

/**
 * Greatest common divisor
 * @param x First number
 * @param y Second number
 * @returns GCD of x and y
 */
export function gcd(x: number, y: number): number {
    let x_: number;
    while (y != 0) {
        x_ = y;
        y = x % y;
        x = x_;
    }
    return x;
}

// ============================================================================
// INI Array Functions
// ============================================================================

/**
 * Load a comma-separated INI setting as an array
 * @param file INI file path
 * @param section Section name
 * @param setting Setting key
 * @returns Array of integer values (PIDs)
 */
export function load_comsep_ini_setting(file: string, section: string, setting: string): SfallList<number> {
    const str = get_ini_string(file + "|" + section + "|" + setting);
    return string_split_ints(str, ",");
}

/**
 * Load a comma-separated setting from fo2tweaks.ini
 * @param section Section name
 * @param setting Setting key
 * @returns Array of integer values (PIDs)
 */
export function fo2tweaks_comsep_setting(section: string, setting: string): SfallList<number> {
    return load_comsep_ini_setting(fo2tweaks_ini, section, setting);
}

/**
 * Load a comma-separated setting from fo2tweaks.ini as integers
 * @param section Section name
 * @param setting Setting key
 * @returns Array of integer values
 */
export function fo2tweaks_comsep_setting_ints(section: string, setting: string): SfallList<number> {
    return load_comsep_ini_setting(fo2tweaks_ini, section, setting);
}

/**
 * Get an INI section as integer key-value pairs
 * Warning: values cannot be 0, or will be skipped!
 * @param file INI file path
 * @param section Section name
 * @returns Map of integer keys to integer values
 */
export function get_ini_section_ints(file: string, section: string): SfallMap<number, number> {
    const ar2 = map({}) as SfallMap<number, number>;
    const ar = get_ini_section(file, section);
    for (const [k, v] of ar) {
        ndebug(k + " " + v);
        ar2[atoi(k)] = atoi(v);
    }
    return ar2;
}

// ============================================================================
// Party Skill Functions
// ============================================================================

/**
 * Get the party member with the best skill level
 * @param skill Skill ID to check
 * @returns Array of [best_party_member, skill_level]
 */
export function get_party_skill_level(skill: SKILL): [CritterPtr, number] {
    let who_best!: CritterPtr;
    let skill_level = 0;
    for (const who of party_member_list_critters()) {
        const who_skill = critter_skill_level(who, skill);
        ndebug(obj_name(who) + " has skill " + skill + " level of " + who_skill);
        if (who_skill >= skill_level) {
            skill_level = who_skill;
            who_best = who;
        }
    }
    ndebug(obj_name(who_best) + " has best skill level of " + skill_level);
    return [who_best, skill_level];
}

// ============================================================================
// Object Interaction Functions
// ============================================================================

/**
 * Force use an object on another object
 * @param who Critter performing the action
 * @param item Item to use
 * @param target Target object
 */
export function use_obj_on_obj_force(who: ObjectPtr, item: ObjectPtr, target: ObjectPtr): void {
    set_self(who);
    set_self(who);
    use_obj_on_obj(item, target);
    set_self(0 as ObjectPtr);
}

// ============================================================================
// Scenery Functions
// ============================================================================

/** Scenery subtype proto offset */
const PRODATA_SC_TYPE = 32;
/** Door scenery type */
const SC_TYPE_DOOR = 0;

/**
 * Check if a scenery object is a door
 * @param scenery_obj Scenery object pointer
 * @returns True if the object is a door
 */
export function is_door(scenery_obj: SceneryPtr): scenery_obj is DoorPtr {
    if (get_proto_data(obj_pid(scenery_obj), PRODATA_SC_TYPE) == SC_TYPE_DOOR) return true;
    return false;
}

// ============================================================================
// Light Level Functions
// ============================================================================

/**
 * Convert absolute light level to percentage (0-100)
 * @param abs_level Absolute light level, or -1 to use current level
 * @returns Percentage light level
 */
export function light_level_abs_to_pct(abs_level: number = -1): number {
    const pct_level_map: { [key: number]: number } = {
        16384: 0, 16629: 1, 16875: 2, 17121: 3, 17367: 4, 17612: 5, 17858: 6, 18104: 7, 18350: 8, 18595: 9,
        18841: 10, 19087: 11, 19333: 12, 19578: 13, 19824: 14, 20070: 15, 20316: 16, 20561: 17, 20807: 18, 21053: 19,
        21299: 20, 21544: 21, 21790: 22, 22036: 23, 22282: 24, 22528: 25, 22773: 26, 23019: 27, 23265: 28, 23511: 29,
        23756: 30, 24002: 31, 24248: 32, 24494: 33, 24739: 34, 24985: 35, 25231: 36, 25477: 37, 25722: 38, 25968: 39,
        26214: 40, 26460: 41, 26705: 42, 26951: 43, 27197: 44, 27443: 45, 27688: 46, 27934: 47, 28180: 48, 28426: 49,
        40960: 50, 53493: 51, 53739: 52, 53985: 53, 54231: 54, 54476: 55, 54722: 56, 54968: 57, 55214: 58, 55459: 59,
        55705: 60, 55951: 61, 56197: 62, 56442: 63, 56688: 64, 56934: 65, 57180: 66, 57425: 67, 57671: 68, 57917: 69,
        58163: 70, 58408: 71, 58654: 72, 58900: 73, 59146: 74, 59392: 75, 59637: 76, 59883: 77, 60129: 78, 60375: 79,
        60620: 80, 60866: 81, 61112: 82, 61358: 83, 61603: 84, 61849: 85, 62095: 86, 62341: 87, 62586: 88, 62832: 89,
        63078: 90, 63324: 91, 63569: 92, 63815: 93, 64061: 94, 64307: 95, 64552: 96, 64798: 97, 65044: 98, 65290: 99,
        65536: 100
    };
    if (abs_level == -1) return pct_level_map[get_light_level()];
    return pct_level_map[abs_level];
}

/**
 * Convert percentage light level (0-100) to absolute
 * @param pct_level Percentage light level
 * @returns Absolute light level
 */
export function light_level_pct_to_abs(pct_level: number): number {
    const abs_level_map: { [key: number]: number } = {
        0: 16384, 1: 16629, 2: 16875, 3: 17121, 4: 17367, 5: 17612, 6: 17858, 7: 18104, 8: 18350, 9: 18595,
        10: 18841, 11: 19087, 12: 19333, 13: 19578, 14: 19824, 15: 20070, 16: 20316, 17: 20561, 18: 20807, 19: 21053,
        20: 21299, 21: 21544, 22: 21790, 23: 22036, 24: 22282, 25: 22528, 26: 22773, 27: 23019, 28: 23265, 29: 23511,
        30: 23756, 31: 24002, 32: 24248, 33: 24494, 34: 24739, 35: 24985, 36: 25231, 37: 25477, 38: 25722, 39: 25968,
        40: 26214, 41: 26460, 42: 26705, 43: 26951, 44: 27197, 45: 27443, 46: 27688, 47: 27934, 48: 28180, 49: 28426,
        50: 40960, 51: 53493, 52: 53739, 53: 53985, 54: 54231, 55: 54476, 56: 54722, 57: 54968, 58: 55214, 59: 55459,
        60: 55705, 61: 55951, 62: 56197, 63: 56442, 64: 56688, 65: 56934, 66: 57180, 67: 57425, 68: 57671, 69: 57917,
        70: 58163, 71: 58408, 72: 58654, 73: 58900, 74: 59146, 75: 59392, 76: 59637, 77: 59883, 78: 60129, 79: 60375,
        80: 60620, 81: 60866, 82: 61112, 83: 61358, 84: 61603, 85: 61849, 86: 62095, 87: 62341, 88: 62586, 89: 62832,
        90: 63078, 91: 63324, 92: 63569, 93: 63815, 94: 64061, 95: 64307, 96: 64552, 97: 64798, 98: 65044, 99: 65290,
        100: 65536
    };
    return abs_level_map[pct_level];
}

// ============================================================================
// PID Lists
// ============================================================================

// Party member PIDs - imported from folib/rp/critterpid
import {
    PID_VIC, PID_SULIK, PID_JOHN_MACRAE, PID_LENNY, PID_MYRON, PID_MARCUS,
    PID_DAVIN, PID_MIRIA, PID_BRAINBOT, PID_ROBOBRAIN_CHIMP, PID_ROBOBRAIN_HUMAN,
    PID_ROBOBRAIN_ABNORMAL, PID_GORIS, PID_CYBERDOG, PID_K9, PID_DOGMEAT,
    PID_KITSUNE, PID_DEX, PID_CAT_JULES
} from "folib/rp/critterpid";

// Ammo PIDs - imported from folib/rp/itempid
import {
    PID_EXPLOSIVE_ROCKET, PID_10MM_JHP, PID_10MM_AP, PID_44_MAGNUM_JHP,
    PID_FLAMETHROWER_FUEL, PID_14MM_AP, PID_223_FMJ, PID_5MM_JHP, PID_5MM_AP,
    PID_ROCKET_AP, PID_SMALL_ENERGY_CELL, PID_MICRO_FUSION_CELL, PID_SHOTGUN_SHELLS,
    PID_44_FMJ_MAGNUM, PID_9MM_BALL, PID_BBS, PID_ROBO_ROCKET_AMMO,
    PID_45_CALIBER_AMMO, PID_2MM_EC_AMMO, PID_4_7MM_CASELESS, PID_9MM_AMMO,
    PID_HN_NEEDLER_CARTRIDGE, PID_HN_AP_NEEDLER_CARTRIDGE, PID_7_62MM_AMMO,
    PID_FLAMETHROWER_FUEL_MK_II
} from "folib/rp/itempid";

/**
 * Get list of Fallout 2 party member PIDs
 * @returns Array of party member PIDs
 */
export function f2_party_member_pids(): SfallList<number> {
    return list(
        PID_VIC, PID_SULIK, PID_JOHN_MACRAE, PID_LENNY, PID_MYRON, PID_MARCUS,
        PID_DAVIN, PID_MIRIA, PID_BRAINBOT, PID_ROBOBRAIN_CHIMP, PID_ROBOBRAIN_HUMAN,
        PID_ROBOBRAIN_ABNORMAL, PID_GORIS, PID_CYBERDOG, PID_K9, PID_DOGMEAT
    );
}

/**
 * Get list of Restoration Project party member PIDs
 * @returns Array of RP party member PIDs
 */
export function rp_party_member_pids(): SfallList<number> {
    return list(PID_KITSUNE, PID_DEX, PID_CAT_JULES);
}

/**
 * Get combined list of F2 and RP party member PIDs
 * @returns Array of all party member PIDs
 */
export function f2rp_party_member_pids(): SfallList<number> {
    const pids = f2_party_member_pids();
    const rp_pids = rp_party_member_pids();
    return array_append(pids, rp_pids);
}

/**
 * Get list of Fallout 2 ammo PIDs
 * @returns Array of ammo PIDs
 */
export function f2_ammo_pids(): SfallList<number> {
    return list(
        PID_EXPLOSIVE_ROCKET, PID_10MM_JHP, PID_10MM_AP, PID_44_MAGNUM_JHP,
        PID_FLAMETHROWER_FUEL, PID_14MM_AP, PID_223_FMJ, PID_5MM_JHP, PID_5MM_AP,
        PID_ROCKET_AP, PID_SMALL_ENERGY_CELL, PID_MICRO_FUSION_CELL, PID_SHOTGUN_SHELLS,
        PID_44_FMJ_MAGNUM, PID_9MM_BALL, PID_BBS, PID_ROBO_ROCKET_AMMO,
        PID_45_CALIBER_AMMO, PID_2MM_EC_AMMO, PID_4_7MM_CASELESS, PID_9MM_AMMO,
        PID_HN_NEEDLER_CARTRIDGE, PID_HN_AP_NEEDLER_CARTRIDGE, PID_7_62MM_AMMO,
        PID_FLAMETHROWER_FUEL_MK_II
    );
}

/**
 * Get NPC level stage configuration for F2/RP
 * Format: "start_level,level_step"
 * @returns Map of PID to stage config string
 */
export function f2rp_npc_stages(): { [key: number]: string } {
    return {
        [PID_SULIK]: "6,3",
        [PID_VIC]: "5,4",
        [PID_JOHN_MACRAE]: "10,4",
        [PID_LENNY]: "10,5",
        [PID_MARCUS]: "12,3",
        [PID_MYRON]: "6,4",
        [PID_BRAINBOT]: "10,4",
        [PID_CYBERDOG]: "9,4", // Robodog
        [PID_GORIS]: "10,4",
        [PID_K9]: "12,4",
        [PID_DOGMEAT]: "6,3",
        [PID_CAT_JULES]: "12,3",
        [PID_KITSUNE]: "12,3",
        [PID_DEX]: "12,3"
    };
}

/**
 * Check if filesystem override is enabled in ddraw.ini.
 * If not, enables it and warns the user to restart.
 */
export function check_filesystem_override(script_name: string): boolean {
    const fs_override = get_ini_setting("ddraw.ini|Misc|UseFileSystemOverride");
    if (fs_override != 1) {
        ndebug("UseFileSystemOverride is disabled, enabling");
        set_ini_setting("ddraw.ini|Misc|UseFileSystemOverride", 1);
        float_msg(dude_obj, script_name + ": filesystem override was disabled, some features failed to load. The setting is corrected. EXIT AND RE-LAUNCH THE GAME now.", FLOAT_MSG_WARNING);
        return false;
    }
    return true;
}
