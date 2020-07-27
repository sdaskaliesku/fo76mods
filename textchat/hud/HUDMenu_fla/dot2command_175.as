 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2command_175 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function dot2command_175()
      {
         // method body index: 1493 method index: 1493
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1494 method index: 1494
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1495 method index: 1495
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
