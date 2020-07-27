 
package
{
   import Shared.AS3.Events.CustomEvent;
   import flash.display.MovieClip;
   
   public dynamic class LevelUpClip extends MovieClip
   {
       
      
      public function LevelUpClip()
      {

         super();
      }
      
      public function AnimateText(aDisplayText:String) : *
      {

         dispatchEvent(new CustomEvent(HUDMenu.EVENT_LEVELUP_START,{"displayText":aDisplayText},true));
      }
   }
}
