 
package
{
   import Shared.AS3.Events.CustomEvent;
   import flash.display.MovieClip;
   
   public dynamic class LevelUpClip extends MovieClip
   {
       
      
      public function LevelUpClip()
      {
         // method body index: 2236 method index: 2236
         super();
      }
      
      public function AnimateText(aDisplayText:String) : *
      {
         // method body index: 2235 method index: 2235
         dispatchEvent(new CustomEvent(HUDMenu.EVENT_LEVELUP_START,{"displayText":aDisplayText},true));
      }
   }
}
