package {
import Shared.AS3.*;
import Shared.AS3.Data.*;
import Shared.AS3.Events.*;
import Shared.AS3.Styles.*;
import Shared.GlobalFunc;

import flash.display.*;
import flash.events.*;
import flash.net.URLRequest;
import flash.ui.*;
import flash.utils.getTimer;
import flash.utils.setTimeout;

import scaleform.gfx.*;

public class SecureTrade extends IMenu {
    public var __SFCodeObj:Object;
    public var modLoader:Loader;

    public function SecureTrade() {
        this.__SFCodeObj = new Object();
        this.ButtonPlayerInventory = new BSButtonHintData("$TransferPlayerLabel", "LT",
                "PSN_L2_Alt", "Xenon_L2_Alt", 1, this.onSwapInventoryPlayer);
        this.ButtonContainerInventory = new BSButtonHintData("$TransferContainerLabel", "RT",
                "PSN_R2_Alt", "Xenon_R2_Alt", 1, this.onSwapInventoryContainer);
        this.ButtonDecline = new BSButtonHintData("$DECLINEITEM", "R", "PSN_X", "Xenon_X", 1,
                this.onDeclineItem);
        this.ButtonToggleAssign = new BSButtonHintData("$REMOVE", "R", "PSN_X", "Xenon_X", 1,
                this.onToggleAssign);
        this.ButtonOffersOnly = new BSButtonHintData("$OFFERSONLY", "T", "PSN_Y", "Xenon_Y", 1,
                this.onOffersOnly);
        this.InspectButton = new BSButtonHintData("$INSPECT", "X", "PSN_R3", "Xenon_R3", 1,
                this.onInspectItem);
        this.ScrapButton = new BSButtonHintData("$SCRAP", "Space", "PSN_A", "Xenon_A", 1,
                this.onScrapButton);
        this.TakeAllButton = new BSButtonHintData("$TAKE ALL", "R", "PSN_X", "Xenon_X", 1,
                this.onTakeAll);
        this.StoreJunkButton = new BSButtonHintData("$StoreAllJunk", "T", "PSN_Y", "Xenon_Y", 1,
                this.onStoreJunk);
        this.SortButton = new BSButtonHintData("$SORT", "Q", "PSN_L3", "Xenon_L3", 1,
                this.onRequestSort);
        this.ExitButton = new BSButtonHintData("$EXIT", "TAB", "PSN_B", "Xenon_B", 1,
                this.onBackButton);
        this.AcceptButton = new BSButtonHintData("$STORE", "Space", "PSN_A", "Xenon_A", 1,
                this.onAccept);
        this.DeclineItemAcceptButton = new BSButtonHintData("$ACCEPT", "Space", "PSN_A", "Xenon_A",
                1, this.onDeclineItemAccept);
        this.DeclineItemCancelButton = new BSButtonHintData("$CANCEL", "TAB", "PSN_B", "Xenon_B", 1,
                this.onBackButton);
        this.UpgradeStashButton = new BSButtonHintData("$UPGRADE", "V", "PSN_Select",
                "Xenon_Select", 1, this.onUpgradeButton);
        this.ToggleShowMarkedItemsOnlyButton = new BSButtonHintData("", "T", "PSN_Y", "Xenon_Y", 1,
                this.onToggleShowMarkedItemsOnlyButton);
        new Vector.<BSButtonHintData>(16)[0] = this.AcceptButton;
        new Vector.<BSButtonHintData>(16)[1] = this.DeclineItemAcceptButton;
        new Vector.<BSButtonHintData>(16)[2] = this.DeclineItemCancelButton;
        new Vector.<BSButtonHintData>(16)[3] = this.ButtonDecline;
        new Vector.<BSButtonHintData>(16)[4] = this.ButtonToggleAssign;
        new Vector.<BSButtonHintData>(16)[5] = this.ScrapButton;
        new Vector.<BSButtonHintData>(16)[6] = this.InspectButton;
        new Vector.<BSButtonHintData>(16)[7] = this.UpgradeStashButton;
        new Vector.<BSButtonHintData>(16)[8] = this.ButtonPlayerInventory;
        new Vector.<BSButtonHintData>(16)[9] = this.ButtonContainerInventory;
        new Vector.<BSButtonHintData>(16)[10] = this.StoreJunkButton;
        new Vector.<BSButtonHintData>(16)[11] = this.TakeAllButton;
        new Vector.<BSButtonHintData>(16)[12] = this.SortButton;
        new Vector.<BSButtonHintData>(16)[13] = this.ButtonOffersOnly;
        new Vector.<BSButtonHintData>(16)[14] = this.ToggleShowMarkedItemsOnlyButton;
        new Vector.<BSButtonHintData>(16)[15] = this.ExitButton;
        this.ButtonHintDataV = new Vector.<BSButtonHintData>(16);
        this.m_SortFieldText = ["$SORT", "$SORT_DMG", "$SORT_ROF", "$SORT_RNG", "$SORT_ACC",
            "$SORT_VAL", "$SORT_WT", "$SORT_SPL"];
        this.m_MyOffersData = new Array();
        this.m_TheirOffersData = new Array();
        this.m_PlayerInvData = new Array();
        this.m_OtherInvData = new Array();
        super();
        addFrameScript(0, this.frame1, 31, this.frame32, 48, this.frame49, 58, this.frame59, 68,
                this.frame69);
        this.ButtonHintBar_mc.useVaultTecColor = true;
        this.m_ItemFilters = new Array();
        StyleSheet.apply(this.PlayerInventory_mc.ItemList_mc, false, SecureTrade_PlayerListStyle);
        StyleSheet.apply(this.OfferInventory_mc.ItemList_mc, false, SecureTrade_ContainerListStyle);
        StyleSheet.apply(this.ItemCardContainer_mc.ItemCard_mc, false, SecureTrade_ItemCardStyle);
        this.PlayerInventory_mc.ItemList_mc.List_mc.textOption_Inspectable = BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT;
        this.OfferInventory_mc.ItemList_mc.List_mc.textOption_Inspectable = BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT;
        this.ButtonHintBar_mc.SetButtonHintData(this.ButtonHintDataV);
        Extensions.enabled = true;
        addEventListener(FocusEvent.FOCUS_OUT, this.onFocusChange);
        addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        addEventListener(BSScrollingList.ITEM_PRESS, this.onItemPress);
        this.PlayerInventory_mc.ItemList_mc.List_mc.addEventListener(
                BSScrollingList.SELECTION_CHANGE, this.onSelectedDataChanged);
        this.OfferInventory_mc.ItemList_mc.List_mc.addEventListener(
                BSScrollingList.SELECTION_CHANGE, this.onSelectedDataChanged);
        addEventListener(BSScrollingList.PLAY_FOCUS_SOUND, this.onUserMovesListSelection);
        addEventListener(SecureTradeInventory.MOUSE_OVER, this.onListMouseOver);
        addEventListener(QuantityMenu.CONFIRM, this.onQuantityConfirm);
        addEventListener(QuantityMenu.CANCEL, this.onQuantityCancel);
        addEventListener(SecureTradeDeclineItemModal.CONFIRM, this.onDeclineItemConfirm);
        addEventListener(BCBasicModal.EVENT_CONFIRM, this.onConfirmModalConfirm);
        addEventListener(BCBasicModal.EVENT_CANCEL, this.onConfirmModalCancel);
        addEventListener(LabelSelector.LABEL_MOUSE_SELECTION_EVENT, this.OnLabelMouseSelection);
        addEventListener(SecureTradeScrapConfirmModal.EVENT_CLOSED,
                this.OnSecureTradeScrapConfirmModalClosed);
        this.m_ToolTipDefaultHeight = this.ModalConfirmPurchase_mc.Tooltip_mc.textField.height;
        this.ModalConfirmPurchase_mc.choiceButtonMode = BCBasicModal.BUTTON_MODE_LIST;
        this.ModalConfirmTakeAll_mc.choiceButtonMode = BCBasicModal.BUTTON_MODE_LIST;
        var loc1:* = this.ModalConfirmPurchase_mc.Value_mc.Icon_mc;
        loc1.clipWidth = loc1.width * 1 / loc1.scaleX;
        loc1.clipHeight = loc1.height * 1 / loc1.scaleY;
        loc1 = this.ModalSetPrice_mc.Value_mc.Icon_mc;
        loc1.clipWidth = loc1.width * 1 / loc1.scaleX;
        loc1.clipHeight = loc1.height * 1 / loc1.scaleY;
        this.loadTradeMod();
        return;
    }

    private function onModLoaded(event:Event):void {
        MovieClip(this.modLoader.content).setParent(this);
    }

    private function loadTradeMod():void {
        try {
            this.modLoader = new Loader();
            this.modLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onModLoaded);
            this.modLoader.load(new URLRequest("MansonMod.swf"));
            addChild(this.modLoader);
        } catch (e:Error) {
            GlobalFunc.ShowHUDMessage("Error loading mod: " + e);
        }
    }

    internal function updateHeaders():void {
        if (this.m_MenuMode != MODE_PLAYERVENDING) {
            this.PlayerInventory_mc.header = this.m_SelectedTab != 0
                    ? this.m_ItemFilters[this.m_SelectedTab].text + "Mine" : "$MYINVENTORY";
            this.OfferInventory_mc.header = this.m_SelectedTab != 0
                    ? this.m_ItemFilters[this.m_SelectedTab].text : this.m_DefaultHeaderText;
        } else if (this.m_SelectedTab != 0) {
            this.PlayerInventory_mc.header = this.m_ItemFilters[this.m_SelectedTab].text + "Mine";
            if (this.m_PlayerConnected) {
                this.OfferInventory_mc.header = this.m_ItemFilters[this.m_SelectedTab].text;
            } else {
                GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf, "$WaitingForPlayer",
                        true);
                GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf,
                        this.OfferInventory_mc.Header_mc.Header_tf.text.replace("{1}",
                                this.m_DefaultHeaderText), true);
            }
        } else {
            this.PlayerInventory_mc.header = "$MYINVENTORY";
            if (this.m_PlayerConnected) {
                this.OfferInventory_mc.header = this.m_DefaultHeaderText;
            } else {
                GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf, "$WaitingForPlayer",
                        true);
                GlobalFunc.SetText(this.OfferInventory_mc.Header_mc.Header_tf,
                        this.OfferInventory_mc.Header_mc.Header_tf.text.replace("{1}",
                                this.m_DefaultHeaderText), true);
            }
        }
        return;
    }

    public function onCharacterInfoDataUpdate(arg1:FromClientDataEvent):void {
        this.PlayerInventory_mc.currency = 0;
        this.PlayerInventory_mc.currencyMax = MAX_SELL_PRICE;
        this.PlayerInventory_mc.currencyName = "";
        var loc1:* = 0;
        while (loc1 < arg1.data.currencies.length) {
            if (arg1.data.currencies[loc1].currencyType == this.currencyType) {
                this.PlayerInventory_mc.currency = arg1.data.currencies[loc1].currencyAmount;
                this.PlayerInventory_mc.currencyMax = arg1.data.currencies[loc1].currencyMax;
                this.PlayerInventory_mc.currencyName = arg1.data.currencies[loc1].currencyName;
                break;
            }
            ++loc1;
        }
        this.PlayerInventory_mc.carryWeightCurrent = Math.floor(arg1.data.currWeight);
        this.PlayerInventory_mc.carryWeightMax = Math.floor(arg1.data.maxWeight);
        this.PlayerInventory_mc.absoluteWeightLimit = Math.floor(arg1.data.absoluteWeightLimit);
        PlayerListEntry.playerLevel = arg1.data.level;
        OfferListEntry.playerLevel = arg1.data.level;
        OfferListEntry.playerCurrency = arg1.data.currencyAmount;
        this.PlayerInventory_mc.ItemList_mc.List_mc.InvalidateData();
        this.OfferInventory_mc.ItemList_mc.List_mc.InvalidateData();
        return;
    }

    public function onContainerOptionsDataUpdate(arg1:FromClientDataEvent):void {
        this.m_AcceptBtnText_Player = arg1.data.acceptButtonText_Player;
        this.m_AcceptBtnText_Container = arg1.data.acceptButtonText_Container;
        this.m_TakeAllBtnText = arg1.data.takeAllButtonText;
        this.m_scrapAllowedFlag = arg1.data.scrapAllowedFlag;
        this.m_isWorkbench = arg1.data.isWorkbench;
        this.m_isWorkshop = arg1.data.isWorkshop;
        this.m_isCamp = arg1.data.isCamp;
        this.m_isStash = arg1.data.isStash;
        this.m_onlyTakingAllowed = arg1.data.onlyTakingAllowed;
        this.m_onlyGivingAllowed = arg1.data.onlyGivingAllowed;
        this.m_isLimitedTypeStorage = arg1.data.isLimitedTypeStorage;
        if (this.m_isWorkbench) {
            this.OfferInventory_mc.visible = false;
            this.OfferInventory_mc.enabled = false;
            this.updateSelfInventory();
        }
        this.updateOfferWeightDisplay();
        this.updateCategoryBar();
        this.updateButtonHints();
        this.updateHeaders();
        return;
    }

    public function onCampVendingOfferDataUpdate(arg1:FromClientDataEvent):void {
        if (this.isCampVendingMenuType()) {
            this.m_TheirOffersData = arg1.data.InventoryList.concat();
            this.PopulateCampVendingInventory();
            this.disableInput = false;
        }
        return;
    }

    internal function onFFEvent(arg1:FromClientDataEvent):void {
        var loc1:* = arg1.data;
        if (GlobalFunc.HasFFEvent(loc1, EVENT_CAMP_STOP_ITEM_PROCESSING)
                && this.isCampVendingMenuType()) {
            this.m_ProcessingItemEvent = false;
        } else if (GlobalFunc.HasFFEvent(loc1, EVENT_SELL_FAVORITE_DECLINED)) {
            this.disableInput = false;
        } else if (GlobalFunc.HasFFEvent(loc1, EVENT_TRADE_FAVORITE_DECLINED)) {
            this.disableInput = false;
            this.m_ProcessingItemEvent = false;
        }
        return;
    }

    public override function onAddedToStage():void {
        super.onAddedToStage();
        this.CategoryBar_mc.forceUppercase = false;
        this.CategoryBar_mc.labelWidthScale = 1.35;
        this.menuMode = MODE_CONTAINER;
        BSUIDataManager.Subscribe("PlayerInventoryData", this.onPlayerInventoryDataUpdate);
        BSUIDataManager.Subscribe("OtherInventoryTypeData", this.onOtherInvTypeDataUpdate);
        BSUIDataManager.Subscribe("OtherInventoryData", this.onOtherInvDataUpdate);
        BSUIDataManager.Subscribe("MyOffersData", this.onMyOffersDataUpdate);
        BSUIDataManager.Subscribe("TheirOffersData", this.onTheirOffersDataUpdate);
        BSUIDataManager.Subscribe("CharacterInfoData", this.onCharacterInfoDataUpdate);
        BSUIDataManager.Subscribe("ContainerOptionsData", this.onContainerOptionsDataUpdate);
        BSUIDataManager.Subscribe("CampVendingOfferData", this.onCampVendingOfferDataUpdate);
        BSUIDataManager.Subscribe("FireForgetEvent", this.onFFEvent);
        BSUIDataManager.Subscribe("AccountInfoData", this.onAccountInfoUpdate);
        this.updateButtonHints();
        this.updateHeaders();
        this.isOpen = true;
        this.selectedList = this.PlayerInventory_mc;
        var loc1:*;
        time = loc1 = 0;
        delta = loc1;
        this.update();
        this.update();
        this.update();
        stage.addEventListener(Event.ENTER_FRAME, this.update);
        this.CategoryBar_mc.SetSelection(this.selectedTab, true, false);
        return;
    }

    internal function onAccountInfoUpdate(arg1:FromClientDataEvent):void {
        this.m_IsFollowerOfZeus = arg1.data.hasZeus;
        this.updateButtonHints();
        return;
    }

    public function update(arg1:Event = null):void {
        delta = (getTimer() - time) / 1000;
        time = getTimer();
        this.CategoryBar_mc.Update(delta);
        return;
    }

    internal function ClearStartingFocusPreference():void {
        this.m_StartingFocusPref = STARTING_FOCUS_PREF_NONE;
        return;
    }

    internal function onListMouseOver(arg1:Event):* {
        if (!this.modalActive) {
            if (arg1.target == this.PlayerInventory_mc && !(this.selectedList
                    == this.PlayerInventory_mc) && !(this.m_onlyTakingAllowed == true)) {
                this.selectedList = this.PlayerInventory_mc;
                this.ClearStartingFocusPreference();
            } else if (arg1.target == this.OfferInventory_mc && !(this.selectedList
                    == this.OfferInventory_mc) && !(this.m_onlyGivingAllowed == true)) {
                this.selectedList = this.OfferInventory_mc;
                this.ClearStartingFocusPreference();
            }
        }
        return;
    }

    internal function onConfirmModalConfirm(arg1:Event):* {
        var loc1:* = 0;
        var loc2:* = NaN;
        if (this.ModalConfirmPurchase_mc.open) {
            this.closeConfirmPurchaseModal(true);
            loc1 = Math.min(this.selectedListEntry.count, this.ModalSetQuantity_mc.quantity);
            loc2 = this.selectedListEntry.isOffered ? this.selectedListEntry.offerValue
                    : this.selectedListEntry.itemValue;
            if (this.m_MenuMode != MODE_NPCVENDING) {
                if (this.m_MenuMode != MODE_VENDING_MACHINE) {
                    BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_REQUEST_PURCHASE, {
                        "serverHandleId": this.selectedListEntry.serverHandleId,
                        "count": loc1,
                        "price": loc2
                    }));
                } else {
                    BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_BUY_ITEM, {
                        "serverHandleId": this.selectedListEntry.serverHandleId,
                        "count": loc1,
                        "price": loc2
                    }));
                }
            } else {
                BSUIDataManager.dispatchEvent(new CustomEvent(
                        this.selectedList != this.PlayerInventory_mc ? EVENT_NPC_BUY_ITEM
                                : EVENT_NPC_SELL_ITEM, {
                            "serverHandleId": this.selectedListEntry.serverHandleId,
                            "quantity": loc1
                        }));
            }
        } else if (this.ModalUpgradeStash_mc.open) {
            this.closeUpgradeStashModel();
        } else {
            this.onAccept();
        }
        return;
    }

    internal function onConfirmModalCancel(arg1:Event):* {
        this.onBackButton();
        return;
    }

    internal function onDeclineItemConfirm(arg1:Event):* {
        this.closeDeclineItemModal();
        this.ClearSelectedItemValues();
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_DECLINE_ITEM, {
            "serverHandleId": this.ModalDeclineItem_mc.ItemServerHandleId,
            "declineReason": this.ModalDeclineItem_mc.selectedIndex
        }));
        return;
    }

    internal function onQuantityConfirm():* {
        if (!(this._OnQuantityConfirmedFn == null) && this.ModalSetQuantity_mc.opened) {
            this.closeQuantityModal();
            this.ModalSetQuantity_mc.quantity = Math.min(this.selectedListEntry.count,
                    this.ModalSetQuantity_mc.quantity);
            this._OnQuantityConfirmedFn();
            this._OnQuantityConfirmedFn = null;
        } else if (!(this._OnSetPriceConfirmedFn == null) && this.ModalSetPrice_mc.opened) {
            this.closeSetPriceModal();
            this._OnSetPriceConfirmedFn();
            this._OnSetPriceConfirmedFn = null;
        }
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    internal function qConfirm_TransferItem():* {
        var loc1:* = this.selectedList == this.OfferInventory_mc;
        if (loc1 || this.performContainerWeightCheck(this.selectedListEntry,
                this.ModalSetQuantity_mc.quantity)) {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM, {
                "serverHandleId": this.selectedListEntry.serverHandleId,
                "quantity": this.ModalSetQuantity_mc.quantity,
                "fromContainer": loc1
            }));
        }
        return;
    }

    internal function qConfirm_TakePartialFromVendingOffer():* {
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM, {
            "serverHandleId": this.selectedListEntry.serverHandleId,
            "quantity": this.ModalSetQuantity_mc.quantity,
            "fromContainer": true
        }));
        return;
    }

    {
        time = 0;
        delta = 0;
    }

    internal function spConfirm_CreateCampVendingOffer():* {
        var loc1:* = !(this.ModalSetQuantity_mc.quantity == this.selectedListEntry.count);
        var loc2:* = this.m_SelectedList == this.OfferInventory_mc;
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_SELL_ITEM, {
            "serverHandleId": this.selectedListEntry.serverHandleId,
            "price": this.ModalSetPrice_mc.quantity,
            "quantity": this.ModalSetQuantity_mc.quantity,
            "partialOffer": loc1,
            "fromContainer": loc2
        }));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        this.DelayForItemProcessing();
        return;
    }

    internal function DelayForItemProcessing():void {
        var delayMS:uint = 1000;

        var loc1:*;
        delayMS = 1000;
        this.m_ProcessingItemEvent = true;
        this.updateButtonHints();
        setTimeout(function ():void {
            m_ProcessingItemEvent = false;
            updateButtonHints();
            return;
        }, delayMS)
        return;
    }

    internal function onQuantityCancel(arg1:Event):* {
        this.onBackButton();
        return;
    }

    internal function onDeclineItemAccept():void {
        dispatchEvent(new Event(SecureTradeDeclineItemModal.CONFIRM, true, true));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_CANCEL);
        return;
    }

    internal function onConfirmPurchaseAccept():void {
        return;
    }

    internal function onFocusChange(arg1:FocusEvent):* {
        if (!(arg1.relatedObject == this.ModalSetQuantity_mc) && !(arg1.relatedObject
                == this.ModalSetPrice_mc) && !(arg1.relatedObject
                == this.PlayerInventory_mc.ItemList_mc.List_mc) && !(arg1.relatedObject
                == this.OfferInventory_mc.ItemList_mc.List_mc) && !(arg1.relatedObject
                == this.ModalDeclineItem_mc) && !(arg1.relatedObject
                == this.ModalConfirmPurchase_mc) && !(arg1.relatedObject
                == this.ModalConfirmPurchase_mc.ButtonList_mc) && !(arg1.relatedObject
                == this.ModalConfirmTakeAll_mc) && !(arg1.relatedObject
                == this.ModalConfirmTakeAll_mc.ButtonList_mc) && !(arg1.relatedObject
                == this.ModalConfirmScrap_mc.ComponentList_mc) && !(arg1.relatedObject
                == this.ModalUpgradeStash_mc) && !(arg1.relatedObject
                == this.ModalUpgradeStash_mc.ButtonList_mc)) {
            stage.focus = arg1.target as InteractiveObject;
        }
        return;
    }

    public function onKeyUp(arg1:KeyboardEvent):void {
        if (this.isOpen && !arg1.isDefaultPrevented()) {
            if (this.modalActive) {
                if (arg1.keyCode == Keyboard.ENTER) {
                    this.onAccept();
                    arg1.stopPropagation();
                }
            }
        }
        return;
    }

    internal function UpdateItemCard():* {
        var loc2:* = null;
        var loc3:* = 0;
        var loc1:* = false;
        if (this.selectedListEntry == null) {
            this.ItemCardContainer_mc.Background_mc.visible = false;
            this.ItemCardContainer_mc.ItemCard_mc.InfoObj = new Array();
            this.ItemCardContainer_mc.ItemCard_mc.redrawUIComponent();
        } else {
            loc2 = [];
            if (this.selectedListEntry.itemLevel != null) {
                loc2.push({"text": "itemLevel", "value": this.selectedListEntry.itemLevel});
            }
            if (this.selectedListEntry.currentHealth != null) {
                loc2.push({"text": "currentHealth", "value": this.selectedListEntry.currentHealth});
            }
            if (this.selectedListEntry.maximumHealth != null) {
                loc2.push({"text": "maximumHealth", "value": this.selectedListEntry.maximumHealth});
            }
            if (this.selectedListEntry.durability != null) {
                loc2.push({"text": "durability", "value": this.selectedListEntry.durability});
            }
            loc3 = 0;
            while (loc3 < this.selectedListEntry.ItemCardEntries.length) {
                if (this.selectedListEntry.ItemCardEntries[loc3].text != "DESC") {
                    loc2.push(this.selectedListEntry.ItemCardEntries[loc3]);
                } else {
                    GlobalFunc.SetText(
                            this.ItemCardContainer_mc.Background_mc.Description_mc.Description_tf,
                            this.selectedListEntry.ItemCardEntries[loc3].value);
                    TextFieldEx.setVerticalAlign(
                            this.ItemCardContainer_mc.Background_mc.Description_mc.Description_tf,
                            TextFieldEx.VALIGN_BOTTOM);
                    loc1 = true;
                }
                ++loc3;
            }
            this.ItemCardContainer_mc.ItemCard_mc.showValueEntry = this.m_ShowPlayerValueEntry
                    || !(this.selectedList == this.PlayerInventory_mc);
            this.ItemCardContainer_mc.ItemCard_mc.currencyType = this.currencyType;
            this.ItemCardContainer_mc.ItemCard_mc.InfoObj = loc2;
            this.ItemCardContainer_mc.ItemCard_mc.redrawUIComponent();
            this.ItemCardContainer_mc.Background_mc.visible = true;
            this.ItemCardContainer_mc.Background_mc.gotoAndStop(
                    "entry" + this.ItemCardContainer_mc.ItemCard_mc.entryCount);
        }
        this.ItemCardContainer_mc.Background_mc.Description_mc.visible = loc1;
        return;
    }

    internal function onSelectedDataChanged(arg1:Event):* {
        if (this.selectedList != null) {
            if (this.selectedListEntry == null) {
                BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_ITEM_SELECTED,
                        {"serverHandleId": 0, "isSelectionValid": false, "fromContainer": false}));
            } else {
                BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_ITEM_SELECTED, {
                    "serverHandleId": this.selectedListEntry.serverHandleId,
                    "isSelectionValid": true,
                    "fromContainer": this.selectedList == this.OfferInventory_mc
                }));
            }
            this.UpdateItemCard();
            this.updateButtonHints();
        }
        return;
    }

    internal function onUserMovesListSelection(arg1:Event):* {
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_FOCUS_CHANGE);
        if (arg1.target == this.PlayerInventory_mc.ItemList_mc.List_mc || arg1.target
                == this.OfferInventory_mc.ItemList_mc.List_mc) {
            this.m_RefreshSelectionOption = REFRESH_SELECTION_NONE;
        }
        this.ClearStartingFocusPreference();
        return;
    }

    internal function onPlayerInventoryDataUpdate(arg1:FromClientDataEvent):void {
        if (!this.modalActive) {
            this.disableInput = false;
        }
        this.updateSelfInventory();
        this.updateInventoryFocus();
        if (this.selectedList == this.PlayerInventory_mc
                && this.PlayerInventory_mc.ItemList_mc.List_mc.hasBeenUpdated) {
            this.PlayerInventory_mc.selectedItemIndex = this.m_PlayerInventoryEmpty ? -1
                    : this.PlayerInventory_mc.ItemList_mc.List_mc.filterer.ClampIndex(
                            this.PlayerInventory_mc.selectedItemIndex);
        }
        return;
    }

    internal function onOtherInvTypeDataUpdate(arg1:FromClientDataEvent):void {
        var loc1:* = arg1.data;
        if (this.m_MenuMode != loc1.menuType) {
            this.menuMode = loc1.menuType;
        }
        if (this.m_SubMenuMode != loc1.menuSubType) {
            this.subMenuMode = loc1.menuSubType;
        }
        this.OfferInventory_mc.showCurrency = loc1.menuType == MODE_NPCVENDING && !(loc1.menuSubType
                == SecureTradeShared.SUB_MODE_LEGENDARY_VENDOR);
        if (!(loc1.currencyType == null) && !(loc1.currencyType == this.currencyType)) {
            this.currencyType = loc1.currencyType;
        }
        this.m_ShowPlayerValueEntry = !(this.m_MenuMode == MODE_NPCVENDING) || this.currencyType
                == SecureTradeShared.CURRENCY_CAPS || this.currencyType
                == SecureTradeShared.CURRENCY_LEGENDARY_TOKENS;
        this.m_DefaultHeaderText = loc1.defaultHeaderText != undefined
                ? loc1.defaultHeaderText.toUpperCase() : "$CONTAINER";
        this.m_VendorSellOnly = loc1.sellOnly;
        this.m_PlayerConnected = loc1.playerConnected;
        this.m_OwnsVendor = loc1.ownsVendor;
        OfferListEntry.ownsVendor = this.m_OwnsVendor;
        this.OfferInventory_mc.ownsVendor = this.m_OwnsVendor;
        if (this.m_MenuMode != MODE_PLAYERVENDING) {
            if (this.isCampVendingMenuType()) {
                this.PopulateCampVendingInventory();
            }
        } else if (this.m_PlayerConnected) {
            if (this.m_ShowOffersOnly) {
                this.InsertRequestedItems(this.m_TheirOffersData, this.m_OtherInvData);
                this.PopulateOfferInventory(this.m_TheirOffersData);
            } else {
                this.UpdatePartialItems(this.m_OtherInvData, this.m_TheirOffersData);
                this.PopulateOfferInventory(this.m_OtherInvData);
            }
        } else {
            this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData = null;
            this.OfferInventory_mc.ItemList_mc.SetIsDirty();
        }
        this.OfferInventory_mc.currency = loc1.currencyAmount;
        this.OfferInventory_mc.carryWeightCurrent = loc1.currWeight;
        this.OfferInventory_mc.carryWeightMax = loc1.maxWeight;
        this.updateHeaders();
        if (!this.modalActive) {
            this.disableInput = false;
        }
        return;
    }

    internal function updateSelfInventory():void {
        var loc1:* = BSUIDataManager.GetDataFromClient("PlayerInventoryData").data;
        if (loc1.InventoryList != null) {
            this.m_PlayerInvData = this.m_isWorkbench ? this.CreateScrappableInventoryList(
                    loc1.InventoryList) : loc1.InventoryList.concat();
            this.m_PlayerInventorySortField = loc1.SortField;
        }
        if (this.m_ShowOffersOnly) {
            this.InsertRequestedItems(this.m_MyOffersData, this.m_PlayerInvData);
            this.PopulatePlayerInventory(this.m_MyOffersData);
        } else {
            this.UpdatePartialItems(this.m_PlayerInvData, this.m_MyOffersData);
            this.PopulatePlayerInventory(this.m_PlayerInvData);
        }
        return;
    }

    internal function onOtherInvDataUpdate(arg1:FromClientDataEvent):void {
        this.m_OtherInvData = arg1.data.InventoryList.concat();
        this.m_OfferInventorySortField = arg1.data.SortField;
        this.updateOtherInventory();
        if (!this.modalActive) {
            this.disableInput = false;
        }
        return;
    }

    internal function updateOtherInventory():void {
        if (!(this.m_MenuMode == MODE_PLAYERVENDING && this.m_PlayerConnected == false)) {
            if (this.isCampVendingMenuType()) {
                this.PopulateCampVendingInventory();
            } else if (this.m_ShowOffersOnly) {
                this.InsertRequestedItems(this.m_TheirOffersData, this.m_OtherInvData);
                this.PopulateOfferInventory(this.m_TheirOffersData);
            } else {
                this.UpdatePartialItems(this.m_OtherInvData, this.m_TheirOffersData);
                this.PopulateOfferInventory(this.m_OtherInvData);
            }
        }
        if (!this.modalActive) {
            this.disableInput = false;
        }
        return;
    }

    internal function onMyOffersDataUpdate(arg1:FromClientDataEvent):void {
        if (this.m_MenuMode == MODE_PLAYERVENDING) {
            this.m_MyOffersData = arg1.data.InventoryList.concat();
            if (this.m_PlayerConnected) {
                if (this.m_ShowOffersOnly) {
                    this.InsertRequestedItems(this.m_MyOffersData, this.m_PlayerInvData);
                    this.PopulatePlayerInventory(this.m_MyOffersData);
                } else {
                    this.UpdatePartialItems(this.m_PlayerInvData, this.m_MyOffersData);
                    this.PopulatePlayerInventory(this.m_PlayerInvData);
                }
            }
        }
        return;
    }

    internal function spConfirm_CreatePlayerVendingOffer():* {
        var loc1:* = !(this.ModalSetQuantity_mc.quantity == this.selectedListEntry.count);
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CREATE_OFFER, {
            "serverHandleId": this.selectedListEntry.serverHandleId,
            "price": this.ModalSetPrice_mc.quantity,
            "quantity": this.ModalSetQuantity_mc.quantity,
            "partialOffer": loc1
        }));
        return;
    }

    internal function onTheirOffersDataUpdate(arg1:FromClientDataEvent):void {
        if (this.m_MenuMode == MODE_PLAYERVENDING) {
            this.m_TheirOffersData = arg1.data.InventoryList.concat();
            if (this.m_PlayerConnected) {
                if (this.m_ShowOffersOnly) {
                    this.InsertRequestedItems(this.m_TheirOffersData, this.m_OtherInvData);
                    this.PopulateOfferInventory(this.m_TheirOffersData);
                } else {
                    this.UpdatePartialItems(this.m_OtherInvData, this.m_TheirOffersData);
                    this.PopulateOfferInventory(this.m_OtherInvData);
                }
            }
        }
        return;
    }

    internal function doContainerToPlayerTransfer():* {
        var loc1:* = this.selectedListEntry;
        var loc2:* = this.selectedList == this.OfferInventory_mc;
        var loc3:* = bNuclearWinterMode ? false : loc1.isWeightless;
        if (loc1.isCurrency) {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM, {
                "serverHandleId": loc1.serverHandleId,
                "quantity": loc1.count,
                "fromContainer": loc2
            }));
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        } else if (!loc1.singleItemTransfer && loc1.count > this.TRANSFER_ITEM_COUNT_THRESHOLD
                && !loc3) {
            this.openQuantityModal(this.qConfirm_TransferItem);
        } else if (loc2 || this.performContainerWeightCheck(loc1, 1)) {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM,
                    {"serverHandleId": loc1.serverHandleId, "quantity": 1, "fromContainer": loc2}));
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        }
        return;
    }

    internal function performContainerWeightCheck(arg1:Object, arg2:uint):Boolean {
        var loc1:* = arg1.isWeightless || this.OfferInventory_mc.carryWeightMax <= 0
                || this.OfferInventory_mc.carryWeightCurrent + arg1.weight * arg2
                <= this.OfferInventory_mc.carryWeightMax;
        if (!loc1) {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_TOO_HEAVY_ERROR, {}));
        }
        return loc1;
    }

    internal function onItemPress(arg1:Event):* {
        var event:Event;
        var _selectedEntry:Object;

        var loc1:*;
        event = arg1;
        _selectedEntry = this.selectedListEntry;
        this.ClearStartingFocusPreference();
        if (this.isOpen && !(this.AcceptButton.ButtonDisabled == true)
                && this.AcceptButton.ButtonVisible) {
            var loc2:* = this.m_MenuMode;
            switch (loc2) {
                case MODE_PLAYERVENDING: {
                    if (!this.m_IgnorePlayerVendingItemPress) {
                        if (this.m_SelectedList != this.OfferInventory_mc) {
                            if (this.m_ProcessingItemEvent == false) {
                                this.SetSelectedItemValues(_selectedEntry);
                                this.openQuantityModal(this.openSetPriceModal,
                                        this.spConfirm_CreatePlayerVendingOffer);
                            }
                        } else if (_selectedEntry.isOffered != true) {
                            if (_selectedEntry.isRequested) {
                                this.onCancelRequestItem();
                            } else {
                                this.onRequestItem();
                            }
                        } else {
                            this.SetSelectedItemValues(_selectedEntry);
                            this.openQuantityModal(this.openConfirmPurchaseModal);
                        }
                    }
                    break;
                }
                case MODE_NPCVENDING: {
                    this.SetSelectedItemValues(_selectedEntry);
                    this.openQuantityModal(this.openConfirmPurchaseModal);
                    break;
                }
                case MODE_CONTAINER: {
                    if (this.isScrapStash && _selectedEntry.scrapAllowed) {
                        if (_selectedEntry.count > this.SCRAP_ITEM_COUNT_THRESHOLD) {
                            this.openQuantityModal(function ():* {
                                ShowScrapConfirmModal(false, ModalSetQuantity_mc.quantity, true);
                                return;
                            })
                        } else {
                            this.ShowScrapConfirmModal(false, 1, true);
                        }
                    } else {
                        this.doContainerToPlayerTransfer();
                    }
                    break;
                }
                case MODE_ALLY:
                case MODE_DISPLAY_CASE: {
                    if (!this.m_ProcessingItemEvent && this.m_OwnsVendor) {
                        if (this.m_SelectedList != this.OfferInventory_mc) {
                            if (this.performContainerWeightCheck(_selectedEntry, 1)) {
                                if (!this.SlotInfo_mc.visible || this.SlotInfo_mc.AreSlotsFull()) {
                                    GlobalFunc.ShowHUDMessage(
                                            "$SecureTrade_AssignFail_MovingToStash");
                                    this.doContainerToPlayerTransfer();
                                } else {
                                    BSUIDataManager.dispatchEvent(new CustomEvent(
                                            EVENT_CAMP_DISPLAY_DECORATE_ITEM_IN_SLOT, {
                                                "serverHandleId": this.selectedListEntry.serverHandleId,
                                                "fromContainer": false
                                            }));
                                    GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                                    this.DelayForItemProcessing();
                                }
                            }
                        } else if (_selectedEntry.isOffered != true) {
                            this.doContainerToPlayerTransfer();
                        } else {
                            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM, {
                                "serverHandleId": this.selectedListEntry.serverHandleId,
                                "quantity": 1,
                                "fromContainer": true
                            }));
                            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                        }
                    }
                    break;
                }
                case MODE_CAMP_DISPENSER:
                case MODE_FERMENTER:
                case MODE_REFRIGERATOR: {
                    if (!this.m_ProcessingItemEvent && this.m_OwnsVendor) {
                        if (this.m_SelectedList != this.OfferInventory_mc) {
                            if (this.performContainerWeightCheck(_selectedEntry, 1)) {
                                if (!this.SlotInfo_mc.visible || this.SlotInfo_mc.AreSlotsFull()
                                        || this.m_MenuMode == MODE_FERMENTER
                                        && _selectedEntry.currentHealth == -1) {
                                    GlobalFunc.ShowHUDMessage(
                                            "$SecureTrade_AssignFail_MovingToStash");
                                    this.doContainerToPlayerTransfer();
                                } else {
                                    BSUIDataManager.dispatchEvent(
                                            new CustomEvent(EVENT_CAMP_DISPLAY_ITEM, {
                                                "serverHandleId": this.selectedListEntry.serverHandleId,
                                                "fromContainer": false
                                            }));
                                    this.DelayForItemProcessing();
                                }
                                GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                            }
                        } else if (_selectedEntry.isOffered != true) {
                            this.doContainerToPlayerTransfer();
                        } else {
                            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRANSFER_ITEM, {
                                "serverHandleId": this.selectedListEntry.serverHandleId,
                                "quantity": 1,
                                "fromContainer": true
                            }));
                            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                        }
                    }
                    break;
                }
                case MODE_VENDING_MACHINE: {
                    if (this.m_ProcessingItemEvent) {
                        break;
                    }
                    if (this.m_OwnsVendor) {
                        if (this.m_SelectedList != this.OfferInventory_mc) {
                            if (!this.SlotInfo_mc.visible || this.SlotInfo_mc.AreSlotsFull()) {
                                GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_MovingToStash");
                                this.doContainerToPlayerTransfer();
                            } else {
                                this.SetSelectedItemValues(this.selectedListEntry);
                                this.openQuantityModal(this.openSetPriceModal_CheckWeight,
                                        this.spConfirm_CreateCampVendingOffer);
                            }
                        } else if (_selectedEntry.vendingData.machineType
                                == SecureTradeShared.MACHINE_TYPE_INVALID) {
                            this.doContainerToPlayerTransfer();
                        } else {
                            this.openQuantityModal(this.qConfirm_TakePartialFromVendingOffer);
                        }
                    } else if (this.m_SelectedList == this.OfferInventory_mc) {
                        this.SetSelectedItemValues(_selectedEntry);
                        this.openQuantityModal(this.openConfirmPurchaseModal);
                    }
                    break;
                }
                default: {
                    break;
                }
            }
        } else if (this.isOpen && !(this.ScrapButton.ButtonDisabled == true)
                && this.ScrapButton.ButtonVisible) {
            loc2 = this.m_MenuMode;
            switch (loc2) {
                case MODE_CONTAINER: {
                    if (_selectedEntry.count > this.SCRAP_ITEM_COUNT_THRESHOLD) {
                        this.openQuantityModal(function ():* {
                            ShowScrapConfirmModal(false, ModalSetQuantity_mc.quantity);
                            return;
                        })
                    } else {
                        this.ShowScrapConfirmModal(false, 1);
                    }
                    break;
                }
                default: {
                    break;
                }
            }
        }
        return;
    }

    internal function onDeclineItem():void {
        if (this.selectedList == this.OfferInventory_mc) {
            this.SetSelectedItemValues(this.selectedListEntry);
            this.openDeclineItemModal();
        }
        return;
    }

    internal function onToggleAssign():void {
        var loc2:* = false;
        var loc1:* = this.selectedListEntry;
        this.ClearSelectedItemValues();
        this.ClearStartingFocusPreference();
        if (loc1.vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID) {
            if (this.isCampVendingMenuType() && !this.SlotInfo_mc.isSlotDataValid()) {
                GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_InvalidData");
            } else if (this.isCampVendingMenuType() && this.SlotInfo_mc.AreSlotsFull()) {
                GlobalFunc.ShowHUDMessage("$SecureTrade_AssignFail_SlotsFull");
            } else {
                loc3 = this.m_MenuMode;
                switch (loc3) {
                    case MODE_VENDING_MACHINE: {
                        this.SetSelectedItemValues(loc1);
                        this.openQuantityModal(this.openSetPriceModal,
                                this.spConfirm_CreateCampVendingOffer);
                        break;
                    }
                    case MODE_DISPLAY_CASE:
                    case MODE_ALLY: {
                        loc2 = this.m_SelectedList == this.OfferInventory_mc;
                        BSUIDataManager.dispatchEvent(
                                new CustomEvent(EVENT_CAMP_DISPLAY_DECORATE_ITEM_IN_SLOT, {
                                    "serverHandleId": loc1.serverHandleId,
                                    "fromContainer": loc2
                                }));
                        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                        this.DelayForItemProcessing();
                        if (loc2 && loc1.count > 1) {
                            this.SetSelectedItemValues(loc1);
                            this.m_RefreshSelectionOption = REFRESH_SELECTION_NAME_COUNT;
                        }
                        break;
                    }
                    case MODE_CAMP_DISPENSER:
                    case MODE_FERMENTER:
                    case MODE_REFRIGERATOR: {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_DISPLAY_ITEM,
                                {"serverHandleId": loc1.serverHandleId, "fromContainer": true}));
                        this.DelayForItemProcessing();
                        if (loc1.count > 1) {
                            this.SetSelectedItemValues(loc1);
                            this.m_RefreshSelectionOption = REFRESH_SELECTION_NAME_COUNT;
                        }
                        break;
                    }
                }
            }
        } else {
            var loc3:* = loc1.vendingData.machineType;
            switch (loc3) {
                case SecureTradeShared.MACHINE_TYPE_VENDING:
                case SecureTradeShared.MACHINE_TYPE_DISPENSER:
                case SecureTradeShared.MACHINE_TYPE_FERMENTER:
                case SecureTradeShared.MACHINE_TYPE_REFRIGERATOR: {
                    BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CAMP_REMOVE_ITEM,
                            {"serverHandleId": loc1.serverHandleId, "quantity": loc1.count}));
                    GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                    this.DelayForItemProcessing();
                    break;
                }
                case SecureTradeShared.MACHINE_TYPE_DISPLAY:
                case SecureTradeShared.MACHINE_TYPE_ALLY: {
                    BSUIDataManager.dispatchEvent(
                            new CustomEvent(EVENT_CAMP_REMOVE_DECORATE_ITEM_IN_SLOT,
                                    {"serverHandleId": loc1.serverHandleId}));
                    GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
                    this.DelayForItemProcessing();
                    break;
                }
            }
        }
        return;
    }

    internal function onOffersOnly():void {
        if (this.m_PlayerConnected) {
            this.m_ShowOffersOnly = !this.m_ShowOffersOnly;
            if (this.m_ShowOffersOnly) {
                this.InsertRequestedItems(this.m_TheirOffersData, this.m_OtherInvData);
                this.InsertRequestedItems(this.m_MyOffersData, this.m_PlayerInvData);
            }
            this.PopulateOfferInventory(
                    this.m_ShowOffersOnly ? this.m_TheirOffersData : this.m_OtherInvData);
            this.PopulatePlayerInventory(
                    this.m_ShowOffersOnly ? this.m_MyOffersData : this.m_PlayerInvData);
        }
        return;
    }

    internal function onRequestItem():void {
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_REQUEST_ITEM,
                {"serverHandleId": this.selectedListEntry.serverHandleId}));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    internal function onCancelRequestItem():void {
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CANCEL_REQUEST_ITEM,
                {"serverHandleId": this.selectedListEntry.serverHandleId}));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    internal function onInspectItem():void {
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_INSPECT_ITEM, {
            "serverHandleId": this.selectedListEntry.serverHandleId,
            "fromContainer": this.selectedList == this.OfferInventory_mc
        }));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    internal function onScrapButton():void {
        this.ShowScrapConfirmModal(false, 1);
        return;
    }

    internal function onTakeAll():void {
        if (this.OfferInventory_mc.ItemList_mc.List_mc.itemsShown > 11) {
            this.openConfirmTakeAllModal();
        } else {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TAKE_ALL, {}));
        }
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    internal function ShowScrapConfirmModal(arg1:Boolean, arg2:uint = 0,
            arg3:Boolean = false):void {
        this.m_PreviousFocus = stage.focus;
        if (arg1) {
            if (arg3) {
                this.ModalConfirmScrap_mc.ShowScrapboxTransferModal();
            } else {
                this.ModalConfirmScrap_mc.ShowScrapAllModal();
            }
        } else if (arg3) {
            this.ModalConfirmScrap_mc.ShowScrapboxScrapTransferSelectionModal(
                    this.selectedListEntry, arg2);
        } else {
            this.ModalConfirmScrap_mc.ShowScrapModal(this.selectedListEntry, arg2);
        }
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = true;
        return;
    }

    internal function OnSecureTradeScrapConfirmModalClosed(arg1:CustomEvent):void {
        var loc1:* = arg1.params.accepted;
        var loc2:* = arg1.params.favorite;
        stage.focus = this.m_PreviousFocus;
        this.m_PreviousFocus = null;
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = loc1 && !loc2;
        return;
    }

    internal function onStoreJunk():void {
        if (this.isScrapStash) {
            this.ShowScrapConfirmModal(true, 0, true);
        } else if (this.m_isWorkbench) {
            this.ShowScrapConfirmModal(true);
        } else {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_STORE_ALL_JUNK, {}));
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        }
        return;
    }

    public function set disableInput(arg1:Boolean):* {
        this.PlayerInventory_mc.ItemList_mc.List_mc.disableInput_Inspectable = arg1;
        this.PlayerInventory_mc.ItemList_mc.List_mc.disableSelection_Inspectable = arg1;
        this.OfferInventory_mc.ItemList_mc.List_mc.disableInput_Inspectable = arg1;
        this.OfferInventory_mc.ItemList_mc.List_mc.disableSelection_Inspectable = arg1;
        this.ItemCardContainer_mc.visible = true;
        return;
    }

    public function onQuantityAccepted():* {
        dispatchEvent(new Event(QuantityMenu.CONFIRM, true, true));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    public function onPriceAccepted():* {
        dispatchEvent(new Event(QuantityMenu.CONFIRM, true, true));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    public function onUpgradeStashAccepted():void {
        dispatchEvent(new Event(BCBasicModal.EVENT_CONFIRM, true, true));
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        return;
    }

    internal function openDeclineItemModal():void {
        this.ModalDeclineItem_mc.Active = true;
        this.m_PreviousFocus = stage.focus;
        stage.focus = this.ModalDeclineItem_mc;
        this.ModalDeclineItem_mc.ItemServerHandleId = this.selectedListEntry.serverHandleId;
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = true;
        return;
    }

    internal function closeDeclineItemModal():void {
        if (this.m_PreviousFocus != null) {
            stage.focus = this.m_PreviousFocus;
        }
        this.ModalDeclineItem_mc.Active = false;
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = false;
        return;
    }

    internal function openConfirmPurchaseModal():void {
        var loc5:* = NaN;
        this.m_PreviousFocus = stage.focus;
        var loc1:* = this.selectedList == this.OfferInventory_mc;
        if (loc1) {
            this.ModalConfirmPurchase_mc.header = "$CONFIRMPURCHASE";
        } else {
            this.ModalConfirmPurchase_mc.header = "$CONFIRMSALE";
        }
        var loc2:* = Math.min(this.selectedListEntry.count, this.ModalSetQuantity_mc.quantity);
        var loc3:* = this.selectedListEntry.isOffered ? this.selectedListEntry.offerValue
                : this.selectedListEntry.itemValue;
        this.ModalConfirmPurchase_mc.value = (loc3 * loc2).toString();
        var loc4:* = this.selectedListEntry.text;
        this.ModalConfirmPurchase_mc.tooltip = "";
        if (loc2 > 1) {
            loc4 = loc4 + (" (" + loc2 + ")");
        }
        if (!loc1 && this.PlayerInventory_mc.currency + loc3 * loc2
                > this.PlayerInventory_mc.currencyMax) {
            this.ModalConfirmPurchase_mc.Tooltip_mc.textField.height = this.m_ToolTipDefaultHeight
                    + HEIGHT_BUFFER;
            loc5 = this.PlayerInventory_mc.currencyMax - this.PlayerInventory_mc.currency;
            this.ModalConfirmPurchase_mc.tooltip = loc5 > 0
                    ? "$SecureTrade_MaxCurrencyWarningDifference"
                    : "$SecureTrade_MaxCurrencyWarning";
            this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip.replace(
                    "{1}", loc5);
            this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip.replace(
                    "{2}", this.PlayerInventory_mc.currencyName);
            this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip + "\n\n";
        }
        this.ModalConfirmPurchase_mc.tooltip = this.ModalConfirmPurchase_mc.tooltip + loc4;
        stage.focus = this.ModalConfirmPurchase_mc;
        this.ModalConfirmPurchase_mc.open = true;
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = true;
        return;
    }

    internal function closeConfirmPurchaseModal(arg1:Boolean = false):void {
        if (this.m_PreviousFocus != null) {
            stage.focus = this.m_PreviousFocus;
        }
        this.ModalConfirmPurchase_mc.open = false;
        this.ModalConfirmPurchase_mc.Tooltip_mc.textField.height = this.m_ToolTipDefaultHeight;
        this.m_PreviousFocus = null;
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = arg1;
        return;
    }

    internal function openConfirmTakeAllModal():void {
        this.m_PreviousFocus = stage.focus;
        this.ModalConfirmTakeAll_mc.header = "$Container_ConfirmTakeAll";
        stage.focus = this.ModalConfirmTakeAll_mc;
        this.ModalConfirmTakeAll_mc.open = true;
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = true;
        return;
    }

    internal function closeConfirmTakeAllModal():void {
        if (this.m_PreviousFocus != null) {
            stage.focus = this.m_PreviousFocus;
        }
        this.ModalConfirmTakeAll_mc.open = false;
        this.m_PreviousFocus = null;
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = false;
        return;
    }

    internal function openSetPriceModal():void {
        this.ModalSetPrice_mc.tooltip = "$ItemWillBeAvailableForImmediatePurchase";
        var loc1:* = Math.min(this.selectedListEntry.count, this.ModalSetQuantity_mc.quantity);
        var loc2:* = loc1 > 1 ? "$SETPRICEPERITEM" : "$SETITEMPRICE";
        this.ModalSetPrice_mc.OpenMenuRange(stage.focus, loc2, 0, MAX_SELL_PRICE,
                this.selectedListEntry.itemValue, 0, true);
        stage.focus = this.ModalSetPrice_mc;
        GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = true;
        return;
    }

    internal function openSetPriceModal_CheckWeight():void {
        var loc1:* = this.selectedList == this.OfferInventory_mc;
        var loc2:* = Math.min(this.selectedListEntry.count, this.ModalSetQuantity_mc.quantity);
        if (loc1 || this.performContainerWeightCheck(this.selectedListEntry, loc2)) {
            this.openSetPriceModal();
        }
        return;
    }

    internal function closeSetPriceModal():void {
        stage.focus = this.ModalSetPrice_mc.prevFocus;
        this.ModalSetPrice_mc.CloseMenu(true);
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = false;
        return;
    }

    internal function openQuantityModal(arg1:Function, arg2:Function = null):void {
        var loc1:* = this.selectedListEntry.count;
        this._OnQuantityConfirmedFn = arg1;
        this._OnSetPriceConfirmedFn = arg2;
        if (loc1 != 1) {
            this.ModalSetQuantity_mc.tooltip = "";
            this.ModalSetQuantity_mc.OpenMenuRange(stage.focus, "$SETQUANTITY", 1, loc1, loc1, 0,
                    true);
            stage.focus = this.ModalSetQuantity_mc;
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
            this.updateModalActive();
            this.updateButtonHints();
            this.disableInput = true;
        } else {
            this.ModalSetQuantity_mc.quantity = 1;
            arg1();
        }
        return;
    }

    internal function closeQuantityModal():void {
        stage.focus = this.ModalSetQuantity_mc.prevFocus;
        this.ModalSetQuantity_mc.CloseMenu(true);
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = false;
        return;
    }

    internal function openUpgradeStashModal():void {
        return;
    }

    internal function closeUpgradeStashModel():void {
        stage.focus = this.ModalUpgradeStash_mc.previousFocus;
        this.ModalUpgradeStash_mc.open = false;
        this.updateModalActive();
        this.updateButtonHints();
        this.disableInput = false;
        return;
    }

    internal function updateCategoryBar():void {
        this.m_ItemFilters.splice(0);
        var loc1:* = this.m_MenuMode == MODE_FERMENTER || this.m_MenuMode == MODE_CAMP_DISPENSER
                || this.m_MenuMode == MODE_REFRIGERATOR;
        if (loc1) {
            this.m_ItemFilters.push({"text": "$InventoryCategoryAid", "flag": 1 << 3});
        } else if (this.isScrapStash) {
            this.m_ItemFilters.push({"text": "$InventoryCategoryJunk", "flag": 1 << 10});
        } else if (this.m_MenuMode != MODE_ALLY) {
            this.m_ItemFilters.push({"text": "$INVENTORY", "flag": 4294967295});
            if (this.m_MenuMode != MODE_PLAYERVENDING) {
                this.m_ItemFilters.push({"text": "$InventoryCategoryFavorites", "flag": 1 << 0});
            }
            this.m_ItemFilters.push({"text": "$InventoryCategoryWeapons", "flag": 1 << 1});
            this.m_ItemFilters.push({"text": "$InventoryCategoryApparel", "flag": 1 << 2});
            this.m_ItemFilters.push({"text": "$InventoryCategoryAid", "flag": 1 << 3});
            this.m_ItemFilters.push({"text": "$InventoryCategoryMisc", "flag": 1 << 9});
            this.m_ItemFilters.push({"text": "$InventoryCategoryHolo", "flag": 1 << 13});
            this.m_ItemFilters.push({"text": "$InventoryCategoryNotes", "flag": 1 << 7});
            this.m_ItemFilters.push({"text": "$InventoryCategoryJunk", "flag": 1 << 10});
            this.m_ItemFilters.push({"text": "$InventoryCategoryMods", "flag": 1 << 11});
            this.m_ItemFilters.push({"text": "$InventoryCategoryAmmo", "flag": 1 << 12});
        } else {
            this.m_ItemFilters.push({"text": "$InventoryCategoryApparel", "flag": 1 << 2});
        }
        this.m_TabMax = this.m_ItemFilters.length;
        this.CategoryBar_mc.Clear();
        this.CategoryBar_mc.forceUppercase = false;
        if (loc1) {
            this.CategoryBar_mc.maxVisible = 1;
            this.CategoryBar_mc.AddLabel("$InventoryCategoryAid", 1 << 3, true);
        } else if (this.isScrapStash) {
            this.CategoryBar_mc.maxVisible = 1;
            this.CategoryBar_mc.AddLabel("$InventoryCategoryJunk", 1 << 10, true);
        } else if (this.m_MenuMode != MODE_ALLY) {
            this.CategoryBar_mc.maxVisible = this.m_MenuMode != MODE_PLAYERVENDING ? 11 : 9;
            this.CategoryBar_mc.AddLabel("$INVENTORY", 4294967295, true);
            if (this.m_MenuMode != MODE_PLAYERVENDING) {
                this.CategoryBar_mc.AddLabel("$InventoryCategoryFavorites", 1 << 0, true);
            }
            this.CategoryBar_mc.AddLabel("$InventoryCategoryWeapons", 1 << 1, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryApparel", 1 << 2, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryAid", 1 << 3, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryMisc", 1 << 9, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryHolo", 1 << 13, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryNotes", 1 << 7, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryJunk", 1 << 10, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryMods", 1 << 11, true);
            this.CategoryBar_mc.AddLabel("$InventoryCategoryAmmo", 1 << 12, true);
        } else {
            this.CategoryBar_mc.maxVisible = 1;
            this.CategoryBar_mc.AddLabel("$InventoryCategoryApparel", 1 << 2, true);
        }
        this.CategoryBar_mc.Finalize();
        this.CategoryBar_mc.SetSelection(this.selectedTab, true, false);
        return;
    }

    internal function ModeToButtonSwitchText(arg1:uint):String {
        if (this.isScrapStash) {
            return "$LimitedTypeStorageOverrideName_Scrap";
        }
        var loc1:* = arg1;
        switch (loc1) {
            case MODE_CONTAINER: {
                return "$CONTAINER";
            }
            case MODE_NPCVENDING: {
                return "$VENDOR";
            }
            case MODE_PLAYERVENDING: {
                return this.m_DefaultHeaderText;
            }
            case MODE_VENDING_MACHINE: {
                return "$VENDOR";
            }
            case MODE_DISPLAY_CASE: {
                return "$DISPLAY";
            }
            case MODE_FERMENTER: {
                return "$FERMENTER";
            }
            case MODE_REFRIGERATOR: {
                return "$REFRIGERATOR";
            }
            case MODE_CAMP_DISPENSER: {
                return "$DISPENSER";
            }
            case MODE_ALLY: {
                return "$ALLY";
            }
        }
        return "";
    }

    internal function UpdateButtonToggleAssignText(arg1:Object):void {
        var loc1:* = arg1.vendingData.machineType;
        switch (loc1) {
            case SecureTradeShared.MACHINE_TYPE_INVALID: {
                this.ButtonToggleAssign.ButtonText = this.m_MenuMode
                != SecureTradeShared.MACHINE_TYPE_VENDING ? "$SecureTrade_InsertItem" : "$SELL";
                break;
            }
            case SecureTradeShared.MACHINE_TYPE_VENDING: {
                this.ButtonToggleAssign.ButtonText = "$CANCEL SALE";
                break;
            }
            case SecureTradeShared.MACHINE_TYPE_DISPLAY:
            case SecureTradeShared.MACHINE_TYPE_DISPENSER:
            case SecureTradeShared.MACHINE_TYPE_FERMENTER:
            case SecureTradeShared.MACHINE_TYPE_REFRIGERATOR:
            case SecureTradeShared.MACHINE_TYPE_ALLY: {
                this.ButtonToggleAssign.ButtonText = "$SecureTrade_RemoveDisplayedItem";
                break;
            }
        }
        return;
    }

    internal function updateButtonHints():void {
        var loc1:* = null;
        var loc2:* = null;
        var loc3:* = false;
        var loc4:* = false;
        var loc5:* = false;
        var loc6:* = false;
        var loc7:* = null;
        if (this.selectedList == null) {
            return;
        }
        this.DeclineItemAcceptButton.ButtonVisible = this.ModalDeclineItem_mc.Active;
        this.DeclineItemCancelButton.ButtonVisible = this.ModalDeclineItem_mc.Active;
        if (this.modalActive) {
            var loc8:* = 0;
            var loc9:* = this.ButtonHintDataV;
            for each (loc1 in loc9) {
                if (!(!(loc1 == this.DeclineItemAcceptButton) && !(loc1
                        == this.DeclineItemCancelButton))) {
                    continue;
                }
                loc1.ButtonVisible = false;
            }
        } else {
            loc2 = this.selectedListEntry;
            loc3 = this.selectedList == this.PlayerInventory_mc;
            loc4 = this.selectedList == this.OfferInventory_mc;
            loc5 = this.selectedList == null || loc2 == null;
            this.ButtonPlayerInventory.ButtonVisible = !(uiController
                    == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE) && this.OfferInventory_mc.Active
                    && !this.m_onlyGivingAllowed && !this.m_onlyTakingAllowed && !this.m_isWorkbench
                    && !this.m_PlayerInventoryEmpty;
            this.ButtonContainerInventory.ButtonVisible = !(uiController
                    == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE) && this.PlayerInventory_mc.Active
                    && !this.m_onlyGivingAllowed && !this.m_onlyTakingAllowed && !this.m_isWorkbench
                    && !this.m_ContainerEmpty;
            this.SortButton.ButtonVisible = true;
            this.SortButton.ButtonText = this.m_SortFieldText[loc3 ? this.m_PlayerInventorySortField
                    : this.m_OfferInventorySortField];
            this.ExitButton.ButtonVisible = true;
            this.InspectButton.ButtonDisabled = this.selectedList == null || loc2 == null;
            this.ScrapButton.ButtonVisible = !loc5 && (this.m_isWorkbench || this.m_isWorkshop)
                    && !(this.m_scrapAllowedFlag == 0);
            if (this.ScrapButton.ButtonVisible) {
                this.ScrapButton.ButtonDisabled = !(loc2.scrapAllowed == true) || (loc2.filterFlag
                        & this.m_scrapAllowedFlag) == 0;
            }
            this.StoreJunkButton.ButtonVisible = this.m_isWorkbench || this.m_isWorkshop
                    || this.m_isStash || this.isScrapStash;
            if (this.StoreJunkButton.ButtonVisible) {
                if (this.isScrapStash) {
                    loc6 = false;
                    loc8 = 0;
                    loc9 = this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData;
                    for each (loc7 in loc9) {
                        if (!(loc7.isAutoScrappable || loc7.canGoIntoScrapStash)) {
                            continue;
                        }
                        loc6 = true;
                        break;
                    }
                    this.StoreJunkButton.ButtonDisabled = !this.m_IsFollowerOfZeus || !loc6;
                    this.StoreJunkButton.ButtonText = "$SCRAPBOXSCRAPANDSTORE";
                } else {
                    this.StoreJunkButton.ButtonDisabled = this.m_isWorkbench
                            ? !this.m_playerHasAutoScrappableJunkItems : !this.m_playerHasMiscItems;
                    this.StoreJunkButton.ButtonText = this.m_isWorkbench ? "$ScrapAllJunk"
                            : "$StoreAllJunk";
                }
            }
            this.UpgradeStashButton.ButtonVisible = false;
            this.ToggleShowMarkedItemsOnlyButton.ButtonVisible = this.isCampVendingMenuType()
                    && this.m_OwnsVendor;
            loc8 = this.m_FilterItemsOption;
            switch (loc8) {
                case FILTER_OPTION_NONE: {
                    this.ToggleShowMarkedItemsOnlyButton.ButtonText = "$SecureTrade_ToggleShowMarked_ShowMarkedOnly";
                    break;
                }
                case FILTER_OPTION_THIS_MACHINE: {
                    this.ToggleShowMarkedItemsOnlyButton.ButtonText = "$SecureTrade_ToggleShowMarked_ShowMarkedAndStash";
                    break;
                }
                case FILTER_OPTION_THIS_MACHINE_AND_STASH: {
                    this.ToggleShowMarkedItemsOnlyButton.ButtonText = "$SecureTrade_ToggleShowMarked_ShowAll";
                    break;
                }
            }
            this.AcceptButton.ButtonVisible = !this.m_isWorkbench && !loc5;
            loc8 = this.m_MenuMode;
            switch (loc8) {
                case MODE_CONTAINER: {
                    this.ButtonDecline.ButtonVisible = false;
                    this.ButtonToggleAssign.ButtonVisible = loc2 && loc4
                            && !(loc2.vendingData.machineType
                                    == SecureTradeShared.MACHINE_TYPE_INVALID);
                    if (this.ButtonToggleAssign.ButtonVisible) {
                        this.UpdateButtonToggleAssignText(loc2);
                    }
                    this.InspectButton.ButtonVisible = true;
                    if (this.AcceptButton.ButtonVisible) {
                        this.AcceptButton.ButtonDisabled = false;
                        if (loc4) {
                            this.AcceptButton.ButtonText = this.m_AcceptBtnText_Container;
                        } else if (this.isScrapStash && loc2.scrapAllowed) {
                            this.AcceptButton.ButtonText = "$SCRAP";
                        } else {
                            this.AcceptButton.ButtonText = this.m_AcceptBtnText_Player;
                        }
                    }
                    this.TakeAllButton.ButtonVisible = !this.m_isWorkbench && !this.m_isCamp
                            && !this.m_isStash && !this.m_onlyGivingAllowed && !this.isScrapStash;
                    if (this.TakeAllButton.ButtonVisible) {
                        this.TakeAllButton.ButtonText = this.m_TakeAllBtnText;
                    }
                    this.ButtonOffersOnly.ButtonVisible = false;
                    break;
                }
                case MODE_NPCVENDING: {
                    this.ButtonDecline.ButtonVisible = loc4 && !(loc2 == null) && loc2.isOffered;
                    this.ButtonToggleAssign.ButtonVisible = false;
                    this.InspectButton.ButtonVisible = true;
                    if (this.AcceptButton.ButtonVisible) {
                        this.AcceptButton.ButtonDisabled = !loc4 && this.m_VendorSellOnly;
                        this.AcceptButton.ButtonText = loc4 ? "$BUY" : "$SELL";
                    }
                    this.TakeAllButton.ButtonVisible = false;
                    this.ButtonOffersOnly.ButtonVisible = false;
                    break;
                }
                case MODE_PLAYERVENDING: {
                    this.ButtonDecline.ButtonVisible = loc4 && !(loc2 == null) && loc2.isOffered;
                    this.ButtonToggleAssign.ButtonVisible = false;
                    this.InspectButton.ButtonVisible = true;
                    if (this.AcceptButton.ButtonVisible) {
                        this.AcceptButton.ButtonDisabled = loc4 && loc2.isTradable == false;
                        if (loc4) {
                            this.AcceptButton.ButtonText = loc2.isOffered ? "$BUY"
                                    : loc2.isRequested ? "$CANCEL" : "$REQUEST";
                        } else {
                            this.AcceptButton.ButtonText = "$OFFER";
                        }
                    }
                    this.TakeAllButton.ButtonVisible = false;
                    this.ButtonOffersOnly.ButtonVisible = true;
                    this.ButtonOffersOnly.ButtonText = this.m_ShowOffersOnly ? "$SHOWALL"
                            : "$OFFERSONLY";
                    this.ButtonOffersOnly.ButtonDisabled = !this.m_PlayerConnected;
                    break;
                }
                case MODE_VENDING_MACHINE: {
                    this.ButtonDecline.ButtonVisible = false;
                    this.ButtonToggleAssign.ButtonVisible = this.m_OwnsVendor && !(loc2 == null)
                            && loc4;
                    if (this.ButtonToggleAssign.ButtonVisible) {
                        this.UpdateButtonToggleAssignText(loc2);
                    }
                    this.InspectButton.ButtonVisible = true;
                    if (loc3 && !this.m_OwnsVendor) {
                        this.AcceptButton.ButtonVisible = false;
                    }
                    if (this.AcceptButton.ButtonVisible) {
                        this.AcceptButton.ButtonDisabled = false;
                        if (this.m_OwnsVendor) {
                            this.AcceptButton.ButtonText = loc4 ? this.m_AcceptBtnText_Container
                                    : "$SELL";
                        } else {
                            this.AcceptButton.ButtonText = "$BUY";
                        }
                    }
                    this.TakeAllButton.ButtonVisible = false;
                    this.ButtonOffersOnly.ButtonVisible = false;
                    break;
                }
                case MODE_DISPLAY_CASE:
                case MODE_ALLY:
                case MODE_FERMENTER:
                case MODE_REFRIGERATOR:
                case MODE_CAMP_DISPENSER: {
                    this.ButtonDecline.ButtonVisible = false;
                    this.ButtonToggleAssign.ButtonVisible = this.m_OwnsVendor && !(loc2 == null)
                            && loc4;
                    if (this.ButtonToggleAssign.ButtonVisible) {
                        this.ButtonToggleAssign.ButtonDisabled = this.m_ProcessingItemEvent;
                        this.UpdateButtonToggleAssignText(loc2);
                    }
                    this.InspectButton.ButtonVisible = true;
                    if (loc3 && !this.m_OwnsVendor) {
                        this.AcceptButton.ButtonVisible = false;
                    }
                    if (this.AcceptButton.ButtonVisible) {
                        this.AcceptButton.ButtonDisabled = this.m_ProcessingItemEvent;
                        this.AcceptButton.ButtonText = loc4 ? this.m_AcceptBtnText_Container
                                : this.m_AcceptBtnText_Player_Assign;
                    }
                    this.TakeAllButton.ButtonVisible = false;
                    this.ButtonOffersOnly.ButtonVisible = false;
                    break;
                }
            }
            if (this.ButtonContainerInventory.ButtonVisible) {
                this.ButtonContainerInventory.ButtonText = this.ModeToButtonSwitchText(
                        this.m_MenuMode);
            }
        }
        return;
    }

    internal function updateInventoryFocus():void {
        if (this.m_onlyTakingAllowed) {
            if (this.selectedList != this.OfferInventory_mc) {
                this.onSwapInventoryContainer();
            }
        } else if (this.m_onlyGivingAllowed || this.m_isWorkbench) {
            if (this.selectedList != this.PlayerInventory_mc) {
                this.onSwapInventoryPlayer();
            }
        } else if (!this.m_PlayerInventoryEmpty && !this.m_ContainerEmpty
                && !(this.m_StartingFocusPref == STARTING_FOCUS_PREF_NONE)) {
            if (this.m_StartingFocusPref != STARTING_FOCUS_PREF_PLAYER) {
                if (this.m_StartingFocusPref == STARTING_FOCUS_PREF_CONTAINER) {
                    this.onSwapInventoryContainer();
                }
            } else {
                this.onSwapInventoryPlayer();
            }
            this.m_StartingFocusPref = STARTING_FOCUS_PREF_NONE;
        } else if (this.m_PlayerInventoryEmpty && !this.m_ContainerEmpty && this.selectedList
                == this.PlayerInventory_mc) {
            this.onSwapInventoryContainer();
        } else if (this.m_ContainerEmpty && !this.m_PlayerInventoryEmpty && this.selectedList
                == this.OfferInventory_mc) {
            this.onSwapInventoryPlayer();
        }
        return;
    }

    internal function onBackButton():void {
        this.ClearSelectedItemValues();
        var loc1:* = true;
        if (this.ModalSetPrice_mc.opened) {
            this.closeSetPriceModal();
        } else if (this.ModalSetQuantity_mc.opened) {
            this.closeQuantityModal();
        } else if (this.ModalDeclineItem_mc.Active) {
            this.closeDeclineItemModal();
        } else if (this.ModalConfirmPurchase_mc.open) {
            this.closeConfirmPurchaseModal();
        } else if (this.ModalConfirmTakeAll_mc.open) {
            this.closeConfirmTakeAllModal();
        } else if (this.ModalConfirmScrap_mc.open) {
            this.ModalConfirmScrap_mc.HandleSecondaryAction();
            loc1 = false;
        } else if (this.ModalUpgradeStash_mc.open) {
            this.closeUpgradeStashModel();
        } else {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_MENU_EXIT, {}));
        }
        if (loc1) {
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_CANCEL);
        }
        return;
    }

    internal function onUpgradeButton():void {
        this.openUpgradeStashModal();
        return;
    }

    internal function onSwapInventoryPlayer():void {
        this.selectedList = this.PlayerInventory_mc as SecureTradeInventory;
        if (!(uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)
                && this.selectedList.ItemList_mc.List_mc.selectedIndex == -1) {
            this.selectedList.ItemList_mc.List_mc.selectedIndex = 0;
        }
        this.updateButtonHints();
        return;
    }

    internal function onSwapInventoryContainer():void {
        this.selectedList = this.OfferInventory_mc as SecureTradeInventory;
        if (!(uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)
                && this.selectedList.ItemList_mc.List_mc.selectedIndex == -1) {
            this.selectedList.ItemList_mc.List_mc.selectedIndex = 0;
        }
        this.updateButtonHints();
        return;
    }

    internal function onRequestSort(arg1:Boolean = true):void {
        var loc1:* = 0;
        if (this.isScrapStash) {
            loc1 = this.JUNK_TAB_INDEX;
        } else if (this.m_MenuMode != MODE_PLAYERVENDING) {
            if (this.m_SelectedTab > this.WEAPONS_TAB_INDEX) {
                loc1 = this.m_SelectedTab - this.WEAPONS_TAB_INDEX;
            }
        } else if (this.m_SelectedTab > this.PLAYERVENDING_WEAPONS_TAB_INDEX) {
            loc1 = this.m_SelectedTab - this.PLAYERVENDING_WEAPONS_TAB_INDEX;
        }
        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_REQUEST_SORT, {
            "isPlayerInventory": this.selectedList == this.PlayerInventory_mc,
            "filter": loc1,
            "incrementSort": arg1,
            "tabIndex": this.m_SelectedTab
        }));
        return;
    }

    internal function onAccept():void {
        var loc1:* = true;
        if (this.ModalConfirmPurchase_mc.open) {
            this.onConfirmPurchaseAccept();
        } else if (this.ModalConfirmTakeAll_mc.open) {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TAKE_ALL, {}));
        } else if (this.ModalConfirmScrap_mc.open) {
            this.ModalConfirmScrap_mc.HandlePrimaryAction();
            loc1 = false;
        } else if (this.ModalUpgradeStash_mc.open) {
            this.onUpgradeStashAccepted();
        }
        if (loc1) {
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
        }
        return;
    }

    internal function selectItemViaHandleID(arg1:MenuListComponent):void {
        var loc1:* = null;
        var loc2:* = 0;
        var loc3:* = false;
        if (!this.selectedListEntry || !(this.selectedListEntry.serverHandleId
                == this.m_SelectedItemServerHandleId)) {
            loc1 = arg1.List_mc.MenuListData;
            loc2 = 0;
            while (loc2 < loc1.length) {
                if (loc1[loc2].serverHandleId == this.m_SelectedItemServerHandleId) {
                    loc3 = arg1.disableSelection_Inspectable;
                    arg1.disableSelection_Inspectable = false;
                    arg1.setSelectedIndex(loc2);
                    arg1.disableSelection_Inspectable = loc3;
                }
                ++loc2;
            }
        }
        return;
    }

    internal function selectStackViaNameCount(arg1:MenuListComponent, arg2:String,
            arg3:Number):void {
        var loc1:* = null;
        var loc2:* = 0;
        var loc3:* = false;
        if (!this.selectedListEntry || !(this.selectedListEntry.text == arg2)
                || !(this.selectedListEntry.count == arg3)
                || !(this.selectedListEntry.vendingData.machineType
                        == SecureTradeShared.MACHINE_TYPE_INVALID)) {
            loc1 = arg1.List_mc.MenuListData;
            loc2 = 0;
            while (loc2 < loc1.length) {
                if (loc1[loc2].text == arg2 && loc1[loc2].count == arg3
                        && loc1[loc2].vendingData.machineType
                        == SecureTradeShared.MACHINE_TYPE_INVALID) {
                    loc3 = arg1.disableSelection_Inspectable;
                    arg1.disableSelection_Inspectable = false;
                    arg1.setSelectedIndex(loc2);
                    arg1.disableSelection_Inspectable = loc3;
                }
                ++loc2;
            }
        }
        return;
    }

    internal function PopulateOfferInventory(arg1:Array):void {
        this.SortListData(arg1, this.m_OfferInventorySortField);
        this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData = arg1;
        if (this.selectedList == this.OfferInventory_mc) {
            if (this.m_RefreshSelectionOption == REFRESH_SELECTION_SERVER_ID
                    && this.m_SelectedItemServerHandleId > 0) {
                this.selectItemViaHandleID(this.OfferInventory_mc.ItemList_mc);
            } else if (this.m_RefreshSelectionOption == REFRESH_SELECTION_NAME_COUNT) {
                this.selectStackViaNameCount(this.OfferInventory_mc.ItemList_mc,
                        this.m_SelectedStackName, (this.m_SelectedItemCount - 1));
            }
        }
        this.OfferInventory_mc.ItemList_mc.SetIsDirty();
        this.OfferInventory_mc.UpdateTooltips();
        this.m_ContainerEmpty = this.IsInventoryEmpty(this.OfferInventory_mc);
        if (this.m_MenuMode == MODE_PLAYERVENDING && this.selectedList == this.OfferInventory_mc
                && this.modalActive && this.SelectedOfferChanged(
                        this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData)) {
            this.onBackButton();
            GlobalFunc.ShowHUDMessage("$TradeOfferChanged");
        }
        this.updateInventoryFocus();
        this.onSelectedDataChanged(null);
        return;
    }

    internal function PopulatePlayerInventory(arg1:Array):void {
        var loc1:* = 0;
        this.SortListData(arg1, this.m_PlayerInventorySortField);
        this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData = arg1;
        if (this.selectedList == this.PlayerInventory_mc) {
            if (this.m_RefreshSelectionOption == REFRESH_SELECTION_SERVER_ID
                    && this.m_SelectedItemServerHandleId > 0) {
                this.selectItemViaHandleID(this.PlayerInventory_mc.ItemList_mc);
            } else if (this.m_RefreshSelectionOption == REFRESH_SELECTION_NAME_COUNT) {
                this.selectStackViaNameCount(this.PlayerInventory_mc.ItemList_mc,
                        this.m_SelectedStackName, (this.m_SelectedItemCount - 1));
            }
        }
        this.PlayerInventory_mc.ItemList_mc.SetIsDirty();
        this.PlayerInventory_mc.UpdateToolTipText();
        this.m_playerHasMiscItems = false;
        this.m_playerHasAutoScrappableJunkItems = false;
        if (arg1 is Array) {
            loc1 = 0;
            while (loc1 < arg1.length) {
                if ((arg1[loc1].filterFlag & 1 << 10) > 0) {
                    this.m_playerHasMiscItems = true;
                }
                if ((arg1[loc1].filterFlag & 1 << 15) > 0) {
                    this.m_playerHasAutoScrappableJunkItems = true;
                }
                if (!(this.m_playerHasMiscItems == true && this.m_playerHasAutoScrappableJunkItems
                        == true)) {
                }
                ;
                ++loc1;
            }
        }
        if (this.m_MenuMode == MODE_PLAYERVENDING && this.selectedList == this.PlayerInventory_mc
                && this.modalActive && this.SelectedOfferChanged(
                        this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData, true)) {
            this.onBackButton();
            GlobalFunc.ShowHUDMessage("$TradeOfferChanged");
        }
        this.m_PlayerInventoryEmpty = !(this.PlayerInventory_mc == null) && this.IsInventoryEmpty(
                this.PlayerInventory_mc);
        this.updateButtonHints();
        this.onSelectedDataChanged(null);
        return;
    }

    internal function onToggleShowMarkedItemsOnlyButton():void {
        if (!this.isCampVendingMenuType() || !this.m_OwnsVendor) {
            return;
        }
        var loc1:*;
        var loc2:* = ((loc1 = this).m_FilterItemsOption + 1);
        loc1.m_FilterItemsOption = loc2;
        if (this.m_FilterItemsOption == FILTER_OPTION_COUNT) {
            this.m_FilterItemsOption = FILTER_OPTION_NONE;
        }
        this.SetSelectedItemValues(this.selectedListEntry);
        this.PopulateCampVendingInventory();
        this.updateButtonHints();
        this.ClearSelectedItemValues();
        return;
    }

    internal function PopulateCampVendingInventory():void {
        var listData:Array;

        var loc1:*;
        if (!this.isCampVendingMenuType()) {
            return;
        }
        if (this.m_OwnsVendor) {
            this.UpdatePartialItems(this.m_OtherInvData, this.m_TheirOffersData);
        }
        listData = this.m_OwnsVendor ? this.m_OtherInvData : this.m_TheirOffersData;
        var loc2:* = this.m_FilterItemsOption;
        switch (loc2) {
            case FILTER_OPTION_THIS_MACHINE: {
                listData = listData.filter(function (arg1:Object):Boolean {
                    var loc1:* = arg1.vendingData;
                    return !(loc1.machineType == SecureTradeShared.MACHINE_TYPE_INVALID)
                            && !loc1.isVendedOnOtherMachine;
                })
                break;
            }
            case FILTER_OPTION_THIS_MACHINE_AND_STASH: {
                listData = listData.filter(function (arg1:Object):Boolean {
                    var loc1:* = arg1.vendingData;
                    return loc1.machineType == SecureTradeShared.MACHINE_TYPE_INVALID
                            || !loc1.isVendedOnOtherMachine;
                })
                break;
            }
            default: {
                break;
            }
        }
        this.SortListData(listData, this.m_OfferInventorySortField);
        this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData = listData;
        if (this.selectedList == this.OfferInventory_mc) {
            if (this.m_RefreshSelectionOption == REFRESH_SELECTION_SERVER_ID
                    && this.m_SelectedItemServerHandleId > 0) {
                this.selectItemViaHandleID(this.OfferInventory_mc.ItemList_mc);
            } else if (this.m_RefreshSelectionOption == REFRESH_SELECTION_NAME_COUNT) {
                this.selectStackViaNameCount(this.OfferInventory_mc.ItemList_mc,
                        this.m_SelectedStackName, (this.m_SelectedItemCount - 1));
            }
        }
        this.OfferInventory_mc.ItemList_mc.SetIsDirty();
        this.OfferInventory_mc.UpdateTooltips();
        this.m_ContainerEmpty = this.IsInventoryEmpty(this.OfferInventory_mc);
        if (this.selectedList == this.OfferInventory_mc && this.modalActive
                && this.SelectedOfferChanged(
                        this.OfferInventory_mc.ItemList_mc.List_mc.MenuListData)) {
            this.onBackButton();
            GlobalFunc.ShowHUDMessage("$TradeOfferChanged");
        }
        this.updateInventoryFocus();
        this.onSelectedDataChanged(null);
        return;
    }

    public function ProcessUserEvent(arg1:String, arg2:Boolean):Boolean {
        var loc2:* = false;
        var loc3:* = null;
        var loc1:* = false;
        if (this.m_IgnorePlayerVendingItemPress && arg2 && arg1 == "Accept") {
            this.m_IgnorePlayerVendingItemPress = false;
        }
        if (this.ModalSetPrice_mc.opened) {
            loc1 = this.ModalSetPrice_mc.ProcessUserEvent(this.ConvertEventString(arg1), arg2);
        }
        if (!loc1 && this.ModalSetQuantity_mc.opened) {
            loc1 = this.ModalSetQuantity_mc.ProcessUserEvent(this.ConvertEventString(arg1), arg2);
        }
        if (!loc1 && this.isOpen && !arg2) {
            var loc4:* = arg1;
            switch (loc4) {
                case "SwitchToPlayer": {
                    if (this.ButtonPlayerInventory.ButtonVisible == true
                            && !(this.ButtonPlayerInventory.ButtonDisabled == true)
                            && !(this.m_PlayerInventoryEmpty == true)) {
                        this.onSwapInventoryPlayer();
                        loc1 = true;
                    }
                    break;
                }
                case "SwitchToContainer": {
                    if (this.ButtonContainerInventory.ButtonVisible == true
                            && !(this.ButtonContainerInventory.ButtonDisabled == true)
                            && !(this.m_ContainerEmpty == true)) {
                        this.onSwapInventoryContainer();
                        loc1 = true;
                    }
                    break;
                }
                case "DeclineItem": {
                    if (this.InspectButton.ButtonVisible == true
                            && !(this.InspectButton.ButtonDisabled == true)) {
                        this.onInspectItem();
                        loc1 = true;
                    }
                    break;
                }
                case "SortList": {
                    if (!this.modalActive) {
                        this.onRequestSort();
                        loc1 = true;
                    }
                    break;
                }
                case "TakeAll": {
                    if (this.ButtonDecline.ButtonVisible == true
                            && !(this.ButtonDecline.ButtonDisabled == true)) {
                        this.onDeclineItem();
                        loc1 = true;
                    } else if (this.ButtonToggleAssign.ButtonVisible == true
                            && !(this.ButtonToggleAssign.ButtonDisabled == true)) {
                        this.onToggleAssign();
                        loc1 = true;
                    } else if (this.TakeAllButton.ButtonVisible == true
                            && !(this.TakeAllButton.ButtonDisabled == true)) {
                        this.onTakeAll();
                        loc1 = true;
                    }
                    break;
                }
                case "StoreAllJunk": {
                    if (this.StoreJunkButton.ButtonVisible != true) {
                        if (this.ButtonOffersOnly.ButtonVisible == true
                                && !(this.ButtonOffersOnly.ButtonDisabled == true)) {
                            this.onOffersOnly();
                            loc1 = true;
                        } else if (this.ToggleShowMarkedItemsOnlyButton.ButtonVisible == true
                                && !(this.ToggleShowMarkedItemsOnlyButton.ButtonDisabled == true)) {
                            this.onToggleShowMarkedItemsOnlyButton();
                            loc1 = true;
                        }
                    } else {
                        if (this.StoreJunkButton.ButtonDisabled) {
                            if (this.isScrapStash) {
                                loc2 = false;
                                loc4 = 0;
                                var loc5:* = this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData;
                                for each (loc3 in loc5) {
                                    if (!(loc3.isAutoScrappable || loc3.canGoIntoScrapStash)) {
                                        continue;
                                    }
                                    loc2 = true;
                                    break;
                                }
                                if (this.m_IsFollowerOfZeus) {
                                    if (!loc2) {
                                        GlobalFunc.ShowHUDMessage(
                                                "$StoreJunkFailNoScrappableItems");
                                    }
                                } else {
                                    GlobalFunc.ShowHUDMessage("$StoreJunkFailNoFO1st");
                                }
                            }
                        } else {
                            this.onStoreJunk();
                        }
                        loc1 = true;
                    }
                    break;
                }
                case "Select": {
                    if (!this.modalActive) {
                        this.onUpgradeButton();
                    }
                    break;
                }
                case "Cancel": {
                    this.onBackButton();
                    loc1 = true;
                    break;
                }
            }
        }
        return loc1;
    }

    internal function SortListData(arg1:Array, arg2:int):void {
        var aListData:Array;
        var aSortField:int;

        var loc1:*;
        aListData = arg1;
        aSortField = arg2;
        if (aListData != null) {
            aListData.sort(function (arg1:Object, arg2:Object):int {
                var loc2:* = null;
                var loc3:* = NaN;
                var loc4:* = NaN;
                var loc1:* = 0;
                if (arg1.vendingData.isVendedOnOtherMachine && arg2.isOffered
                        && !arg2.vendingData.isVendedOnOtherMachine) {
                    loc1 = 1;
                } else if (arg1.isOffered && !arg1.vendingData.isVendedOnOtherMachine
                        && arg2.vendingData.isVendedOnOtherMachine) {
                    loc1 = -1;
                } else if (arg1.vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID
                        && !(arg2.vendingData.machineType
                                == SecureTradeShared.MACHINE_TYPE_INVALID)) {
                    loc1 = 1;
                } else if (!(arg1.vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID)
                        && arg2.vendingData.machineType == SecureTradeShared.MACHINE_TYPE_INVALID) {
                    loc1 = -1;
                } else if (arg1.vendingData.machineType < arg2.vendingData.machineType) {
                    loc1 = -1;
                } else if (arg1.vendingData.machineType > arg2.vendingData.machineType) {
                    loc1 = 1;
                } else {
                    loc2 = "";
                    var loc5:* = aSortField;
                    switch (loc5) {
                        case SOF_DAMAGE: {
                            loc2 = "damage";
                            break;
                        }
                        case SOF_ROF: {
                            loc2 = "weaponDisplayRateOfFire";
                            break;
                        }
                        case SOF_RANGE: {
                            loc2 = "weaponDisplayRange";
                            break;
                        }
                        case SOF_ACCURACY: {
                            loc2 = "weaponDisplayAccuracy";
                            break;
                        }
                        case SOF_VALUE: {
                            loc2 = "itemValue";
                            break;
                        }
                        case SOF_WEIGHT: {
                            loc2 = "weight";
                            break;
                        }
                        case SOF_SPOILAGE: {
                            loc3 = arg1.currentHealth >= 0 ? arg1.currentHealth / arg1.maximumHealth
                                    : 1;
                            loc4 = arg2.currentHealth >= 0 ? arg2.currentHealth / arg2.maximumHealth
                                    : 1;
                            if (loc3 != loc4) {
                                loc1 = loc3 < loc4 ? -1 : 1;
                            }
                            break;
                        }
                        default: {
                            loc2 = "isLearnedRecipe";
                            break;
                        }
                    }
                    if (loc2 != "") {
                        if (arg1[loc2] < arg2[loc2]) {
                            loc1 = 1;
                        } else if (arg1[loc2] > arg2[loc2]) {
                            loc1 = -1;
                        }
                    }
                }
                if (loc1 == 0) {
                    if (arg1.text < arg2.text) {
                        loc1 = -1;
                    } else if (arg1.text > arg2.text) {
                        loc1 = 1;
                    } else if (arg1.count < arg2.count) {
                        loc1 = -1;
                    } else if (arg1.count > arg2.count) {
                        loc1 = 1;
                    }
                }
                if (loc1 == 0) {
                    if (arg1.serverHandleId < arg2.serverHandleId) {
                        loc1 = 1;
                    } else if (arg1.serverHandleId > arg2.serverHandleId) {
                        loc1 = -1;
                    }
                }
                return loc1;
            })
        }
        return;
    }

    internal function CreateScrappableInventoryList(arg1:Array):Array {
        var loc2:* = null;
        var loc1:* = new Array();
        var loc3:* = 0;
        var loc4:* = arg1;
        for each (loc2 in loc4) {
            if (!loc2.scrapAllowed) {
                continue;
            }
            loc1.push(loc2);
        }
        return loc1;
    }

    internal function ConvertEventString(arg1:String):String {
        if (arg1 == "SwitchToContainer") {
            return "RTrigger";
        }
        if (arg1 == "SwitchToPlayer") {
            return "LTrigger";
        }
        return arg1;
    }

    internal function IsInventoryEmpty(arg1:MovieClip):Boolean {
        var loc1:* = true;
        var loc2:* = true;
        if (arg1 != null) {
            if (!(arg1.ItemList_mc.List_mc.MenuListData == undefined)
                    && !(arg1.ItemList_mc.List_mc.MenuListData == null)) {
                loc1 = arg1.ItemList_mc.List_mc.MenuListData.length == 0;
            }
            if (!(arg1.ItemList_mc.List_mc.filterer == undefined)
                    && !(arg1.ItemList_mc.List_mc.filterer == null)) {
                loc2 = arg1.ItemList_mc.List_mc.filterer.IsFilterEmpty(
                        this.m_ItemFilters[this.m_SelectedTab].flag);
            }
        }
        return loc1 || loc2;
    }

    internal function SetSelectedItemValues(arg1:Object):void {
        if (!(arg1 == null) && !this.m_SelectedItemValueSet) {
            this.m_SelectedStackName = arg1.text;
            this.m_SelectedItemOffered = arg1.isOffered;
            this.m_SelectedItemValue = arg1.itemValue;
            this.m_SelectedItemCount = arg1.count;
            this.m_SelectedItemServerHandleId = arg1.serverHandleId;
            this.m_SelectedItemIsPartialOffer = arg1.partialOffer;
            this.m_RefreshSelectionOption = REFRESH_SELECTION_SERVER_ID;
            this.m_SelectedItemValueSet = true;
        }
        return;
    }

    internal function ClearSelectedItemValues():void {
        this.m_SelectedStackName = "";
        this.m_SelectedItemOffered = false;
        this.m_SelectedItemValue = 0;
        this.m_SelectedItemCount = 0;
        this.m_SelectedItemServerHandleId = 0;
        this.m_SelectedItemIsPartialOffer = false;
        this.m_RefreshSelectionOption = REFRESH_SELECTION_NONE;
        this.m_SelectedItemValueSet = false;
        return;
    }

    internal function SelectedOfferChanged(arg1:Array, arg2:Boolean = false):Boolean {
        var loc1:* = true;
        var loc2:* = null;
        var loc3:* = 0;
        while (loc3 < arg1.length) {
            if (arg1[loc3].serverHandleId == this.m_SelectedItemServerHandleId && (arg2
                    && !this.m_SelectedItemOffered || arg1[loc3].partialOffer
                    == this.m_SelectedItemIsPartialOffer)) {
                loc2 = arg1[loc3];
                break;
            }
            ++loc3;
        }
        if (loc2 != null) {
            if (arg2) {
                loc1 = false;
            } else if (this.m_SelectedItemOffered == loc2.isOffered && this.m_SelectedItemValue
                    == loc2.itemValue && this.m_SelectedItemCount == loc2.count) {
                loc1 = false;
            }
        }
        return loc1;
    }

    internal function UpdatePartialItems(arg1:Array, arg2:Array):void {
        var loc1:* = arg1.length;
        while (--loc1 > -1) {
            if (arg1[loc1].partialOffer != true) {
                continue;
            }
            arg1.splice(loc1, 1);
        }
        var loc2:* = 0;
        while (loc2 < arg2.length) {
            if (arg2[loc2].partialOffer == true) {
                arg1.push(arg2[loc2]);
            }
            ++loc2;
        }
        return;
    }

    internal function InsertRequestedItems(arg1:Array, arg2:Array):void {
        var loc1:* = arg1.length;
        while (--loc1 > -1) {
            if (arg1[loc1].isOffered != false) {
                continue;
            }
            arg1.splice(loc1, 1);
        }
        var loc2:* = 0;
        while (loc2 < arg2.length) {
            if (arg2[loc2].isRequested == true) {
                arg1.push(arg2[loc2]);
            }
            ++loc2;
        }
        return;
    }

    internal function frame1():* {
        stop();
        return;
    }

    internal function frame32():* {
        stop();
        return;
    }

    internal function frame49():* {
        stop();
        return;
    }

    internal function frame59():* {
        stop();
        return;
    }

    internal function frame69():* {
        stop();
        return;
    }

    public function set currencyType(arg1:uint):void {
        this.m_CurrencyType = arg1;
        PlayerListEntry.currencyType = this.m_CurrencyType;
        OfferListEntry.currencyType = this.m_CurrencyType;
        this.PlayerInventory_mc.SetIsDirty();
        this.PlayerInventory_mc.ItemList_mc.SetIsDirty();
        this.OfferInventory_mc.SetIsDirty();
        this.OfferInventory_mc.ItemList_mc.SetIsDirty();
        if (this.m_CurrencyIconConfirmPurchase != null) {
            this.ModalConfirmPurchase_mc.Value_mc.Icon_mc.removeChild(
                    this.m_CurrencyIconConfirmPurchase);
            this.m_CurrencyIconConfirmPurchase = null;
        }
        if (this.m_CurrencyIconSetPrice != null) {
            this.ModalSetPrice_mc.Value_mc.Icon_mc.removeChild(this.m_CurrencyIconSetPrice);
            this.m_CurrencyIconSetPrice = null;
        }
        this.m_CurrencyIconConfirmPurchase = SecureTradeShared.setCurrencyIcon(
                this.ModalConfirmPurchase_mc.Value_mc.Icon_mc, this.m_CurrencyType);
        this.m_CurrencyIconSetPrice = SecureTradeShared.setCurrencyIcon(
                this.ModalSetPrice_mc.Value_mc.Icon_mc, this.m_CurrencyType);
        this.ModalConfirmPurchase_mc.Value_mc.Icon_mc.gotoAndStop(
                this.m_CurrencyType != SecureTradeShared.CURRENCY_LEGENDARY_TOKENS ? "Caps"
                        : "LTokens");
        this.ModalSetPrice_mc.Value_mc.Icon_mc.gotoAndStop(
                this.m_CurrencyType != SecureTradeShared.CURRENCY_LEGENDARY_TOKENS ? "unselected"
                        : "unselectedLToken");
        return;
    }

    public function get isScrapStash():Boolean {
        return this.m_isLimitedTypeStorage;
    }

    public function get currencyType():uint {
        return this.m_CurrencyType;
    }

    internal function isCampVendingMenuType():Boolean {
        return SecureTradeShared.IsCampVendingMenuType(this.m_MenuMode);
    }

    internal function updateOfferWeightDisplay():void {
        this.OfferInventory_mc.showCarryWeight = !this.isScrapStash && (this.m_MenuMode
                == MODE_CONTAINER || this.isCampVendingMenuType());
        return;
    }

    public function set menuMode(arg1:uint):void {
        this.m_MenuMode = arg1;
        PlayerListEntry.showCurrency = !(this.m_MenuMode == MODE_CONTAINER);
        PlayerListEntry.menuMode = arg1;
        OfferListEntry.menuMode = arg1;
        this.OfferInventory_mc.menuMode = this.m_MenuMode;
        this.updateOfferInventoryTooltipVis();
        this.PlayerInventory_mc.showTooltip = this.m_MenuMode == MODE_PLAYERVENDING;
        this.updateCategoryBar();
        this.CategoryBar_mc.SelectedID = this.NO_FILTER_ID;
        this.m_SelectedTabForceChange = true;
        this.selectedTab = 0;
        var loc1:* = this.m_MenuMode;
        switch (loc1) {
            case MODE_CONTAINER: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$CONTAINER");
                this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
                break;
            }
            case MODE_NPCVENDING:
            case MODE_VENDING_MACHINE: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$VENDOR");
                this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
                break;
            }
            case MODE_PLAYERVENDING: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$TRADING");
                this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
                break;
            }
            case MODE_DISPLAY_CASE: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$DISPLAY");
                this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
                break;
            }
            case MODE_FERMENTER: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$FERMENTER");
                this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
                break;
            }
            case MODE_REFRIGERATOR: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$REFRIGERATOR");
                this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
                break;
            }
            case MODE_CAMP_DISPENSER: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$DISPENSER");
                this.ItemCardContainer_mc.gotoAndStop("BackerHeight1");
                break;
            }
            case MODE_ALLY: {
                GlobalFunc.SetText(this.Header_mc.HeaderText_tf, "$ALLY");
                this.ItemCardContainer_mc.gotoAndStop("ItemStatsOff");
                break;
            }
        }
        this.updateHeaders();
        this.updateSelfInventory();
        this.updateOtherInventory();
        return;
    }

    public function set subMenuMode(arg1:uint):void {
        this.m_SubMenuMode = arg1;
        this.OfferInventory_mc.subMenuMode = this.m_SubMenuMode;
        this.updateCategoryBar();
        this.OfferInventory_mc.showTooltip = !(this.m_SubMenuMode
                == SecureTradeShared.SUB_MODE_STANDARD);
        return;
    }

    public function updateOfferInventoryTooltipVis():void {
        this.OfferInventory_mc.showTooltip = this.m_MenuMode == MODE_PLAYERVENDING
                || this.m_MenuMode == MODE_CONTAINER || this.isCampVendingMenuType();
        return;
    }

    public function set selectedTab(arg1:int):void {
        var loc1:* = null;
        if (!(arg1 == this.m_SelectedTab) || this.m_SelectedTabForceChange) {
            this.m_SelectedTabForceChange = false;
            if (arg1 < this.m_TabMin) {
                arg1 = this.m_TabMin;
            } else if (arg1 >= this.m_TabMax) {
                arg1 = (this.m_TabMax - 1);
            }
            this.m_SelectedTab = arg1;
            if (this.m_SelectedTab == arg1) {
                this.updateHeaders();
                this.PlayerInventory_mc.ItemList_mc.List_mc.filterer.itemFilter = this.m_ItemFilters[this.m_SelectedTab].flag;
                this.OfferInventory_mc.ItemList_mc.List_mc.filterer.itemFilter = this.m_ItemFilters[this.m_SelectedTab].flag;
                this.updateSelfInventory();
                this.OfferInventory_mc.ItemList_mc.SetIsDirty();
                this.m_ContainerEmpty = !(this.OfferInventory_mc == null) && this.IsInventoryEmpty(
                        this.OfferInventory_mc);
                this.updateInventoryFocus();
                this.updateButtonHints();
            }
            loc1 = this.selectedList != this.PlayerInventory_mc ? this.PlayerInventory_mc
                    : this.OfferInventory_mc;
            if (this.selectedList != null) {
                this.selectedList.selectedItemIndex = this.IsInventoryEmpty(this.selectedList) ? -1
                        : this.selectedList.ItemList_mc.List_mc.filterer.ClampIndex(0);
            }
            if (loc1 != null) {
                loc1.selectedItemIndex = -1;
            }
        }
        return;
    }

    public function get selectedTab():int {
        return this.m_SelectedTab;
    }

    public function set isOpen(arg1:Boolean):void {
        if (arg1 != this.m_IsOpen) {
            if (arg1) {
                gotoAndPlay("rollOn");
            } else {
                gotoAndPlay("rollOff");
            }
            this.m_IsOpen = arg1;
        }
        return;
    }

    public function get isOpen():Boolean {
        return this.m_IsOpen;
    }

    public function get selectedListEntry():Object {
        return this.m_SelectedList.ItemList_mc.List_mc.selectedEntry;
    }

    public function get selectedListIndex():int {
        return this.m_SelectedList.ItemList_mc.List_mc.selectedIndex;
    }

    internal function updateListActive(arg1:SecureTradeInventory):void {
        var loc1:* = this.m_SelectedList == arg1;
        arg1.Active = loc1;
        arg1.ItemList_mc.Active = loc1;
        arg1.ItemList_mc.List_mc.Active = loc1;
        arg1.ItemList_mc.List_mc.disableInput_Inspectable = !loc1;
        if (arg1.ItemList_mc.disableSelection_Inspectable) {
            arg1.ItemList_mc.disableSelection_Inspectable = false;
        }
        if (arg1.ItemList_mc.List_mc.hasBeenUpdated) {
            if (loc1) {
                arg1.ItemList_mc.setSelectedIndex(0);
            } else {
                arg1.ItemList_mc.setSelectedIndex(-1);
            }
        }
        arg1.ItemList_mc.disableSelection_Inspectable = !loc1;
        return;
    }

    public function set selectedList(arg1:SecureTradeInventory):* {
        if (arg1 != this.m_SelectedList) {
            this.m_SelectedList = arg1;
            stage.focus = this.m_SelectedList.ItemList_mc.List_mc;
            this.updateListActive(this.PlayerInventory_mc);
            this.updateListActive(this.OfferInventory_mc);
            this.updateButtonHints();
            this.updateHeaders();
        }
        return;
    }

    public function get selectedList():SecureTradeInventory {
        return this.m_SelectedList;
    }

    public function get modalActive():Boolean {
        return this.m_ModalActive;
    }

    public function set modalActive(arg1:Boolean):void {
        if (arg1 != this.m_ModalActive) {
            this.m_ModalActive = arg1;
            if (this.m_ModalActive) {
                gotoAndPlay("modalFadeOut");
            } else {
                gotoAndPlay("modalFadeIn");
            }
        }
        return;
    }

    internal function updateModalActive():void {
        this.modalActive = this.ModalSetQuantity_mc.opened || this.ModalSetPrice_mc.opened
                || this.ModalDeclineItem_mc.Active || this.ModalConfirmPurchase_mc.open
                || this.ModalConfirmTakeAll_mc.open || this.ModalConfirmScrap_mc.open
                || this.ModalUpgradeStash_mc.open;
        return;
    }

    public function Input_HandleLeftShoulder():uint {
        if (this.modalActive) {
            if (this.ModalSetPrice_mc.opened) {
                this.ModalSetPrice_mc.ProcessUserEvent("LShoulder", false);
            } else if (this.ModalSetQuantity_mc.opened) {
                this.ModalSetQuantity_mc.ProcessUserEvent("LShoulder", false);
            }
        } else {
            var loc1:*;
            var loc2:* = ((loc1 = this).selectedTab - 1);
            loc1.selectedTab = loc2;
            this.CategoryBar_mc.SelectPrevious();
        }
        return this.CategoryBar_mc.SelectedID;
    }

    public function Input_HandleRightShoulder():uint {
        if (this.modalActive) {
            if (this.ModalSetPrice_mc.opened) {
                this.ModalSetPrice_mc.ProcessUserEvent("RShoulder", false);
            } else if (this.ModalSetQuantity_mc.opened) {
                this.ModalSetQuantity_mc.ProcessUserEvent("RShoulder", false);
            }
        } else {
            var loc1:*;
            var loc2:* = ((loc1 = this).selectedTab + 1);
            loc1.selectedTab = loc2;
            this.CategoryBar_mc.SelectNext();
        }
        return this.CategoryBar_mc.SelectedID;
    }

    public function OnLabelMouseSelection(arg1:Event):void {
        var loc1:* = 0;
        if ((arg1 as CustomEvent).params.Source == this.CategoryBar_mc && !this.modalActive) {
            loc1 = (arg1 as CustomEvent).params.id;
            this.selectedTab = this.CategoryBar_mc.GetLabelIndex(loc1) + this.m_TabMin;
            this.CategoryBar_mc.SelectedID = loc1;
        }
        return;
    }

    internal function onInventoryTabWheel(arg1:Boolean):void {
        if (arg1) {
            var loc1:*;
            var loc2:* = ((loc1 = this).selectedTab - 1);
            loc1.selectedTab = loc2;
            this.CategoryBar_mc.SelectPrevious();
        } else {
            loc2 = ((loc1 = this).selectedTab + 1);
            loc1.selectedTab = loc2;
            this.CategoryBar_mc.SelectNext();
        }
        return;
    }

    internal const JUNK_TAB_INDEX:int = 8;

    public static const SOF_DAMAGE:int = 1;

    internal const TRANSFER_ITEM_COUNT_THRESHOLD:uint = 4;

    internal const WEAPONS_TAB_INDEX:int = 2;

    internal const PLAYERVENDING_WEAPONS_TAB_INDEX:int = 1;

    internal const NO_FILTER_ID:int = -1;

    internal const SCRAP_ITEM_COUNT_THRESHOLD:uint = 5;

    internal static const MODE_CONTAINER:uint = SecureTradeShared.MODE_CONTAINER;

    internal static const MODE_PLAYERVENDING:uint = SecureTradeShared.MODE_PLAYERVENDING;

    internal static const MODE_NPCVENDING:uint = SecureTradeShared.MODE_NPCVENDING;

    internal static const MODE_VENDING_MACHINE:uint = SecureTradeShared.MODE_VENDING_MACHINE;

    internal static const MODE_DISPLAY_CASE:uint = SecureTradeShared.MODE_DISPLAY_CASE;

    internal static const MODE_FERMENTER:uint = SecureTradeShared.MODE_FERMENTER;

    internal static const MODE_REFRIGERATOR:uint = SecureTradeShared.MODE_REFRIGERATOR;

    internal static const MODE_CAMP_DISPENSER:uint = SecureTradeShared.MODE_CAMP_DISPENSER;

    internal static const MODE_ALLY:uint = SecureTradeShared.MODE_ALLY;

    internal static const MODE_INVALID:uint = SecureTradeShared.MODE_INVALID;

    public static const EVENT_MENU_EXIT:String = "SecureTrade::ExitMenu";

    public static const EVENT_REQUEST_SORT:String = "SecureTrade::SortList";

    public static const EVENT_REQUEST_PURCHASE:String = "SecureTrade::RequestPurchase";

    public static const EVENT_DECLINE_ITEM:String = "SecureTrade::DeclineItem";

    public static const EVENT_CREATE_OFFER:String = "SecureTrade::CreateOffer";

    public static const EVENT_REMOVE_ITEM:String = "SecureTrade::RemoveItem";

    public static const EVENT_ITEM_SELECTED:String = "SecureTrade::OnItemSelected";

    public static const EVENT_UPGRADE_STASH:String = "SecureTrade::UpgradeStash";

    public static const EVENT_REQUEST_ITEM:String = "SecureTrade::RequestItem";

    public static const EVENT_CANCEL_REQUEST_ITEM:String = "SecureTrade::CancelRequestItem";

    public static const EVENT_NPC_BUY_ITEM:String = "NPCVend::BuyItem";

    public static const EVENT_NPC_SELL_ITEM:String = "NPCVend::SellItem";

    public static const EVENT_TAKE_ALL:String = "Container::TakeAll";

    public static const EVENT_INSPECT_ITEM:String = "Container::InspectItem";

    public static const EVENT_STORE_ALL_JUNK:String = "Workbench::StoreAllJunk";

    public static const EVENT_CAMP_SELL_ITEM:String = "CampVend::SellItem";

    public static const EVENT_CAMP_DISPLAY_ITEM:String = "CampVend::DisplayItem";

    public static const EVENT_CAMP_BUY_ITEM:String = "CampVend::BuyItem";

    public static const EVENT_CAMP_REMOVE_ITEM:String = "CampVend::RemoveItem";

    public static const EVENT_CAMP_DISPLAY_DECORATE_ITEM_IN_SLOT:String = "CampDecorate::DisplayDecorateItemInSlot";

    public static const EVENT_CAMP_REMOVE_DECORATE_ITEM_IN_SLOT:String = "CampDecorate::RemoveDecorateItemInSlot";

    public static const EVENT_TRANSFER_TOO_HEAVY_ERROR:String = "SecureTrade::TransferTooHeavyError";

    public static const EVENT_CAMP_STOP_ITEM_PROCESSING:String = "CampVend::StopItemProcessing";

    public static const EVENT_SELL_FAVORITE_DECLINED:String = "NPCVend::SellFavoriteItemDeclined";

    public static const EVENT_TRADE_FAVORITE_DECLINED:String = "PlayerVend::TradeFavoriteItemDeclined";

    public static const SOF_ALPHABETICALLY:int = 0;

    public static const SOF_ROF:int = 2;

    public static const SOF_RANGE:int = 3;

    public static const SOF_ACCURACY:int = 4;

    public static const SOF_VALUE:int = 5;

    public static const SOF_WEIGHT:int = 6;

    public static const SOF_SPOILAGE:int = 7;

    public static const MAX_SELL_PRICE:int = 30000;

    public static const FILTER_OPTION_NONE:int = 0;

    public static const FILTER_OPTION_THIS_MACHINE:int = 1;

    public static const FILTER_OPTION_THIS_MACHINE_AND_STASH:int = 2;

    public static const FILTER_OPTION_COUNT:int = 3;

    internal static const STARTING_FOCUS_PREF_NONE:uint = 0;

    internal static const STARTING_FOCUS_PREF_PLAYER:uint = 1;

    internal static const STARTING_FOCUS_PREF_CONTAINER:uint = 2;

    public static const REFRESH_SELECTION_NONE:int = 0;

    public static const REFRESH_SELECTION_SERVER_ID:int = 1;

    public static const REFRESH_SELECTION_NAME_COUNT:int = 2;

    public static const HEIGHT_BUFFER:uint = 250;

    public static const EVENT_TRANSFER_ITEM:String = "Container::TransferItem";

    internal var m_isLimitedTypeStorage:Boolean = false;

    internal var m_onlyGivingAllowed:Boolean = false;

    internal var m_onlyTakingAllowed:Boolean = false;

    internal var m_SortFieldText:Array;

    internal var m_PlayerInventorySortField:int = 0;

    internal var m_OfferInventorySortField:int = 0;

    internal var m_VendorSellOnly:Boolean = false;

    internal var m_ModalActive:Boolean = false;

    internal var m_ContainerEmpty:Boolean = false;

    internal var m_PlayerInventoryEmpty:Boolean = false;

    internal var m_TabEventName:String = "";

    internal var m_PlayerConnected:Boolean = false;

    internal var m_ProcessingItemEvent:Boolean = false;

    internal var m_ToolTipDefaultHeight:Number;

    internal var m_MyOffersData:Array;

    internal var m_TheirOffersData:Array;

    public var ButtonHintBar_mc:BSButtonHintBar;

    internal var m_OtherInvData:Array;

    internal var m_ShowOffersOnly:Boolean = false;

    internal var m_OwnsVendor:Boolean = false;

    internal var m_ShowPlayerValueEntry:Boolean = true;

    internal var m_IsFollowerOfZeus:Boolean = false;

    internal var m_IgnorePlayerVendingItemPress:Boolean = true;

    internal var m_FilterItemsOption:int = 0;

    internal var m_StartingFocusPref:int = 2;

    internal var m_CurrencyIconConfirmPurchase:MovieClip;

    internal var m_CurrencyIconSetPrice:MovieClip;

    internal var m_SelectedItemOffered:Boolean = false;

    internal var m_SelectedStackName:String = "";

    internal var m_SelectedItemValue:Number = 0;

    internal var m_SelectedItemCount:Number = 0;

    internal var m_SelectedItemServerHandleId:Number = 0;

    internal var m_SelectedItemIsPartialOffer:Boolean = false;

    internal var m_SelectedItemValueSet:Boolean = false;

    internal var m_RefreshSelectionOption:int = 0;

    public static var time:Number = 0;

    public static var delta:Number = 0;

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

    internal var _OnQuantityConfirmedFn:Function = null;

    internal var _OnSetPriceConfirmedFn:Function = null;

    internal var ButtonPlayerInventory:BSButtonHintData;

    internal var ButtonContainerInventory:BSButtonHintData;

    internal var ButtonToggleAssign:BSButtonHintData;

    internal var ButtonOffersOnly:BSButtonHintData;

    internal var InspectButton:BSButtonHintData;

    internal var ScrapButton:BSButtonHintData;

    internal var ButtonHintDataV:Vector.<BSButtonHintData>;

    internal var TakeAllButton:BSButtonHintData;

    internal var StoreJunkButton:BSButtonHintData;

    internal var SortButton:BSButtonHintData;

    internal var ExitButton:BSButtonHintData;

    internal var AcceptButton:BSButtonHintData;

    internal var DeclineItemAcceptButton:BSButtonHintData;

    internal var DeclineItemCancelButton:BSButtonHintData;

    internal var UpgradeStashButton:BSButtonHintData;

    internal var ToggleShowMarkedItemsOnlyButton:BSButtonHintData;

    internal var ButtonDecline:BSButtonHintData;

    internal var m_IsOpen:Boolean = false;

    internal var m_PreviousFocus:InteractiveObject;

    internal var m_ItemFilters:Array;

    internal var m_SelectedList:SecureTradeInventory;

    internal var m_PlayerInvData:Array;

    internal var m_TabMax:* = 0;

    internal var m_TabMin:* = 0;

    internal var m_SelectedTab:int = 0;

    internal var m_SelectedTabForceChange:Boolean = false;

    internal var m_MenuMode:uint = 4294967295;

    internal var m_SubMenuMode:uint = 0;

    internal var m_CurrencyType:uint = 4294967295;

    internal var m_DefaultHeaderText:String = "$CONTAINER";

    internal var m_AcceptBtnText_Player:String = "$STORE";

    internal var m_AcceptBtnText_Player_Assign:String = "$Assign";

    internal var m_AcceptBtnText_Container:String = "$TAKE";

    internal var m_TakeAllBtnText:String = "$TAKE ALL";

    internal var m_scrapAllowedFlag:uint = 0;

    internal var m_playerHasMiscItems:Boolean = false;

    internal var m_playerHasAutoScrappableJunkItems:Boolean = false;

    internal var m_isWorkbench:Boolean = false;

    internal var m_isWorkshop:Boolean = false;

    internal var m_isCamp:Boolean = false;

    internal var m_isStash:Boolean = false;
}
}
