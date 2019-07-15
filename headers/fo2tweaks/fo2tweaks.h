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
#define in_dialog (get_game_mode bwand DIALOG)

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
  return [who_best, skill_level];
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

procedure light_level_abs_to_pct(variable abs_level := -1) begin
  variable pct_level_map;
  variable pct_level;
  pct_level_map := {
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
  if abs_level == -1 then pct_level := pct_level_map[get_light_level];
  else pct_level := pct_level_map[abs_level];
  return pct_level;
end

procedure light_level_pct_to_abs(variable pct_level) begin
  variable abs_level_map;
  variable abs_level;
  abs_level_map := {
    0: 16384,
    1: 16629,
    2: 16875,
    3: 17121,
    4: 17367,
    5: 17612,
    6: 17858,
    7: 18104,
    8: 18350,
    9: 18595,
    10: 18841,
    11: 19087,
    12: 19333,
    13: 19578,
    14: 19824,
    15: 20070,
    16: 20316,
    17: 20561,
    18: 20807,
    19: 21053,
    20: 21299,
    21: 21544,
    22: 21790,
    23: 22036,
    24: 22282,
    25: 22528,
    26: 22773,
    27: 23019,
    28: 23265,
    29: 23511,
    30: 23756,
    31: 24002,
    32: 24248,
    33: 24494,
    34: 24739,
    35: 24985,
    36: 25231,
    37: 25477,
    38: 25722,
    39: 25968,
    40: 26214,
    41: 26460,
    42: 26705,
    43: 26951,
    44: 27197,
    45: 27443,
    46: 27688,
    47: 27934,
    48: 28180,
    49: 28426,
    50: 40960,
    51: 53493,
    52: 53739,
    53: 53985,
    54: 54231,
    55: 54476,
    56: 54722,
    57: 54968,
    58: 55214,
    59: 55459,
    60: 55705,
    61: 55951,
    62: 56197,
    63: 56442,
    64: 56688,
    65: 56934,
    66: 57180,
    67: 57425,
    68: 57671,
    69: 57917,
    70: 58163,
    71: 58408,
    72: 58654,
    73: 58900,
    74: 59146,
    75: 59392,
    76: 59637,
    77: 59883,
    78: 60129,
    79: 60375,
    80: 60620,
    81: 60866,
    82: 61112,
    83: 61358,
    84: 61603,
    85: 61849,
    86: 62095,
    87: 62341,
    88: 62586,
    89: 62832,
    90: 63078,
    91: 63324,
    92: 63569,
    93: 63815,
    94: 64061,
    95: 64307,
    96: 64552,
    97: 64798,
    98: 65044,
    99: 65290,
    100: 65536
  };
  abs_level := abs_level_map[pct_level];
  return abs_level;
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
  armor := critter_inven_obj(obj, INVEN_TYPE_WORN);
  if not armor or not is_armor(armor) then return false;
  return armor;
end

procedure f2rp_pid_maxstage begin
  variable rp_map;
  rp_map := {
    PID_SULIK: 6, //Sulik
    PID_VIC: 6, //Vic
    PID_JOHN_MACRAE: 4, //Cassidy
    PID_LENNY: 3, //Lenny
    PID_MARCUS: 5, //Marcus
    PID_MYRON: 4, //Myron
    PID_ROBOBRAIN: 5, //Brainbot
    PID_CYBERDOG: 4, //Robodog
    PID_GORIS: 6, //Goris
    PID_K9: 4, //K-9
    PID_DOGMEAT: 6, //Dogmeat
    PID_CAT_JULES: 5, //Cat Jules
    PID_KITSUNE: 5, //Kitsune
    PID_DEX: 5, //Dex
    PID_MIRIA: 0, //Miria
    PID_DAVIN: 0 //Davin
  };
  return rp_map;
end

//warning: values cannot be 0, or will be skipped!
procedure get_ini_section_ints(variable file, variable section) begin
  variable ar, ar2 := temp_array_map, k, v;
  ar := get_ini_section(file, section);
  foreach k: v in ar begin
    ndebug(k + " " + v);
    ar2[atoi(k)] := atoi(v);
  end
  foreach k: v in ar2 begin
    ndebug(k + " " + v);
  end
  return ar2;
end

procedure use_obj_on_obj_force(variable who, variable item, variable target) begin
  set_self(who);
  set_self(who);
  use_obj_on_obj(item, target);
  set_self(0);
end
