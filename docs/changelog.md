## Changelog

* Version 12:
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

* Version 11.2:
  - More robust damage mod: make sure correct `ddraw.ini` settings are correct and ammo modifiers are not reset by other mods.
  - If fog of war is enabled, don't display HP for critters in the fog.
  - Minor optimizations.

* Version 11.1:
  - Fixed knockback limit and no dropping items on death not working due to missing scripts.
  - Fixed quicksave/quickload shortcuts getting stuck.

* Version 11:
  - Fixed being able to walk through watched doors when autodoors is disabled.
  - Fixed attacker self-damage calculation in damage mod.
  - Fixed being unable to use 'j' key when naming savegames.
  - Fixed auto reload for solar scorcher.
  - Fixed unlimited party setting not working for Dogmeat.
  - Re-added party run speed component.
  - Added Nirran's tweak for avoiding items being dropped on death.
  - Allowed to limit knockback instead of disabling it completely.
  - Re-added translations.
  - Fixed savegame corruption.

* Version 10:
  - Remapped some keys that were conflicting with [Party Orders](https://github.com/BGforgeNet/Fallout2_Party_Orders).
  - Replaced free Night Vision with minimal light level.
  - Ammobox will only show up for guns with ammo.
  - Restored general speedup component.
  - Fixed bug with Robobrain still checking party limit.
  - Packed into .dat.

* Version 9.4:
  - Fixed bug with combat difficulty multiplier being applied to player damage.
  - Added an option to decouple AI difficulty from damage difficulty.
  - Fixed a number of issues related to perks (only dude is allowed to have them) in damage mod and healing revision.
  - Remapped G to center on dude.

* Version 9.3:
  - Fixed living anatomy granted when healing revision is disabled.

* Version 9.2:
  - Fixed a mistake in critical level calculation.

* Version 9.1:
  - Fixed incorrect damage calculation on critical.

* Version 9:
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
* Version 8:
  - Added "Map hotkey" component
  - Re-enabled Molotov cocktail component
  - Fixed installation when fallout.cfg is missing
  - Fixed missing speedup settings when installed on old sfall version
* Version 7.1:
  - Disabled Molotov cocktail temporarily, until sfall 4.0 is out
* Version 7:
  - fixed Molotov cocktail not exploding
  - upgraded sfall to 3.8.3
* Version 6:
  - added "Disable Kaga" component
  - added "Disable Knockback" component
  - upgraded sfall to 3.7.4
  - various under-the-hood changes for stability and reliability
  - added combat speed increase to "general speedup" component
  - added Russian translation for installation routine
  - fixed Miria shotgun wedding/rape getting stuck
  - don't require starting new game for "unlimited carry weight"
* Version 5:
   - added unrestricted party AI component
   - expanded component "run speed" to include party
   - added component "stretch plotline"
   - added component "oxygen tank protects from radon"
   - enabled speed options in HRP as well
   - specified licence
   - added "no scope penalties" component
   - fixed uninstallation procedure to ensure there are no leftovers
   - ensured that proto files get read-only attribute
   - fixed installation on non-RP environments
   - removed binary files from original game, instead implement a routine to extract them at install time
   - moved level 5 and carry weight to game's beginning
* Version 4:
   - allowed carry weight of 9999
   - added "general speedup" component
   - updated sfall to version 3.7b
* Version 3:
   - fixed bug when enemies didn't receive same grenade CtH boost
   - fixed bug with grenade CtH when Sfall wasn't installed previously
* Version 2: added "no burst" component.
* Version 1: initial release.
