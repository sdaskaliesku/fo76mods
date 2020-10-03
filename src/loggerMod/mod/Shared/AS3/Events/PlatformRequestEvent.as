 
package Shared.AS3.Events
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PlatformRequestEvent extends Event
   {
      
      public static const PLATFORM_REQUEST:String = // method body index: 189 method index: 189
      "GetPlatform";
       
      
      var _target:MovieClip;
      
      public function PlatformRequestEvent(param1:MovieClip)
      {
         // method body index: 190 method index: 190
         super(PLATFORM_REQUEST);
         this._target = param1;
      }
      
      public function RespondToRequest(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {
         // method body index: 191 method index: 191
         this._target.SetPlatform(param1,param2,param3,param4);
      }
      
      override public function clone() : Event
      {
         // method body index: 192 method index: 192
         return new PlatformRequestEvent(this._target);
      }
   }
}
