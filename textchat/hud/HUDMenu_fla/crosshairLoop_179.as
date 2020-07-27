 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class crosshairLoop_179 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function crosshairLoop_179()
      {
         // method body index: 1468 method index: 1468
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      function frame1() : *
      {
         // method body index: 1469 method index: 1469
         stop();
      }
      
      function frame4() : *
      {
         // method body index: 1470 method index: 1470
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
