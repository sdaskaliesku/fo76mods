 
package
{
   public dynamic class RadsBar extends MeterBarWidget
   {
       
      
      public function RadsBar()
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
