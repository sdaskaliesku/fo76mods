 
package
{
   public dynamic class XPMeterBar extends MeterBarWidget
   {
       
      
      public function XPMeterBar()
      {
         // method body index: 3397 method index: 3397
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3398 method index: 3398
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3399 method index: 3399
         gotoAndPlay("Flashing");
      }
   }
}
