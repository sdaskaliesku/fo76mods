 
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
         // method body index: 351 method index: 351
         super();
         this.m_Ready = false;
         this.m_Payload = aPayload;
         this.m_IsTest = false;
      }
      
      public function DispatchChange() : void
      {
         // method body index: 352 method index: 352
         dispatchEvent(new FromClientDataEvent(this));
      }
      
      public function SetReady() : void
      {
         // method body index: 353 method index: 353
         if(!this.m_Ready)
         {
            this.m_Ready = true;
            this.DispatchChange();
         }
      }
      
      public function get data() : Object
      {
         // method body index: 354 method index: 354
         return this.m_Payload;
      }
      
      public function get dataReady() : Boolean
      {
         // method body index: 355 method index: 355
         return this.m_Ready;
      }
      
      public function get isTest() : Boolean
      {
         // method body index: 356 method index: 356
         return this.m_IsTest;
      }
      
      public function set isTest(value:Boolean) : *
      {
         // method body index: 357 method index: 357
         this.m_IsTest = value;
      }
   }
}
