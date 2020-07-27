 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2charge_176 extends MovieClip
   {
       
      
      public var Left:MovieClip;
      
      public function dot2charge_176()
      {
         // method body index: 1488 method index: 1488
         super();
         addFrameScript(0,this.frame1,13,this.frame14);
      }
      
      function frame1() : *
      {
         // method body index: 1489 method index: 1489
         stop();
      }
      
      function frame14() : *
      {
         // method body index: 1490 method index: 1490
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
