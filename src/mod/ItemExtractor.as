package {
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONDecoder;
import com.adobe.serialization.json.JSONEncoder;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ItemExtractor {

    public static const VERSION:Number = 0.3;

    private var _sfeObj:Object;
    private var _config:Object;

    public function ItemExtractor() {
        this._sfeObj = null;
    }

    public function set sfeObj(value:Object):void {
        _sfeObj = value;
    }

    public function extractItems(playerInventory:Object, stashInventory:Object):void {
        try {
            if (!isSfeDefined()) {
                ShowHUDMessage("SFE cannot be found. Items extraction cancelled.");
            }
//            var clientData:Object = BSUIDataManager.GetDataFromClient("PlayerInventoryData").data;
            var clientData:Object = {};
            clientData.playerInventory = playerInventory;
            clientData.stashInventory = stashInventory;
            clientData.user = _config;
            clientData.version = VERSION;
            writeData(toString(clientData));
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