 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2command_194 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function activate2command_194()
      {
         // method body index: 1460 method index: 1460
         super();
         addFrameScript(0,this.frame1,9,this.frame10);
      }
      
      function frame1() : *
      {
         // method body index: 1458 method index: 1458
         stop();
      }
      
      function frame10() : *
      {
         // method body index: 1459 method index: 1459
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
