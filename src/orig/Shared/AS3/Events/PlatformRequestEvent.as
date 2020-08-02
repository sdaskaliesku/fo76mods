 
package Shared.AS3.Events
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PlatformRequestEvent extends Event
   {
      
      public static const PLATFORM_REQUEST:String = // method body index: 218 method index: 218
      "GetPlatform";
       
      
      var _target:MovieClip;
      
      public function PlatformRequestEvent(aTarget:MovieClip)
      {
         // method body index: 219 method index: 219
         super(PLATFORM_REQUEST);
         this._target = aTarget;
      }
      
      public function RespondToRequest(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : *
      {
         // method body index: 220 method index: 220
         this._target.SetPlatform(auiPlatform,abPS3Switch,auiController,auiKeyboard);
      }
      
      override public function clone() : Event
      {
         // method body index: 221 method index: 221
         return new PlatformRequestEvent(this._target);
      }
   }
}
