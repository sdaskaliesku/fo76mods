 
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
         // method body index: 2868 method index: 2868
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      public function SetMeterPercent(afPercent:Number) : *
      {
         // method body index: 2865 method index: 2865
         this.MeterBar_mc.Percent = afPercent / 100;
      }
      
      function frame1() : *
      {
         // method body index: 2866 method index: 2866
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 2867 method index: 2867
         gotoAndPlay("Flashing");
      }
   }
}
