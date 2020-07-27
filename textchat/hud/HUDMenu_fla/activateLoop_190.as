 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activateLoop_190 extends MovieClip
   {
       
      
      public function activateLoop_190()
      {
         // method body index: 1404 method index: 1404
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      function frame1() : *
      {
         // method body index: 1405 method index: 1405
         stop();
      }
      
      function frame4() : *
      {
         // method body index: 1406 method index: 1406
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
