package {
import Shared.AS3.BSButtonHintBar;
import Shared.AS3.BSButtonHintData;

import flash.display.MovieClip;
import flash.events.KeyboardEvent;
import flash.text.TextField;

import scaleform.gfx.Extensions;

import utils.Logger;

public class ItemExtractorMod extends MovieClip {

    public static const MODE_CONTAINER:uint = 0;

//    public static const MODE_PLAYERVENDING:uint = 1;
//
//    public static const MODE_NPCVENDING:uint = 2;
//
//    public static const MODE_VENDING_MACHINE:int = 3;
//
//    public static const MODE_DISPLAY_CASE:int = 4;
//
//    public static const MODE_CAMP_DISPENSER:int = 5;
//
//    public static const MODE_FERMENTER:int = 6;
//
//    public static const MODE_REFRIGERATOR:int = 7;
//
//    public static const MODE_ALLY:int = 8;

    public static const MODE_INVALID:uint = uint.MAX_VALUE;

    public var debugLogger:TextField;
    private var _itemExtractor:ItemExtractor;
    private var _parent:MovieClip;
    public var extractButton:BSButtonHintData;
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
            Extensions.enabled = true;
        } catch (e:Error) {
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
            Logger.get().error("Error getting button hints from parent " + e);
        }
        buttons.push(this.extractButton);
        try {
            buttonHintBar.SetButtonHintData(buttons);
            buttonHintBar.onRemovedFromStage();
            buttonHintBar.onAddedToStage();
            buttonHintBar.redrawDisplayObject();
        } catch (e:Error) {
            Logger.get().error("Error setting new button hints data" + e);
        }
    }

    private function extractItems():void {
        try {
            var playerInventory:Object = this.parentClip.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData;
            var stashInventory:Object = this.parentClip.OfferInventory_mc.ItemList_mc.List_mc.MenuListData;
            this._itemExtractor.extractItems(playerInventory, stashInventory);
        } catch (e:Error) {
            ItemExtractor.ShowHUDMessage("Error extracting items: " + e);
        }
    }

    private function isValidMode() : Boolean {
        try {
            return this.parentClip.m_MenuMode === MODE_CONTAINER;
        } catch (e: Error) {
            Logger.get().error("Error while getting mode" + e);
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
            this._itemExtractor.init();
            this.extractItems();
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
        }
    }
}
}
