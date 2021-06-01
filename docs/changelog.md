## Changelog

### Version 12.5
- Fixed level up match not working for Skynet.
- Pulse grenades can also be thrown onto empty hexes.
- Healing revision no longer allows to heal corpses (!).
- Unlimited trunk now support EtTu's moto.
- Updated sfall to 4.3.

### Version 12.4
- Fixed max knockback being [always limited to 0](https://forums.bgforge.net/viewtopic.php?f=26&p=888) regardless of actual setting value.

### Version 12.3
- Fixed ammobox [not updating](https://forums.bgforge.net/viewtopic.php?f=26&p=861) when using red button to switch hands.
- Updated sfall to 4.2.8.1.

### Version 12.2
- Disabled automatic cursor by default.
- Added a note about enabling `UseFileSystemOverride` in `ddraw.ini` for Run Speed component.

### Version 12.1
- Fixed Healing Revision not accounting for items bonuses for First Aid.
- Healing Revision now also takes into account Healer perk, adding 2 HP per heal per perk level.
- Updated sfall to 4.2.5.1.

### Version 12
- Minimal light level is no longer enabled by default.
- Fixed HP being displayed for invisible critters.
- Speed up component makes HP counters instant, really.
- More robust check for worldmap key in Modoc shitter.
- Added auto cursor component.
- Grenades CtH now ignores armor class from all sources, not just armor.
- Added area attack for grenades.
- Added support for Sonora grenades and traps to highlighting.
- Town map key now works consistently on world map as well.
- Hotkeys in ini are now in human readable format.

### Version 11.2
- More robust damage mod: make sure correct `ddraw.ini` settings are correct and ammo modifiers are not reset by other mods.
- If fog of war is enabled, don't display HP for critters in the fog.
- Minor optimizations.

### Version 11.1
- Fixed knockback limit and no dropping items on death not working due to missing scripts.
- Fixed quicksave/quickload shortcuts getting stuck.

### Version 11
- Fixed being able to walk through watched doors when autodoors is disabled.
- Fixed attacker self-damage calculation in damage mod.
- Fixed being unable to use 'j' key when naming savegames.
- Fixed auto reload for solar scorcher.
- Fixed unlimited party setting not working for Dogmeat.
- Re-added party run speed component.
- Added Nirran's tweak for avoiding items being dropped on death.
- Allowed to limit knockback instead of disabling it completely.
- Re-added translations.
- Fixed savegame corruption under certain condition.

### Version 10
- Remapped some keys that were conflicting with [Party Orders](https://github.com/BGforgeNet/Fallout2_Party_Orders).
- Replaced free Night Vision with minimal light level.
- Ammobox will only show up for guns with ammo.
- Restored general speedup component.
- Fixed bug with Robobrain still checking party limit.
- Packed into `.dat`.

### Version 9.4
- Fixed bug with combat difficulty multiplier being applied to player damage.
- Added an option to decouple AI difficulty from damage difficulty.
- Fixed a number of issues related to perks (only dude is allowed to have them) in damage mod and healing revision.
- Remapped G to center on dude.

### Version 9.3
- Fixed living anatomy granted when healing revision is disabled.

### Version 9.2
- Fixed a mistake in damage mod's critical level calculation.

### Version 9.1
- Fixed incorrect damage calculation on critical.

### Version 9
- Massive overhaul with compatibility in mind. Now featuring only fully pluggable components.
- Removed inventory filter.
- Removed burst control (merged into [Party Orders](https://github.com/BGforgeNet/Fallout2_Party_Orders)).
- Removed unrestricted party AI.
- Removed general speedup and run speed.
- Removed silence fake reload.
- Removed stretch game plot.
- Removed oxygen tank radon protection.
- Removed Kaga component.
- Added ammobox.
- Added autodoors.
- Added auto reload.
- Added damage mod.
- Added healing overhaul.
- Added expanded highlighting.
- Added HP over head.
- Added keymap.
- Added light level component.
- Added town map hotkey.
- Added workaround for party killing Modoc brahmin.
- Added party level matching.
- Improved unlimited party.

### Version 8
- Added "Map hotkey" component.
- Re-enabled Molotov cocktail component.
- Fixed installation when `fallout.cfg` is missing.
- Fixed missing speedup settings when installed on old sfall version.

### Version 7.1
- Disabled Molotov cocktail temporarily, until sfall 4.0 is out.

### Version 7
- Fixed Molotov cocktail not exploding.
- Upgraded sfall to 3.8.3.

### Version 6
- Added "Disable Kaga" component.
- Added "Disable Knockback" component.
- Upgraded sfall to 3.7.4.
- Various under-the-hood changes for stability and reliability.
- Added combat speed increase to "general speedup" component.
- Added Russian translation for installation routine.
- Fixed Miria shotgun wedding/rape getting stuck.
- Don't require starting new game for "unlimited carry weight".

### Version 5
- Added unrestricted party AI component.
- Expanded component "run speed" to include party.
- Added component "stretch plotline".
- Added component "oxygen tank protects from radon".
- Enabled speed options in HRP as well.
- Specified license.
- Added "no scope penalties" component.
- Fixed uninstallation procedure to ensure there are no leftovers.
- Ensured that proto files get read-only attribute.
- Fixed installation on non-RP environments.
- Removed binary files from original game, instead implement a routine to extract them at install time.
- Moved level 5 and carry weight to game's beginning.

### Version 4
- Allowed carry weight of 9999.
- Added "general speedup" component.
- Updated sfall to version 3.7b.

### Version 3
- Fixed bug when enemies didn't receive same grenade CtH boost.
- Fixed bug with grenade CtH when Sfall wasn't installed previously.

### Version 2
Added "no burst" component.

### Version 1
Iinitial release.
