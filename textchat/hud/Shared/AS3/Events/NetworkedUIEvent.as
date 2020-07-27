 
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

         this._EventType = param2;
         this._EventSender = param3;
         this._EventTarget = param4;
         this._EventData = param5;
         super(param1,param6,param7);
      }
      
      override public function clone() : Event
      {

         return new NetworkedUIEvent(type,this._EventType,this._EventSender,this._EventTarget,this._EventData,bubbles,cancelable);
      }
      
      public function get EventType() : String
      {

         return this._EventType;
      }
      
      public function get EventSender() : String
      {

         return this._EventSender;
      }
      
      public function get EventTarget() : String
      {

         return this._EventTarget;
      }
      
      public function get EventData() : String
      {

         return this._EventData;
      }
   }
}
