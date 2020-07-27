 
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
         // method body index: 1423 method index: 1423
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1424 method index: 1424
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1425 method index: 1425
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
