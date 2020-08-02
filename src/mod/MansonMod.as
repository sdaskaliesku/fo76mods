package {
import Shared.GlobalFunc;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import utils.Logger;

public class MansonMod extends MovieClip {

    public var debugLogger:TextField;

    public function MansonMod() {
        super();
        Logger.init(this.debugLogger);
        Logger.get().info("load 100500");
        this.debugLogger.addEventListener(MouseEvent.CLICK, onMouseClick);
        Logger.get().info("Loaded");
    }

    private static function randomRange(minNum:Number, maxNum:Number):Number {
        return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
    }

    private function onMouseClick(e:Event):void {
        try {
            GlobalFunc.ShowHUDMessage("mytestmessage");
        } catch (e:Error) {
            Logger.get().errorHandler("onMouseClick", e);
        }
    }
}
}
