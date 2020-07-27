 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2activate_178 extends MovieClip
   {
       
      
      public function dot2activate_178()
      {
         // method body index: 1483 method index: 1483
         super();
         addFrameScript(0,this.frame1,7,this.frame8);
      }
      
      function frame1() : *
      {
         // method body index: 1484 method index: 1484
         stop();
      }
      
      function frame8() : *
      {
         // method body index: 1485 method index: 1485
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
