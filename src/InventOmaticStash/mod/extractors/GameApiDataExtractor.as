package extractors {
import Shared.AS3.Data.BSUIDataManager;
import Shared.AS3.Events.CustomEvent;

public class GameApiDataExtractor {
    public static const EVENT_TRANSFER_ITEM:String = "Container::TransferItem";
    public static const EVENT_INSPECT_ITEM:String = "Container::InspectItem";
    public static const EVENT_ITEM_SELECTED:String = "SecureTrade::OnItemSelected";
    public static var PlayerInventoryData:String = "PlayerInventoryData";
    public static var CharacterInfoData:String = "CharacterInfoData";
    public static var AccountInfoData:String = "AccountInfoData";
    public static var InventoryItemCardData:String = "InventoryItemCardData";
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
        "WorkshopStateData",
        "WorkshopBudgetData",
        "WorkshopButtonBarData",
        "WorkshopCategoryData",
        "WorkshopConfigData",
        "WorkshopItemCardData",
        "WorkshopMessageData",
        "OtherInventoryTypeData",
        "OtherInventoryData",
        "MyOffersData",
        "TheirOffersData",
        "ContainerOptionsData",
        "CampVendingOfferData",
        "FireForgetEvent"
        // IGNORED FIELDS
//        "InventoryItemCardData"
//        "PlayerInventoryData",
//        "CharacterInfoData",
//        "AccountInfoData"
    ];

    public static function getFullApiData(array:Array):Object {
        var gameApiData:Object = {};
        if (array == null || array.length < 1) {
            array = GAME_API_METHODS;
        }
        array.forEach(function (apiMethodName:String):void {
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

    public static function getInventoryItemCardData():Object {
        return getApiData(InventoryItemCardData);
    }

    public static function inspectItem(serverHandleId:Number, fromContainer:Boolean):void {
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_INSPECT_ITEM, {
            "serverHandleId": serverHandleId,
            "fromContainer": fromContainer
        }));
    }

    public static function selectItem(serverHandleId:Number, fromContainer:Boolean):void {
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_ITEM_SELECTED, {
            "serverHandleId": serverHandleId,
            "isSelectionValid": true,
            "fromContainer": fromContainer
        }));
    }

    public static function subscribeInventoryItemCardData(callback:Function):void {
        BSUIDataManager.Subscribe(InventoryItemCardData, callback);
    }

    // fromContainer = true, means moving items from pipboy to container
    public static function transferItem(item:Object, fromContainer:Boolean = false):void {
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM, {
            "serverHandleId": item.serverHandleId,
            "quantity": item.count,
            "fromContainer": fromContainer
        }));
    }
}
}