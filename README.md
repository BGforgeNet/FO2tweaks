# FO2tweaks

<a href="https://tra.bgforge.net/projects/fallout/fo2tweaks/">
<img src="https://tra.bgforge.net/widgets/fallout/-/fo2tweaks/svg-badge.svg" alt="Translation status" />
</a>
<a href="https://creativecommons.org/licenses/by-nc-sa/4.0/">
<img src="https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-blue.svg" alt="License" />
</a>

[__Download__](https://github.com/BGforgeNet/fo2tweaks/releases/latest)
 | [__Installation__](#installation)
 | [__Reporting issues__](#reporting-issues)
 | [__Forum__](https://forum.bgforge.net/viewforum.php?f=26)
 | [__Discord__](https://discord.gg/4Yqfggm)
 | [__Help translating__](https://tra.bgforge.net/projects/fallout/fo2tweaks/)

This is a collection of convenience tweaks, common sense changes, and cheats for Fallout 2.
It is highly configurable, any component can be used with or without others. Some components also allow fine tuning.

- [Components](#components)
  - [Inventory](#inventory)
    - [Unlimited carry weight](#unlimited-carry-weight)
    - [Unlimited trunk](#unlimited-trunk)
    - [Auto reload](#auto-reload)
  - [Party](#party)
    - [Unlimited party](#unlimited-party)
    - [Party level match](#party-level-match)
  - [Combat](#combat)
    - [Ammobox](#ammobox)
    - [Damage mod](#damage-mod)
    - [Disable knockback](#disable-knockback)
    - [Molotov cocktail: fire damage](#molotov-cocktail-fire-damage)
    - [Grenades ignore armor class](#grenades-ignore-armor-class)
    - [No close range penalty for scoped weapons](#no-close-range-penalty-for-scoped-weapons)
    - [HP over head](#hp-over-head)
  - [Miscellaneous](#miscellaneous)
    - [Autodoors](#autodoors)
    - [Healing revision](#healing-revision)
    - [Level 5 after Temple of Trials](#level-5-after-temple-of-trials)
    - [Worldmap hotkey](#worldmap-hotkey)
    - [Modoc brahmin](#modoc-brahmin)
    - [Expanded highlighting](#expanded-highlighting)
    - [Light level](#light-level)
- [Compatibility](#compatibility)
- [Installation](#installation)
- [Unistallation](#uninstallation)
- [Reporting issues](#reporting-issues)
- [Author](#author)
- [License](#license)
- [Changelog](#changelog)

## Components

### Inventory

#### Unlimited carry weight
AKA inventory pain killer, part 1. Let the Chosen one carry up to 99999, regardless of strength.

#### Unlimited trunk
Inventory pain killer, part 2. Never worry about trunk filling up.

#### Auto reload
Dude will automatically reload both weapons after combat has ended.

### Party

#### Unlimited party
This component removes charisma checks upon NPC joining the party.
It does not remove other checks (karma, etc). For example, Goris may still decline to join if you're a childkiller.
All vanilla and RP companions are included. More can added in the ini file.

#### Party level match
Some NPC like Goris are acquired later in the game and never reach their true potential because of that.
Now NPCs will automatically level up to match dude's level of experience. Default is to max out at level 24, configurable.
You can kick an NPC out, come back later, more experienced, and they will level up to match that.


### Combat
#### Ammobox
Current ammo will be displayed in an box notification during combat.

![ammobox in game](https://github.com/BGforgeNet/fo2tweaks/blob/master/pics/ammobox.jpg "ammobox in game")

#### Damage mod
Damage mod is a massive overhaul of Fallout's damage formula, intended to make AP ammo useful. It only affects __firearms__.

In a nutshell:
- DR mod is now DR/DT mod, and it multiplies both values, rather then adding/subtracting.
- DR mod also determines ammo damage multiplier. +25% DR also means damage multiplier of 1.25.
- DT is applied before any multipliers.
- Each bullet in a burst rolls its own critical damage (including bypass effect, but excluding any others). This roll is not affected by Sniper perk.

A more detailed description is available [here](https://forum.bgforge.net/viewtopic.php?f=26&p=388).

Effect on the game:
- Early game is more or less the same, JHP ammo rules.
- By midgame, starting somewhere with Metal Armor Mark II, AP ammo becomes somewhat more effective. (This doesn't mean that JHP doesn't do damage, though. A point-blank burst from a minigun with JHP will rip most enemies in Combat Armor apart).
- Power armor with its massive DT is a game changer. It will shrug off most JHP attacks. Even AP ammo is not very effective. You'll need to penetrate (criticals), or bring heavy weaponry.

It's designed for vanilla game ammo/weapons/armor. It will *work* with various mods such as [EcCo](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/),
however that may require tinkering with individual ammo modifiers in fo2tweaks.ini, and satisfactory result is not guaranteed.

#### Disable knockback
Disable knockback. That affects all weapons and explosives. These long trips over the screen from a Super Sledge can be really annoying.

#### Molotov cocktail: fire damage
Let Molotov cocktail do fire damage instead of explosive (and optionally, enable "burning death" animation)

#### Grenades ignore armor class
Grenades are actually thrown to target's feet, not "through" armor.
Hitting a person in power armor should not be any harder than one in leather armor.
Thus, this component removes AC penalty from grenades' CtH.

It also affects explosive (but not armor piercing) rockets from rocket launcher and grenade launchers from [EcCo](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/) mod.

#### No close range penalty for scoped weapons
Remove the close range penalty for Scoped Hunting Rifle, change its range to 48.
If [EcCo](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/) mod is installed,
it also affects Bozar and Sniper Rifle (without changing range).

#### HP over head
Current HP will be displayed over head in combat, for dude, party and nearby enemies.

*Note:* This component is not perfect, and there might be delays in numbers updating.

![hp over head in game](https://github.com/BGforgeNet/fo2tweaks/blob/master/pics/hp_over_head.jpg "hp over head in game")

### Miscellaneous

#### Autodoors
When not in combat, dude will be able to walk through unlocked doors without having to open them explicitly (like NPCs do).

#### Level 5 after Temple of Trials
Nets the Chosen 9500 XP after completing the Temple of Trials.
(While it feels like a cheat, pretty much the same may be accomplished by farming Geckos, or, easier even, planting/stealing items from them)

#### Healing revision
This is a massive change to Doctor and First Aid skills:
- First Aid is no longer Doctor's little brother. Now it's being treated as a skill of practical application of your Doctor knowledge.
- Doctor is "theoretical knowledge". Doctor's effectiveness is directly proportional to First Aid level.
- Both skills can be used once per day per *patient*.
- Effectiveness is capped at 100% for both skills.
- Amount healed is proportional to skill level. Maximum amount to heal (100% both skills) is 5 with First Aid and 10 with Doctor, with a little random added.
- XP granted is 10 per HP healed.
- For purposes of determining the amount healed, best skill level in *party* is used.
- Healing is applied automatically during rest and travel, Baldur's Gate style.
- Doctor's bags and First Aid kits are unchanged. They grant bonus to skill when used by dude explicitly, but they will randomly deplete as in original game. The items are not used in automatic healing described above.
- As a final bonus, if Doctor skill is raised to 135+, dude will receive Living Anatomy for free. (Applied when entering the next map. Can be configured or disabled.).

#### Worldmap hotkey
Adds hotkeys to call worldmap (W) and town map (T) at any moment. Yes, that can be used as a cheat at times. Configurable.

#### Keymap
Allows to remap vanilla game hotkeys. Configurable. Default mapping (to avoid accidental quick save instead of load and vice versa):
- Quick save: F5
- Quick load: F8
- Load game: F9
- Center on PC: G (for laptop users with no Home key)

#### Modoc Brahmin
A common annoyance in Modoc brahmin quest is that a party member shoots a brahma accidentally, and then the party proceeds to wipe them out.
To avoid this, these brahmin will now be on player's team.

#### Expanded highlighting
Expanded version of Sfall highlighting mod. A picture speaks a thousand words. Highly configurable.

![highlighting in game](https://github.com/BGforgeNet/fo2tweaks/blob/master/pics/highlighting.jpg "highlighting in game")


#### Light level
Designed for Restoration Project users. Unfortunately, many areas in RP are quite dark compared to the original game, to the point of being eye hazard.

Currently there's no way to adjust light level gracefully, so this component will grant the dude a free level of Night Vision perk.
Displayed light level affects chance to hit for both dude and enemies, so it's still fair game.

## Compatibility
* FO2tweaks is designed to be compatible with any other mod. If you find a conflict - report it.
* Damage mod component is a special case. It's designed for vanilla game stats, so using it with mods like YAAM or F2WR will probably yield unexpected results.
You're free to try and share your experience, however.

## Installation
- Download __fo2tweaks.zip__ from the [latest release page](https://github.com/BGforgeNet/fo2tweaks/releases/latest).
- Unzip the archive into the game directory.
- FO2tweaks requires sfall version 4.1.2+. It's shipped with the mod (ddraw.dll).
  If you have a newer version, you don't need to overwite the dll.
  However, if you just installed killap's Unofficial Patch or Restoration project,
  you'll need to use the version shipped with FO2tweaks (or a later version, which can be found [here](https://github.com/phobos2077/sfall/releases)).
- Edit fo2tweaks.ini to enable, disable or fine tune components as you desire.

## Uninstallation
Delete fo2tweaks.ini and all data/scripts/gl_g_* files.

## Reporting issues
* Open a new [issue](https://github.com/BGforgeNet/fo2tweaks/issues) and describe the problem.
* Also see the [forum](https://forum.bgforge.net/viewforum.php?f=26).

## Author
- [burner1024](https://github.com/burner1024)

## License
- The mod is [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Changelog
See [here](CHANGELOG.md).
