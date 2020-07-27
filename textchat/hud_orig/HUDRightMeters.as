 
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
      
      public static const FADE_DELAY:Number = // method body index: 2190 method index: 2190
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
      
      private var HUDModes:Array;
      
      private var bIsPip:Boolean = false;
      
      private var oldHudMode = "All";
      
      public function HUDRightMeters()
      {
         // method body index: 2191 method index: 2191
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
         BSUIDataManager.Subscribe("HUDRightMetersData",this.onStateUpdate);
         this.HUDModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.IRON_SIGHTS,HUDModes.POWER_ARMOR,HUDModes.PIPBOY,HUDModes.SCOPE_MENU,HUDModes.VERTIBIRD_MODE,HUDModes.SIT_WAIT_MODE,HUDModes.VATS_MODE);
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
      
      public function set showFusionCoreMeter(aShow:Boolean) : void
      {
         // method body index: 2192 method index: 2192
         if(aShow != this.bShowFusionCore)
         {
            this.bShowFusionCore = aShow;
            if(aShow)
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
         // method body index: 2193 method index: 2193
         var corePercent:Number = GlobalFunc.Clamp(this.m_FusionCorePercent,0,this.PercentMax) / this.PercentMax;
         var coreFrame:int = Math.ceil(corePercent * this.HUDFusionCoreMeter_mc.Meter_mc.totalFrames);
         this.HUDFusionCoreMeter_mc.Meter_mc.gotoAndStop(coreFrame);
         var displayCount:uint = GlobalFunc.Clamp(this.m_FusionCoreCount,0,9);
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
      
      private function onPowerArmorInfoUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 2194 method index: 2194
         this.m_FusionCorePercent = arEvent.data.fusionCorePercent;
         this.m_FusionCoreWarnPercent = arEvent.data.fusionCoreWarnPercent;
         this.m_FusionCoreCount = arEvent.data.fusionCoreCount;
         if(this.bShowFusionCore)
         {
            this.updateFusionCoreMeter();
         }
      }
      
      private function onHudModeDataChange(event:FromClientDataEvent) : *
      {
         // method body index: 2195 method index: 2195
         this.visible = this.HUDModes.indexOf(event.data.hudMode) != -1;
         this.m_InPowerArmor = event.data.inPowerArmor;
         this.m_PowerArmorHUDEnabled = event.data.powerArmorHUDEnabled;
         this.showFusionCoreMeter = this.m_InPowerArmor && !this.m_PowerArmorHUDEnabled;
         if(this.bShowFusionCore)
         {
            this.updateFusionCoreMeter();
         }
         var bWasPip:Boolean = this.bIsPip;
         this.bIsPip = event.data.hudMode == HUDModes.PIPBOY;
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
         else if(this.visible && bWasPip)
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
         if(event.data.inPowerArmor && event.data.powerArmorHUDEnabled)
         {
            gotoAndStop("powerArmorHUD");
         }
         else
         {
            gotoAndStop("defaultHUD");
         }
         this.oldHudMode = event.data.hudMode;
      }
      
      private function onStateUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 2196 method index: 2196
         var hungerRestorePercent:Number = NaN;
         var hungerRestoreFrame:int = 0;
         var thirstRestorePercent:Number = NaN;
         var thirstRestoreFrame:int = 0;
         var newData:Object = arEvent.data;
         if(newData.hungerPercent < 0 || newData.thirstPercent < 0)
         {
            return;
         }
         var hungerPercentTmp:Number = newData.hungerPercent;
         var thirstPercentTmp:Number = newData.thirstPercent;
         if(hungerPercentTmp < this.PercentIndefiniteShow)
         {
            this.endHungerHideTimeout();
            this.fadeInHunger();
         }
         else if(!GlobalFunc.CloseToNumber(this.fHungerPercent,hungerPercentTmp,this.PercentChangeVal) || hungerPercentTmp > this.fHungerPercent)
         {
            this.endHungerHideTimeout();
            this.fadeInHunger();
            this.HungerTimeout = setTimeout(this.fadeOutHunger,FADE_DELAY);
         }
         this.fHungerPercent = hungerPercentTmp;
         hungerPercentTmp = GlobalFunc.Clamp(hungerPercentTmp,0,this.PercentMax) / this.PercentMax;
         var hungerFrame:int = Math.ceil(hungerPercentTmp * this.HUDHungerMeter_mc.Meter_mc.totalFrames);
         this.HUDHungerMeter_mc.Meter_mc.gotoAndStop(hungerFrame);
         if(this.fHungerPercent <= this.PercentIndefiniteShow)
         {
            this.HUDHungerMeter_mc.survivalMeterIcon_mc.gotoAndStop("foodNegative");
         }
         else
         {
            this.HUDHungerMeter_mc.survivalMeterIcon_mc.gotoAndStop("foodPositive");
         }
         if(newData.hunger_RestorePct is Number && newData.hunger_RestorePct > 0)
         {
            hungerRestorePercent = GlobalFunc.Clamp(this.fHungerPercent + newData.hunger_RestorePct,0,this.PercentMax) / this.PercentMax;
            hungerRestoreFrame = Math.ceil(hungerRestorePercent * this.HUDHungerMeter_mc.GhostMeter_mc.totalFrames);
            this.HUDHungerMeter_mc.GhostMeter_mc.gotoAndStop(hungerRestoreFrame);
            this.HUDHungerMeter_mc.GhostMeter_mc.visible = true;
         }
         else
         {
            this.HUDHungerMeter_mc.GhostMeter_mc.visible = false;
         }
         if(thirstPercentTmp < this.PercentIndefiniteShow)
         {
            this.endThirstHideTimeout();
            this.fadeInThirst();
         }
         else if(!GlobalFunc.CloseToNumber(this.fThirstPercent,thirstPercentTmp,this.PercentChangeVal) || thirstPercentTmp > this.fThirstPercent)
         {
            this.endThirstHideTimeout();
            this.fadeInThirst();
            this.ThirstTimeout = setTimeout(this.fadeOutThirst,FADE_DELAY);
         }
         this.fThirstPercent = thirstPercentTmp;
         thirstPercentTmp = GlobalFunc.Clamp(thirstPercentTmp,0,this.PercentMax) / this.PercentMax;
         var thirstFrame:int = Math.ceil(thirstPercentTmp * this.HUDThirstMeter_mc.Meter_mc.totalFrames);
         this.HUDThirstMeter_mc.Meter_mc.gotoAndStop(thirstFrame);
         if(this.fThirstPercent <= this.PercentIndefiniteShow)
         {
            this.HUDThirstMeter_mc.survivalMeterIcon_mc.gotoAndStop("thirstNegative");
         }
         else
         {
            this.HUDThirstMeter_mc.survivalMeterIcon_mc.gotoAndStop("thirstPositive");
         }
         if(newData.thirst_RestorePct is Number && newData.thirst_RestorePct > 0)
         {
            thirstRestorePercent = GlobalFunc.Clamp(this.fThirstPercent + newData.thirst_RestorePct,0,this.PercentMax) / this.PercentMax;
            thirstRestoreFrame = Math.ceil(thirstRestorePercent * this.HUDThirstMeter_mc.GhostMeter_mc.totalFrames);
            this.HUDThirstMeter_mc.GhostMeter_mc.gotoAndStop(thirstRestoreFrame);
            this.HUDThirstMeter_mc.GhostMeter_mc.visible = true;
         }
         else
         {
            this.HUDThirstMeter_mc.GhostMeter_mc.visible = false;
         }
      }
      
      public function fadeInHunger() : void
      {
         // method body index: 2197 method index: 2197
         if(!this.bShowHunger)
         {
            this.bShowHunger = true;
            this.HUDHungerMeter_mc.gotoAndPlay("rollOn");
         }
      }
      
      public function fadeOutHunger() : void
      {
         // method body index: 2198 method index: 2198
         if(this.bShowHunger && !this.bIsPip)
         {
            this.HungerTimeout = -1;
            this.bShowHunger = false;
            this.HUDHungerMeter_mc.gotoAndPlay("rollOff");
         }
      }
      
      private function endHungerHideTimeout() : void
      {
         // method body index: 2199 method index: 2199
         if(this.HungerTimeout != -1)
         {
            clearTimeout(this.HungerTimeout);
            this.HungerTimeout = -1;
         }
      }
      
      public function fadeInThirst() : void
      {
         // method body index: 2200 method index: 2200
         if(!this.bShowThirst)
         {
            this.bShowThirst = true;
            this.HUDThirstMeter_mc.gotoAndPlay("rollOn");
         }
      }
      
      public function fadeOutThirst() : void
      {
         // method body index: 2201 method index: 2201
         if(this.bShowThirst && !this.bIsPip)
         {
            this.ThirstTimeout = -1;
            this.bShowThirst = false;
            this.HUDThirstMeter_mc.gotoAndPlay("rollOff");
         }
      }
      
      private function endThirstHideTimeout() : void
      {
         // method body index: 2202 method index: 2202
         if(this.ThirstTimeout != -1)
         {
            clearTimeout(this.ThirstTimeout);
            this.ThirstTimeout = -1;
         }
      }
      
      function frame1() : *
      {
         // method body index: 2203 method index: 2203
         stop();
      }
      
      function frame2() : *
      {
         // method body index: 2204 method index: 2204
         stop();
      }
   }
}
