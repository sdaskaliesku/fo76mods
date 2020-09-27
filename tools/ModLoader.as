package {
import Shared.GlobalFunc;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.text.TextField;

public class ModLoader {
    private var _modLoader:Loader;
    private var _movieClip:MovieClip;
    private var _parent:Sprite;
    private var _swfFile:String;
    private var _notifyUser:Boolean = false;
    private var _onCompleteCallBack:Function = null;

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

    public function load():void {
        try {
            trace("Starting loading " + swfFile + " mod");
            if (notifyUser) {
                GlobalFunc.ShowHUDMessage("Starting loading " + swfFile + " mod");
            }
            this._modLoader = new Loader();
            parent.addChild(this._modLoader);
            _modLoader.load(new URLRequest(swfFile));
            if (onCompleteCallBack != null) {
                this._modLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,
                        onCompleteCallBack);
            }
            trace(swfFile + " loaded");
            if (notifyUser) {
                GlobalFunc.ShowHUDMessage(swfFile + " loaded");
            }
        } catch (e) {
            GlobalFunc.ShowHUDMessage("Error loading: " + swfFile);
            GlobalFunc.ShowHUDMessage(e.toString());
        }
    }

//    public function initSFE(sfeObj:Object):void {
//        var movieClip:MovieClip = this.modLoader.content as MovieClip;
//        movieClip.__SFCodeObj = sfeObj;
//    }

    public function getTextField(): TextField {
        var movieClip:MovieClip = this.modLoader.content as MovieClip;
        return movieClip.debugLogger as TextField;
    }

    public function get modLoader():Loader {
        return _modLoader;
    }

    public function get movieClip():MovieClip {
        return _movieClip;
    }

    public static function loadMod(sprite:Sprite, onCompleteCallBack:Function = null): ModLoader {
        try {
            GlobalFunc.ShowHUDMessage("Trying to load custom mod");
            var modLoader:ModLoader = new ModLoader(sprite, "MansonMod.swf");
            modLoader.notifyUser = true;
            if (onCompleteCallBack != null) {
                modLoader.onCompleteCallBack = onCompleteCallBack;
            } else {
                modLoader.onCompleteCallBack = function (e:Event):void {
                    GlobalFunc.ShowHUDMessage("Manson mod loaded");
                };
            }
            modLoader.load();
            return modLoader;
        } catch (e:Error) {
            trace(e);
            GlobalFunc.ShowHUDMessage("Manson mod load error" + e.toString());
        }
        return null;
    }
}
}