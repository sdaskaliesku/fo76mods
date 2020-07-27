 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2none_172 extends MovieClip
   {
       
      
      public function dot2none_172()
      {
         // method body index: 1503 method index: 1503
         super();
         addFrameScript(0,this.frame1,7,this.frame8);
      }
      
      function frame1() : *
      {
         // method body index: 1504 method index: 1504
         stop();
      }
      
      function frame8() : *
      {
         // method body index: 1505 method index: 1505
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
