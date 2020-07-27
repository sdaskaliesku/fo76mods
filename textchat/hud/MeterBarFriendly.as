 
package
{
   public dynamic class MeterBarFriendly extends MeterBarWidget
   {
       
      
      public function MeterBarFriendly()
      {
         // method body index: 3388 method index: 3388
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      function frame1() : *
      {
         // method body index: 3389 method index: 3389
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3390 method index: 3390
         gotoAndPlay("Flashing");
      }
   }
}
