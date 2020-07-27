 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class HitIndicator_198 extends MovieClip
   {
       
      
      public function HitIndicator_198()
      {
         // method body index: 1124 method index: 1124
         super();
         addFrameScript(0,this.frame1,12,this.frame13);
      }
      
      function frame1() : *
      {
         // method body index: 1122 method index: 1122
         stop();
      }
      
      function frame13() : *
      {
         // method body index: 1123 method index: 1123
         this["onAnimationComplete"]();
      }
   }
}
