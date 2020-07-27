 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activateLoop_190 extends MovieClip
   {
       
      
      public function activateLoop_190()
      {

         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame4() : *
      {

         dispatchEvent(new Event("animationComplete"));
      }
   }
}
