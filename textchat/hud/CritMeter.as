 
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
         // method body index: 2803 method index: 2803
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      public function SetMeterPercent(param1:Number) : *
      {
         // method body index: 2804 method index: 2804
         this.MeterBar_mc.Percent = param1 / 100;
      }
      
      function frame1() : *
      {
         // method body index: 2805 method index: 2805
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 2806 method index: 2806
         gotoAndPlay("Flashing");
      }
   }
}
