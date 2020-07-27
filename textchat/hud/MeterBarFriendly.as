 
package
{
   public dynamic class MeterBarFriendly extends MeterBarWidget
   {
       
      
      public function MeterBarFriendly()
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
