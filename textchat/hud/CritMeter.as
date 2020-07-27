 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   
   public class CritMeter extends BSUIComponent
   {
       
      
      public var MeterBar_mc:MovieClip;
      
      public var DisplayText_mc:MovieClip;
      
      public var CritMeterStars_mc:MovieClip;
      
      public function CritMeter()
      {

         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      public function SetMeterPercent(param1:Number) : *
      {

         this.MeterBar_mc.Percent = param1 / 100;
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
