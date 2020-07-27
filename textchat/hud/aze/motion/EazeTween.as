 
package aze.motion
{
   import aze.motion.easing.Linear;
   import aze.motion.easing.Quadratic;
   import aze.motion.specials.EazeSpecial;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public final class EazeTween
   {
      
      public static var defaultEasing:Function = // method body index: 61 method index: 61
      Quadratic.easeOut;
      
      public static var defaultDuration:Object = // method body index: 61 method index: 61
      {
         "slow":1,
         "normal":0.4,
         "fast":0.2
      };
      
      public static const specialProperties:Dictionary = // method body index: 61 method index: 61
      new Dictionary();
      
      private static const running:Dictionary = // method body index: 61 method index: 61
      new Dictionary();
      
      private static const ticker:Shape = // method body index: 61 method index: 61
      createTicker();
      
      private static var pauseTime:Number;
      
      private static var head:EazeTween;
      
      private static var tweenCount:int = // method body index: 61 method index: 61
      0;
      
      {
         // method body index: 61 method index: 61
         specialProperties.alpha = true;
         specialProperties.alphaVisible = true;
         specialProperties.scale = true;
      }
      
      private var prev:EazeTween;
      
      private var next:EazeTween;
      
      private var rnext:EazeTween;
      
      private var isDead:Boolean;
      
      private var target:Object;
      
      private var reversed:Boolean;
      
      private var overwrite:Boolean;
      
      private var autoStart:Boolean;
      
      private var _configured:Boolean;
      
      private var _started:Boolean;
      
      private var _inited:Boolean;
      
      private var duration;
      
      private var _duration:Number;
      
      private var _ease:Function;
      
      private var startTime:Number;
      
      private var endTime:Number;
      
      private var properties:EazeProperty;
      
      private var specials:EazeSpecial;
      
      private var autoVisible:Boolean;
      
      private var slowTween:Boolean;
      
      private var _chain:Array;
      
      private var _onStart:Function;
      
      private var _onStartArgs:Array;
      
      private var _onUpdate:Function;
      
      private var _onUpdateArgs:Array;
      
      private var _onComplete:Function;
      
      private var _onCompleteArgs:Array;
      
      public function EazeTween(param1:Object, param2:Boolean = true)
      {
         // method body index: 69 method index: 69
         super();
         if(!param1)
         {
            throw new ArgumentError("EazeTween: target can not be null");
         }
         this.target = param1;
         this.autoStart = param2;
         this._ease = defaultEasing;
      }
      
      public static function killAllTweens() : void
      {
         // method body index: 62 method index: 62
         var _loc1_:* = null;
         for(_loc1_ in running)
         {
            killTweensOf(_loc1_);
         }
      }
      
      public static function killTweensOf(param1:Object) : void
      {
         // method body index: 63 method index: 63
         var _loc2_:EazeTween = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:EazeTween = running[param1];
         while(_loc3_)
         {
            _loc3_.isDead = true;
            _loc3_.dispose();
            if(_loc3_.rnext)
            {
               _loc2_ = _loc3_;
               _loc3_ = _loc3_.rnext;
               _loc2_.rnext = null;
            }
            else
            {
               _loc3_ = null;
            }
         }
         delete running[param1];
      }
      
      public static function pauseAllTweens() : void
      {
         // method body index: 64 method index: 64
         if(ticker.hasEventListener(Event.ENTER_FRAME))
         {
            pauseTime = getTimer();
            ticker.removeEventListener(Event.ENTER_FRAME,tick);
         }
      }
      
      public static function resumeAllTweens() : void
      {
         // method body index: 65 method index: 65
         var _loc1_:Number = NaN;
         var _loc2_:EazeTween = null;
         if(!ticker.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_ = getTimer() - pauseTime;
            _loc2_ = head;
            while(_loc2_)
            {
               _loc2_.startTime = _loc2_.startTime + _loc1_;
               _loc2_.endTime = _loc2_.endTime + _loc1_;
               _loc2_ = _loc2_.next;
            }
            ticker.addEventListener(Event.ENTER_FRAME,tick);
         }
      }
      
      private static function createTicker() : Shape
      {
         // method body index: 66 method index: 66
         var _loc1_:Shape = new Shape();
         _loc1_.addEventListener(Event.ENTER_FRAME,tick);
         return _loc1_;
      }
      
      private static function tick(param1:Event) : void
      {
         // method body index: 67 method index: 67
         if(head)
         {
            updateTweens(getTimer());
         }
      }
      
      private static function updateTweens(param1:int) : void
      {
         // method body index: 68 method index: 68
         var _loc2_:* = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Object = null;
         var _loc6_:EazeProperty = null;
         var _loc7_:EazeSpecial = null;
         var _loc8_:EazeTween = null;
         var _loc9_:EazeTween = null;
         var _loc10_:CompleteData = null;
         var _loc11_:int = 0;
         var _loc12_:Array = [];
         var _loc13_:int = 0;
         var _loc14_:EazeTween = head;
         var _loc15_:int = 0;
         while(_loc14_)
         {
            _loc15_++;
            if(_loc14_.isDead)
            {
               _loc2_ = true;
            }
            else
            {
               _loc2_ = param1 >= _loc14_.endTime;
               _loc3_ = !!_loc2_?Number(Number(1)):Number(Number((param1 - _loc14_.startTime) / _loc14_._duration));
               _loc4_ = _loc14_._ease(_loc3_ || 0);
               _loc5_ = _loc14_.target;
               _loc6_ = _loc14_.properties;
               while(_loc6_)
               {
                  _loc5_[_loc6_.name] = _loc6_.start + _loc6_.delta * _loc4_;
                  _loc6_ = _loc6_.next;
               }
               if(_loc14_.slowTween)
               {
                  if(_loc14_.autoVisible)
                  {
                     _loc5_.visible = _loc5_.alpha > 0.001;
                  }
                  if(_loc14_.specials)
                  {
                     _loc7_ = _loc14_.specials;
                     while(_loc7_)
                     {
                        _loc7_.update(_loc4_,_loc2_);
                        _loc7_ = _loc7_.next;
                     }
                  }
                  if(_loc14_._onStart != null)
                  {
                     _loc14_._onStart.apply(null,_loc14_._onStartArgs);
                     _loc14_._onStart = null;
                     _loc14_._onStartArgs = null;
                  }
                  if(_loc14_._onUpdate != null)
                  {
                     _loc14_._onUpdate.apply(null,_loc14_._onUpdateArgs);
                  }
               }
            }
            if(_loc2_)
            {
               if(_loc14_._started)
               {
                  _loc10_ = new CompleteData(_loc14_._onComplete,_loc14_._onCompleteArgs,_loc14_._chain,_loc14_.endTime - param1);
                  _loc14_._chain = null;
                  _loc12_.unshift(_loc10_);
                  _loc13_++;
               }
               _loc14_.isDead = true;
               _loc14_.detach();
               _loc14_.dispose();
               _loc8_ = _loc14_;
               _loc9_ = _loc14_.prev;
               _loc14_ = _loc8_.next;
               if(_loc9_)
               {
                  _loc9_.next = _loc14_;
                  if(_loc14_)
                  {
                     _loc14_.prev = _loc9_;
                  }
               }
               else
               {
                  head = _loc14_;
                  if(_loc14_)
                  {
                     _loc14_.prev = null;
                  }
               }
               _loc8_.prev = _loc8_.next = null;
            }
            else
            {
               _loc14_ = _loc14_.next;
            }
         }
         if(_loc13_)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc13_)
            {
               _loc12_[_loc11_].execute();
               _loc11_++;
            }
         }
         tweenCount = _loc15_;
      }
      
      private function configure(param1:*, param2:Object = null, param3:Boolean = false) : void
      {
         // method body index: 70 method index: 70
         var _loc4_:* = null;
         var _loc5_:* = undefined;
         this._configured = true;
         this.reversed = param3;
         this.duration = param1;
         if(param2)
         {
            for(_loc4_ in param2)
            {
               _loc5_ = param2[_loc4_];
               if(_loc4_ in specialProperties)
               {
                  if(_loc4_ == "alpha")
                  {
                     this.autoVisible = true;
                     this.slowTween = true;
                  }
                  else if(_loc4_ == "alphaVisible")
                  {
                     _loc4_ = "alpha";
                     this.autoVisible = false;
                  }
                  else if(!(_loc4_ in this.target))
                  {
                     if(_loc4_ == "scale")
                     {
                        this.configure(param1,{
                           "scaleX":_loc5_,
                           "scaleY":_loc5_
                        },param3);
                     }
                     else
                     {
                        this.specials = new specialProperties[_loc4_](this.target,_loc4_,_loc5_,this.specials);
                        this.slowTween = true;
                     }
                     continue;
                  }
               }
               if(_loc5_ is Array && this.target[_loc4_] is Number)
               {
                  if("__bezier" in specialProperties)
                  {
                     this.specials = new specialProperties["__bezier"](this.target,_loc4_,_loc5_,this.specials);
                     this.slowTween = true;
                  }
               }
               else
               {
                  this.properties = new EazeProperty(_loc4_,_loc5_,this.properties);
               }
            }
         }
      }
      
      public function start(param1:Boolean = true, param2:Number = 0) : void
      {
         // method body index: 71 method index: 71
         if(this._started)
         {
            return;
         }
         if(!this._inited)
         {
            this.init();
         }
         this.overwrite = param1;
         this.startTime = getTimer() + param2;
         this._duration = (!!isNaN(this.duration)?this.smartDuration(String(this.duration)):Number(this.duration)) * 1000;
         this.endTime = this.startTime + this._duration;
         if(this.reversed || this._duration == 0)
         {
            this.update(this.startTime);
         }
         if(this.autoVisible && this._duration > 0)
         {
            this.target.visible = true;
         }
         this._started = true;
         this.attach(this.overwrite);
      }
      
      private function init() : void
      {
         // method body index: 72 method index: 72
         if(this._inited)
         {
            return;
         }
         var _loc1_:EazeProperty = this.properties;
         while(_loc1_)
         {
            _loc1_.init(this.target,this.reversed);
            _loc1_ = _loc1_.next;
         }
         var _loc2_:EazeSpecial = this.specials;
         while(_loc2_)
         {
            _loc2_.init(this.reversed);
            _loc2_ = _loc2_.next;
         }
         this._inited = true;
      }
      
      private function smartDuration(param1:String) : Number
      {
         // method body index: 73 method index: 73
         var _loc2_:EazeSpecial = null;
         if(param1 in defaultDuration)
         {
            return defaultDuration[param1];
         }
         if(param1 == "auto")
         {
            _loc2_ = this.specials;
            while(_loc2_)
            {
               if("getPreferredDuration" in _loc2_)
               {
                  return _loc2_["getPreferredDuration"]();
               }
               _loc2_ = _loc2_.next;
            }
         }
         return defaultDuration.normal;
      }
      
      public function easing(param1:Function) : EazeTween
      {
         // method body index: 74 method index: 74
         this._ease = param1 || defaultEasing;
         return this;
      }
      
      public function filter(param1:*, param2:Object, param3:Boolean = false) : EazeTween
      {
         // method body index: 75 method index: 75
         if(!param2)
         {
            param2 = {};
         }
         if(param3)
         {
            param2.remove = true;
         }
         this.addSpecial(param1,param1,param2);
         return this;
      }
      
      public function tint(param1:* = null, param2:Number = 1, param3:Number = NaN) : EazeTween
      {
         // method body index: 76 method index: 76
         if(isNaN(param3))
         {
            param3 = 1 - param2;
         }
         this.addSpecial("tint","tint",[param1,param2,param3]);
         return this;
      }
      
      public function colorMatrix(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:uint = 16777215, param6:Number = 0) : EazeTween
      {
         // method body index: 77 method index: 77
         var _loc7_:Boolean = !param1 && !param2 && !param3 && !param4 && !param6;
         return this.filter(ColorMatrixFilter,{
            "brightness":param1,
            "contrast":param2,
            "saturation":param3,
            "hue":param4,
            "tint":param5,
            "colorize":param6
         },_loc7_);
      }
      
      public function short(param1:Number, param2:String = "rotation", param3:Boolean = false) : EazeTween
      {
         // method body index: 78 method index: 78
         this.addSpecial("__short",param2,[param1,param3]);
         return this;
      }
      
      public function rect(param1:Rectangle, param2:String = "scrollRect") : EazeTween
      {
         // method body index: 79 method index: 79
         this.addSpecial("__rect",param2,param1);
         return this;
      }
      
      private function addSpecial(param1:*, param2:*, param3:Object) : void
      {
         // method body index: 80 method index: 80
         if(param1 in specialProperties && this.target)
         {
            if((!this._inited || this._duration == 0) && this.autoStart)
            {
               EazeSpecial(new specialProperties[param1](this.target,param2,param3,null)).init(true);
            }
            else
            {
               this.specials = new specialProperties[param1](this.target,param2,param3,this.specials);
               if(this._started)
               {
                  this.specials.init(this.reversed);
               }
               this.slowTween = true;
            }
         }
      }
      
      public function onStart(param1:Function, ... rest) : EazeTween
      {
         // method body index: 81 method index: 81
         this._onStart = param1;
         this._onStartArgs = rest;
         this.slowTween = !this.autoVisible || this.specials != null || this._onUpdate != null || this._onStart != null;
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : EazeTween
      {
         // method body index: 82 method index: 82
         this._onUpdate = param1;
         this._onUpdateArgs = rest;
         this.slowTween = !this.autoVisible || this.specials != null || this._onUpdate != null || this._onStart != null;
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : EazeTween
      {
         // method body index: 83 method index: 83
         this._onComplete = param1;
         this._onCompleteArgs = rest;
         return this;
      }
      
      public function kill(param1:Boolean = false) : void
      {
         // method body index: 84 method index: 84
         if(this.isDead)
         {
            return;
         }
         if(param1)
         {
            this._onUpdate = this._onComplete = null;
            this.update(this.endTime);
         }
         else
         {
            this.detach();
            this.dispose();
         }
         this.isDead = true;
      }
      
      public function killTweens() : EazeTween
      {
         // method body index: 85 method index: 85
         EazeTween.killTweensOf(this.target);
         return this;
      }
      
      public function updateNow() : EazeTween
      {
         // method body index: 86 method index: 86
         var _loc1_:Number = NaN;
         if(this._started)
         {
            _loc1_ = Math.max(this.startTime,getTimer());
            this.update(_loc1_);
         }
         else
         {
            this.init();
            this.endTime = this._duration = 1;
            this.update(0);
         }
         return this;
      }
      
      private function update(param1:Number) : void
      {
         // method body index: 87 method index: 87
         var _loc2_:EazeTween = head;
         head = this;
         updateTweens(param1);
         head = _loc2_;
      }
      
      private function attach(param1:Boolean) : void
      {
         // method body index: 88 method index: 88
         var _loc2_:EazeTween = null;
         if(param1)
         {
            killTweensOf(this.target);
         }
         else
         {
            _loc2_ = running[this.target];
         }
         if(_loc2_)
         {
            this.prev = _loc2_;
            this.next = _loc2_.next;
            if(this.next)
            {
               this.next.prev = this;
            }
            _loc2_.next = this;
            this.rnext = _loc2_;
         }
         else
         {
            if(head)
            {
               head.prev = this;
            }
            this.next = head;
            head = this;
         }
         running[this.target] = this;
      }
      
      private function detach() : void
      {
         // method body index: 89 method index: 89
         var _loc1_:EazeTween = null;
         var _loc2_:EazeTween = null;
         if(this.target && this._started)
         {
            _loc1_ = running[this.target];
            if(_loc1_ == this)
            {
               if(this.rnext)
               {
                  running[this.target] = this.rnext;
               }
               else
               {
                  delete running[this.target];
               }
            }
            else if(_loc1_)
            {
               _loc2_ = _loc1_;
               _loc1_ = _loc1_.rnext;
               while(_loc1_)
               {
                  if(_loc1_ == this)
                  {
                     _loc2_.rnext = this.rnext;
                     break;
                  }
                  _loc2_ = _loc1_;
                  _loc1_ = _loc1_.rnext;
               }
            }
            this.rnext = null;
         }
      }
      
      private function dispose() : void
      {
         // method body index: 90 method index: 90
         var _loc1_:EazeTween = null;
         if(this._started)
         {
            this.target = null;
            this._onComplete = null;
            this._onCompleteArgs = null;
            if(this._chain)
            {
               for each(_loc1_ in this._chain)
               {
                  _loc1_.dispose();
               }
               this._chain = null;
            }
         }
         if(this.properties)
         {
            this.properties.dispose();
            this.properties = null;
         }
         this._ease = null;
         this._onStart = null;
         this._onStartArgs = null;
         if(this.slowTween)
         {
            if(this.specials)
            {
               this.specials.dispose();
               this.specials = null;
            }
            this.autoVisible = false;
            this._onUpdate = null;
            this._onUpdateArgs = null;
         }
      }
      
      public function delay(param1:*, param2:Boolean = true) : EazeTween
      {
         // method body index: 91 method index: 91
         return this.add(param1,null,param2);
      }
      
      public function apply(param1:Object = null, param2:Boolean = true) : EazeTween
      {
         // method body index: 92 method index: 92
         return this.add(0,param1,param2);
      }
      
      public function play(param1:* = 0, param2:Boolean = true) : EazeTween
      {
         // method body index: 93 method index: 93
         return this.add("auto",{"frame":param1},param2).easing(Linear.easeNone);
      }
      
      public function to(param1:*, param2:Object = null, param3:Boolean = true) : EazeTween
      {
         // method body index: 94 method index: 94
         return this.add(param1,param2,param3);
      }
      
      public function from(param1:*, param2:Object = null, param3:Boolean = true) : EazeTween
      {
         // method body index: 95 method index: 95
         return this.add(param1,param2,param3,true);
      }
      
      private function add(param1:*, param2:Object, param3:Boolean, param4:Boolean = false) : EazeTween
      {
         // method body index: 96 method index: 96
         if(this.isDead)
         {
            return new EazeTween(this.target).add(param1,param2,param3,param4);
         }
         if(this._configured)
         {
            return this.chain().add(param1,param2,param3,param4);
         }
         this.configure(param1,param2,param4);
         if(this.autoStart)
         {
            this.start(param3);
         }
         return this;
      }
      
      public function chain(param1:Object = null) : EazeTween
      {
         // method body index: 97 method index: 97
         var _loc2_:EazeTween = new EazeTween(param1 || this.target,false);
         if(!this._chain)
         {
            this._chain = [];
         }
         this._chain.push(_loc2_);
         return _loc2_;
      }
      
      public function get isStarted() : Boolean
      {
         // method body index: 98 method index: 98
         return this._started;
      }
      
      public function get isFinished() : Boolean
      {
         // method body index: 99 method index: 99
         return this.isDead;
      }
   }
}

