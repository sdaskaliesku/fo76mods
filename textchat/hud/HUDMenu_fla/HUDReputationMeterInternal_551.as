 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class HUDReputationMeterInternal_551 extends MovieClip
   {
       
      
      public var FactionIcon_mc:MovieClip;
      
      public var Header_mc:MovieClip;
      
      public var LeftStatusIcon_mc:MovieClip;
      
      public var LeftStatusText_mc:MovieClip;
      
      public var Meter_mc:MovieClip;
      
      public var RightStatusIcon_mc:MovieClip;
      
      public var RightStatusText_mc:MovieClip;
      
      public var UpwardIndicator_mc:MovieClip;
      
      public function HUDReputationMeterInternal_551()
      {

         super();
         this.__setProp_Meter_mc_HUDReputationMeterInternal_Meter_mc_0();
      }
      
      function __setProp_Meter_mc_HUDReputationMeterInternal_Meter_mc_0() : *
      {

         try
         {
            this.Meter_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.Meter_mc.BarAlpha = 0.5;
         this.Meter_mc.bracketCornerLength = 6;
         this.Meter_mc.bracketLineWidth = 1.5;
         this.Meter_mc.bracketPaddingX = 0;
         this.Meter_mc.bracketPaddingY = 0;
         this.Meter_mc.BracketStyle = "horizontal";
         this.Meter_mc.bShowBrackets = false;
         this.Meter_mc.bUseShadedBackground = false;
         this.Meter_mc.Justification = "left";
         this.Meter_mc.Percent = 0;
         this.Meter_mc.ShadedBackgroundMethod = "Shader";
         this.Meter_mc.ShadedBackgroundType = "normal";
         try
         {
            this.Meter_mc["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
