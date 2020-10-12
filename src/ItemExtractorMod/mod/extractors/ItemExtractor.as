package extractors {
public class ItemExtractor extends BaseItemExtractor {

    public static const VERSION:Number = 0.6;
    public static const MOD_NAME:String = "ItemExtractorMod";

    private var _verboseOutput:Boolean = false;

    override public function buildOutputObject():Object {
        var itemsModIni:Object = super.buildOutputObject();
        itemsModIni.characterInventories = {};
        var CharacterInfoData:Object = GameApiDataExtractor.getCharacterInfoData();
        var AccountInfoData:Object = GameApiDataExtractor.getAccountInfoData();

        var characterInventory:Object = {};
        characterInventory.playerInventory = this.playerInventory;
        characterInventory.stashInventory = this.stashInventory;
        characterInventory.AccountInfoData = AccountInfoData;
        characterInventory.CharacterInfoData = CharacterInfoData;
        if (_verboseOutput) {
            characterInventory.fullGameData = GameApiDataExtractor.getFullApiData();
        }

        itemsModIni.characterInventories[CharacterInfoData.name] = characterInventory;
        return itemsModIni;
    }

    public function set verboseOutput(value:Boolean):void {
        _verboseOutput = value;
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