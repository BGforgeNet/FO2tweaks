Var ammobox
Var auto_cursor
Var auto_reload
Var autodoors
Var carry_weight
Var damage_mod
Var gigolo_limit
Var healing_revision
Var highlighting
Var hp_over_head
Var improved_grenades
Var keymap
Var level5
Var max_knockback
Var min_light_level
Var modoc_brahmin
Var molotov_fire
Var no_drop_items_on_death
Var no_scope_penalty
Var party_level_match
Var run_speed
Var speedup
Var townmap_key
Var trunk_space
Var unlimited_party
Var worldmap_key

Var ammobox_state
Var auto_cursor_state
Var auto_reload_state
Var autodoors_state
Var carry_weight_state
Var damage_mod_state
Var gigolo_limit_state
Var healing_revision_state
Var highlighting_state
Var hp_over_head_state
Var improved_grenades_state
Var keymap_state
Var level5_state
Var max_knockback_state
Var min_light_level_state
Var modoc_brahmin_state
Var molotov_fire_state
Var no_drop_items_on_death_state
Var no_scope_penalty_state
Var party_level_match_state
Var run_speed_state
Var speedup_state
Var townmap_key_state
Var trunk_space_state
Var unlimited_party_state
Var worldmap_key_state

Function "inventoryPageConfig"

  !insertmacro MUI_HEADER_TEXT "Inventory Tweaks" "Please select the inventory tweaks that you want enabled."

	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  ${If} $advanced == 0
    Abort
  ${EndIf}

  ${NSD_CreateCheckBox} 20% 26u 60% 10u "(Virtually) unlimited carry weight"
  Pop $carry_weight

  ${If} $carry_weight_state == ${BST_CHECKED}
		${NSD_Check} $carry_weight
	${EndIf}

  ${NSD_CreateCheckBox} 20% 40u 60% 10u "Exploded, gooified, and vaporised enemies won't drop their inventory on the ground"
  Pop $no_drop_items_on_death

  ${If} $no_drop_items_on_death_state == ${BST_CHECKED}
		${NSD_Check} $no_drop_items_on_death
	${EndIf}

  ${NSD_CreateCheckBox} 20% 54u 60% 10u "Infinite car trunk space"
  Pop $trunk_space

  ${If} $trunk_space_state == ${BST_CHECKED}
		${NSD_Check} $trunk_space
	${EndIf}

  nsDialogs::Show

FunctionEnd

Function "inventoryPageLeave"

  ${NSD_GetState} $carry_weight $carry_weight_state
  ${NSD_GetState} $no_drop_items_on_death $no_drop_items_on_death_state
  ${NSD_GetState} $trunk_space $trunk_space_state

FunctionEnd

Function "partyPageConfig"

  !insertmacro MUI_HEADER_TEXT "Party Tweaks" "Please select the party tweaks that you want enabled."

	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  ${If} $advanced == 0
    Abort
  ${EndIf}

  ${NSD_CreateCheckBox} 20% 26u 40% 10u "Party NPC level matches player level more closely"
  Pop $party_level_match

  ${If} $party_level_match_state == ${BST_CHECKED}
		${NSD_Check} $party_level_match
  ${EndIf}

  ${NSD_CreateCheckBox} 20% 40u 40% 10u "Disable charisma check when joining party (unlimited party members)"
  Pop $unlimited_party

  ${If} $unlimited_party_state == ${BST_CHECKED}
		${NSD_Check} $unlimited_party
	${EndIf}

	nsDialogs::Show

FunctionEnd

Function "partyPageLeave"

	${NSD_GetState} $party_level_match $party_level_match_state
  ${NSD_GetState} $unlimited_party $unlimited_party_state

FunctionEnd

Function "speedPageConfig"

  !insertmacro MUI_HEADER_TEXT "Speed Tweaks" "Please select the speed tweaks that you want enabled."

	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  ${If} $advanced == 0
    Abort
  ${EndIf}

  ${NSD_CreateCheckBox} 20% 26u 40% 10u "Enable speedup convenience tweaks. See manual for more info"
  Pop $speedup

  ${If} $speedup_state == ${BST_CHECKED}
		${NSD_Check} $speedup
	${EndIf}

  ${NSD_CreateCheckBox} 20% 40u 40% 10u "Increase party run speed in heavy armour and slow party member speed generally."
  Pop $run_speed

  ${If} $run_speed_state == ${BST_CHECKED}
		${NSD_Check} $run_speed
	${EndIf}

	nsDialogs::Show

FunctionEnd

Function "speedPageLeave"

	${NSD_GetState} $run_speed $run_speed_state
  ${NSD_GetState} $speedup $speedup_state

FunctionEnd

