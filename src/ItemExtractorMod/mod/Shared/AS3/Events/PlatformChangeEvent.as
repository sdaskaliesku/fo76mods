 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class PlatformChangeEvent extends Event
   {
      
      public static const PLATFORM_PC_KB_MOUSE:uint = // method body index: 177 method index: 177
      0;
      
      public static const PLATFORM_PC_GAMEPAD:uint = // method body index: 177 method index: 177
      1;
      
      public static const PLATFORM_XB1:uint = // method body index: 177 method index: 177
      2;
      
      public static const PLATFORM_PS4:uint = // method body index: 177 method index: 177
      3;
      
      public static const PLATFORM_MOBILE:uint = // method body index: 177 method index: 177
      4;
      
      public static const PLATFORM_INVALID:uint = // method body index: 177 method index: 177
      uint.MAX_VALUE;
      
      public static const PLATFORM_PC_KB_ENG:uint = // method body index: 177 method index: 177
      0;
      
      public static const PLATFORM_PC_KB_FR:uint = // method body index: 177 method index: 177
      1;
      
      public static const PLATFORM_PC_KB_BE:uint = // method body index: 177 method index: 177
      2;
      
      public static const PLATFORM_CHANGE:String = // method body index: 177 method index: 177
      "SetPlatform";
       
      
      var _uiPlatform:uint = 4.294967295E9;
      
      var _bPS3Switch:Boolean = false;
      
      var _uiController:uint = 4.294967295E9;
      
      var _uiKeyboard:uint = 4.294967295E9;
      
      public function PlatformChangeEvent(param1:uint, param2:Boolean, param3:uint, param4:uint)
      {
         // method body index: 186 method index: 186
         super(PLATFORM_CHANGE,true,true);
         this.uiPlatform = param1;
         this.bPS3Switch = param2;
         this.uiController = param3;
         this.uiKeyboard = param4;
      }
      
      public function get uiPlatform() : *
      {
         // method body index: 178 method index: 178
         return this._uiPlatform;
      }
      
      public function set uiPlatform(param1:uint) : *
      {
         // method body index: 179 method index: 179
         this._uiPlatform = param1;
      }
      
      public function get bPS3Switch() : *
      {
         // method body index: 180 method index: 180
         return this._bPS3Switch;
      }
      
      public function set bPS3Switch(param1:Boolean) : *
      {
         // method body index: 181 method index: 181
         this._bPS3Switch = param1;
      }
      
      public function get uiController() : *
      {
         // method body index: 182 method index: 182
         return this._uiController;
      }
      
      public function set uiController(param1:uint) : *
      {
         // method body index: 183 method index: 183
         this._uiController = param1;
      }
      
      public function get uiKeyboard() : *
      {
         // method body index: 184 method index: 184
         return this._uiKeyboard;
      }
      
      public function set uiKeyboard(param1:uint) : *
      {
         // method body index: 185 method index: 185
         this._uiKeyboard = param1;
      }
      
      override public function clone() : Event
      {
         // method body index: 187 method index: 187
         return new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
      }
   }
}
