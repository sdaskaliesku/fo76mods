 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class command2none_186 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function command2none_186()
      {
         // method body index: 1428 method index: 1428
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1429 method index: 1429
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1430 method index: 1430
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
