 
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
         // method body index: 1569 method index: 1569
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1567 method index: 1567
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1568 method index: 1568
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
