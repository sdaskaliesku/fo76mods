 
package
{
   import flash.display.MovieClip;
   
   public dynamic class PerkCardClip extends MovieClip
   {
       
      
      public var PerkCardAnim_mc:MovieClip;
      
      public function PerkCardClip()
      {

         super();
         addFrameScript(0,this.frame1,14,this.frame15,22,this.frame23);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame15() : *
      {

         stop();
      }
      
      function frame23() : *
      {

         stop();
      }
   }
}
