 
package Shared.AS3.Events
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PlatformRequestEvent extends Event
   {
      
      public static const PLATFORM_REQUEST:String = // method body index: 400 method index: 400
      "GetPlatform";
       
      
      var _target:MovieClip;
      
      public function PlatformRequestEvent(aTarget:MovieClip)
      {

         super(PLATFORM_REQUEST);
         this._target = aTarget;
      }
      
      public function RespondToRequest(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : *
      {

         this._target.SetPlatform(auiPlatform,abPS3Switch,auiController,auiKeyboard);
      }
      
      override public function clone() : Event
      {

         return new PlatformRequestEvent(this._target);
      }
   }
}
