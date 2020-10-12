package extractors {
import Shared.AS3.Data.BSUIDataManager;

internal class GameApiDataExtractor {
    public static var PlayerInventoryData:String = "PlayerInventoryData";
    public static var CharacterInfoData:String = "CharacterInfoData";
    public static var AccountInfoData:String = "AccountInfoData";
    private static var GAME_API_METHODS:Array = [
        "FriendsContextMenuData",
        "StoreCategoryData",
        "StoreAtomPackData",
        "PerkCardGameModeFilterUIData",
        "ChallengeCompleteData",
        "StoreMenuData",
        "ChallengeTrackerUpdateData",
        "HUDModeData",
        "QuestTrackerData",
        "FanfareData",
        "CurrencyData",
        "MapMenuData",
        "ScoreboardFilterData",
        "ControlMapData",
        "ReputationData",
        "PerksUIData",
        "LegendaryPerksMenuData",
        "BabylonAvailableMapsData",
        "HUDMessageProvider",
        "CardPacksUIData",
        "BabylonUIData",
        "PurchaseCompleteData",
        "SeasonWidgetData",
        "LoginInfoData",
        "LoginResponseData",
        "HubMenuShuttle",
        "WorkshopStateData"
        // IGNORED FIELDS
//        "PlayerInventoryData",
//        "CharacterInfoData",
//        "AccountInfoData"
    ];

    public static function getFullApiData():Object {
        var gameApiData:Object = {};
        GAME_API_METHODS.forEach(function (apiMethodName:String):void {
            gameApiData[apiMethodName] = getApiData(apiMethodName);
        });
        return gameApiData;
    }

    public static function getApiData(input:String):Object {
        try {
            return BSUIDataManager.GetDataFromClient(input).data;
        } catch (e:Error) {

        }
        return {
            message: "Error extracting data for " + input
        };
    }

    public static function getAccountInfoData():Object {
        return getApiData(AccountInfoData);
    }

    public static function getCharacterInfoData():Object {
        return getApiData(CharacterInfoData);
    }
}
}