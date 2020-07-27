 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class NetworkedUIEvent extends Event
   {
       
      
      private var _EventType:String = "blank";
      
      private var _EventSender:String = "data";
      
      private var _EventTarget:String = "for";
      
      private var _EventData:String = "testing";
      
      public function NetworkedUIEvent(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Boolean = false, param7:Boolean = false)
      {
         // method body index: 403 method index: 403
         this._EventType = param2;
         this._EventSender = param3;
         this._EventTarget = param4;
         this._EventData = param5;
         super(param1,param6,param7);
      }
      
      override public function clone() : Event
      {
         // method body index: 404 method index: 404
         return new NetworkedUIEvent(type,this._EventType,this._EventSender,this._EventTarget,this._EventData,bubbles,cancelable);
      }
      
      public function get EventType() : String
      {
         // method body index: 405 method index: 405
         return this._EventType;
      }
      
      public function get EventSender() : String
      {
         // method body index: 406 method index: 406
         return this._EventSender;
      }
      
      public function get EventTarget() : String
      {
         // method body index: 407 method index: 407
         return this._EventTarget;
      }
      
      public function get EventData() : String
      {
         // method body index: 408 method index: 408
         return this._EventData;
      }
   }
}
