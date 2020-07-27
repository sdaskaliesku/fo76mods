 
package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class ActionPointMeter extends MovieClip
   {
       
      
      public var MeterBar_mc:MovieClip;
      
      public var Optional_mc:MovieClip;
      
      public var ActionPointSegments_mc:MovieClip;
      
      public var DisplayText_tf:TextField;
      
      public var DisplayText_mc:MovieClip;
      
      public var APBarFrame_mc:MovieClip;
      
      private var TotalBarWidth:Number;
      
      private const SegmentBorder:Number = 2.0;
      
      public function ActionPointMeter()
      {

         super();
         while(this.ActionPointSegments_mc.numChildren > 0)
         {
            this.ActionPointSegments_mc.removeChildAt(0);
         }
         this.TotalBarWidth = this.MeterBar_mc.width;
         this.DisplayText_tf = this.DisplayText_mc.DisplayText_tf;
         this.__setProp_Optional_mc_ActionPointMeter_Optional_mc_0();
         this.__setProp_MeterBar_mc_ActionPointMeter_MeterBar_mc_0();
      }
      
      public function AddSegments(aSegmentWidths:Array) : *
      {

         var newSegment:ActionPointBarSegment = null;
         var totalSegmentWidth:Number = NaN;
         while(this.ActionPointSegments_mc.numChildren > 0)
         {
            this.ActionPointSegments_mc.removeChildAt(0);
         }
         var segmentStartX:Number = 0;
         for(var i:uint = 0; i < aSegmentWidths.length; i++)
         {
            newSegment = new ActionPointBarSegment();
            totalSegmentWidth = aSegmentWidths[i] * this.TotalBarWidth;
            newSegment.width = totalSegmentWidth - 2 * this.SegmentBorder;
            newSegment.x = segmentStartX + this.SegmentBorder;
            this.ActionPointSegments_mc.addChild(newSegment);
            segmentStartX = segmentStartX + totalSegmentWidth;
         }
      }
      
      public function SetMeterPercent(afPercent:Number) : *
      {

         this.MeterBar_mc.Percent = afPercent / 100;
         this.OnMeterUpdated();
      }
      
      public function OnMeterUpdated() : *
      {

         this.ActionPointSegments_mc.x = -this.MeterBar_mc.width;
      }
      
      function __setProp_Optional_mc_ActionPointMeter_Optional_mc_0() : *
      {

         try
         {
            this.Optional_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.Optional_mc.BarAlpha = 1;
         this.Optional_mc.bracketCornerLength = 6;
         this.Optional_mc.bracketLineWidth = 1.5;
         this.Optional_mc.bracketPaddingX = 0;
         this.Optional_mc.bracketPaddingY = 0;
         this.Optional_mc.BracketStyle = "horizontal";
         this.Optional_mc.bShowBrackets = false;
         this.Optional_mc.bUseShadedBackground = false;
         this.Optional_mc.Justification = "left";
         this.Optional_mc.Percent = 0;
         this.Optional_mc.ShadedBackgroundMethod = "Shader";
         this.Optional_mc.ShadedBackgroundType = "normal";
         try
         {
            this.Optional_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_MeterBar_mc_ActionPointMeter_MeterBar_mc_0() : *
      {

         try
         {
            this.MeterBar_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.MeterBar_mc.BarAlpha = 1;
         this.MeterBar_mc.bracketCornerLength = 6;
         this.MeterBar_mc.bracketLineWidth = 1.5;
         this.MeterBar_mc.bracketPaddingX = 0;
         this.MeterBar_mc.bracketPaddingY = 0;
         this.MeterBar_mc.BracketStyle = "horizontal";
         this.MeterBar_mc.bShowBrackets = false;
         this.MeterBar_mc.bUseShadedBackground = false;
         this.MeterBar_mc.Justification = "right";
         this.MeterBar_mc.Percent = 1;
         this.MeterBar_mc.ShadedBackgroundMethod = "Shader";
         this.MeterBar_mc.ShadedBackgroundType = "normal";
         try
         {
            this.MeterBar_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
