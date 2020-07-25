package {
import Shared.AS3.BSButtonHintData;
import Shared.AS3.Events.PlatformChangeEvent;
import Shared.AS3.ListFilterer;

import com.adobe.serialization.json.JSON;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

public class BetterInventory extends Sprite {

    private static const DEBUG_MODE:Boolean = // method body index: 210 method index: 210
            true;

    private static const STATS_PAGE_INDEX:int = // method body index: 210 method index: 210
            0;

    private static const INV_PAGE_INDEX:int = // method body index: 210 method index: 210
            1;

    private static const TAB_WEAPONS_INDEX:int = // method body index: 210 method index: 210
            0;

    private static const TAB_APPAREL_INDEX:int = // method body index: 210 method index: 210
            1;

    private static const TAB_AID_INDEX:int = // method body index: 210 method index: 210
            2;

    private static const TAB_MISC_INDEX:int = // method body index: 210 method index: 210
            3;

    private static const TAB_NOTES_INDEX:int = // method body index: 210 method index: 210
            5;

    private static const TAB_AMMO_INDEX:int = // method body index: 210 method index: 210
            8;

    public var debug_tf:TextField;
    private var pipboyMenu:MovieClip;

    private var filterButton:BSButtonHintData;
    private var _bIsDirty:Boolean;

    private var _buttonHintsInitialized:Boolean = false;

    private var itemInfoMap:Dictionary;

    private var paperDollMap:Dictionary;

    private var currentTab:int = -1;

    private var currentTabWeight:String = "0";

    private var filterer:ListFiltererEx;

    private var savedFilterMode:Array;

    private var shiftKeyDown:Boolean = false;

    private var ctrlKeyDown:Boolean = false;

    private var disableFilterChangeOnCtrl:Boolean = false;

    private var _translator:TextField;

    private var _weightStr:String = "";

    private var selectedTabLabelOverride:String = "";

    private var _stackWeightInvalidated:Boolean = false;

    public function BetterInventory() {
        // method body index: 211 method index: 211
        trace("BetterInventory loaded");
        this.itemInfoMap = new Dictionary();
        this.paperDollMap = new Dictionary();
        this.savedFilterMode = [-1, -1, -1, ListFiltererEx.FILTER_MISC_NON_KEYS, -1, -1, -1, -1,
            -1];
        this._translator = new TextField();
        super();
        trace("BetterInventory loaded");
        this.debug_tf.visible = true;
        this.debug_tf.selectable = true;
        this.debug_tf.mouseWheelEnabled = true;
        this.debug_tf.mouseEnabled = true;
        this.debug_tf.useRichTextClipboard = true;
        this.filterButton = new BSButtonHintData("$FILTER", "Ctrl", "PSN_L1", "Xenon_L1", 1,
                this.onCopyData);
        this.debug_tf.addEventListener(MouseEvent.CLICK, this.onCopyData);
        addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
    }

    private function init():void {
        // method body index: 212 method index: 212
        this.log("BetterInventory now initializing");
        stage.getChildAt(0)["BetterInventory"] = this;
        stage.addEventListener(PipboyChangeEvent.PIPBOY_CHANGE_EVENT, this.prePipboyChangeEvent,
                false, int.MAX_VALUE);
        stage.addEventListener(PipboyChangeEvent.PIPBOY_CHANGE_EVENT, this.postPipboyChangeEvent,
                false, 1);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
        this.invPage.List_mc.addEventListener(MouseEvent.MOUSE_WHEEL,
                this.invListMouseWheelHandler);
        this.invPage.addEventListener("PipboyPage::LowerPipboyAllowedChange",
                this.onLowerPipboyAllowedChange, false, int.MIN_VALUE);
        try {
            this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.Selected.textField_tf.addEventListener(
                    MouseEvent.CLICK, this.onTabClicked);
            this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.Selected.textField_tf.addEventListener(
                    MouseEvent.MOUSE_WHEEL, this.onTabMouseWheel);
        } catch (e:Error) {
            log("WARN: init(): Some QOL features could not be activated. Check missing paths?");
            log(e.errorID + " " + e.name + " " + e.message);
        }
        this.invPage.addEventListener("PipboyPage::BottomBarUpdate", this.onBottomBarUpdate, false,
                int.MIN_VALUE);
        var oldItemFilter:int = this.invPage.List_mc.filterer.itemFilter;
        this.filterer = new ListFiltererEx(this.itemInfoMap, this.paperDollMap);
        this.filterer.itemFilter = oldItemFilter;
        this.invPage.List_mc.filterer = this.filterer;
        this.invPage.List_mc.InvalidateData();
        this._translator.text = "$wt";
        this._weightStr = this._translator.text;
        if (this.pipboyMenu.DataObj.CurrentPage == INV_PAGE_INDEX) {
            this.preInventoryUpdate(this.pipboyMenu.DataObj);
            this.postInventoryUpdate(this.pipboyMenu.DataObj);
            this.SetIsDirty();
        }
    }

    private function onLowerPipboyAllowedChange(param1:Event):void {
        // method body index: 213 method index: 213
        this.log("PipboyPage::LowerPipboyAllowedChange - CanLowerPipboy:",
                this.invPage.CanLowerPipboy());
        this.updateFilterButton();
    }

    private function onBottomBarUpdate(param1:Event):void {
        // method body index: 214 method index: 214
        this.log("onBottomBarUpdate");
        this._stackWeightInvalidated = true;
        this.SetIsDirty();
    }

    public function ProcessUserEvent(param1:String, param2:Boolean):Boolean {
        // method body index: 215 method index: 215
        if (this.shiftKeyDown && !param2) {
            switch (param1) {
                case "Forward":
                case "LTrigger":
                    this.pipboyMenu.TryToSetTab(TAB_WEAPONS_INDEX);
                    return true;
                case "Back":
                case "RTrigger":
                    this.pipboyMenu.TryToSetTab(TAB_AMMO_INDEX);
                    return true;
                case "StrafeLeft":
                case "Left":
                    this.pipboyMenu.TryToSetTab(
                            Math.max(TAB_WEAPONS_INDEX, this.pipboyMenu.DataObj.CurrentTab - 2));
                    return true;
                case "StrafeRight":
                case "Right":
                    this.pipboyMenu.TryToSetTab(
                            Math.min(TAB_AMMO_INDEX, this.pipboyMenu.DataObj.CurrentTab + 2));
                    return true;
            }
        }
        if (this.pipboyMenu.uiPlatform == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE) {
            return false;
        }
        var _loc3_:Boolean = false;
        if (!param2) {
            if (param1 == "LShoulder") {
                this.onFilterButtonPress();
                _loc3_ = true;
            }
        }
        return _loc3_;
    }

    private function addedToStageHandler(param1:Event):void {
        // method body index: 216 method index: 216
        this.log3("Added to stage");
        try {
            this.log3("Trying to connect");
        } catch (e) {
            this.log3("format1")
            this.logError(e);
        }
        var _loc2_:* = stage.getChildAt(0);
        this.pipboyMenu = "Menu_mc" in _loc2_ ? _loc2_.Menu_mc : null;
        this.log("movieRoot:", _loc2_);
        this.log("pipboyMenu:", this.pipboyMenu);
        if (this.pipboyMenu && getQualifiedClassName(this.pipboyMenu) == "PipboyMenu") {
            this.init();
        } else {
            this.log("FAIL: Not injected into PipboyMenu.");
        }
    }

    private final function onRenderEvent(param1:Event):void {
        // method body index: 217 method index: 217
        if (stage) {
            stage.removeEventListener(Event.RENDER, this.onRenderEvent);
        }
        if (this._bIsDirty) {
            this._bIsDirty = false;
            this.redraw();
        }
    }

    private function invListMouseWheelHandler(param1:MouseEvent):void {
        // method body index: 218 method index: 218
        if (this.ctrlKeyDown) {
            this.disableFilterChangeOnCtrl = true;
        }
    }

    private function keyDownHandler(param1:KeyboardEvent):void {
        // method body index: 219 method index: 219
        if (param1.keyCode == Keyboard.SHIFT) {
            this.shiftKeyDown = true;
        } else if (param1.keyCode == Keyboard.CONTROL) {
            this.ctrlKeyDown = true;
        }
    }

    private function keyUpHandler(param1:KeyboardEvent):void {
        // method body index: 220 method index: 220
        if (param1.keyCode == Keyboard.SHIFT) {
            this.shiftKeyDown = false;
        } else if (param1.keyCode == Keyboard.CONTROL) {
            this.ctrlKeyDown = false;
        }
        switch (param1.keyCode) {
            case Keyboard.CONTROL:
                if (!this.disableFilterChangeOnCtrl) {
                    this.onFilterButtonPress();
                } else {
                    this.disableFilterChangeOnCtrl = false;
                }
                break;
            case Keyboard.ALTERNATE:
                this.onFilterPreviousPress();
        }
        if (param1.keyCode >= Keyboard.NUMBER_1 && param1.keyCode <= Keyboard.NUMBER_9) {
            this.onSetFilterMode(param1.keyCode - Keyboard.NUMBER_1);
        }
    }

    private function prePipboyChangeEvent(param1:PipboyChangeEvent):void {
        // method body index: 221 method index: 221
        if (param1.UpdateMask.Intersects(PipboyUpdateMask.Inventory)) {
            if (param1.DataObj.CurrentPage == INV_PAGE_INDEX) {
                this.preInventoryUpdate(param1.DataObj);
            }
        }
    }

    private function postPipboyChangeEvent(param1:PipboyChangeEvent):void {
        // method body index: 222 method index: 222
        if (param1.UpdateMask.Intersects(PipboyUpdateMask.Inventory)) {
            if (param1.DataObj.CurrentPage == INV_PAGE_INDEX) {
                this.postInventoryUpdate(param1.DataObj);
            }
            this.updateFilterButton();
        }
        this.SetIsDirty();
    }

    private function preInventoryUpdate(param1:Pipboy_DataObj):void {
        // method body index: 223 method index: 223
        this.populateItemInfoMap(param1.InvItems, param1.InvFilter);
    }

    private function postInventoryUpdate(param1:Pipboy_DataObj):void {
        // method body index: 224 method index: 224
        if (this.currentTab != param1.CurrentTab) {
            this.log("Tab changed from", this.currentTab, "to", param1.CurrentTab);
            if (this.currentTab > -1) {
            }
            this.applyFilter(this.savedFilterMode[param1.CurrentTab]);
            this.log("Restored saved filter mode:", this.savedFilterMode[param1.CurrentTab]);
            this.currentTab = param1.CurrentTab;
        }
        this.calcTabWeight();
    }

    private function applyFilter(param1:int):void {
        // method body index: 225 method index: 225
        this.filterer.extraFilterType = param1;
        this.updateFilterButton();
        this.calcTabWeight();
        this.SetIsDirty();
        this.invPage.List_mc.InvalidateData();
    }

    private function updateFilterButton():void {
        // method body index: 226 method index: 226
        var btnVisible:Boolean = this.pipboyMenu.DataObj.CurrentPage == INV_PAGE_INDEX
                && (this.pipboyMenu.DataObj.CurrentTab == TAB_WEAPONS_INDEX
                        || this.pipboyMenu.DataObj.CurrentTab == TAB_APPAREL_INDEX
                        || this.pipboyMenu.DataObj.CurrentTab == TAB_AID_INDEX
                        || this.pipboyMenu.DataObj.CurrentTab == TAB_MISC_INDEX
                        || this.pipboyMenu.DataObj.CurrentTab == TAB_NOTES_INDEX)
                && this.invPage.CanLowerPipboy();
        this.filterButton.ButtonVisible = btnVisible;
        if (!btnVisible) {
            return;
        }
        var _loc1_:String = ListFiltererEx.GetFilterText(this.filterer.extraFilterType);
        if (_loc1_ == "") {
            this.filterButton.ButtonText = "$FILTER";
            this.selectedTabLabelOverride = this.invPage.TabNames[this.pipboyMenu.DataObj.CurrentTab];
        } else {
            this.filterButton.ButtonText = "$$FILTER" + " (" + _loc1_ + ")";
            this.selectedTabLabelOverride = "$"
                    + this.invPage.TabNames[this.pipboyMenu.DataObj.CurrentTab] + " (" + _loc1_
                    + ")";
        }
        this.SetIsDirty();
    }

    private function setSelectedTabLabel(param1:String):void {
        // method body index: 227 method index: 227
        var _loc2_:Number = 12.5;
        this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.Selected.textField_tf.text = param1;
        this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.LeftOne.x = this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.Selected.x
                - this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.Selected.width / 2
                - this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.LeftOne.width / 2 - _loc2_;
        this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.LeftTwo.x = this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.LeftOne.x
                - this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.LeftOne.width / 2
                - this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.LeftTwo.width / 2 - _loc2_;
        this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.RightOne.x = this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.Selected.x
                + this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.Selected.width / 2
                + this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.RightOne.width / 2 + _loc2_;
        this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.RightTwo.x = this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.RightOne.x
                + this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.RightOne.width / 2
                + this.pipboyMenu.Header_mc.TabHeader_mc.AlphaHolder.RightTwo.width / 2 + _loc2_;
    }

    private function populateItemInfoMap(param1:Array, param2:int):void {
        // method body index: 228 method index: 228
        var _loc5_:Object = null;
        var _loc6_:Array = null;
        var _loc7_:Array = null;
        var _loc3_:uint = 0;
        this.log("Populate itemInfoMap started");
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc5_ = param1[_loc4_];
            if (_loc5_.filterFlag & param2) {
                if (this.itemInfoMap[_loc5_.serverHandleID] == null) {
                    _loc6_ = [];
                    _loc7_ = new Array();
                    this.invPage.codeObj.onInvItemSelection(_loc4_, _loc6_, _loc7_, this.pipboyMenu,
                            _loc5_.serverHandleID);
                    this.itemInfoMap[_loc5_.serverHandleID] = _loc6_;
                    this.paperDollMap[_loc5_.serverHandleID] = _loc7_;
                    _loc3_++;
                }
            }
            _loc4_++;
        }
        this.log("Populate itemInfoMap finished, entries added:", _loc3_);
    }

    private function onTabClicked(param1:MouseEvent):void {
        // method body index: 229 method index: 229
        if (this.shiftKeyDown) {
            this.onFilterPreviousPress();
        } else {
            this.onFilterButtonPress();
        }
    }

    private function onTabMouseWheel(param1:MouseEvent):void {
        // method body index: 230 method index: 230
        if (param1.delta < 0) {
            this.onFilterButtonPress();
        } else {
            this.onFilterPreviousPress();
        }
    }

    private function onCopyData(event:MouseEvent):void {
        this.log3("Before fuck");

        try {
            this.log3("Begin fuck");

            this.log3("Query success");
        } catch (e) {
            this.log3("Error inserting");
            this.logError(e);
        }
        this.log3("After fuck");
    }

    private function onFilterButtonPress():void {
        // method body index: 231 method index: 231
        if (!this.filterButton.ButtonVisible || !this.filterButton.ButtonEnabled) {
            return;
        }
        this.log("onFilterButtonPress");
        this.advanceFilterMode(1);
    }

    private function onFilterPreviousPress():void {
        // method body index: 232 method index: 232
        if (!this.filterButton.ButtonVisible || !this.filterButton.ButtonEnabled) {
            return;
        }
        this.log("onFilterPreviousPress");
        this.advanceFilterMode(-1);
    }

    private function advanceFilterMode(param1:int = 1):void {
        // method body index: 233 method index: 233
        this.log("Advancing filter mode by", param1);
        var _loc2_:int = this.filterer.extraFilterType;
        _loc2_ = _loc2_ + param1;
        var _loc3_:Array = ListFiltererEx.GetFilterIndexBoundaries(
                this.pipboyMenu.DataObj.CurrentTab);
        if (_loc2_ < -1) {
            _loc2_ = _loc3_[1];
        } else if (_loc2_ < _loc3_[0]) {
            _loc2_ = param1 > 0 ? int(_loc3_[0]) : -1;
        } else if (_loc2_ > _loc3_[1]) {
            _loc2_ = -1;
        }
        this.applyFilter(_loc2_);
    }

    private function onSetFilterMode(param1:int):void {
        // method body index: 234 method index: 234
        if (!this.filterButton.ButtonVisible || !this.filterButton.ButtonEnabled) {
            return;
        }
        this.log("onSetFilterMode", param1);
        if (param1 == 0) {
            this.applyFilter(-1);
            return;
        }
        var _loc2_:Array = ListFiltererEx.GetFilterIndexBoundaries(
                this.pipboyMenu.DataObj.CurrentTab);
        var _loc3_:* = _loc2_[0] + (param1 - 1);
        if (_loc3_ < _loc2_[0] || _loc3_ > _loc2_[1]) {
            return;
        }
        this.applyFilter(_loc3_);
    }

    private function calcTabWeight():void {
        // method body index: 235 method index: 235
        var tabWeight:Number = NaN;
        var bailoutCounter:int = 0;
        var filterer:ListFilterer = null;
        var idx:int = 0;
        var entry:Object = null;
        var infoArr:Array = null;
        var infoObj:* = undefined;
        var weight:Number = NaN;
        try {
            tabWeight = 0;
            bailoutCounter = 5000;
            filterer = this.invPage.List_mc.filterer;
            idx = filterer.GetNextFilterMatch(-1);
            while (idx != int.MAX_VALUE && bailoutCounter--) {
                entry = this.invPage.List_mc.entryList[idx];
//                this.log3(entry);
                infoArr = this.itemInfoMap[entry.serverHandleID];
//                this.log3(infoArr);
                break;
                if (infoArr == null) {
                    this.log("WARN: calcTabWeight() - no info object for", entry.text,
                            "serverHandleID", entry.serverHandleID);
                }
                for each(infoObj in infoArr) {
                    if (infoObj.text == "$wt") {
                        weight = Number(infoObj.value);
                        tabWeight = tabWeight + weight * entry.count;
                        break;
                    }
                }
                idx = filterer.GetNextFilterMatch(idx);
            }
            if (bailoutCounter <= 0) {
                this.log("WARNING: We bailed out of calculating tab weight.");
            }
            this.currentTabWeight = int(tabWeight) == tabWeight ? tabWeight.toFixed(0)
                    : tabWeight.toFixed(1);
            return;
        } catch (e:Error) {
            log("Calculating tab weight FAILED");
            log(e.errorID + " " + e.name + " " + e.message);
            return;
        }
    }

    private function initButtonHints():void {
        // method body index: 236 method index: 236
        var _loc1_:int = 0;
        this.invPage.buttonHintDataV.splice(0, 0, this.filterButton);
        if (this.pipboyMenu.uiPlatform != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE) {
            _loc1_ = this.invPage.buttonHintDataV.length - 1;
            while (_loc1_ >= 0) {
                if (this.invPage.buttonHintDataV[_loc1_].XenonButton == "Xenon_L1") {
                    this.invPage.buttonHintDataV.splice(_loc1_, 1);
                    break;
                }
                _loc1_--;
            }
        }
        this.pipboyMenu.ButtonHintBar_mc.SetButtonHintData(this.invPage.buttonHintDataV);
    }

    private function redraw():void {
        // method body index: 237 method index: 237
        var selectedEntry:Object = null;
        var i:int = 0;
        var itemCard:MovieClip = null;
        var actualLabelWidth:Number = NaN;
        var labelWidthDiff:Number = NaN;
        var weightSingle:Number = NaN;
        var weightSingleDecimalPlaces:int = 0;
        var totalWeight:Number = NaN;
        if (!this._buttonHintsInitialized) {
            this._buttonHintsInitialized = true;
            this.initButtonHints();
        }
        var weightStr:String = Math.floor(this.pipboyMenu.DataObj.CurrWeight) + "/" + Math.floor(
                this.pipboyMenu.DataObj.MaxWeight) + " [" + this.currentTabWeight + "]";
        this.pipboyMenu.BottomBar_mc.Info_mc.Weight_tf.text = weightStr;
        if (this.selectedTabLabelOverride != "") {
            this.setSelectedTabLabel(this.selectedTabLabelOverride);
            this.selectedTabLabelOverride = "";
        }
        if (this._stackWeightInvalidated) {
            this._stackWeightInvalidated = false;
            try {
                selectedEntry = this.invPage.List_mc.selectedEntry;
                if (selectedEntry && selectedEntry.count > 1) {
                    i = 0;
                    while (i < this.invPage.ItemCard_mc.numChildren) {
                        itemCard = this.invPage.ItemCard_mc.getChildAt(i) as MovieClip;
                        if (getQualifiedClassName(itemCard) == "ItemCard_StandardEntry") {
                            if (itemCard.Label_tf.text == this._weightStr) {
                                actualLabelWidth = itemCard.Label_tf.getLineMetrics(0).width + 5;
                                labelWidthDiff = itemCard.Label_tf.width - actualLabelWidth;
                                if (labelWidthDiff > 0) {
                                    itemCard.Label_tf.width = actualLabelWidth;
                                    itemCard.Value_tf.x = itemCard.Value_tf.x - labelWidthDiff;
                                    itemCard.Value_tf.width = itemCard.Value_tf.width
                                            + labelWidthDiff;
                                }
                                weightSingle = Number(itemCard.Value_tf.text);
                                weightSingleDecimalPlaces = itemCard.Value_tf.text.indexOf(".") > -1
                                        ? int(itemCard.Value_tf.text.length - 1
                                                - itemCard.Value_tf.text.indexOf(".")) : 0;
                                totalWeight = weightSingle * selectedEntry.count;
                                itemCard.Value_tf.text = weightSingle + " [" + totalWeight.toFixed(
                                        weightSingleDecimalPlaces) + "]";
//                                this.log3(selectedEntry);
                                break;
                            }
                        }
                        i++;
                    }
                }
                return;
            } catch (e:Error) {
                log("Calculating stack weight FAILED");
                log(e.errorID + " " + e.name + " " + e.message);
                return;
            }
        }
    }

    private function get invPage():MovieClip {
        // method body index: 238 method index: 238
        return this.pipboyMenu.GetPage(INV_PAGE_INDEX);
    }

    private function SetIsDirty():void {
        // method body index: 239 method index: 239
        this._bIsDirty = true;
        if (stage) {
            stage.addEventListener(Event.RENDER, this.onRenderEvent, false, int.MIN_VALUE);
            stage.invalidate();
        }
    }

    private function RoundDecimal(param1:Number, param2:uint):String {
        // method body index: 240 method index: 240
        var _loc5_:int = 0;
        var _loc3_:String = param1.toFixed(param2);
        var _loc4_:int = _loc3_.indexOf(".");
        if (_loc4_ > -1) {
            _loc5_ = _loc3_.length - 1;
            while (_loc5_ >= _loc4_) {
                if (_loc3_.charAt(_loc5_) != "0") {
                    return _loc3_.substring(0,
                            _loc5_ == _loc4_ ? Number(_loc5_) : Number(_loc5_ + 1));
                }
                _loc5_--;
            }
        }
        return _loc3_;
    }

    private function log3(rest:Object):void {
        // method body index: 241 method index: 241
        if (!DEBUG_MODE) {
            return;
        }
        this.debug_tf.appendText(rest.toString());
        this.debug_tf.appendText("\r\n");
        try {
            var json:String = com.adobe.serialization.json.JSON.encode(rest);
            this.debug_tf.appendText(json);
            this.debug_tf.appendText("\r\n");
        } catch (e:Error) {
            this.logError(e);
        }
    }

    private function logError(e:Error):void {
        this.debug_tf.appendText(e.toString());
        this.debug_tf.appendText("catch: " + e.toString() + "\r\n");
        this.debug_tf.appendText("catch: " + e.getStackTrace() + "\r\n");
        this.debug_tf.appendText(e.errorID + " " + e.name + " " + e.message);
    }

    private function log(...rest):void {
    }
}
}
