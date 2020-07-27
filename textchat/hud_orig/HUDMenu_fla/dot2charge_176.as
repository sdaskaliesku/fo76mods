 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2charge_176 extends MovieClip
   {
       
      
      public var Left:MovieClip;
      
      public function dot2charge_176()
      {
         // method body index: 1564 method index: 1564
         super();
         addFrameScript(0,this.frame1,13,this.frame14);
      }
      
      function frame1() : *
      {
         // method body index: 1562 method index: 1562
         stop();
      }
      
      function frame14() : *
      {
         // method body index: 1563 method index: 1563
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
