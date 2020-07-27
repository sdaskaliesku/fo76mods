 
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
      
      public static const TIME_PER_VALUE:Number = // method body index: 2175 method index: 2175
      200;
      
      public static const MAX_TIME_CAP:Number = // method body index: 2175 method index: 2175
      3000;
      
      public static const HOLD_TIME:Number = // method body index: 2175 method index: 2175
      2000;
      
      public static const DISPLAY_COMPLETE:String = // method body index: 2175 method index: 2175
      "Reputation::DisplayComplete";
      
      public static const FADEOUT_COMPLETE:String = // method body index: 2175 method index: 2175
      "Reputation::FadeOutEnd";
      
      public static const HEADER_ICON_SPACING:Number = // method body index: 2175 method index: 2175
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
      
      public function set data(aData:Object) : void
      {

         var leftStatus:Object = null;
         var rightStatus:Object = null;
         var fullDuration:Number = NaN;
         var meterDuration:Number = NaN;
         this.m_Data = aData;
         this.Header_mc.Header_tf.text = GlobalFunc.LocalizeFormattedString(aData.factionName + "Reputation").toUpperCase();
         var headerMetrics:TextLineMetrics = this.Header_mc.Header_tf.getLineMetrics(0);
         this.FactionIcon_mc.x = this.Header_mc.x + (this.Header_mc.Header_tf.width - headerMetrics.width) / 2 - this.FactionIcon_mc.width / 2 - HEADER_ICON_SPACING;
         this.FactionIcon_mc.gotoAndStop(aData.factionCode);
         if(aData.tierStart != aData.tierEnd)
         {
            rightStatus = {
               "code":aData.factionCode.toLowerCase(),
               "tier":aData.tierEnd
            };
            leftStatus = rightStatus;
         }
         else
         {
            leftStatus = {
               "code":aData.factionCode.toUpperCase(),
               "tier":aData.tierStart
            };
            rightStatus = {
               "code":aData.factionCode.toUpperCase(),
               "tier":aData.tierStart + 1
            };
         }
         Factions.updateFaceIcon(this.LeftStatusIcon_mc,leftStatus);
         Factions.updateFaceIcon(this.RightStatusIcon_mc,rightStatus);
         this.CurrentStanding_mc.CurrentStanding_tf.text = GlobalFunc.LocalizeFormattedString("$ReputationCurrentStanding","$ReputationStatus" + leftStatus.tier);
         if(aData.tierStart == aData.tierEnd)
         {
            fullDuration = Math.abs(aData.percentEnd - aData.percentStart) * 100 * TIME_PER_VALUE;
            meterDuration = Math.min(MAX_TIME_CAP,fullDuration);
            this.tweenMeter(aData.percentStart,aData.percentEnd,meterDuration);
         }
         else
         {
            this.tweenMeter(aData.percentStart,aData.percentEnd,0);
         }
      }
      
      public function get data() : Object
      {

         return this.m_Data;
      }
      
      public function set meterPercent(aPercent:Number) : void
      {

         this.m_MeterPercent = aPercent;
         this.Meter_mc.gotoAndStop(GlobalFunc.Clamp(Math.ceil(aPercent * this.m_MeterFrames),1,this.m_MeterFrames));
      }
      
      public function get meterPercent() : Number
      {

         return this.m_MeterPercent;
      }
      
      private function tweenMeter(aStartPercent:Number, aTargPercent:Number, aDuration:Number) : void
      {

         if(aStartPercent <= aTargPercent)
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
         if(aStartPercent != aTargPercent || aDuration > 0)
         {
            this.meterPercent = aTargPercent;
            this.m_MeterTween = new Tween(this,"meterPercent",None.easeIn,aStartPercent,aTargPercent,aDuration / 1000,true);
            this.m_MeterTween.addEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
         }
         else
         {
            this.meterPercent = aStartPercent;
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
      
      private function onTweenFinish(aEvent:TweenEvent = null) : void
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
