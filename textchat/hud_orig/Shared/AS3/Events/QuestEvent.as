 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class QuestEvent extends Event
   {
      
      public static const EVENT_COMPLETE:String = // method body index: 379 method index: 379
      "QuestComplete";
      
      public static const EVENT_AVAILABLE:String = // method body index: 379 method index: 379
      "QuestAvailable";
      
      public static const EVENT_ACCEPTED:String = // method body index: 379 method index: 379
      "QuestAccepted";
       
      
      private var m_Data:Object;
      
      public var pvpFlag:Boolean;
      
      public function QuestEvent(aType:String, aQuestData:Object, aBubbles:Boolean = false, aCancelable:Boolean = false, aPVPFlag:Boolean = false)
      {
         // method body index: 381 method index: 381
         this.m_Data = aQuestData;
         this.pvpFlag = aPVPFlag;
         super(aType,aBubbles,aCancelable);
      }
      
      public function get data() : Object
      {
         // method body index: 380 method index: 380
         return this.m_Data;
      }
      
      override public function clone() : Event
      {
         // method body index: 382 method index: 382
         return new QuestEvent(type,this.data,bubbles,cancelable);
      }
   }
}
