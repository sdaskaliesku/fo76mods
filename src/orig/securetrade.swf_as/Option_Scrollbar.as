package 
{
    import Shared.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    
    public class Option_Scrollbar extends flash.display.MovieClip
    {
        public function Option_Scrollbar()
        {
            super();
            this.fMinThumbX = this.Track_mc.x;
            this.fMaxThumbX = this.Track_mc.x + this.Track_mc.width - this.Thumb_mc.width;
            addEventListener(flash.events.MouseEvent.CLICK, this.onClick);
            this.Thumb_mc.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onThumbMouseDown);
            return;
        }

        public function get MinValue():Number
        {
            return this.fMinValue;
        }

        internal function onThumbMouseUp(arg1:flash.events.MouseEvent):*
        {
            this.Thumb_mc.stopDrag();
            this.bDragging = false;
            Shared.GlobalFunc.PlayMenuSound("UIMenuQuantity");
            if (this.bDisabled) 
            {
                dispatchEvent(new flash.events.Event(VALUE_CHANGE_FAILED, true, true));
            }
            else 
            {
                stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onThumbMouseUp);
                stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onThumbMouseMove);
                dispatchEvent(new flash.events.Event(VALUE_CHANGE, true, true));
            }
            return;
        }

        internal function onThumbMouseMove(arg1:flash.events.MouseEvent):*
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this.bDisabled) 
            {
                dispatchEvent(new flash.events.Event(VALUE_CHANGE_FAILED, true, true));
            }
            else 
            {
                loc1 = this.Thumb_mc.x;
                loc2 = (loc1 - this.fMinThumbX) / (this.fMaxThumbX - this.fMinThumbX);
                this.value = this.MinValue + loc2 * (this.MaxValue - this.MinValue);
                dispatchEvent(new flash.events.Event(VALUE_CHANGE, true, true));
            }
            return;
        }

        internal function onThumbMouseDown(arg1:flash.events.MouseEvent):*
        {
            this.Thumb_mc.startDrag(false, new flash.geom.Rectangle(this.fMinThumbX, this.Thumb_mc.y, this.fMaxThumbX - this.fMinThumbX, 0));
            this.bDragging = true;
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onThumbMouseUp);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onThumbMouseMove);
            return;
        }

        public function onClick(arg1:flash.events.MouseEvent):*
        {
            if (arg1.target != this.LeftCatcher_mc) 
            {
                if (arg1.target != this.RightCatcher_mc) 
                {
                    if (arg1.target == this.BarCatcher_mc) 
                    {
                        if (this.bDisabled) 
                        {
                            dispatchEvent(new flash.events.Event(VALUE_CHANGE_FAILED, true, true));
                        }
                        else 
                        {
                            this.value = (arg1.currentTarget.mouseX - this.BarCatcher_mc.x) / this.BarCatcher_mc.width * (this.fMaxValue - this.fMinValue);
                            dispatchEvent(new flash.events.Event(VALUE_CHANGE, true, true));
                        }
                        Shared.GlobalFunc.PlayMenuSound("UIMenuQuantity");
                    }
                }
                else 
                {
                    this.Increment();
                }
            }
            else 
            {
                this.Decrement();
            }
            return;
        }

        public function HandleKeyboardInput(arg1:flash.events.KeyboardEvent):*
        {
            if (arg1.keyCode == flash.ui.Keyboard.LEFT && this.value > 0) 
            {
                this.Decrement();
            }
            else if (arg1.keyCode == flash.ui.Keyboard.RIGHT && this.value < 1) 
            {
                this.Increment();
            }
            return;
        }

        public function Increment():*
        {
            if (this.bDisabled) 
            {
                dispatchEvent(new flash.events.Event(VALUE_CHANGE_FAILED, true, true));
            }
            else 
            {
                this.value = this.value + this.fStepSize;
                dispatchEvent(new flash.events.Event(VALUE_CHANGE, true, true));
            }
            Shared.GlobalFunc.PlayMenuSound("UIMenuQuantity");
            return;
        }

        public function Decrement():*
        {
            if (this.bDisabled) 
            {
                dispatchEvent(new flash.events.Event(VALUE_CHANGE_FAILED, true, true));
            }
            else 
            {
                this.value = this.value - this.fStepSize;
                dispatchEvent(new flash.events.Event(VALUE_CHANGE, true, true));
            }
            Shared.GlobalFunc.PlayMenuSound("UIMenuQuantity");
            return;
        }

        public function set value(arg1:Number):*
        {
            var loc1:*=NaN;
            this.fValue = Math.min(Math.max(arg1, this.fMinValue), this.fMaxValue);
            if (!this.bDragging) 
            {
                if (this.fMinValue >= this.fMaxValue) 
                {
                    loc1 = 1;
                }
                else 
                {
                    loc1 = (this.fValue - this.fMinValue) / (this.fMaxValue - this.fMinValue);
                }
                this.Thumb_mc.x = this.fMinThumbX + loc1 * (this.fMaxThumbX - this.fMinThumbX);
            }
            return;
        }

        public function get value():Number
        {
            return this.fValue;
        }

        public function set StepSize(arg1:Number):*
        {
            this.fStepSize = arg1;
            return;
        }

        public function get StepSize():Number
        {
            return this.fStepSize;
        }

        public function set MaxValue(arg1:Number):*
        {
            this.fMaxValue = arg1;
            return;
        }

        public function get MaxValue():Number
        {
            return this.fMaxValue;
        }

        public function set MinValue(arg1:Number):*
        {
            this.fMinValue = arg1;
            return;
        }

        public static const VALUE_CHANGE:String="Option_Scrollbar::VALUE_CHANGE";

        public static const VALUE_CHANGE_FAILED:String="Option_Scrollbar::VALUE_CHANGE_FAILED";

        public var Track_mc:flash.display.MovieClip;

        internal var iStartDragThumb:int;

        internal var fStepSize:Number=0.05;

        internal var fMaxValue:Number=1;

        internal var fMinValue:Number=0;

        protected var bDragging:Boolean=false;

        protected var fMaxThumbX:Number;

        protected var fMinThumbX:Number;

        internal var fValue:Number;

        public var BarCatcher_mc:flash.display.MovieClip;

        public var RightCatcher_mc:flash.display.MovieClip;

        public var LeftCatcher_mc:flash.display.MovieClip;

        public var RightArrow_mc:flash.display.MovieClip;

        public var LeftArrow_mc:flash.display.MovieClip;

        public var Thumb_mc:flash.display.MovieClip;

        internal var fStartValue:Number;

        public var bDisabled:Boolean=false;
    }
}
