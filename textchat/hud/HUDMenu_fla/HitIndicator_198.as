 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class HitIndicator_198 extends MovieClip
   {
       
      
      public function HitIndicator_198()
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

         this["onAnimationComplete"]();
      }
   }
}
