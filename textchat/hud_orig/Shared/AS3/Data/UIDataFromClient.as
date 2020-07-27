 
package Shared.AS3.Data
{
   import flash.events.EventDispatcher;
   
   public class UIDataFromClient extends EventDispatcher
   {
       
      
      private var m_Payload:Object;
      
      private var m_Ready:Boolean = false;
      
      private var m_IsTest:Boolean = false;
      
      public function UIDataFromClient(aPayload:Object)
      {
         // method body index: 596 method index: 596
         super();
         this.m_Ready = false;
         this.m_Payload = aPayload;
         this.m_IsTest = false;
      }
      
      public function DispatchChange() : void
      {
         // method body index: 597 method index: 597
         dispatchEvent(new FromClientDataEvent(this));
      }
      
      public function SetReady() : void
      {
         // method body index: 598 method index: 598
         if(!this.m_Ready)
         {
            this.m_Ready = true;
            this.DispatchChange();
         }
      }
      
      public function get data() : Object
      {
         // method body index: 599 method index: 599
         return this.m_Payload;
      }
      
      public function get dataReady() : Boolean
      {
         // method body index: 600 method index: 600
         return this.m_Ready;
      }
      
      public function get isTest() : Boolean
      {
         // method body index: 601 method index: 601
         return this.m_IsTest;
      }
      
      public function set isTest(value:Boolean) : *
      {
         // method body index: 602 method index: 602
         this.m_IsTest = value;
      }
   }
}
