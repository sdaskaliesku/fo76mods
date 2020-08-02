 
package Shared.AS3.Data
{
   import flash.events.Event;
   
   public final class FromClientDataEvent extends Event
   {
       
      
      private var m_FromClient:UIDataFromClient;
      
      public function FromClientDataEvent(aFromClient:UIDataFromClient)
      {
         // method body index: 197 method index: 197
         super(Event.CHANGE);
         this.m_FromClient = aFromClient;
      }
      
      public function get fromClient() : Object
      {
         // method body index: 198 method index: 198
         return this.m_FromClient;
      }
      
      public function get data() : Object
      {
         // method body index: 199 method index: 199
         return this.m_FromClient.data;
      }
   }
}
