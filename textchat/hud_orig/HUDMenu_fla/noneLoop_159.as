 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class noneLoop_159 extends MovieClip
   {
       
      
      public function noneLoop_159()
      {

         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame3() : *
      {

         dispatchEvent(new Event("animationComplete"));
      }
   }
}
