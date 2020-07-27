 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2none_191 extends MovieClip
   {
       
      
      public function activate2none_191()
      {

         super();
         addFrameScript(0,this.frame1,7,this.frame8);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame8() : *
      {

         dispatchEvent(new Event("animationComplete"));
      }
   }
}
