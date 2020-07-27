package utils {
import flash.display.Sprite;
import flash.events.DataEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import flash.system.Security;
import flash.utils.ByteArray;

public class SocketService extends BaseService {

    private var host:String;
    private var port:int;
    private var socket:Socket;

    public function SocketService(sprite:Sprite, host:String = "localhost", port:int = 9090) {
        super(sprite);
        this.host = host;
        this.port = port;
        Security.loadPolicyFile("xmlsocket://" + host + ":" + port);
        Security.loadPolicyFile("socket://" + host + ":" + port);
//        Security.allowInsecureDomain("*");
//        Security.allowDomain("*");
    }

    public function connect():void {
        Logger.get().info("Connect method in");

        try {
            Logger.get().info("Starting connection");

            this.socket = new Socket(host, port);
            socket.addEventListener(Event.CONNECT, onConnect);
            socket.addEventListener(DataEvent.DATA, onData);
            socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            socket.connect(host, port);
            Logger.get().info("Connect success!!!");
        } catch (e:Error) {
            Logger.get().error("Error connecting");
            Logger.get().error(e);
        }
        Logger.get().info("Connect method out");
    }

    public function readData():void {
        try {
            var object:* = socket.readObject();

            Logger.get().info(object);
            socket.close();
        } catch (e:Error) {
            Logger.get().error("Error reading data");
            Logger.get().error(e);
        }
    }

    public override function sendData():void {
        if (socket == null) {
            connect();
        }
        try {
            socket.writeUTFBytes("test from fo76");
            readData();
            socket.close();
        } catch (e:Error) {
            Logger.get().error("Error sending data");
            Logger.get().error(e);
        }
    }

    private static function ioErrorHandler(event:IOErrorEvent):void {
        Logger.get().error("ioErrorHandler");
        Logger.get().error(event);
    }

    private static function securityErrorHandler(event:SecurityErrorEvent):void {
        Logger.get().error("securityErrorHandler");
        Logger.get().error(event);
    }

    private function onData(progrEvent:ProgressEvent):void {

        var stream:ByteArray = new ByteArray();
        socket.writeBytes(stream, 0, 0);

        var data:String = "";

        while (socket.bytesAvailable) {
            data += socket.readUTFBytes(1);
        }

        trace("data " + data);
        Logger.get().info(data);
    }

    private static function onConnect(data:Object):void {
        Logger.get().info("onConnect");
        Logger.get().info(data);
    }
}
}