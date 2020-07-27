 
package
{
   import Shared.AS3.Factions;
   import Shared.GlobalFunc;
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.None;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextLineMetrics;
   import flash.utils.setTimeout;
   
   public class HUDReputationUpdateMeter extends MovieClip
   {
      
      public static const TIME_PER_VALUE:Number = // method body index: 2101 method index: 2101
      200;
      
      public static const MAX_TIME_CAP:Number = // method body index: 2101 method index: 2101
      3000;
      
      public static const HOLD_TIME:Number = // method body index: 2101 method index: 2101
      2000;
      
      public static const DISPLAY_COMPLETE:String = // method body index: 2101 method index: 2101
      "Reputation::DisplayComplete";
      
      public static const FADEOUT_COMPLETE:String = // method body index: 2101 method index: 2101
      "Reputation::FadeOutEnd";
      
      public static const HEADER_ICON_SPACING:Number = // method body index: 2101 method index: 2101
      6;
       
      
      public var Internal_mc:MovieClip;
      
      public var Header_mc:MovieClip;
      
      public var FactionIcon_mc:MovieClip;
      
      public var Meter_mc:MovieClip;
      
      public var MeterShadow_mc:MovieClip;
      
      public var LeftStatusIcon_mc:MovieClip;
      
      public var RightStatusIcon_mc:MovieClip;
      
      public var CurrentStanding_mc:MovieClip;
      
      private var m_MeterTween:Tween = null;
      
      private var m_Data:Object;
      
      private var m_MeterPercent:Number = 0.0;
      
      private var m_MeterFrames:Number = 100;
      
      public function HUDReputationUpdateMeter()
      {

         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11);
         this.Header_mc = this.Internal_mc.Header_mc;
         this.FactionIcon_mc = this.Internal_mc.FactionIcon_mc;
         this.Meter_mc = this.Internal_mc.MeterContainer_mc.Meter_mc;
         this.MeterShadow_mc = this.Internal_mc.MeterShadow_mc;
         this.LeftStatusIcon_mc = this.Internal_mc.LeftStatusIcon_mc;
         this.RightStatusIcon_mc = this.Internal_mc.RightStatusIcon_mc;
         this.CurrentStanding_mc = this.Internal_mc.CurrentStanding_mc;
         this.m_MeterFrames = this.Meter_mc.totalFrames;
      }
      
      public function set data(param1:Object) : void
      {

         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this.m_Data = param1;
         this.Header_mc.Header_tf.text = GlobalFunc.LocalizeFormattedString(param1.factionName + "Reputation").toUpperCase();
         var _loc6_:TextLineMetrics = this.Header_mc.Header_tf.getLineMetrics(0);
         this.FactionIcon_mc.x = this.Header_mc.x + (this.Header_mc.Header_tf.width - _loc6_.width) / 2 - this.FactionIcon_mc.width / 2 - HEADER_ICON_SPACING;
         this.FactionIcon_mc.gotoAndStop(param1.factionCode);
         if(param1.tierStart != param1.tierEnd)
         {
            _loc3_ = {
               "code":param1.factionCode.toLowerCase(),
               "tier":param1.tierEnd
            };
            _loc2_ = _loc3_;
         }
         else
         {
            _loc2_ = {
               "code":param1.factionCode.toUpperCase(),
               "tier":param1.tierStart
            };
            _loc3_ = {
               "code":param1.factionCode.toUpperCase(),
               "tier":param1.tierStart + 1
            };
         }
         Factions.updateFaceIcon(this.LeftStatusIcon_mc,_loc2_);
         Factions.updateFaceIcon(this.RightStatusIcon_mc,_loc3_);
         this.CurrentStanding_mc.CurrentStanding_tf.text = GlobalFunc.LocalizeFormattedString("$ReputationCurrentStanding","$ReputationStatus" + _loc2_.tier);
         if(param1.tierStart == param1.tierEnd)
         {
            _loc4_ = Math.abs(param1.percentEnd - param1.percentStart) * 100 * TIME_PER_VALUE;
            _loc5_ = Math.min(MAX_TIME_CAP,_loc4_);
            this.tweenMeter(param1.percentStart,param1.percentEnd,_loc5_);
         }
         else
         {
            this.tweenMeter(param1.percentStart,param1.percentEnd,0);
         }
      }
      
      public function get data() : Object
      {

         return this.m_Data;
      }
      
      public function set meterPercent(param1:Number) : void
      {

         this.m_MeterPercent = param1;
         this.Meter_mc.gotoAndStop(GlobalFunc.Clamp(Math.ceil(param1 * this.m_MeterFrames),1,this.m_MeterFrames));
      }
      
      public function get meterPercent() : Number
      {

         return this.m_MeterPercent;
      }
      
      private function tweenMeter(param1:Number, param2:Number, param3:Number) : void
      {

         if(param1 <= param2)
         {
            this.Internal_mc.UpwardIndicator_mc.gotoAndPlay("RepUp");
            this.Internal_mc.MeterContainer_mc.gotoAndStop("RepUp");
            GlobalFunc.PlayMenuSound("UIReputationIncrease");
         }
         else
         {
            this.Internal_mc.UpwardIndicator_mc.gotoAndPlay("RepDown");
            this.Internal_mc.MeterContainer_mc.gotoAndStop("RepDown");
            GlobalFunc.PlayMenuSound("UIReputationDecrease");
         }
         if(this.m_MeterTween != null)
         {
            this.m_MeterTween.removeEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
            this.m_MeterTween.stop();
            this.m_MeterTween = null;
         }
         if(param1 != param2 || param3 > 0)
         {
            this.meterPercent = param2;
            this.m_MeterTween = new Tween(this,"meterPercent",None.easeIn,param1,param2,param3 / 1000,true);
            this.m_MeterTween.addEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
         }
         else
         {
            this.meterPercent = param1;
            this.onTweenFinish();
         }
      }
      
      public function fadeIn() : void
      {

         gotoAndPlay("rollOn");
      }
      
      public function fadeOut() : void
      {

         gotoAndPlay("rollOff");
      }
      
      private function onHoldFinish() : void
      {

         dispatchEvent(new Event(DISPLAY_COMPLETE,true));
      }
      
      private function onTweenFinish(param1:TweenEvent = null) : void
      {

         setTimeout(this.onHoldFinish,HOLD_TIME);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame6() : *
      {

         dispatchEvent(new Event("Reputation::FullyShown",true));
         stop();
      }
      
      function frame11() : *
      {

         dispatchEvent(new Event("Reputation::FadeOutEnd",true));
      }
   }
}
