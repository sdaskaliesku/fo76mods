 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class crosshair2none_180 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function crosshair2none_180()
      {
         // method body index: 1539 method index: 1539
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1537 method index: 1537
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1538 method index: 1538
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
