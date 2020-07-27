 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class PlatformChangeEvent extends Event
   {
      
      public static const PLATFORM_PC_KB_MOUSE:uint = // method body index: 388 method index: 388
      0;
      
      public static const PLATFORM_PC_GAMEPAD:uint = // method body index: 388 method index: 388
      1;
      
      public static const PLATFORM_XB1:uint = // method body index: 388 method index: 388
      2;
      
      public static const PLATFORM_PS4:uint = // method body index: 388 method index: 388
      3;
      
      public static const PLATFORM_MOBILE:uint = // method body index: 388 method index: 388
      4;
      
      public static const PLATFORM_INVALID:uint = // method body index: 388 method index: 388
      uint.MAX_VALUE;
      
      public static const PLATFORM_PC_KB_ENG:uint = // method body index: 388 method index: 388
      0;
      
      public static const PLATFORM_PC_KB_FR:uint = // method body index: 388 method index: 388
      1;
      
      public static const PLATFORM_PC_KB_BE:uint = // method body index: 388 method index: 388
      2;
      
      public static const PLATFORM_CHANGE:String = // method body index: 388 method index: 388
      "SetPlatform";
       
      
      var _uiPlatform:uint = 4.294967295E9;
      
      var _bPS3Switch:Boolean = false;
      
      var _uiController:uint = 4.294967295E9;
      
      var _uiKeyboard:uint = 4.294967295E9;
      
      public function PlatformChangeEvent(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint)
      {
         // method body index: 397 method index: 397
         super(PLATFORM_CHANGE,true,true);
         this.uiPlatform = auiPlatform;
         this.bPS3Switch = abPS3Switch;
         this.uiController = auiController;
         this.uiKeyboard = auiKeyboard;
      }
      
      public function get uiPlatform() : *
      {
         // method body index: 389 method index: 389
         return this._uiPlatform;
      }
      
      public function set uiPlatform(auiPlatform:uint) : *
      {
         // method body index: 390 method index: 390
         this._uiPlatform = auiPlatform;
      }
      
      public function get bPS3Switch() : *
      {
         // method body index: 391 method index: 391
         return this._bPS3Switch;
      }
      
      public function set bPS3Switch(abPS3Switch:Boolean) : *
      {
         // method body index: 392 method index: 392
         this._bPS3Switch = abPS3Switch;
      }
      
      public function get uiController() : *
      {
         // method body index: 393 method index: 393
         return this._uiController;
      }
      
      public function set uiController(auiController:uint) : *
      {
         // method body index: 394 method index: 394
         this._uiController = auiController;
      }
      
      public function get uiKeyboard() : *
      {
         // method body index: 395 method index: 395
         return this._uiKeyboard;
      }
      
      public function set uiKeyboard(auiKeyboard:uint) : *
      {
         // method body index: 396 method index: 396
         this._uiKeyboard = auiKeyboard;
      }
      
      override public function clone() : Event
      {
         // method body index: 398 method index: 398
         return new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
      }
   }
}
