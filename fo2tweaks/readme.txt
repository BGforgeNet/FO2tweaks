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
- [Special notes / compatibility](#special-notes--compatibility)
- [Installation](#installation)
- [Unistallation](#uninstallation)
- [Reporting issues](#reporting-issues)
- [Author](#author)
- [License](#license)
- [Used software](#used-software)
- [Changelog](#changelog)

### Components
#### Molotov cocktail: fire damage
Let Molotov cocktail do fire damage instead of explosive (and optionally, enable "burning death" animation)
`
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
#### Armor doesn't reduce run speed
In the original game, running becomes slower as armor gets heavier. This component disables that behaviour, so that run speed is constant and fast.
#### Inventory filter
Inventory pain killer, part 3. This is the ultimate inventory mod which allows you to *filter* your stuff. The actual author is [Mr.Сталин](http://www.nuclear-city.com/index.php/topic/512-плагин-filter-inventory-для-fallout2-и-модов/page-1). This component requires Sfall version at least 3.5. If Sfall is not found or is too old, a newer version will be installed automatically.


__Tips:__
- Press CTRL to activate the second set of buttons
- Use middle mouse click on weapon/ammo buttons to see both item types
- You can't use bags (which aren't in original Fallout 2 anyway, but possibly may be added by 3rd party mods)

__Sample:__

![Sample](fo2tweaks/components/inventory_filter/sample.gif)

#### Unlimited party
This component removes charisma checks upon joining the party. It does not remove other checks (karma, etc). For example, Goris may still decline to join if you're a "bad guy".

The following companions are affected:
- Brain bot
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
- Miron
- Robodog
- Sulik
- Vic

#### Companions never use burst fire
Give any weapon to your companions, and never be burst in the back. (Well, unless you give them a machine gun which only has burst mode).

#### General game speedup
This component is only a convenience feature, configuring some sfall settings to speedup gameplay. Specifically:
- Game itself runs at 115% of the original speed
- Opening movies are skipped
- Combat, dialog and pipboy sleep panel animations are instant
- Empty weapons are stacked regardless of the ammo
- Weapon reload dialog with number of ammo boxes is skipped
- Weapon switch is instant (no animation)
- No splash screen is displayed (when HRP is available)
- Fade in/out is instance (when HRP is available)

### Special notes / compatibility
- **It will ONLY work if you have killap's patch** or restoration pack installed. You can get those at http://www.killap.net.
- It should be **compatible with any other mod** provided that "fo2tweaks" is installed last. It patches files instead of overwriting them.

### Reporting issues
The mod is tested on Windows XP x86. If you have any issues, reach me on [github](https://github.com/burner1024/fo2tweaks/issues).

### Installation
- Download __fo2tweaks.zip__ from the [latest release page](https://github.com/burner1024/fo2tweaks/releases/latest)
- Unzip the archive into the game directory
- Launch fo2tweaks.bat, answer the questions

### Uninstallation
- Launch fo2tweaks.bat, answer the questions

### Author
- burner1024 @ github

### License
- It's provided as is, without any guarantee. Feel free to use it in any way that you see fit.
- Used software have their own licences, refer to the corresponding resources for those.

### Used software
* [SSLC compiler/decompiler](http://www.nma-fallout.com/showthread.php?201526-Useful-Scripting-Libraries)
* [Gema](http://gema.sourceforge.net)
* [Weidu](http://weidu.org/~thebigg/)
* [Sfall](https://github.com/phobos2077/sfall)

### Changelog
* Version 5:
   - enable speed options in HRP as well
* Version 4:
   - allow carry weight of 9999
   - add "general speedup" component
   - update sfall to version 3.7b
* Version 3:
   - fixed bug when enemies didn't receive same grenade CtH boost
   - fixed bug with grenade CtH when Sfall wasn't installed prviously
* Version 2: Added "no burst" component.
* Version 1: initial release.

