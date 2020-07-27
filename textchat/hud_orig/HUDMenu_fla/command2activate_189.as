 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class command2activate_189 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function command2activate_189()
      {
         // method body index: 1489 method index: 1489
         super();
         addFrameScript(0,this.frame1,9,this.frame10);
      }
      
      function frame1() : *
      {
         // method body index: 1487 method index: 1487
         stop();
      }
      
      function frame10() : *
      {
         // method body index: 1488 method index: 1488
         dispatchEvent(new Event("animationComplete"));
         stop();
      }
   }
}
