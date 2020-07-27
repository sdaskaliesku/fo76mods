package utils {
import flash.display.Sprite;
import flash.net.URLRequest;

public class FileService extends BaseService {
    private const DEFAULT_PATH = "D:\\workspace\\fo76\\test.txt";
    private var path:String;

    public function FileService(sprite:Sprite, path:String = DEFAULT_PATH) {
        super(sprite);
        this.path = path;
    }

//    public override function sendData():void {
//        try {
//            var local:SharedObject = SharedObject.getLocal("test.txt", ".");
//            local.setProperty("test", "test");
//            local.close();
//        } catch (e) {
//            Logger.get().error(e);
//        }
//    }

    public override function sendData():void {
        Logger.get().info("Start sending");
        try {
            var request:URLRequest = new URLRequest(DEFAULT_PATH);
            myLoader.load(request, loaderCtx);
//            myLoader.close();

//            var loader:URLLoader = new URLLoader();
//            loader.addEventListener(Event.COMPLETE, completeHandler);
//            loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
//            loader.load(request);
//            loader.close();
            Logger.get().info("Finish sending");
        } catch (e:Error) {
            Logger.get().error(e);
        }
    }
}
}