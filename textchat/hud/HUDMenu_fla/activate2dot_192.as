 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2dot_192 extends MovieClip
   {
       
      
      public function activate2dot_192()
      {
         // method body index: 1394 method index: 1394
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1395 method index: 1395
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1396 method index: 1396
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
