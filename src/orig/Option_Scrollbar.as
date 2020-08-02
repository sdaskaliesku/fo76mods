 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   
   public class Option_Scrollbar extends MovieClip
   {
      
      public static const VALUE_CHANGE:String = // method body index: 1144 method index: 1144
      "Option_Scrollbar::VALUE_CHANGE";
      
      public static const VALUE_CHANGE_FAILED:String = // method body index: 1144 method index: 1144
      "Option_Scrollbar::VALUE_CHANGE_FAILED";
       
      
      public var Track_mc:MovieClip;
      
      public var Thumb_mc:MovieClip;
      
      public var LeftArrow_mc:MovieClip;
      
      public var RightArrow_mc:MovieClip;
      
      public var LeftCatcher_mc:MovieClip;
      
      public var RightCatcher_mc:MovieClip;
      
      public var BarCatcher_mc:MovieClip;
      
      private var fValue:Number;
      
      protected var fMinThumbX:Number;
      
      protected var fMaxThumbX:Number;
      
      protected var bDragging:Boolean = false;
      
      private var fMinValue:Number = 0.0;
      
      private var fMaxValue:Number = 1.0;
      
      private var fStepSize:Number = 0.05;
      
      private var iStartDragThumb:int;
      
      private var fStartValue:Number;
      
      public var bDisabled:Boolean = false;
      
      public function Option_Scrollbar()
      {
         // method body index: 1151 method index: 1151
         super();
         this.fMinThumbX = this.Track_mc.x;
         this.fMaxThumbX = this.Track_mc.x + this.Track_mc.width - this.Thumb_mc.width;
         addEventListener(MouseEvent.CLICK,this.onClick);
         this.Thumb_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.onThumbMouseDown);
      }
      
      public function get MinValue() : Number
      {
         // method body index: 1145 method index: 1145
         return this.fMinValue;
      }
      
      public function set MinValue(afMinValue:Number) : *
      {
         // method body index: 1146 method index: 1146
         this.fMinValue = afMinValue;
      }
      
      public function get MaxValue() : Number
      {
         // method body index: 1147 method index: 1147
         return this.fMaxValue;
      }
      
      public function set MaxValue(afMaxValue:Number) : *
      {
         // method body index: 1148 method index: 1148
         this.fMaxValue = afMaxValue;
      }
      
      public function get StepSize() : Number
      {
         // method body index: 1149 method index: 1149
         return this.fStepSize;
      }
      
      public function set StepSize(afStepSize:Number) : *
      {
         // method body index: 1150 method index: 1150
         this.fStepSize = afStepSize;
      }
      
      public function get value() : Number
      {
         // method body index: 1152 method index: 1152
         return this.fValue;
      }
      
      public function set value(afValue:Number) : *
      {
         // method body index: 1153 method index: 1153
         var finterp:Number = NaN;
         this.fValue = Math.min(Math.max(afValue,this.fMinValue),this.fMaxValue);
         if(!this.bDragging)
         {
            if(this.fMinValue >= this.fMaxValue)
            {
               finterp = 1;
            }
            else
            {
               finterp = (this.fValue - this.fMinValue) / (this.fMaxValue - this.fMinValue);
            }
            this.Thumb_mc.x = this.fMinThumbX + finterp * (this.fMaxThumbX - this.fMinThumbX);
         }
      }
      
      public function Decrement() : *
      {
         // method body index: 1154 method index: 1154
         if(!this.bDisabled)
         {
            this.value = this.value - this.fStepSize;
            dispatchEvent(new Event(VALUE_CHANGE,true,true));
         }
         else
         {
            dispatchEvent(new Event(VALUE_CHANGE_FAILED,true,true));
         }
         GlobalFunc.PlayMenuSound("UIMenuQuantity");
      }
      
      public function Increment() : *
      {
         // method body index: 1155 method index: 1155
         if(!this.bDisabled)
         {
            this.value = this.value + this.fStepSize;
            dispatchEvent(new Event(VALUE_CHANGE,true,true));
         }
         else
         {
            dispatchEvent(new Event(VALUE_CHANGE_FAILED,true,true));
         }
         GlobalFunc.PlayMenuSound("UIMenuQuantity");
      }
      
      public function HandleKeyboardInput(event:KeyboardEvent) : *
      {
         // method body index: 1156 method index: 1156
         if(event.keyCode == Keyboard.LEFT && this.value > 0)
         {
            this.Decrement();
         }
         else if(event.keyCode == Keyboard.RIGHT && this.value < 1)
         {
            this.Increment();
         }
      }
      
      public function onClick(event:MouseEvent) : *
      {
         // method body index: 1157 method index: 1157
         if(event.target == this.LeftCatcher_mc)
         {
            this.Decrement();
         }
         else if(event.target == this.RightCatcher_mc)
         {
            this.Increment();
         }
         else if(event.target == this.BarCatcher_mc)
         {
            if(!this.bDisabled)
            {
               this.value = (event.currentTarget.mouseX - this.BarCatcher_mc.x) / this.BarCatcher_mc.width * (this.fMaxValue - this.fMinValue);
               dispatchEvent(new Event(VALUE_CHANGE,true,true));
            }
            else
            {
               dispatchEvent(new Event(VALUE_CHANGE_FAILED,true,true));
            }
            GlobalFunc.PlayMenuSound("UIMenuQuantity");
         }
      }
      
      private function onThumbMouseDown(event:MouseEvent) : *
      {
         // method body index: 1158 method index: 1158
         this.Thumb_mc.startDrag(false,new Rectangle(this.fMinThumbX,this.Thumb_mc.y,this.fMaxThumbX - this.fMinThumbX,0));
         this.bDragging = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onThumbMouseUp);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onThumbMouseMove);
      }
      
      private function onThumbMouseMove(events:MouseEvent) : *
      {
         // method body index: 1159 method index: 1159
         var fThumbPos:Number = NaN;
         var lerpValue:Number = NaN;
         if(!this.bDisabled)
         {
            fThumbPos = this.Thumb_mc.x;
            lerpValue = (fThumbPos - this.fMinThumbX) / (this.fMaxThumbX - this.fMinThumbX);
            this.value = this.MinValue + lerpValue * (this.MaxValue - this.MinValue);
            dispatchEvent(new Event(VALUE_CHANGE,true,true));
         }
         else
         {
            dispatchEvent(new Event(VALUE_CHANGE_FAILED,true,true));
         }
      }
      
      private function onThumbMouseUp(event:MouseEvent) : *
      {
         // method body index: 1160 method index: 1160
         this.Thumb_mc.stopDrag();
         this.bDragging = false;
         GlobalFunc.PlayMenuSound("UIMenuQuantity");
         if(!this.bDisabled)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onThumbMouseUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onThumbMouseMove);
            dispatchEvent(new Event(VALUE_CHANGE,true,true));
         }
         else
         {
            dispatchEvent(new Event(VALUE_CHANGE_FAILED,true,true));
         }
      }
   }
}
