package utils {
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

public class HttpService extends BaseService {
    private var host:String;
    private var endpoint:String;
    private var port:int;
    private var fullURL:String;

    public function HttpService(sprite:Sprite, host:String = "http://localhost", port:int = 4567,
            endpoint:String = "fo76") {
        super(sprite);
        this.host = host;
        this.port = port;
        this.endpoint = endpoint;
//        this.fullURL = "http://localhost:4567/fo76";
        this.fullURL = host + ":" + port + "/" + endpoint;
        Logger.get().info("Full url = " + this.fullURL);
        super._sprite.addChild(myLoader);
    }

    public override function sendData():void {
        Logger.get().info("Start sending");
        try {
            var request:URLRequest = new URLRequest(this.fullURL);
            request.method = URLRequestMethod.GET;
            var variables:URLVariables = new URLVariables();
            variables.name = "Anton Ashardi";
            request.data = variables;
//            sendToURL(request);
            Logger.get().info("Sending request");
            myLoader.load(request, loaderCtx);
            Logger.get().info("Request sent");
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

    private function ioErrorHandler(data:Event):void {
        Logger.get().error(data);
    }

    private function completeHandler(data:Event):void {
        Logger.get().info(data);
    }
}
}