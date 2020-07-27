 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class stealthTextStates_mc_213 extends MovieClip
   {
       
      
      public var stealthTextAnimStates:MovieClip;
      
      public function stealthTextStates_mc_213()
      {

         super();
         addFrameScript(5,this.frame6,11,this.frame12,72,this.frame73,103,this.frame104);
      }
      
      function frame6() : *
      {

         stop();
      }
      
      function frame12() : *
      {

         stop();
      }
      
      function frame73() : *
      {

         gotoAndPlay("caution");
      }
      
      function frame104() : *
      {

         gotoAndPlay("danger");
      }
   }
}
