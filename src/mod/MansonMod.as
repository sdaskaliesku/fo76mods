package {
import Shared.GlobalFunc;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import utils.Logger;

public class MansonMod extends MovieClip {

    public var debugLogger:TextField;
    public var __SFCodeObj:Object;

    public function MansonMod() {
        super();
        Logger.init(this.debugLogger);
        Logger.get().info("load 100500");
//        this.__SFCodeObj = new Object();
//        this.debugLogger.addEventListener(MouseEvent.CLICK, onMouseClick);
        Logger.get().info("Loaded");
    }

    private static function randomRange(minNum:Number, maxNum:Number):Number {
        return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
    }

    private function onMouseClick(e:Event):void {
        try {
            var sfe:Boolean = this.__SFCodeObj != null && this.__SFCodeObj.call != null;
            GlobalFunc.ShowHUDMessage("mytestmessage: " + sfe);
        } catch (e:Error) {
            Logger.get().errorHandler("onMouseClick", e);
        }
    }
}
}
