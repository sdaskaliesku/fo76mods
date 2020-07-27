 
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
         // method body index: 1453 method index: 1453
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1454 method index: 1454
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1455 method index: 1455
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
