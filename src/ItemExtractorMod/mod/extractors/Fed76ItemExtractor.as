package extractors {
public class Fed76ItemExtractor extends BaseItemExtractor {

    public static const VERSION:Number = 0.6;
    public static const MOD_NAME:String = "Fed76Enhancer";

    override public function buildOutputObject():Object {
        var itemsModIni:Object = super.buildOutputObject();
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

    public function Fed76ItemExtractor(value:Object) {
        super(value, MOD_NAME, VERSION);
    }
}
}