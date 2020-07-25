 
package
{
   import flash.display.Stage;
   import flash.events.Event;
   
   public class PipboyChangeEvent extends Event
   {
      
      public static const PIPBOY_CHANGE_EVENT:String = // method body index: 118 method index: 118
      "PipboyChangeEvent";
       
      
      private var _UpdateMask:PipboyUpdateMask;
      
      private var _DataObj:Pipboy_DataObj;
      
      private var _TabNames:Array;
      
      public function PipboyChangeEvent()
      {
         // method body index: 122 method index: 122
         super(PIPBOY_CHANGE_EVENT);
      }
      
      public static function DispatchEvent(param1:PipboyUpdateMask, param2:Stage, param3:Pipboy_DataObj, param4:Array) : *
      {
         // method body index: 119 method index: 119
         var _loc5_:PipboyChangeEvent = new PipboyChangeEvent();
         _loc5_._UpdateMask = param1;
         _loc5_._DataObj = param3;
         _loc5_._TabNames = param4;
         param2.dispatchEvent(_loc5_);
         _loc5_._DataObj = null;
         _loc5_._TabNames = null;
      }
      
      public static function Register(param1:Stage, param2:Function) : *
      {
         // method body index: 120 method index: 120
         param1.addEventListener(PIPBOY_CHANGE_EVENT,param2);
      }
      
      public static function Unregister(param1:Stage, param2:Function) : *
      {
         // method body index: 121 method index: 121
         param1.removeEventListener(PIPBOY_CHANGE_EVENT,param2);
      }
      
      public function get UpdateMask() : PipboyUpdateMask
      {
         // method body index: 123 method index: 123
         return this._UpdateMask;
      }
      
      public function get DataObj() : Pipboy_DataObj
      {
         // method body index: 124 method index: 124
         return this._DataObj;
      }
      
      public function get TabNames() : Array
      {
         // method body index: 125 method index: 125
         return this._TabNames;
      }
   }
}
