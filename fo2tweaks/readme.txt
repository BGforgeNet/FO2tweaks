## Fallout 2 tweaks mod

This mod provides several tweaks for Fallout 2.

- [__Download__](https://github.com/burner1024/fo2tweaks/releases/latest)
- [Components](#components) (__*__ means that starting a new game is required)
  - [Molotov cocktail: fire damage](#molotov-cocktail-fire-damage)
  - [Grenades ignore armor class](#grenades-ignore-armor-class)
  - [Level 5 after temple of trials](#level-5-after-temple-of-trials)__*__
  - [Max carry weight](#max-carry-weight)__*__
  - [Unlimited trunk](#unlimited-trunk)__*__
  - [Silence "fake reload" animation](#silence-fake-reload-animation)
  - [Armor doesn't reduce run speed](#armor-doesnt-reduce-run-speed)
  - [Inventory filter](#inventory-filter)
  - [Unlimited party](#unlimited-party)
  - [Companions never use burst fire](#companions-never-use-burst-fire)
  - [General game speedup](#general-game-speedup)
  - [Unrestricted party combat AI](#unrestricted-party-combat-ai)
- [Special notes / compatibility](#special-notes--compatibility)
- [Installation](#installation)
- [Troubleshooting](#troubleshooting)
- [Unistallation](#uninstallation)
- [Reporting issues](#reporting-issues)
- [Author](#author)
- [Licence](#licence)
- [Used software](#used-software)
- [Changelog](#changelog)

### Components

#### Molotov cocktail: fire damage
Let Molotov cocktail do fire damage instead of explosive (and optionally, enable "burning death" animation)

#### Grenades ignore armor class
Removes AC penalty from grenades, since they are actually thrown to target's feet, not "through" armor. This also affects explosive rockets from rocket launcher and grenade launchers from [EcCo mod](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/).

#### Level 5 after temple of trials
Nets the Chosen 10000 xp for completing the temple of trials

#### Max carry weight
AKA inventory pain killer, part 1. Let the Chosen carry up to 9999, regardless of strength. This takes effects after the temple of trials.

#### Unlimited trunk
Inventory pain killer, part 2. Never worry about trunk filling up.

#### Silence fake reload animation
Silence really annoying SMG/rifle "reload" sound which the dude does when he's idle (which is every few seconds). The animation itself still plays.

#### Increase run speed
##### Armor doesn't reduce dude run speed
In the original game, running becomes slower as armor gets heavier. This component disables that behaviour, so that run speed is constant and fast.
##### Party NPC can run as well as dude
Are you tired of your party lagging behind? Then this component is for you. All companions will have their run speed increased. Those that don't have run animations (Marcus, Skynet) will have them created (sped up walking one).
##### Both of the above options
Like it says, speed up both the dude and the companions.

#### Inventory filter
Inventory pain killer, part 3. This is the ultimate inventory mod which allows you to *filter* your stuff. The actual author is [Mr.Сталин](http://www.nuclear-city.com/index.php/topic/512-плагин-filter-inventory-для-fallout2-и-модов/page-1). This component requires Sfall version at least 3.5. If Sfall is not found or is too old, a newer version will be installed automatically.

__Tips:__
- Press CTRL to activate the second set of buttons
- Use middle mouse click on weapon/ammo buttons to see both item types
- You can't use bags (which aren't in original Fallout 2 anyway, but possibly may be added by 3rd party mods)

__Sample:__

![Sample](fo2tweaks/components/inventory_filter/sample.gif)

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

#### General game speedup
This component preconfigures some Sfall and HRP settings for faster gameplay. Specifically:
- Game itself runs at 115% of the original speed
- Opening movies are skipped
- Combat, dialog and pipboy sleep panel animations are instant
- Empty weapons are stacked regardless of the ammo
- Weapon reload dialog with number of ammo boxes is skipped
- Weapon switch is instant (no animation)
- No splash screen is displayed (with HRP)
- Fade in/out is instant (with HRP)

#### Stretch game plotline
In terms of roleplay, there's not much sense to visit the cities of the Big Circle: Broken Hills, Redding, New Reno, etc. In Vault City computer, you learn about Vault 15, in Vault 15 - about Vault 13, get the GECK, and it's pretty much non-stop express from there.
This component removes bits of information here and there, so that there are less shortcut paths:
- Vault City computer won't reveal Vault 15 location (but Tandi will - if you ask her)
- Vault 15 computer won't reveal Vault 13 location
- Lou (owner of Malamute salon in Redding) won't reveal San Francisco location
- Hakunin won't reveal Navarro location

#### Oxygen tank protects from radon in Broken Hills mine
Any character having the tank in his inventory won't be damaged by poison gas.

#### No close range penalty for scoped weapons
You aren't forced to use the scope in close range, are you? Affects only one weapon currently, Scoped Hunting Rifle.

#### Unrestricted party combat AI
Party management in combat is bad enough. But to make it worse, some NPC have various combat behavior settings unavailable to them. This components removes all such restrictions. Now you can order Myron to go berserk, or Marcus to be a coward, or any custom combination.

### Special notes / compatibility
- **It will ONLY work if you have killap's patch** or restoration pack installed. You can get those at http://www.killap.net.
- It should be **compatible with any other mod** provided that "fo2tweaks" is installed **last**. It patches files instead of overwriting them.

### Reporting issues
The mod is tested on Windows XP x86. If you have any issues, reach me on [github](https://github.com/burner1024/fo2tweaks/issues).

### Installation
- Download __fo2tweaks.zip__ from the [latest release page](https://github.com/burner1024/fo2tweaks/releases/latest)
- Unzip the archive into the game directory
- Launch fo2tweaks.bat, answer the questions

### Troubleshooting
If installation gets seemingly stuck (more than a minute without any progress), try disabling your antivirus for a moment. In particular, Avast is known to raise false positives.

### Uninstallation
- Launch fo2tweaks.bat, answer the questions

### Author
- burner1024 @ github

### Licence
- The mod itself is [CC0 v1.0](https://creativecommons.org/publicdomain/zero/1.0/)
- Used software have their own licences, refer to the corresponding resources for those.

### Used software
* [SSLC compiler/decompiler](http://www.nma-fallout.com/showthread.php?201526-Useful-Scripting-Libraries)
* [Gema](http://gema.sourceforge.net)
* [Weidu](http://weidu.org/~thebigg/)
* [Sfall](https://github.com/phobos2077/sfall)
* [Dat2](https://github.com/falltergeist/datfile)
* [Zlib](http://www.zlib.net)

### Changelog
* Version 5:
   - added unrestricted party AI component
   - expanded component "run speed" to include party
   - added component "stretch plotline"
   - added component "oxygen tank protects from radon"
   - enabled speed options in HRP as well
   - specified licence
* Version 4:
   - allowed carry weight of 9999
   - added "general speedup" component
   - updated sfall to version 3.7b
* Version 3:
   - fixed bug when enemies didn't receive same grenade CtH boost
   - fixed bug with grenade CtH when Sfall wasn't installed prviously
* Version 2: Added "no burst" component.
* Version 1: initial release.
