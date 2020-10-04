package {
import Shared.AS3.BSButtonHintBar;
import Shared.AS3.BSButtonHintData;
import Shared.GlobalFunc;

import extractors.BaseItemExtractor;
import extractors.Fed76ItemExtractor;
import extractors.ItemExtractor;
import extractors.VendorPriceCheckExtractor;

import flash.display.MovieClip;
import flash.events.KeyboardEvent;
import flash.text.TextField;

import scaleform.gfx.Extensions;

import utils.Logger;

public class ItemExtractorMod extends MovieClip {

    public static const VERSION:Number = 0.6;
    public static const IS_FED_ENABLED:Boolean = false;

    public var debugLogger:TextField;
    private var _itemExtractor:BaseItemExtractor;
    private var _fedItemExtractor:BaseItemExtractor;
    private var _priceCheckItemExtractor:BaseItemExtractor;
    private var _parent:MovieClip;
    public var extractButton:BSButtonHintData;
    public var fed76extractButton:BSButtonHintData;
    public var buttonHintBar:BSButtonHintBar;

    public function ItemExtractorMod() {
        super();
        try {
            Logger.DEBUG_MODE = false;
            Logger.init(this.debugLogger);
            Extensions.enabled = true;
        } catch (e:Error) {
            Logger.get().error(e);
            ShowHUDMessage("Error loading mod " + e);
        }
    }

    private function init():void {
        try {
            this.initButtonHints();
            stage.getChildAt(0)["ItemExtractorMod"] = this;
            stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
        } catch (e:Error) {
            Logger.get().errorHandler("Error init buttons", e);
        }
    }

    private function initButtonHints():void {
        if (buttonHintBar == null) {
            ShowHUDMessage("Unexpected error while adding extract button!");
            Logger.get().error("Error getting button hint bar from parent.");
            return;
        }
        this.extractButton = new BSButtonHintData("Extract items", "O", "PSN_Start",
                "Xenon_Start", 1,
                this.extractDataCallback);
        this.extractButton.ButtonVisible = true;
        this.extractButton.ButtonDisabled = false;
        this.extractButton.secondaryButtonCallback = this.extractDataCallback;

        if (IS_FED_ENABLED) {
            this.fed76extractButton = new BSButtonHintData("Fed76Extract", "F", "PSN_Select",
                    "Xenon_Select", 1,
                    this.fed76ExtractDataCallback);
            this.fed76extractButton.ButtonVisible = true;
            this.fed76extractButton.ButtonDisabled = false;
            this.fed76extractButton.secondaryButtonCallback = this.fed76ExtractDataCallback;
        }
        var buttons:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
        try {
            buttons = this.parentClip.ButtonHintDataV;
        } catch (e:Error) {
            Logger.get().error("Error getting button hints from parent: " + e);
        }
        buttons.push(this.extractButton);
        if (IS_FED_ENABLED) {
            buttons.push(this.fed76extractButton);
        }
        try {
            buttonHintBar.SetButtonHintData(buttons);
            buttonHintBar.onRemovedFromStage();
            buttonHintBar.onAddedToStage();
            buttonHintBar.redrawDisplayObject();
        } catch (e:Error) {
            Logger.get().error("Error setting new button hints data: " + e);
        }
    }

    private function setInventoryObjects():void {
        try {
            var playerInventory:Object = this.parentClip.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData;
            var stashInventory:Object = this.parentClip.OfferInventory_mc.ItemList_mc.List_mc.MenuListData;
            this._itemExtractor.setInventory(playerInventory, stashInventory);
            this._priceCheckItemExtractor.setInventory(playerInventory, stashInventory);
            this._fedItemExtractor.setInventory(playerInventory, stashInventory);
        } catch (e:Error) {
            ShowHUDMessage("Error extracting items(inv objects): " + e);
        }
    }

    public function extractDataCallback():void {
        try {
            var extractorToUse:BaseItemExtractor = this._priceCheckItemExtractor;
            if (!extractorToUse.isValidMode(this.parentClip.m_MenuMode)) {
                extractorToUse = this._itemExtractor;
            }
            if (!extractorToUse.isValidMode(this.parentClip.m_MenuMode)) {
                extractorToUse.showInvalidModeMessage();
                return;
            }
            this.setInventoryObjects();
            extractorToUse.extractItems();
        } catch (e:Error) {
            ShowHUDMessage("Error extracting items(init): " + e);
        }
    }

    public function fed76ExtractDataCallback():void {
        try {
            var extractorToUse:BaseItemExtractor = this._fedItemExtractor;
            if (!extractorToUse.isValidMode(this.parentClip.m_MenuMode)) {
                extractorToUse.showInvalidModeMessage();
                return;
            }
            this.setInventoryObjects();
            extractorToUse.extractItems();
        } catch (e:Error) {
            ShowHUDMessage("Error extracting items(init): " + e);
        }
    }

    public function setParent(parent:MovieClip):void {
        this._parent = parent;
        this._itemExtractor = new ItemExtractor(parent.__SFCodeObj);
        this._fedItemExtractor = new Fed76ItemExtractor(parent.__SFCodeObj);
        this._priceCheckItemExtractor = new VendorPriceCheckExtractor(parent.__SFCodeObj);
        this.buttonHintBar = parent.ButtonHintBar_mc;
        init();
    }

    public function get parentClip():MovieClip {
        return _parent;
    }

    private function keyUpHandler(e:KeyboardEvent):void {
        if (e.keyCode == 79) {
            extractDataCallback();
            return;
        }
        if (IS_FED_ENABLED && e.keyCode == 70) {
            fed76ExtractDataCallback();
        }
    }

    public static function ShowHUDMessage(text:String):void {
        GlobalFunc.ShowHUDMessage("[ItemExtractorLoader v" + VERSION + "] " + text);
    }
}
}