Function "combatPageConfig"

  !insertmacro MUI_HEADER_TEXT "Combat Tweaks" "Please select the combat tweaks that you want enabled."

	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  ${If} $advanced == 0
    Abort
  ${EndIf}

  ${NSD_CreateLabel} 20% 26u 40% 10u "Maximum Hexes for knockback:"
  Pop $0

  ${NSD_CreateNumber} 45% 24u 20% 12u "$max_knockback_state"
  Pop $max_knockback

  ${NSD_CreateCheckBox} 20% 56u 45% 10u "Display current ammunition type in an infobox while in combat"
  Pop $ammobox

  ${If} $ammobox_state == ${BST_CHECKED}
		${NSD_Check} $ammobox
	${EndIf}

  ${NSD_CreateCheckBox} 20% 74u 40% 10u "Automatically change cursor to attack when hovering over an enemy in combat"
  Pop $auto_cursor

  ${If} $auto_cursor_state == ${BST_CHECKED}
		${NSD_Check} $auto_cursor
	${EndIf}

  ${NSD_CreateCheckBox} 20% 90u 40% 10u "AP/JHP Damage Mod. Set DamageFormula to 0 in ddraw.ini if this is enabled"
  Pop $damage_mod

  ${If} $damage_mod_state == ${BST_CHECKED}
		${NSD_Check} $damage_mod
	${EndIf}

  ${NSD_CreateCheckBox} 20% 106u 40% 10u "Display HP over party and enemy heads during combat"
  Pop $hp_over_head

  ${If} $hp_over_head_state == ${BST_CHECKED}
		${NSD_Check} $hp_over_head
	${EndIf}

  ${NSD_CreateCheckBox} 20% 122u 40% 10u "Improved grenade handling"
  Pop $improved_grenades

  ${If} $improved_grenades_state == ${BST_CHECKED}
		${NSD_Check} $improved_grenades
	${EndIf}

  ${NSD_CreateCheckBox} 20% 40u 40% 10u "Molotov deals file damage"
  Pop $molotov_fire

  ${If} $molotov_fire_state == ${BST_CHECKED}
		${NSD_Check} $molotov_fire
	${EndIf}

  ${NSD_CreateCheckBox} 20% 138u 40% 10u "No penalty to hit at close range for scoped weapons"
  Pop $no_scope_penalty

  ${If} $no_scope_penalty_state == ${BST_CHECKED}
		${NSD_Check} $no_scope_penalty
	${EndIf}


	nsDialogs::Show

FunctionEnd

Function "combatPageLeave"

	${NSD_GetState} $ammobox $ammobox_state
	${NSD_GetState} $auto_cursor $auto_cursor_state
	${NSD_GetState} $damage_mod $damage_mod_state
	${NSD_GetState} $hp_over_head $hp_over_head_state
	${NSD_GetState} $improved_grenades $improved_grenades_state
  ${NSD_GetState} $molotov_fire $molotov_fire_state
  ${NSD_GetState} $no_scope_penalty $no_scope_penalty_state
  ${NSD_GetText} $max_knockback $max_knockback_state

FunctionEnd

Function "utilityPageConfig"

  !insertmacro MUI_HEADER_TEXT "Utility Tweaks" "Please select the utility tweaks that you want enabled."

	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  ${If} $advanced == 0
    Abort
  ${EndIf}

  ${NSD_CreateLabel} 20% 26u 40% 10u "World Map hotkey:"
  Pop $0

  ${NSD_CreateText} 45% 24u 20% 12u "$worldmap_key_state"
  Pop $max_knockback

  ${NSD_CreateLabel} 20% 40u 40% 10u "Town Map hotkey:"
  Pop $0

  ${NSD_CreateText} 45% 38u 20% 12u "$townmap_key_state"
	Pop $townmap_key

  ${NSD_CreateCheckBox} 20% 54u 40% 10u "PC automatically reloads weapons in both hands after combat"
  Pop $auto_reload

  ${If} $auto_reload_state == ${BST_CHECKED}
		${NSD_Check} $auto_reload
	${EndIf}

  ${NSD_CreateCheckBox} 20% 70u 40% 10u "Automatically open unlocked doors when not in combat"
  Pop $autodoors

  ${If} $autodoors_state == ${BST_CHECKED}
		${NSD_Check} $autodoors
	${EndIf}

  ${NSD_CreateCheckBox} 20% 86u 40% 10u "Make PC level 5 after the Temple of Trials"
  Pop $level5

  ${If} $level5_state == ${BST_CHECKED}
		${NSD_Check} $level5
	${EndIf}

  ${NSD_CreateCheckBox} 20% 104u 40% 10u "Enable custom keybindings from 'mods/fo2tweaks.ini'"
  Pop $keymap

  ${If} $keymap_state == ${BST_CHECKED}
		${NSD_Check} $keymap
	${EndIf}

	nsDialogs::Show

FunctionEnd

Function "utilityPageLeave"

	${NSD_GetState} $auto_reload $auto_reload_state
	${NSD_GetState} $autodoors $autodoors_state
	${NSD_GetState} $keymap $keymap_state
	${NSD_GetState} $level5 $level5_state
  ${NSD_GetText} $townmap_key $townmap_key_state
  ${NSD_GetText} $worldmap_key $worldmap_key_state

FunctionEnd

