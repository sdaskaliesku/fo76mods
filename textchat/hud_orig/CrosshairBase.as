 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import aze.motion.EazeTween;
   import aze.motion.easing.Quadratic;
   import aze.motion.eaze;
   import fl.motion.AdjustColor;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.Timer;
   
   public class CrosshairBase extends BSUIComponent
   {
      
      public static const DEFAULT_TICK_RADIUS:Number = // method body index: 2875 method index: 2875
      19;
      
      public static const EAZE_TIME_SEC:Number = // method body index: 2875 method index: 2875
      0.15;
      
      public static const COLLAPSE_DELAY_SEC:Number = // method body index: 2875 method index: 2875
      0.3;
      
      public static const STATE_NONE:String = // method body index: 2875 method index: 2875
      "None";
      
      public static const STATE_DOT:String = // method body index: 2875 method index: 2875
      "Dot";
      
      public static const STATE_STANDARD:String = // method body index: 2875 method index: 2875
      "Standard";
      
      public static const STATE_ACTIVATE:String = // method body index: 2875 method index: 2875
      "Activate";
      
      public static const STATE_COMMAND:String = // method body index: 2875 method index: 2875
      "Command";
      
      public static const CLIPNAME_STANDARD_STANDARD:String = // method body index: 2875 method index: 2875
      "Standard_Standard";
      
      public static const ANIMATION_COMPLETE:String = // method body index: 2875 method index: 2875
      "animationComplete";
       
      
      public var CrosshairTicks_mc:MovieClip;
      
      public var CrosshairClips_mc:MovieClip;
      
      private var _currentState:String = "None";
      
      private var _requestedState:String = "None";
      
      private var _currentAnimStart:String;
      
      private var _currentAnimFinish:String;
      
      private var _currentRadius:Number = 0;
      
      private var _requestedRadius:Number = 0;
      
      private var _activeClip:MovieClip;
      
      private var _activeClipName:String;
      
      private var _collapsingCrosshair:Boolean = false;
      
      private var _expandingCrosshair:Boolean = false;
      
      private var _collapseCountdown:uint = 0;
      
      private var _expandVelocity:Number = 0;
      
      private var _targetIsHostile:Boolean = false;
      
      private var _hostileColorMatrixFilter:ColorMatrixFilter;
      
      private var _collapseDelayTimer:Timer;
      
      public function CrosshairBase()
      {

         this._collapseDelayTimer = new Timer(COLLAPSE_DELAY_SEC,1);
         super();
         this._currentAnimStart = new String();
         this._currentAnimFinish = new String();
         this._activeClip = null;
         this._activeClipName = new String();
         this._collapseDelayTimer.addEventListener(TimerEvent.TIMER,this.BeginCollapsingTicks);
         this.StartNextClip();
         var colorFilter:AdjustColor = new AdjustColor();
         colorFilter.brightness = -90;
         colorFilter.contrast = 15;
         colorFilter.saturation = 25;
         colorFilter.hue = -50;
         this._hostileColorMatrixFilter = new ColorMatrixFilter(colorFilter.CalculateFinalFlatArray());
         BSUIDataManager.Subscribe("TargetData",this.onTargetDataUpdate);
      }
      
      public function set targetIsHostile(aHostile:Boolean) : void
      {

         if(this._targetIsHostile != aHostile)
         {
            this._targetIsHostile = aHostile;
            if(this._targetIsHostile)
            {
               this.filters = [this._hostileColorMatrixFilter];
            }
            else
            {
               this.filters = [];
            }
            SetIsDirty();
         }
      }
      
      public function get targetIsHostile() : Boolean
      {

         return this._targetIsHostile;
      }
      
      public function set requestedState(value:String) : void
      {

         if(value != this._requestedState)
         {
            this._requestedState = value;
            SetIsDirty();
         }
      }
      
      public function set requestedRadius(value:Number) : void
      {

         if(value != this._requestedRadius)
         {
            this._requestedRadius = value;
            SetIsDirty();
         }
      }
      
      private function onTargetDataUpdate(arEvent:FromClientDataEvent) : void
      {

         this.targetIsHostile = arEvent.data.isHostile;
      }
      
      private function onAnimationComplete(aEvent:Event) : *
      {

         this._currentState = this._currentAnimFinish;
         this.StartNextClip();
      }
      
      private function StartNextClip() : *
      {

         var nextClip:MovieClip = null;
         var setupNextClip:* = false;
         this.CrosshairTicks_mc.visible = false;
         this.CrosshairClips_mc.visible = true;
         this._currentAnimStart = this._currentState;
         this._currentAnimFinish = this._requestedState;
         this._activeClipName = this._currentState + "_" + this._requestedState;
         nextClip = this.CrosshairClips_mc[this._activeClipName] as MovieClip;
         var clearCurrentClip:Boolean = this._activeClip && this._activeClip != nextClip;
         if(clearCurrentClip)
         {
            this._activeClip.removeEventListener(ANIMATION_COMPLETE,this.onAnimationComplete);
            this._activeClip.visible = false;
         }
         if(this._activeClipName == CLIPNAME_STANDARD_STANDARD)
         {
            this.BeginExpandingTicks();
         }
         else
         {
            setupNextClip = this._activeClip != nextClip;
            if(setupNextClip)
            {
               this._activeClip = nextClip;
               this._activeClip.addEventListener(ANIMATION_COMPLETE,this.onAnimationComplete);
               this._activeClip.visible = true;
            }
            this._activeClip.gotoAndPlay(2);
         }
      }
      
      private function RepositionCrosshairTicks(aRadius:Number, aOnCompleteCallback:Function = null) : void
      {

         var crossahairEaze:EazeTween = eaze(this.CrosshairTicks_mc.Up).to(EAZE_TIME_SEC,{"y":-aRadius}).easing(Quadratic.easeIn);
         eaze(this.CrosshairTicks_mc.Down).to(EAZE_TIME_SEC,{"y":aRadius}).easing(Quadratic.easeIn);
         eaze(this.CrosshairTicks_mc.Left).to(EAZE_TIME_SEC,{"x":-aRadius}).easing(Quadratic.easeIn);
         eaze(this.CrosshairTicks_mc.Right).to(EAZE_TIME_SEC,{"x":aRadius}).easing(Quadratic.easeIn);
         if(aOnCompleteCallback != null)
         {
            crossahairEaze.onComplete(aOnCompleteCallback);
         }
      }
      
      private function BeginExpandingTicks() : void
      {

         this.CrosshairTicks_mc.visible = true;
         this.CrosshairClips_mc.visible = false;
         this.RepositionCrosshairTicks(this._requestedRadius);
      }
      
      private function BeginCollapsingTicks() : void
      {

         this.CrosshairTicks_mc.visible = true;
         this.CrosshairClips_mc.visible = false;
         this.RepositionCrosshairTicks(DEFAULT_TICK_RADIUS,this.StartNextClip);
      }
      
      override public function redrawUIComponent() : void
      {

         if(this._activeClipName == CLIPNAME_STANDARD_STANDARD)
         {
            if(this._requestedState != STATE_STANDARD)
            {
               if(this._requestedState == STATE_ACTIVATE)
               {
                  this._collapseDelayTimer.reset();
                  this._collapseDelayTimer.start();
               }
               else
               {
                  this.BeginCollapsingTicks();
               }
            }
            else
            {
               this.BeginExpandingTicks();
            }
         }
      }
   }
}
