 
package
{
   import flash.display.MovieClip;
   
   public dynamic class DirectionalHitIndicator extends MovieClip
   {
       
      
      public var Arc_mc:MovieClip;
      
      public function DirectionalHitIndicator()
      {
         // method body index: 787 method index: 787
         super();
         addFrameScript(1,this.frame2,3,this.frame4);
      }
      
      function frame2() : *
      {
         // method body index: 788 method index: 788
         stop();
      }
      
      function frame4() : *
      {
         // method body index: 789 method index: 789
         stop();
      }
   }
}
