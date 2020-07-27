 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class QuestTrackerAlertInternal_357 extends MovieClip
   {
       
      
      public var AlertText_mc:MovieClip;
      
      public var Backer_mc:MovieClip;
      
      public function QuestTrackerAlertInternal_357()
      {

         super();
         addFrameScript(0,this.frame1,5,this.frame6,34,this.frame35,63,this.frame64);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame6() : *
      {

         stop();
      }
      
      function frame35() : *
      {

         gotoAndPlay("AlertState2");
      }
      
      function frame64() : *
      {

         gotoAndPlay("AlertState3");
      }
   }
}
