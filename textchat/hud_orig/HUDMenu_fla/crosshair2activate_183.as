 
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
         // method body index: 1524 method index: 1524
         super();
         addFrameScript(0,this.frame1,11,this.frame12);
      }
      
      function frame1() : *
      {
         // method body index: 1522 method index: 1522
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1523 method index: 1523
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
