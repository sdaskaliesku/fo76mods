 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class dot2crosshair_174 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function dot2crosshair_174()
      {
         // method body index: 1498 method index: 1498
         super();
         addFrameScript(0,this.frame1,7,this.frame8);
      }
      
      function frame1() : *
      {
         // method body index: 1499 method index: 1499
         stop();
      }
      
      function frame8() : *
      {
         // method body index: 1500 method index: 1500
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
