 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class QuestTrackerAlertInternal_357 extends MovieClip
   {
       
      
      public var AlertText_mc:MovieClip;
      
      public var Backer_mc:MovieClip;
      
      public function QuestTrackerAlertInternal_357()
      {
         // method body index: 1329 method index: 1329
         super();
         addFrameScript(0,this.frame1,5,this.frame6,34,this.frame35,63,this.frame64);
      }
      
      function frame1() : *
      {
         // method body index: 1325 method index: 1325
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1326 method index: 1326
         stop();
      }
      
      function frame35() : *
      {
         // method body index: 1327 method index: 1327
         gotoAndPlay("AlertState2");
      }
      
      function frame64() : *
      {
         // method body index: 1328 method index: 1328
         gotoAndPlay("AlertState3");
      }
   }
}
