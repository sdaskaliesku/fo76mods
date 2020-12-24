package {
import Shared.AS3.BSButtonHintBar;
import Shared.AS3.BSButtonHintData;
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONDecoder;

import extractors.BaseItemExtractor;
import extractors.ItemExtractor;
import extractors.VendorPriceCheckExtractor;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.text.TextField;

import utils.Logger;

public class ItemExtractorMod extends MovieClip {

    public var debugLogger:TextField;
    private var _itemExtractor:ItemExtractor;
    private var _priceCheckItemExtractor:VendorPriceCheckExtractor;
    private var _parent:MovieClip;
    public var extractButton:BSButtonHintData;
    public var buttonHintBar:BSButtonHintBar;
    protected var extractorToUse: BaseItemExtractor;

    public function ItemExtractorMod() {
        super();
        try {
            Logger.DEBUG_MODE = false;
            Logger.init(this.debugLogger);
        } catch (e:Error) {
            Logger.get().error(e);
            ShowHUDMessage("Error loading mod " + e);
        }
    }

    private function init():void {
        try {
            this.initButtonHints();
            stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
            var extractorToUse:BaseItemExtractor = this._priceCheckItemExtractor;
            if (!extractorToUse.isValidMode(this.parentClip.m_MenuMode)) {
                extractorToUse = this._itemExtractor;
            }
            ShowHUDMessage("Loaded extractor: " + extractorToUse.getExtractorName())
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

        // noinspection JSValidateTypes
        var buttons:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
        try {
            buttons = this.parentClip.ButtonHintDataV;
        } catch (e:Error) {
            Logger.get().error("Error getting button hints from parent: " + e);
        }
        buttons.push(this.extractButton);

        try {
            buttonHintBar.SetButtonHintData(buttons);
            buttonHintBar.onRemovedFromStage();
            buttonHintBar.onAddedToStage();
            buttonHintBar.redrawDisplayObject();
        } catch (e:Error) {
            Logger.get().error("Error setting new button hints data: " + e);
        }
    }

    public function extractDataCallback():void {
        try {
            var extractorToUse:BaseItemExtractor = this._priceCheckItemExtractor;
            if (!extractorToUse.isValidMode(this.parentClip.m_MenuMode)) {
                extractorToUse = this._itemExtractor;
            }
            extractorToUse.setInventory(this.parentClip);
        } catch (e:Error) {
            ShowHUDMessage("Error extracting items(init): " + e);
        }
    }

    //noinspection JSUnusedGlobalSymbols
    public function setParent(parent:MovieClip):void {
        this._parent = parent;
        this._itemExtractor = new ItemExtractor(_parent.__SFCodeObj);
        this._priceCheckItemExtractor = new VendorPriceCheckExtractor(_parent.__SFCodeObj);
        this.buttonHintBar = _parent.ButtonHintBar_mc;
        loadConfig();
        init();
    }

    private function loadConfig():void {
        try {
            var url:URLRequest = new URLRequest("../itemExtractorModConfig.json");
            var loader:URLLoader = new URLLoader();
            loader.load(url);
            loader.addEventListener(Event.COMPLETE, loaderComplete);

            function loaderComplete(e:Event):void {
                var jsonData:Object = new JSONDecoder(loader.data, true).getValue()
                _itemExtractor.verboseOutput = jsonData.verboseOutput;
                _itemExtractor.apiMethods = jsonData.apiMethods;
                _itemExtractor.additionalItemDataForAll = jsonData.additionalItemDataForAll;
                Logger.get().debugMode = jsonData.debug;
                ShowHUDMessage("Config file is loaded!");
            }
        } catch (e:Error) {
            ShowHUDMessage(e.getStackTrace());
        }
    }

    public function get parentClip():MovieClip {
        return _parent;
    }

    private function keyUpHandler(e:KeyboardEvent):void {
        if (e.keyCode == 79) {
            extractDataCallback();
        }
    }

    public static function ShowHUDMessage(text:String):void {
        GlobalFunc.ShowHUDMessage("[ItemExtractorLoader v" + Version.LOADER + "] " + text);
    }
}
}
