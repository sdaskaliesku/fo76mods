 
package
{
   public dynamic class MeterBarFriendly extends MeterBarWidget
   {
       
      
      public function MeterBarFriendly()
      {
         // method body index: 3411 method index: 3411
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3409 method index: 3409
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3410 method index: 3410
         gotoAndPlay("Flashing");
      }
   }
}
