 
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
         // method body index: 1418 method index: 1418
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1419 method index: 1419
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1420 method index: 1420
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
