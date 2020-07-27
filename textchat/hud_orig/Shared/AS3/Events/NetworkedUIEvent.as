 
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

         this._EventType = aEventType;
         this._EventSender = aEventSender;
         this._EventTarget = aEventTarget;
         this._EventData = aEventData;
         super(type,bubbles,cancelable);
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
