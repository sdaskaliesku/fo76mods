 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class NetworkedUIEvent extends Event
   {
       
      
      private var _EventType:String = "blank";
      
      private var _EventSender:String = "data";
      
      private var _EventTarget:String = "for";
      
      private var _EventData:String = "testing";
      
      public function NetworkedUIEvent(type:String, aEventType:String, aEventSender:String, aEventTarget:String, aEventData:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         // method body index: 406 method index: 406
         this._EventType = aEventType;
         this._EventSender = aEventSender;
         this._EventTarget = aEventTarget;
         this._EventData = aEventData;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         // method body index: 407 method index: 407
         return new NetworkedUIEvent(type,this._EventType,this._EventSender,this._EventTarget,this._EventData,bubbles,cancelable);
      }
      
      public function get EventType() : String
      {
         // method body index: 408 method index: 408
         return this._EventType;
      }
      
      public function get EventSender() : String
      {
         // method body index: 409 method index: 409
         return this._EventSender;
      }
      
      public function get EventTarget() : String
      {
         // method body index: 410 method index: 410
         return this._EventTarget;
      }
      
      public function get EventData() : String
      {
         // method body index: 411 method index: 411
         return this._EventData;
      }
   }
}
