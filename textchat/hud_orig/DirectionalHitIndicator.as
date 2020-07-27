 
package
{
   import flash.display.MovieClip;
   
   public dynamic class DirectionalHitIndicator extends MovieClip
   {
       
      
      public var Arc_mc:MovieClip;
      
      public function DirectionalHitIndicator()
      {
         // method body index: 863 method index: 863
         super();
         addFrameScript(1,this.frame2,3,this.frame4);
      }
      
      function frame2() : *
      {
         // method body index: 861 method index: 861
         stop();
      }
      
      function frame4() : *
      {
         // method body index: 862 method index: 862
         stop();
      }
   }
}
