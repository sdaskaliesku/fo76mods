 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2dot_192 extends MovieClip
   {
       
      
      public function activate2dot_192()
      {
         // method body index: 1470 method index: 1470
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         // method body index: 1468 method index: 1468
         stop();
      }
      
      function frame7() : *
      {
         // method body index: 1469 method index: 1469
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
