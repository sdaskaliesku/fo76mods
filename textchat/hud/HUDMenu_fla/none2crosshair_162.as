 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class none2crosshair_162 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function none2crosshair_162()
      {
         // method body index: 1584 method index: 1584
         super();
         addFrameScript(0,this.frame1,5,this.frame6);
      }
      
      function frame1() : *
      {
         // method body index: 1585 method index: 1585
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1586 method index: 1586
         dispatchEvent(new Event("animationComplete"));
      }
   }
}
