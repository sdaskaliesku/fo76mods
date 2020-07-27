 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class crosshair2dot_181 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function crosshair2dot_181()
      {
         // method body index: 1458 method index: 1458
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1459 method index: 1459
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1460 method index: 1460
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
