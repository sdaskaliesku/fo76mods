 
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

         super(PLATFORM_REQUEST);
         this._target = param1;
      }
      
      public function RespondToRequest(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {

         this._target.SetPlatform(param1,param2,param3,param4);
      }
      
      override public function clone() : Event
      {

         return new PlatformRequestEvent(this._target);
      }
   }
}
