package {
import Shared.AS3.BGSExternalInterface;
import Shared.AS3.Data.BSUIDataManager;
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONDecoder;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.KeyboardEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.text.TextField;

import utils.Logger;

public class InventOmaticPipboy extends MovieClip {

    public static const MOD_NAME:String = "Invent-O-Matic-Pipboy";

    public static const EMBEDDED_CONFIG:Object = {
        "debug": false,
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
                    "characterName": "none",
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
                    "matchMode": "CONTAINS",
                    "itemNames": ["Mini nuke", "missile"],
                    "enabled": false,
                    "checkCharacterName": false,
                    "characterName": "none"
                }
            ]
        },
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
    };

    public var debugLogger:TextField;
    private var _parent:MovieClip;
    public var config:Object;
    public var characterName:String;
    public static const USE_EMBEDDED_CONFIG:Boolean = false;
    public static const DROP_ACTION:String = "drop";
    public static const CONSUME_ACTION:String = "consume";

    public function InventOmaticPipboy() {
        super();
        try {
            Logger.DEBUG_MODE = false;
            Logger.init(this.debugLogger);
        } catch (e:Error) {
            Logger.get().error(e);
            ShowHUDMessage("Error loading mod " + e);
        }
    }

    private function init():void {
        try {
            stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
            this.characterName = getCharacterName();
        } catch (e:Error) {
            Logger.get().errorHandler("Error adding key listener", e);
        }
    }

    public function consumeItemsCallback(sectionConfig:Object):void {
        sectionConfig.itemNames.forEach(function (itemName:String):void {
            var listMc:Array = parentClip.List_mc.entryList;
            for (var index:int = 0; index < listMc.length; index++) {
                var item:Object = listMc[index];
                var matches:Boolean = isItemMatchingConfig(item, itemName, sectionConfig.matchMode);
                if (matches) {
                    ShowHUDMessage("Trying to consume item: " + item.text);
                    consumeItem(item.nodeID);
                }
            }
        });
    }

    public function isProtected(item:Object, sectionConfig:Object):Boolean {
        var teenoodleTragedyProtection:Object = sectionConfig.teenoodleTragedyProtection;
        if (teenoodleTragedyProtection) {
            if (teenoodleTragedyProtection.typesToDrop
                    && teenoodleTragedyProtection.typesToDrop.length > 0) {
                var types:Array = teenoodleTragedyProtection.typesToDrop;
                var matchingFilterFlags:Array = [];
                for (var i:int = 0; i < types.length; i++) {
                    matchingFilterFlags = matchingFilterFlags.concat(matchingFilterFlags,
                            ItemTypes.ITEM_TYPES[types[i]]);
                }

                if (matchingFilterFlags.indexOf(item.filterFlag) == -1) {
                    return true;
                }
            }
            if (teenoodleTragedyProtection.ignoreLegendaries) {
                if (item.isLegendary) {
                    return true;
                }
            }
            if (teenoodleTragedyProtection.ignoreNonTradable) {
                if (!item.isTradable) {
                    return true;
                }
            }
        }
        return false;
    }

    public function dropItemsCallback(sectionConfig:Object):void {
        sectionConfig.itemNames.forEach(function (itemName:String):void {
            var listMc:Array = parentClip.List_mc.entryList;
            for (var index:int = 0; index < listMc.length; index++) {
                var item:Object = listMc[index];
                var matches:Boolean = isItemMatchingConfig(item, itemName, sectionConfig.matchMode);
                if (matches && !isProtected(item, sectionConfig)) {
                    var serverHandleID:String = item.serverHandleID;
                    var amount:int = item.count;
                    ShowHUDMessage("Trying to drop item: " + item.text + "(" + amount + "), "
                            + serverHandleID);
                    dropItem(item);
                }
            }
        });
    }

    private static function isItemMatchingConfig(item:Object, itemConfig:String,
            matchMode:String):Boolean {
        var itemText:String = item.text;
        if (itemText === null || itemText == null || itemText.length < 1 || itemText === ''
                || itemText == '') {
            return false;
        }
        var matches:Boolean = false;
        if (matchMode === MatchMode.EXACT) {
            matches = itemText === itemConfig;
        } else if (matchMode === MatchMode.CONTAINS) {
            matches = itemText.toLowerCase().indexOf(itemConfig.toLowerCase()) >= 0;
        } else if (matchMode === MatchMode.STARTS) {
            matches = itemText.toLowerCase().indexOf(itemConfig.toLowerCase()) === 0;
        } else if (matchMode === MatchMode.ALL) {
            matches = true;
        }
        return matches;
    }

    public static function getCharacterName():String {
        try {
            return BSUIDataManager.GetDataFromClient("CharacterInfoData").data.name;
        } catch (e:Error) {

        }
        return null;
    }

    private function isTheSameCharacterName(sectionConfig:Object):Boolean {
        if (sectionConfig.checkCharacterName) {
            return this.characterName === sectionConfig.characterName;
        }
        return true;
    }

    public function setParent(parent:MovieClip):void {
        this._parent = parent;
        if (USE_EMBEDDED_CONFIG) {
            config = EMBEDDED_CONFIG;
        } else {
            loadConfig();
        }
        init();
    }

    private function loadConfig():void {
        try {
            var url:URLRequest = new URLRequest("../inventOmaticPipboyConfig.json");
            var loader:URLLoader = new URLLoader();
            loader.load(url);
            loader.addEventListener(IOErrorEvent.IO_ERROR, loaderError);
            loader.addEventListener(Event.COMPLETE, loaderComplete);

            function loaderError(e:Event):void {
                ShowHUDMessage("Error loading config " + e);
                Logger.get().error(e);
            }

            function loaderComplete(e:Event):void {
                try {
                    var jsonData:Object = new JSONDecoder(loader.data, true).getValue();
                    config = jsonData;
                    Logger.get().debugMode = jsonData.debug;
                    ShowHUDMessage("Config file is loaded!");
                } catch (e:Error) {
                    ShowHUDMessage("Error loading config " + e);
                    Logger.get().error(e);
                }
            }
        } catch (e:Error) {
            ShowHUDMessage(e.getStackTrace());
        }
    }

    public function get parentClip():MovieClip {
        return _parent;
    }

    private function isMatchingConfigSection(e:KeyboardEvent, sectionConfig:Object):Boolean {
        return e.keyCode === sectionConfig.hotkey && sectionConfig.enabled
                && isTheSameCharacterName(sectionConfig);
    }

    public function isConfigEnabled(configName:String):Boolean {
        return config[configName]
                && config[configName].enabled
                && config[configName].configs
                && config[configName].configs.length > 0;
    }

    private function keyUpHandler(e:KeyboardEvent):void {
        if (config) {
            if (isConfigEnabled(DROP_ACTION)) {
                config.drop.configs.forEach(function (sectionConfig:Object):void {
                    if (isMatchingConfigSection(e, sectionConfig)) {
                        ShowHUDMessage("[Drop] " + sectionConfig.name, true);
                        dropItemsCallback(sectionConfig);
                    }
                });
            }
            if (isConfigEnabled(CONSUME_ACTION)) {
                config.consume.configs.forEach(function (sectionConfig:Object):void {
                    if (isMatchingConfigSection(e, sectionConfig)) {
                        ShowHUDMessage("[Consume] " + sectionConfig.name, true);
                        consumeItemsCallback(sectionConfig);
                    }
                });
            }
        }
    }

    private function consumeItem(index:int):void {
        try {
            BGSExternalInterface.call(this.parentClip.codeObj, "SelectItem", index);
        } catch (e:Error) {
            Logger.get().error("Error consuming item: " + e);
        }
    }

    private function dropItem(item:Object):void {
        try {
            BGSExternalInterface.call(this.parentClip.codeObj, "ItemDrop", item.serverHandleID,
                    item.count);
        } catch (e:Error) {
            Logger.get().error("Error dropping item: " + e);
        }
    }

    public function ShowHUDMessage(text:String, forceDisplay:Boolean = false):void {
        if ((config && config.debug) || forceDisplay) {
            GlobalFunc.ShowHUDMessage("[" + MOD_NAME + " v" + Version.MOD + "] " + text);
        }
    }
}
}
