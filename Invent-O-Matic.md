Mod allows you to drop all the unneeded items, prepare for the fight, get some buffs with a single key press within your pipboy.

#Installation

A. Manually edit Fallout76Custom.ini:
   ```
   [Archive]
   sResourceArchive2List = InventOmaticPipboy.ba2
   ```
B. Regular installation via any supported mod manager.

####**Don't forget to drop config file into the Data directory!**

#Usage:

1. You have to modify config file: **inventOmaticPipboyConfig.json**

##**If you're facing issue while configuring mod or need any help, please, join discord for support: https://discord.gg/7fef733**

`debug` - values are true or false, needed only if you have some issues with mod.

`drop` - section intended for dropping all the specified items

`consume` - section intended for consuming/using all the specified items

### Drop section - intended for dropping all the specified items

Sample of Drop section looks like this:

```json
    "drop": {
      "enabled": true,
      "configs": [
          {
            "name": "Junk items to drop",
            "hotkey": 79,
            "matchMode": "CONTAINS",
            "itemNames": ["Mini nuke", "missile", "junk"],
            "enabled": true,
            "checkCharacterName": false,
            "characterName": "MANSON1",
            "teenoodleTragedyProtection": {
                "ignoreLegendaries": false,
                "ignoreNonTradable": false,
                "typesToDrop": [
                  "JUNK"
                ]
            }
          }, 
          {
            "name": "Junk items to drop 2",
            "hotkey": 82,
            "matchMode": "EXACT",
            "itemNames": ["itemName1", "itemName2"],
            "enabled": false,
            "checkCharacterName": false,
            "characterName": "none"
          }
      ]
    }
```

`enabled` - turns on (`true`) or off (`false`) entire drop feature

`configs` - list of different configs for dropping items, there could be a bunch of drop configs, each config consists of additional options:

`name` - custom name of the config (it will display a message in-game, once you will press specified hotkey)

