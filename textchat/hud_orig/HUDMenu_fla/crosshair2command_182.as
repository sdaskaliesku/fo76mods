 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class crosshair2command_182 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function crosshair2command_182()
      {
         // method body index: 1529 method index: 1529
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1527 method index: 1527
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1528 method index: 1528
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
