 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDRightMeters extends MovieClip
   {
      
      public static const FADE_DELAY:Number = // method body index: 2116 method index: 2116
      10000;
       
      
      public var PowerArmorLowBatteryWarning_mc:MovieClip;
      
      public var LocalEmote_mc:EmoteWidget;
      
      public var FlashLightWidget_mc:MovieClip;
      
      public var ExplosiveAmmoCount_mc:MovieClip;
      
      public var AmmoCount_mc:MovieClip;
      
      public var FatigueWarning_mc:MovieClip;
      
      public var ActionPointMeter_mc:MovieClip;
      
      public var HUDActiveEffectsWidget_mc:HUDActiveEffectsWidget;
      
      public var HUDHungerMeter_mc:MovieClip;
      
      public var HUDThirstMeter_mc:MovieClip;
      
      public var HUDFusionCoreMeter_mc:MovieClip;
      
      private var bShowHunger:Boolean = false;
      
      private var bShowThirst:Boolean = false;
      
      private var bShowFusionCore:Boolean = false;
      
      private var m_FusionCorePercent:Number = 0;
      
      private var m_FusionCoreWarnPercent:Number = 0;
      
      private var m_FusionCoreCount:uint = 0;
      
      private var m_InPowerArmor:Boolean = false;
      
      private var m_PowerArmorHUDEnabled:Boolean = true;
      
      private var fHungerPercent:Number = -1.0;
      
      private var fThirstPercent:Number = -1.0;
      
      private var HungerTimeout:int = -1;
      
      private var ThirstTimeout:int = -1;
      
      private const PercentIndefiniteShow:Number = 0.25;
      
      private const PercentChangeVal:Number = 0.03;
      
      private const PercentMax:Number = 1.0;
      
      private var m_HudModes:Array;
      
      private var bIsPip:Boolean = false;
      
      private var oldHudMode = "All";
      
      public function HUDRightMeters()
      {

         super();
         addFrameScript(0,this.frame1,1,this.frame2);
         BSUIDataManager.Subscribe("HUDRightMetersData",this.onStateUpdate);
         this.m_HudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.IRON_SIGHTS,HUDModes.POWER_ARMOR,HUDModes.PIPBOY,HUDModes.SCOPE_MENU,HUDModes.VERTIBIRD_MODE,HUDModes.SIT_WAIT_MODE,HUDModes.VATS_MODE);
         BSUIDataManager.Subscribe("HUDModeData",this.onHudModeDataChange);
         BSUIDataManager.Subscribe("PowerArmorInfoData",this.onPowerArmorInfoUpdate);
         gotoAndStop("defaultHUD");
         this.HUDHungerMeter_mc.gotoAndStop("off");
         this.HUDThirstMeter_mc.gotoAndStop("off");
         this.HUDFusionCoreMeter_mc.gotoAndStop("off");
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.AmmoCount_mc.ClipCount_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AmmoCount_mc.ReserveCount_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function set showFusionCoreMeter(param1:Boolean) : void
      {

         if(param1 != this.bShowFusionCore)
         {
            this.bShowFusionCore = param1;
            if(param1)
            {
               this.HUDFusionCoreMeter_mc.gotoAndPlay("rollOn");
            }
            else
            {
               this.HUDFusionCoreMeter_mc.gotoAndPlay("rollOff");
            }
         }
      }
      
      private function updateFusionCoreMeter() : void
      {

         var _loc1_:Number = GlobalFunc.Clamp(this.m_FusionCorePercent,0,this.PercentMax) / this.PercentMax;
         var _loc2_:int = Math.ceil(_loc1_ * this.HUDFusionCoreMeter_mc.Meter_mc.totalFrames);
         this.HUDFusionCoreMeter_mc.Meter_mc.gotoAndStop(_loc2_);
         var _loc3_:uint = GlobalFunc.Clamp(this.m_FusionCoreCount,0,9);
         this.HUDFusionCoreMeter_mc.CoreCount_mc.CoreCount_tf.text = "x" + this.m_FusionCoreCount;
         if(this.m_FusionCoreCount == 0 && this.m_FusionCorePercent < this.m_FusionCoreWarnPercent)
         {
            this.HUDFusionCoreMeter_mc.survivalMeterIcon_mc.gotoAndStop("coreNegative");
         }
         else
         {
            this.HUDFusionCoreMeter_mc.survivalMeterIcon_mc.gotoAndStop("corePositive");
         }
      }
      
      private function onPowerArmorInfoUpdate(param1:FromClientDataEvent) : void
      {

         this.m_FusionCorePercent = param1.data.fusionCorePercent;
         this.m_FusionCoreWarnPercent = param1.data.fusionCoreWarnPercent;
         this.m_FusionCoreCount = param1.data.fusionCoreCount;
         if(this.bShowFusionCore)
         {
            this.updateFusionCoreMeter();
         }
      }
      
      private function onHudModeDataChange(param1:FromClientDataEvent) : *
      {

         this.visible = this.m_HudModes.indexOf(param1.data.hudMode) != -1;
         this.m_InPowerArmor = param1.data.inPowerArmor;
         this.m_PowerArmorHUDEnabled = param1.data.powerArmorHUDEnabled;
         this.showFusionCoreMeter = this.m_InPowerArmor && !this.m_PowerArmorHUDEnabled;
         if(this.bShowFusionCore)
         {
            this.updateFusionCoreMeter();
         }
         var _loc2_:Boolean = this.bIsPip;
         this.bIsPip = param1.data.hudMode == HUDModes.PIPBOY;
         if(this.bIsPip)
         {
            if(this.fHungerPercent >= 0)
            {
               this.endHungerHideTimeout();
               this.fadeInHunger();
            }
            if(this.fThirstPercent >= 0)
            {
               this.endThirstHideTimeout();
               this.fadeInThirst();
            }
         }
         else if(this.visible && _loc2_)
         {
            if(this.HungerTimeout == -1 && this.fHungerPercent >= this.PercentIndefiniteShow)
            {
               this.HungerTimeout = setTimeout(this.fadeOutHunger,FADE_DELAY);
            }
            if(this.ThirstTimeout == -1 && this.fThirstPercent >= this.PercentIndefiniteShow)
            {
               this.ThirstTimeout = setTimeout(this.fadeOutThirst,FADE_DELAY);
            }
         }
         if(param1.data.inPowerArmor && param1.data.powerArmorHUDEnabled)
         {
            gotoAndStop("powerArmorHUD");
         }
         else
         {
            gotoAndStop("defaultHUD");
         }
         this.oldHudMode = param1.data.hudMode;
      }
      
      private function onStateUpdate(param1:FromClientDataEvent) : *
      {

         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:Object = param1.data;
         if(_loc6_.hungerPercent < 0 || _loc6_.thirstPercent < 0)
         {
            return;
         }
         var _loc7_:Number = _loc6_.hungerPercent;
         var _loc8_:Number = _loc6_.thirstPercent;
         if(_loc7_ < this.PercentIndefiniteShow)
         {
            this.endHungerHideTimeout();
            this.fadeInHunger();
         }
         else if(!GlobalFunc.CloseToNumber(this.fHungerPercent,_loc7_,this.PercentChangeVal) || _loc7_ > this.fHungerPercent)
         {
            this.endHungerHideTimeout();
            this.fadeInHunger();
            this.HungerTimeout = setTimeout(this.fadeOutHunger,FADE_DELAY);
         }
         this.fHungerPercent = _loc7_;
         _loc7_ = GlobalFunc.Clamp(_loc7_,0,this.PercentMax) / this.PercentMax;
         var _loc9_:int = Math.ceil(_loc7_ * this.HUDHungerMeter_mc.Meter_mc.totalFrames);
         this.HUDHungerMeter_mc.Meter_mc.gotoAndStop(_loc9_);
         if(this.fHungerPercent <= this.PercentIndefiniteShow)
         {
            this.HUDHungerMeter_mc.survivalMeterIcon_mc.gotoAndStop("foodNegative");
         }
         else
         {
            this.HUDHungerMeter_mc.survivalMeterIcon_mc.gotoAndStop("foodPositive");
         }
         if(_loc6_.hunger_RestorePct is Number && _loc6_.hunger_RestorePct > 0)
         {
            _loc2_ = GlobalFunc.Clamp(this.fHungerPercent + _loc6_.hunger_RestorePct,0,this.PercentMax) / this.PercentMax;
            _loc3_ = Math.ceil(_loc2_ * this.HUDHungerMeter_mc.GhostMeter_mc.totalFrames);
            this.HUDHungerMeter_mc.GhostMeter_mc.gotoAndStop(_loc3_);
            this.HUDHungerMeter_mc.GhostMeter_mc.visible = true;
         }
         else
         {
            this.HUDHungerMeter_mc.GhostMeter_mc.visible = false;
         }
         if(_loc8_ < this.PercentIndefiniteShow)
         {
            this.endThirstHideTimeout();
            this.fadeInThirst();
         }
         else if(!GlobalFunc.CloseToNumber(this.fThirstPercent,_loc8_,this.PercentChangeVal) || _loc8_ > this.fThirstPercent)
         {
            this.endThirstHideTimeout();
            this.fadeInThirst();
            this.ThirstTimeout = setTimeout(this.fadeOutThirst,FADE_DELAY);
         }
         this.fThirstPercent = _loc8_;
         _loc8_ = GlobalFunc.Clamp(_loc8_,0,this.PercentMax) / this.PercentMax;
         var _loc10_:int = Math.ceil(_loc8_ * this.HUDThirstMeter_mc.Meter_mc.totalFrames);
         this.HUDThirstMeter_mc.Meter_mc.gotoAndStop(_loc10_);
         if(this.fThirstPercent <= this.PercentIndefiniteShow)
         {
            this.HUDThirstMeter_mc.survivalMeterIcon_mc.gotoAndStop("thirstNegative");
         }
         else
         {
            this.HUDThirstMeter_mc.survivalMeterIcon_mc.gotoAndStop("thirstPositive");
         }
         if(_loc6_.thirst_RestorePct is Number && _loc6_.thirst_RestorePct > 0)
         {
            _loc4_ = GlobalFunc.Clamp(this.fThirstPercent + _loc6_.thirst_RestorePct,0,this.PercentMax) / this.PercentMax;
            _loc5_ = Math.ceil(_loc4_ * this.HUDThirstMeter_mc.GhostMeter_mc.totalFrames);
            this.HUDThirstMeter_mc.GhostMeter_mc.gotoAndStop(_loc5_);
            this.HUDThirstMeter_mc.GhostMeter_mc.visible = true;
         }
         else
         {
            this.HUDThirstMeter_mc.GhostMeter_mc.visible = false;
         }
      }
      
      public function fadeInHunger() : void
      {

         if(!this.bShowHunger)
         {
            this.bShowHunger = true;
            this.HUDHungerMeter_mc.gotoAndPlay("rollOn");
         }
      }
      
      public function fadeOutHunger() : void
      {

         if(this.bShowHunger && !this.bIsPip)
         {
            this.HungerTimeout = -1;
            this.bShowHunger = false;
            this.HUDHungerMeter_mc.gotoAndPlay("rollOff");
         }
      }
      
      private function endHungerHideTimeout() : void
      {

         if(this.HungerTimeout != -1)
         {
            clearTimeout(this.HungerTimeout);
            this.HungerTimeout = -1;
         }
      }
      
      public function fadeInThirst() : void
      {

         if(!this.bShowThirst)
         {
            this.bShowThirst = true;
            this.HUDThirstMeter_mc.gotoAndPlay("rollOn");
         }
      }
      
      public function fadeOutThirst() : void
      {

         if(this.bShowThirst && !this.bIsPip)
         {
            this.ThirstTimeout = -1;
            this.bShowThirst = false;
            this.HUDThirstMeter_mc.gotoAndPlay("rollOff");
         }
      }
      
      private function endThirstHideTimeout() : void
      {

         if(this.ThirstTimeout != -1)
         {
            clearTimeout(this.ThirstTimeout);
            this.ThirstTimeout = -1;
         }
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame2() : *
      {

         stop();
      }
   }
}
