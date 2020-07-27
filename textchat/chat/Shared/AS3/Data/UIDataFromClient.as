 
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
         // method body index: 194 method index: 194
         super();
         this.m_Ready = false;
         this.m_Payload = param1;
         this.m_IsTest = false;
      }
      
      public function DispatchChange() : void
      {
         // method body index: 195 method index: 195
         dispatchEvent(new FromClientDataEvent(this));
      }
      
      public function SetReady() : void
      {
         // method body index: 196 method index: 196
         if(!this.m_Ready)
         {
            this.m_Ready = true;
            this.DispatchChange();
         }
      }
      
      public function get data() : Object
      {
         // method body index: 197 method index: 197
         return this.m_Payload;
      }
      
      public function get dataReady() : Boolean
      {
         // method body index: 198 method index: 198
         return this.m_Ready;
      }
      
      public function get isTest() : Boolean
      {
         // method body index: 199 method index: 199
         return this.m_IsTest;
      }
      
      public function set isTest(param1:Boolean) : *
      {
         // method body index: 200 method index: 200
         this.m_IsTest = param1;
      }
   }
}
