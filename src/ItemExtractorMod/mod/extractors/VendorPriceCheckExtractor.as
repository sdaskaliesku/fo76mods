package extractors {
public class VendorPriceCheckExtractor extends BaseItemExtractor {

    public static const VERSION:Number = 0.6;
    public static const MOD_NAME:String = "VendorPriceCheck";

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

    override public function isValidMode(menuMode:uint):Boolean {
        return menuMode === MODE_PLAYERVENDING
                || menuMode === MODE_NPCVENDING
                || menuMode === MODE_VENDING_MACHINE;
    }

    override public function getInvalidModeMessage():String {
        return "Please, use this function only in player's vendor!";
    }

    public function VendorPriceCheckExtractor(value:Object) {
        super(value, MOD_NAME, VERSION);
    }
}
}