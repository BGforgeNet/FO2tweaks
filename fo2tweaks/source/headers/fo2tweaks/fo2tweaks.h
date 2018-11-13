#include "..\define.h"
#include "..\sfall\sfall.h"
#include "..\sfall\lib.arrays.h"
#include "..\sfall\lib.strings.h"
#include "..\sfall\define_extra.h"
#include "tile.h"
#include "mouse.h"

#define NAME "fo2tweaks"
#define fo2tweaks_ini "fo2tweaks.ini"
#define fo2tweaks_setting(section, setting) get_ini_setting(fo2tweaks_ini + "|" + section + "|" + setting)
#define fo2tweaks_string(section, setting) get_ini_string(fo2tweaks_ini + "|" + section + "|" + setting)
#define ndebug(message) debug_msg(NAME + ": " + message + "\n")

#define sec_main "main"

#define is_weapon(obj) (obj_item_subtype(obj) == item_type_weapon)
#define is_weapon_pid(pid)	(proto_data(pid, it_type) == item_type_weapon)
#define is_ammo(obj)	 (obj_item_subtype(obj) == item_type_ammo)
#define is_ammo_pid(pid)	(proto_data(pid, it_type) == item_type_ammo)
#define is_armor(obj)	 (obj_item_subtype(obj) == item_type_armor)
#define is_armod_pid(pid)	(proto_data(pid, it_type) == item_type_armor)
#define is_critter(obj)   (obj_type(obj) == OBJ_TYPE_CRITTER)
#define is_scenery(obj)   (obj_type(obj) == OBJ_TYPE_SCENERY)

#define in_combat (get_game_mode bwand COMBAT)
#define in_inventory (get_game_mode bwand INVENTORY)
#define in_dialig (get_game_mode bwand DIALOG)

#define is_dead(critter_obj) (critter_state(critter_obj) == CRITTER_IS_DEAD)


procedure get_active_weapon(variable attacker) begin
  variable item;
  if attacker == dude_obj and active_hand == 0 then begin
    item := critter_inven_obj2(attacker, INVEN_TYPE_LEFT_HAND);
  end else begin
    item := critter_inven_obj2(attacker, INVEN_TYPE_RIGHT_HAND);
  end
  if item and is_weapon(item) then return item;
  return false;
end

procedure get_dude_inactive_weapon begin
  variable item;
  if active_hand == 0 then begin
    item := critter_inven_obj2(dude_obj, INVEN_TYPE_RIGHT_HAND);
  end else begin
    item := critter_inven_obj2(dude_obj, INVEN_TYPE_LEFT_HAND);
  end
  if item and is_weapon(item) then return item;
  return false;
end

procedure get_active_weapon_pid(variable attacker) begin
  variable weapon, weapon_pid;
  weapon := get_active_weapon(attacker);
  if weapon then return obj_pid(weapon);
  return false;
end

procedure get_active_ammo_pid(variable attacker) begin
  variable weapon, ammo_pid;

  weapon := get_active_weapon(attacker);
  if not weapon then return false;

  ammo_pid := get_weapon_ammo_pid(weapon);
  if ammo_pid == -1 then return false;

  return ammo_pid;
end

procedure get_dude_inactive_ammo_pid begin
  variable weapon, ammo_pid;

  weapon := get_dude_inactive_weapon;
  if not weapon then return false;

  ammo_pid := get_weapon_ammo_pid(weapon);
  if ammo_pid == -1 then return false;

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
    ndebug(obj_name(who) + " has skill " + skill + " level of " + who_skill);
    if who_skill > skill_level then begin
      skill_level := who_skill;
      who_best := who;
    end
  end
  ndebug(obj_name(who_best) + " has best skill " + skill_name + " of " + skill_level);
  return skill_level;
end

//greatest common divisor
procedure gcd(variable x, variable y) begin
  variable x_;
  while y != 0 do begin
    x_ := y;
    y := x % y;
    x := x_;
  end
  return x;
end

procedure mode_ended(variable mode_to_check, variable old_mode, variable new_mode) begin
  if (old_mode bwand mode_to_check) > 0 and (new_mode bwand mode_to_check) == 0 then return true;
  return false;
end
procedure mode_started(variable mode_to_check, variable old_mode, variable new_mode) begin
  if (old_mode bwand mode_to_check) == 0 and (new_mode bwand mode_to_check) > 0 then return true;
  return false;
end

procedure f2_party_member_pids begin
  variable pids;
  pids := [
    PID_VIC,
    PID_SULIK,
    PID_JOHN_MACRAE,
    PID_LENNY,
    PID_MYRON,
    PID_MARCUS,
    PID_DAVIN,
    PID_MIRIA,
    PID_ROBOBRAIN,
    PID_ROBOBRAIN_CHIMP,
    PID_ROBOBRAIN_HUMAN,
    PID_ROBOBRAIN_ABNORMAL,
    PID_GORIS,
    PID_CYBERDOG,
    PID_K9,
    PID_DOGMEAT
  ];
  return pids;
