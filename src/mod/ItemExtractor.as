package {
import Shared.AS3.Data.BSUIDataManager;
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONEncoder;

public class ItemExtractor {

    public static const VERSION:Number = 0.5;
    public static const MOD_NAME:String = "ItemExtractorMod";
    public static const FED_MOD_NAME:String = "Fed76Enhancer";

    private var _sfeObj:Object;
    private var playerInventory:Object;
    private var stashInventory:Object;

    public function ItemExtractor() {
        this._sfeObj = null;
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
            ShowHUDMessage("Starting extracting items!");
            var itemsModIni:Object = {};
            itemsModIni.characterInventories = {};
            var CharacterInfoData:Object = BSUIDataManager.GetDataFromClient(
                    "CharacterInfoData").data;
            var AccountInfoData:Object = BSUIDataManager.GetDataFromClient("AccountInfoData").data;

            var characterInventory:Object = {};
            characterInventory.playerInventory = this.playerInventory;
            characterInventory.stashInventory = this.stashInventory;
            characterInventory.AccountInfoData = AccountInfoData;
            characterInventory.CharacterInfoData = CharacterInfoData;

            itemsModIni.characterInventories[CharacterInfoData.name] = characterInventory;
            itemsModIni.modName = MOD_NAME;
            itemsModIni.version = VERSION;
            writeData(toString(itemsModIni));
        } catch (e:Error) {
            ShowHUDMessage("Error extracting items(core): " + e);
        }
    }

    public function extractFed76Items():void {
        try {
            if (!isSfeDefined()) {
                ShowHUDMessage("SFE cannot be found. Items extraction cancelled.");
                return;
            }
            ShowHUDMessage("Starting extracting items!");
            var itemsModIni:Object = {};
            itemsModIni.characterInventories = {};
            var items:Array = [];
            for each (var item:Object in this.stashInventory) {
                if (item.itemLevel < 45 || !item.isLegendary || !item.isTradable) {
                    continue;
                }
                var itemToStore:Object = {};
                itemToStore.itemLevel = item.itemLevel;
                itemToStore.text = item.text;
                itemToStore.isLegendary = item.isLegendary;
                itemToStore.isTradable = item.isTradable;
                itemToStore.vendingData = item.vendingData;
                itemToStore.ItemCardEntries = item.ItemCardEntries;
                itemToStore.filterFlag = item.filterFlag;
                itemToStore.itemValue = item.itemValue;
                itemToStore.numLegendaryStars = item.numLegendaryStars;
                items.push(itemToStore);
            }
            itemsModIni.characterInventories['test'] = items;
            itemsModIni.modName = FED_MOD_NAME;
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
            } else {
                ShowHUDMessage("Cannot find SFE, writing to file cancelled!");
            }
        } catch (e:Error) {
            ShowHUDMessage("Error saving items! " + e);
        }
    }

    public static function ShowHUDMessage(text:String):void {
        GlobalFunc.ShowHUDMessage("[" + MOD_NAME + " v" + VERSION + "] " + text);
    }
}
}