 
package Shared.AS3.Events
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PlatformRequestEvent extends Event
   {
      
      public static const PLATFORM_REQUEST:String = // method body index: 155 method index: 155
      "GetPlatform";
       
      
      var _target:MovieClip;
      
      public function PlatformRequestEvent(param1:MovieClip)
      {
         // method body index: 156 method index: 156
         super(PLATFORM_REQUEST);
         this._target = param1;
      }
      
      public function RespondToRequest(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {
         // method body index: 157 method index: 157
         this._target.SetPlatform(param1,param2,param3,param4);
      }
      
      override public function clone() : Event
      {
         // method body index: 158 method index: 158
         return new PlatformRequestEvent(this._target);
      }
   }
}