Function "miscPageConfig"

  !insertmacro MUI_HEADER_TEXT "Miscellaneous Tweaks" "Please select the miscellaneous tweaks that you want enabled."

	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  ${If} $advanced == 0
    Abort
  ${EndIf}

  ${NSD_CreateCheckBox} 20% 26u 40% 10u "Expanded highlighting mod."
  Pop $highlighting

  ${If} $highlighting_state == ${BST_CHECKED}
		${NSD_Check} $highlighting
	${EndIf}

  ${NSD_CreateCheckBox} 20% 40u 40% 10u "Alternative healing implementation"
  Pop $healing_revision

  ${If} $healing_revision_state == ${BST_CHECKED}
		${NSD_Check} $healing_revision
	${EndIf}

  ${NSD_CreateNumber} 20% 54u 40% 10u "$min_light_level_state"
  Pop $min_light_level

  ${If} $min_light_level_state == ${BST_CHECKED}
		${NSD_Check} $min_light_level
	${EndIf}

  ${NSD_CreateCheckBox} 20% 70u 40% 10u "Modoc brahmin are on the PC's team"
  Pop $modoc_brahmin

  ${If} $modoc_brahmin_state == ${BST_CHECKED}
		${NSD_Check} $modoc_brahmin
	${EndIf}

	nsDialogs::Show

FunctionEnd

Function "miscPageLeave"

  ${NSD_GetText} $min_light_level $min_light_level_state
	${NSD_GetState} $highlighting $highlighting_state
  ${NSD_GetState} $healing_revision $healing_revision_state
  ${NSD_GetState} $modoc_brahmin $modoc_brahmin_state

FunctionEnd

Function "writeKeys"

  IfFileExists $TEMP\fo2tweaks.ini +2 0
  Delete $TEMP\fo2tweaks.ini
  CopyFiles "..\..\mods\fo2tweaks.ini" "$TEMP\fo2tweaks.ini"
  DeleteINISec "$TEMP\fo2tweaks.ini" "main"

  WriteINIStr "$TEMP\fo2tweaks.ini" "main" "gigolo_limit" "$gigolo_limit"
  WriteINIStr "$TEMP\fo2tweaks.ini" "main" "max_knockback" "$max_knockback"
  WriteINIStr "$TEMP\fo2tweaks.ini" "main" "townmap_key" "$townmap_key"
  WriteINIStr "$TEMP\fo2tweaks.ini" "main" "worldmap_key" "$worldmap_key"


  ${If} $ammobox == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "ammobox" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "ammobox" "0"
  ${EndIf}

  ${If} $auto_cursor == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "auto_cursor" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "auto_cursor" "0"
  ${EndIf}

  ${If} $auto_reload == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "auto_reload" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "auto_reload" "0"
  ${EndIf}

  ${If} $autodoors == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "autodoors" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "autodoors" "0"
  ${EndIf}

  ${If} $carry_weight == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "carry_weight" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "carry_weight" "0"
  ${EndIf}

  ${If} $damage_mod == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "damage_mod" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "damage_mod" "0"
  ${EndIf}

  ${If} $healing_revision == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "healing_revision" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "healing_revision" "0"
  ${EndIf}

  ${If} $highlighting == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "highlighting" "1"
    # Disable default sfall highlighting if enabled
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "highlighting" "0"
  ${EndIf}

  ${If} $hp_over_head == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "hp_over_head" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "hp_over_head" "0"
  ${EndIf}

  ${If} $improved_grenades == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "improved_grenades" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "improved_grenades" "0"
  ${EndIf}

  ${If} $keymap == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "keymap" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "keymap" "0"
  ${EndIf}

  ${If} $level5 == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "level5" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "level5" "0"
  ${EndIf}

  ${If} $min_light_level == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "min_light_level" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "min_light_level" "0"
  ${EndIf}

  ${If} $modoc_brahmin == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "modoc_brahmin" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "modoc_brahmin" "0"
  ${EndIf}

  ${If} $molotov_fire == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "molotov_fire" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "molotov_fire" "0"
  ${EndIf}

  ${If} $no_drop_items_on_death == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "no_drop_items_on_death" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "no_drop_items_on_death" "0"
  ${EndIf}

  ${If} $no_scope_penalty == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "worldmap_key" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "worldmap_key" "0"
  ${EndIf}

  ${If} $party_level_match == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "party_level_match" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "party_level_match" "0"
  ${EndIf}

  ${If} $run_speed == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "run_speed" "1"
    # Set UseFileSystemOverride=1 in ddraw.ini
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "run_speed" "0"
  ${EndIf}

  ${If} $speedup == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "speedup" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "speedup" "0"
  ${EndIf}

  ${If} $trunk_space == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "trunk_space" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "trunk_space" "0"
  ${EndIf}

  ${If} $unlimited_party == ${BST_CHECKED}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "unlimited_party" "1"
  ${Else}
    WriteINIStr "$TEMP\fo2tweaks.ini" "main" "unlimited_party" "0"
  ${EndIf}

FunctionEnd
