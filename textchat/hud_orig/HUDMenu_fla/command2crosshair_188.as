 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class command2crosshair_188 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function command2crosshair_188()
      {
         // method body index: 1494 method index: 1494
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1492 method index: 1492
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1493 method index: 1493
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
