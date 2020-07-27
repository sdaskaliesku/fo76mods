 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class activate2none_191 extends MovieClip
   {
       
      
      public function activate2none_191()
      {
         // method body index: 1399 method index: 1399
         super();
         addFrameScript(0,this.frame1,7,this.frame8);
      }
      
      function frame1() : *
      {
         // method body index: 1400 method index: 1400
         stop();
      }
      
      function frame8() : *
      {
         // method body index: 1401 method index: 1401
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