end

procedure rp_party_member_pids begin
  variable pids;
  pids := [PID_KITSUNE, PID_DEX, PID_CAT_JULES];
  return pids;
end

procedure f2rp_party_member_pids begin
  variable pids, rp_pids;
  pids := f2_party_member_pids;
  rp_pids := rp_party_member_pids;
  pids := array_append(pids, rp_pids);
  return pids;
end

procedure f2_ammo_pids begin
  variable pids;
  pids := [
    PID_EXPLOSIVE_ROCKET,
    PID_10MM_JHP,
  	PID_10MM_AP,
  	PID_44_MAGNUM_JHP,
  	PID_FLAMETHROWER_FUEL,
  	PID_14MM_AP,
  	PID_223_FMJ,
  	PID_5MM_JHP,
  	PID_5MM_AP,
  	PID_ROCKET_AP,
  	PID_SMALL_ENERGY_CELL,
  	PID_MICRO_FUSION_CELL,
  	PID_SHOTGUN_SHELLS,
  	PID_44_FMJ_MAGNUM,
  	PID_9MM_BALL,
  	PID_BBS,
  	PID_ROBO_ROCKET_AMMO,
  	PID_45_CALIBER_AMMO,
  	PID_2MM_EC_AMMO,
  	PID_4_7MM_CASELESS,
  	PID_9MM_AMMO,
  	PID_HN_NEEDLER_CARTRIDGE,
  	PID_HN_AP_NEEDLER_CARTRIDGE,
  	PID_7_62MM_AMMO,
  	PID_FLAMETHROWER_FUEL_MK_II
  ];
  return pids;
end

procedure get_real_light_level begin
  variable real_level_map;
  variable real_level;
  real_level_map := {
    16384: 0,
    16629: 1,
    16875: 2,
    17121: 3,
    17367: 4,
    17612: 5,
    17858: 6,
    18104: 7,
    18350: 8,
    18595: 9,
    18841: 10,
    19087: 11,
    19333: 12,
    19578: 13,
    19824: 14,
    20070: 15,
    20316: 16,
    20561: 17,
    20807: 18,
    21053: 19,
    21299: 20,
    21544: 21,
    21790: 22,
    22036: 23,
    22282: 24,
    22528: 25,
    22773: 26,
    23019: 27,
    23265: 28,
    23511: 29,
    23756: 30,
    24002: 31,
    24248: 32,
    24494: 33,
    24739: 34,
    24985: 35,
    25231: 36,
    25477: 37,
    25722: 38,
    25968: 39,
    26214: 40,
    26460: 41,
    26705: 42,
    26951: 43,
    27197: 44,
    27443: 45,
    27688: 46,
    27934: 47,
    28180: 48,
    28426: 49,
    40960: 50,
    53493: 51,
    53739: 52,
    53985: 53,
    54231: 54,
    54476: 55,
    54722: 56,
    54968: 57,
    55214: 58,
    55459: 59,
    55705: 60,
    55951: 61,
    56197: 62,
    56442: 63,
    56688: 64,
    56934: 65,
    57180: 66,
    57425: 67,
    57671: 68,
    57917: 69,
    58163: 70,
    58408: 71,
    58654: 72,
    58900: 73,
    59146: 74,
    59392: 75,
    59637: 76,
    59883: 77,
    60129: 78,
    60375: 79,
    60620: 80,
    60866: 81,
    61112: 82,
    61358: 83,
    61603: 84,
    61849: 85,
    62095: 86,
    62341: 87,
    62586: 88,
    62832: 89,
    63078: 90,
    63324: 91,
    63569: 92,
    63815: 93,
    64061: 94,
    64307: 95,
    64552: 96,
    64798: 97,
    65044: 98,
    65290: 99,
    65536: 100
  };
  real_level := real_level_map[get_light_level];
  return real_level;
end

procedure is_gun(variable obj) begin
  variable anim_code;
  variable ranged_codes := [
    WPN_ANIM_PISTOL,
    WPN_ANIM_SMG,
    WPN_ANIM_RIFLE,
    WPN_ANIM_BIG_GUN,
    WPN_ANIM_MINIGUN,
    WPN_ANIM_ROCKET_LAUNCHER
  ];
  if not is_weapon(obj) then return false;
  anim_code := get_proto_data(obj_pid(obj), PROTO_WP_ANIM);
  if is_in_array(anim_code, ranged_codes) then return true;
  return false;
end

procedure get_armor(variable obj) begin
  variable armor;
  if not is_critter(obj) then return false;
  armor := critter_inven_obj(dude_obj, INVEN_TYPE_WORN);
  if not armor or not is_armor(armor) then return false;
  return armor;
end
