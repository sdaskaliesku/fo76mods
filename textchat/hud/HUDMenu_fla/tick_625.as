 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class tick_625 extends MovieClip
   {
       
      
      public function tick_625()
      {

         super();
         addFrameScript(0,this.frame1,41,this.frame42);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame42() : *
      {

         gotoAndPlay("Pulse");
      }
   }
}
