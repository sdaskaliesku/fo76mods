 
package fl.motion
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class AnimatorBase extends EventDispatcher
   {
      
      private static var enterFrameBeacon:MovieClip = // method body index: 561 method index: 561
      new MovieClip();
       
      
      private var _motion:MotionBase;
      
      private var _motionArray:Array;
      
      protected var _lastMotionUsed:MotionBase;
      
      protected var _lastColorTransformApplied:ColorTransform;
      
      protected var _filtersApplied:Boolean;
      
      protected var _lastBlendModeApplied:String;
      
      protected var _cacheAsBitmapHasBeenApplied:Boolean;
      
      protected var _lastCacheAsBitmapApplied:Boolean;
      
      protected var _opaqueBackgroundHasBeenApplied:Boolean;
      
      protected var _lastOpaqueBackgroundApplied:Object;
      
      protected var _visibleHasBeenApplied:Boolean;
      
      protected var _lastVisibleApplied:Boolean;
      
      protected var _lastMatrixApplied:Matrix;
      
      protected var _lastMatrix3DApplied:Object;
      
      protected var _toRemove:Array;
      
      protected var _lastFrameHandled:int;
      
      protected var _lastSceneHandled:String;
      
      protected var _registeredParent:Boolean;
      
      public var orientToPath:Boolean = false;
      
      public var transformationPoint:Point;
      
      public var transformationPointZ:int;
      
      public var autoRewind:Boolean = false;
      
      public var positionMatrix:Matrix;
      
      public var repeatCount:int = 1;
      
      private var _isPlaying:Boolean = false;
      
      protected var _target:DisplayObject;
      
      protected var _lastTarget:DisplayObject;
      
      private var _lastRenderedTime:int = -1;
      
      private var _lastRenderedMotion:MotionBase = null;
      
      private var _time:int = -1;
      
      private var _targetParent:DisplayObjectContainer = null;
      
      private var _targetParentBtn:SimpleButton = null;
      
      private var _targetName:String = "";
      
      private var targetStateOriginal:Object = null;
      
      private var _placeholderName:String = null;
      
      private var _instanceFactoryClass:Class = null;
      
      private var instanceFactory:Object = null;
      
      private var _useCurrentFrame:Boolean = false;
      
      private var _spanStart:int = -1;
      
      private var _spanEnd:int = -1;
      
      private var _sceneName:String = "";
      
      private var _frameEvent:String = "enterFrame";
      
      private var _targetState3D:Array = null;
      
      protected var _isAnimator3D:Boolean;
      
      private var playCount:int = 0;
      
      protected var targetState:Object;
      
      public function AnimatorBase(param1:XML = null, param2:DisplayObject = null)
      {

         super();
         this.target = param2;
         this._isAnimator3D = false;
         this.transformationPoint = new Point(0.5,0.5);
         this.transformationPointZ = 0;
         this._sceneName = "";
         this._toRemove = new Array();
         this._lastFrameHandled = -1;
         this._lastSceneHandled = null;
         this._registeredParent = false;
      }
      
      protected static function colorTransformsEqual(param1:ColorTransform, param2:ColorTransform) : Boolean
      {

         return param1.alphaMultiplier == param2.alphaMultiplier && param1.alphaOffset == param2.alphaOffset && param1.blueMultiplier == param2.blueMultiplier && param1.blueOffset == param2.blueOffset && param1.greenMultiplier == param2.greenMultiplier && param1.greenOffset == param2.greenOffset && param1.redMultiplier == param2.redMultiplier && param1.redOffset == param2.redOffset;
      }
      
      public static function registerParentFrameHandler(param1:MovieClip, param2:AnimatorBase, param3:int, param4:int = 0, param5:Boolean = false) : void
      {

         param2._registeredParent = true;
         if(param3 == -1)
         {
            param3 = param1.currentFrame - 1;
         }
         if(param5)
         {
            param2.useCurrentFrame(true,param3);
         }
         else
         {
            param2.repeatCount = param4;
         }
      }
      
      public static function processCurrentFrame(param1:MovieClip, param2:AnimatorBase, param3:Boolean, param4:Boolean = false) : void
      {

         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param2 && param1)
         {
            if(param2.usingCurrentFrame)
            {
               _loc5_ = param1.currentFrame - 1;
               if(param1.scenes.length > 1)
               {
                  if(param1.currentScene.name != param2.sceneName)
                  {
                     _loc5_ = -1;
                  }
               }
               if(_loc5_ >= param2.spanStart && _loc5_ <= param2.spanEnd)
               {
                  _loc6_ = !!param2.motionArray?int(int(_loc5_)):int(int(_loc5_ - param2.spanStart));
                  if(!param2.isPlaying)
                  {
                     param2.play(_loc6_,param3);
                  }
                  else if(!param4)
                  {
                     if(_loc5_ == param2.spanEnd)
                     {
                        param2.handleLastFrame(true,false);
                     }
                     else
                     {
                        param2.time = _loc6_;
                     }
                  }
               }
               else if(param2.isPlaying && !param4)
               {
                  param2.end(true,false,true);
               }
               else if(!param2.isPlaying && param4)
               {
                  param2.startFrameEvents();
               }
            }
            else if(param2.targetParent && (param2.targetParent.hasOwnProperty(param2.targetName) && param2.targetParent[param2.targetName] == null || param2.targetParent.getChildByName(param2.targetName) == null))
            {
               if(param2.isPlaying)
               {
                  param2.end(true,false);
               }
               else if(param4)
               {
                  param2.startFrameEvents();
               }
            }
            else if(!param2.isPlaying)
            {
               if(param4)
               {
                  param2.play(0,param3);
               }
            }
            else if(!param4)
            {
               param2.nextFrame(false,false);
            }
         }
      }
      
      public static function registerButtonState(param1:SimpleButton, param2:AnimatorBase, param3:int, param4:int = -1, param5:String = null, param6:String = null, param7:Class = null) : void
      {

         var newTarget:DisplayObject = null;
         var container:DisplayObjectContainer = null;
         var targetParentBtn:SimpleButton = param1;
         var anim:AnimatorBase = param2;
         var stateFrame:int = param3;
         var zIndex:int = param4;
         var targetName:String = param5;
         var placeholderName:String = param6;
         var instanceFactoryClass:Class = param7;
         var target:DisplayObject = targetParentBtn.upState;
         switch(stateFrame)
         {
            case 1:
               target = targetParentBtn.overState;
               break;
            case 2:
               target = targetParentBtn.downState;
               break;
            case 3:
               target = targetParentBtn.hitTestState;
         }
         if(!target)
         {
            return;
         }
         if(zIndex >= 0)
         {
            try
            {
               container = DisplayObjectContainer(target);
               newTarget = container.getChildAt(zIndex);
            }
            catch(e:Error)
            {
               newTarget = null;
            }
            if(newTarget != null)
            {
               target = newTarget;
            }
         }
         anim.target = target;
         if(placeholderName != null && instanceFactoryClass != null)
         {
            anim.targetParentButton = targetParentBtn;
            anim.targetName = targetName;
            anim.instanceFactoryClass = instanceFactoryClass;
            anim.useCurrentFrame(true,stateFrame);
            anim.target.addEventListener(anim.frameEvent,anim.placeholderButtonEnterFrameHandler,false,0,true);
            anim.placeholderButtonEnterFrameHandler(null);
         }
         else
         {
            anim.time = 0;
         }
      }
      
      public static function registerSpriteParent(param1:Sprite, param2:AnimatorBase, param3:String, param4:String = null, param5:Class = null) : void
      {

         var _loc6_:DisplayObject = null;
         if(param1 == null || param2 == null || param3 == null)
         {
            return;
         }
         if(param4 != null && param5 != null)
         {
            _loc6_ = param1[param4];
            if(_loc6_ == null)
            {
               _loc6_ = param1.getChildByName(param4);
            }
            param2.target = _loc6_;
            param2.targetParent = param1;
            param2.targetName = param3;
            param2.placeholderName = param4;
            param2.instanceFactoryClass = param5;
            param2.useCurrentFrame(true,0);
            param2.target.addEventListener(param2.frameEvent,param2.placeholderSpriteEnterFrameHandler,false,0,true);
            param2.placeholderSpriteEnterFrameHandler(null);
         }
         else
         {
            _loc6_ = param1[param3];
            if(_loc6_ == null)
            {
               _loc6_ = param1.getChildByName(param3);
            }
            param2.target = _loc6_;
            param2.time = 0;
         }
      }
      
      public function get motion() : MotionBase
      {

         return this._motion;
      }
      
      public function set motion(param1:MotionBase) : void
      {

         this._motion = param1;
         if(param1)
         {
            if(this.motionArray)
            {
               this._spanStart = this._spanEnd = -1;
            }
            this.motionArray = null;
         }
      }
      
      public function get motionArray() : Array
      {

         return this._motionArray;
      }
      
      public function set motionArray(param1:Array) : void
      {

         var _loc2_:int = 0;
         this._motionArray = param1 && param1.length > 0?param1:null;
         if(this._motionArray)
         {
            this.motion = null;
            this._spanStart = this._motionArray[0].motion_internal::spanStart;
            this._spanEnd = this._spanStart - 1;
            _loc2_ = 0;
            while(_loc2_ < this._motionArray.length)
            {
               this._spanEnd = this._spanEnd + this._motionArray[_loc2_].duration;
               _loc2_++;
            }
         }
      }
      
      public function get isPlaying() : Boolean
      {

         return this._isPlaying;
      }
      
      public function get target() : DisplayObject
      {

         return this._target;
      }
      
      public function set target(param1:DisplayObject) : void
      {

         if(!param1)
         {
            return;
         }
         this._target = param1;
         if(param1 != this._lastTarget)
         {
            this._lastColorTransformApplied = null;
            this._filtersApplied = false;
            this._lastBlendModeApplied = null;
            this._cacheAsBitmapHasBeenApplied = false;
            this._opaqueBackgroundHasBeenApplied = false;
            this._visibleHasBeenApplied = false;
            this._lastMatrixApplied = null;
            this._lastMatrix3DApplied = null;
            this._toRemove = new Array();
         }
         this._lastTarget = param1;
         var _loc2_:Boolean = false;
         if(this.targetParent && this.targetName != "")
         {
            if(this.targetStateOriginal)
            {
               this.targetState = this.targetStateOriginal;
               return;
            }
            _loc2_ = true;
         }
         this.targetState = {};
         this.setTargetState();
         if(_loc2_)
         {
            this.targetStateOriginal = this.targetState;
         }
      }
      
      protected function setTargetState() : void
      {

      }
      
      public function set initialPosition(param1:Array) : void
      {

      }
      
      public function get time() : int
      {

         return this._time;
      }
      
      public function set time(param1:int) : void
      {

         var _loc2_:Array = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc5_:ColorTransform = null;
         var _loc6_:Array = null;
         if(param1 == this._time)
         {
            return;
         }
         if(this._placeholderName)
         {
            _loc3_ = this._targetParent[this._placeholderName];
            if(!_loc3_)
            {
               _loc3_ = this._targetParent.getChildByName(this._placeholderName);
            }
            if(_loc3_ && _loc3_.parent == this._targetParent && this._target.parent == this._targetParent)
            {
               this._targetParent.addChildAt(this._target,this._targetParent.getChildIndex(_loc3_) + 1);
            }
         }
         var _loc7_:MotionBase = this.motion;
         if(_loc7_)
         {
            if(param1 > _loc7_.duration - 1)
            {
               param1 = _loc7_.duration - 1;
            }
            else if(param1 < 0)
            {
               param1 = 0;
            }
            this._time = param1;
         }
         else
         {
            _loc2_ = this.motionArray;
            if(param1 <= this._spanStart)
            {
               _loc7_ = _loc2_[0];
               param1 = this._spanStart;
            }
            else if(param1 >= this._spanEnd)
            {
               _loc7_ = _loc2_[_loc2_.length - 1];
               param1 = this._spanEnd;
            }
            else
            {
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  _loc7_ = _loc2_[_loc4_];
                  if(param1 <= _loc7_.motion_internal::spanStart + _loc7_.duration - 1)
                  {
                     break;
                  }
                  _loc4_++;
               }
            }
            this._time = param1;
            param1 = param1 - _loc7_.motion_internal::spanStart;
         }
         this.dispatchEvent(new MotionEvent(MotionEvent.TIME_CHANGE));
         var _loc8_:KeyframeBase = _loc7_.getCurrentKeyframe(param1);
         var _loc9_:Boolean = _loc8_.index == this._lastRenderedTime && (!_loc2_ || this._lastRenderedMotion == _loc7_) && !_loc8_.tweensLength;
         if(_loc9_)
         {
            return;
         }
         if(_loc8_.blank)
         {
            this._target.visible = false;
         }
         else
         {
            if(this._isAnimator3D)
            {
               this._lastMatrixApplied = null;
               this.setTime3D(param1,_loc7_);
            }
            else
            {
               this._lastMatrix3DApplied = null;
               this.setTimeClassic(param1,_loc7_,_loc8_);
            }
            _loc5_ = _loc7_.getColorTransform(param1);
            if(_loc2_)
            {
               if(!_loc5_ && this._lastColorTransformApplied)
               {
                  _loc5_ = new ColorTransform();
               }
               if(_loc5_ && (!this._lastColorTransformApplied || !colorTransformsEqual(_loc5_,this._lastColorTransformApplied)))
               {
                  this._target.transform.colorTransform = _loc5_;
                  this._lastColorTransformApplied = _loc5_;
               }
            }
            else if(_loc5_)
            {
               this._target.transform.colorTransform = _loc5_;
            }
            _loc6_ = _loc7_.getFilters(param1);
            if(_loc2_ && !_loc6_ && this._filtersApplied)
            {
               this._target.filters = null;
               this._filtersApplied = false;
            }
            else if(_loc6_)
            {
               this._target.filters = _loc6_;
               this._filtersApplied = true;
            }
            if(!_loc2_ || this._lastBlendModeApplied != _loc8_.blendMode)
            {
               this._target.blendMode = _loc8_.blendMode;
               this._lastBlendModeApplied = _loc8_.blendMode;
            }
            if(!_loc2_ || this._lastOpaqueBackgroundApplied != _loc8_.opaqueBackground || !this._opaqueBackgroundHasBeenApplied)
            {
               this._target.opaqueBackground = _loc8_.opaqueBackground;
               this._opaqueBackgroundHasBeenApplied = true;
               this._lastOpaqueBackgroundApplied = _loc8_.opaqueBackground;
            }
            if(!_loc2_ || this._lastVisibleApplied != _loc8_.visible || !this._visibleHasBeenApplied)
            {
               this._target.visible = _loc8_.visible;
               this._visibleHasBeenApplied = true;
               this._lastVisibleApplied = _loc8_.visible;
            }
         }
         this._lastRenderedTime = param1;
         this._lastRenderedMotion = _loc7_;
         this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_UPDATE));
      }
      
      protected function setTime3D(param1:int, param2:MotionBase) : Boolean
      {

         return false;
      }
      
      protected function setTimeClassic(param1:int, param2:MotionBase, param3:KeyframeBase) : Boolean
      {

         return false;
      }
      
      public function get targetParent() : DisplayObjectContainer
      {

         return this._targetParent;
      }
      
      public function set targetParent(param1:DisplayObjectContainer) : void
      {

         this._targetParent = param1;
      }
      
      public function get targetParentButton() : SimpleButton
      {

         return this._targetParentBtn;
      }
      
      public function set targetParentButton(param1:SimpleButton) : *
      {

         this._targetParentBtn = param1;
      }
      
      public function get targetName() : String
      {

         return this._targetName;
      }
      
      public function set targetName(param1:String) : void
      {

         this._targetName = param1;
      }
      
      public function get placeholderName() : String
      {

         return this._placeholderName;
      }
      
      public function set placeholderName(param1:String) : void
      {

         this._placeholderName = param1;
      }
      
      public function get instanceFactoryClass() : Class
      {

         return this._instanceFactoryClass;
      }
      
      public function set instanceFactoryClass(param1:Class) : void
      {

         var f:Class = param1;
         if(f == this._instanceFactoryClass)
         {
            return;
         }
         this._instanceFactoryClass = f;
         try
         {
            this.instanceFactory = this._instanceFactoryClass["getSingleton"]();
            return;
         }
         catch(e:Error)
         {
            instanceFactory = null;
            return;
         }
      }
      
      public function useCurrentFrame(param1:Boolean, param2:int) : void
      {

         this._useCurrentFrame = param1;
         if(!this.motionArray)
         {
            this._spanStart = param2;
         }
      }
      
      public function get usingCurrentFrame() : Boolean
      {

         return this._useCurrentFrame;
      }
      
      public function get spanStart() : int
      {

         return this._spanStart;
      }
      
      public function get spanEnd() : int
      {

         if(this._spanEnd >= 0)
         {
            return this._spanEnd;
         }
         if(this._motion && this._motion.duration > 0)
         {
            return this._spanStart + this._motion.duration - 1;
         }
         return this._spanStart;
      }
      
      public function get sceneName() : String
      {

         return this._sceneName;
      }
      
      public function set sceneName(param1:String) : void
      {

         this._sceneName = param1;
      }
      
      private function handleEnterFrame(param1:Event) : void
      {

         var _loc2_:MovieClip = null;
         if(this._registeredParent)
         {
            _loc2_ = this._targetParent as MovieClip;
            if(_loc2_ == null)
            {
               return;
            }
            if(!this.usingCurrentFrame || _loc2_.currentFrame != this._lastFrameHandled || _loc2_.currentScene.name != this._lastSceneHandled || this.target == null && this.instanceFactoryClass != null)
            {
               processCurrentFrame(_loc2_,this,false);
            }
            this.removeChildren();
            this._lastFrameHandled = _loc2_.currentFrame;
            this._lastSceneHandled = _loc2_.currentScene.name;
         }
         else
         {
            this.nextFrame();
         }
      }
      
      private function removeChildren() : void
      {

         var _loc1_:Object = null;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._toRemove.length)
         {
            _loc1_ = this._toRemove[_loc3_];
            if(_loc1_.target == this._target || _loc1_.target.parent != this._targetParent)
            {
               this._toRemove.splice(_loc3_,1);
            }
            else
            {
               _loc2_ = MovieClip(this._targetParent);
               if(_loc1_.currentFrame == _loc2_.currentFrame && (_loc2_.scenes.length <= 1 || _loc1_.currentSceneName == _loc2_.currentScene.name))
               {
                  _loc3_++;
               }
               else
               {
                  this.removeChildTarget(_loc2_,_loc1_.target,_loc1_.target.name);
                  this._toRemove.splice(_loc3_,1);
               }
            }
         }
      }
      
      protected function removeChildTarget(param1:MovieClip, param2:DisplayObject, param3:String) : void
      {

         param1.removeChild(param2);
         if(param1.hasOwnProperty(param3) && param1[param3] == param2)
         {
            param1[param3] = null;
         }
         this._lastColorTransformApplied = null;
         this._filtersApplied = false;
         this._lastBlendModeApplied = null;
         this._cacheAsBitmapHasBeenApplied = false;
         this._opaqueBackgroundHasBeenApplied = false;
         this._visibleHasBeenApplied = false;
         this._lastMatrixApplied = null;
         this._lastMatrix3DApplied = null;
      }
      
      public function get frameEvent() : String
      {

         return this._frameEvent;
      }
      
      public function set frameEvent(param1:String) : void
      {

         this._frameEvent = param1;
      }
      
      public function get targetState3D() : Array
      {

         return this._targetState3D;
      }
      
      public function set targetState3D(param1:Array) : void
      {

         this._targetState3D = param1;
      }
      
      public function nextFrame(param1:Boolean = false, param2:Boolean = true) : void
      {

         if(this.motionArray && this.time >= this.spanEnd || !this.motionArray && this.time >= this.motion.duration - 1)
         {
            this.handleLastFrame(param1,param2);
         }
         else
         {
            this.time++;
         }
      }
      
      public function play(param1:int = -1, param2:Boolean = true) : void
      {

         var _loc3_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         if(!this._isPlaying)
         {
            if(this._target == null && this._targetParent && this._targetName != "")
            {
               _loc3_ = !!this._targetParent.hasOwnProperty(this._targetName)?this._targetParent[this._targetName]:this._targetParent.getChildByName(this._targetName);
               if(this.instanceFactory == null || this.instanceFactory["isTargetForFrame"](_loc3_,param1,this.sceneName))
               {
                  this.target = _loc3_;
               }
               if(!this.target)
               {
                  _loc3_ = this._targetParent.getChildByName(this._targetName);
                  if(this.instanceFactory == null || this.instanceFactory["isTargetForFrame"](_loc3_,param1,this.sceneName))
                  {
                     this.target = _loc3_;
                  }
                  if(!this.target && this._placeholderName && this.instanceFactory)
                  {
                     _loc4_ = this.instanceFactory["getInstance"](this._targetParent,this._targetName,param1,this.sceneName);
                     if(_loc4_)
                     {
                        _loc4_.name = this._targetName;
                        this._targetParent[this._targetName] = _loc4_;
                        _loc5_ = this._targetParent[this._placeholderName];
                        if(!_loc5_)
                        {
                           _loc5_ = this._targetParent.getChildByName(this._placeholderName);
                        }
                        if(_loc5_)
                        {
                           this._targetParent.addChildAt(_loc4_,this._targetParent.getChildIndex(_loc5_) + 1);
                        }
                        else
                        {
                           this._targetParent.addChild(_loc4_);
                        }
                        this.target = _loc4_;
                     }
                  }
               }
            }
            if(param2)
            {
               enterFrameBeacon.addEventListener(this.frameEvent,this.handleEnterFrame,false,0,true);
            }
            if(!this.target)
            {
               return;
            }
            this._isPlaying = true;
         }
         this.playCount = 0;
         if(param1 > -1)
         {
            this.time = param1;
         }
         else
         {
            this.rewind();
         }
         this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_START));
      }
      
      public function end(param1:Boolean = false, param2:Boolean = true, param3:Boolean = false) : void
      {

         var _loc4_:MovieClip = null;
         if(param2)
         {
            enterFrameBeacon.removeEventListener(this.frameEvent,this.handleEnterFrame);
         }
         this._isPlaying = false;
         this.playCount = 0;
         if(this.autoRewind)
         {
            this.rewind();
         }
         else if(this.motion && this.time != this.motion.duration - 1)
         {
            this.time = this.motion.duration - 1;
         }
         else if(this.motionArray && this.time != this._spanEnd)
         {
            this.time = this._spanEnd;
         }
         if(param1)
         {
            if(this._targetParent && this._targetName != "")
            {
               if(this._target && this.instanceFactory && this._targetParent is MovieClip && this._targetParent == this._target.parent)
               {
                  if(param3)
                  {
                     this.removeChildTarget(MovieClip(this._targetParent),this._target,this._targetName);
                  }
                  else
                  {
                     _loc4_ = MovieClip(this._targetParent);
                     this._toRemove.push({
                        "target":this._target,
                        "currentFrame":_loc4_.currentFrame,
                        "currentSceneName":_loc4_.currentScene.name
                     });
                  }
               }
               this._target = null;
            }
            this._lastRenderedTime = -1;
            this._time = -1;
         }
         this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_END));
      }
      
      public function stop() : void
      {

         enterFrameBeacon.removeEventListener(this.frameEvent,this.handleEnterFrame);
         this._isPlaying = false;
         this.playCount = 0;
         this.rewind();
         this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_END));
      }
      
      public function pause() : void
      {

         enterFrameBeacon.removeEventListener(this.frameEvent,this.handleEnterFrame);
         this._isPlaying = false;
      }
      
      public function resume() : void
      {

         enterFrameBeacon.addEventListener(this.frameEvent,this.handleEnterFrame,false,0,true);
         this._isPlaying = true;
      }
      
      public function startFrameEvents() : void
      {

         enterFrameBeacon.addEventListener(this.frameEvent,this.handleEnterFrame,false,0,true);
      }
      
      public function rewind() : void
      {

         this.time = !!this.motionArray?int(int(this._spanStart)):0;
      }
      
      private function placeholderButtonEnterFrameHandler(param1:Event) : void
      {

         var _loc2_:DisplayObjectContainer = null;
         if(this._targetParentBtn == null || this.instanceFactory == null)
         {
            this._target.removeEventListener(this.frameEvent,this.placeholderButtonEnterFrameHandler);
            return;
         }
         var _loc3_:DisplayObject = this.instanceFactory["getInstance"](this._targetParentBtn,this._targetName,this._spanStart);
         if(_loc3_ == null)
         {
            return;
         }
         this._target.removeEventListener(this.frameEvent,this.placeholderButtonEnterFrameHandler);
         if(this._target.parent == null || DisplayObject(this._target.parent) == this._targetParentBtn)
         {
            switch(this._spanStart)
            {
               case 1:
                  this._targetParentBtn.overState = _loc3_;
                  break;
               case 2:
                  this._targetParentBtn.downState = _loc3_;
                  break;
               case 3:
                  this._targetParentBtn.hitTestState = _loc3_;
                  break;
               default:
                  this._targetParentBtn.upState = _loc3_;
            }
         }
         else
         {
            _loc2_ = this._target.parent as DisplayObjectContainer;
            if(_loc2_ != null)
            {
               _loc2_.addChildAt(_loc3_,_loc2_.getChildIndex(this._target) + 1);
               _loc2_.removeChild(this._target);
            }
         }
         this.target = _loc3_;
         this.time = 0;
      }
      
      private function placeholderSpriteEnterFrameHandler(param1:Event) : void
      {

         if(this._targetParent == null || this.instanceFactory == null)
         {
            this._target.removeEventListener(this.frameEvent,this.placeholderSpriteEnterFrameHandler);
            return;
         }
         var _loc2_:DisplayObject = this.instanceFactory["getInstance"](this._targetParent,this._targetName,0);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.name = this._targetName;
         this._targetParent[this._targetName] = _loc2_;
         this._target.removeEventListener(this.frameEvent,this.placeholderSpriteEnterFrameHandler);
         this._targetParent[this._placeholderName] = null;
         this._targetParent.addChildAt(_loc2_,this._targetParent.getChildIndex(this._target) + 1);
         this._targetParent.removeChild(this._target);
         this.target = _loc2_;
         this.time = 0;
      }
      
      private function handleLastFrame(param1:Boolean = false, param2:Boolean = true) : void
      {

         this.playCount++;
         if(this.repeatCount == 0 || this.playCount < this.repeatCount)
         {
            this.rewind();
         }
         else
         {
            this.end(param1,param2,false);
         }
      }
   }
}
