 
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
         // method body index: 708 method index: 708
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
      
      public function AddSegments(param1:Array) : *
      {
         // method body index: 709 method index: 709
         var _loc2_:ActionPointBarSegment = null;
         var _loc3_:Number = NaN;
         while(this.ActionPointSegments_mc.numChildren > 0)
         {
            this.ActionPointSegments_mc.removeChildAt(0);
         }
         var _loc4_:Number = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = new ActionPointBarSegment();
            _loc3_ = param1[_loc5_] * this.TotalBarWidth;
            _loc2_.width = _loc3_ - 2 * this.SegmentBorder;
            _loc2_.x = _loc4_ + this.SegmentBorder;
            this.ActionPointSegments_mc.addChild(_loc2_);
            _loc4_ = _loc4_ + _loc3_;
            _loc5_++;
         }
      }
      
      public function SetMeterPercent(param1:Number) : *
      {
         // method body index: 710 method index: 710
         this.MeterBar_mc.Percent = param1 / 100;
         this.OnMeterUpdated();
      }
      
      public function OnMeterUpdated() : *
      {
         // method body index: 711 method index: 711
         this.ActionPointSegments_mc.x = -this.MeterBar_mc.width;
      }
      
      function __setProp_Optional_mc_ActionPointMeter_Optional_mc_0() : *
      {
         // method body index: 712 method index: 712
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
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_MeterBar_mc_ActionPointMeter_MeterBar_mc_0() : *
      {
         // method body index: 713 method index: 713
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
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
