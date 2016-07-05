# FO2tweaks

This is a collection of convenience tweaks, common sense changes, and cheats for Fallout 2.

- [__Download__](https://github.com/burner1024/fo2tweaks/releases/latest)
- [Components](#components) (__*__ means that starting a new game is required)
  - [Inventory](#inventory)
    - [Unlimited carry weight](#unlimited-carry-weight)__*__
    - [Unlimited trunk](#unlimited-trunk)__*__
    - [Inventory filter](#inventory-filter)
  - [Party](#party)
    - [Unlimited party](#unlimited-party)
    - [Companions never use burst fire](#companions-never-use-burst-fire)
    - [Unrestricted party combat AI](#unrestricted-party-combat-ai)
  - [Speed](#speed)
    - [Increase run speed](#increase-run-speed) (both dude and party)
    - [General game speedup](#general-game-speedup)
  - [Miscellaneous](#miscellaneous)
    - [Molotov cocktail: fire damage](#molotov-cocktail-fire-damage)
    - [Grenades ignore armor class](#grenades-ignore-armor-class)
    - [Level 5 after temple of trials](#level-5-after-temple-of-trials)__*__
    - [Silence "fake reload" animation](#silence-fake-reload-animation)
    - [Stretch game plotline](#stretch-game-plotline)
    - [Oxygen tank protects from radon in Broken Hills mine](#oxygen-tank-protects-from-radon-in-broken-hills-mine)
    - [No close range penalty for scoped weapons](#no-close-range-penalty-for-scoped-weapons)
- [Special notes / compatibility](#special-notes--compatibility)
- [Installation](#installation)
- [Unistallation](#uninstallation)
- [Update](#update)
- [Troubleshooting](#troubleshooting)
- [Reporting issues](#reporting-issues)
- [Author](#author)
- [Licence](#licence)
- [Used software](#used-software)
- [Changelog](#changelog)

## Components

### Inventory

#### Unlimited carry weight
AKA inventory pain killer, part 1. Let the Chosen one carry up to 9999, regardless of strength.

#### Unlimited trunk
Inventory pain killer, part 2. Never worry about trunk filling up.

#### Inventory filter
Inventory pain killer, part 3. This is the ultimate inventory mod which allows you to *filter* your stuff. The actual author is [Mr.Сталин](http://www.nuclear-city.com/index.php/topic/512-плагин-filter-inventory-для-fallout2-и-модов/page-1). This component requires Sfall version at least 3.5. If Sfall is not found or is too old, a newer version will be installed automatically.

__Tips:__
- Press CTRL to activate the second set of buttons
- Use middle mouse click on weapon/ammo buttons to see both item types
- You can't use bags (which aren't in original Fallout 2 anyway, but possibly may be added by 3rd party mods)

__Sample:__

![Sample](fo2tweaks/components/inventory_filter/sample.gif)

### Party

#### Unlimited party
This component removes charisma checks upon NPC joining the party. It does not remove other checks (karma, etc). For example, Goris may still decline to join if you're a childkiller.

The following companions are affected:
- Cassidy
- Cat Jules
- Davin
- Dex
- Dogmeat
- Goris
- Kitsune
- K-9
- Lenny
- Marcus
- Miria
- Myron
- Robodog
- Skynet
- Sulik
- Vic

#### Companions never use burst fire
Give any weapon to your companions, and never be burst in the back. (Well, unless you give them a machine gun which only has burst mode).

#### Unrestricted party combat AI
Party management in combat is bad enough. But to make it worse, some NPC have various combat behavior settings unavailable to them. This components removes all such restrictions. Now you can order Myron to go berserk, or Marcus to be a coward, or any custom combination.

### Speed
#### Increase run speed
##### Armor doesn't reduce dude run speed
In the original game, running becomes slower as armor gets heavier. This component disables that behaviour, so that run speed is constant and fast.
##### Party NPC can run as well as dude
Are you tired of Marcus lagging behind? What about Skynet? Then this component is for you. All companions will have their run speed increased. Those that don't have run animations will have them created (sped up walking one).
##### Both of the above options
Like it says, speed up both the dude and the companions.

#### General game speedup
It's a convenience component. It preconfigures some Sfall and HRP settings for faster gameplay. You can achieve the same by performing manual Sfall and HRP configuration.

Specifically, it does the following:
- Game itself runs at 115% of the original speed
- Opening movies are skipped
- Combat, dialog and pipboy sleep panel animations are instant
- Empty weapons are stacked regardless of the ammo
- Weapon reload dialog with number of ammo boxes is skipped
- Weapon switch is instant (no animation)
- No splash screen is displayed (with HRP)
- Fade in/out is instant (with HRP)

### Miscellaneous
#### Molotov cocktail: fire damage
Let Molotov cocktail do fire damage instead of explosive (and optionally, enable "burning death" animation)

#### Grenades ignore armor class
Grenades are actually thrown to target's feet, not "through" armor. Hitting a person in power armor should not be any harder than one in leather armor. Thus, this component removes AC penalty from grenades' CtH.

It also affects explosive (but not armor piercing) rockets from rocket launcher and grenade launchers from [EcCo mod](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/).

#### Level 5 after temple of trials
Nets the Chosen 9500 xp right at the beginning of the game, almost leveling him to 5. (The reason for "almost" is that the interface is limited to 99 free skill points max, so a Skilled character will lose many points if gone directly to level 5)

#### Silence fake reload animation
Silence really annoying SMG/rifle "reload" sound which the dude does when he's idle (which is every few seconds). The animation itself still plays.

#### Stretch game plotline
In terms of roleplay, there's not much sense to visit the cities of the Big Circle: Broken Hills, Redding, New Reno, etc. In Vault City computer, you learn about Vault 15, in Vault 15 - about Vault 13, get the GECK, and it's pretty much non-stop express from there.
This component removes bits of information here and there, so that there are less shortcut paths:
- Vault City computer **will not** reveal Vault 15 location (but Tandi will - if you ask her)
- Vault 15 computer **will not** reveal Vault 13 location
- Lou (owner of Malamute salon in Redding) **will not** reveal San Francisco location
- Hakunin **will not** reveal Navarro location

#### Oxygen tank protects from radon in Broken Hills mine
Any character having the tank in his inventory won't be damaged by poison gas.

#### No close range penalty for scoped weapons
You aren't forced to use the scope in close range, are you? Affects only one weapon currently: Scoped Hunting Rifle.

## Special notes / compatibility
- **It will ONLY work if you have killap's patch** or restoration pack installed. You can get those at http://www.killap.net.
- It should be **compatible with any other mod** provided that "fo2tweaks" is installed **last**. It patches files instead of overwriting them.

## Reporting issues
The mod is tested on Windows XP x86. If you have any issues, reach me on [github](https://github.com/burner1024/fo2tweaks/issues).

## Installation
- Download __fo2tweaks.zip__ from the [latest release page](https://github.com/burner1024/fo2tweaks/releases/latest)
- Unzip the archive into the game directory
- Launch fo2tweaks.bat, answer the questions

## Uninstallation
- Launch fo2tweaks.bat, answer the questions

## Update
- If you're updating from a previous fo2tweaks version, uninstall it full, delete fo2tweaks dir and fo2tweaks.bat, then install new version normally

## Troubleshooting
If installation gets seemingly stuck (more than a minute without any progress), try disabling your antivirus for a moment. In particular, Avast is known to raise false positives.

## Author
- burner1024 @ github

## Licence
- The mod itself is [CC0 v1.0](https://creativecommons.org/publicdomain/zero/1.0/)
- Used software have their own licences, refer to the corresponding resources for those.

## Used software
* [SSLC compiler/decompiler](http://www.nma-fallout.com/threads/improved-scripting-tools-ssl-and-script-editor.203003/)
* [Gema](http://gema.sourceforge.net)
* [Weidu](http://weidu.org/~thebigg/)
* [Sfall](https://github.com/phobos2077/sfall)
* [Dat2](https://github.com/falltergeist/datfile)
* [Zlib](http://www.zlib.net)

## Changelog
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
