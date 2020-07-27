 
package
{
   public dynamic class CritMeterBar extends MeterBarWidget
   {
       
      
      public function CritMeterBar()
      {
         // method body index: 3371 method index: 3371
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3372 method index: 3372
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3373 method index: 3373
         gotoAndPlay("Flashing");
      }
   }
}
