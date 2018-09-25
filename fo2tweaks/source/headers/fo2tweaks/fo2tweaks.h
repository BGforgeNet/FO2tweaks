#include "..\define.h"

#define fo2tweaks_ini "fo2tweaks.ini"

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

#define sec_radon "broken_radon"
#define set_radon_armor "armor"
#define set_radon_items "items"

#define sec_grenades_chance "grenades_chance"
#define set_grenades_weapons "weapons"
#define set_grenades_ammo "ammo"

#define sec_burst_control "burst_control"
#define set_burst_message_on "burst_message"
#define set_burst_message_off "nonurst_message"
#define set_burst_key "burst_key"

#define sec_molotov_fire "molotov_fire"
#define set_molotov_flameboy "flameboy"

#define sec_worldmap "worldmap"
#define set_worldmap_hotkey "hotkey"

#define sec_scope "scope_remove"
#define set_scope_remove "remove"
#define set_scope_to_long "to_long"


procedure get_active_weapon_pid(variable attacker) begin
  variable weapon_pid;
  if attacker == dude_obj then begin
    if active_hand == 0 then begin
      weapon_pid := obj_pid(critter_inven_obj(attacker, INVEN_TYPE_LEFT_HAND));
    end else begin
      weapon_pid := obj_pid(critter_inven_obj(attacker, INVEN_TYPE_RIGHT_HAND));
    end
  end else begin
    weapon_pid := obj_pid(critter_inven_obj(attacker, INVEN_TYPE_LEFT_HAND));
  end
  return weapon_pid;
end

procedure get_active_ammo_pid(variable attacker) begin
  variable ammo_pid;
  if attacker == dude_obj then begin
    if active_hand == 0 then begin
      ammo_pid := get_weapon_ammo_pid(critter_inven_obj(attacker, INVEN_TYPE_LEFT_HAND));
    end else begin
      ammo_pid := get_weapon_ammo_pid(critter_inven_obj(attacker, INVEN_TYPE_LEFT_HAND));
    end
  end else begin
    ammo_pid := get_weapon_ammo_pid(critter_inven_obj(attacker, INVEN_TYPE_LEFT_HAND));
  end
  return ammo_pid;
end

procedure load_comsep_ini_setting(variable file, variable section, variable setting) begin
  variable str, ar;
  str := get_ini_string(file + "|" + section + "|" + setting);
  ar := string_split(str, ",");
  return ar;
end
