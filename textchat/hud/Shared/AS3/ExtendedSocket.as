 
package Shared.AS3
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.errors.EOFError;
   import flash.errors.IOError;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import scaleform.gfx.TextFieldEx;
   
   public class ExtendedSocket extends MovieClip implements IEventDispatcher
   {
       
      
      public var sfCodeObject = null;
      
      public var prevBytesAvailable:uint = 0;
      
      public var bytesAvailable:uint = 0;
      
      public var connected:Boolean = false;
      
      private var connectTimer:Timer;
      
      private var dataTimer:Timer;
      
      private var connectCalled:Boolean = false;
      
      private var message:TextField;
      
      public function ExtendedSocket(param1:*)
      {
         // method body index: 2388 method index: 2388
         this.connectTimer = new Timer(5,1);
         this.dataTimer = new Timer(50,1);
         this.message = new TextField();
         super();
         if(param1 != null)
         {
            this.sfCodeObject = param1;
            if(param1.call != null)
            {
               this.sfCodeObject.call("register",this);
            }
         }
      }
      
      public function connect(param1:String, param2:String) : void
      {
         // method body index: 2389 method index: 2389
         var _loc3_:String = this.name;
         var _loc4_:Object = this;
         if(this.connected)
         {
            return;
         }
         this.connectCalled = true;
         if(this.sfCodeObject.call != null)
         {
            this.sfCodeObject.call("connect",param1,param2);
            this.connectTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onConnectLoop);
            this.dataTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSocketLoop);
            this.connectTimer.reset();
            this.connectTimer.start();
            this.dataTimer.reset();
            this.dataTimer.start();
         }
      }
      
      public function close() : void
      {
         // method body index: 2390 method index: 2390
      }
      
      public function readByte() : int
      {
         // method body index: 2391 method index: 2391
         return this.sfCodeObject.call("readByte");
      }
      
      public function readUTFBytes(param1:uint) : String
      {
         // method body index: 2392 method index: 2392
         if(param1 > this.bytesAvailable)
         {
            param1 = this.bytesAvailable;
         }
         var _loc2_:String = "";
         _loc2_ = this.sfCodeObject.call("readUTFBytes",param1);
         if(_loc2_ === "$$IOERROR$$")
         {
            this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
            throw new IOError();
         }
         if(_loc2_ === "$$EOFERROR$$")
         {
            throw new EOFError();
         }
         return _loc2_;
      }
      
      public function writeUTFBytes(param1:String) : void
      {
         // method body index: 2393 method index: 2393
         var _loc2_:Boolean = this.sfCodeObject.call("writeUTFBytes",param1);
         if(!_loc2_)
         {
            this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
            throw new IOError();
         }
      }
      
      public function flush() : void
      {
         // method body index: 2394 method index: 2394
      }
      
      public function onConnectLoop() : void
      {
         // method body index: 2395 method index: 2395
         if(this.connected)
         {
            this.dispatchEvent(new Event("ExtendedSocket::CONNECT"));
         }
         else
         {
            this.connectTimer.reset();
            this.connectTimer.start();
         }
      }
      
      public function onSocketLoop() : void
      {
         // method body index: 2396 method index: 2396
         if(this.bytesAvailable > this.prevBytesAvailable)
         {
            this.dispatchEvent(new Event("ExtendedSocket::SocketData"));
         }
         this.prevBytesAvailable = this.bytesAvailable;
         this.dataTimer.reset();
         this.dataTimer.start();
      }
      
      private function displayError(param1:String) : void
      {
         // method body index: 2397 method index: 2397
         this.message.width = 1600;
         GlobalFunc.SetText(this.message,this.message.text + "\n" + param1,false);
         TextFieldEx.setTextAutoSize(this.message,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.message.autoSize = TextFieldAutoSize.LEFT;
         this.message.wordWrap = true;
         this.message.multiline = true;
         addChild(this.message);
         this.message.visible = true;
         var _loc2_:TextFormat = new TextFormat("Arial",15,65280);
         this.message.defaultTextFormat = _loc2_;
         this.message.setTextFormat(_loc2_);
         this.message.mouseEnabled = false;
      }
   }
}
