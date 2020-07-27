 
package
{
   public dynamic class XPMeterBar extends MeterBarWidget
   {
       
      
      public function XPMeterBar()
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
