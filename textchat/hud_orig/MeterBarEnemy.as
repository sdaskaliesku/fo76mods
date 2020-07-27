 
package
{
   public dynamic class MeterBarEnemy extends MeterBarWidget
   {
       
      
      public function MeterBarEnemy()
      {
         // method body index: 3406 method index: 3406
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3404 method index: 3404
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3405 method index: 3405
         gotoAndPlay("Flashing");
      }
   }
}
