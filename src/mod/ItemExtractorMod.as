package {
import Shared.AS3.BSButtonHintBar;
import Shared.AS3.BSButtonHintData;

import flash.display.MovieClip;
import flash.events.KeyboardEvent;
import flash.text.TextField;

import scaleform.gfx.Extensions;

import utils.Logger;

public class ItemExtractorMod extends MovieClip {

    public static const IS_FED_ENABLED:Boolean = true;

    public static const MODE_CONTAINER:uint = 0;

    public static const MODE_PLAYERVENDING:uint = 1;

    public static const MODE_NPCVENDING:uint = 2;

    public static const MODE_VENDING_MACHINE:int = 3;

    public static const MODE_DISPLAY_CASE:int = 4;

    public static const MODE_CAMP_DISPENSER:int = 5;

    public static const MODE_FERMENTER:int = 6;

    public static const MODE_REFRIGERATOR:int = 7;

    public static const MODE_ALLY:int = 8;

    public static const MODE_INVALID:uint = uint.MAX_VALUE;

    public var debugLogger:TextField;
    private var _itemExtractor:ItemExtractor;
    private var _parent:MovieClip;
    public var extractButton:BSButtonHintData;
    public var fed76extractButton:BSButtonHintData;
    public var buttonHintBar:BSButtonHintBar = null;

    public function ItemExtractorMod() {
        super();
        try {
            this._itemExtractor = new ItemExtractor();
            Logger.DEBUG_MODE = false;
            Logger.init(this.debugLogger);
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

            Extensions.enabled = true;
        } catch (e:Error) {
            Logger.get().error(e);
            ItemExtractor.ShowHUDMessage("Error loading mod " + e);
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
            ItemExtractor.ShowHUDMessage("Unexpected error while adding extract button!");
            Logger.get().error("Error getting button hint bar from parent.");
            return;
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
        } catch (e:Error) {
            ItemExtractor.ShowHUDMessage("Error extracting items(inv objects): " + e);
        }
    }

    private function isFed76ValidMode():Boolean {
        try {
            return this.parentClip.m_MenuMode === MODE_PLAYERVENDING || this.parentClip.m_MenuMode
                    === MODE_NPCVENDING || this.parentClip.m_MenuMode === MODE_VENDING_MACHINE;
        } catch (e:Error) {
            Logger.get().error("Error while getting mode: " + e);
        }
        return false;
    }

    private function isValidMode():Boolean {
        try {
            return this.parentClip.m_MenuMode === MODE_CONTAINER;
        } catch (e:Error) {
            Logger.get().error("Error while getting mode: " + e);
        }
        return false;
    }

    public function extractDataCallback():void {
        try {
            if (!this.isValidMode()) {
                ItemExtractor.ShowHUDMessage(
                        "Please, use this function only in your stash box.");
                return;
            }
            this.setInventoryObjects();
            this._itemExtractor.extractItems();
        } catch (e:Error) {
            ItemExtractor.ShowHUDMessage("Error extracting items(init): " + e);
        }
    }

    public function fed76ExtractDataCallback():void {
        try {
            if (!this.isFed76ValidMode()) {
                ItemExtractor.ShowHUDMessage(
                        "Please, use this function only in player's vendor!");
                return;
            }
            this.setInventoryObjects();
            this._itemExtractor.extractFed76Items();
        } catch (e:Error) {
            ItemExtractor.ShowHUDMessage("Error extracting items(init): " + e);
        }
    }

    public function setParent(parent:MovieClip):void {
        this._parent = parent;
        this._itemExtractor.sfeObj = parent.__SFCodeObj;
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
}
}