final class EazeProperty
{
    
   
   public var name:String;
   
   public var start:Number;
   
   public var end:Number;
   
   public var delta:Number;
   
   public var next:EazeProperty;
   
   function EazeProperty(param1:String, param2:Number, param3:EazeProperty)
   {
      // method body index: 101 method index: 101
      super();
      this.name = param1;
      this.end = param2;
      this.next = param3;
   }
   
   public function init(param1:Object, param2:Boolean) : void
   {
      // method body index: 102 method index: 102
      if(param2)
      {
         this.start = this.end;
         this.end = param1[this.name];
         param1[this.name] = this.start;
      }
      else
      {
         this.start = param1[this.name];
      }
      this.delta = this.end - this.start;
   }
   
   public function dispose() : void
   {
      // method body index: 103 method index: 103
      if(this.next)
      {
         this.next.dispose();
      }
      this.next = null;
   }
}

import aze.motion.EazeTween;

final class CompleteData
{
    
   
   private var callback:Function;
   
   private var args:Array;
   
   private var chain:Array;
   
   private var diff:Number;
   
   function CompleteData(param1:Function, param2:Array, param3:Array, param4:Number)
   {
      // method body index: 105 method index: 105
      super();
      this.callback = param1;
      this.args = param2;
      this.chain = param3;
      this.diff = param4;
   }
   
   public function execute() : void
   {
      // method body index: 106 method index: 106
      var _loc1_:int = 0;
      var _loc2_:int = 0;
      if(this.callback != null)
      {
         this.callback.apply(null,this.args);
         this.callback = null;
      }
      this.args = null;
      if(this.chain)
      {
         _loc1_ = this.chain.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            EazeTween(this.chain[_loc2_]).start(false,this.diff);
            _loc2_++;
         }
         this.chain = null;
      }
   }
}
