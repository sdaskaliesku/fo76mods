 
package HUDMenu_fla
{
   import Shared.AS3.BSButtonHintBar;
   import flash.display.MovieClip;
   
   public dynamic class RevivePrompt_253 extends MovieClip
   {
       
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var reviveTimer:MovieClip;
      
      public var reviveTitle:MovieClip;
      
      public function RevivePrompt_253()
      {

         super();
         addFrameScript(0,this.frame1,99,this.frame100);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame100() : *
      {

         gotoAndPlay("idle");
      }
   }
}
