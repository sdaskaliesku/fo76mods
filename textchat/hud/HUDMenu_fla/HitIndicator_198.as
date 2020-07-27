 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class HitIndicator_198 extends MovieClip
   {
       
      
      public function HitIndicator_198()
      {
         // method body index: 1048 method index: 1048
         super();
         addFrameScript(0,this.frame1,12,this.frame13);
      }
      
      function frame1() : *
      {
         // method body index: 1049 method index: 1049
         stop();
      }
      
      function frame13() : *
      {
         // method body index: 1050 method index: 1050
         this["onAnimationComplete"]();
      }
   }
}
