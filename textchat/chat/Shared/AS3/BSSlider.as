 
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
      
      public static const VALUE_CHANGED:String = // method body index: 623 method index: 623
      "Slider::ValueChanged";
      
      public static const FILL_MIN_POS_OFFSET:Number = // method body index: 623 method index: 623
      2;
      
      public static const HANDLE_SIZE_VALUE_DELTA_MAX:Number = // method body index: 623 method index: 623
      8;
      
      public static const HANDLE_SIZE_MIN_PERCENT:Number = // method body index: 623 method index: 623
      0.25;
      
      public static const HANDLE_SIZE_MAX_PERCENT:Number = // method body index: 623 method index: 623
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
      
      public function set handleSizeViaContents(param1:Boolean) : void
      {

         this._bHandleSizeViaContents = param1;
         SetIsDirty();
      }
      
      public function set dispatchOnValueChange(param1:Boolean) : void
      {

         this._bDispatchOnValueChange = param1;
      }
      
      public function get dispatchOnValueChange() : Boolean
      {

         return this._bDispatchOnValueChange;
      }
      
      public function updateConstraints() : void
      {

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
      
      public function set bVertical(param1:Boolean) : void
      {

         this._bVertical = param1;
         this.updateConstraints();
      }
      
      private function updateHandleSize() : void
      {

         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._bHandleSizeViaContents)
         {
            _loc1_ = this._iMaxValue - this._iMinValue;
            _loc2_ = HANDLE_SIZE_VALUE_DELTA_MAX / _loc1_;
            _loc3_ = GlobalFunc.Clamp(_loc2_,HANDLE_SIZE_MIN_PERCENT,HANDLE_SIZE_MAX_PERCENT);
            if(this._bVertical)
            {
               this.Marker_mc.width = this._MarkerBaseSizePos.width;
               this.Marker_mc.height = this._fFillLength * _loc3_;
            }
            else
            {
               this.Marker_mc.width = this._fFillLength * _loc3_;
               this.Marker_mc.height = this._MarkerBaseSizePos.height;
            }
            this._fHandleSize = !!this._bVertical?Number(Number(this.Marker_mc.height)):Number(Number(this.Marker_mc.width));
         }
      }
      
      public function get handleSize() : Number
      {

         return this._fHandleSize;
      }
      
      public function get sliderLength() : Number
      {

         if(this._bHandleSizeViaContents)
         {
            return this._fFillLength - this.handleSize;
         }
         return this._fFillLength;
      }
      
      public function get minValue() : uint
      {

         return this._iMinValue;
      }
      
      public function set minValue(param1:uint) : *
      {

         this._iMinValue = Math.min(param1,this._iMaxValue);
         if(this._iValue < this._iMinValue)
         {
            this.value = this._iMinValue;
         }
         SetIsDirty();
      }
      
      public function get value() : uint
      {

         return this._iValue;
      }
      
      public function set value(param1:uint) : *
      {

         this.doSetValue(param1);
      }
      
      public function doSetValue(param1:uint, param2:Boolean = true) : void
      {

         this._iValue = Math.min(Math.max(param1,this._iMinValue),this._iMaxValue);
         if(this._bVertical)
         {
            this.Marker_mc.y = this.markerPosition;
         }
         else
         {
            this.Marker_mc.x = this.markerPosition;
         }
         if(param2 && this._bDispatchOnValueChange)
         {
            dispatchEvent(new CustomEvent(VALUE_CHANGED,this.value,true,true));
         }
         SetIsDirty();
      }
      
      public function valueJump(param1:int) : *
      {

         if(param1 < 0 && -param1 > this._iValue)
         {
            this.value = 1;
         }
         else
         {
            this.value = Math.min(Math.max(this._iValue + param1,this._iMinValue),this._iMaxValue);
         }
      }
      
      public function get maxValue() : uint
      {

         return this._iMaxValue;
      }
      
      public function set maxValue(param1:uint) : *
      {

         this._iMaxValue = Math.max(param1,1);
         if(this._iValue > this._iMaxValue)
         {
            this.value = this._iMaxValue;
         }
         SetIsDirty();
      }
      
      public function get markerPosition() : Number
      {

         var _loc1_:Number = this._iValue / this._iMaxValue;
         var _loc2_:Number = this._fMinPosition + _loc1_ * this.sliderLength;
         return _loc2_;
      }
      
      public function get controllerBumberJumpSize() : uint
      {

         return this._iControllerBumperJumpSize;
      }
      
      public function set controllerBumberJumpSize(param1:uint) : *
      {

         this._iControllerBumperJumpSize = param1;
      }
      
      public function get controllerTriggerJumpSize() : uint
      {

         return this._iControllerTriggerJumpSize;
      }
      
      public function set controllerTriggerJumpSize(param1:uint) : *
      {

         this._iControllerTriggerJumpSize = param1;
      }
      
      private function onBeginDrag(param1:MouseEvent) : *
      {

         this._bIsDragging = true;
         this._HandleDragStartPosOffset = !!this._bVertical?Number(Number(mouseY - this.Marker_mc.y)):Number(Number(mouseX - this.Marker_mc.x));
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onReleaseDrag);
         stage.addEventListener(Event.ENTER_FRAME,this.onValueDrag);
      }
      
      private function onReleaseDrag(param1:MouseEvent) : *
      {

         if(this._bIsDragging)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onReleaseDrag);
            stage.removeEventListener(Event.ENTER_FRAME,this.onValueDrag);
            this.onValueDrag(null);
            this._bIsDragging = false;
         }
      }
      
      private function onValueDrag(param1:Event) : *
      {

         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
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
            _loc2_ = !!this._bVertical?Number(Number(this.Marker_mc.y)):Number(Number(this.Marker_mc.x));
            _loc3_ = !!this._bVertical?Number(Number(this._SliderMarkerBoundBox.y)):Number(Number(this._SliderMarkerBoundBox.x));
            _loc4_ = !!this._bVertical?Number(Number(this._SliderMarkerBoundBox.y + this.sliderLength)):Number(Number(this._SliderMarkerBoundBox.x + this.sliderLength));
            _loc5_ = (_loc2_ - _loc3_) / (_loc4_ - _loc3_);
            this.value = this._iMinValue + Math.round(_loc5_ * (this._iMaxValue - this._iMinValue));
         }
      }
      
      private function onKeyDownHandler(param1:KeyboardEvent) : *
      {

         if(param1.keyCode == Keyboard.LEFT)
         {
            this.valueJump(-1);
            param1.stopPropagation();
         }
         else if(param1.keyCode == Keyboard.RIGHT)
         {
            this.valueJump(1);
            param1.stopPropagation();
         }
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : *
      {

         if(param1.delta < 0)
         {
            this.valueJump(-1);
         }
         else if(param1.delta > 0)
         {
            this.valueJump(1);
         }
         param1.stopPropagation();
      }
      
      public function onArrowClickHandler(param1:MouseEvent) : *
      {

         var _loc2_:MovieClip = param1.target as MovieClip;
         if(param1.target == this.LeftArrow_mc)
         {
            this.valueJump(-this._iControllerBumperJumpSize);
         }
         else if(param1.target == this.RightArrow_mc)
         {
            this.valueJump(this._iControllerBumperJumpSize);
         }
      }
      
      public function onSliderBarMouseClickHandler(param1:MouseEvent) : *
      {

         var _loc2_:Number = !!this._bVertical?Number(Number(mouseY)):Number(Number(mouseX));
         var _loc3_:uint = _loc2_ / this.sliderLength * (this._iMaxValue - this._iMinValue);
         this.value = _loc3_;
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {

         var _loc3_:* = false;
         if(!param2)
         {
            if(param1 == "LShoulder")
            {
               this.valueJump(-this._iControllerBumperJumpSize);
               _loc3_ = true;
            }
            else if(param1 == "RShoulder")
            {
               this.valueJump(this._iControllerBumperJumpSize);
               _loc3_ = true;
            }
            else if(param1 == "LTrigger")
            {
               this.valueJump(-this._iControllerTriggerJumpSize);
               _loc3_ = true;
            }
            else if(param1 == "RTrigger")
            {
               this.valueJump(this._iControllerTriggerJumpSize);
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function addParentScrollEvents() : void
      {

         parent.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         parent.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this._bParentMouseHandler = true;
      }
      
      override public function onAddedToStage() : void
      {

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

         super.redrawUIComponent();
         this.updateHandleSize();
         var _loc1_:Number = this.markerPosition;
         if(this._bVertical)
         {
            this.Marker_mc.y = _loc1_;
            this.Fill_mc.height = _loc1_ - this.Fill_mc.y;
         }
         else
         {
            this.Marker_mc.x = _loc1_;
            this.Fill_mc.width = _loc1_ - this.Fill_mc.x;
         }
      }
   }
}
