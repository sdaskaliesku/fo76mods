 
package
{
   public dynamic class CritMeterBar extends MeterBarWidget
   {
       
      
      public function CritMeterBar()
      {
         // method body index: 3394 method index: 3394
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3392 method index: 3392
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3393 method index: 3393
         gotoAndPlay("Flashing");
      }
   }
}
