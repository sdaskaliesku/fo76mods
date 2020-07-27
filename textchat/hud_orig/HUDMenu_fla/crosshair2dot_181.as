 
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
         // method body index: 1534 method index: 1534
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1532 method index: 1532
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1533 method index: 1533
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
