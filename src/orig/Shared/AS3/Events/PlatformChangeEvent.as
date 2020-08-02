 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class PlatformChangeEvent extends Event
   {
      
      public static const PLATFORM_PC_KB_MOUSE:uint = // method body index: 206 method index: 206
      0;
      
      public static const PLATFORM_PC_GAMEPAD:uint = // method body index: 206 method index: 206
      1;
      
      public static const PLATFORM_XB1:uint = // method body index: 206 method index: 206
      2;
      
      public static const PLATFORM_PS4:uint = // method body index: 206 method index: 206
      3;
      
      public static const PLATFORM_MOBILE:uint = // method body index: 206 method index: 206
      4;
      
      public static const PLATFORM_INVALID:uint = // method body index: 206 method index: 206
      uint.MAX_VALUE;
      
      public static const PLATFORM_PC_KB_ENG:uint = // method body index: 206 method index: 206
      0;
      
      public static const PLATFORM_PC_KB_FR:uint = // method body index: 206 method index: 206
      1;
      
      public static const PLATFORM_PC_KB_BE:uint = // method body index: 206 method index: 206
      2;
      
      public static const PLATFORM_CHANGE:String = // method body index: 206 method index: 206
      "SetPlatform";
       
      
      var _uiPlatform:uint = 4.294967295E9;
      
      var _bPS3Switch:Boolean = false;
      
      var _uiController:uint = 4.294967295E9;
      
      var _uiKeyboard:uint = 4.294967295E9;
      
      public function PlatformChangeEvent(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint)
      {
         // method body index: 215 method index: 215
         super(PLATFORM_CHANGE,true,true);
         this.uiPlatform = auiPlatform;
         this.bPS3Switch = abPS3Switch;
         this.uiController = auiController;
         this.uiKeyboard = auiKeyboard;
      }
      
      public function get uiPlatform() : *
      {
         // method body index: 207 method index: 207
         return this._uiPlatform;
      }
      
      public function set uiPlatform(auiPlatform:uint) : *
      {
         // method body index: 208 method index: 208
         this._uiPlatform = auiPlatform;
      }
      
      public function get bPS3Switch() : *
      {
         // method body index: 209 method index: 209
         return this._bPS3Switch;
      }
      
      public function set bPS3Switch(abPS3Switch:Boolean) : *
      {
         // method body index: 210 method index: 210
         this._bPS3Switch = abPS3Switch;
      }
      
      public function get uiController() : *
      {
         // method body index: 211 method index: 211
         return this._uiController;
      }
      
      public function set uiController(auiController:uint) : *
      {
         // method body index: 212 method index: 212
         this._uiController = auiController;
      }
      
      public function get uiKeyboard() : *
      {
         // method body index: 213 method index: 213
         return this._uiKeyboard;
      }
      
      public function set uiKeyboard(auiKeyboard:uint) : *
      {
         // method body index: 214 method index: 214
         this._uiKeyboard = auiKeyboard;
      }
      
      override public function clone() : Event
      {
         // method body index: 216 method index: 216
         return new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
      }
   }
}
