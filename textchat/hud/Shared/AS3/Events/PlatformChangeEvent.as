 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class PlatformChangeEvent extends Event
   {
      
      public static const PLATFORM_PC_KB_MOUSE:uint = // method body index: 385 method index: 385
      0;
      
      public static const PLATFORM_PC_GAMEPAD:uint = // method body index: 385 method index: 385
      1;
      
      public static const PLATFORM_XB1:uint = // method body index: 385 method index: 385
      2;
      
      public static const PLATFORM_PS4:uint = // method body index: 385 method index: 385
      3;
      
      public static const PLATFORM_MOBILE:uint = // method body index: 385 method index: 385
      4;
      
      public static const PLATFORM_INVALID:uint = // method body index: 385 method index: 385
      uint.MAX_VALUE;
      
      public static const PLATFORM_PC_KB_ENG:uint = // method body index: 385 method index: 385
      0;
      
      public static const PLATFORM_PC_KB_FR:uint = // method body index: 385 method index: 385
      1;
      
      public static const PLATFORM_PC_KB_BE:uint = // method body index: 385 method index: 385
      2;
      
      public static const PLATFORM_CHANGE:String = // method body index: 385 method index: 385
      "SetPlatform";
       
      
      var _uiPlatform:uint = 4.294967295E9;
      
      var _bPS3Switch:Boolean = false;
      
      var _uiController:uint = 4.294967295E9;
      
      var _uiKeyboard:uint = 4.294967295E9;
      
      public function PlatformChangeEvent(param1:uint, param2:Boolean, param3:uint, param4:uint)
      {
         // method body index: 386 method index: 386
         super(PLATFORM_CHANGE,true,true);
         this.uiPlatform = param1;
         this.bPS3Switch = param2;
         this.uiController = param3;
         this.uiKeyboard = param4;
      }
      
      public function get uiPlatform() : *
      {
         // method body index: 387 method index: 387
         return this._uiPlatform;
      }
      
      public function set uiPlatform(param1:uint) : *
      {
         // method body index: 388 method index: 388
         this._uiPlatform = param1;
      }
      
      public function get bPS3Switch() : *
      {
         // method body index: 389 method index: 389
         return this._bPS3Switch;
      }
      
      public function set bPS3Switch(param1:Boolean) : *
      {
         // method body index: 390 method index: 390
         this._bPS3Switch = param1;
      }
      
      public function get uiController() : *
      {
         // method body index: 391 method index: 391
         return this._uiController;
      }
      
      public function set uiController(param1:uint) : *
      {
         // method body index: 392 method index: 392
         this._uiController = param1;
      }
      
      public function get uiKeyboard() : *
      {
         // method body index: 393 method index: 393
         return this._uiKeyboard;
      }
      
      public function set uiKeyboard(param1:uint) : *
      {
         // method body index: 394 method index: 394
         this._uiKeyboard = param1;
      }
      
      override public function clone() : Event
      {
         // method body index: 395 method index: 395
         return new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
      }
   }
}
