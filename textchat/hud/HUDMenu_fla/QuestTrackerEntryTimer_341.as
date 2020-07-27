 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class QuestTrackerEntryTimer_341 extends MovieClip
   {
       
      
      public var Sizer_mc:MovieClip;
      
      public var Text_mc:MovieClip;
      
      public function QuestTrackerEntryTimer_341()
      {

         super();
         addFrameScript(0,this.frame1,35,this.frame36);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame36() : *
      {

         gotoAndPlay("warning");
      }
   }
}
