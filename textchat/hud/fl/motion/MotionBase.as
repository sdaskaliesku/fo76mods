 
package fl.motion
{
   import flash.filters.BitmapFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class MotionBase
   {
       
      
      public var keyframes:Array;
      
      private var _spanStart:int;
      
      private var _transformationPoint:Point;
      
      private var _transformationPointZ:int;
      
      private var _initialPosition:Array;
      
      private var _initialMatrix:Matrix;
      
      private var _duration:int = 0;
      
      private var _is3D:Boolean = false;
      
      private var _overrideScale:Boolean;
      
      private var _overrideSkew:Boolean;
      
      private var _overrideRotate:Boolean;
      
      public function MotionBase(param1:XML = null)
      {
         // method body index: 28 method index: 28
         var _loc2_:KeyframeBase = null;
         super();
         this.keyframes = [];
         if(this.duration == 0)
         {
            _loc2_ = this.getNewKeyframe();
            _loc2_.index = 0;
            this.addKeyframe(_loc2_);
         }
         this._overrideScale = false;
         this._overrideSkew = false;
         this._overrideRotate = false;
      }
      
      motion_internal function set spanStart(param1:int) : void
      {
         // method body index: 29 method index: 29
         this._spanStart = param1;
      }
      
      motion_internal function get spanStart() : int
      {
         // method body index: 30 method index: 30
         return this._spanStart;
      }
      
      motion_internal function set transformationPoint(param1:Point) : void
      {
         // method body index: 31 method index: 31
         this._transformationPoint = param1;
      }
      
      motion_internal function get transformationPoint() : Point
      {
         // method body index: 32 method index: 32
         return this._transformationPoint;
      }
      
      motion_internal function set transformationPointZ(param1:int) : void
      {
         // method body index: 33 method index: 33
         this._transformationPointZ = param1;
      }
      
      motion_internal function get transformationPointZ() : int
      {
         // method body index: 34 method index: 34
         return this._transformationPointZ;
      }
      
      motion_internal function set initialPosition(param1:Array) : void
      {
         // method body index: 35 method index: 35
         this._initialPosition = param1;
      }
      
      motion_internal function get initialPosition() : Array
      {
         // method body index: 36 method index: 36
         return this._initialPosition;
      }
      
      motion_internal function set initialMatrix(param1:Matrix) : void
      {
         // method body index: 37 method index: 37
         this._initialMatrix = param1;
      }
      
      motion_internal function get initialMatrix() : Matrix
      {
         // method body index: 38 method index: 38
         return this._initialMatrix;
      }
      
      public function get duration() : int
      {
         // method body index: 39 method index: 39
         if(this._duration < this.keyframes.length)
         {
            this._duration = this.keyframes.length;
         }
         return this._duration;
      }
      
      public function set duration(param1:int) : void
      {
         // method body index: 40 method index: 40
         if(param1 < this.keyframes.length)
         {
            param1 = this.keyframes.length;
         }
         this._duration = param1;
      }
      
      public function get is3D() : Boolean
      {
         // method body index: 41 method index: 41
         return this._is3D;
      }
      
      public function set is3D(param1:Boolean) : void
      {
         // method body index: 42 method index: 42
         this._is3D = param1;
      }
      
      public function overrideTargetTransform(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true) : void
      {
         // method body index: 43 method index: 43
         this._overrideScale = param1;
         this._overrideSkew = param2;
         this._overrideRotate = param3;
      }
      
      private function indexOutOfRange(param1:int) : Boolean
      {
         // method body index: 44 method index: 44
         return isNaN(param1) || param1 < 0 || param1 > this.duration - 1;
      }
      
      public function getCurrentKeyframe(param1:int, param2:String = "") : KeyframeBase
      {
         // method body index: 45 method index: 45
         var _loc3_:KeyframeBase = null;
         if(isNaN(param1) || param1 < 0 || param1 > this.duration - 1)
         {
            return null;
         }
         var _loc4_:int = param1;
         while(_loc4_ > 0)
         {
            _loc3_ = this.keyframes[_loc4_];
            if(_loc3_ && _loc3_.affectsTweenable(param2))
            {
               return _loc3_;
            }
            _loc4_--;
         }
         return this.keyframes[0];
      }
      
      public function getNextKeyframe(param1:int, param2:String = "") : KeyframeBase
      {
         // method body index: 46 method index: 46
         var _loc3_:KeyframeBase = null;
         if(isNaN(param1) || param1 < 0 || param1 > this.duration - 1)
         {
            return null;
         }
         var _loc4_:int = param1 + 1;
         while(_loc4_ < this.keyframes.length)
         {
            _loc3_ = this.keyframes[_loc4_];
            if(_loc3_ && _loc3_.affectsTweenable(param2))
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function setValue(param1:int, param2:String, param3:Number) : void
      {
         // method body index: 47 method index: 47
         if(param1 == 0)
         {
            return;
         }
         var _loc4_:KeyframeBase = this.keyframes[param1];
         if(!_loc4_)
         {
            _loc4_ = this.getNewKeyframe();
            _loc4_.index = param1;
            this.addKeyframe(_loc4_);
         }
         _loc4_.setValue(param2,param3);
      }
      
      public function getColorTransform(param1:int) : ColorTransform
      {
         // method body index: 48 method index: 48
         var _loc2_:ColorTransform = null;
         var _loc3_:KeyframeBase = this.getCurrentKeyframe(param1,"color");
         if(!_loc3_ || !_loc3_.color)
         {
            return null;
         }
         var _loc4_:ColorTransform = _loc3_.color;
         var _loc5_:Number = param1 - _loc3_.index;
         if(_loc5_ == 0)
         {
            _loc2_ = _loc4_;
         }
         return _loc2_;
      }
      
      public function getMatrix3D(param1:int) : Object
      {
         // method body index: 49 method index: 49
         var _loc2_:KeyframeBase = this.getCurrentKeyframe(param1,"matrix3D");
         return !!_loc2_?_loc2_.matrix3D:null;
      }
      
      public function getMatrix(param1:int) : Matrix
      {
         // method body index: 50 method index: 50
         var _loc2_:KeyframeBase = this.getCurrentKeyframe(param1,"matrix");
         return !!_loc2_?_loc2_.matrix:null;
      }
      
      public function useRotationConcat(param1:int) : Boolean
      {
         // method body index: 51 method index: 51
         var _loc2_:KeyframeBase = this.getCurrentKeyframe(param1,"rotationConcat");
         return !!_loc2_?Boolean(Boolean(_loc2_.useRotationConcat)):false;
      }
      
      public function getFilters(param1:Number) : Array
      {
         // method body index: 52 method index: 52
         var _loc2_:Array = null;
         var _loc3_:KeyframeBase = this.getCurrentKeyframe(param1,"filters");
         if(!_loc3_ || _loc3_.filters && !_loc3_.filters.length)
         {
            return [];
         }
         var _loc4_:Array = _loc3_.filters;
         var _loc5_:Number = param1 - _loc3_.index;
         if(_loc5_ == 0)
         {
            _loc2_ = _loc4_;
         }
         return _loc2_;
      }
      
      protected function findTweenedValue(param1:Number, param2:String, param3:KeyframeBase, param4:Number, param5:Number) : Number
      {
         // method body index: 53 method index: 53
         return NaN;
      }
      
      public function getValue(param1:Number, param2:String) : Number
      {
         // method body index: 54 method index: 54
         var _loc3_:Number = NaN;
         var _loc4_:KeyframeBase = this.getCurrentKeyframe(param1,param2);
         if(!_loc4_ || _loc4_.blank)
         {
            return NaN;
         }
         var _loc5_:Number = _loc4_.getValue(param2);
         if(isNaN(_loc5_) && _loc4_.index > 0)
         {
            _loc5_ = this.getValue(_loc4_.index - 1,param2);
         }
         if(isNaN(_loc5_))
         {
            return NaN;
         }
         var _loc6_:Number = param1 - _loc4_.index;
         if(_loc6_ == 0)
         {
            return _loc5_;
         }
         _loc3_ = this.findTweenedValue(param1,param2,_loc4_,_loc6_,_loc5_);
         return _loc3_;
      }
      
      public function addKeyframe(param1:KeyframeBase) : void
      {
         // method body index: 55 method index: 55
         this.keyframes[param1.index] = param1;
         if(this.duration < this.keyframes.length)
         {
            this.duration = this.keyframes.length;
         }
      }
      
      public function addPropertyArray(param1:String, param2:Array, param3:int = -1, param4:int = -1) : void
      {
         // method body index: 56 method index: 56
         var _loc5_:KeyframeBase = null;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:int = param2.length;
         var _loc10_:* = null;
         var _loc11_:Boolean = true;
         var _loc12_:Number = 0;
         if(_loc9_ > 0)
         {
            if(param2[0] is Number)
            {
               _loc11_ = false;
               if(param2[0] is Number)
               {
                  _loc12_ = Number(param2[0]);
               }
            }
         }
         if(this.duration < _loc9_)
         {
            this.duration = _loc9_;
         }
         if(param3 == -1 || param4 == -1)
         {
            param3 = 0;
            param4 = this.duration;
         }
         var _loc13_:int = param3;
         while(_loc13_ < param4)
         {
            _loc5_ = KeyframeBase(this.keyframes[_loc13_]);
            if(_loc5_ == null)
            {
               _loc5_ = this.getNewKeyframe();
               _loc5_.index = _loc13_;
               this.addKeyframe(_loc5_);
            }
            if(_loc5_.filters && _loc5_.filters.length == 0)
            {
               _loc5_.filters = null;
            }
            _loc6_ = _loc10_;
            _loc7_ = _loc13_ - param3;
            if(_loc7_ < param2.length)
            {
               if(param2[_loc7_] || !_loc11_)
               {
                  _loc6_ = param2[_loc7_];
               }
            }
            switch(param1)
            {
               case "blendMode":
               case "matrix3D":
               case "matrix":
               case "cacheAsBitmap":
               case "opaqueBackground":
               case "visible":
                  _loc5_[param1] = _loc6_;
                  break;
               case "rotationConcat":
                  _loc5_.useRotationConcat = true;
                  if(!this._overrideRotate && !_loc11_)
                  {
                     _loc5_.setValue(param1,(_loc6_ - _loc12_) * Math.PI / 180);
                  }
                  else
                  {
                     _loc5_.setValue(param1,_loc6_ * Math.PI / 180);
                  }
                  break;
               case "brightness":
               case "tintMultiplier":
               case "tintColor":
               case "alphaMultiplier":
               case "alphaOffset":
               case "redMultiplier":
               case "redOffset":
               case "greenMultiplier":
               case "greenOffset":
               case "blueMultiplier":
               case "blueOffset":
                  if(_loc5_.color == null)
                  {
                     _loc5_.color = new Color();
                  }
                  _loc5_.color[param1] = _loc6_;
                  break;
               case "rotationZ":
                  _loc5_.useRotationConcat = true;
                  this._is3D = true;
                  if(!this._overrideRotate && !_loc11_)
                  {
                     _loc5_.setValue("rotationConcat",_loc6_ - _loc12_);
                  }
                  else
                  {
                     _loc5_.setValue("rotationConcat",_loc6_);
                  }
                  break;
               case "rotationX":
               case "rotationY":
               case "z":
                  this._is3D = true;
               default:
                  _loc8_ = _loc6_;
                  if(!_loc11_)
                  {
                     switch(param1)
                     {
                        case "scaleX":
                        case "scaleY":
                           if(!this._overrideScale)
                           {
                              if(_loc12_ == 0)
                              {
                                 _loc8_ = _loc6_ + 1;
                              }
                              else
                              {
                                 _loc8_ = _loc6_ / _loc12_;
                              }
                           }
                           break;
                        case "skewX":
                        case "skewY":
                           if(!this._overrideSkew)
                           {
                              _loc8_ = _loc6_ - _loc12_;
                           }
                           break;
                        case "rotationX":
                        case "rotationY":
                           if(!this._overrideRotate)
                           {
                              _loc8_ = _loc6_ - _loc12_;
                           }
                     }
                  }
                  _loc5_.setValue(param1,_loc8_);
            }
            _loc10_ = _loc6_;
            _loc13_++;
         }
      }
      
      public function initFilters(param1:Array, param2:Array, param3:int = -1, param4:int = -1) : void
      {
         // method body index: 57 method index: 57
         var _loc5_:Class = null;
         var _loc6_:int = 0;
         var _loc7_:KeyframeBase = null;
         var _loc8_:BitmapFilter = null;
         var _loc9_:int = 0;
         if(param3 == -1 || param4 == -1)
         {
            param3 = 0;
            param4 = this.duration;
         }
         var _loc10_:int = 0;
         while(_loc10_ < param1.length)
         {
            _loc5_ = getDefinitionByName(param1[_loc10_]) as Class;
            _loc6_ = param3;
            while(_loc6_ < param4)
            {
               _loc7_ = KeyframeBase(this.keyframes[_loc6_]);
               if(_loc7_ == null)
               {
                  _loc7_ = this.getNewKeyframe();
                  _loc7_.index = _loc6_;
                  this.addKeyframe(_loc7_);
               }
               if(_loc7_ && _loc7_.filters == null)
               {
                  _loc7_.filters = new Array();
               }
               if(_loc7_ && _loc7_.filters)
               {
                  _loc8_ = null;
                  switch(param1[_loc10_])
                  {
                     case "flash.filters.GradientBevelFilter":
                     case "flash.filters.GradientGlowFilter":
                        _loc9_ = param2[_loc10_];
                        _loc8_ = BitmapFilter(new _loc5_(4,45,new Array(_loc9_),new Array(_loc9_),new Array(_loc9_)));
                        break;
                     default:
                        _loc8_ = BitmapFilter(new _loc5_());
                  }
                  if(_loc8_)
                  {
                     _loc7_.filters.push(_loc8_);
                  }
               }
               _loc6_++;
            }
            _loc10_++;
         }
      }
      
      public function addFilterPropertyArray(param1:int, param2:String, param3:Array, param4:int = -1, param5:int = -1) : void
      {
         // method body index: 58 method index: 58
         var _loc6_:KeyframeBase = null;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc9_:int = param3.length;
         var _loc10_:* = null;
         var _loc11_:Boolean = true;
         if(_loc9_ > 0)
         {
            if(param3[0] is Number)
            {
               _loc11_ = false;
            }
         }
         if(this.duration < _loc9_)
         {
            this.duration = _loc9_;
         }
         if(param4 == -1 || param5 == -1)
         {
            param4 = 0;
            param5 = this.duration;
         }
         var _loc12_:int = param4;
         while(_loc12_ < param5)
         {
            _loc6_ = KeyframeBase(this.keyframes[_loc12_]);
            if(_loc6_ == null)
            {
               _loc6_ = this.getNewKeyframe();
               _loc6_.index = _loc12_;
               this.addKeyframe(_loc6_);
            }
            _loc7_ = _loc10_;
            _loc8_ = _loc12_ - param4;
            if(_loc8_ < param3.length)
            {
               if(param3[_loc8_] || !_loc11_)
               {
                  _loc7_ = param3[_loc8_];
               }
            }
            switch(param2)
            {
               case "adjustColorBrightness":
               case "adjustColorContrast":
               case "adjustColorSaturation":
               case "adjustColorHue":
                  _loc6_.setAdjustColorProperty(param1,param2,_loc7_);
                  break;
               default:
                  if(param1 < _loc6_.filters.length)
                  {
                     _loc6_.filters[param1][param2] = _loc7_;
                  }
            }
            _loc10_ = _loc7_;
            _loc12_++;
         }
      }
      
      protected function getNewKeyframe(param1:XML = null) : KeyframeBase
      {
         // method body index: 59 method index: 59
         return new KeyframeBase(param1);
      }
   }
}
