#include "..\define.h"
#include "..\sfall\sfall.h"
#include "..\sfall\lib.arrays.h"
#include "..\sfall\lib.strings.h"
#include "..\sfall\define_extra.h"
#include "tile.h"

#define NAME "fo2tweaks"
#define fo2tweaks_ini "fo2tweaks.ini"
#define fo2tweaks_setting(section, setting) get_ini_setting(fo2tweaks_ini + "|" + section + "|" + setting)
#define fo2tweaks_string(section, setting) get_ini_string(fo2tweaks_ini + "|" + section + "|" + setting)
#define ndebug(message) debug_msg(NAME + ": " + message + "\n")

#define sec_main "main"
#define set_carry_weight "carry_weight"
#define set_grenades_chance "grenades_chance"
#define set_level5 "level5"
#define set_worldmap_key "worldmap_key"
#define set_molotov_fire "molotov_fire"
#define set_no_knockback "no_knockback"
#define set_trunk_space "trunk_space"
#define set_autodoors "autodoors"
#define set_ammobox "ammobox"
#define set_sneak_spotted "sneak_spotted"
#define set_modoc_brahmin "modoc_brahmin"
#define set_healing_revision "healing_revision"
#define set_no_scope_penalty "no_scope_penalty"
#define set_hp_over_head "hp_over_head"
#define set_party_skill_items "party_skill_items"
#define set_damage_mod "damage_mod"

#define sec_damage_mod "damage_mod"
#define set_damage_mod_new_burst "new_burst"
#define set_damage_mod_random_bodyparts "unaimed_shots_random_bodyparts"
#define set_damage_mod_bodyparts_chance "unaimed_shots_bodyparts_chance"

#define sec_party_skill_items "party_skill_items"

#define sec_sneak_spotted "sneak_spotted"
#define set_sneak_spotted_msg "message"
#define set_sneak_spotted_stop "stop"

#define sec_ammobox "ammobox"
#define set_ammobox_number "number"
#define set_ammobox_color "color"

#define sec_radon "broken_radon"
#define set_radon_armor "armor"
#define set_radon_items "items"

#define sec_grenades_chance "grenades_chance"
#define set_grenades_weapons "weapons"
#define set_grenades_ammo "ammo"

#define sec_molotov_fire "molotov_fire"
#define set_molotov_flameboy "flameboy"

#define sec_worldmap "worldmap"
#define set_worldmap_hotkey "hotkey"

#define sec_no_scope_penalty "no_scope_penalty"
#define set_scope_remove "remove"
#define set_scope_to_long "to_long"

#define is_weapon(x) (obj_item_subtype(x) == item_type_weapon)
#define is_critter(obj)   (obj_type(obj) == OBJ_TYPE_CRITTER)
#define in_combat (get_game_mode bwand COMBAT)
#define is_dead(critter_obj) (critter_state(critter_obj) == CRITTER_IS_DEAD)


procedure get_active_weapon(variable attacker) begin
  variable item;
  if attacker == dude_obj and active_hand == 0 then begin
    item := critter_inven_obj2(attacker, INVEN_TYPE_LEFT_HAND);
  end else begin
    item := critter_inven_obj2(attacker, INVEN_TYPE_RIGHT_HAND);
  end
  if is_weapon(item) then begin
    return item;
  end else begin
    return -1;
  end
end

procedure get_dude_inactive_weapon begin
  variable item;
  if active_hand == 0 then begin
    item := critter_inven_obj2(dude_obj, INVEN_TYPE_RIGHT_HAND);
  end else begin
    item := critter_inven_obj2(dude_obj, INVEN_TYPE_LEFT_HAND);
  end
  if is_weapon(item) then begin
    return item;
  end else begin
    return -1;
  end
end

procedure get_active_weapon_pid(variable attacker) begin
  variable weapon, weapon_pid;
  weapon := get_active_weapon(attacker);
  if weapon != -1 then begin
    weapon_pid := obj_pid(weapon);
  end else begin
    weapon_pid := -1;
  end
  return weapon_pid;
end

procedure get_active_ammo_pid(variable attacker) begin
  variable weapon, ammo_pid;
  weapon := get_active_weapon(attacker);
  if weapon != -1 then begin
    ammo_pid := get_weapon_ammo_pid(weapon);
  end else begin
    ammo_pid := -1;
  end
  return ammo_pid;
end

procedure get_dude_inactive_ammo_pid begin
  variable weapon, ammo_pid;
  weapon := get_dude_inactive_weapon;
  if weapon != -1 then begin
    ammo_pid := get_weapon_ammo_pid(weapon);
  end else begin
    ammo_pid := -1;
  end
  return ammo_pid;
end

procedure load_comsep_ini_setting(variable file, variable section, variable setting) begin
  variable str, ar, ar2;
  str := get_ini_string(file + "|" + section + "|" + setting);
  ar := string_split_ints(str, ",");
  ar2 := create_array(len_array(ar), 0);
  ar2 := ar;
  return ar2;
end

procedure fo2tweaks_comsep_setting(variable section, variable setting) begin
  variable ar := load_comsep_ini_setting(fo2tweaks_ini, section, setting);
  return ar;
end

procedure in_party(variable obj) begin
  if is_in_array(obj, party_member_list_critters) then return true;
  else return false;
end

procedure is_empty(variable container_or_critter_obj) begin
  if inven_ptr(container_or_critter_obj, 0) then return false;
  return true;
end

procedure is_container(variable obj) begin
  if obj_type(obj) != OBJ_TYPE_ITEM then return false;
  if obj_item_subtype(obj) != item_type_container then return false;
  return true;
end

procedure get_party_skill_level(variable skill) begin
  variable who;
  variable who_best;
  variable skill_level := 0;
  variable skill_name;
  foreach who in party_member_list_critters begin
    variable who_skill := critter_skill_level(who, skill);
    if who_skill > skill_level then begin
      skill_level := who_skill;
      who_best := who;
    end
  end
  ndebug(obj_name(who_best) + " has best skill " + mstr_skill(skill_name) + " of " + skill_level);
  return [who_best, skill_level];
end
