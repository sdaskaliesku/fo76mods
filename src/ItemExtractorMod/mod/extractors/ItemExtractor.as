package extractors {
import Shared.AS3.Data.BSUIDataManager;

public class ItemExtractor extends BaseItemExtractor {

    public static const VERSION:Number = 0.6;
    public static const MOD_NAME:String = "ItemExtractorMod";

    override public function buildOutputObject():Object {
        var itemsModIni:Object = super.buildOutputObject();
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
        return itemsModIni;
    }

    public function ItemExtractor(value:Object) {
        super(value, MOD_NAME, VERSION);
    }

    override public function isValidMode(menuMode:uint):Boolean {
        return menuMode === MODE_CONTAINER;
    }

    override public function getInvalidModeMessage():String {
        return "Please, use this function only in your stash box.";
    }
}
}