 
package
{
   public dynamic class MeterBarEnemy extends MeterBarWidget
   {
       
      
      public function MeterBarEnemy()
      {
         // method body index: 3383 method index: 3383
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3384 method index: 3384
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3385 method index: 3385
         gotoAndPlay("Flashing");
      }
   }
}
