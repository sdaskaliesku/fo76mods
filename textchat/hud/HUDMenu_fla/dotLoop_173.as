 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dotLoop_173 extends MovieClip
   {
       
      
      public function dotLoop_173()
      {
         // method body index: 1508 method index: 1508
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      function frame1() : *
      {
         // method body index: 1509 method index: 1509
         stop();
      }
      
      function frame4() : *
      {
         // method body index: 1510 method index: 1510
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
