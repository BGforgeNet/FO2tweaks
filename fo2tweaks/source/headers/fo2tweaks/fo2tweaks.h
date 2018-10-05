#include "..\define.h"
#include "..\sfall\sfall.h"
#include "..\sfall\lib.arrays.h"

#define fo2tweaks_ini "fo2tweaks.ini"
#define fo2tweaks_setting(section, setting) get_ini_setting(fo2tweaks_ini + "|" + section + "|" + setting)
#define fo2tweaks_string(section, setting) get_ini_string(fo2tweaks_ini + "|" + section + "|" + setting)
#define ndebug(message) debug_msg(NAME + ": " + message)

#define sec_main "main"
#define set_carry_weight "carry_weight"
#define set_grenades_chance "grenades_chance"
#define set_level5 "level5"
#define set_worldmap_key "worldmap_key"
#define set_molotov_fire "molotov_fire"
#define set_no_knockback "no_knockback"
#define set_burst_control "burst_control"
#define set_trunk_space "trunk_space"
#define set_autodoors "autodoors"
#define set_ammobox "ammobox"
#define set_sneak_spotted "sneak_spotted"
#define set_modoc_brahmin "modoc_brahmin"
#define set_healing_revision "healing_revision"
#define set_no_scope_penalty "no_scope_penalty"
#define set_hp_over_head "hp_over_head"

#define sec_healing_revision "healing_revision"
#define set_healing_not_in_combat_msg "not_in_combat_msg"
#define set_healing_already_used_msg "already_used_msg"
#define set_healing_use_items "use_items"
#define set_healing_heal_disabilities_msg "heal_disabilites_msg"
#define set_healing_fail_disabilities_msg "fail_disabilites_msg"
#define set_healing_fail_msg "fail_msg"
#define set_healing_no_chance_msg "no_chance_msg"
#define set_healing_healthy_msg "healthy_msg"
#define set_healing_doctor_items "doctor_items"
#define set_healing_fa_items "first_aid_items"

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

#define sec_burst_control "burst_control"
#define set_burst_float_on "float_on"
#define set_burst_float_off "float_off"
#define set_burst_display_on "display_on"
#define set_burst_display_off "display_off"
#define set_burst_key "burst_key"

#define sec_molotov_fire "molotov_fire"
#define set_molotov_flameboy "flameboy"

#define sec_worldmap "worldmap"
#define set_worldmap_hotkey "hotkey"

#define sec_no_scope_penalty "no_scope_penalty"
#define set_scope_remove "remove"
#define set_scope_to_long "to_long"

#define is_weapon(x) (obj_item_subtype(x) == item_type_weapon)

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
  variable str, ar;
  str := get_ini_string(file + "|" + section + "|" + setting);
  ar := string_split(str, ",");
  return ar;
end

procedure fo2tweaks_comsep_setting(variable section, variable setting) begin
  variable ar := load_comsep_ini_setting(fo2tweaks_ini, section, setting);
  return ar;
end
