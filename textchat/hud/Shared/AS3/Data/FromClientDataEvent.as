 
package Shared.AS3.Data
{
   import flash.events.Event;
   
   public final class FromClientDataEvent extends Event
   {
       
      
      private var m_FromClient:UIDataFromClient;
      
      public function FromClientDataEvent(param1:UIDataFromClient)
      {

         super(Event.CHANGE);
         this.m_FromClient = param1;
      }
      
      public function get fromClient() : Object
      {

         return this.m_FromClient;
      }
      
      public function get data() : Object
      {

         return this.m_FromClient.data;
      }
   }
}
