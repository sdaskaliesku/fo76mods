 
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
         // method body index: 1316 method index: 1316
         super();
         addFrameScript(0,this.frame1,99,this.frame100);
      }
      
      function frame1() : *
      {
         // method body index: 1317 method index: 1317
         stop();
      }
      
      function frame100() : *
      {
         // method body index: 1318 method index: 1318
         gotoAndPlay("idle");
      }
   }
}
