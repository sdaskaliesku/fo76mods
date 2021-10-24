package {
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONDecoder;

import flash.display.Loader;

import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ModManager extends MovieClip {

    public static const VERSION:Number = 0.335;

    public const CONFIG_PATH:String = "../modManagerConfig.json";
    public var config:Object = {};
    public var parentClip:MovieClip;
    private var parentName:String = null;
    private var sfe:Object = null;

    public function ModManager(parentClip:MovieClip, parentName:String, sfe:Object = null) {
        this.parentClip = parentClip;
        this.parentName = parentName;
        this.sfe = sfe;
        this.loadConfig();
    }

    private function loadConfig():void {
        debug('loadConfig');
        var url:URLRequest = new URLRequest(CONFIG_PATH);
        var loader:URLLoader = new URLLoader();
        loader.load(url);
        var that:ModManager = this;
        debug('Config load1');
        loader.addEventListener(Event.COMPLETE, function (e:Event):void {
            var data:String = loader.data;
            var jsonData:Object = new JSONDecoder(data, true).getValue();
            debug('Config loaded');
            that.config = jsonData;
            var modConfigs:Object = that.config[that.parentName];
            if (modConfigs && modConfigs.length > 0) {
                for (var i:int = 0; i < modConfigs.length; i++) {
                    var modConfig:Object = modConfigs[i];
                    that.loadMod(modConfig);
                }
            }
        });
    }

    public function getModLoaderName(mod:String):String {
        return mod + 'Loader';
    }

    public function onModLoaded(modName:String):void {
        // todo: if any mod requires some specific load logic, that could be achieved
        //  by adding if/switch statement by mod name and executing mod-specific logic
        try {
            debug("onModLoaded start " + modName);
            MovieClip(this.parentClip.modLoaders[getModLoaderName(modName)].content).setParent(
                    this.parentClip);
            debug("onModLoaded " + modName);
        } catch (e:Error) {
            ShowHUDMessage("Error onModLoaded " + modName, true);
            ShowHUDMessage('' + e, true);
        }
    }

    public function loadMod(modConfig:Object):void {
        try {
            var modName:String = modConfig.name;
            ShowHUDMessage("Loading " + modName, this.config.debug);
            if (!modConfig.enabled) {
                ShowHUDMessage("Mod disabled, ignoring loading: " + modName, this.config.debug);
                return;
            }
            var url:URLRequest = new URLRequest(CONFIG_PATH);
            var loader:URLLoader = new URLLoader();
            loader.load(url);
            var that:ModManager = this;
            var loaderName:String = this.getModLoaderName(modName);
            loader.addEventListener(Event.COMPLETE, function (e:Event):void {
                try {
                    that.parentClip.modLoaders[loaderName] = new Loader();
                    that.parentClip.modLoaders[loaderName].contentLoaderInfo.addEventListener(
                            Event.COMPLETE, function (e:Event):void {
                                that.onModLoaded(modName);
                            });
                    that.parentClip.modLoaders[loaderName].load(new URLRequest(modName));
                    that.parentClip.addChild(that.parentClip.modLoaders[loaderName]);
                    debug("loadModCOMPLETE " + modName);
                } catch (e:Error) {
                    ShowHUDMessage("Error Loading " + modName, that.config.debug);
                    ShowHUDMessage('' + e, that.config.debug);
                }
            });
            debug("loadMod " + modName);
        } catch (e:Error) {
            ShowHUDMessage("Error loading mod: " + modConfig, this.config.debug);
            ShowHUDMessage('' + e, this.config.debug);
        }
    }

    public static function ShowHUDMessage(text:String, force:Boolean = false):void {
        if (force) {
            GlobalFunc.ShowHUDMessage("[ModManagerLoader v" + ModManager.VERSION + "] " + text);
        }
    }

    public static function debug(text:String):void {
        ShowHUDMessage(text, true);
    }
}
}