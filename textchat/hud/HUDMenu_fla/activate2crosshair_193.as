 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2crosshair_193 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function activate2crosshair_193()
      {
         // method body index: 1389 method index: 1389
         super();
         addFrameScript(0,this.frame1,11,this.frame12);
      }
      
      function frame1() : *
      {
         // method body index: 1390 method index: 1390
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1391 method index: 1391
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