`hotkey` - actual button that will trigger dropping (see full list of values here: https://www.makeflashgames.com/resources/keycodes.php), you have to provide keyCode from the table

`matchMode` - one of the values:

- `"CONTAINS"` - item name in pipboy should include item name in config, case-insensitive (USE WITH CAUTION: it could drop too many items, in case too generic item name)
- `"STARTS"` - item name in pipboy should start with item name in config, case-insensitive; e.g. prefix (USE WITH CAUTION: it could drop too many items, in case too generic item name)
- `"EXACT"` - item name in pipboy should exactly match item name in config, case-sensitive
- `"ALL"` - ignores item names and drops everything

`itemNames` - list of items, that you want to drop, e.g. 

```json
"itemNames": ["item name1", "item name 2", "etc"]
```

`enabled` - turns on (`true`) or off (`false`) entire specific drop config

`checkCharacterName` - [Optional] turns on (`true`) or off (`false`) checking if specified `characterName` matches character in game

`characterName` - [Optional] character name, will be used only if `checkCharacterName` is equal to `true`

`teenoodleTragedyProtection` - [Optional] specific protection config, to eliminate possibility of dropping items, that you don't want to, it consists of:

- `ignoreLegendaries` - turns on (`true`) or off (`false`) dropping legendary items (if all other checks are passed, e.g. by item name)
- `ignoreNonTradable` - turns on (`true`) or off (`false`) dropping non-tradable items (if all other checks are passed, e.g. by item name). Not very useful, IMO, since game marks most of the junk items as non-tradable.
- `typesToDrop` - array of specific item types, that should be processed for dropping, e.g.
```json
                "typesToDrop": [
                  "JUNK",
                  "AMMO"
                ]
```

In this case, mod will try to drop only items from junk and ammo categories, rest of them will be ignored.

Full list of types:
```
        "POWER_ARMOR"
        "WEAPON"
        "ARMOR"
        "APPAREL"
        "FOOD_WATER"
        "AID"
        "NOTES"
        "HOLO"
        "AMMO"
        "MISC"
        "MODS"
        "JUNK"
```

### Consume section - intended for consuming all the specified items (acts the same way, as you'd clicked on item in your pipboy)

####Here and everywhere in this document, by 'consume' I mean using aid/food, dressing up gear and so on. Consume works exactly the same way, as you'd clicked on item in pipboy with your mouse.

Sample of Consume section looks like this:
```json
        "consume": {
            "enabled": true,
            "configs": [
                {
                    "name": "Boss name items to consume",
                    "hotkey": 80,
                    "matchMode": "CONTAINS",
                    "itemNames": ["Beer", "Fury"],
                    "enabled": true,
                    "checkCharacterName": false,
                    "characterName": "none"
                },
                {
                    "name": "Boss name items to consume 2",
                    "hotkey": 81,
                    "matchMode": "CONTAINS",
                    "itemNames": ["Beer", "Fury"],
                    "enabled": false,
                    "checkCharacterName": false,
                    "characterName": "none"
                }
            ]
        }
```

`enabled` - turns on (`true`) or off (`false`) entire consume feature

`configs` - list of different configs for consume items, there could be a bunch of consume configs, each config consists of additional options:

`name` - custom name of the config (it will display a message in-game, once you will press specified hotkey)

`hotkey` - actual button that will trigger consuming (see full list of values here: https://www.makeflashgames.com/resources/keycodes.php), you have to provide keyCode from the table

`matchMode` - one of the values:

- `"CONTAINS"` - item name in pipboy should include item name in config, case-insensitive (USE WITH CAUTION: it could drop too many items, in case too generic item name)
- `"STARTS"` - item name in pipboy should start with item name in config, case-insensitive; e.g. prefix (USE WITH CAUTION: it could drop too many items, in case too generic item name)
- `"EXACT"` - item name in pipboy should exactly match item name in config, case-sensitive
- `"ALL"` - ignores item names and consumes everything

`itemNames` - list of items, that you want to consume, e.g.

```json
"itemNames": ["item name1", "item name 2", "etc"]
```

`enabled` - turns on (`true`) or off (`false`) entire specific consume config

`checkCharacterName` - [Optional] turns on (`true`) or off (`false`) checking if specified `characterName` matches character in game

`characterName` - [Optional] character name, will be used only if `checkCharacterName` is equal to `true`


Basically, you may specify unlimited configs for both drop and consume actions and bind all of them to a different hotkeys.

2. Once config is populated - open your pipboy, navigate to inventory tab and press configured hotkey.
3. That's it!
   Important
   This mod modifies pipboy_invpage.swf file, so it is incompatible with any other mod that modifies the same file.
   
# Known incompatible mods:
- **Save Everything** (in pipboy - doesn't work; for trade/container menu it should work, if placed before InventOmaticPipboy.ba2 in mod list).

Option, to enable Save Everything in trade menus/scrapbox/stashbox, everywhere except pipboy in order to be able to use both mods:

1. Download SaveEverything mod
2. Unzip its content in a random directory (there should be directory "Interface" and inside it, 3 files: pipboymenu.swf, saveeverything_pipboy_invpage.swf, securetrade.swf).
3. Delete pipboymenu.swf, saveeverything_pipboy_invpage.swf files.
4. In the end you should get Interface directory with a single file inside: securetrade.swf. (Make sure to check file structure with original mod, it should be the same, except 2 removed files).
5. Use Archive2 or any other ba2 archiver to make ba2 file.
6. Install this newly created mod.
7. Done! Invent-O-Matic works in pipboy, SaveEverything works in trade menus.


Compatible with Better Inventory mod. To make both mods work, InventOmaticPipboy.ba2 should be after Better Inventory in mod list in `Fallout76Custom.ini` file.

#Future plans:
- Add configuration to the game UI (right now there is no way to see configured settings in game)
- Integrate with other mods

#Support
If you need any help, please join my discord server: https://discord.gg/7fef733

#Donations
I'm developing all the tools just because I like it, everything is free to use and open-source, but if you wish to support my work, here is my patreon:
https://www.patreon.com/manson_ew2