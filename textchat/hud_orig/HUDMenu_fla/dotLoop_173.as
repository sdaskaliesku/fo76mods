 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dotLoop_173 extends MovieClip
   {
       
      
      public function dotLoop_173()
      {
         // method body index: 1584 method index: 1584
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      function frame1() : *
      {
         // method body index: 1582 method index: 1582
         stop();
      }
      
      function frame4() : *
      {
         // method body index: 1583 method index: 1583
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
