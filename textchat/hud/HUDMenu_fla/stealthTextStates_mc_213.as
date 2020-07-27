 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class stealthTextStates_mc_213 extends MovieClip
   {
       
      
      public var stealthTextAnimStates:MovieClip;
      
      public function stealthTextStates_mc_213()
      {
         // method body index: 1849 method index: 1849
         super();
         addFrameScript(5,this.frame6,11,this.frame12,72,this.frame73,103,this.frame104);
      }
      
      function frame6() : *
      {
         // method body index: 1850 method index: 1850
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1851 method index: 1851
         stop();
      }
      
      function frame73() : *
      {
         // method body index: 1852 method index: 1852
         gotoAndPlay("caution");
      }
      
      function frame104() : *
      {
         // method body index: 1853 method index: 1853
         gotoAndPlay("danger");
      }
   }
}
