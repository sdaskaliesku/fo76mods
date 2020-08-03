package Shared.AS3 
{
    import Shared.*;
    import Shared.AS3.Events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    
    public class BSSlider extends Shared.AS3.BSUIComponent
    {
        public function BSSlider()
        {
            super();
            this._fillBaseSizePos = new flash.geom.Rectangle(this.Fill_mc.x, this.Fill_mc.y, this.Fill_mc.width, this.Fill_mc.height);
            this._MarkerBaseSizePos = new flash.geom.Rectangle(this.Marker_mc.x, this.Marker_mc.y, this.Marker_mc.width, this.Marker_mc.height);
            this.updateConstraints();
            this._bIsDragging = false;
            this._iMinValue = 0;
            this._iMaxValue = 1;
            this.value = this._iMinValue;
            this._iControllerBumperJumpSize = 1;
            this._iControllerTriggerJumpSize = 3;
            this.Marker_mc.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onBeginDrag);
            this.Marker_mc.buttonMode = true;
            return;
        }

        public function get value():uint
        {
            return this._iValue;
        }

        public function set value(arg1:uint):*
        {
            this.doSetValue(arg1);
            return;
        }

        public function doSetValue(arg1:uint, arg2:Boolean=true):void
        {
            this._iValue = Math.min(Math.max(arg1, this._iMinValue), this._iMaxValue);
            if (this._bVertical) 
            {
                this.Marker_mc.y = this.markerPosition;
            }
            else 
            {
                this.Marker_mc.x = this.markerPosition;
            }
            if (arg2 && this._bDispatchOnValueChange) 
            {
                dispatchEvent(new Shared.AS3.Events.CustomEvent(VALUE_CHANGED, this.value, true, true));
            }
            SetIsDirty();
            return;
        }

        public function valueJump(arg1:int):*
        {
            if (arg1 < 0 && -arg1 > this._iValue) 
            {
                this.value = 1;
            }
            else 
            {
                this.value = Math.min(Math.max(this._iValue + arg1, this._iMinValue), this._iMaxValue);
            }
            return;
        }

        public function get maxValue():uint
        {
            return this._iMaxValue;
        }

        public function set maxValue(arg1:uint):*
        {
            this._iMaxValue = Math.max(arg1, 1);
            if (this._iValue > this._iMaxValue) 
            {
                this.value = this._iMaxValue;
            }
            SetIsDirty();
            return;
        }

        public function get sliderLength():Number
        {
            if (this._bHandleSizeViaContents) 
            {
                return this._fFillLength - this.handleSize;
            }
            return this._fFillLength;
        }

        public function get markerPosition():Number
        {
            var loc1:*=this._iValue / this._iMaxValue;
            var loc2:*=this._fMinPosition + loc1 * this.sliderLength;
            return loc2;
        }

        public function get controllerBumberJumpSize():uint
        {
            return this._iControllerBumperJumpSize;
        }

        public function set controllerBumberJumpSize(arg1:uint):*
        {
            this._iControllerBumperJumpSize = arg1;
            return;
        }

        public function get controllerTriggerJumpSize():uint
        {
            return this._iControllerTriggerJumpSize;
        }

        public function set controllerTriggerJumpSize(arg1:uint):*
        {
            this._iControllerTriggerJumpSize = arg1;
            return;
        }

        internal function onBeginDrag(arg1:flash.events.MouseEvent):*
        {
            this._bIsDragging = true;
            this._HandleDragStartPosOffset = this._bVertical ? mouseY - this.Marker_mc.y : mouseX - this.Marker_mc.x;
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onReleaseDrag);
            stage.addEventListener(flash.events.Event.ENTER_FRAME, this.onValueDrag);
            return;
        }

        internal function onReleaseDrag(arg1:flash.events.MouseEvent):*
        {
            if (this._bIsDragging) 
            {
                stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onReleaseDrag);
                stage.removeEventListener(flash.events.Event.ENTER_FRAME, this.onValueDrag);
                this.onValueDrag(null);
                this._bIsDragging = false;
            }
            return;
        }

        internal function onValueDrag(arg1:flash.events.Event):*
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (this._bIsDragging) 
            {
                if (this._bVertical) 
                {
                    this.Marker_mc.y = Shared.GlobalFunc.Clamp(mouseY - this._HandleDragStartPosOffset, this._SliderMarkerBoundBox.y, this._SliderMarkerBoundBox.y + this.sliderLength);
                }
                else 
                {
                    this.Marker_mc.x = Shared.GlobalFunc.Clamp(mouseX - this._HandleDragStartPosOffset, this._SliderMarkerBoundBox.x, this._SliderMarkerBoundBox.x + this.sliderLength);
                }
                loc1 = this._bVertical ? this.Marker_mc.y : this.Marker_mc.x;
                loc2 = this._bVertical ? this._SliderMarkerBoundBox.y : this._SliderMarkerBoundBox.x;
                loc3 = this._bVertical ? this._SliderMarkerBoundBox.y + this.sliderLength : this._SliderMarkerBoundBox.x + this.sliderLength;
                loc4 = (loc1 - loc2) / (loc3 - loc2);
                this.value = this._iMinValue + Math.round(loc4 * (this._iMaxValue - this._iMinValue));
            }
            return;
        }

        internal function onKeyDownHandler(arg1:flash.events.KeyboardEvent):*
        {
            if (arg1.keyCode != flash.ui.Keyboard.LEFT) 
            {
                if (arg1.keyCode == flash.ui.Keyboard.RIGHT) 
                {
                    this.valueJump(1);
                    arg1.stopPropagation();
                }
            }
            else 
            {
                this.valueJump(-1);
                arg1.stopPropagation();
            }
            return;
        }

        internal function onMouseWheelHandler(arg1:flash.events.MouseEvent):*
        {
            if (arg1.delta < 0) 
            {
                this.valueJump(-1);
            }
            else if (arg1.delta > 0) 
            {
                this.valueJump(1);
            }
            arg1.stopPropagation();
            return;
        }

        public function onArrowClickHandler(arg1:flash.events.MouseEvent):*
        {
            var loc1:*=arg1.target as flash.display.MovieClip;
            if (arg1.target != this.LeftArrow_mc) 
            {
                if (arg1.target == this.RightArrow_mc) 
                {
                    this.valueJump(this._iControllerBumperJumpSize);
                }
            }
            else 
            {
                this.valueJump(-this._iControllerBumperJumpSize);
            }
            return;
        }

        public function onSliderBarMouseClickHandler(arg1:flash.events.MouseEvent):*
        {
            var loc1:*=this._bVertical ? mouseY : mouseX;
            var loc2:*=loc1 / this.sliderLength * (this._iMaxValue - this._iMinValue);
            this.value = loc2;
            return;
        }

        public function ProcessUserEvent(arg1:String, arg2:Boolean):Boolean
        {
            var loc1:*=false;
            if (!arg2) 
            {
                if (arg1 != "LShoulder") 
                {
                    if (arg1 != "RShoulder") 
                    {
                        if (arg1 != "LTrigger") 
                        {
                            if (arg1 == "RTrigger") 
                            {
                                this.valueJump(this._iControllerTriggerJumpSize);
                                loc1 = true;
                            }
                        }
                        else 
                        {
                            this.valueJump(-this._iControllerTriggerJumpSize);
                            loc1 = true;
                        }
                    }
                    else 
                    {
                        this.valueJump(this._iControllerBumperJumpSize);
                        loc1 = true;
                    }
                }
                else 
                {
                    this.valueJump(-this._iControllerBumperJumpSize);
                    loc1 = true;
                }
            }
            return loc1;
        }

        public function addParentScrollEvents():void
        {
            parent.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
            parent.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            this._bParentMouseHandler = true;
            return;
        }

        public override function onRemovedFromStage():void
        {
            super.onRemovedFromStage();
            if (this._bParentMouseHandler) 
            {
                parent.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
                parent.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            }
            if (this.LeftArrow_mc != null) 
            {
                this.LeftArrow_mc.removeEventListener(flash.events.MouseEvent.CLICK, this.onArrowClickHandler);
            }
            if (this.RightArrow_mc != null) 
            {
                this.RightArrow_mc.removeEventListener(flash.events.MouseEvent.CLICK, this.onArrowClickHandler);
            }
            this.SliderBackground_mc.removeEventListener(flash.events.MouseEvent.CLICK, this.onSliderBarMouseClickHandler);
            return;
        }

        public function set handleSizeViaContents(arg1:Boolean):void
        {
            this._bHandleSizeViaContents = arg1;
            SetIsDirty();
            return;
        }

        public function set dispatchOnValueChange(arg1:Boolean):void
        {
            this._bDispatchOnValueChange = arg1;
            return;
        }

        public function get dispatchOnValueChange():Boolean
        {
            return this._bDispatchOnValueChange;
        }

        public override function redrawUIComponent():void
        {
            super.redrawUIComponent();
            this.updateHandleSize();
            var loc1:*=this.markerPosition;
            if (this._bVertical) 
            {
                this.Marker_mc.y = loc1;
                this.Fill_mc.height = loc1 - this.Fill_mc.y;
            }
            else 
            {
                this.Marker_mc.x = loc1;
                this.Fill_mc.width = loc1 - this.Fill_mc.x;
            }
            return;
        }

        public function updateConstraints():void
        {
            if (this._bVertical) 
            {
                this._fMinPosition = this._fillBaseSizePos.y + FILL_MIN_POS_OFFSET;
                this._fMaxPosition = this._fillBaseSizePos.y + this._fillBaseSizePos.height;
                this._SliderMarkerBoundBox = new flash.geom.Rectangle(this._fillBaseSizePos.x, this._fillBaseSizePos.y, 0, this._fillBaseSizePos.height);
                this.Fill_mc.width = this._fillBaseSizePos.width;
                this.Marker_mc.x = this._MarkerBaseSizePos.x;
            }
            else 
            {
                this._fMinPosition = this._fillBaseSizePos.x + FILL_MIN_POS_OFFSET;
                this._fMaxPosition = this._fillBaseSizePos.x + this._fillBaseSizePos.width;
                this._SliderMarkerBoundBox = new flash.geom.Rectangle(this._fillBaseSizePos.x, this._fillBaseSizePos.y, this._fillBaseSizePos.width, 0);
                this.Fill_mc.height = this._fillBaseSizePos.height;
                this.Marker_mc.y = this._MarkerBaseSizePos.y;
            }
            this._fFillLength = this._fMaxPosition - this._fMinPosition;
            return;
        }

        public function set bVertical(arg1:Boolean):void
        {
            this._bVertical = arg1;
            this.updateConstraints();
            return;
        }

        internal function updateHandleSize():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (this._bHandleSizeViaContents) 
            {
                loc1 = this._iMaxValue - this._iMinValue;
                loc2 = HANDLE_SIZE_VALUE_DELTA_MAX / loc1;
                loc3 = Shared.GlobalFunc.Clamp(loc2, HANDLE_SIZE_MIN_PERCENT, HANDLE_SIZE_MAX_PERCENT);
                if (this._bVertical) 
                {
                    this.Marker_mc.width = this._MarkerBaseSizePos.width;
                    this.Marker_mc.height = this._fFillLength * loc3;
                }
                else 
                {
                    this.Marker_mc.width = this._fFillLength * loc3;
                    this.Marker_mc.height = this._MarkerBaseSizePos.height;
                }
                this._fHandleSize = this._bVertical ? this.Marker_mc.height : this.Marker_mc.width;
            }
            return;
        }

        public function get handleSize():Number
        {
            return this._fHandleSize;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            if (this.LeftArrow_mc != null) 
            {
                this.LeftArrow_mc.addEventListener(flash.events.MouseEvent.CLICK, this.onArrowClickHandler);
            }
            if (this.RightArrow_mc != null) 
            {
                this.RightArrow_mc.addEventListener(flash.events.MouseEvent.CLICK, this.onArrowClickHandler);
            }
            this.SliderBackground_mc.addEventListener(flash.events.MouseEvent.CLICK, this.onSliderBarMouseClickHandler);
            return;
        }

        public function get minValue():uint
        {
            return this._iMinValue;
        }

        public function set minValue(arg1:uint):*
        {
            this._iMinValue = Math.min(arg1, this._iMaxValue);
            if (this._iValue < this._iMinValue) 
            {
                this.value = this._iMinValue;
            }
            SetIsDirty();
            return;
        }

        public static const VALUE_CHANGED:String="Slider::ValueChanged";

        public static const FILL_MIN_POS_OFFSET:Number=2;

        public static const HANDLE_SIZE_VALUE_DELTA_MAX:Number=8;

        public static const HANDLE_SIZE_MIN_PERCENT:Number=0.25;

        public static const HANDLE_SIZE_MAX_PERCENT:Number=0.75;

        public var SliderBackground_mc:flash.display.MovieClip;

        public var Marker_mc:flash.display.MovieClip;

        public var Fill_mc:flash.display.MovieClip;

        public var LeftArrow_mc:flash.display.MovieClip;

        public var RightArrow_mc:flash.display.MovieClip;

        internal var _iMaxValue:uint;

        internal var _iMinValue:uint;

        internal var _fFillLength:Number;

        internal var _fMinPosition:Number;

        internal var _fMaxPosition:Number;

        internal var _SliderMarkerBoundBox:flash.geom.Rectangle;

        internal var _bIsDragging:Boolean;

        internal var _iControllerBumperJumpSize:*;

        internal var _iControllerTriggerJumpSize:*;

        internal var _bVertical:Boolean=false;

        internal var _fillBaseSizePos:flash.geom.Rectangle;

        internal var _MarkerBaseSizePos:flash.geom.Rectangle;

        internal var _bDispatchOnValueChange:Boolean=true;

        internal var _bHandleSizeViaContents:Boolean=false;

        internal var _HandleDragStartPosOffset:Number=0;

        internal var _fHandleSize:Number=0;

        internal var _bParentMouseHandler:Boolean=true;

        internal var _iValue:uint;
    }
}
