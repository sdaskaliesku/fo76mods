package {

import Shared.AS3.Data.BSUIDataManager;
import Shared.AS3.Data.FromClientDataEvent;
import Shared.AS3.Data.UIDataFromClient;
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONEncoder;

import flash.display.MovieClip;
import flash.events.KeyboardEvent;
import flash.text.TextField;

import scaleform.gfx.Extensions;

import utils.Logger;

public class LoggerMod extends MovieClip {

    public static const VERSION:Number = 0.1;
    public static const MOD_NAME:String = "LoggerMod";
    public static const EVENT_CAMP_BUY_ITEM:String = "CampVend::BuyItem";
    public static const EVENT_CAMP_SELL_ITEM:String = "CampVend::SellItem";

    public var debugLogger:TextField;
    private var _parent:MovieClip;
    private var __SFCodeObj:Object;
    private var m_PurchaseCompleteData:UIDataFromClient;

    public function LoggerMod() {
        super();
        try {
            Logger.DEBUG_MODE = true;
            Logger.init(this.debugLogger);
            Extensions.enabled = true;
            BSUIDataManager.Subscribe("PurchaseCompleteData",this.onPurchaseCompleteDataUpdate);
            this.m_PurchaseCompleteData = BSUIDataManager.GetDataFromClient("PurchaseCompleteData");
            init();
            stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
        } catch (e:Error) {
            Logger.get().error(e);
            ShowHUDMessage("Error loading mod " + e);
        }
    }

    private function keyUpHandler(e:KeyboardEvent):void {
        if (e.keyCode == 79) {
            init();
        }
    }

    function logEventData(etype:String, event:Object):void {
        Logger.get().info("Type: " + etype);
        Logger.get().info(LoggerMod.toString(event));
    }

    private function init():void {
        try {
//            stage.getChildAt(0)[MOD_NAME] = this;
            var events:Array = [EVENT_CAMP_BUY_ITEM, EVENT_CAMP_SELL_ITEM, "PurchaseCompleteData"];
            for each (var eventType:String in events) {
                const etype:String = eventType
                BSUIDataManager.addEventListener(etype, function (event:FromClientDataEvent):void {
                    logEventData(etype + "1", event.data);
                });
                BSUIDataManager.Subscribe(etype, function (event:FromClientDataEvent):void {
                    logEventData(etype, event.data);
                });
                var data:Object = BSUIDataManager.GetDataFromClient(etype).data;
                logEventData(etype,  data);
            }

        } catch (e:Error) {
            Logger.get().errorHandler("Error init", e);
        }
    }

    private static function toString(obj:Object):String {
        try {
            return new JSONEncoder(obj).getString();
        } catch (e:Error) {
            Logger.get().errorHandler("Error toString", e);
        }
        return "ERROR";
    }

    public function setParent(parent:MovieClip):void {
        this._parent = parent;
        this.__SFCodeObj = parent.__SFCodeObj;
    }

    public function get parentClip():MovieClip {
        return _parent;
    }

    public static function ShowHUDMessage(text:String):void {
        GlobalFunc.ShowHUDMessage("[" + MOD_NAME + " v" + VERSION + "] " + text);
    }

    private function onPurchaseCompleteDataUpdate(param1:Object):void {
        logEventData("PurchaseCompleteData3",  this.m_PurchaseCompleteData.data);
        logEventData("PurchaseCompleteData4",  param1);
    }
}
}
