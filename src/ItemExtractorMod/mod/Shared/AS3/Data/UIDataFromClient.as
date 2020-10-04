 
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
         // method body index: 273 method index: 273
         super();
         this.m_Ready = false;
         this.m_Payload = param1;
         this.m_IsTest = false;
      }
      
      public function DispatchChange() : void
      {
         // method body index: 274 method index: 274
         dispatchEvent(new FromClientDataEvent(this));
      }
      
      public function SetReady() : void
      {
         // method body index: 275 method index: 275
         if(!this.m_Ready)
         {
            this.m_Ready = true;
            this.DispatchChange();
         }
      }
      
      public function get data() : Object
      {
         // method body index: 276 method index: 276
         return this.m_Payload;
      }
      
      public function get dataReady() : Boolean
      {
         // method body index: 277 method index: 277
         return this.m_Ready;
      }
      
      public function get isTest() : Boolean
      {
         // method body index: 278 method index: 278
         return this.m_IsTest;
      }
      
      public function set isTest(param1:Boolean) : void
      {
         // method body index: 279 method index: 279
         this.m_IsTest = param1;
      }
   }
}
