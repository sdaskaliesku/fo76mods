 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class crosshair2activate_183 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function crosshair2activate_183()
      {
         // method body index: 1448 method index: 1448
         super();
         addFrameScript(0,this.frame1,11,this.frame12);
      }
      
      function frame1() : *
      {
         // method body index: 1449 method index: 1449
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1450 method index: 1450
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
