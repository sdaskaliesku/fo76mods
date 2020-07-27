 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2charge_176 extends MovieClip
   {
       
      
      public var Left:MovieClip;
      
      public function dot2charge_176()
      {

         super();
         addFrameScript(0,this.frame1,13,this.frame14);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame14() : *
      {

         dispatchEvent(new Event("animationComplete"));
      }
   }
}
