package extractors {
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONEncoder;

public class BaseItemExtractor {

    public static const MODE_CONTAINER:uint = 0;

    public static const MODE_PLAYERVENDING:uint = 1;

    public static const MODE_NPCVENDING:uint = 2;

    public static const MODE_VENDING_MACHINE:int = 3;

    public static const MODE_DISPLAY_CASE:int = 4;

    public static const MODE_CAMP_DISPENSER:int = 5;

    public static const MODE_FERMENTER:int = 6;

    public static const MODE_REFRIGERATOR:int = 7;

    public static const MODE_ALLY:int = 8;

    public static const MODE_INVALID:uint = uint.MAX_VALUE;

    protected var _sfeObj:Object;
    protected var playerInventory:Object;
    protected var stashInventory:Object;
    protected var version:Number;
    protected var modName:String;

    public function BaseItemExtractor(value:Object, modName:String, version:Number) {
        this._sfeObj = value;
        this.modName = modName;
        this.version = version;
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
            ShowHUDMessage("Starting extracting items!");
            var itemsModIni:Object = buildOutputObject();
            writeData(toString(itemsModIni));
        } catch (e:Error) {
            ShowHUDMessage("Error extracting items(core): " + e);
        }
    }

    public function buildOutputObject():Object {
        return {
            modName: modName,
            version: version
        };
    }

    protected static function toString(obj:Object):String {
        return new JSONEncoder(obj).getString();
    }

    public function isSfeDefined():Boolean {
        return this._sfeObj != null && this._sfeObj.call != null;
    }

    protected function writeData(data:String):void {
        try {
            if (isSfeDefined()) {
                this._sfeObj.call("writeItemsModFile", data);
                ShowHUDMessage("Done saving items!");
            } else {
                ShowHUDMessage("Cannot find SFE, writing to file cancelled!");
            }
        } catch (e:Error) {
            ShowHUDMessage("Error saving items! " + e);
        }
    }

    public function ShowHUDMessage(text:String):void {
        GlobalFunc.ShowHUDMessage("[" + modName + " v" + version + "] " + text);
    }

    public function isValidMode(menuMode:uint):Boolean {
        return false;
    }

    public function getInvalidModeMessage():String {
        return "Invalid mode";
    }

    public function showInvalidModeMessage():void {
        this.ShowHUDMessage(getInvalidModeMessage());
    }
}
}