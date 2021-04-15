 
package Shared.AS3.Data
{
   import flash.events.Event;
   
   public final class FromClientDataEvent extends Event
   {
       
      
      private var m_FromClient:UIDataFromClient;
      
      public function FromClientDataEvent(param1:UIDataFromClient)
      {
         // method body index: 173 method index: 173
         super(Event.CHANGE);
         this.m_FromClient = param1;
      }
      
      public function get fromClient() : Object
      {
         // method body index: 174 method index: 174
         return this.m_FromClient;
      }
      
      public function get data() : Object
      {
         // method body index: 175 method index: 175
         return this.m_FromClient.data;
      }
   }
}
