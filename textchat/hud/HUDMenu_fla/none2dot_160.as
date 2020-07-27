 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class none2dot_160 extends MovieClip
   {
       
      
      public function none2dot_160()
      {
         // method body index: 1589 method index: 1589
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1590 method index: 1590
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1591 method index: 1591
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
