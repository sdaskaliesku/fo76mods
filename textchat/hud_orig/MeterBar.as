 
package
{
   public dynamic class MeterBar extends MeterBarWidget
   {
       
      
      public function MeterBar()
      {

         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {

         stop();
      }
   }
}
