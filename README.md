# FO2tweaks

[![Build status](https://github.com/BGforgeNet/FO2tweaks/workflows/build/badge.svg)](https://github.com/BGforgeNet/FO2tweaks/actions?query=workflow%3Abuild)
[![Translation status](https://hive.bgforge.net/widgets/fallout/-/fo2tweaks/svg-badge.svg)](https://hive.bgforge.net/projects/fallout/fo2tweaks/)
[![License](https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-blue.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![Patreon](https://img.shields.io/badge/Patreon-donate-FF424D?logo=Patreon&labelColor=141518)](https://www.patreon.com/BGforge)

[![Telegram](https://img.shields.io/badge/telegram-join%20%20%20%20%E2%9D%B1%E2%9D%B1%E2%9D%B1-darkorange?logo=telegram)](https://t.me/bgforge)
[![Discord](https://img.shields.io/discord/420268540700917760?logo=discord&label=discord&color=blue&logoColor=FEE75C)](https://discord.gg/4Yqfggm)
[![IRC](https://img.shields.io/badge/%23IRC-join%20%20%20%20%E2%9D%B1%E2%9D%B1%E2%9D%B1-darkorange)](https://bgforge.net/irc)

[**Download**](https://github.com/BGforgeNet/FO2tweaks/releases/latest)
| [**Report issues**](#reporting-issues)
| [**Discuss**](https://forums.bgforge.net/viewforum.php?f=26)
| [**Translate**](https://hive.bgforge.net/projects/fallout/fo2tweaks/)

This is a collection of convenience tweaks, common sense changes, and cheats for Fallout 2.
It is highly configurable, any component can be used with or without others. Some components also allow fine tuning.

- [Components](#components)
- [Installation](#installation)
- [Unistallation](#uninstallation)
- [Reporting issues](#reporting-issues)
- [Author](#author)
- [Changelog](docs/changelog.md)

## Components

- [Inventory](#inventory)
  - [Unlimited carry weight](#unlimited-carry-weight)
  - [Unlimited trunk](#unlimited-trunk)
  - [Auto reload](#auto-reload)
  - [Don't drop items on death](#dont-drop-items-on-death)
- [Party](#party)
  - [Unlimited party](#unlimited-party)
  - [Party level match](#party-level-match)
- [Speed](#speed)
  - [General game speedup](#general-game-speedup)
  - [Party run speed](#party-run-speed)
- [Combat](#combat)
  - [Ammobox](#ammobox)
  - [Damage mod](#damage-mod)
  - [Limit knockback](#limit-knockback)
  - [Molotov cocktail: fire damage](#molotov-cocktail-fire-damage)
  - [Improved grenades](#improved-grenades)
  - [No close range penalty for scoped weapons](#no-close-range-penalty-for-scoped-weapons)
  - [HP over head](#hp-over-head)
  - [Auto cursor](#auto-cursor)
- [Miscellaneous](#miscellaneous)
  - [Autodoors](#autodoors)
  - [Healing revision](#healing-revision)
  - [Level 5 after Temple of Trials](#level-5-after-temple-of-trials)
  - [Map hotkey](#map-hotkey)
  - [Keymap](#keymap)
  - [Modoc brahmin](#modoc-brahmin)
  - [Expanded highlighting](#expanded-highlighting)
  - [Light level](#light-level)

### Inventory

#### Unlimited carry weight

AKA inventory pain killer, part 1. Let the Chosen One carry up to 99999, regardless of strength.

#### Unlimited trunk

Inventory pain killer, part 2. Never worry about trunk filling up.

#### Auto reload

Dude will automatically reload both weapons after combat has ended.

#### Don't drop items on death

Certain violent death animations (exploded, electrified, etc) cause enemies to drop all their inventory to the ground. It's annoying to pick up all that. Now you can disable this behaviour and loot all remains normally.

### Party

#### Unlimited party

This component removes charisma checks upon NPC joining the party.
It does not remove other checks (karma, etc). For example, Goris may still decline to join if you're a childkiller.
All vanilla and RP companions are included. More can be added in `mods/fo2tweaks.ini`.

#### Party level match

Some NPCs like Goris are acquired later in the game and never reach their true potential because of that.
Now NPCs will automatically level up to match dude's level of experience. Default is to max out at level 24, configurable.
You can kick an NPC out, come back later, more experienced, and they will level up to match that.

### Speed

#### General game speedup

This is a convenience only component. It will set various values in game configs to increase overall game/interface speed. That includes skipping intro movies and splash screens, decreasing fadein/out time, weapon equip animation, etc.

Note:

1. You can do the same manually, this is simply a shortcut.
1. For it to start working, you need to enable it in `fo2tweaks.ini`, load a savegame, then _quit and relaunch the game_.
1. If you later disable speedup in `fo2tweaks.ini`, all the settings will not reset back to what they were. If you want that, you'll have to reset them manually.

[Full list of changed settings](docs/speedup.md).

In addition to that, you will probably want to set the following options in `fallout2.cfg`:

```ini
[preferences]
combat_speed=50
player_speedup=1
running=1
```

#### Party run speed

Are you tired of Marcus, Skynet, Lenny lagging behind? Then this coomponent is for you. It has two separate options:

- Make Chosen's run speed constant. In vanilla game, wearing heavy armor descreases run speed by approximately 20%. This option disables the penalty for the Chosen.
- Increase companions run speed:
  - All NPCs get a slight boost (like Chosen above).
  - NPCs who have no running animation (Marcus, Skynet, Lenny) get one, so they will be able to catch up with the Chosen.

### Combat

#### Ammobox

Current ammo type will be displayed in a notification box during combat.

![ammobox in game](https://github.com/BGforgeNet/fo2tweaks/blob/master/pics/ammobox.jpg "ammobox in game")

#### Damage mod

Damage mod is a massive overhaul of Fallout's damage formula, intended to make AP ammo useful. It only affects **firearms**.
(**Note**: you must set `DamageFormula=0` in `ddraw.ini` for this component to work correctly.)

In a nutshell:

- DR mod is now DR/DT mod, and it multiplies both values, rather then adding/subtracting.
- DR mod also determines ammo damage multiplier. +25% DR also means damage multiplier of 1.25.
- DT is applied before any multipliers.
- Each bullet in a burst rolls its own critical damage (including bypass effect, but excluding any others). This roll is not affected by Sniper perk.

A more detailed description is available [here](https://forums.bgforge.net/viewtopic.php?f=26&p=388).

Effect on the game:

- Early game is more or less the same, JHP ammo rules.
- By midgame, starting somewhere with Metal Armor Mark II, AP ammo becomes somewhat more effective. (This doesn't mean that JHP doesn't do damage, though. A point-blank burst from a minigun with JHP will rip most enemies in Combat Armor apart).
- Power armor with its massive DT is a game changer. It will shrug off most JHP attacks. Even AP ammo is not very effective. You'll need to penetrate (criticals), or bring heavy weaponry.

It's designed for vanilla game ammo/weapons/armor. It will _work_ with various mods such as [EcCo](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/),
however that may require tinkering with individual ammo modifiers in `fo2tweaks.ini`, and satisfactory result is not guaranteed.

#### Limit knockback

Allows to limit max knockback distance. That affects all weapons and explosives. These long trips over the screen from a Super Sledge can be really annoying.

#### Molotov cocktail: fire damage

Let Molotov cocktail do fire damage instead of explosive (and optionally, enable "burning death" animation)

#### Improved grenades

Grenades are actually thrown to target's feet, not "through" armor.
Hitting a person in power armor should not be any harder than one in leather armor.
Thus:

1. Target's armor class is ignored when using grenades, making it easier to hit with one.
2. Grenades can now be tossed into empty hexes, opening new tactical possibilities.

It also affects explosive (but not armor piercing) rockets from rocket launcher, flares, grenade launchers from [EcCo](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/) mod.

#### No close range penalty for scoped weapons

Remove the close range penalty for Scoped Hunting Rifle, change its range to 48.
If [EcCo](http://www.nma-fallout.com/threads/economy-and-combat-rebalance-mod.193578/) mod is installed,
it also affects Bozar and Sniper Rifle (without changing range).

#### HP over head

Current HP will be displayed over head in combat, for dude, party and nearby enemies. Can be configured to display HP always or on key tap.

_Note:_ This component is not perfect, there might be delays in updating, and it will interfere with combat floats.

![hp over head in game](https://github.com/BGforgeNet/fo2tweaks/blob/master/pics/hp_over_head.jpg "hp over head in game")

#### Auto cursor

In combat, cursor state automatically changes to "attack" when hovering over an enemy, and back to "move" when over an empty hex.

### Miscellaneous

#### Autodoors

When not in combat, dude will be able to walk through unlocked doors without having to open them explicitly (like NPCs do).

#### Level 5 after Temple of Trials

Nets the Chosen 9500 XP after completing the Temple of Trials.
(While it feels like a cheat, pretty much the same may be accomplished by farming geckos, or, easier even, planting/stealing items from them)

#### Healing revision

This is a massive change to Doctor and First Aid skills:

- First Aid is no longer Doctor's little brother. Now it's being treated as a skill of practical application of your Doctor knowledge.
- Doctor is "theoretical knowledge". Doctor's effectiveness is directly proportional to First Aid level.
- Both skills can be used once per day per _patient_.
- Effectiveness is capped at 100% for both skills.
- Amount healed is proportional to skill level. Maximum amount to heal (100% both skills) is 5 with First Aid and 10 with Doctor, with a little random added. (Also, each level of Healer perk adds extra 2 HP healed.)
- XP granted is 10 per HP healed.
- For purposes of determining the amount healed, best skill level in _party_ is used.
- Healing is applied automatically during rest and travel, Baldur's Gate style.
- Doctor's bags and First Aid kits are unchanged. They grant bonus to skill when used by dude explicitly, but they will randomly deplete as in original game. The items are not used in automatic healing described above.
- As a final bonus, if Doctor skill is raised to 135+, dude will receive Living Anatomy for free. (Applied when entering the next map. Can be configured or disabled.).

#### Map hotkey

Adds hotkeys to call worldmap (W) and town map (Y) at any moment. Yes, that can be used as a cheat at times. Configurable.

#### Keymap

Allows to remap vanilla game hotkeys. Configurable. Default mapping (to avoid accidental quick save instead of load and vice versa):

- Quick save: F5
- Quick load: F8
- Load game: F9
- Center on PC: J (for laptop users with no Home key)

#### Modoc Brahmin

A common annoyance in Modoc brahmin quest is that a party member shoots a brahma accidentally, and then the party proceeds to wipe them out.
To avoid this, these brahmin will now be on player's team.

#### Expanded highlighting

Expanded version of Sfall highlighting mod. A picture is worth a thousand words. Highly configurable.

**Note:** if you're using this, you must disable default sfall highlighting (delete `data/scripts/gl_highlighting.int`).

![highlighting in game](https://github.com/BGforgeNet/FO2tweaks/blob/master/pics/highlighting.jpg "highlighting in game")

#### Light level

Designed for Restoration Project users. Unfortunately, many areas in RP are quite dark compared to the original game, to the point of being eye hazard.

This allows to set a lower limit for the ambient light level. Refer to the [wiki](https://falloutmods.fandom.com/wiki/Fallout_2_light_levels) to understand how light works in Fallout.

## Installation

- Download `fo2tweaks_v*.zip` from the [latest release](https://github.com/BGforgeNet/FO2tweaks/releases/latest) page.
- Unzip the archive into main game directory. FO2tweaks requires sfall (`ddraw.dll`) version 4.1.3+, it's shipped with the mod. If you have a newer version, you don't need to overwite the dll when extracting the archive.
- Edit `mods/fo2tweaks.ini` to enable, disable or fine tune components as you desire.

This is how it's supposed to look when installed:

![installed](pics/installed.png)

## Compatibility

- FO2tweaks is designed to be compatible with any other mod. If you find a conflict - report it.
- Damage mod component is a special case. It's designed for vanilla game stats, so using it with mods like YAAM or F2WR will probably yield unexpected results.
  You're free to try and share your experience, however.

## Uninstallation

Delete `mods/fo2tweaks.*` files.

## Reporting issues

1. Discussion and questions: see the [forum](https://forums.bgforge.net/viewforum.php?f=26).
1. Bug reports:
   - describe the bug
   - attach a savegame
   - detail the steps to trigger the bug
   - note versions: FO2tweaks, `ddraw.dll`, any other mods you have installed. _Exact_ versions, don't just say "latest".
   - also attach [`debug.log`](https://github.com/BGforgeNet/Fallout2_Unofficial_Patch/blob/master/docs/debug.md)
1. For feature requests: free form, but please be descriptive.

## Author

- [Magus at BGforge](https://forums.bgforge.net/viewforum.php?f=26)
