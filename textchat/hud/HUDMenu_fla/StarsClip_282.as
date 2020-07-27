 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class StarsClip_282 extends MovieClip
   {
       
      
      public var Container:MovieClip;
      
      public function StarsClip_282()
      {

         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {

         this.Container.gotoAndStop(int(Math.random() * 11));
         this.scaleY = this.scaleX = Math.random() / 5 + 0.01;
         this.x = 0 + Math.random() * 300;
         this.y = 20 + Math.random() * 20;
         this.gotoAndPlay(int(Math.random() * 40));
      }
   }
}
