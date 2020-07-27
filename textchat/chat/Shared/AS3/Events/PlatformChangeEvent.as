 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class PlatformChangeEvent extends Event
   {
      
      public static const PLATFORM_PC_KB_MOUSE:uint = // method body index: 143 method index: 143
      0;
      
      public static const PLATFORM_PC_GAMEPAD:uint = // method body index: 143 method index: 143
      1;
      
      public static const PLATFORM_XB1:uint = // method body index: 143 method index: 143
      2;
      
      public static const PLATFORM_PS4:uint = // method body index: 143 method index: 143
      3;
      
      public static const PLATFORM_MOBILE:uint = // method body index: 143 method index: 143
      4;
      
      public static const PLATFORM_INVALID:uint = // method body index: 143 method index: 143
      uint.MAX_VALUE;
      
      public static const PLATFORM_PC_KB_ENG:uint = // method body index: 143 method index: 143
      0;
      
      public static const PLATFORM_PC_KB_FR:uint = // method body index: 143 method index: 143
      1;
      
      public static const PLATFORM_PC_KB_BE:uint = // method body index: 143 method index: 143
      2;
      
      public static const PLATFORM_CHANGE:String = // method body index: 143 method index: 143
      "SetPlatform";
       
      
      var _uiPlatform:uint = 4.294967295E9;
      
      var _bPS3Switch:Boolean = false;
      
      var _uiController:uint = 4.294967295E9;
      
      var _uiKeyboard:uint = 4.294967295E9;
      
      public function PlatformChangeEvent(param1:uint, param2:Boolean, param3:uint, param4:uint)
      {
         // method body index: 144 method index: 144
         super(PLATFORM_CHANGE,true,true);
         this.uiPlatform = param1;
         this.bPS3Switch = param2;
         this.uiController = param3;
         this.uiKeyboard = param4;
      }
      
      public function get uiPlatform() : *
      {
         // method body index: 145 method index: 145
         return this._uiPlatform;
      }
      
      public function set uiPlatform(param1:uint) : *
      {
         // method body index: 146 method index: 146
         this._uiPlatform = param1;
      }
      
      public function get bPS3Switch() : *
      {
         // method body index: 147 method index: 147
         return this._bPS3Switch;
      }
      
      public function set bPS3Switch(param1:Boolean) : *
      {
         // method body index: 148 method index: 148
         this._bPS3Switch = param1;
      }
      
      public function get uiController() : *
      {
         // method body index: 149 method index: 149
         return this._uiController;
      }
      
      public function set uiController(param1:uint) : *
      {
         // method body index: 150 method index: 150
         this._uiController = param1;
      }
      
      public function get uiKeyboard() : *
      {
         // method body index: 151 method index: 151
         return this._uiKeyboard;
      }
      
      public function set uiKeyboard(param1:uint) : *
      {
         // method body index: 152 method index: 152
         this._uiKeyboard = param1;
      }
      
      override public function clone() : Event
      {
         // method body index: 153 method index: 153
         return new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
      }
   }
}
