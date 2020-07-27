 
package
{
   import Shared.AS3.Events.CustomEvent;
   import flash.display.MovieClip;
   
   public dynamic class LevelUpClip extends MovieClip
   {
       
      
      public function LevelUpClip()
      {
         // method body index: 2161 method index: 2161
         super();
      }
      
      public function AnimateText(param1:String) : *
      {
         // method body index: 2162 method index: 2162
         dispatchEvent(new CustomEvent(HUDMenu.EVENT_LEVELUP_START,{"displayText":param1},true));
      }
   }
}
