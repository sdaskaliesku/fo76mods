package utils {
import flash.display.Loader;
import flash.display.Sprite;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.getQualifiedClassName;

public class BaseService {

    protected var _sprite:Sprite;
    protected var myLoader:Loader = new Loader();
    protected var loaderCtx:LoaderContext = new LoaderContext(false,
            ApplicationDomain.currentDomain);

    public function BaseService(sprite:Sprite) {
        _sprite = sprite;
        _sprite.addChild(myLoader);
        Logger.get().info("Service loaded: " + getQualifiedClassName(this))
    }

    public function sendData():void {
    }
}
}