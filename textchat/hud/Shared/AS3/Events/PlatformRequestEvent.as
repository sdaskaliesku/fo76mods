 
package Shared.AS3.Events
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PlatformRequestEvent extends Event
   {
      
      public static const PLATFORM_REQUEST:String = // method body index: 397 method index: 397
      "GetPlatform";
       
      
      var _target:MovieClip;
      
      public function PlatformRequestEvent(param1:MovieClip)
      {
         // method body index: 398 method index: 398
         super(PLATFORM_REQUEST);
         this._target = param1;
      }
      
      public function RespondToRequest(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {
         // method body index: 399 method index: 399
         this._target.SetPlatform(param1,param2,param3,param4);
      }
      
      override public function clone() : Event
      {
         // method body index: 400 method index: 400
         return new PlatformRequestEvent(this._target);
      }
   }
}
