package extractors {
public class ItemExtractor extends BaseItemExtractor {

    public static const MOD_NAME:String = "Invent-O-Matic-Extractor";

    public override function buildOutputObject():Object {
        var outputObject:Object = super.buildOutputObject();

        var charData:Object = GameApiDataExtractor.getCharacterInfoData();
        var acData:Object = GameApiDataExtractor.getAccountInfoData();

        var characterInventory:Object = {};
        characterInventory.playerInventory = this.playerInventory;
        characterInventory.stashInventory = this.stashInventory;
        characterInventory.AccountInfoData = acData.name;
        characterInventory.CharacterInfoData = charData.name;

        if (_verboseOutput) {
            characterInventory.fullGameData = GameApiDataExtractor.getFullApiData(this._apiMethods);
        }

        outputObject.characterInventories = {};
        outputObject.characterInventories[charData.name] = characterInventory
        return outputObject;
    }

    public function ItemExtractor(value:Object) {
        super(value, MOD_NAME, Version.ITEM_EXTRACTOR);
    }

    override public function isValidMode(menuMode:uint):Boolean {
        return true;
    }

    override public function getInvalidModeMessage():String {
        return "Please, use this function only in your stash box.";
    }
}
}