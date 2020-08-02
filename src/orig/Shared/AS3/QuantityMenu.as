 
package Shared.AS3
{
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   
   public class QuantityMenu extends MovieClip
   {
      
      private static const LabelBufferX = // method body index: 1024 method index: 1024
      3;
      
      public static const QUANTITY_CHANGED = // method body index: 1024 method index: 1024
      "QuantityChanged";
      
      private static const SCROLL_STARTSPEED = // method body index: 1024 method index: 1024
      300;
      
      private static const SCROLL_TIMECOEF = // method body index: 1024 method index: 1024
      1000;
      
      private static const SCROLL_MAX = // method body index: 1024 method index: 1024
      10;
      
      public static const INV_MAX_NUM_BEFORE_QUANTITY_MENU:uint = // method body index: 1024 method index: 1024
      5;
      
      public static const CONFIRM:String = // method body index: 1024 method index: 1024
      "QuantityMenu::quantityConfirmed";
      
      public static const CANCEL:String = // method body index: 1024 method index: 1024
      "QuantityMenu::quantityCancelled";
       
      
      public var Label_tf:TextField;
      
      public var Value_tf:TextField;
      
      public var ValueMin_tf:TextField;
      
      public var ValueMax_tf:TextField;
      
      public var TotalValue_tf:TextField;
      
      public var CapsLabel_tf:TextField;
      
      public var QuantityScrollbar_mc:Option_Scrollbar;
      
      public var Header_mc:MovieClip;
      
      public var Tooltip_mc:MovieClip;
      
      public var Value_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var QuantityBracketHolder_mc:MovieClip;
      
      private var bIsScrolling:Boolean;
      
      private var uiScrollStartTime:uint;
      
      private var uiScrollCurSpeed:uint;
      
      private var iScrollSpeed:int;
      
      protected var uiQuantity:uint;
      
      protected var uiMaxQuantity:uint;
      
      protected var uiMinQuantity:uint;
      
      protected var iArrowStepSize:int;
      
      protected var iShoulderStepSize:int;
      
      protected var iTriggerStepSize:int;
      
      protected var bOpened:Boolean;
      
      protected var prevFocusObj:InteractiveObject;
      
      protected var uiItemValue:uint = 0;
      
      protected var m_ValueList:Array;
      
      protected var m_AcceptButton:BSButtonHintData;
      
      protected var m_CancelButton:BSButtonHintData;
      
      public function QuantityMenu()
      {
         // method body index: 1025 method index: 1025
         var buttonHintDataV:Vector.<BSButtonHintData> = null;
         this.m_AcceptButton = new BSButtonHintData("$ACCEPT","Space","PSN_A","Xenon_A",1,this.onConfirm);
         this.m_CancelButton = new BSButtonHintData("$CANCEL","TAB","PSN_B","Xenon_B",1,this.onCancel);
         super();
         this.uiScrollStartTime = 0;
         this.uiScrollCurSpeed = 1;
         this.iScrollSpeed = 1;
         this.uiQuantity = 1;
         this.uiMaxQuantity = 1;
         this.uiMinQuantity = 1;
         this.bOpened = false;
         this.bIsScrolling = false;
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         addEventListener(Option_Scrollbar.VALUE_CHANGE,this.onValueChange);
         this.QuantityScrollbar_mc.removeEventListener(MouseEvent.CLICK,this.QuantityScrollbar_mc.onClick);
         this.QuantityScrollbar_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.onArrowMouseDown);
         if(this.Header_mc != null)
         {
            this.Label_tf = this.Header_mc.textField;
         }
         if(this.Value_mc != null)
         {
            this.Value_tf = this.Value_mc.Value_tf;
         }
         mouseEnabled = false;
         mouseChildren = false;
         if(this.ButtonHintBar_mc != null)
         {
            buttonHintDataV = new Vector.<BSButtonHintData>();
            buttonHintDataV.push(this.m_AcceptButton);
            buttonHintDataV.push(this.m_CancelButton);
            this.ButtonHintBar_mc.SetButtonHintData(buttonHintDataV);
         }
      }
      
      public function set acceptButtonText(aText:String) : void
      {
         // method body index: 1026 method index: 1026
         this.m_AcceptButton.ButtonText = aText;
      }
      
      public function set cancelButtonText(aText:String) : void
      {
         // method body index: 1027 method index: 1027
         this.m_CancelButton.ButtonText = aText;
      }
      
      public function set tooltip(aTip:String) : void
      {
         // method body index: 1028 method index: 1028
         if(this.Tooltip_mc != null)
         {
            this.Tooltip_mc.textField.text = aTip;
         }
      }
      
      public function get opened() : Boolean
      {
         // method body index: 1029 method index: 1029
         return this.bOpened;
      }
      
      public function get quantity() : uint
      {
         // method body index: 1030 method index: 1030
         if(this.m_ValueList != null)
         {
            return this.m_ValueList[this.uiQuantity];
         }
         return this.uiQuantity;
      }
      
      public function set quantity(aQuantity:uint) : void
      {
         // method body index: 1031 method index: 1031
         if(this.m_ValueList != null)
         {
            this.m_ValueList[this.uiQuantity] = aQuantity;
         }
         else
         {
            this.uiQuantity = aQuantity;
         }
      }
      
      public function get prevFocus() : InteractiveObject
      {
         // method body index: 1032 method index: 1032
         return this.prevFocusObj;
      }
      
      public function OpenMenuRange(aPrevFocusObj:InteractiveObject, asLabelText:String, auiMinQuantity:uint, auiMaxQuantity:uint, auiDefaultQuantity:uint = 4.294967295E9, auiItemValue:* = 0, aAnimatedVisibility:Boolean = false) : *
      {
         // method body index: 1033 method index: 1033
         this.OpenMenu(auiMaxQuantity,aPrevFocusObj,asLabelText,auiItemValue,auiMinQuantity,auiDefaultQuantity,aAnimatedVisibility);
      }
      
      public function OpenMenuList(aPrevFocusObj:InteractiveObject, asLabelText:String, aValueList:Array) : *
      {
         // method body index: 1034 method index: 1034
         var maxQuantity:uint = aValueList.length - 1;
         this.m_ValueList = aValueList;
         this.OpenMenu(maxQuantity,aPrevFocusObj,asLabelText,0,0);
      }
      
      public function OpenMenu(auiMaxQuantity:int, aPrevFocusObj:InteractiveObject, asLabelText:String = "", auiItemValue:* = 0, auiMinQuantity:uint = 1, auiDefaultQuantity:uint = 4.294967295E9, aAnimatedVisibility:Boolean = false) : *
      {
         // method body index: 1035 method index: 1035
         if(auiDefaultQuantity != uint.MAX_VALUE)
         {
            this.uiQuantity = auiDefaultQuantity;
         }
         else
         {
            this.uiQuantity = auiMaxQuantity;
         }
         this.uiMinQuantity = auiMinQuantity;
         this.uiMaxQuantity = auiMaxQuantity;
         this.QuantityScrollbar_mc.MinValue = auiMinQuantity;
         this.QuantityScrollbar_mc.MaxValue = auiMaxQuantity;
         this.iArrowStepSize = 1;
         this.iShoulderStepSize = Math.max(auiMaxQuantity / 20,1);
         this.iTriggerStepSize = Math.max(auiMaxQuantity / 4,1);
         this.QuantityScrollbar_mc.StepSize = this.iArrowStepSize;
         this.QuantityScrollbar_mc.value = this.uiQuantity;
         this.uiItemValue = auiItemValue;
         if(asLabelText.length)
         {
            GlobalFunc.SetText(this.Label_tf,asLabelText,false);
         }
         if(this.QuantityBracketHolder_mc != null)
         {
            this.FitBrackets();
         }
         this.RefreshText();
         this.prevFocusObj = aPrevFocusObj;
         if(aAnimatedVisibility)
         {
            this.gotoAndPlay("rollOn");
         }
         else
         {
            this.alpha = 1;
         }
         mouseEnabled = true;
         mouseChildren = true;
         this.bOpened = true;
      }
      
      public function CloseMenu(aAnimatedVisibility:Boolean = false) : *
      {
         // method body index: 1036 method index: 1036
         this.prevFocusObj = null;
         if(aAnimatedVisibility)
         {
            this.gotoAndPlay("rollOff");
         }
         else
         {
            this.alpha = 0;
         }
         this.bOpened = false;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      private function FitBrackets() : *
      {
         // method body index: 1037 method index: 1037
         var midX:Number = this.Label_tf.x + this.Label_tf.width * 0.5;
         var labelWidth:Number = this.Label_tf.textWidth;
         var QuantityMenuLeftBracket_mc:MovieClip = this.QuantityBracketHolder_mc.QuantityMenuLeftBracket_mc;
         var QuantityMenuRightBracket_mc:MovieClip = this.QuantityBracketHolder_mc.QuantityMenuRightBracket_mc;
         var QuantityMenuBottomBracket_mc:MovieClip = this.QuantityBracketHolder_mc.QuantityMenuBottomBracket_mc;
         QuantityMenuLeftBracket_mc.x = midX - labelWidth * 0.5 - LabelBufferX - QuantityMenuLeftBracket_mc.width - this.QuantityBracketHolder_mc.x;
         QuantityMenuRightBracket_mc.x = midX + labelWidth * 0.5 + LabelBufferX + QuantityMenuRightBracket_mc.width - this.QuantityBracketHolder_mc.x;
         QuantityMenuBottomBracket_mc.width = QuantityMenuRightBracket_mc.x - QuantityMenuLeftBracket_mc.x;
         QuantityMenuBottomBracket_mc.x = midX - QuantityMenuBottomBracket_mc.width * 0.5 - this.QuantityBracketHolder_mc.x;
         if(this.QuantityScrollbar_mc.x < this.QuantityBracketHolder_mc.x + QuantityMenuLeftBracket_mc.x + 20)
         {
            this.QuantityScrollbar_mc.x = this.QuantityBracketHolder_mc.x + QuantityMenuLeftBracket_mc.x + 15;
            this.QuantityScrollbar_mc.width = QuantityMenuRightBracket_mc.x - QuantityMenuLeftBracket_mc.x - 15;
         }
      }
      
      private function RefreshText() : *
      {
         // method body index: 1038 method index: 1038
         var valueListLen:uint = 0;
         var uitotalValue:uint = 0;
         var displayMin:uint = this.uiMinQuantity;
         var displayMax:uint = this.uiMaxQuantity;
         var displayNum:uint = this.uiQuantity;
         if(this.m_ValueList != null)
         {
            valueListLen = this.m_ValueList.length;
            displayMin = this.m_ValueList[0];
            displayMax = this.m_ValueList[valueListLen - 1];
            displayNum = this.m_ValueList[this.uiQuantity];
         }
         if(this.ValueMin_tf != null)
         {
            GlobalFunc.SetText(this.ValueMin_tf,displayMin.toString(),false);
         }
         if(this.ValueMax_tf != null)
         {
            GlobalFunc.SetText(this.ValueMax_tf,displayMax.toString(),false);
         }
         if(this.Value_tf != null)
         {
            GlobalFunc.SetText(this.Value_tf,displayNum.toString(),false);
         }
         this.QuantityScrollbar_mc.value = this.uiQuantity;
         if(this.TotalValue_tf != null)
         {
            uitotalValue = this.uiQuantity * this.uiItemValue;
            GlobalFunc.SetText(this.TotalValue_tf,uitotalValue.toString(),false);
         }
      }
      
      private function modifyQuantity(aiQuantity:int) : *
      {
         // method body index: 1039 method index: 1039
         var newQuantity:int = this.uiQuantity + aiQuantity;
         newQuantity = Math.min(newQuantity,this.uiMaxQuantity);
         newQuantity = Math.max(newQuantity,this.uiMinQuantity);
         if(this.uiQuantity != newQuantity)
         {
            this.uiQuantity = newQuantity;
            this.RefreshText();
            dispatchEvent(new CustomEvent(QUANTITY_CHANGED,newQuantity,true));
         }
      }
      
      private function stopScroll() : *
      {
         // method body index: 1040 method index: 1040
         this.bIsScrolling = false;
         this.uiScrollCurSpeed = 1;
         removeEventListener(Event.ENTER_FRAME,this.onArrowTick);
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      public function onKeyDown(event:KeyboardEvent) : *
      {
         // method body index: 1041 method index: 1041
         if(event.keyCode == Keyboard.RIGHT)
         {
            this.bIsScrolling = true;
            this.uiScrollStartTime = getTimer();
            this.iScrollSpeed = 1;
            this.modifyQuantity(1);
            addEventListener(Event.ENTER_FRAME,this.onArrowTick);
            removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         else if(event.keyCode == Keyboard.LEFT)
         {
            this.bIsScrolling = true;
            this.uiScrollStartTime = getTimer();
            this.iScrollSpeed = -1;
            this.modifyQuantity(-1);
            addEventListener(Event.ENTER_FRAME,this.onArrowTick);
            removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
      }
      
      public function onKeyUp(event:KeyboardEvent) : *
      {
         // method body index: 1042 method index: 1042
         if(event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.LEFT)
         {
            this.stopScroll();
         }
         if(event.keyCode == Keyboard.ENTER)
         {
            this.onConfirm();
            event.stopPropagation();
         }
      }
      
      private function onConfirm() : void
      {
         // method body index: 1043 method index: 1043
         this.stopScroll();
         dispatchEvent(new Event(CONFIRM,true,true));
      }
      
      private function onCancel() : void
      {
         // method body index: 1044 method index: 1044
         this.stopScroll();
         dispatchEvent(new Event(CANCEL,true,true));
      }
      
      public function onMouseWheel(event:MouseEvent) : *
      {
         // method body index: 1045 method index: 1045
         if(event.delta > 0)
         {
            this.modifyQuantity(this.iArrowStepSize);
         }
         else if(event.delta < 0)
         {
            this.modifyQuantity(-this.iArrowStepSize);
         }
      }
      
      function onArrowMouseUp(e:Event) : void
      {
         // method body index: 1046 method index: 1046
         this.bIsScrolling = false;
         this.uiScrollCurSpeed = 1;
         removeEventListener(Event.ENTER_FRAME,this.onArrowTick);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onArrowMouseUp);
      }
      
      function onArrowTick(e:Event) : void
      {
         // method body index: 1047 method index: 1047
         var deltaTime:* = undefined;
         if(this.bIsScrolling)
         {
            deltaTime = getTimer() - this.uiScrollStartTime;
            if(deltaTime > SCROLL_STARTSPEED)
            {
               this.uiScrollCurSpeed = this.uiScrollCurSpeed + int(Math.floor(this.uiScrollCurSpeed * (deltaTime / SCROLL_TIMECOEF)));
               this.uiScrollCurSpeed = Math.min(this.uiScrollCurSpeed,SCROLL_MAX);
               this.modifyQuantity(this.uiScrollCurSpeed * this.iScrollSpeed);
            }
         }
      }
      
      function onValueChange(e:Event) : void
      {
         // method body index: 1048 method index: 1048
         this.uiQuantity = this.QuantityScrollbar_mc.value;
         this.RefreshText();
      }
      
      public function onArrowMouseDown(event:MouseEvent) : *
      {
         // method body index: 1049 method index: 1049
         var clicktarget:MovieClip = null;
         var otarget:Object = event.target;
         if(event.target as MovieClip)
         {
            clicktarget = event.target as MovieClip;
            if(clicktarget == this.QuantityScrollbar_mc.RightCatcher_mc)
            {
               this.bIsScrolling = true;
               this.uiScrollStartTime = getTimer();
               this.iScrollSpeed = 1;
               this.modifyQuantity(this.iArrowStepSize);
               stage.addEventListener(MouseEvent.MOUSE_UP,this.onArrowMouseUp);
               addEventListener(Event.ENTER_FRAME,this.onArrowTick);
            }
            else if(clicktarget == this.QuantityScrollbar_mc.LeftCatcher_mc)
            {
               this.bIsScrolling = true;
               this.uiScrollStartTime = getTimer();
               this.iScrollSpeed = -1;
               this.modifyQuantity(-this.iArrowStepSize);
               stage.addEventListener(MouseEvent.MOUSE_UP,this.onArrowMouseUp);
               addEventListener(Event.ENTER_FRAME,this.onArrowTick);
            }
         }
      }
      
      public function ProcessUserEvent(asEvent:String, bData:Boolean) : Boolean
      {
         // method body index: 1050 method index: 1050
         var bprocessed:Boolean = false;
         if(!bData)
         {
            if(asEvent == "LShoulder")
            {
               this.modifyQuantity(-this.iShoulderStepSize);
               bprocessed = true;
            }
            else if(asEvent == "RShoulder")
            {
               this.modifyQuantity(this.iShoulderStepSize);
               bprocessed = true;
            }
            else if(asEvent == "LTrigger")
            {
               this.modifyQuantity(-this.iTriggerStepSize);
               bprocessed = true;
            }
            else if(asEvent == "RTrigger")
            {
               this.modifyQuantity(this.iTriggerStepSize);
               bprocessed = true;
            }
         }
         return bprocessed;
      }
   }
}
