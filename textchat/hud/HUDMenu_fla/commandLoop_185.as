 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class commandLoop_185 extends MovieClip
   {
       
      
      public var Down:MovieClip;
      
      public var Left:MovieClip;
      
      public var Right:MovieClip;
      
      public var Up:MovieClip;
      
      public function commandLoop_185()
      {

         super();
         addFrameScript(0,this.frame1,12,this.frame13);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame13() : *
      {

         dispatchEvent(new Event("animationComplete"));
      }
   }
}
