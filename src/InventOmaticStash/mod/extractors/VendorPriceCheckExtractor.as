package extractors {
import Shared.AS3.SecureTradeShared;

import flash.display.MovieClip;
import flash.utils.setTimeout;

public class VendorPriceCheckExtractor extends BaseItemExtractor {

    public static const MOD_NAME:String = "Invent-O-Matic-Vendor-Extractor";

    override public function buildOutputObject():Object {
        var itemsModIni:Object = super.buildOutputObject();
        itemsModIni.characterInventories = {};
        var characterInventory:Object = {};
        var items:Array = [];
        for each (var item:Object in this.stashInventory) {
            item.serverHandleId = -1;
            items.push(item);
        }
        characterInventory.stashInventory = items;
        characterInventory.AccountInfoData = {};
        characterInventory.CharacterInfoData = {};
        itemsModIni.characterInventories['priceCheck'] = characterInventory;
        return itemsModIni;
    }

    public override function setInventory(parent:MovieClip):void {
        if (!isSfeDefined()) {
            ShowHUDMessage('SFE cannot be found. Items extraction cancelled.');
            return;
        }
        ShowHUDMessage("Starting gathering items data from stash!");
        var delay:Number = populateItemCards(parent, parent.OfferInventory_mc, true,
                stashInventory);
        setTimeout(function ():void {
            populateItemCardEntries(stashInventory);
            extractItems();
        }, delay);
    }

    override public function isValidMode(menuMode:uint):Boolean {
        return menuMode === SecureTradeShared.MODE_PLAYERVENDING
                || menuMode === SecureTradeShared.MODE_NPCVENDING
                || menuMode === SecureTradeShared.MODE_VENDING_MACHINE;
    }

    override public function getInvalidModeMessage():String {
        return "Please, use this function only in player's vendor!";
    }

    public function VendorPriceCheckExtractor(value:Object) {
        super(value, MOD_NAME, Version.VENDOR);
    }
}
}