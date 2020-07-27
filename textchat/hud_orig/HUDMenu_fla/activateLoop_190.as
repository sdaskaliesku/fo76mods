 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activateLoop_190 extends MovieClip
   {
       
      
      public function activateLoop_190()
      {
         // method body index: 1480 method index: 1480
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      function frame1() : *
      {
         // method body index: 1478 method index: 1478
         stop();
      }
      
      function frame4() : *
      {
         // method body index: 1479 method index: 1479
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
