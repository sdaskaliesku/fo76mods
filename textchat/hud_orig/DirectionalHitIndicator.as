 
package
{
   import flash.display.MovieClip;
   
   public dynamic class DirectionalHitIndicator extends MovieClip
   {
       
      
      public var Arc_mc:MovieClip;
      
      public function DirectionalHitIndicator()
      {

         super();
         addFrameScript(1,this.frame2,3,this.frame4);
      }
      
      function frame2() : *
      {

         stop();
      }
      
      function frame4() : *
      {

         stop();
      }
   }
}
