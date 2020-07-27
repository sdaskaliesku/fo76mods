 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class noneLoop_159 extends MovieClip
   {
       
      
      public function noneLoop_159()
      {
         // method body index: 1670 method index: 1670
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      function frame1() : *
      {
         // method body index: 1668 method index: 1668
         stop();
      }
      
      function frame3() : *
      {
         // method body index: 1669 method index: 1669
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
