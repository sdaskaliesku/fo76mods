 
package
{
   import Shared.AS3.BCBasicModal;
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.AS3.IMenu;
   import Shared.AS3.QuantityMenu;
   import Shared.AS3.SWFLoaderClip;
   import Shared.AS3.SecureTradeShared;
   import Shared.AS3.StyleSheet;
   import Shared.AS3.Styles.SecureTrade_ContainerListStyle;
   import Shared.AS3.Styles.SecureTrade_ItemCardStyle;
   import Shared.AS3.Styles.SecureTrade_PlayerListStyle;
   import Shared.GlobalFunc;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class SecureTrade extends IMenu
   {
      
      public static var time:Number = // method body index: 1326 method index: 1326
      0;
      
      public static var delta:Number = // method body index: 1326 method index: 1326
      0;
      
      private static const MODE_CONTAINER:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_CONTAINER;
      
      private static const MODE_PLAYERVENDING:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_PLAYERVENDING;
      
      private static const MODE_NPCVENDING:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_NPCVENDING;
      
      private static const MODE_VENDING_MACHINE:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_VENDING_MACHINE;
      
      private static const MODE_DISPLAY_CASE:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_DISPLAY_CASE;
      
      private static const MODE_FERMENTER:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_FERMENTER;
      
      private static const MODE_REFRIGERATOR:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_REFRIGERATOR;
      
      private static const MODE_CAMP_DISPENSER:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_CAMP_DISPENSER;
      
      private static const MODE_ALLY:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_ALLY;
      
      private static const MODE_INVALID:uint = // method body index: 1326 method index: 1326
      SecureTradeShared.MODE_INVALID;
      
      public static const EVENT_MENU_EXIT:String = // method body index: 1326 method index: 1326
      "SecureTrade::ExitMenu";
      
      public static const EVENT_REQUEST_SORT:String = // method body index: 1326 method index: 1326
      "SecureTrade::SortList";
      
      public static const EVENT_REQUEST_PURCHASE:String = // method body index: 1326 method index: 1326
      "SecureTrade::RequestPurchase";
      
      public static const EVENT_DECLINE_ITEM:String = // method body index: 1326 method index: 1326
      "SecureTrade::DeclineItem";
      
      public static const EVENT_CREATE_OFFER:String = // method body index: 1326 method index: 1326
      "SecureTrade::CreateOffer";
      
      public static const EVENT_REMOVE_ITEM:String = // method body index: 1326 method index: 1326
      "SecureTrade::RemoveItem";
      
      public static const EVENT_ITEM_SELECTED:String = // method body index: 1326 method index: 1326
      "SecureTrade::OnItemSelected";
      
      public static const EVENT_UPGRADE_STASH:String = // method body index: 1326 method index: 1326
      "SecureTrade::UpgradeStash";
      
      public static const EVENT_REQUEST_ITEM:String = // method body index: 1326 method index: 1326
      "SecureTrade::RequestItem";
      
      public static const EVENT_CANCEL_REQUEST_ITEM:String = // method body index: 1326 method index: 1326
      "SecureTrade::CancelRequestItem";
      
      public static const EVENT_NPC_BUY_ITEM:String = // method body index: 1326 method index: 1326
      "NPCVend::BuyItem";
      
      public static const EVENT_NPC_SELL_ITEM:String = // method body index: 1326 method index: 1326
      "NPCVend::SellItem";
      
      public static const EVENT_TRANSFER_ITEM:String = // method body index: 1326 method index: 1326
      "Container::TransferItem";
      
      public static const EVENT_TAKE_ALL:String = // method body index: 1326 method index: 1326
      "Container::TakeAll";
      
      public static const EVENT_INSPECT_ITEM:String = // method body index: 1326 method index: 1326
      "Container::InspectItem";
      
      public static const EVENT_STORE_ALL_JUNK:String = // method body index: 1326 method index: 1326
      "Workbench::StoreAllJunk";
      
      public static const EVENT_CAMP_SELL_ITEM:String = // method body index: 1326 method index: 1326
      "CampVend::SellItem";
      
      public static const EVENT_CAMP_DISPLAY_ITEM:String = // method body index: 1326 method index: 1326
      "CampVend::DisplayItem";
      
      public static const EVENT_CAMP_BUY_ITEM:String = // method body index: 1326 method index: 1326
      "CampVend::BuyItem";
      
      public static const EVENT_CAMP_REMOVE_ITEM:String = // method body index: 1326 method index: 1326
      "CampVend::RemoveItem";
      
      public static const EVENT_CAMP_DISPLAY_DECORATE_ITEM_IN_SLOT:String = // method body index: 1326 method index: 1326
      "CampDecorate::DisplayDecorateItemInSlot";
      
      public static const EVENT_CAMP_REMOVE_DECORATE_ITEM_IN_SLOT:String = // method body index: 1326 method index: 1326
      "CampDecorate::RemoveDecorateItemInSlot";
      
      public static const EVENT_TRANSFER_TOO_HEAVY_ERROR:String = // method body index: 1326 method index: 1326
      "SecureTrade::TransferTooHeavyError";
      
      public static const EVENT_CAMP_STOP_ITEM_PROCESSING:String = // method body index: 1326 method index: 1326
      "CampVend::StopItemProcessing";
      
      public static const EVENT_SELL_FAVORITE_DECLINED:String = // method body index: 1326 method index: 1326
      "NPCVend::SellFavoriteItemDeclined";
      
      public static const EVENT_TRADE_FAVORITE_DECLINED:String = // method body index: 1326 method index: 1326
      "PlayerVend::TradeFavoriteItemDeclined";
      
      public static const SOF_ALPHABETICALLY:int = // method body index: 1326 method index: 1326
      0;
      
      public static const SOF_DAMAGE:int = // method body index: 1326 method index: 1326
      1;
      
      public static const SOF_ROF:int = // method body index: 1326 method index: 1326
      2;
      
      public static const SOF_RANGE:int = // method body index: 1326 method index: 1326
      3;
      
      public static const SOF_ACCURACY:int = // method body index: 1326 method index: 1326
      4;
      
      public static const SOF_VALUE:int = // method body index: 1326 method index: 1326
      5;
      
      public static const SOF_WEIGHT:int = // method body index: 1326 method index: 1326
      6;
      
      public static const SOF_SPOILAGE:int = // method body index: 1326 method index: 1326
      7;
      
      public static const MAX_SELL_PRICE:int = // method body index: 1326 method index: 1326
      30000;
      
      public static const FILTER_OPTION_NONE:int = // method body index: 1326 method index: 1326
      0;
      
      public static const FILTER_OPTION_THIS_MACHINE:int = // method body index: 1326 method index: 1326
      1;
      
      public static const FILTER_OPTION_THIS_MACHINE_AND_STASH:int = // method body index: 1326 method index: 1326
      2;
      
      public static const FILTER_OPTION_COUNT:int = // method body index: 1326 method index: 1326
      3;
      
      private static const STARTING_FOCUS_PREF_NONE:uint = // method body index: 1326 method index: 1326
      0;
      
      private static const STARTING_FOCUS_PREF_PLAYER:uint = // method body index: 1326 method index: 1326
      1;
      
      private static const STARTING_FOCUS_PREF_CONTAINER:uint = // method body index: 1326 method index: 1326
      2;
      
      public static const REFRESH_SELECTION_NONE:int = // method body index: 1326 method index: 1326
      0;
      
      public static const REFRESH_SELECTION_SERVER_ID:int = // method body index: 1326 method index: 1326
      1;
      
      public static const REFRESH_SELECTION_NAME_COUNT:int = // method body index: 1326 method index: 1326
      2;
      
      public static const HEIGHT_BUFFER:uint = // method body index: 1326 method index: 1326
      250;
       
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var PlayerInventory_mc:SecureTradePlayerInventory;
      
      public var OfferInventory_mc:SecureTradeOfferInventory;
      
      public var SlotInfo_mc:SecureTradeSlotInfo;
      
      public var ItemCardContainer_mc:MovieClip;
      
      public var ModalSetQuantity_mc:QuantityMenu;
      
      public var ModalSetPrice_mc:QuantityMenu;
      
      public var ModalDeclineItem_mc:SecureTradeDeclineItemModal;
      
      public var ItemPreview_mc:MovieClip;
      
      public var ModalConfirmPurchase_mc:BCBasicModal;
      
      public var ModalConfirmTakeAll_mc:BCBasicModal;
      
      public var ModalConfirmScrap_mc:SecureTradeScrapConfirmModal;
      
      public var CategoryBar_mc:LabelSelector;
      
      public var Header_mc:MovieClip;
      
      public var ModalUpgradeStash_mc:BCBasicModal;
      
      private var _OnQuantityConfirmedFn:Function = null;
      
      private var _OnSetPriceConfirmedFn:Function = null;
      
      private var ButtonPlayerInventory:BSButtonHintData;
      
      private var ButtonContainerInventory:BSButtonHintData;
      
      private var ButtonDecline:BSButtonHintData;
      
      private var ButtonToggleAssign:BSButtonHintData;
      
      private var ButtonOffersOnly:BSButtonHintData;
      
      private var InspectButton:BSButtonHintData;
      
      private var ScrapButton:BSButtonHintData;
      
      private var TakeAllButton:BSButtonHintData;
      
      private var StoreJunkButton:BSButtonHintData;
      
      private var SortButton:BSButtonHintData;
      
      private var ExitButton:BSButtonHintData;
      
      private var AcceptButton:BSButtonHintData;
      
      private var DeclineItemAcceptButton:BSButtonHintData;
      
      private var DeclineItemCancelButton:BSButtonHintData;
      
      private var UpgradeStashButton:BSButtonHintData;
      
      private var ToggleShowMarkedItemsOnlyButton:BSButtonHintData;
      
      private var ButtonHintDataV:Vector.<BSButtonHintData>;
      
      private const NO_FILTER_ID:int = -1;
      
      private const SCRAP_ITEM_COUNT_THRESHOLD:uint = 5;
      
      private const TRANSFER_ITEM_COUNT_THRESHOLD:uint = 4;
      
      private const WEAPONS_TAB_INDEX = 2;
      
      private const PLAYERVENDING_WEAPONS_TAB_INDEX = 1;
      
      private const JUNK_TAB_INDEX = 8;
      
      private var m_IsOpen:Boolean = false;
      
      private var m_PreviousFocus:InteractiveObject;
      
      private var m_ItemFilters:Array;
      
      private var m_SelectedList:SecureTradeInventory;
      
      private var m_TabMax = 0;
      
      private var m_TabMin = 0;
      
      private var m_SelectedTab:int = 0;
      
      private var m_SelectedTabForceChange:Boolean = false;
      
      private var m_MenuMode:uint = 4.294967295E9;
      
      private var m_SubMenuMode:uint = 0;
      
      private var m_CurrencyType:uint = 4.294967295E9;
      
      private var m_DefaultHeaderText:String = "$CONTAINER";
      
      private var m_AcceptBtnText_Player:String = "$STORE";
      
      private var m_AcceptBtnText_Player_Assign:String = "$Assign";
      
      private var m_AcceptBtnText_Container:String = "$TAKE";
      
      private var m_TakeAllBtnText:String = "$TAKE ALL";
      
      private var m_scrapAllowedFlag:uint = 0;
      
      private var m_playerHasMiscItems:Boolean = false;
      
      private var m_playerHasAutoScrappableJunkItems:Boolean = false;
      
      private var m_isWorkbench:Boolean = false;
      
      private var m_isWorkshop:Boolean = false;
      
      private var m_isCamp:Boolean = false;
      
      private var m_isStash:Boolean = false;
      
      private var m_isLimitedTypeStorage:Boolean = false;
      
      private var m_onlyGivingAllowed:Boolean = false;
      
      private var m_onlyTakingAllowed:Boolean = false;
      
      private var m_SortFieldText:Array;
      
      private var m_PlayerInventorySortField:int = 0;
      
      private var m_OfferInventorySortField:int = 0;
      
      private var m_VendorSellOnly:Boolean = false;
      
      private var m_ModalActive:Boolean = false;
      
      private var m_ContainerEmpty:Boolean = false;
      
      private var m_PlayerInventoryEmpty:Boolean = false;
      
      private var m_TabEventName:String = "";
      
      private var m_PlayerConnected:Boolean = false;
      
      private var m_ProcessingItemEvent:Boolean = false;
      
      private var m_ToolTipDefaultHeight:Number;
      
      private var m_MyOffersData:Array;
      
      private var m_TheirOffersData:Array;
      
      private var m_PlayerInvData:Array;
      
      private var m_OtherInvData:Array;
      
      private var m_ShowOffersOnly:Boolean = false;
      
      private var m_OwnsVendor:Boolean = false;
      
      private var m_ShowPlayerValueEntry:Boolean = true;
      
      private var m_IsFollowerOfZeus:Boolean = false;
      
      private var m_IgnorePlayerVendingItemPress:Boolean = true;
      
      private var m_FilterItemsOption:int = 0;
      
      private var m_StartingFocusPref:int = 2;
      
      private var m_CurrencyIconConfirmPurchase:MovieClip;
      
      private var m_CurrencyIconSetPrice:MovieClip;
      
      private var m_SelectedItemOffered:Boolean = false;
      
      private var m_SelectedStackName:String = "";
      
      private var m_SelectedItemValue:Number = 0;
      
      private var m_SelectedItemCount:Number = 0;
      
      private var m_SelectedItemServerHandleId:Number = 0;
      
      private var m_SelectedItemIsPartialOffer:Boolean = false;
      
      private var m_SelectedItemValueSet:Boolean = false;
      
      private var m_RefreshSelectionOption:int = 0;
      
      public function SecureTrade()
      {
         // method body index: 1347 method index: 1347
         this.ButtonPlayerInventory = new BSButtonHintData("$TransferPlayerLabel","LT","PSN_L2_Alt","Xenon_L2_Alt",1,this.onSwapInventoryPlayer);
         this.ButtonContainerInventory = new BSButtonHintData("$TransferContainerLabel","RT","PSN_R2_Alt","Xenon_R2_Alt",1,this.onSwapInventoryContainer);
         this.ButtonDecline = new BSButtonHintData("$DECLINEITEM","R","PSN_X","Xenon_X",1,this.onDeclineItem);
         this.ButtonToggleAssign = new BSButtonHintData("$REMOVE","R","PSN_X","Xenon_X",1,this.onToggleAssign);
         this.ButtonOffersOnly = new BSButtonHintData("$OFFERSONLY","T","PSN_Y","Xenon_Y",1,this.onOffersOnly);
         this.InspectButton = new BSButtonHintData("$INSPECT","X","PSN_R3","Xenon_R3",1,this.onInspectItem);
         this.ScrapButton = new BSButtonHintData("$SCRAP","Space","PSN_A","Xenon_A",1,this.onScrapButton);
         this.TakeAllButton = new BSButtonHintData("$TAKE ALL","R","PSN_X","Xenon_X",1,this.onTakeAll);
         this.StoreJunkButton = new BSButtonHintData("$StoreAllJunk","T","PSN_Y","Xenon_Y",1,this.onStoreJunk);
         this.SortButton = new BSButtonHintData("$SORT","Q","PSN_L3","Xenon_L3",1,this.onRequestSort);
         this.ExitButton = new BSButtonHintData("$EXIT","TAB","PSN_B","Xenon_B",1,this.onBackButton);
         this.AcceptButton = new BSButtonHintData("$STORE","Space","PSN_A","Xenon_A",1,this.onAccept);
         this.DeclineItemAcceptButton = new BSButtonHintData("$ACCEPT","Space","PSN_A","Xenon_A",1,this.onDeclineItemAccept);
         this.DeclineItemCancelButton = new BSButtonHintData("$CANCEL","TAB","PSN_B","Xenon_B",1,this.onBackButton);
         this.UpgradeStashButton = new BSButtonHintData("$UPGRADE","V","PSN_Select","Xenon_Select",1,this.onUpgradeButton);
         this.ToggleShowMarkedItemsOnlyButton = new BSButtonHintData("","T","PSN_Y","Xenon_Y",1,this.onToggleShowMarkedItemsOnlyButton);
         this.ButtonHintDataV = new <BSButtonHintData>[this.AcceptButton,this.DeclineItemAcceptButton,this.DeclineItemCancelButton,this.ButtonDecline,this.ButtonToggleAssign,this.ScrapButton,this.InspectButton,this.UpgradeStashButton,this.ButtonPlayerInventory,this.ButtonContainerInventory,this.StoreJunkButton,this.TakeAllButton,this.SortButton,this.ButtonOffersOnly,this.ToggleShowMarkedItemsOnlyButton,this.ExitButton];
         this.m_SortFieldText = ["$SORT","$SORT_DMG","$SORT_ROF","$SORT_RNG","$SORT_ACC","$SORT_VAL","$SORT_WT","$SORT_SPL"];
         this.m_MyOffersData = new Array();
         this.m_TheirOffersData = new Array();
         this.m_PlayerInvData = new Array();
         this.m_OtherInvData = new Array();
         super();
         this.ButtonHintBar_mc.useVaultTecColor = true;
         this.m_ItemFilters = new Array();
         StyleSheet.apply(this.PlayerInventory_mc.ItemList_mc,false,SecureTrade_PlayerListStyle);
         StyleSheet.apply(this.OfferInventory_mc.ItemList_mc,false,SecureTrade_ContainerListStyle);
         StyleSheet.apply(this.ItemCardContainer_mc.ItemCard_mc,false,SecureTrade_ItemCardStyle);
         this.PlayerInventory_mc.ItemList_mc.List_mc.textOption_Inspectable = BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT;
         this.OfferInventory_mc.ItemList_mc.List_mc.textOption_Inspectable = BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT;
         this.ButtonHintBar_mc.SetButtonHintData(this.ButtonHintDataV);
         Extensions.enabled = true;
         addEventListener(FocusEvent.FOCUS_OUT,this.onFocusChange);
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         addEventListener(BSScrollingList.ITEM_PRESS,this.onItemPress);
         this.PlayerInventory_mc.ItemList_mc.List_mc.addEventListener(BSScrollingList.SELECTION_CHANGE,this.onSelectedDataChanged);
         this.OfferInventory_mc.ItemList_mc.List_mc.addEventListener(BSScrollingList.SELECTION_CHANGE,this.onSelectedDataChanged);
         addEventListener(BSScrollingList.PLAY_FOCUS_SOUND,this.onUserMovesListSelection);
         addEventListener(SecureTradeInventory.MOUSE_OVER,this.onListMouseOver);
         addEventListener(QuantityMenu.CONFIRM,this.onQuantityConfirm);
         addEventListener(QuantityMenu.CANCEL,this.onQuantityCancel);
         addEventListener(SecureTradeDeclineItemModal.CONFIRM,this.onDeclineItemConfirm);
         addEventListener(BCBasicModal.EVENT_CONFIRM,this.onConfirmModalConfirm);
         addEventListener(BCBasicModal.EVENT_CANCEL,this.onConfirmModalCancel);
         addEventListener(LabelSelector.LABEL_MOUSE_SELECTION_EVENT,this.OnLabelMouseSelection);
         addEventListener(SecureTradeScrapConfirmModal.EVENT_CLOSED,this.OnSecureTradeScrapConfirmModalClosed);
         this.m_ToolTipDefaultHeight = this.ModalConfirmPurchase_mc.Tooltip_mc.textField.height;
         this.ModalConfirmPurchase_mc.choiceButtonMode = BCBasicModal.BUTTON_MODE_LIST;
         this.ModalConfirmTakeAll_mc.choiceButtonMode = BCBasicModal.BUTTON_MODE_LIST;
         var currencyIconTemp:SWFLoaderClip = this.ModalConfirmPurchase_mc.Value_mc.Icon_mc;
         currencyIconTemp.clipWidth = currencyIconTemp.width * (1 / currencyIconTemp.scaleX);
         currencyIconTemp.clipHeight = currencyIconTemp.height * (1 / currencyIconTemp.scaleY);
         currencyIconTemp = this.ModalSetPrice_mc.Value_mc.Icon_mc;
         currencyIconTemp.clipWidth = currencyIconTemp.width * (1 / currencyIconTemp.scaleX);
         currencyIconTemp.clipHeight = currencyIconTemp.height * (1 / currencyIconTemp.scaleY);
      }
      
      public function set currencyType(aType:uint) : void
      {
         // method body index: 1327 method index: 1327
         this.m_CurrencyType = aType;
         PlayerListEntry.currencyType = this.m_CurrencyType;
         OfferListEntry.currencyType = this.m_CurrencyType;
         this.PlayerInventory_mc.SetIsDirty();
         this.PlayerInventory_mc.ItemList_mc.SetIsDirty();
         this.OfferInventory_mc.SetIsDirty();
         this.OfferInventory_mc.ItemList_mc.SetIsDirty();
         if(this.m_CurrencyIconConfirmPurchase != null)
         {
            this.ModalConfirmPurchase_mc.Value_mc.Icon_mc.removeChild(this.m_CurrencyIconConfirmPurchase);
            this.m_CurrencyIconConfirmPurchase = null;
         }
         if(this.m_CurrencyIconSetPrice != null)
         {
            this.ModalSetPrice_mc.Value_mc.Icon_mc.removeChild(this.m_CurrencyIconSetPrice);
            this.m_CurrencyIconSetPrice = null;
         }
         this.m_CurrencyIconConfirmPurchase = SecureTradeShared.setCurrencyIcon(this.ModalConfirmPurchase_mc.Value_mc.Icon_mc,this.m_CurrencyType);
         this.m_CurrencyIconSetPrice = SecureTradeShared.setCurrencyIcon(this.ModalSetPrice_mc.Value_mc.Icon_mc,this.m_CurrencyType);
         this.ModalConfirmPurchase_mc.Value_mc.Icon_mc.gotoAndStop(this.m_CurrencyType == SecureTradeShared.CURRENCY_LEGENDARY_TOKENS?"LTokens":"Caps");
         this.ModalSetPrice_mc.Value_mc.Icon_mc.gotoAndStop(this.m_CurrencyType == SecureTradeShared.CURRENCY_LEGENDARY_TOKENS?"unselectedLToken":"unselected");
      }
      
      public function get isScrapStash() : Boolean
      {
         // method body index: 1328 method index: 1328
         return this.m_isLimitedTypeStorage;
      }
      
      public function get currencyType() : uint
      {
         // method body index: 1329 method index: 1329
         return this.m_CurrencyType;
      }
      
      private function isCampVendingMenuType() : Boolean
      {
         // method body index: 1330 method index: 1330
         return SecureTradeShared.IsCampVendingMenuType(this.m_MenuMode);
      }
      
      private function updateOfferWeightDisplay() : void
      {
         // method body index: 1331 method index: 1331
         this.OfferInventory_mc.showCarryWeight = !this.isScrapStash && (this.m_MenuMode == MODE_CONTAINER || this.isCampVendingMenuType());
      }
      
      public function set menuMode(aMode:uint) : void
      {
         // method body index: 1332 method index: 1332
         this.m_MenuMode = aMode;
         PlayerListEntry.showCurrency = this.m_MenuMode != MODE_CONTAINER;
         PlayerListEntry.menuMode = aMode;
         OfferListEntry.menuMode = aMode;
         this.OfferInventory_mc.menuMode = this.m_MenuMode;
         this.updateOfferInventoryTooltipVis();
         this.PlayerInventory_mc.showTooltip = this.m_MenuMode == MODE_PLAYERVENDING;
         this.updateCategoryBar();
         this.CategoryBar_mc.SelectedID = this.NO_FILTER_ID;
         this.m_SelectedTabForceChange = true;
         this.selectedTab = 0;
         switch(this.m_MenuMode)
         {
            case MODE_CONTAINER:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$CONTAINER");
               this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
               break;
            case MODE_NPCVENDING:
            case MODE_VENDING_MACHINE:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$VENDOR");
               this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
               break;
            case MODE_PLAYERVENDING:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$TRADING");
               this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
               break;
            case MODE_DISPLAY_CASE:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$DISPLAY");
               this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
               break;
            case MODE_FERMENTER:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$FERMENTER");
               this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
               break;
            case MODE_REFRIGERATOR:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$REFRIGERATOR");
               this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
               break;
            case MODE_CAMP_DISPENSER:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$DISPENSER");
               this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
               break;
            case MODE_ALLY:
               GlobalFunc.SetText(this.Header_mc.HeaderText_tf,"$ALLY");
               this.ItemCardContainer_mc.gotoAndStop("ItemStatsOff");
         }
         this.updateHeaders();
         this.updateSelfInventory();
         this.updateOtherInventory();
      }
      
      public function set subMenuMode(aMode:uint) : void
      {
         // method body index: 1333 method index: 1333
         this.m_SubMenuMode = aMode;
         this.OfferInventory_mc.subMenuMode = this.m_SubMenuMode;
         this.updateCategoryBar();
         this.OfferInventory_mc.showTooltip = this.m_SubMenuMode != SecureTradeShared.SUB_MODE_STANDARD;
      }
      
      public function updateOfferInventoryTooltipVis() : void
      {
         // method body index: 1334 method index: 1334
         this.OfferInventory_mc.showTooltip = this.m_MenuMode == MODE_PLAYERVENDING || this.m_MenuMode == MODE_CONTAINER || this.isCampVendingMenuType();
      }
      
      public function set selectedTab(aFilter:int) : void
      {
         // method body index: 1335 method index: 1335
         var otherList:SecureTradeInventory = null;
         if(aFilter != this.m_SelectedTab || this.m_SelectedTabForceChange)
         {
            this.m_SelectedTabForceChange = false;
            if(aFilter < this.m_TabMin)
            {
               aFilter = this.m_TabMin;
            }
            else if(aFilter >= this.m_TabMax)
            {
               aFilter = this.m_TabMax - 1;
            }
            this.m_SelectedTab = aFilter;
            if(this.m_SelectedTab == aFilter)
            {
               this.updateHeaders();
               this.PlayerInventory_mc.ItemList_mc.List_mc.filterer.itemFilter = this.m_ItemFilters[this.m_SelectedTab].flag;
               this.OfferInventory_mc.ItemList_mc.List_mc.filterer.itemFilter = this.m_ItemFilters[this.m_SelectedTab].flag;
               this.updateSelfInventory();
               this.OfferInventory_mc.ItemList_mc.SetIsDirty();
               this.m_ContainerEmpty = this.OfferInventory_mc != null && this.IsInventoryEmpty(this.OfferInventory_mc);
               this.updateInventoryFocus();
               this.updateButtonHints();
            }
            otherList = this.selectedList == this.PlayerInventory_mc?this.OfferInventory_mc:this.PlayerInventory_mc;
            if(this.selectedList != null)
            {
               this.selectedList.selectedItemIndex = !!this.IsInventoryEmpty(this.selectedList)?Number(-1):Number(this.selectedList.ItemList_mc.List_mc.filterer.ClampIndex(0));
            }
            if(otherList != null)
            {
               otherList.selectedItemIndex = -1;
            }
         }
      }
      
      public function get selectedTab() : int
      {
         // method body index: 1336 method index: 1336
         return this.m_SelectedTab;
      }
      
      public function set isOpen(aOpen:Boolean) : void
      {
         // method body index: 1337 method index: 1337
         if(aOpen != this.m_IsOpen)
         {
            if(aOpen)
            {
               gotoAndPlay("rollOn");
            }
            else
            {
               gotoAndPlay("rollOff");
            }
            this.m_IsOpen = aOpen;
         }
      }
      
      public function get isOpen() : Boolean
      {
         // method body index: 1338 method index: 1338
         return this.m_IsOpen;
      }
      
      public function get selectedListEntry() : Object
      {
         // method body index: 1339 method index: 1339
         return this.m_SelectedList.ItemList_mc.List_mc.selectedEntry;
      }
      
      public function get selectedListIndex() : int
      {
         // method body index: 1340 method index: 1340
         return this.m_SelectedList.ItemList_mc.List_mc.selectedIndex;
      }
      
      private function updateListActive(aCheckList:SecureTradeInventory) : void
      {
         // method body index: 1341 method index: 1341
         var isListSelected:* = this.m_SelectedList == aCheckList;
         aCheckList.Active = isListSelected;
         aCheckList.ItemList_mc.Active = isListSelected;
         aCheckList.ItemList_mc.List_mc.Active = isListSelected;
         aCheckList.ItemList_mc.List_mc.disableInput_Inspectable = !isListSelected;
         if(aCheckList.ItemList_mc.disableSelection_Inspectable)
         {
            aCheckList.ItemList_mc.disableSelection_Inspectable = false;
         }
         if(aCheckList.ItemList_mc.List_mc.hasBeenUpdated)
         {
            if(isListSelected)
            {
               aCheckList.ItemList_mc.setSelectedIndex(0);
            }
            else
            {
               aCheckList.ItemList_mc.setSelectedIndex(-1);
            }
         }
         aCheckList.ItemList_mc.disableSelection_Inspectable = !isListSelected;
      }
      
      public function set selectedList(aList:SecureTradeInventory) : *
      {
         // method body index: 1342 method index: 1342
         if(aList != this.m_SelectedList)
         {
            this.m_SelectedList = aList;
            stage.focus = this.m_SelectedList.ItemList_mc.List_mc;
            this.updateListActive(this.PlayerInventory_mc);
            this.updateListActive(this.OfferInventory_mc);
            this.updateButtonHints();
            this.updateHeaders();
         }
      }
      
      public function get selectedList() : SecureTradeInventory
      {
         // method body index: 1343 method index: 1343
         return this.m_SelectedList;
      }
      
      public function get modalActive() : Boolean
      {
         // method body index: 1344 method index: 1344
         return this.m_ModalActive;
      }
      
      public function set modalActive(aActive:Boolean) : void
      {
         // method body index: 1345 method index: 1345
         if(aActive != this.m_ModalActive)
         {
            this.m_ModalActive = aActive;
            if(this.m_ModalActive)
            {
               gotoAndPlay("modalFadeOut");
            }
            else
            {
               gotoAndPlay("modalFadeIn");
            }
         }
      }
      
      private function updateModalActive() : void
      {
         // method body index: 1346 method index: 1346
         this.modalActive = this.ModalSetQuantity_mc.opened || this.ModalSetPrice_mc.opened || this.ModalDeclineItem_mc.Active || this.ModalConfirmPurchase_mc.open || this.ModalConfirmTakeAll_mc.open || this.ModalConfirmScrap_mc.open || this.ModalUpgradeStash_mc.open;
      }
      
      public function Input_HandleLeftShoulder() : uint
      {
         // method body index: 1348 method index: 1348
         if(!this.modalActive)
         {
            this.selectedTab--;
            this.CategoryBar_mc.SelectPrevious();
         }
         else if(this.ModalSetPrice_mc.opened)
         {
            this.ModalSetPrice_mc.ProcessUserEvent("LShoulder",false);
         }
         else if(this.ModalSetQuantity_mc.opened)
         {
            this.ModalSetQuantity_mc.ProcessUserEvent("LShoulder",false);
         }
         return this.CategoryBar_mc.SelectedID;
      }
      
      public function Input_HandleRightShoulder() : uint
      {
         // method body index: 1349 method index: 1349
         if(!this.modalActive)
         {
            this.selectedTab++;
            this.CategoryBar_mc.SelectNext();
         }
         else if(this.ModalSetPrice_mc.opened)
         {
            this.ModalSetPrice_mc.ProcessUserEvent("RShoulder",false);
         }
         else if(this.ModalSetQuantity_mc.opened)
         {
            this.ModalSetQuantity_mc.ProcessUserEvent("RShoulder",false);
         }
         return this.CategoryBar_mc.SelectedID;
      }
      
      public function OnLabelMouseSelection(aEvent:Event) : void
      {
         // method body index: 1350 method index: 1350
         var labelId:uint = 0;
         if((aEvent as CustomEvent).params.Source == this.CategoryBar_mc && !this.modalActive)
         {
            labelId = (aEvent as CustomEvent).params.id;
            this.selectedTab = this.CategoryBar_mc.GetLabelIndex(labelId) + this.m_TabMin;
            this.CategoryBar_mc.SelectedID = labelId;
         }
      }
      
      private function onInventoryTabWheel(wheelDown:Boolean) : void
      {
         // method body index: 1351 method index: 1351
         if(wheelDown)
         {
            this.selectedTab--;
            this.CategoryBar_mc.SelectPrevious();
         }
         else
         {
            this.selectedTab++;
            this.CategoryBar_mc.SelectNext();
         }
      }
      
      private function updateHeaders() : void
      {
         // method body index: 1352 method index: 1352
         if(this.m_MenuMode == MODE_PLAYERVENDING)
         {
            if(this.m_SelectedTab == 0)
            {
               this.PlayerInventory_mc.header = "$MYINVENTORY";
               if(this.m_PlayerConnected)
               {
                  this.OfferInventory_mc.header = this.m_DefaultHeaderText;
               }
               else
               {
                  GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf,"$WaitingForPlayer",true);
                  GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf,this.OfferInventory_mc.Header_mc.Header_tf.text.replace("{1}",this.m_DefaultHeaderText),true);
               }
            }
            else
            {
               this.PlayerInventory_mc.header = this.m_ItemFilters[this.m_SelectedTab].text + "Mine";
               if(this.m_PlayerConnected)
               {
                  this.OfferInventory_mc.header = this.m_ItemFilters[this.m_SelectedTab].text;
               }
               else
               {
                  GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf,"$WaitingForPlayer",true);
                  GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf,this.OfferInventory_mc.Header_mc.Header_tf.text.replace("{1}",this.m_DefaultHeaderText),true);
               }
            }
         }
         else
         {
            this.PlayerInventory_mc.header = this.m_SelectedTab == 0?"$MYINVENTORY":this.m_ItemFilters[this.m_SelectedTab].text + "Mine";
            this.OfferInventory_mc.header = this.m_SelectedTab == 0?this.m_DefaultHeaderText:this.m_ItemFilters[this.m_SelectedTab].text;
         }
      }
      
      public function onCharacterInfoDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1353 method index: 1353
         this.PlayerInventory_mc.currency = 0;
         this.PlayerInventory_mc.currencyMax = MAX_SELL_PRICE;
         this.PlayerInventory_mc.currencyName = "";
         for(var idx:uint = 0; idx < arEvent.data.currencies.length; idx++)
         {
            if(arEvent.data.currencies[idx].currencyType == this.currencyType)
            {
               this.PlayerInventory_mc.currency = arEvent.data.currencies[idx].currencyAmount;
               this.PlayerInventory_mc.currencyMax = arEvent.data.currencies[idx].currencyMax;
               this.PlayerInventory_mc.currencyName = arEvent.data.currencies[idx].currencyName;
               break;
            }
         }
         this.PlayerInventory_mc.carryWeightCurrent = Math.floor(arEvent.data.currWeight);
         this.PlayerInventory_mc.carryWeightMax = Math.floor(arEvent.data.maxWeight);
         this.PlayerInventory_mc.absoluteWeightLimit = Math.floor(arEvent.data.absoluteWeightLimit);
         PlayerListEntry.playerLevel = arEvent.data.level;
         OfferListEntry.playerLevel = arEvent.data.level;
         OfferListEntry.playerCurrency = arEvent.data.currencyAmount;
         this.PlayerInventory_mc.ItemList_mc.List_mc.InvalidateData();
         this.OfferInventory_mc.ItemList_mc.List_mc.InvalidateData();
      }
      
      public function onContainerOptionsDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1354 method index: 1354
         this.m_AcceptBtnText_Player = arEvent.data.acceptButtonText_Player;
         this.m_AcceptBtnText_Container = arEvent.data.acceptButtonText_Container;
         this.m_TakeAllBtnText = arEvent.data.takeAllButtonText;
         this.m_scrapAllowedFlag = arEvent.data.scrapAllowedFlag;
         this.m_isWorkbench = arEvent.data.isWorkbench;
         this.m_isWorkshop = arEvent.data.isWorkshop;
         this.m_isCamp = arEvent.data.isCamp;
         this.m_isStash = arEvent.data.isStash;
         this.m_onlyTakingAllowed = arEvent.data.onlyTakingAllowed;
         this.m_onlyGivingAllowed = arEvent.data.onlyGivingAllowed;
         this.m_isLimitedTypeStorage = arEvent.data.isLimitedTypeStorage;
         if(this.m_isWorkbench)
         {
            this.OfferInventory_mc.visible = false;
            this.OfferInventory_mc.enabled = false;
            this.updateSelfInventory();
         }
         this.updateOfferWeightDisplay();
         this.updateCategoryBar();
         this.updateButtonHints();
         this.updateHeaders();
      }
      
      public function onCampVendingOfferDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1355 method index: 1355
         if(this.isCampVendingMenuType())
         {
            this.m_TheirOffersData = arEvent.data.InventoryList.concat();
            this.PopulateCampVendingInventory();
            this.disableInput = false;
         }
      }
      
      private function onFFEvent(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1356 method index: 1356
         var data:* = arEvent.data;
         if(GlobalFunc.HasFFEvent(data,EVENT_CAMP_STOP_ITEM_PROCESSING) && this.isCampVendingMenuType())
         {
            this.m_ProcessingItemEvent = false;
         }
         else if(GlobalFunc.HasFFEvent(data,EVENT_SELL_FAVORITE_DECLINED))
         {
            this.disableInput = false;
         }
         else if(GlobalFunc.HasFFEvent(data,EVENT_TRADE_FAVORITE_DECLINED))
         {
            this.disableInput = false;
            this.m_ProcessingItemEvent = false;
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1357 method index: 1357
         super.onAddedToStage();
         this.CategoryBar_mc.forceUppercase = false;
         this.CategoryBar_mc.labelWidthScale = 1.35;
         this.menuMode = MODE_CONTAINER;
         BSUIDataManager.Subscribe("PlayerInventoryData",this.onPlayerInventoryDataUpdate);
         BSUIDataManager.Subscribe("OtherInventoryTypeData",this.onOtherInvTypeDataUpdate);
         BSUIDataManager.Subscribe("OtherInventoryData",this.onOtherInvDataUpdate);
         BSUIDataManager.Subscribe("MyOffersData",this.onMyOffersDataUpdate);
         BSUIDataManager.Subscribe("TheirOffersData",this.onTheirOffersDataUpdate);
         BSUIDataManager.Subscribe("CharacterInfoData",this.onCharacterInfoDataUpdate);
         BSUIDataManager.Subscribe("ContainerOptionsData",this.onContainerOptionsDataUpdate);
         BSUIDataManager.Subscribe("CampVendingOfferData",this.onCampVendingOfferDataUpdate);
         BSUIDataManager.Subscribe("FireForgetEvent",this.onFFEvent);
         BSUIDataManager.Subscribe("AccountInfoData",this.onAccountInfoUpdate);
         this.updateButtonHints();
         this.updateHeaders();
         this.isOpen = true;
         this.selectedList = this.PlayerInventory_mc;
         time = 0;
         delta = 0;
         this.update();
         this.update();
         this.update();
         stage.addEventListener(Event.ENTER_FRAME,this.update);
         this.CategoryBar_mc.SetSelection(this.selectedTab,true,false);
      }
      
      private function onAccountInfoUpdate(aEvent:FromClientDataEvent) : void
      {
         // method body index: 1358 method index: 1358
         this.m_IsFollowerOfZeus = aEvent.data.hasZeus;
         this.updateButtonHints();
      }
      
      public function update(evt:Event = null) : void
      {
         // method body index: 1359 method index: 1359
         delta = (getTimer() - time) / 1000;
         time = getTimer();
         this.CategoryBar_mc.Update(delta);
      }
      
      private function ClearStartingFocusPreference() : void
      {
         // method body index: 1360 method index: 1360
         this.m_StartingFocusPref = STARTING_FOCUS_PREF_NONE;
      }
      
      private function onListMouseOver(event:Event) : *
      {
         // method body index: 1361 method index: 1361
         if(!this.modalActive)
         {
            if(event.target == this.PlayerInventory_mc && this.selectedList != this.PlayerInventory_mc && this.m_onlyTakingAllowed != true)
            {
               this.selectedList = this.PlayerInventory_mc;
               this.ClearStartingFocusPreference();
            }
            else if(event.target == this.OfferInventory_mc && this.selectedList != this.OfferInventory_mc && this.m_onlyGivingAllowed != true)
            {
               this.selectedList = this.OfferInventory_mc;
               this.ClearStartingFocusPreference();
            }
         }
      }
      
      private function onConfirmModalConfirm(event:Event) : *
      {
         // method body index: 1362 method index: 1362
         var purchaseCount:int = 0;
         var purchaseValue:Number = NaN;
         if(this.ModalConfirmPurchase_mc.open)
         {
            this.closeConfirmPurchaseModal(true);
            purchaseCount = Math.min(this.selectedListEntry.count,this.ModalSetQuantity_mc.quantity);
            purchaseValue = !!this.selectedListEntry.isOffered?Number(this.selectedListEntry.offerValue):Number(this.selectedListEntry.itemValue);
            if(this.m_MenuMode == MODE_NPCVENDING)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(this.selectedList == this.PlayerInventory_mc?EVENT_NPC_SELL_ITEM:EVENT_NPC_BUY_ITEM,{
                  "serverHandleId":this.selectedListEntry.serverHandleId,
                  "quantity":purchaseCount
               }));
            }
            else if(this.m_MenuMode == MODE_VENDING_MACHINE)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_BUY_ITEM,{
                  "serverHandleId":this.selectedListEntry.serverHandleId,
                  "count":purchaseCount,
                  "price":purchaseValue
               }));
            }
            else
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_REQUEST_PURCHASE,{
                  "serverHandleId":this.selectedListEntry.serverHandleId,
                  "count":purchaseCount,
                  "price":purchaseValue
               }));
            }
         }
         else if(this.ModalUpgradeStash_mc.open)
         {
            this.closeUpgradeStashModel();
         }
         else
         {
            this.onAccept();
         }
      }
      
      private function onConfirmModalCancel(event:Event) : *
      {
         // method body index: 1363 method index: 1363
         this.onBackButton();
      }
      
      private function onDeclineItemConfirm(event:Event) : *
      {
         // method body index: 1364 method index: 1364
         this.closeDeclineItemModal();
         this.ClearSelectedItemValues();
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_DECLINE_ITEM,{
            "serverHandleId":this.ModalDeclineItem_mc.ItemServerHandleId,
            "declineReason":this.ModalDeclineItem_mc.selectedIndex
         }));
      }
      
      private function onQuantityConfirm() : *
      {
         // method body index: 1365 method index: 1365
         if(this._OnQuantityConfirmedFn != null && this.ModalSetQuantity_mc.opened)
         {
            this.closeQuantityModal();
            this.ModalSetQuantity_mc.quantity = Math.min(this.selectedListEntry.count,this.ModalSetQuantity_mc.quantity);
            this._OnQuantityConfirmedFn();
            this._OnQuantityConfirmedFn = null;
         }
         else if(this._OnSetPriceConfirmedFn != null && this.ModalSetPrice_mc.opened)
         {
            this.closeSetPriceModal();
            this._OnSetPriceConfirmedFn();
            this._OnSetPriceConfirmedFn = null;
         }
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function qConfirm_TransferItem() : *
      {
         // method body index: 1366 method index: 1366
         var _fromContainer:* = this.selectedList == this.OfferInventory_mc;
         if(_fromContainer || this.performContainerWeightCheck(this.selectedListEntry,this.ModalSetQuantity_mc.quantity))
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM,{
               "serverHandleId":this.selectedListEntry.serverHandleId,
               "quantity":this.ModalSetQuantity_mc.quantity,
               "fromContainer":_fromContainer
            }));
         }
      }
      
      private function qConfirm_TakePartialFromVendingOffer() : *
      {
         // method body index: 1367 method index: 1367
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM,{
            "serverHandleId":this.selectedListEntry.serverHandleId,
            "quantity":this.ModalSetQuantity_mc.quantity,
            "fromContainer":true
         }));
      }
      
      private function spConfirm_CreatePlayerVendingOffer() : *
      {
         // method body index: 1368 method index: 1368
         var isPartialOffer:* = this.ModalSetQuantity_mc.quantity != this.selectedListEntry.count;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CREATE_OFFER,{
            "serverHandleId":this.selectedListEntry.serverHandleId,
            "price":this.ModalSetPrice_mc.quantity,
            "quantity":this.ModalSetQuantity_mc.quantity,
            "partialOffer":isPartialOffer
         }));
      }
      
      private function spConfirm_CreateCampVendingOffer() : *
      {
         // method body index: 1369 method index: 1369
         var partialOffer:* = this.ModalSetQuantity_mc.quantity != this.selectedListEntry.count;
         var fromContainer:* = this.m_SelectedList == this.OfferInventory_mc;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_SELL_ITEM,{
            "serverHandleId":this.selectedListEntry.serverHandleId,
            "price":this.ModalSetPrice_mc.quantity,
            "quantity":this.ModalSetQuantity_mc.quantity,
            "partialOffer":partialOffer,
            "fromContainer":fromContainer
         }));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
         this.DelayForItemProcessing();
      }
      
      private function DelayForItemProcessing() : void
      {
         // method body index: 1371 method index: 1371
         var delayMS:uint = 1000;
         this.m_ProcessingItemEvent = true;
         this.updateButtonHints();
         setTimeout(function():// method body index: 1370 method index: 1370
         void
         {
            // method body index: 1370 method index: 1370
            m_ProcessingItemEvent = false;
            updateButtonHints();
         },delayMS);
      }
      
      private function onQuantityCancel(event:Event) : *
      {
         // method body index: 1372 method index: 1372
         this.onBackButton();
      }
      
      private function onDeclineItemAccept() : void
      {
         // method body index: 1373 method index: 1373
         dispatchEvent(new Event(SecureTradeDeclineItemModal.CONFIRM,true,true));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_CANCEL);
      }
      
      private function onConfirmPurchaseAccept() : void
      {
         // method body index: 1374 method index: 1374
      }
      
      private function onFocusChange(event:FocusEvent) : *
      {
         // method body index: 1375 method index: 1375
         if(event.relatedObject != this.ModalSetQuantity_mc && event.relatedObject != this.ModalSetPrice_mc && event.relatedObject != this.PlayerInventory_mc.ItemList_mc.List_mc && event.relatedObject != this.OfferInventory_mc.ItemList_mc.List_mc && event.relatedObject != this.ModalDeclineItem_mc && event.relatedObject != this.ModalConfirmPurchase_mc && event.relatedObject != this.ModalConfirmPurchase_mc.ButtonList_mc && event.relatedObject != this.ModalConfirmTakeAll_mc && event.relatedObject != this.ModalConfirmTakeAll_mc.ButtonList_mc && event.relatedObject != this.ModalConfirmScrap_mc.ComponentList_mc && event.relatedObject != this.ModalUpgradeStash_mc && event.relatedObject != this.ModalUpgradeStash_mc.ButtonList_mc)
         {
            stage.focus = event.target as InteractiveObject;
         }
      }
      
      public function onKeyUp(event:KeyboardEvent) : void
      {
         // method body index: 1376 method index: 1376
         if(this.isOpen && !event.isDefaultPrevented())
         {
            if(this.modalActive)
            {
               if(event.keyCode == Keyboard.ENTER)
               {
                  this.onAccept();
                  event.stopPropagation();
               }
            }
         }
      }
      
      private function UpdateItemCard() : *
      {
         // method body index: 1377 method index: 1377
         var filteredInfoObj:Array = null;
         var i:uint = 0;
         var hasDescription:Boolean = false;
         if(this.selectedListEntry != null)
         {
            filteredInfoObj = [];
            if(this.selectedListEntry.itemLevel != null)
            {
               filteredInfoObj.push({
                  "text":"itemLevel",
                  "value":this.selectedListEntry.itemLevel
               });
            }
            if(this.selectedListEntry.currentHealth != null)
            {
               filteredInfoObj.push({
                  "text":"currentHealth",
                  "value":this.selectedListEntry.currentHealth
               });
            }
            if(this.selectedListEntry.maximumHealth != null)
            {
               filteredInfoObj.push({
                  "text":"maximumHealth",
                  "value":this.selectedListEntry.maximumHealth
               });
            }
            if(this.selectedListEntry.durability != null)
            {
               filteredInfoObj.push({
                  "text":"durability",
                  "value":this.selectedListEntry.durability
               });
            }
            for(i = 0; i < this.selectedListEntry.ItemCardEntries.length; i++)
            {
               if(this.selectedListEntry.ItemCardEntries[i].text == "DESC")
               {
                  GlobalFunc.SetText(this.ItemCardContainer_mc.Background_mc.Description_mc.Description_tf,this.selectedListEntry.ItemCardEntries[i].value);
                  TextFieldEx.setVerticalAlign(this.ItemCardContainer_mc.Background_mc.Description_mc.Description_tf,TextFieldEx.VALIGN_BOTTOM);
                  hasDescription = true;
               }
               else
               {
                  filteredInfoObj.push(this.selectedListEntry.ItemCardEntries[i]);
               }
            }
            this.ItemCardContainer_mc.ItemCard_mc.showValueEntry = this.m_ShowPlayerValueEntry || this.selectedList != this.PlayerInventory_mc;
            this.ItemCardContainer_mc.ItemCard_mc.currencyType = this.currencyType;
            this.ItemCardContainer_mc.ItemCard_mc.InfoObj = filteredInfoObj;
            this.ItemCardContainer_mc.ItemCard_mc.redrawUIComponent();
            this.ItemCardContainer_mc.Background_mc.visible = true;
            this.ItemCardContainer_mc.Background_mc.gotoAndStop("entry" + this.ItemCardContainer_mc.ItemCard_mc.entryCount);
         }
         else
         {
            this.ItemCardContainer_mc.Background_mc.visible = false;
            this.ItemCardContainer_mc.ItemCard_mc.InfoObj = new Array();
            this.ItemCardContainer_mc.ItemCard_mc.redrawUIComponent();
         }
         this.ItemCardContainer_mc.Background_mc.Description_mc.visible = hasDescription;
      }
      
      private function onSelectedDataChanged(event:Event) : *
      {
         // method body index: 1378 method index: 1378
         if(this.selectedList != null)
         {
            if(this.selectedListEntry != null)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_ITEM_SELECTED,{
                  "serverHandleId":this.selectedListEntry.serverHandleId,
                  "isSelectionValid":true,
                  "fromContainer":this.selectedList == this.OfferInventory_mc
               }));
            }
            else
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_ITEM_SELECTED,{
                  "serverHandleId":0,
                  "isSelectionValid":false,
                  "fromContainer":false
               }));
            }
            this.UpdateItemCard();
            this.updateButtonHints();
         }
      }
      
      private function onUserMovesListSelection(event:Event) : *
      {
         // method body index: 1379 method index: 1379
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_FOCUS_CHANGE);
         if(event.target == this.PlayerInventory_mc.ItemList_mc.List_mc || event.target == this.OfferInventory_mc.ItemList_mc.List_mc)
         {
            this.m_RefreshSelectionOption = REFRESH_SELECTION_NONE;
         }
         this.ClearStartingFocusPreference();
      }
      
      private function onPlayerInventoryDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1380 method index: 1380
         if(!this.modalActive)
         {
            this.disableInput = false;
         }
         this.updateSelfInventory();
         this.updateInventoryFocus();
         if(this.selectedList == this.PlayerInventory_mc && this.PlayerInventory_mc.ItemList_mc.List_mc.hasBeenUpdated)
         {
            this.PlayerInventory_mc.selectedItemIndex = !!this.m_PlayerInventoryEmpty?Number(-1):Number(this.PlayerInventory_mc.ItemList_mc.List_mc.filterer.ClampIndex(this.PlayerInventory_mc.selectedItemIndex));
         }
      }
      
      private function onOtherInvTypeDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1381 method index: 1381
         var data:Object = arEvent.data;
         if(this.m_MenuMode != data.menuType)
         {
            this.menuMode = data.menuType;
         }
         if(this.m_SubMenuMode != data.menuSubType)
         {
            this.subMenuMode = data.menuSubType;
         }
         this.OfferInventory_mc.showCurrency = data.menuType == MODE_NPCVENDING && data.menuSubType != SecureTradeShared.SUB_MODE_LEGENDARY_VENDOR;
         if(data.currencyType != null && data.currencyType != this.currencyType)
         {
            this.currencyType = data.currencyType;
         }
         this.m_ShowPlayerValueEntry = this.m_MenuMode != MODE_NPCVENDING || this.currencyType == SecureTradeShared.CURRENCY_CAPS || this.currencyType == SecureTradeShared.CURRENCY_LEGENDARY_TOKENS;
         this.m_DefaultHeaderText = data.defaultHeaderText == undefined?"$CONTAINER":data.defaultHeaderText.toUpperCase();
         this.m_VendorSellOnly = data.sellOnly;
         this.m_PlayerConnected = data.playerConnected;
         this.m_OwnsVendor = data.ownsVendor;
         OfferListEntry.ownsVendor = this.m_OwnsVendor;
         this.OfferInventory_mc.ownsVendor = this.m_OwnsVendor;
         if(this.m_MenuMode == MODE_PLAYERVENDING)
         {
            if(this.m_PlayerConnected)
            {
               if(!this.m_ShowOffersOnly)
               {
                  this.UpdatePartialItems(this.m_OtherInvData,this.m_TheirOffersData);
                  this.PopulateOfferInventory(this.m_OtherInvData);
               }
               else
               {
                  this.InsertRequestedItems(this.m_TheirOffersData,this.m_OtherInvData);
                  this.PopulateOfferInventory(this.m_TheirOffersData);
               }
            }
            else
            {
               this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData = null;
               this.OfferInventory_mc.ItemList_mc.SetIsDirty();
            }
         }
         else if(this.isCampVendingMenuType())
         {
            this.PopulateCampVendingInventory();
         }
         this.OfferInventory_mc.currency = data.currencyAmount;
         this.OfferInventory_mc.carryWeightCurrent = data.currWeight;
         this.OfferInventory_mc.carryWeightMax = data.maxWeight;
         this.updateHeaders();
         if(!this.modalActive)
         {
            this.disableInput = false;
         }
      }
      
      private function updateSelfInventory() : void
      {
         // method body index: 1382 method index: 1382
         var clientData:Object = BSUIDataManager.GetDataFromClient("PlayerInventoryData").data;
         if(clientData.InventoryList != null)
         {
            this.m_PlayerInvData = !!this.m_isWorkbench?this.CreateScrappableInventoryList(clientData.InventoryList):clientData.InventoryList.concat();
            this.m_PlayerInventorySortField = clientData.SortField;
         }
         if(!this.m_ShowOffersOnly)
         {
            this.UpdatePartialItems(this.m_PlayerInvData,this.m_MyOffersData);
            this.PopulatePlayerInventory(this.m_PlayerInvData);
         }
         else
         {
            this.InsertRequestedItems(this.m_MyOffersData,this.m_PlayerInvData);
            this.PopulatePlayerInventory(this.m_MyOffersData);
         }
      }
      
      private function onOtherInvDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1383 method index: 1383
         this.m_OtherInvData = arEvent.data.InventoryList.concat();
         this.m_OfferInventorySortField = arEvent.data.SortField;
         this.updateOtherInventory();
         if(!this.modalActive)
         {
            this.disableInput = false;
         }
      }
      
      private function updateOtherInventory() : void
      {
         // method body index: 1384 method index: 1384
         if(!(this.m_MenuMode == MODE_PLAYERVENDING && this.m_PlayerConnected == false))
         {
            if(this.isCampVendingMenuType())
            {
               this.PopulateCampVendingInventory();
            }
            else if(!this.m_ShowOffersOnly)
            {
               this.UpdatePartialItems(this.m_OtherInvData,this.m_TheirOffersData);
               this.PopulateOfferInventory(this.m_OtherInvData);
            }
            else
            {
               this.InsertRequestedItems(this.m_TheirOffersData,this.m_OtherInvData);
               this.PopulateOfferInventory(this.m_TheirOffersData);
            }
         }
         if(!this.modalActive)
         {
            this.disableInput = false;
         }
      }
      
      private function onMyOffersDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1385 method index: 1385
         if(this.m_MenuMode == MODE_PLAYERVENDING)
         {
            this.m_MyOffersData = arEvent.data.InventoryList.concat();
            if(this.m_PlayerConnected)
            {
               if(this.m_ShowOffersOnly)
               {
                  this.InsertRequestedItems(this.m_MyOffersData,this.m_PlayerInvData);
                  this.PopulatePlayerInventory(this.m_MyOffersData);
               }
               else
               {
                  this.UpdatePartialItems(this.m_PlayerInvData,this.m_MyOffersData);
                  this.PopulatePlayerInventory(this.m_PlayerInvData);
               }
            }
         }
      }
      
      private function onTheirOffersDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1386 method index: 1386
         if(this.m_MenuMode == MODE_PLAYERVENDING)
         {
            this.m_TheirOffersData = arEvent.data.InventoryList.concat();
            if(this.m_PlayerConnected)
            {
               if(this.m_ShowOffersOnly)
               {
                  this.InsertRequestedItems(this.m_TheirOffersData,this.m_OtherInvData);
                  this.PopulateOfferInventory(this.m_TheirOffersData);
               }
               else
               {
                  this.UpdatePartialItems(this.m_OtherInvData,this.m_TheirOffersData);
                  this.PopulateOfferInventory(this.m_OtherInvData);
               }
            }
         }
      }
      
      private function doContainerToPlayerTransfer() : *
      {
         // method body index: 1387 method index: 1387
         var _selectedEntry:Object = this.selectedListEntry;
         var _fromContainer:* = this.selectedList == this.OfferInventory_mc;
         var _isWeightless:Boolean = !!bNuclearWinterMode?false:Boolean(_selectedEntry.isWeightless);
         if(_selectedEntry.isCurrency)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM,{
               "serverHandleId":_selectedEntry.serverHandleId,
               "quantity":_selectedEntry.count,
               "fromContainer":_fromContainer
            }));
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
         }
         else if(!_selectedEntry.singleItemTransfer && _selectedEntry.count > this.TRANSFER_ITEM_COUNT_THRESHOLD && !_isWeightless)
         {
            this.openQuantityModal(this.qConfirm_TransferItem);
         }
         else if(_fromContainer || this.performContainerWeightCheck(_selectedEntry,1))
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM,{
               "serverHandleId":_selectedEntry.serverHandleId,
               "quantity":1,
               "fromContainer":_fromContainer
            }));
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
         }
      }
      
      private function performContainerWeightCheck(aEntry:Object, aItemCount:uint) : Boolean
      {
         // method body index: 1388 method index: 1388
         var weightOkay:Boolean = aEntry.isWeightless || this.OfferInventory_mc.carryWeightMax <= 0 || this.OfferInventory_mc.carryWeightCurrent + aEntry.weight * aItemCount <= this.OfferInventory_mc.carryWeightMax;
         if(!weightOkay)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_TOO_HEAVY_ERROR,{}));
         }
         return weightOkay;
      }
      
      private function onItemPress(event:Event) : *
      {
         // method body index: 1391 method index: 1391
         var _selectedEntry:Object = this.selectedListEntry;
         this.ClearStartingFocusPreference();
         if(this.isOpen && this.AcceptButton.ButtonDisabled != true && this.AcceptButton.ButtonVisible)
         {
            switch(this.m_MenuMode)
            {
               case MODE_PLAYERVENDING:
                  if(!this.m_IgnorePlayerVendingItemPress)
                  {
                     if(this.m_SelectedList == this.OfferInventory_mc)
                     {
                        if(_selectedEntry.isOffered == true)
                        {
                           this.SetSelectedItemValues(_selectedEntry);
                           this.openQuantityModal(this.openConfirmPurchaseModal);
                        }
                        else if(_selectedEntry.isRequested)
                        {
                           this.onCancelRequestItem();
                        }
                        else
                        {
                           this.onRequestItem();
                        }
                     }
                     else if(this.m_ProcessingItemEvent == false)
                     {
                        this.SetSelectedItemValues(_selectedEntry);
                        this.openQuantityModal(this.openSetPriceModal,this.spConfirm_CreatePlayerVendingOffer);
                     }
                  }
                  break;
               case MODE_NPCVENDING:
                  this.SetSelectedItemValues(_selectedEntry);
                  this.openQuantityModal(this.openConfirmPurchaseModal);
                  break;
               case MODE_CONTAINER:
                  if(this.isScrapStash && _selectedEntry.scrapAllowed)
                  {
                     if(_selectedEntry.count > this.SCRAP_ITEM_COUNT_THRESHOLD)
                     {
                        this.openQuantityModal(function():// method body index: 1389 method index: 1389
                        *
                        {
                           // method body index: 1389 method index: 1389
                           ShowScrapConfirmModal(false,ModalSetQuantity_mc.quantity,true);
                        });
                     }
                     else
                     {
                        this.ShowScrapConfirmModal(false,1,true);
                     }
                  }
                  else
                  {
                     this.doContainerToPlayerTransfer();
                  }
                  break;
               case MODE_ALLY:
               case MODE_DISPLAY_CASE:
                  if(!this.m_ProcessingItemEvent && this.m_OwnsVendor)
                  {
                     if(this.m_SelectedList == this.OfferInventory_mc)
                     {
                        if(_selectedEntry.isOffered == true)
                        {
                           BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM,{
                              "serverHandleId":this.selectedListEntry.serverHandleId,
                              "quantity":1,
                              "fromContainer":true
                           }));
                           GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                        }
                        else
                        {
                           this.doContainerToPlayerTransfer();
                        }
                     }
                     else if(this.performContainerWeightCheck(_selectedEntry,1))
                     {
                        if(!this.SlotInfo_mc.visible || this.SlotInfo_mc.AreSlotsFull())
                        {
                           GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_MovingToStash");
                           this.doContainerToPlayerTransfer();
                        }
                        else
                        {
                           BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_DISPLAY_DECORATE_ITEM_IN_SLOT,{
                              "serverHandleId":this.selectedListEntry.serverHandleId,
                              "fromContainer":false
                           }));
                           GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                           this.DelayForItemProcessing();
                        }
                     }
                  }
                  break;
               case MODE_CAMP_DISPENSER:
               case MODE_FERMENTER:
               case MODE_REFRIGERATOR:
                  if(!this.m_ProcessingItemEvent && this.m_OwnsVendor)
                  {
                     if(this.m_SelectedList == this.OfferInventory_mc)
                     {
                        if(_selectedEntry.isOffered == true)
                        {
                           BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM,{
                              "serverHandleId":this.selectedListEntry.serverHandleId,
                              "quantity":1,
                              "fromContainer":true
                           }));
                           GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                        }
                        else
                        {
                           this.doContainerToPlayerTransfer();
                        }
                     }
                     else if(this.performContainerWeightCheck(_selectedEntry,1))
                     {
                        if(!this.SlotInfo_mc.visible || this.SlotInfo_mc.AreSlotsFull() || this.m_MenuMode == MODE_FERMENTER && _selectedEntry.currentHealth == -1)
                        {
                           GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_MovingToStash");
                           this.doContainerToPlayerTransfer();
                        }
                        else
                        {
                           BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_DISPLAY_ITEM,{
                              "serverHandleId":this.selectedListEntry.serverHandleId,
                              "fromContainer":false
                           }));
                           this.DelayForItemProcessing();
                        }
                        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                     }
                  }
                  break;
               case MODE_VENDING_MACHINE:
                  if(this.m_ProcessingItemEvent)
                  {
                     break;
                  }
                  if(this.m_OwnsVendor)
                  {
                     if(this.m_SelectedList == this.OfferInventory_mc)
                     {
                        if(_selectedEntry.vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID)
                        {
                           this.openQuantityModal(this.qConfirm_TakePartialFromVendingOffer);
                        }
                        else
                        {
                           this.doContainerToPlayerTransfer();
                        }
                     }
                     else if(!this.SlotInfo_mc.visible || this.SlotInfo_mc.AreSlotsFull())
                     {
                        GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_MovingToStash");
                        this.doContainerToPlayerTransfer();
                     }
                     else
                     {
                        this.SetSelectedItemValues(this.selectedListEntry);
                        this.openQuantityModal(this.openSetPriceModal_CheckWeight,this.spConfirm_CreateCampVendingOffer);
                     }
                  }
                  else if(this.m_SelectedList == this.OfferInventory_mc)
                  {
                     this.SetSelectedItemValues(_selectedEntry);
                     this.openQuantityModal(this.openConfirmPurchaseModal);
                  }
                  break;
            }
         }
         else if(this.isOpen && this.ScrapButton.ButtonDisabled != true && this.ScrapButton.ButtonVisible)
         {
            switch(this.m_MenuMode)
            {
               case MODE_CONTAINER:
                  if(_selectedEntry.count > this.SCRAP_ITEM_COUNT_THRESHOLD)
                  {
                     this.openQuantityModal(function():// method body index: 1390 method index: 1390
                     *
                     {
                        // method body index: 1390 method index: 1390
                        ShowScrapConfirmModal(false,ModalSetQuantity_mc.quantity);
                     });
                  }
                  else
                  {
                     this.ShowScrapConfirmModal(false,1);
                  }
            }
         }
      }
      
      private function onDeclineItem() : void
      {
         // method body index: 1392 method index: 1392
         if(this.selectedList == this.OfferInventory_mc)
         {
            this.SetSelectedItemValues(this.selectedListEntry);
            this.openDeclineItemModal();
         }
      }
      
      private function onToggleAssign() : void
      {
         // method body index: 1393 method index: 1393
         var fromContainer:* = false;
         var entry:Object = this.selectedListEntry;
         this.ClearSelectedItemValues();
         this.ClearStartingFocusPreference();
         if(entry.vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID)
         {
            switch(entry.vendingData.machineType)
            {
               case SecureTradeShared.MACHINE_TYPE_VENDING:
               case SecureTradeShared.MACHINE_TYPE_DISPENSER:
               case SecureTradeShared.MACHINE_TYPE_FERMENTER:
               case SecureTradeShared.MACHINE_TYPE_REFRIGERATOR:
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_REMOVE_ITEM,{
                     "serverHandleId":entry.serverHandleId,
                     "quantity":entry.count
                  }));
                  GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                  this.DelayForItemProcessing();
                  break;
               case SecureTradeShared.MACHINE_TYPE_DISPLAY:
               case SecureTradeShared.MACHINE_TYPE_ALLY:
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_REMOVE_DECORATE_ITEM_IN_SLOT,{"serverHandleId":entry.serverHandleId}));
                  GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                  this.DelayForItemProcessing();
            }
         }
         else if(this.isCampVendingMenuType() && !this.SlotInfo_mc.isSlotDataValid())
         {
            GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_InvalidData");
         }
         else if(this.isCampVendingMenuType() && this.SlotInfo_mc.AreSlotsFull())
         {
            GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_SlotsFull");
         }
         else
         {
            switch(this.m_MenuMode)
            {
               case MODE_VENDING_MACHINE:
                  this.SetSelectedItemValues(entry);
                  this.openQuantityModal(this.openSetPriceModal,this.spConfirm_CreateCampVendingOffer);
                  break;
               case MODE_DISPLAY_CASE:
               case MODE_ALLY:
                  fromContainer = this.m_SelectedList == this.OfferInventory_mc;
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_DISPLAY_DECORATE_ITEM_IN_SLOT,{
                     "serverHandleId":entry.serverHandleId,
                     "fromContainer":fromContainer
                  }));
                  GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                  this.DelayForItemProcessing();
                  if(fromContainer && entry.count > 1)
                  {
                     this.SetSelectedItemValues(entry);
                     this.m_RefreshSelectionOption = REFRESH_SELECTION_NAME_COUNT;
                  }
                  break;
               case MODE_CAMP_DISPENSER:
               case MODE_FERMENTER:
               case MODE_REFRIGERATOR:
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_DISPLAY_ITEM,{
                     "serverHandleId":entry.serverHandleId,
                     "fromContainer":true
                  }));
                  this.DelayForItemProcessing();
                  if(entry.count > 1)
                  {
                     this.SetSelectedItemValues(entry);
                     this.m_RefreshSelectionOption = REFRESH_SELECTION_NAME_COUNT;
                  }
            }
         }
      }
      
      private function onOffersOnly() : void
      {
         // method body index: 1394 method index: 1394
         if(this.m_PlayerConnected)
         {
            this.m_ShowOffersOnly = !this.m_ShowOffersOnly;
            if(this.m_ShowOffersOnly)
            {
               this.InsertRequestedItems(this.m_TheirOffersData,this.m_OtherInvData);
               this.InsertRequestedItems(this.m_MyOffersData,this.m_PlayerInvData);
            }
            this.PopulateOfferInventory(!!this.m_ShowOffersOnly?this.m_TheirOffersData:this.m_OtherInvData);
            this.PopulatePlayerInventory(!!this.m_ShowOffersOnly?this.m_MyOffersData:this.m_PlayerInvData);
         }
      }
      
      private function onRequestItem() : void
      {
         // method body index: 1395 method index: 1395
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_REQUEST_ITEM,{"serverHandleId":this.selectedListEntry.serverHandleId}));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function onCancelRequestItem() : void
      {
         // method body index: 1396 method index: 1396
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CANCEL_REQUEST_ITEM,{"serverHandleId":this.selectedListEntry.serverHandleId}));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function onInspectItem() : void
      {
         // method body index: 1397 method index: 1397
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_INSPECT_ITEM,{
            "serverHandleId":this.selectedListEntry.serverHandleId,
            "fromContainer":this.selectedList == this.OfferInventory_mc
         }));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function onScrapButton() : void
      {
         // method body index: 1398 method index: 1398
         this.ShowScrapConfirmModal(false,1);
      }
      
      private function onTakeAll() : void
      {
         // method body index: 1399 method index: 1399
         if(this.OfferInventory_mc.ItemList_mc.List_mc.itemsShown > 11)
         {
            this.openConfirmTakeAllModal();
         }
         else
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TAKE_ALL,{}));
         }
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function ShowScrapConfirmModal(aScrapAll:Boolean, aScrapQuantity:uint = 0, aScrapBoxTransfer:Boolean = false) : void
      {
         // method body index: 1400 method index: 1400
         this.m_PreviousFocus = stage.focus;
         if(aScrapAll)
         {
            if(aScrapBoxTransfer)
            {
               this.ModalConfirmScrap_mc.ShowScrapboxTransferModal();
            }
            else
            {
               this.ModalConfirmScrap_mc.ShowScrapAllModal();
            }
         }
         else if(aScrapBoxTransfer)
         {
            this.ModalConfirmScrap_mc.ShowScrapboxScrapTransferSelectionModal(this.selectedListEntry,aScrapQuantity);
         }
         else
         {
            this.ModalConfirmScrap_mc.ShowScrapModal(this.selectedListEntry,aScrapQuantity);
         }
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = true;
      }
      
      private function OnSecureTradeScrapConfirmModalClosed(event:CustomEvent) : void
      {
         // method body index: 1401 method index: 1401
         var accepted:Boolean = event.params.accepted;
         var favorite:Boolean = event.params.favorite;
         stage.focus = this.m_PreviousFocus;
         this.m_PreviousFocus = null;
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = accepted && !favorite;
      }
      
      private function onStoreJunk() : void
      {
         // method body index: 1402 method index: 1402
         if(this.isScrapStash)
         {
            this.ShowScrapConfirmModal(true,0,true);
         }
         else if(this.m_isWorkbench)
         {
            this.ShowScrapConfirmModal(true);
         }
         else
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_STORE_ALL_JUNK,{}));
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
         }
      }
      
      public function set disableInput(aDisable:Boolean) : *
      {
         // method body index: 1403 method index: 1403
         this.PlayerInventory_mc.ItemList_mc.List_mc.disableInput_Inspectable = aDisable;
         this.PlayerInventory_mc.ItemList_mc.List_mc.disableSelection_Inspectable = aDisable;
         this.OfferInventory_mc.ItemList_mc.List_mc.disableInput_Inspectable = aDisable;
         this.OfferInventory_mc.ItemList_mc.List_mc.disableSelection_Inspectable = aDisable;
         this.ItemCardContainer_mc.visible = true;
      }
      
      public function onQuantityAccepted() : *
      {
         // method body index: 1404 method index: 1404
         dispatchEvent(new Event(QuantityMenu.CONFIRM,true,true));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      public function onPriceAccepted() : *
      {
         // method body index: 1405 method index: 1405
         dispatchEvent(new Event(QuantityMenu.CONFIRM,true,true));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      public function onUpgradeStashAccepted() : void
      {
         // method body index: 1406 method index: 1406
         dispatchEvent(new Event(BCBasicModal.EVENT_CONFIRM,true,true));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function openDeclineItemModal() : void
      {
         // method body index: 1407 method index: 1407
         this.ModalDeclineItem_mc.Active = true;
         this.m_PreviousFocus = stage.focus;
         stage.focus = this.ModalDeclineItem_mc;
         this.ModalDeclineItem_mc.ItemServerHandleId = this.selectedListEntry.serverHandleId;
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = true;
      }
      
      private function closeDeclineItemModal() : void
      {
         // method body index: 1408 method index: 1408
         if(this.m_PreviousFocus != null)
         {
            stage.focus = this.m_PreviousFocus;
         }
         this.ModalDeclineItem_mc.Active = false;
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = false;
      }
      
      private function openConfirmPurchaseModal() : void
      {
         // method body index: 1409 method index: 1409
         var currencyDif:Number = NaN;
         this.m_PreviousFocus = stage.focus;
         var isPurchase:* = this.selectedList == this.OfferInventory_mc;
         if(isPurchase)
         {
            this.ModalConfirmPurchase_mc.header = "$CONFIRMPURCHASE";
         }
         else
         {
            this.ModalConfirmPurchase_mc.header = "$CONFIRMSALE";
         }
         var purchaseCount:Number = Math.min(this.selectedListEntry.count,this.ModalSetQuantity_mc.quantity);
         var purchaseValue:Number = !!this.selectedListEntry.isOffered?Number(this.selectedListEntry.offerValue):Number(this.selectedListEntry.itemValue);
         this.ModalConfirmPurchase_mc.value = (purchaseValue * purchaseCount).toString();
         var itemNameText:String = this.selectedListEntry.text;
         this.ModalConfirmPurchase_mc.tooltip = "";
         if(purchaseCount > 1)
         {
            itemNameText = itemNameText + (" (" + purchaseCount + ")");
         }
         if(!isPurchase && this.PlayerInventory_mc.currency + purchaseValue * purchaseCount > this.PlayerInventory_mc.currencyMax)
         {
            this.ModalConfirmPurchase_mc.Tooltip_mc.textField.height = this.m_ToolTipDefaultHeight + HEIGHT_BUFFER;
            currencyDif = this.PlayerInventory_mc.currencyMax - this.PlayerInventory_mc.currency;
            this.ModalConfirmPurchase_mc.tooltip = currencyDif > 0?"$SecureTrade_MaxCurrencyWarningDifference":"$SecureTrade_MaxCurrencyWarning";
            this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip.replace("{1}",currencyDif);
            this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip.replace("{2}",this.PlayerInventory_mc.currencyName);
            this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip + "\n\n";
         }
         this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip + itemNameText;
         stage.focus = this.ModalConfirmPurchase_mc;
         this.ModalConfirmPurchase_mc.open = true;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = true;
      }
      
      private function closeConfirmPurchaseModal(aDontEnableInput:Boolean = false) : void
      {
         // method body index: 1410 method index: 1410
         if(this.m_PreviousFocus != null)
         {
            stage.focus = this.m_PreviousFocus;
         }
         this.ModalConfirmPurchase_mc.open = false;
         this.ModalConfirmPurchase_mc.Tooltip_mc.textField.height = this.m_ToolTipDefaultHeight;
         this.m_PreviousFocus = null;
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = aDontEnableInput;
      }
      
      private function openConfirmTakeAllModal() : void
      {
         // method body index: 1411 method index: 1411
         this.m_PreviousFocus = stage.focus;
         this.ModalConfirmTakeAll_mc.header = "$Container_ConfirmTakeAll";
         stage.focus = this.ModalConfirmTakeAll_mc;
         this.ModalConfirmTakeAll_mc.open = true;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = true;
      }
      
      private function closeConfirmTakeAllModal() : void
      {
         // method body index: 1412 method index: 1412
         if(this.m_PreviousFocus != null)
         {
            stage.focus = this.m_PreviousFocus;
         }
         this.ModalConfirmTakeAll_mc.open = false;
         this.m_PreviousFocus = null;
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = false;
      }
      
      private function openSetPriceModal() : void
      {
         // method body index: 1413 method index: 1413
         this.ModalSetPrice_mc.tooltip = "$ItemWillBeAvailableForImmediatePurchase";
         var purchaseQuantity:Number = Math.min(this.selectedListEntry.count,this.ModalSetQuantity_mc.quantity);
         var priceString:String = purchaseQuantity > 1?"$SETPRICEPERITEM":"$SETITEMPRICE";
         this.ModalSetPrice_mc.OpenMenuRange(stage.focus,priceString,0,MAX_SELL_PRICE,this.selectedListEntry.itemValue,0,true);
         stage.focus = this.ModalSetPrice_mc;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = true;
      }
      
      private function openSetPriceModal_CheckWeight() : void
      {
         // method body index: 1414 method index: 1414
         var _fromContainer:* = this.selectedList == this.OfferInventory_mc;
         var purchaseQuantity:Number = Math.min(this.selectedListEntry.count,this.ModalSetQuantity_mc.quantity);
         if(_fromContainer || this.performContainerWeightCheck(this.selectedListEntry,purchaseQuantity))
         {
            this.openSetPriceModal();
         }
      }
      
      private function closeSetPriceModal() : void
      {
         // method body index: 1415 method index: 1415
         stage.focus = this.ModalSetPrice_mc.prevFocus;
         this.ModalSetPrice_mc.CloseMenu(true);
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = false;
      }
      
      private function openQuantityModal(aQuantityConfirmFn:Function, aSetPriceConfirmFn:Function = null) : void
      {
         // method body index: 1416 method index: 1416
         var count:int = this.selectedListEntry.count;
         this._OnQuantityConfirmedFn = aQuantityConfirmFn;
         this._OnSetPriceConfirmedFn = aSetPriceConfirmFn;
         if(count == 1)
         {
            this.ModalSetQuantity_mc.quantity = 1;
            aQuantityConfirmFn();
         }
         else
         {
            this.ModalSetQuantity_mc.tooltip = "";
            this.ModalSetQuantity_mc.OpenMenuRange(stage.focus,"$SETQUANTITY",1,count,count,0,true);
            stage.focus = this.ModalSetQuantity_mc;
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
            this.updateModalActive();
            this.updateButtonHints();
            this.disableInput = true;
         }
      }
      
      private function closeQuantityModal() : void
      {
         // method body index: 1417 method index: 1417
         stage.focus = this.ModalSetQuantity_mc.prevFocus;
         this.ModalSetQuantity_mc.CloseMenu(true);
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = false;
      }
      
      private function openUpgradeStashModal() : void
      {
         // method body index: 1418 method index: 1418
      }
      
      private function closeUpgradeStashModel() : void
      {
         // method body index: 1419 method index: 1419
         stage.focus = this.ModalUpgradeStash_mc.previousFocus;
         this.ModalUpgradeStash_mc.open = false;
         this.updateModalActive();
         this.updateButtonHints();
         this.disableInput = false;
      }
      
      private function updateCategoryBar() : void
      {
         // method body index: 1420 method index: 1420
         this.m_ItemFilters.splice(0);
         var bIsAidOnly:Boolean = this.m_MenuMode == MODE_FERMENTER || this.m_MenuMode == MODE_CAMP_DISPENSER || this.m_MenuMode == MODE_REFRIGERATOR;
         if(bIsAidOnly)
         {
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryAid",
               "flag":1 << 3
            });
         }
         else if(this.isScrapStash)
         {
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryJunk",
               "flag":1 << 10
            });
         }
         else if(this.m_MenuMode == MODE_ALLY)
         {
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryApparel",
               "flag":1 << 2
            });
         }
         else
         {
            this.m_ItemFilters.push({
               "text":"$INVENTORY",
               "flag":4294967295
            });
            if(this.m_MenuMode != MODE_PLAYERVENDING)
            {
               this.m_ItemFilters.push({
                  "text":"$InventoryCategoryFavorites",
                  "flag":1 << 0
               });
            }
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryWeapons",
               "flag":1 << 1
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryApparel",
               "flag":1 << 2
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryAid",
               "flag":1 << 3
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryMisc",
               "flag":1 << 9
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryHolo",
               "flag":1 << 13
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryNotes",
               "flag":1 << 7
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryJunk",
               "flag":1 << 10
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryMods",
               "flag":1 << 11
            });
            this.m_ItemFilters.push({
               "text":"$InventoryCategoryAmmo",
               "flag":1 << 12
            });
         }
         this.m_TabMax = this.m_ItemFilters.length;
         this.CategoryBar_mc.Clear();
         this.CategoryBar_mc.forceUppercase = false;
         if(bIsAidOnly)
         {
            this.CategoryBar_mc.maxVisible = 1;
            this.CategoryBar_mc.AddLabel("$InventoryCategoryAid",1 << 3,true);
         }
         else if(this.isScrapStash)
         {
            this.CategoryBar_mc.maxVisible = 1;
            this.CategoryBar_mc.AddLabel("$InventoryCategoryJunk",1 << 10,true);
         }
         else if(this.m_MenuMode == MODE_ALLY)
         {
            this.CategoryBar_mc.maxVisible = 1;
            this.CategoryBar_mc.AddLabel("$InventoryCategoryApparel",1 << 2,true);
         }
         else
         {
            this.CategoryBar_mc.maxVisible = this.m_MenuMode == MODE_PLAYERVENDING?uint(9):uint(11);
            this.CategoryBar_mc.AddLabel("$INVENTORY",4294967295,true);
            if(this.m_MenuMode != MODE_PLAYERVENDING)
            {
               this.CategoryBar_mc.AddLabel("$InventoryCategoryFavorites",1 << 0,true);
            }
            this.CategoryBar_mc.AddLabel("$InventoryCategoryWeapons",1 << 1,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryApparel",1 << 2,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryAid",1 << 3,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryMisc",1 << 9,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryHolo",1 << 13,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryNotes",1 << 7,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryJunk",1 << 10,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryMods",1 << 11,true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryAmmo",1 << 12,true);
         }
         this.CategoryBar_mc.Finalize();
         this.CategoryBar_mc.SetSelection(this.selectedTab,true,false);
      }
      
      private function ModeToButtonSwitchText(aMode:uint) : String
      {
         // method body index: 1421 method index: 1421
         if(this.isScrapStash)
         {
            return "$LimitedTypeStorageOverrideName_Scrap";
         }
         switch(aMode)
         {
            case MODE_CONTAINER:
               return "$CONTAINER";
            case MODE_NPCVENDING:
               return "$VENDOR";
            case MODE_PLAYERVENDING:
               return this.m_DefaultHeaderText;
            case MODE_VENDING_MACHINE:
               return "$VENDOR";
            case MODE_DISPLAY_CASE:
               return "$DISPLAY";
            case MODE_FERMENTER:
               return "$FERMENTER";
            case MODE_REFRIGERATOR:
               return "$REFRIGERATOR";
            case MODE_CAMP_DISPENSER:
               return "$DISPENSER";
            case MODE_ALLY:
               return "$ALLY";
            default:
               return "";
         }
      }
      
      private function UpdateButtonToggleAssignText(selectedEntry:Object) : void
      {
         // method body index: 1422 method index: 1422
         switch(selectedEntry.vendingData.machineType)
         {
            case SecureTradeShared.MACHINE_TYPE_INVALID:
               this.ButtonToggleAssign.ButtonText = this.m_MenuMode == SecureTradeShared.MACHINE_TYPE_VENDING?"$SELL":"$SecureTrade_InsertItem";
               break;
            case SecureTradeShared.MACHINE_TYPE_VENDING:
               this.ButtonToggleAssign.ButtonText = "$CANCEL SALE";
               break;
            case SecureTradeShared.MACHINE_TYPE_DISPLAY:
            case SecureTradeShared.MACHINE_TYPE_DISPENSER:
            case SecureTradeShared.MACHINE_TYPE_FERMENTER:
            case SecureTradeShared.MACHINE_TYPE_REFRIGERATOR:
            case SecureTradeShared.MACHINE_TYPE_ALLY:
               this.ButtonToggleAssign.ButtonText = "$SecureTrade_RemoveDisplayedItem";
         }
      }
      
      private function updateButtonHints() : void
      {
         // method body index: 1423 method index: 1423
         var buttonHintData:BSButtonHintData = null;
         var _selectedEntry:Object = null;
         var isPlayerInventorySelected:* = false;
         var isOfferListSelected:* = false;
         var isNothingSelected:Boolean = false;
         var bHasAnyScrappableEntries:Boolean = false;
         var item:Object = null;
         if(this.selectedList == null)
         {
            return;
         }
         this.DeclineItemAcceptButton.ButtonVisible = this.ModalDeclineItem_mc.Active;
         this.DeclineItemCancelButton.ButtonVisible = this.ModalDeclineItem_mc.Active;
         if(this.modalActive)
         {
            for each(buttonHintData in this.ButtonHintDataV)
            {
               if(buttonHintData != this.DeclineItemAcceptButton && buttonHintData != this.DeclineItemCancelButton)
               {
                  buttonHintData.ButtonVisible = false;
               }
            }
         }
         else
         {
            _selectedEntry = this.selectedListEntry;
            isPlayerInventorySelected = this.selectedList == this.PlayerInventory_mc;
            isOfferListSelected = this.selectedList == this.OfferInventory_mc;
            isNothingSelected = this.selectedList == null || _selectedEntry == null;
            this.ButtonPlayerInventory.ButtonVisible = uiController != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && this.OfferInventory_mc.Active && !this.m_onlyGivingAllowed && !this.m_onlyTakingAllowed && !this.m_isWorkbench && !this.m_PlayerInventoryEmpty;
            this.ButtonContainerInventory.ButtonVisible = uiController != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && this.PlayerInventory_mc.Active && !this.m_onlyGivingAllowed && !this.m_onlyTakingAllowed && !this.m_isWorkbench && !this.m_ContainerEmpty;
            this.SortButton.ButtonVisible = true;
            this.SortButton.ButtonText = this.m_SortFieldText[!!isPlayerInventorySelected?this.m_PlayerInventorySortField:this.m_OfferInventorySortField];
            this.ExitButton.ButtonVisible = true;
            this.InspectButton.ButtonDisabled = this.selectedList == null || _selectedEntry == null;
            this.ScrapButton.ButtonVisible = !isNothingSelected && (this.m_isWorkbench || this.m_isWorkshop) && this.m_scrapAllowedFlag != 0;
            if(this.ScrapButton.ButtonVisible)
            {
               this.ScrapButton.ButtonDisabled = _selectedEntry.scrapAllowed != true || (_selectedEntry.filterFlag & this.m_scrapAllowedFlag) == 0;
            }
            this.StoreJunkButton.ButtonVisible = this.m_isWorkbench || this.m_isWorkshop || this.m_isStash || this.isScrapStash;
            if(this.StoreJunkButton.ButtonVisible)
            {
               if(this.isScrapStash)
               {
                  bHasAnyScrappableEntries = false;
                  for each(item in this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData)
                  {
                     if(item.isAutoScrappable || item.canGoIntoScrapStash)
                     {
                        bHasAnyScrappableEntries = true;
                        break;
                     }
                  }
                  this.StoreJunkButton.ButtonDisabled = !this.m_IsFollowerOfZeus || !bHasAnyScrappableEntries;
                  this.StoreJunkButton.ButtonText = "$SCRAPBOXSCRAPANDSTORE";
               }
               else
               {
                  this.StoreJunkButton.ButtonDisabled = !!this.m_isWorkbench?!this.m_playerHasAutoScrappableJunkItems:!this.m_playerHasMiscItems;
                  this.StoreJunkButton.ButtonText = !!this.m_isWorkbench?"$ScrapAllJunk":"$StoreAllJunk";
               }
            }
            this.UpgradeStashButton.ButtonVisible = false;
            this.ToggleShowMarkedItemsOnlyButton.ButtonVisible = this.isCampVendingMenuType() && this.m_OwnsVendor;
            switch(this.m_FilterItemsOption)
            {
               case FILTER_OPTION_NONE:
                  this.ToggleShowMarkedItemsOnlyButton.ButtonText = "$SecureTrade_ToggleShowMarked_ShowMarkedOnly";
                  break;
               case FILTER_OPTION_THIS_MACHINE:
                  this.ToggleShowMarkedItemsOnlyButton.ButtonText = "$SecureTrade_ToggleShowMarked_ShowMarkedAndStash";
                  break;
               case FILTER_OPTION_THIS_MACHINE_AND_STASH:
                  this.ToggleShowMarkedItemsOnlyButton.ButtonText = "$SecureTrade_ToggleShowMarked_ShowAll";
            }
            this.AcceptButton.ButtonVisible = !this.m_isWorkbench && !isNothingSelected;
            switch(this.m_MenuMode)
            {
               case MODE_CONTAINER:
                  this.ButtonDecline.ButtonVisible = false;
                  this.ButtonToggleAssign.ButtonVisible = _selectedEntry && isOfferListSelected && _selectedEntry.vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID;
                  if(this.ButtonToggleAssign.ButtonVisible)
                  {
                     this.UpdateButtonToggleAssignText(_selectedEntry);
                  }
                  this.InspectButton.ButtonVisible = true;
                  if(this.AcceptButton.ButtonVisible)
                  {
                     this.AcceptButton.ButtonDisabled = false;
                     if(isOfferListSelected)
                     {
                        this.AcceptButton.ButtonText = this.m_AcceptBtnText_Container;
                     }
                     else if(this.isScrapStash && _selectedEntry.scrapAllowed)
                     {
                        this.AcceptButton.ButtonText = "$SCRAP";
                     }
                     else
                     {
                        this.AcceptButton.ButtonText = this.m_AcceptBtnText_Player;
                     }
                  }
                  this.TakeAllButton.ButtonVisible = !this.m_isWorkbench && !this.m_isCamp && !this.m_isStash && !this.m_onlyGivingAllowed && !this.isScrapStash;
                  if(this.TakeAllButton.ButtonVisible)
                  {
                     this.TakeAllButton.ButtonText = this.m_TakeAllBtnText;
                  }
                  this.ButtonOffersOnly.ButtonVisible = false;
                  break;
               case MODE_NPCVENDING:
                  this.ButtonDecline.ButtonVisible = isOfferListSelected && _selectedEntry != null && _selectedEntry.isOffered;
                  this.ButtonToggleAssign.ButtonVisible = false;
                  this.InspectButton.ButtonVisible = true;
                  if(this.AcceptButton.ButtonVisible)
                  {
                     this.AcceptButton.ButtonDisabled = !isOfferListSelected && this.m_VendorSellOnly;
                     this.AcceptButton.ButtonText = !!isOfferListSelected?"$BUY":"$SELL";
                  }
                  this.TakeAllButton.ButtonVisible = false;
                  this.ButtonOffersOnly.ButtonVisible = false;
                  break;
               case MODE_PLAYERVENDING:
                  this.ButtonDecline.ButtonVisible = isOfferListSelected && _selectedEntry != null && _selectedEntry.isOffered;
                  this.ButtonToggleAssign.ButtonVisible = false;
                  this.InspectButton.ButtonVisible = true;
                  if(this.AcceptButton.ButtonVisible)
                  {
                     this.AcceptButton.ButtonDisabled = isOfferListSelected && _selectedEntry.isTradable == false;
                     if(isOfferListSelected)
                     {
                        this.AcceptButton.ButtonText = !!_selectedEntry.isOffered?"$BUY":!!_selectedEntry.isRequested?"$CANCEL":"$REQUEST";
                     }
                     else
                     {
                        this.AcceptButton.ButtonText = "$OFFER";
                     }
                  }
                  this.TakeAllButton.ButtonVisible = false;
                  this.ButtonOffersOnly.ButtonVisible = true;
                  this.ButtonOffersOnly.ButtonText = !!this.m_ShowOffersOnly?"$SHOWALL":"$OFFERSONLY";
                  this.ButtonOffersOnly.ButtonDisabled = !this.m_PlayerConnected;
                  break;
               case MODE_VENDING_MACHINE:
                  this.ButtonDecline.ButtonVisible = false;
                  this.ButtonToggleAssign.ButtonVisible = this.m_OwnsVendor && _selectedEntry != null && isOfferListSelected;
                  if(this.ButtonToggleAssign.ButtonVisible)
                  {
                     this.UpdateButtonToggleAssignText(_selectedEntry);
                  }
                  this.InspectButton.ButtonVisible = true;
                  if(isPlayerInventorySelected && !this.m_OwnsVendor)
                  {
                     this.AcceptButton.ButtonVisible = false;
                  }
                  if(this.AcceptButton.ButtonVisible)
                  {
                     this.AcceptButton.ButtonDisabled = false;
                     if(this.m_OwnsVendor)
                     {
                        this.AcceptButton.ButtonText = !!isOfferListSelected?this.m_AcceptBtnText_Container:"$SELL";
                     }
                     else
                     {
                        this.AcceptButton.ButtonText = "$BUY";
                     }
                  }
                  this.TakeAllButton.ButtonVisible = false;
                  this.ButtonOffersOnly.ButtonVisible = false;
                  break;
               case MODE_DISPLAY_CASE:
               case MODE_ALLY:
               case MODE_FERMENTER:
               case MODE_REFRIGERATOR:
               case MODE_CAMP_DISPENSER:
                  this.ButtonDecline.ButtonVisible = false;
                  this.ButtonToggleAssign.ButtonVisible = this.m_OwnsVendor && _selectedEntry != null && isOfferListSelected;
                  if(this.ButtonToggleAssign.ButtonVisible)
                  {
                     this.ButtonToggleAssign.ButtonDisabled = this.m_ProcessingItemEvent;
                     this.UpdateButtonToggleAssignText(_selectedEntry);
                  }
                  this.InspectButton.ButtonVisible = true;
                  if(isPlayerInventorySelected && !this.m_OwnsVendor)
                  {
                     this.AcceptButton.ButtonVisible = false;
                  }
                  if(this.AcceptButton.ButtonVisible)
                  {
                     this.AcceptButton.ButtonDisabled = this.m_ProcessingItemEvent;
                     this.AcceptButton.ButtonText = !!isOfferListSelected?this.m_AcceptBtnText_Container:this.m_AcceptBtnText_Player_Assign;
                  }
                  this.TakeAllButton.ButtonVisible = false;
                  this.ButtonOffersOnly.ButtonVisible = false;
            }
            if(this.ButtonContainerInventory.ButtonVisible)
            {
               this.ButtonContainerInventory.ButtonText = this.ModeToButtonSwitchText(this.m_MenuMode);
            }
         }
      }
      
      private function updateInventoryFocus() : void
      {
         // method body index: 1424 method index: 1424
         if(this.m_onlyTakingAllowed)
         {
            if(this.selectedList != this.OfferInventory_mc)
            {
               this.onSwapInventoryContainer();
            }
         }
         else if(this.m_onlyGivingAllowed || this.m_isWorkbench)
         {
            if(this.selectedList != this.PlayerInventory_mc)
            {
               this.onSwapInventoryPlayer();
            }
         }
         else if(!this.m_PlayerInventoryEmpty && !this.m_ContainerEmpty && this.m_StartingFocusPref != STARTING_FOCUS_PREF_NONE)
         {
            if(this.m_StartingFocusPref == STARTING_FOCUS_PREF_PLAYER)
            {
               this.onSwapInventoryPlayer();
            }
            else if(this.m_StartingFocusPref == STARTING_FOCUS_PREF_CONTAINER)
            {
               this.onSwapInventoryContainer();
            }
            this.m_StartingFocusPref = STARTING_FOCUS_PREF_NONE;
         }
         else if(this.m_PlayerInventoryEmpty && !this.m_ContainerEmpty && this.selectedList == this.PlayerInventory_mc)
         {
            this.onSwapInventoryContainer();
         }
         else if(this.m_ContainerEmpty && !this.m_PlayerInventoryEmpty && this.selectedList == this.OfferInventory_mc)
         {
            this.onSwapInventoryPlayer();
         }
      }
      
      private function onBackButton() : void
      {
         // method body index: 1425 method index: 1425
         this.ClearSelectedItemValues();
         var playSound:Boolean = true;
         if(this.ModalSetPrice_mc.opened)
         {
            this.closeSetPriceModal();
         }
         else if(this.ModalSetQuantity_mc.opened)
         {
            this.closeQuantityModal();
         }
         else if(this.ModalDeclineItem_mc.Active)
         {
            this.closeDeclineItemModal();
         }
         else if(this.ModalConfirmPurchase_mc.open)
         {
            this.closeConfirmPurchaseModal();
         }
         else if(this.ModalConfirmTakeAll_mc.open)
         {
            this.closeConfirmTakeAllModal();
         }
         else if(this.ModalConfirmScrap_mc.open)
         {
            this.ModalConfirmScrap_mc.HandleSecondaryAction();
            playSound = false;
         }
         else if(this.ModalUpgradeStash_mc.open)
         {
            this.closeUpgradeStashModel();
         }
         else
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_MENU_EXIT,{}));
         }
         if(playSound)
         {
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_CANCEL);
         }
      }
      
      private function onUpgradeButton() : void
      {
         // method body index: 1426 method index: 1426
         this.openUpgradeStashModal();
      }
      
      private function onSwapInventoryPlayer() : void
      {
         // method body index: 1427 method index: 1427
         this.selectedList = this.PlayerInventory_mc as SecureTradeInventory;
         if(uiController != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && this.selectedList.ItemList_mc.List_mc.selectedIndex == -1)
         {
            this.selectedList.ItemList_mc.List_mc.selectedIndex = 0;
         }
         this.updateButtonHints();
      }
      
      private function onSwapInventoryContainer() : void
      {
         // method body index: 1428 method index: 1428
         this.selectedList = this.OfferInventory_mc as SecureTradeInventory;
         if(uiController != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && this.selectedList.ItemList_mc.List_mc.selectedIndex == -1)
         {
            this.selectedList.ItemList_mc.List_mc.selectedIndex = 0;
         }
         this.updateButtonHints();
      }
      
      private function onRequestSort(aIncrementSort:Boolean = true) : void
      {
         // method body index: 1429 method index: 1429
         var filterIndex:* = 0;
         if(this.isScrapStash)
         {
            filterIndex = this.JUNK_TAB_INDEX;
         }
         else if(this.m_MenuMode == MODE_PLAYERVENDING)
         {
            if(this.m_SelectedTab > this.PLAYERVENDING_WEAPONS_TAB_INDEX)
            {
               filterIndex = this.m_SelectedTab - this.PLAYERVENDING_WEAPONS_TAB_INDEX;
            }
         }
         else if(this.m_SelectedTab > this.WEAPONS_TAB_INDEX)
         {
            filterIndex = this.m_SelectedTab - this.WEAPONS_TAB_INDEX;
         }
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_REQUEST_SORT,{
            "isPlayerInventory":this.selectedList == this.PlayerInventory_mc,
            "filter":filterIndex,
            "incrementSort":aIncrementSort,
            "tabIndex":this.m_SelectedTab
         }));
      }
      
      private function onAccept() : void
      {
         // method body index: 1430 method index: 1430
         var playSound:Boolean = true;
         if(this.ModalConfirmPurchase_mc.open)
         {
            this.onConfirmPurchaseAccept();
         }
         else if(this.ModalConfirmTakeAll_mc.open)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TAKE_ALL,{}));
         }
         else if(this.ModalConfirmScrap_mc.open)
         {
            this.ModalConfirmScrap_mc.HandlePrimaryAction();
            playSound = false;
         }
         else if(this.ModalUpgradeStash_mc.open)
         {
            this.onUpgradeStashAccepted();
         }
         if(playSound)
         {
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
         }
      }
      
      private function selectItemViaHandleID(aItemList:MenuListComponent) : void
      {
         // method body index: 1431 method index: 1431
         var listData:Array = null;
         var i:uint = 0;
         var tempSelectionDisabled:Boolean = false;
         if(!this.selectedListEntry || this.selectedListEntry.serverHandleId != this.m_SelectedItemServerHandleId)
         {
            listData = aItemList.List_mc.MenuListData;
            for(i = 0; i < listData.length; i++)
            {
               if(listData[i].serverHandleId == this.m_SelectedItemServerHandleId)
               {
                  tempSelectionDisabled = aItemList.disableSelection_Inspectable;
                  aItemList.disableSelection_Inspectable = false;
                  aItemList.setSelectedIndex(i);
                  aItemList.disableSelection_Inspectable = tempSelectionDisabled;
                  break;
               }
            }
         }
      }
      
      private function selectStackViaNameCount(aItemList:MenuListComponent, aName:String, aCount:Number) : void
      {
         // method body index: 1432 method index: 1432
         var listData:Array = null;
         var i:uint = 0;
         var tempSelectionDisabled:Boolean = false;
         if(!this.selectedListEntry || this.selectedListEntry.text != aName || this.selectedListEntry.count != aCount || this.selectedListEntry.vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID)
         {
            listData = aItemList.List_mc.MenuListData;
            for(i = 0; i < listData.length; i++)
            {
               if(listData[i].text == aName && listData[i].count == aCount && listData[i].vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID)
               {
                  tempSelectionDisabled = aItemList.disableSelection_Inspectable;
                  aItemList.disableSelection_Inspectable = false;
                  aItemList.setSelectedIndex(i);
                  aItemList.disableSelection_Inspectable = tempSelectionDisabled;
                  break;
               }
            }
         }
      }
      
      private function PopulateOfferInventory(listData:Array) : void
      {
         // method body index: 1433 method index: 1433
         this.SortListData(listData,this.m_OfferInventorySortField);
         this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData = listData;
         if(this.selectedList == this.OfferInventory_mc)
         {
            if(this.m_RefreshSelectionOption == REFRESH_SELECTION_SERVER_ID && this.m_SelectedItemServerHandleId > 0)
            {
               this.selectItemViaHandleID(this.OfferInventory_mc.ItemList_mc);
            }
            else if(this.m_RefreshSelectionOption == REFRESH_SELECTION_NAME_COUNT)
            {
               this.selectStackViaNameCount(this.OfferInventory_mc.ItemList_mc,this.m_SelectedStackName,this.m_SelectedItemCount - 1);
            }
         }
         this.OfferInventory_mc.ItemList_mc.SetIsDirty();
         this.OfferInventory_mc.UpdateTooltips();
         this.m_ContainerEmpty = this.IsInventoryEmpty(this.OfferInventory_mc);
         if(this.m_MenuMode == MODE_PLAYERVENDING && this.selectedList == this.OfferInventory_mc && this.modalActive && this.SelectedOfferChanged(this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData))
         {
            this.onBackButton();
            GlobalFunc.ShowHUDMessage("$TradeOfferChanged");
         }
         this.updateInventoryFocus();
         this.onSelectedDataChanged(null);
      }
      
      private function PopulatePlayerInventory(listData:Array) : void
      {
         // method body index: 1434 method index: 1434
         var i:uint = 0;
         this.SortListData(listData,this.m_PlayerInventorySortField);
         this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData = listData;
         if(this.selectedList == this.PlayerInventory_mc)
         {
            if(this.m_RefreshSelectionOption == REFRESH_SELECTION_SERVER_ID && this.m_SelectedItemServerHandleId > 0)
            {
               this.selectItemViaHandleID(this.PlayerInventory_mc.ItemList_mc);
            }
            else if(this.m_RefreshSelectionOption == REFRESH_SELECTION_NAME_COUNT)
            {
               this.selectStackViaNameCount(this.PlayerInventory_mc.ItemList_mc,this.m_SelectedStackName,this.m_SelectedItemCount - 1);
            }
         }
         this.PlayerInventory_mc.ItemList_mc.SetIsDirty();
         this.PlayerInventory_mc.UpdateToolTipText();
         this.m_playerHasMiscItems = false;
         this.m_playerHasAutoScrappableJunkItems = false;
         if(listData is Array)
         {
            for(i = 0; i < listData.length; i++)
            {
               if((listData[i].filterFlag & 1 << 10) > 0)
               {
                  this.m_playerHasMiscItems = true;
               }
               if((listData[i].filterFlag & 1 << 15) > 0)
               {
                  this.m_playerHasAutoScrappableJunkItems = true;
               }
               if(this.m_playerHasMiscItems == true && this.m_playerHasAutoScrappableJunkItems == true)
               {
                  break;
               }
            }
         }
         if(this.m_MenuMode == MODE_PLAYERVENDING && this.selectedList == this.PlayerInventory_mc && this.modalActive && this.SelectedOfferChanged(this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData,true))
         {
            this.onBackButton();
            GlobalFunc.ShowHUDMessage("$TradeOfferChanged");
         }
         this.m_PlayerInventoryEmpty = this.PlayerInventory_mc != null && this.IsInventoryEmpty(this.PlayerInventory_mc);
         this.updateButtonHints();
         this.onSelectedDataChanged(null);
      }
      
      private function onToggleShowMarkedItemsOnlyButton() : void
      {
         // method body index: 1435 method index: 1435
         if(!this.isCampVendingMenuType() || !this.m_OwnsVendor)
         {
            return;
         }
         this.m_FilterItemsOption++;
         if(this.m_FilterItemsOption == FILTER_OPTION_COUNT)
         {
            this.m_FilterItemsOption = FILTER_OPTION_NONE;
         }
         this.SetSelectedItemValues(this.selectedListEntry);
         this.PopulateCampVendingInventory();
         this.updateButtonHints();
         this.ClearSelectedItemValues();
      }
      
      private function PopulateCampVendingInventory() : void
      {
         // method body index: 1438 method index: 1438
         if(!this.isCampVendingMenuType())
         {
            return;
         }
         if(this.m_OwnsVendor)
         {
            this.UpdatePartialItems(this.m_OtherInvData,this.m_TheirOffersData);
         }
         var listData:Array = !!this.m_OwnsVendor?this.m_OtherInvData:this.m_TheirOffersData;
         switch(this.m_FilterItemsOption)
         {
            case FILTER_OPTION_THIS_MACHINE:
               listData = listData.filter(function(itemData:Object):// method body index: 1436 method index: 1436
               Boolean
               {
                  // method body index: 1436 method index: 1436
                  var vendingData:* = itemData.vendingData;
                  return vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID && !vendingData.isVendedOnOtherMachine;
               });
               break;
            case FILTER_OPTION_THIS_MACHINE_AND_STASH:
               listData = listData.filter(function(itemData:Object):// method body index: 1437 method index: 1437
               Boolean
               {
                  // method body index: 1437 method index: 1437
                  var vendingData:* = itemData.vendingData;
                  return vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID || !vendingData.isVendedOnOtherMachine;
               });
         }
         this.SortListData(listData,this.m_OfferInventorySortField);
         this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData = listData;
         if(this.selectedList == this.OfferInventory_mc)
         {
            if(this.m_RefreshSelectionOption == REFRESH_SELECTION_SERVER_ID && this.m_SelectedItemServerHandleId > 0)
            {
               this.selectItemViaHandleID(this.OfferInventory_mc.ItemList_mc);
            }
            else if(this.m_RefreshSelectionOption == REFRESH_SELECTION_NAME_COUNT)
            {
               this.selectStackViaNameCount(this.OfferInventory_mc.ItemList_mc,this.m_SelectedStackName,this.m_SelectedItemCount - 1);
            }
         }
         this.OfferInventory_mc.ItemList_mc.SetIsDirty();
         this.OfferInventory_mc.UpdateTooltips();
         this.m_ContainerEmpty = this.IsInventoryEmpty(this.OfferInventory_mc);
         if(this.selectedList == this.OfferInventory_mc && this.modalActive && this.SelectedOfferChanged(this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData))
         {
            this.onBackButton();
            GlobalFunc.ShowHUDMessage("$TradeOfferChanged");
         }
         this.updateInventoryFocus();
         this.onSelectedDataChanged(null);
      }
      
      public function ProcessUserEvent(strEventName:String, abPressed:Boolean) : Boolean
      {
         // method body index: 1439 method index: 1439
         var bHasAnyScrappableEntries:Boolean = false;
         var item:Object = null;
         var bhandled:Boolean = false;
         if(this.m_IgnorePlayerVendingItemPress && abPressed && strEventName == "Accept")
         {
            this.m_IgnorePlayerVendingItemPress = false;
         }
         if(this.ModalSetPrice_mc.opened)
         {
            bhandled = this.ModalSetPrice_mc.ProcessUserEvent(this.ConvertEventString(strEventName),abPressed);
         }
         if(!bhandled && this.ModalSetQuantity_mc.opened)
         {
            bhandled = this.ModalSetQuantity_mc.ProcessUserEvent(this.ConvertEventString(strEventName),abPressed);
         }
         if(!bhandled && this.isOpen && !abPressed)
         {
            switch(strEventName)
            {
               case "SwitchToPlayer":
                  if(this.ButtonPlayerInventory.ButtonVisible == true && this.ButtonPlayerInventory.ButtonDisabled != true && this.m_PlayerInventoryEmpty != true)
                  {
                     this.onSwapInventoryPlayer();
                     bhandled = true;
                  }
                  break;
               case "SwitchToContainer":
                  if(this.ButtonContainerInventory.ButtonVisible == true && this.ButtonContainerInventory.ButtonDisabled != true && this.m_ContainerEmpty != true)
                  {
                     this.onSwapInventoryContainer();
                     bhandled = true;
                  }
                  break;
               case "DeclineItem":
                  if(this.InspectButton.ButtonVisible == true && this.InspectButton.ButtonDisabled != true)
                  {
                     this.onInspectItem();
                     bhandled = true;
                  }
                  break;
               case "SortList":
                  if(!this.modalActive)
                  {
                     this.onRequestSort();
                     bhandled = true;
                  }
                  break;
               case "TakeAll":
                  if(this.ButtonDecline.ButtonVisible == true && this.ButtonDecline.ButtonDisabled != true)
                  {
                     this.onDeclineItem();
                     bhandled = true;
                  }
                  else if(this.ButtonToggleAssign.ButtonVisible == true && this.ButtonToggleAssign.ButtonDisabled != true)
                  {
                     this.onToggleAssign();
                     bhandled = true;
                  }
                  else if(this.TakeAllButton.ButtonVisible == true && this.TakeAllButton.ButtonDisabled != true)
                  {
                     this.onTakeAll();
                     bhandled = true;
                  }
                  break;
               case "StoreAllJunk":
                  if(this.StoreJunkButton.ButtonVisible == true)
                  {
                     if(this.StoreJunkButton.ButtonDisabled)
                     {
                        if(this.isScrapStash)
                        {
                           bHasAnyScrappableEntries = false;
                           for each(item in this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData)
                           {
                              if(item.isAutoScrappable || item.canGoIntoScrapStash)
                              {
                                 bHasAnyScrappableEntries = true;
                                 break;
                              }
                           }
                           if(!this.m_IsFollowerOfZeus)
                           {
                              GlobalFunc.ShowHUDMessage("$StoreJunkFailNoFO1st");
                           }
                           else if(!bHasAnyScrappableEntries)
                           {
                              GlobalFunc.ShowHUDMessage("$StoreJunkFailNoScrappableItems");
                           }
                        }
                     }
                     else
                     {
                        this.onStoreJunk();
                     }
                     bhandled = true;
                  }
                  else if(this.ButtonOffersOnly.ButtonVisible == true && this.ButtonOffersOnly.ButtonDisabled != true)
                  {
                     this.onOffersOnly();
                     bhandled = true;
                  }
                  else if(this.ToggleShowMarkedItemsOnlyButton.ButtonVisible == true && this.ToggleShowMarkedItemsOnlyButton.ButtonDisabled != true)
                  {
                     this.onToggleShowMarkedItemsOnlyButton();
                     bhandled = true;
                  }
                  break;
               case "Select":
                  if(!this.modalActive)
                  {
                     this.onUpgradeButton();
                  }
                  break;
               case "Cancel":
                  this.onBackButton();
                  bhandled = true;
            }
         }
         return bhandled;
      }
      
      private function SortListData(aListData:Array, aSortField:int) : void
      {
         // method body index: 1441 method index: 1441
         if(aListData != null)
         {
            aListData.sort(function(aItem1:Object, aItem2:Object):// method body index: 1440 method index: 1440
            int
            {
               // method body index: 1440 method index: 1440
               var propName:String = null;
               var aItem1Percent:Number = NaN;
               var aItem2Percent:Number = NaN;
               var returnVal:int = 0;
               if(aItem1.vendingData.isVendedOnOtherMachine && aItem2.isOffered && !aItem2.vendingData.isVendedOnOtherMachine)
               {
                  returnVal = 1;
               }
               else if(aItem1.isOffered && !aItem1.vendingData.isVendedOnOtherMachine && aItem2.vendingData.isVendedOnOtherMachine)
               {
                  returnVal = -1;
               }
               else if(aItem1.vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID && aItem2.vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID)
               {
                  returnVal = 1;
               }
               else if(aItem1.vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID && aItem2.vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID)
               {
                  returnVal = -1;
               }
               else if(aItem1.vendingData.machineType < aItem2.vendingData.machineType)
               {
                  returnVal = -1;
               }
               else if(aItem1.vendingData.machineType > aItem2.vendingData.machineType)
               {
                  returnVal = 1;
               }
               else
               {
                  propName = "";
                  switch(aSortField)
                  {
                     case SOF_DAMAGE:
                        propName = "damage";
                        break;
                     case SOF_ROF:
                        propName = "weaponDisplayRateOfFire";
                        break;
                     case SOF_RANGE:
                        propName = "weaponDisplayRange";
                        break;
                     case SOF_ACCURACY:
                        propName = "weaponDisplayAccuracy";
                        break;
                     case SOF_VALUE:
                        propName = "itemValue";
                        break;
                     case SOF_WEIGHT:
                        propName = "weight";
                        break;
                     case SOF_SPOILAGE:
                        aItem1Percent = aItem1.currentHealth >= 0?Number(aItem1.currentHealth / aItem1.maximumHealth):Number(1);
                        aItem2Percent = aItem2.currentHealth >= 0?Number(aItem2.currentHealth / aItem2.maximumHealth):Number(1);
                        if(aItem1Percent != aItem2Percent)
                        {
                           returnVal = aItem1Percent < aItem2Percent?-1:1;
                        }
                        break;
                     default:
                        propName = "isLearnedRecipe";
                  }
                  if(propName != "")
                  {
                     if(aItem1[propName] < aItem2[propName])
                     {
                        returnVal = 1;
                     }
                     else if(aItem1[propName] > aItem2[propName])
                     {
                        returnVal = -1;
                     }
                  }
               }
               if(returnVal == 0)
               {
                  if(aItem1.text < aItem2.text)
                  {
                     returnVal = -1;
                  }
                  else if(aItem1.text > aItem2.text)
                  {
                     returnVal = 1;
                  }
                  else if(aItem1.count < aItem2.count)
                  {
                     returnVal = -1;
                  }
                  else if(aItem1.count > aItem2.count)
                  {
                     returnVal = 1;
                  }
               }
               if(returnVal == 0)
               {
                  if(aItem1.serverHandleId < aItem2.serverHandleId)
                  {
                     returnVal = 1;
                  }
                  else if(aItem1.serverHandleId > aItem2.serverHandleId)
                  {
                     returnVal = -1;
                  }
               }
               return returnVal;
            });
         }
      }
      
      private function CreateScrappableInventoryList(aListData:Array) : Array
      {
         // method body index: 1442 method index: 1442
         var item:Object = null;
         var scrappableInventory:Array = new Array();
         for each(item in aListData)
         {
            if(item.scrapAllowed)
            {
               scrappableInventory.push(item);
            }
         }
         return scrappableInventory;
      }
      
      private function ConvertEventString(eventName:String) : String
      {
         // method body index: 1443 method index: 1443
         if(eventName == "SwitchToContainer")
         {
            return "RTrigger";
         }
         if(eventName == "SwitchToPlayer")
         {
            return "LTrigger";
         }
         return eventName;
      }
      
      private function IsInventoryEmpty(aInventoryMC:MovieClip) : Boolean
      {
         // method body index: 1444 method index: 1444
         var inventoryEmpty:* = true;
         var filterEmtpty:Boolean = true;
         if(aInventoryMC != null)
         {
            if(aInventoryMC.ItemList_mc.List_mc.MenuListData != undefined && aInventoryMC.ItemList_mc.List_mc.MenuListData != null)
            {
               inventoryEmpty = aInventoryMC.ItemList_mc.List_mc.MenuListData.length == 0;
            }
            if(aInventoryMC.ItemList_mc.List_mc.filterer != undefined && aInventoryMC.ItemList_mc.List_mc.filterer != null)
            {
               filterEmtpty = aInventoryMC.ItemList_mc.List_mc.filterer.IsFilterEmpty(this.m_ItemFilters[this.m_SelectedTab].flag);
            }
         }
         return inventoryEmpty || filterEmtpty;
      }
      
      private function SetSelectedItemValues(itemData:Object) : void
      {
         // method body index: 1445 method index: 1445
         if(itemData != null && !this.m_SelectedItemValueSet)
         {
            this.m_SelectedStackName = itemData.text;
            this.m_SelectedItemOffered = itemData.isOffered;
            this.m_SelectedItemValue = itemData.itemValue;
            this.m_SelectedItemCount = itemData.count;
            this.m_SelectedItemServerHandleId = itemData.serverHandleId;
            this.m_SelectedItemIsPartialOffer = itemData.partialOffer;
            this.m_RefreshSelectionOption = REFRESH_SELECTION_SERVER_ID;
            this.m_SelectedItemValueSet = true;
         }
      }
      
      private function ClearSelectedItemValues() : void
      {
         // method body index: 1446 method index: 1446
         this.m_SelectedStackName = "";
         this.m_SelectedItemOffered = false;
         this.m_SelectedItemValue = 0;
         this.m_SelectedItemCount = 0;
         this.m_SelectedItemServerHandleId = 0;
         this.m_SelectedItemIsPartialOffer = false;
         this.m_RefreshSelectionOption = REFRESH_SELECTION_NONE;
         this.m_SelectedItemValueSet = false;
      }
      
      private function SelectedOfferChanged(list:Array, playerInventory:Boolean = false) : Boolean
      {
         // method body index: 1447 method index: 1447
         var itemChanged:Boolean = true;
         var data:Object = null;
         for(var index:Number = 0; index < list.length; index++)
         {
            if(list[index].serverHandleId == this.m_SelectedItemServerHandleId && (playerInventory && !this.m_SelectedItemOffered || list[index].partialOffer == this.m_SelectedItemIsPartialOffer))
            {
               data = list[index];
               break;
            }
         }
         if(data != null)
         {
            if(playerInventory)
            {
               itemChanged = false;
            }
            else if(this.m_SelectedItemOffered == data.isOffered && this.m_SelectedItemValue == data.itemValue && this.m_SelectedItemCount == data.count)
            {
               itemChanged = false;
            }
         }
         return itemChanged;
      }
      
      private function UpdatePartialItems(inventoryList:Array, offersList:Array) : void
      {
         // method body index: 1448 method index: 1448
         var i:int = inventoryList.length;
         while(--i > -1)
         {
            if(inventoryList[i].partialOffer == true)
            {
               inventoryList.splice(i,1);
            }
         }
         for(var j:Number = 0; j < offersList.length; j++)
         {
            if(offersList[j].partialOffer == true)
            {
               inventoryList.push(offersList[j]);
            }
         }
      }
      
      private function InsertRequestedItems(offersList:Array, inventoryList:Array) : void
      {
         // method body index: 1449 method index: 1449
         var i:int = offersList.length;
         while(--i > -1)
         {
            if(offersList[i].isOffered == false)
            {
               offersList.splice(i,1);
            }
         }
         for(var j:Number = 0; j < inventoryList.length; j++)
         {
            if(inventoryList[j].isRequested == true)
            {
               offersList.push(inventoryList[j]);
            }
         }
      }
   }
}
