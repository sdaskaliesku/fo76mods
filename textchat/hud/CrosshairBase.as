 
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
      
      public static const DEFAULT_TICK_RADIUS:Number = // method body index: 2813 method index: 2813
      19;
      
      public static const EAZE_TIME_SEC:Number = // method body index: 2813 method index: 2813
      0.15;
      
      public static const COLLAPSE_DELAY_SEC:Number = // method body index: 2813 method index: 2813
      0.3;
      
      public static const STATE_NONE:String = // method body index: 2813 method index: 2813
      "None";
      
      public static const STATE_DOT:String = // method body index: 2813 method index: 2813
      "Dot";
      
      public static const STATE_STANDARD:String = // method body index: 2813 method index: 2813
      "Standard";
      
      public static const STATE_ACTIVATE:String = // method body index: 2813 method index: 2813
      "Activate";
      
      public static const STATE_COMMAND:String = // method body index: 2813 method index: 2813
      "Command";
      
      public static const CLIPNAME_STANDARD_STANDARD:String = // method body index: 2813 method index: 2813
      "Standard_Standard";
      
      public static const ANIMATION_COMPLETE:String = // method body index: 2813 method index: 2813
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
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.brightness = -90;
         _loc1_.contrast = 15;
         _loc1_.saturation = 25;
         _loc1_.hue = -50;
         this._hostileColorMatrixFilter = new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray());
         BSUIDataManager.Subscribe("TargetData",this.onTargetDataUpdate);
      }
      
      public function set targetIsHostile(param1:Boolean) : void
      {

         if(this._targetIsHostile != param1)
         {
            this._targetIsHostile = param1;
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
      
      public function set requestedState(param1:String) : void
      {

         if(param1 != this._requestedState)
         {
            this._requestedState = param1;
            SetIsDirty();
         }
      }
      
      public function set requestedRadius(param1:Number) : void
      {

         if(param1 != this._requestedRadius)
         {
            this._requestedRadius = param1;
            SetIsDirty();
         }
      }
      
      private function onTargetDataUpdate(param1:FromClientDataEvent) : void
      {

         this.targetIsHostile = param1.data.isHostile;
      }
      
      private function onAnimationComplete(param1:Event) : *
      {

         this._currentState = this._currentAnimFinish;
         this.StartNextClip();
      }
      
      private function StartNextClip() : *
      {

         var _loc1_:MovieClip = null;
         var _loc2_:* = false;
         this.CrosshairTicks_mc.visible = false;
         this.CrosshairClips_mc.visible = true;
         this._currentAnimStart = this._currentState;
         this._currentAnimFinish = this._requestedState;
         this._activeClipName = this._currentState + "_" + this._requestedState;
         _loc1_ = this.CrosshairClips_mc[this._activeClipName] as MovieClip;
         var _loc3_:Boolean = this._activeClip && this._activeClip != _loc1_;
         if(_loc3_)
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
            _loc2_ = this._activeClip != _loc1_;
            if(_loc2_)
            {
               this._activeClip = _loc1_;
               this._activeClip.addEventListener(ANIMATION_COMPLETE,this.onAnimationComplete);
               this._activeClip.visible = true;
            }
            this._activeClip.gotoAndPlay(2);
         }
      }
      
      private function RepositionCrosshairTicks(param1:Number, param2:Function = null) : void
      {

         var _loc3_:EazeTween = eaze(this.CrosshairTicks_mc.Up).to(EAZE_TIME_SEC,{"y":-param1}).easing(Quadratic.easeIn);
         eaze(this.CrosshairTicks_mc.Down).to(EAZE_TIME_SEC,{"y":param1}).easing(Quadratic.easeIn);
         eaze(this.CrosshairTicks_mc.Left).to(EAZE_TIME_SEC,{"x":-param1}).easing(Quadratic.easeIn);
         eaze(this.CrosshairTicks_mc.Right).to(EAZE_TIME_SEC,{"x":param1}).easing(Quadratic.easeIn);
         if(param2 != null)
         {
            _loc3_.onComplete(param2);
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
