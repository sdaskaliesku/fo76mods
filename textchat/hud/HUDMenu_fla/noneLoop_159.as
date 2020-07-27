 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class noneLoop_159 extends MovieClip
   {
       
      
      public function noneLoop_159()
      {
         // method body index: 1594 method index: 1594
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      function frame1() : *
      {
         // method body index: 1595 method index: 1595
         stop();
      }
      
      function frame3() : *
      {
         // method body index: 1596 method index: 1596
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
