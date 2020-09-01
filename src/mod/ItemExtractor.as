package {
import Shared.AS3.Data.BSUIDataManager;
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONDecoder;
import com.adobe.serialization.json.JSONEncoder;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ItemExtractor {

    public static const VERSION:Number = 0.4;

    private var _sfeObj:Object;
    private var _config:Object;
    private var itemsModIni:Object;
    private var playerInventory:Object;
    private var stashInventory:Object;

    public function ItemExtractor() {
        this._sfeObj = null;
        this.itemsModIni = null;
    }

    public function set sfeObj(value:Object):void {
        _sfeObj = value;
    }

    public function setInventory(playerInventory:Object, stashInventory:Object):void {
        this.playerInventory = playerInventory;
        this.stashInventory = stashInventory;
    }

    public function extractItems():void {
        try {
            if (!isSfeDefined()) {
                ShowHUDMessage("SFE cannot be found. Items extraction cancelled.");
                return;
            }
            if (itemsModIni === null) {
                itemsModIni = {};
                itemsModIni.characterInventories = {};
            }
            var CharacterInfoData:Object = BSUIDataManager.GetDataFromClient("CharacterInfoData").data;
            var AccountInfoData:Object = BSUIDataManager.GetDataFromClient("AccountInfoData").data;

            var characterInventory:Object = {};
            characterInventory.playerInventory = this.playerInventory;
            characterInventory.stashInventory = this.stashInventory;
            characterInventory.AccountInfoData = AccountInfoData;
            characterInventory.CharacterInfoData = CharacterInfoData;

            itemsModIni.characterInventories[CharacterInfoData.name] = characterInventory;
            itemsModIni.user = _config;
            itemsModIni.version = VERSION;
            writeData(toString(itemsModIni));
        } catch (e:Error) {
            ShowHUDMessage("Error extracting items(core): " + e);
        }
    }

    private static function toString(obj:Object):String {
        return new JSONEncoder(obj).getString();
    }

    public function isSfeDefined():Boolean {
        return this._sfeObj != null && this._sfeObj.call != null;
    }

    private function writeData(data:String):void {
        try {
            if (isSfeDefined()) {
                this._sfeObj.call("writeItemsModFile", data);
                ShowHUDMessage("Done saving items!");
            }
        } catch (e:Error) {
            ShowHUDMessage("Error saving items! " + e);
        }
    }

    public static function ShowHUDMessage(text:String):void {
        GlobalFunc.ShowHUDMessage("[ItemExtractorMod v" + VERSION + "] " + text);
    }

    private function readItemsModIniFile():void {
        try {
            var url:String = "../itemsmod.ini";
            var loader:URLLoader = new URLLoader(new URLRequest(url));
            loader.addEventListener(Event.COMPLETE, onFileLoaded);
            function onFileLoaded(e:Event):void {
                var loader:URLLoader = e.target as URLLoader;
                var data:String = loader.data;
                itemsModIni = new JSONDecoder(data, true).getValue();
                ShowHUDMessage("Loaded previous item dump");
                extractItems();
            }
        } catch (e:Error) {
            ShowHUDMessage("Error loading previous item dump: " + e);
        }
    }

    public function init():void {
        try {
            var url:String = "../trademod.json";
            var loader:URLLoader = new URLLoader(new URLRequest(url));
            loader.addEventListener(Event.COMPLETE, onFileLoaded);

            function onFileLoaded(e:Event):void {
                var loader:URLLoader = e.target as URLLoader;
                var data:String = loader.data;
                _config = new JSONDecoder(data, true).getValue();
                ShowHUDMessage("Config loaded for user: " + _config.user);
                if (_config.append) {
                    readItemsModIniFile();
                } else {
                    extractItems();
                }
            }
        } catch (e:Error) {
            _config = {
                user: 'nouser',
                password: 'nopassword'
            };
            ShowHUDMessage("Error reading config file: " + e);
        }
    }
}
}