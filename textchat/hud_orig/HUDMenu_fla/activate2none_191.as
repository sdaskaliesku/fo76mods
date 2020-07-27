 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2none_191 extends MovieClip
   {
       
      
      public function activate2none_191()
      {
         // method body index: 1475 method index: 1475
         super();
         addFrameScript(0,this.frame1,7,this.frame8);
      }
      
      function frame1() : *
      {
         // method body index: 1473 method index: 1473
         stop();
      }
      
      function frame8() : *
      {
         // method body index: 1474 method index: 1474
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
