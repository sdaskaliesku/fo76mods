 
package fl.transitions
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class Tween extends EventDispatcher
   {
      
      protected static var _mc:MovieClip = // method body index: 604 method index: 604
      new MovieClip();
       
      
      public var isPlaying:Boolean = false;
      
      public var obj:Object = null;
      
      public var prop:String = "";
      
      public var func:Function;
      
      public var begin:Number = NaN;
      
      public var change:Number = NaN;
      
      public var useSeconds:Boolean = false;
      
      public var prevTime:Number = NaN;
      
      public var prevPos:Number = NaN;
      
      public var looping:Boolean = false;
      
      private var _duration:Number = NaN;
      
      private var _time:Number = NaN;
      
      private var _fps:Number = NaN;
      
      private var _position:Number = NaN;
      
      private var _startTime:Number = NaN;
      
      private var _intervalID:uint = 0;
      
      private var _finish:Number = NaN;
      
      private var _timer:Timer = null;
      
      public function Tween(param1:Object, param2:String, param3:Function, param4:Number, param5:Number, param6:Number, param7:Boolean = false)
      {
         // method body index: 618 method index: 618
         this.func = function(param1:Number, param2:Number, param3:Number, param4:Number):// method body index: 605 method index: 605
         Number
         {
            // method body index: 605 method index: 605
            return param3 * param1 / param4 + param2;
         };
         super();
         if(!arguments.length)
         {
            return;
         }
         this.obj = param1;
         this.prop = param2;
         this.begin = param4;
         this.position = param4;
         this.duration = param6;
         this.useSeconds = param7;
         if(param3 is Function)
         {
            this.func = param3;
         }
         this.finish = param5;
         this._timer = new Timer(100);
         this.start();
      }
      
      public function get time() : Number
      {
         // method body index: 606 method index: 606
         return this._time;
      }
      
      public function set time(param1:Number) : void
      {
         // method body index: 607 method index: 607
         this.prevTime = this._time;
         if(param1 > this.duration)
         {
            if(this.looping)
            {
               this.rewind(param1 - this._duration);
               this.update();
               this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_LOOP,this._time,this._position));
            }
            else
            {
               if(this.useSeconds)
               {
                  this._time = this._duration;
                  this.update();
               }
               this.stop();
               this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_FINISH,this._time,this._position));
            }
         }
         else if(param1 < 0)
         {
            this.rewind();
            this.update();
         }
         else
         {
            this._time = param1;
            this.update();
         }
      }
      
      public function get duration() : Number
      {
         // method body index: 608 method index: 608
         return this._duration;
      }
      
      public function set duration(param1:Number) : void
      {
         // method body index: 609 method index: 609
         this._duration = param1 <= 0?Number(Infinity):Number(param1);
      }
      
      public function get FPS() : Number
      {
         // method body index: 610 method index: 610
         return this._fps;
      }
      
      public function set FPS(param1:Number) : void
      {
         // method body index: 611 method index: 611
         var _loc2_:Boolean = this.isPlaying;
         this.stopEnterFrame();
         this._fps = param1;
         if(_loc2_)
         {
            this.startEnterFrame();
         }
      }
      
      public function get position() : Number
      {
         // method body index: 612 method index: 612
         return this.getPosition(this._time);
      }
      
      public function set position(param1:Number) : void
      {
         // method body index: 613 method index: 613
         this.setPosition(param1);
      }
      
      public function getPosition(param1:Number = NaN) : Number
      {
         // method body index: 614 method index: 614
         if(isNaN(param1))
         {
            param1 = this._time;
         }
         return this.func(param1,this.begin,this.change,this._duration);
      }
      
      public function setPosition(param1:Number) : void
      {
         // method body index: 615 method index: 615
         this.prevPos = this._position;
         if(this.prop.length)
         {
            this.obj[this.prop] = this._position = param1;
         }
         this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_CHANGE,this._time,this._position));
      }
      
      public function get finish() : Number
      {
         // method body index: 616 method index: 616
         return this.begin + this.change;
      }
      
      public function set finish(param1:Number) : void
      {
         // method body index: 617 method index: 617
         this.change = param1 - this.begin;
      }
      
      public function continueTo(param1:Number, param2:Number) : void
      {
         // method body index: 619 method index: 619
         this.begin = this.position;
         this.finish = param1;
         if(!isNaN(param2))
         {
            this.duration = param2;
         }
         this.start();
      }
      
      public function yoyo() : void
      {
         // method body index: 620 method index: 620
         this.continueTo(this.begin,this.time);
      }
      
      protected function startEnterFrame() : void
      {
         // method body index: 621 method index: 621
         var _loc1_:Number = NaN;
         if(isNaN(this._fps))
         {
            _mc.addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
         }
         else
         {
            _loc1_ = 1000 / this._fps;
            this._timer.delay = _loc1_;
            this._timer.addEventListener(TimerEvent.TIMER,this.timerHandler,false,0,true);
            this._timer.start();
         }
         this.isPlaying = true;
      }
      
      protected function stopEnterFrame() : void
      {
         // method body index: 622 method index: 622
         if(isNaN(this._fps))
         {
            _mc.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         else
         {
            this._timer.stop();
         }
         this.isPlaying = false;
      }
      
      public function start() : void
      {
         // method body index: 623 method index: 623
         this.rewind();
         this.startEnterFrame();
         this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_START,this._time,this._position));
      }
      
      public function stop() : void
      {
         // method body index: 624 method index: 624
         this.stopEnterFrame();
         this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_STOP,this._time,this._position));
      }
      
      public function resume() : void
      {
         // method body index: 625 method index: 625
         this.fixTime();
         this.startEnterFrame();
         this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_RESUME,this._time,this._position));
      }
      
      public function rewind(param1:Number = 0) : void
      {
         // method body index: 626 method index: 626
         this._time = param1;
         this.fixTime();
         this.update();
      }
      
      public function fforward() : void
      {
         // method body index: 627 method index: 627
         this.time = this._duration;
         this.fixTime();
      }
      
      public function nextFrame() : void
      {
         // method body index: 628 method index: 628
         if(this.useSeconds)
         {
            this.time = (getTimer() - this._startTime) / 1000;
         }
         else
         {
            this.time = this._time + 1;
         }
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         // method body index: 629 method index: 629
         this.nextFrame();
      }
      
      protected function timerHandler(param1:TimerEvent) : void
      {
         // method body index: 630 method index: 630
         this.nextFrame();
         param1.updateAfterEvent();
      }
      
      public function prevFrame() : void
      {
         // method body index: 631 method index: 631
         if(!this.useSeconds)
         {
            this.time = this._time - 1;
         }
      }
      
      private function fixTime() : void
      {
         // method body index: 632 method index: 632
         if(this.useSeconds)
         {
            this._startTime = getTimer() - this._time * 1000;
         }
      }
      
      private function update() : void
      {
         // method body index: 633 method index: 633
         this.setPosition(this.getPosition(this._time));
      }
   }
}
