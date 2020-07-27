 
package Shared.AS3.Data
{
   import flash.events.Event;
   
   public final class FromClientDataEvent extends Event
   {
       
      
      private var m_FromClient:UIDataFromClient;
      
      public function FromClientDataEvent(param1:UIDataFromClient)
      {
         // method body index: 363 method index: 363
         super(Event.CHANGE);
         this.m_FromClient = param1;
      }
      
      public function get fromClient() : Object
      {
         // method body index: 364 method index: 364
         return this.m_FromClient;
      }
      
      public function get data() : Object
      {
         // method body index: 365 method index: 365
         return this.m_FromClient.data;
      }
   }
}
