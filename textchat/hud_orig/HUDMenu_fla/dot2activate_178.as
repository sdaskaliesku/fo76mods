 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2activate_178 extends MovieClip
   {
       
      
      public function dot2activate_178()
      {
         // method body index: 1559 method index: 1559
         super();
         addFrameScript(0,this.frame1,7,this.frame8);
      }
      
      function frame1() : *
      {
         // method body index: 1557 method index: 1557
         stop();
      }
      
      function frame8() : *
      {
         // method body index: 1558 method index: 1558
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
