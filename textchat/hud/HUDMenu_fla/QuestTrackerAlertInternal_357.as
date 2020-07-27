 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class QuestTrackerAlertInternal_357 extends MovieClip
   {
       
      
      public var AlertText_mc:MovieClip;
      
      public var Backer_mc:MovieClip;
      
      public function QuestTrackerAlertInternal_357()
      {
         // method body index: 1251 method index: 1251
         super();
         addFrameScript(0,this.frame1,5,this.frame6,34,this.frame35,63,this.frame64);
      }
      
      function frame1() : *
      {
         // method body index: 1252 method index: 1252
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1253 method index: 1253
         stop();
      }
      
      function frame35() : *
      {
         // method body index: 1254 method index: 1254
         gotoAndPlay("AlertState2");
      }
      
      function frame64() : *
      {
         // method body index: 1255 method index: 1255
         gotoAndPlay("AlertState3");
      }
   }
}
