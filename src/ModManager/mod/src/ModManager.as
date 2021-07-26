package {
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONDecoder;

import flash.display.Loader;

import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.getQualifiedClassName;

public class ModManager extends MovieClip {

    public static const VERSION:Number = 0.335;

    public const CONFIG_PATH:String = "../modManagerConfig.json";
    public var config:Object = {};
    public var parentClip:MovieClip;
    private var parentName:String = null;

    private function loadConfig():void {
        var url:URLRequest = new URLRequest(CONFIG_PATH);
        var loader:URLLoader = new URLLoader();
        loader.load(url);
        var that:ModManager = this;
        loader.addEventListener(Event.COMPLETE, function (e:Event):void {
            var data:String = loader.data;
            var jsonData:Object = new JSONDecoder(data, true).getValue();
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
            ShowHUDMessage("onModLoaded start " + modName, true);
            MovieClip(this.parentClip.modLoaders[getModLoaderName(modName)].content).setParent(
                    this.parentClip);
            ShowHUDMessage("onModLoaded " + modName, true);
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
                    ShowHUDMessage("loadModCOMPLETE " + modName, that.config.debug);
                } catch (e:Error) {
                    ShowHUDMessage("Error Loading " + modName, that.config.debug);
                    ShowHUDMessage('' + e, that.config.debug);
                }
            });
            ShowHUDMessage("loadMod " + modName, this.config.debug);
        } catch (e:Error) {
            ShowHUDMessage("Error loading mod: " + modConfig, this.config.debug);
            ShowHUDMessage('' + e, this.config.debug);
        }
    }

    /**
     * Should be invoked from parent swf, that loads this one
     * @param parent - parent movie clip
     */
    public function setParent(parent:MovieClip):void {
        this.parentClip = parent;
        this.parentName = getQualifiedClassName(parent);
        this.loadConfig();
    }

    public static function ShowHUDMessage(text:String, force:Boolean = false):void {
        if (force) {
            GlobalFunc.ShowHUDMessage("[ModManagerLoader v" + ModManager.VERSION + "] " + text);
        }
    }
}
}