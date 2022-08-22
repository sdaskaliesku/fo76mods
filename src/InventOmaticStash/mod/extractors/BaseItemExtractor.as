package extractors {
import Shared.AS3.Data.FromClientDataEvent;
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONDecoder;
import com.adobe.serialization.json.JSONEncoder;

import flash.display.MovieClip;
import flash.utils.setTimeout;

import utils.Logger;

public class BaseItemExtractor {

    protected var secureTrade:Object;
    protected var playerInventory:Array = [];
    protected var stashInventory:Array = [];
    protected var version:Number;
    protected var modName:String;
    protected static var itemCardEntries:Object = {};
    protected static var DEFAULT_DELAY:Number = 1000;
    protected static var ITEM_CARD_ENTRY_DELAY_STEP:Number = 100;
    protected var _verboseOutput:Boolean = false;
    protected var _apiMethods:Array = [];
    protected var _additionalItemDataForAll:Boolean = false;
    protected var _modNameToUse:String;

    public function BaseItemExtractor(
            secureTrade:Object, modName:String, version:Number) {
        this.secureTrade = secureTrade;
        this.modName = modName;
        this.version = version;
        this._modNameToUse = modName;
        GameApiDataExtractor.subscribeInventoryItemCardData(onInventoryItemCardDataUpdate);
    }

    public function getExtractorName():String {
        return modName + ' v' + version;
    }

    public function setInventory(parent:MovieClip):void {
        if (!isSfeDefined()) {
            ShowHUDMessage('SFE cannot be found. Items extraction cancelled.');
            return;
        }
        ShowHUDMessage("Starting gathering items data from inventory!");
        var delay:Number = populateItemCards(parent, parent.PlayerInventory_mc, false,
                playerInventory);
        setTimeout(function ():void {
            ShowHUDMessage("Starting gathering items data from stash!");
            var delay2:Number = populateItemCards(parent, parent.OfferInventory_mc, true,
                    stashInventory);
            setTimeout(function ():void {
                ShowHUDMessage("Building output object...");
                try {
                    populateItemCardEntries(playerInventory);
                    populateItemCardEntries(stashInventory);
                    extractItems();
                } catch (e:Error) {
                    ShowHUDMessage("Error building output object " + e);
                }
            }, delay2);

        }, delay);
    }

    protected function populateItemCardEntries(inventory:Array):void {
        inventory.forEach(function (item:Object):void {
            if (itemCardEntries[item.serverHandleId]) {
                item.ItemCardEntries = itemCardEntries[item.serverHandleId].itemCardEntries;
            }
        });
    }

    protected function populateItemCards(parent:MovieClip, inventory:SecureTradeInventory,
            fromContainer:Boolean, output:Array):Number {
        var inv:Array = inventory.ItemList_mc.List_mc.MenuListData;
        var delay:Number = ITEM_CARD_ENTRY_DELAY_STEP;
        inv.forEach(function (item:Object):void {
            item.ItemCardEntries = [];
            if (item.isLegendary || _additionalItemDataForAll) {
                setTimeout(function ():void {
                    try {
                        parent.selectedList = inventory;
                        inventory.Active = true;
                        GameApiDataExtractor.selectItem(item.serverHandleId, fromContainer);
                        var itemCardData:Object = clone(
                                GameApiDataExtractor.getInventoryItemCardData());
                        itemCardEntries[itemCardData.serverHandleId] = itemCardData;
                        output.push(item);
                    } catch (e:Error) {
                        Logger.get().errorHandler("Error getting data for item " + item.text, e)
                    }
                }, delay);
                delay += ITEM_CARD_ENTRY_DELAY_STEP;
            } else {
                output.push(item);
            }
        });
        return delay + DEFAULT_DELAY;
    }

    private function clone(object:Object):Object {
        try {
            var str:String = toString(object);
            return new JSONDecoder(str, true).getValue();
        } catch (e:Error) {
            ShowHUDMessage("Error cloning object: " + e)
        }
        return {};
    }

    public function extractItems():void {
        try {
            if (!isSfeDefined()) {
                ShowHUDMessage('SFE cannot be found. Items extraction cancelled.');
                return;
            }
            ShowHUDMessage('Starting extracting items!');
            var itemsModIni:Object = buildOutputObject();
            writeData(toString(itemsModIni));
        } catch (e:Error) {
            ShowHUDMessage('Error extracting items(core): ' + e);
        }
    }

    public function set apiMethods(value:Array):void {
        _apiMethods = value;
    }

    public function set additionalItemDataForAll(value:Boolean):void {
        _additionalItemDataForAll = value;
    }

    public function set verboseOutput(value:Boolean):void {
        _verboseOutput = value;
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
        return this.secureTrade._sfeObj != null && this.secureTrade._sfeObj.call != null;
    }

    protected function writeData(data:String):void {
        try {
            if (isSfeDefined()) {
                this.secureTrade._sfeObj.call('writeItemsModFile', data);
                ShowHUDMessage('Done saving items!', true);
            } else {
                ShowHUDMessage('Cannot find SFE, writing to file cancelled!');
            }
        } catch (e:Error) {
            ShowHUDMessage('Error saving items! ' + e);
        }
    }

    public function ShowHUDMessage(text:String, force:Boolean = false):void {
        if (_verboseOutput || force) {
            GlobalFunc.ShowHUDMessage('[' + modName + ' v' + version + '] ' + text);
        }
    }

    public function isValidMode(menuMode:uint):Boolean {
        return false;
    }

    public function getInvalidModeMessage():String {
        return 'Invalid mode';
    }

    public function showInvalidModeMessage():void {
        this.ShowHUDMessage(getInvalidModeMessage());
    }

    private function onInventoryItemCardDataUpdate(eventData:FromClientDataEvent):void {
        var data:Object = eventData.data;
        itemCardEntries[data.serverHandleId] = clone(data);
    }
}
}