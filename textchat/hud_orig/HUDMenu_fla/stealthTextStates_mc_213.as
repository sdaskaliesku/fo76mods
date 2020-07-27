 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class stealthTextStates_mc_213 extends MovieClip
   {
       
      
      public var stealthTextAnimStates:MovieClip;
      
      public function stealthTextStates_mc_213()
      {
         // method body index: 1927 method index: 1927
         super();
         addFrameScript(5,this.frame6,11,this.frame12,72,this.frame73,103,this.frame104);
      }
      
      function frame6() : *
      {
         // method body index: 1923 method index: 1923
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1924 method index: 1924
         stop();
      }
      
      function frame73() : *
      {
         // method body index: 1925 method index: 1925
         gotoAndPlay("caution");
      }
      
      function frame104() : *
      {
         // method body index: 1926 method index: 1926
         gotoAndPlay("danger");
      }
   }
}
