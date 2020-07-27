 
package Shared.AS3.Data
{
   import flash.events.Event;
   
   public final class FromClientDataEvent extends Event
   {
       
      
      private var m_FromClient:UIDataFromClient;
      
      public function FromClientDataEvent(aFromClient:UIDataFromClient)
      {
         // method body index: 366 method index: 366
         super(Event.CHANGE);
         this.m_FromClient = aFromClient;
      }
      
      public function get fromClient() : Object
      {
         // method body index: 367 method index: 367
         return this.m_FromClient;
      }
      
      public function get data() : Object
      {
         // method body index: 368 method index: 368
         return this.m_FromClient.data;
      }
   }
}
