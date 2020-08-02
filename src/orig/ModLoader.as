package {
import Shared.GlobalFunc;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

public class ModLoader {
    private var _modLoader:Loader;
    private var _movieClip:MovieClip;
    private var _parent:Sprite;
    private var _swfFile:String;
    private var _notifyUser:Boolean = false;
    private var _onCompleteCallBack:Function = Function.createEmptyFunction();

    public function ModLoader(parent:Sprite, swfFile:String) {
        this.swfFile = swfFile;
        this.parent = parent;
    }

    public function get onCompleteCallBack():Function {
        return _onCompleteCallBack;
    }

    public function set onCompleteCallBack(value:Function):void {
        _onCompleteCallBack = value;
    }

    public function get notifyUser():Boolean {
        return _notifyUser;
    }

    public function set notifyUser(value:Boolean):void {
        _notifyUser = value;
    }

    public function get parent():Sprite {
        return _parent;
    }

    public function set parent(value:Sprite):void {
        _parent = value;
    }

    public function get swfFile():String {
        return _swfFile;
    }

    public function set swfFile(value:String):void {
        _swfFile = value;
    }

    public function load():MovieClip {
        try {
            trace("Starting loading " + swfFile + " mod");
            if (notifyUser) {
                GlobalFunc.ShowHUDMessage("Starting loading " + swfFile + " mod");
            }
            this._modLoader = new Loader();
            parent.addChild(this._modLoader);
            this._modLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,
                    function (e:Event):void {
                        defaultOnCompleteCallBack();
                        if (onCompleteCallBack != null) {
                            onCompleteCallBack(e);
                        }
                    });
            trace(swfFile + " loaded");
            if (notifyUser) {
                GlobalFunc.ShowHUDMessage(swfFile + " loaded");
            }
        } catch (e) {
            GlobalFunc.ShowHUDMessage("Error loading: " + swfFile);
            GlobalFunc.ShowHUDMessage(e.toString());
        }
        return this.modLoader.content as MovieClip;
    }

    private function defaultOnCompleteCallBack():void {
        this._movieClip = this.modLoader.contentLoaderInfo as MovieClip;
    }

    public function initSFE(sfeObj:Object):void {
        var movieClip:MovieClip = this.modLoader.content as MovieClip;
        movieClip.__SFCodeObj = sfeObj;
    }

    public function get modLoader():Loader {
        return _modLoader;
    }

    public function get movieClip():MovieClip {
        return _movieClip;
    }
}
}