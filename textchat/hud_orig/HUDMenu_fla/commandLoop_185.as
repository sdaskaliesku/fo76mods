 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class commandLoop_185 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function commandLoop_185()
      {
         // method body index: 1509 method index: 1509
         super();
         addFrameScript(0,this.frame1,12,this.frame13);
      }
      
      function frame1() : *
      {
         // method body index: 1507 method index: 1507
         stop();
      }
      
      function frame13() : *
      {
         // method body index: 1508 method index: 1508
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
