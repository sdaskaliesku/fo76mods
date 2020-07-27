 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2crosshair_193 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function activate2crosshair_193()
      {
         // method body index: 1465 method index: 1465
         super();
         addFrameScript(0,this.frame1,11,this.frame12);
      }
      
      function frame1() : *
      {
         // method body index: 1463 method index: 1463
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1464 method index: 1464
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
