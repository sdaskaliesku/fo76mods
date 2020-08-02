 
package Shared.AS3
{
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   
   public class BSSlider extends BSUIComponent
   {
      
      public static const VALUE_CHANGED:String = // method body index: 1631 method index: 1631
      "Slider::ValueChanged";
      
      public static const FILL_MIN_POS_OFFSET:Number = // method body index: 1631 method index: 1631
      2;
      
      public static const HANDLE_SIZE_VALUE_DELTA_MAX:Number = // method body index: 1631 method index: 1631
      8;
      
      public static const HANDLE_SIZE_MIN_PERCENT:Number = // method body index: 1631 method index: 1631
      0.25;
      
      public static const HANDLE_SIZE_MAX_PERCENT:Number = // method body index: 1631 method index: 1631
      0.75;
       
      
      public var SliderBackground_mc:MovieClip;
      
      public var Marker_mc:MovieClip;
      
      public var Fill_mc:MovieClip;
      
      public var LeftArrow_mc:MovieClip;
      
      public var RightArrow_mc:MovieClip;
      
      private var _iMaxValue:uint;
      
      private var _iValue:uint;
      
      private var _iMinValue:uint;
      
      private var _fFillLength:Number;
      
      private var _fMinPosition:Number;
      
      private var _fMaxPosition:Number;
      
      private var _SliderMarkerBoundBox:Rectangle;
      
      private var _bIsDragging:Boolean;
      
      private var _iControllerBumperJumpSize;
      
      private var _iControllerTriggerJumpSize;
      
      private var _bVertical:Boolean = false;
      
      private var _fillBaseSizePos:Rectangle;
      
      private var _MarkerBaseSizePos:Rectangle;
      
      private var _bDispatchOnValueChange:Boolean = true;
      
      private var _bHandleSizeViaContents:Boolean = false;
      
      private var _HandleDragStartPosOffset:Number = 0;
      
      private var _fHandleSize:Number = 0;
      
      private var _bParentMouseHandler:Boolean = true;
      
      public function BSSlider()
      {
         // method body index: 1637 method index: 1637
         super();
         this._fillBaseSizePos = new Rectangle(this.Fill_mc.x,this.Fill_mc.y,this.Fill_mc.width,this.Fill_mc.height);
         this._MarkerBaseSizePos = new Rectangle(this.Marker_mc.x,this.Marker_mc.y,this.Marker_mc.width,this.Marker_mc.height);
         this.updateConstraints();
         this._bIsDragging = false;
         this._iMinValue = 0;
         this._iMaxValue = 1;
         this.value = this._iMinValue;
         this._iControllerBumperJumpSize = 1;
         this._iControllerTriggerJumpSize = 3;
         this.Marker_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.onBeginDrag);
         this.Marker_mc.buttonMode = true;
      }
      
      public function set handleSizeViaContents(aValue:Boolean) : void
      {
         // method body index: 1632 method index: 1632
         this._bHandleSizeViaContents = aValue;
         SetIsDirty();
      }
      
      public function set dispatchOnValueChange(aVal:Boolean) : void
      {
         // method body index: 1633 method index: 1633
         this._bDispatchOnValueChange = aVal;
      }
      
      public function get dispatchOnValueChange() : Boolean
      {
         // method body index: 1634 method index: 1634
         return this._bDispatchOnValueChange;
      }
      
      public function updateConstraints() : void
      {
         // method body index: 1635 method index: 1635
         if(this._bVertical)
         {
            this._fMinPosition = this._fillBaseSizePos.y + FILL_MIN_POS_OFFSET;
            this._fMaxPosition = this._fillBaseSizePos.y + this._fillBaseSizePos.height;
            this._SliderMarkerBoundBox = new Rectangle(this._fillBaseSizePos.x,this._fillBaseSizePos.y,0,this._fillBaseSizePos.height);
            this.Fill_mc.width = this._fillBaseSizePos.width;
            this.Marker_mc.x = this._MarkerBaseSizePos.x;
         }
         else
         {
            this._fMinPosition = this._fillBaseSizePos.x + FILL_MIN_POS_OFFSET;
            this._fMaxPosition = this._fillBaseSizePos.x + this._fillBaseSizePos.width;
            this._SliderMarkerBoundBox = new Rectangle(this._fillBaseSizePos.x,this._fillBaseSizePos.y,this._fillBaseSizePos.width,0);
            this.Fill_mc.height = this._fillBaseSizePos.height;
            this.Marker_mc.y = this._MarkerBaseSizePos.y;
         }
         this._fFillLength = this._fMaxPosition - this._fMinPosition;
      }
      
      public function set bVertical(aVertical:Boolean) : void
      {
         // method body index: 1636 method index: 1636
         this._bVertical = aVertical;
         this.updateConstraints();
      }
      
      private function updateHandleSize() : void
      {
         // method body index: 1638 method index: 1638
         var valueDelta:Number = NaN;
         var valueRangePercent:Number = NaN;
         var valueRangePercentClamped:Number = NaN;
         if(this._bHandleSizeViaContents)
         {
            valueDelta = this._iMaxValue - this._iMinValue;
            valueRangePercent = HANDLE_SIZE_VALUE_DELTA_MAX / valueDelta;
            valueRangePercentClamped = GlobalFunc.Clamp(valueRangePercent,HANDLE_SIZE_MIN_PERCENT,HANDLE_SIZE_MAX_PERCENT);
            if(this._bVertical)
            {
               this.Marker_mc.width = this._MarkerBaseSizePos.width;
               this.Marker_mc.height = this._fFillLength * valueRangePercentClamped;
            }
            else
            {
               this.Marker_mc.width = this._fFillLength * valueRangePercentClamped;
               this.Marker_mc.height = this._MarkerBaseSizePos.height;
            }
            this._fHandleSize = !!this._bVertical?Number(this.Marker_mc.height):Number(this.Marker_mc.width);
         }
      }
      
      public function get handleSize() : Number
      {
         // method body index: 1639 method index: 1639
         return this._fHandleSize;
      }
      
      public function get sliderLength() : Number
      {
         // method body index: 1640 method index: 1640
         if(this._bHandleSizeViaContents)
         {
            return this._fFillLength - this.handleSize;
         }
         return this._fFillLength;
      }
      
      public function get minValue() : uint
      {
         // method body index: 1641 method index: 1641
         return this._iMinValue;
      }
      
      public function set minValue(aVal:uint) : *
      {
         // method body index: 1642 method index: 1642
         this._iMinValue = Math.min(aVal,this._iMaxValue);
         if(this._iValue < this._iMinValue)
         {
            this.value = this._iMinValue;
         }
         SetIsDirty();
      }
      
      public function get value() : uint
      {
         // method body index: 1643 method index: 1643
         return this._iValue;
      }
      
      public function set value(aVal:uint) : *
      {
         // method body index: 1644 method index: 1644
         this.doSetValue(aVal);
      }
      
      public function doSetValue(aVal:uint, aDispatch:Boolean = true) : void
      {
         // method body index: 1645 method index: 1645
         this._iValue = Math.min(Math.max(aVal,this._iMinValue),this._iMaxValue);
         if(this._bVertical)
         {
            this.Marker_mc.y = this.markerPosition;
         }
         else
         {
            this.Marker_mc.x = this.markerPosition;
         }
         if(aDispatch && this._bDispatchOnValueChange)
         {
            dispatchEvent(new CustomEvent(VALUE_CHANGED,this.value,true,true));
         }
         SetIsDirty();
      }
      
      public function valueJump(aDelta:int) : *
      {
         // method body index: 1646 method index: 1646
         if(aDelta < 0 && -aDelta > this._iValue)
         {
            this.value = 1;
         }
         else
         {
            this.value = Math.min(Math.max(this._iValue + aDelta,this._iMinValue),this._iMaxValue);
         }
      }
      
      public function get maxValue() : uint
      {
         // method body index: 1647 method index: 1647
         return this._iMaxValue;
      }
      
      public function set maxValue(aVal:uint) : *
      {
         // method body index: 1648 method index: 1648
         this._iMaxValue = Math.max(aVal,1);
         if(this._iValue > this._iMaxValue)
         {
            this.value = this._iMaxValue;
         }
         SetIsDirty();
      }
      
      public function get markerPosition() : Number
      {
         // method body index: 1649 method index: 1649
         var finterp:Number = this._iValue / this._iMaxValue;
         var i:Number = this._fMinPosition + finterp * this.sliderLength;
         return i;
      }
      
      public function get controllerBumberJumpSize() : uint
      {
         // method body index: 1650 method index: 1650
         return this._iControllerBumperJumpSize;
      }
      
      public function set controllerBumberJumpSize(aVal:uint) : *
      {
         // method body index: 1651 method index: 1651
         this._iControllerBumperJumpSize = aVal;
      }
      
      public function get controllerTriggerJumpSize() : uint
      {
         // method body index: 1652 method index: 1652
         return this._iControllerTriggerJumpSize;
      }
      
      public function set controllerTriggerJumpSize(aVal:uint) : *
      {
         // method body index: 1653 method index: 1653
         this._iControllerTriggerJumpSize = aVal;
      }
      
      private function onBeginDrag(aEvent:MouseEvent) : *
      {
         // method body index: 1654 method index: 1654
         this._bIsDragging = true;
         this._HandleDragStartPosOffset = !!this._bVertical?Number(mouseY - this.Marker_mc.y):Number(mouseX - this.Marker_mc.x);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onReleaseDrag);
         stage.addEventListener(Event.ENTER_FRAME,this.onValueDrag);
      }
      
      private function onReleaseDrag(aEvent:MouseEvent) : *
      {
         // method body index: 1655 method index: 1655
         if(this._bIsDragging)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onReleaseDrag);
            stage.removeEventListener(Event.ENTER_FRAME,this.onValueDrag);
            this.onValueDrag(null);
            this._bIsDragging = false;
         }
      }
      
      private function onValueDrag(e:Event) : *
      {
         // method body index: 1656 method index: 1656
         var markerPos:Number = NaN;
         var markerMin:Number = NaN;
         var markerMax:Number = NaN;
         var lerpValue:Number = NaN;
         if(this._bIsDragging)
         {
            if(this._bVertical)
            {
               this.Marker_mc.y = GlobalFunc.Clamp(mouseY - this._HandleDragStartPosOffset,this._SliderMarkerBoundBox.y,this._SliderMarkerBoundBox.y + this.sliderLength);
            }
            else
            {
               this.Marker_mc.x = GlobalFunc.Clamp(mouseX - this._HandleDragStartPosOffset,this._SliderMarkerBoundBox.x,this._SliderMarkerBoundBox.x + this.sliderLength);
            }
            markerPos = !!this._bVertical?Number(this.Marker_mc.y):Number(this.Marker_mc.x);
            markerMin = !!this._bVertical?Number(this._SliderMarkerBoundBox.y):Number(this._SliderMarkerBoundBox.x);
            markerMax = !!this._bVertical?Number(this._SliderMarkerBoundBox.y + this.sliderLength):Number(this._SliderMarkerBoundBox.x + this.sliderLength);
            lerpValue = (markerPos - markerMin) / (markerMax - markerMin);
            this.value = this._iMinValue + Math.round(lerpValue * (this._iMaxValue - this._iMinValue));
         }
      }
      
      private function onKeyDownHandler(event:KeyboardEvent) : *
      {
         // method body index: 1657 method index: 1657
         if(event.keyCode == Keyboard.LEFT)
         {
            this.valueJump(-1);
            event.stopPropagation();
         }
         else if(event.keyCode == Keyboard.RIGHT)
         {
            this.valueJump(1);
            event.stopPropagation();
         }
      }
      
      private function onMouseWheelHandler(event:MouseEvent) : *
      {
         // method body index: 1658 method index: 1658
         if(event.delta < 0)
         {
            this.valueJump(-1);
         }
         else if(event.delta > 0)
         {
            this.valueJump(1);
         }
         event.stopPropagation();
      }
      
      public function onArrowClickHandler(event:MouseEvent) : *
      {
         // method body index: 1659 method index: 1659
         var Movie:MovieClip = event.target as MovieClip;
         if(event.target == this.LeftArrow_mc)
         {
            this.valueJump(-this._iControllerBumperJumpSize);
         }
         else if(event.target == this.RightArrow_mc)
         {
            this.valueJump(this._iControllerBumperJumpSize);
         }
      }
      
      public function onSliderBarMouseClickHandler(event:MouseEvent) : *
      {
         // method body index: 1660 method index: 1660
         var clickPos:Number = !!this._bVertical?Number(mouseY):Number(mouseX);
         var newValue:uint = clickPos / this.sliderLength * (this._iMaxValue - this._iMinValue);
         this.value = newValue;
      }
      
      public function ProcessUserEvent(strEventName:String, abPressed:Boolean) : Boolean
      {
         // method body index: 1661 method index: 1661
         var bhandled:* = false;
         if(!abPressed)
         {
            if(strEventName == "LShoulder")
            {
               this.valueJump(-this._iControllerBumperJumpSize);
               bhandled = true;
            }
            else if(strEventName == "RShoulder")
            {
               this.valueJump(this._iControllerBumperJumpSize);
               bhandled = true;
            }
            else if(strEventName == "LTrigger")
            {
               this.valueJump(-this._iControllerTriggerJumpSize);
               bhandled = true;
            }
            else if(strEventName == "RTrigger")
            {
               this.valueJump(this._iControllerTriggerJumpSize);
               bhandled = true;
            }
         }
         return bhandled;
      }
      
      public function addParentScrollEvents() : void
      {
         // method body index: 1662 method index: 1662
         parent.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         parent.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this._bParentMouseHandler = true;
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1663 method index: 1663
         super.onAddedToStage();
         if(this.LeftArrow_mc != null)
         {
            this.LeftArrow_mc.addEventListener(MouseEvent.CLICK,this.onArrowClickHandler);
         }
         if(this.RightArrow_mc != null)
         {
            this.RightArrow_mc.addEventListener(MouseEvent.CLICK,this.onArrowClickHandler);
         }
         this.SliderBackground_mc.addEventListener(MouseEvent.CLICK,this.onSliderBarMouseClickHandler);
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 1664 method index: 1664
         super.onRemovedFromStage();
         if(this._bParentMouseHandler)
         {
            parent.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
            parent.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         }
         if(this.LeftArrow_mc != null)
         {
            this.LeftArrow_mc.removeEventListener(MouseEvent.CLICK,this.onArrowClickHandler);
         }
         if(this.RightArrow_mc != null)
         {
            this.RightArrow_mc.removeEventListener(MouseEvent.CLICK,this.onArrowClickHandler);
         }
         this.SliderBackground_mc.removeEventListener(MouseEvent.CLICK,this.onSliderBarMouseClickHandler);
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1665 method index: 1665
         super.redrawUIComponent();
         this.updateHandleSize();
         var markerPos:Number = this.markerPosition;
         if(this._bVertical)
         {
            this.Marker_mc.y = markerPos;
            this.Fill_mc.height = markerPos - this.Fill_mc.y;
         }
         else
         {
            this.Marker_mc.x = markerPos;
            this.Fill_mc.width = markerPos - this.Fill_mc.x;
         }
      }
   }
}
