 
package
{
   public dynamic class XPMeterBar extends MeterBarWidget
   {
       
      
      public function XPMeterBar()
      {
         // method body index: 3420 method index: 3420
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3418 method index: 3418
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3419 method index: 3419
         gotoAndPlay("Flashing");
      }
   }
}
