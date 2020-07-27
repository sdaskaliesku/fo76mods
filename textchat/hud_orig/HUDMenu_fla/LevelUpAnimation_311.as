 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class LevelUpAnimation_311 extends MovieClip
   {
       
      
      public var LevelUpText:MovieClip;
      
      public function LevelUpAnimation_311()
      {
         // method body index: 1133 method index: 1133
         super();
         addFrameScript(0,this.frame1,19,this.frame20);
      }
      
      function frame1() : *
      {
         // method body index: 1131 method index: 1131
         dispatchEvent(new Event("HUD::LevelUpHidden",true));
         stop();
      }
      
      function frame20() : *
      {
         // method body index: 1132 method index: 1132
         dispatchEvent(new Event("HUD::LevelUpVisible",true));
      }
   }
}
