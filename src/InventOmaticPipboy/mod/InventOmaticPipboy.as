package {
import Shared.AS3.BGSExternalInterface;
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

    public var debugLogger:TextField;
    private var _parent:MovieClip;
    public var config:Object;

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
        } catch (e:Error) {
            Logger.get().errorHandler("Error adding key listener", e);
        }
    }

    public function consumeItemsCallback(itemsToConsume:Array, matchMode:String):void {
        itemsToConsume.forEach(function (itemConfig:String):void {
            var listMc:Array = parentClip.List_mc.entryList;
            for (var index:int = 0; index < listMc.length; index++) {
                var item:Object = listMc[index];
                var matches:Boolean = isItemMatchingConfig(item, itemConfig, matchMode);
                if (matches) {
                    ShowHUDMessage("Trying to consume item: " + item.text);
                    consumeItem(index);
                }
            }
        });
    }

    private static function isItemMatchingConfig(item:Object, itemConfig:String,
            matchMode:String):Boolean {
        var itemText:String = item.text;
        var matches:Boolean = false;
        if (matchMode === MatchMode.EXACT) {
            matches = itemText === itemConfig;
        } else if (matchMode === MatchMode.CONTAINS) {
            matches = itemText.toLowerCase().indexOf(itemConfig.toLowerCase()) >= 0;
        } else if (matchMode === MatchMode.STARTS) {
            matches = itemText.toLowerCase().indexOf(itemConfig.toLowerCase()) === 0;
        }
        return matches;
    }

    public function dropItemsCallback(itemsToDrop:Array, matchMode:String):void {
        itemsToDrop.forEach(function (itemConfig:String):void {
            var listMc:Array = parentClip.List_mc.entryList;
            for (var index:int = 0; index < listMc.length; index++) {
                var item:Object = listMc[index];
                var matches:Boolean = isItemMatchingConfig(item, itemConfig, matchMode);
                if (matches) {
                    var serverHandleID:String = item.serverHandleID;
                    var amount:int = item.count;
                    ShowHUDMessage("Trying to drop item: " + item.text + "(" + amount + "), "
                            + serverHandleID);
                    dropItem(item);
                }
            }
        });
    }

    public function setParent(parent:MovieClip):void {
        this._parent = parent;
        loadConfig();
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

    private function keyUpHandler(e:KeyboardEvent):void {
        if (config) {
            if (config.drop && config.drop.length > 0) {
                config.drop.forEach(function (sectionConfig:Object):void {
                    if (e.keyCode === sectionConfig.hotkey) {
                        ShowHUDMessage("[Drop] " + sectionConfig.name, true);
                        dropItemsCallback(sectionConfig.itemNames, sectionConfig.matchMode);
                    }
                });
            }
            if (config.consume && config.consume.length > 0) {
                config.consume.forEach(function (sectionConfig:Object):void {
                    if (e.keyCode === sectionConfig.hotkey) {
                        ShowHUDMessage("[Consume] " + sectionConfig.name, true);
                        consumeItemsCallback(sectionConfig.itemNames, sectionConfig.matchMode);
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
