 
package
{
   public dynamic class MeterBarEnemy extends MeterBarWidget
   {
       
      
      public function MeterBarEnemy()
      {

         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame16() : *
      {

         gotoAndPlay("Flashing");
      }
   }
}
