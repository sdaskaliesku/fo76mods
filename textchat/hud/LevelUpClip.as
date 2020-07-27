 
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
      
      public function AnimateText(param1:String) : *
      {

         dispatchEvent(new CustomEvent(HUDMenu.EVENT_LEVELUP_START,{"displayText":param1},true));
      }
   }
}
