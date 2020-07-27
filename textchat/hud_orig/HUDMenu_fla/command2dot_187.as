 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class command2dot_187 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function command2dot_187()
      {
         // method body index: 1499 method index: 1499
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1497 method index: 1497
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1498 method index: 1498
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
