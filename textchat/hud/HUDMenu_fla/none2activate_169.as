 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class none2activate_169 extends MovieClip
   {
       
      
      public function none2activate_169()
      {
         // method body index: 1574 method index: 1574
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1575 method index: 1575
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1576 method index: 1576
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
