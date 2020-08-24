package {
import Shared.AS3.BSButtonHintData;

import fl.controls.Button;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

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
    public var btn:Button;
    private var _itemExtractor:ItemExtractor;
    private var _parent:MovieClip;
    public var extractButton:BSButtonHintData;

    public function ItemExtractorMod() {
        super();
        try {
            this._itemExtractor = new ItemExtractor();
            Logger.DEBUG_MODE = false;
            this.btn.addEventListener(MouseEvent.CLICK, extractDataCallback);
            Logger.init(this.debugLogger);
            this.addEventListener(Event.ADDED, init)
        } catch (e:Error) {
            ItemExtractor.ShowHUDMessage("Error loading mod " + e);
        }
    }

    private function init(e:Event):void {
        this.btn.label = "Extract";
        this.extractButton = new BSButtonHintData("Extract", "O", "PSN_Y", "Xenon_Y", 1,
                this.extractItems);
        this.extractButton.visible = true;
        this.extractButton.ButtonVisible = true;
        initButtonHints();
    }

    private function initButtonHints():void {
        this.parentClip.ButtonHintDataV.splice(0, 0, this.extractButton);
        this.parentClip.ButtonHintBar_mc.SetButtonHintData(this.parentClip.buttonHintDataV);
    }

    private function extractItems():void {
        try {
//            GlobalFunc.ShowHUDMessage("Extracting items... ");
            var playerInventory:Object = this.parentClip.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData;
            var stashInventory:Object = this.parentClip.OfferInventory_mc.ItemList_mc.List_mc.MenuListData;
            this._itemExtractor.extractItems(playerInventory, stashInventory);
//            GlobalFunc.ShowHUDMessage("Finished extracting items... ");
        } catch (e:Error) {
            ItemExtractor.ShowHUDMessage("Error loading mod. " + e);
        }
    }

    private function extractDataCallback(e:MouseEvent):void {
        try {
//            if (e.keyCode == 112) {
            if (this.parentClip.m_MenuMode != MODE_CONTAINER) {
                ItemExtractor.ShowHUDMessage(
                        "Please, use this function only in your stash box.");
                return;
            }
            this.extractItems();
//            }
        } catch (e:Error) {
            ItemExtractor.ShowHUDMessage("Error loading mod. " + e);
        }
    }

    public function setParent(parent:MovieClip):void {
        this._parent = parent;
        this._itemExtractor.sfeObj = parent.__SFCodeObj;
    }

    public function get parentClip():MovieClip {
        return _parent;
    }
}
}
