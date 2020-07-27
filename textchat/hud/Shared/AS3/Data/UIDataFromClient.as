 
package Shared.AS3.Data
{
   import flash.events.EventDispatcher;
   
   public class UIDataFromClient extends EventDispatcher
   {
       
      
      private var m_Payload:Object;
      
      private var m_Ready:Boolean = false;
      
      private var m_IsTest:Boolean = false;
      
      public function UIDataFromClient(param1:Object)
      {
         // method body index: 482 method index: 482
         super();
         this.m_Ready = false;
         this.m_Payload = param1;
         this.m_IsTest = false;
      }
      
      public function DispatchChange() : void
      {
         // method body index: 483 method index: 483
         dispatchEvent(new FromClientDataEvent(this));
      }
      
      public function SetReady() : void
      {
         // method body index: 484 method index: 484
         if(!this.m_Ready)
         {
            this.m_Ready = true;
            this.DispatchChange();
         }
      }
      
      public function get data() : Object
      {
         // method body index: 485 method index: 485
         return this.m_Payload;
      }
      
      public function get dataReady() : Boolean
      {
         // method body index: 486 method index: 486
         return this.m_Ready;
      }
      
      public function get isTest() : Boolean
      {
         // method body index: 487 method index: 487
         return this.m_IsTest;
      }
      
      public function set isTest(param1:Boolean) : *
      {
         // method body index: 488 method index: 488
         this.m_IsTest = param1;
      }
   }
}
