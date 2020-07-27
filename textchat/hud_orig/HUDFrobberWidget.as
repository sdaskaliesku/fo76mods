 
package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.text.TextLineMetrics;
   import flash.ui.Keyboard;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDFrobberWidget extends MovieClip
   {
      
      public static const TEST_MODE:Boolean = // method body index: 2451 method index: 2451
      false;
      
      private static const ICON_SPACING:Number = // method body index: 2451 method index: 2451
      2;
      
      public static const BUTTON_TYPE_INVALID:int = // method body index: 2451 method index: 2451
      -1;
      
      public static const BUTTON_TYPE_A:int = // method body index: 2451 method index: 2451
      0;
      
      public static const BUTTON_TYPE_X:int = // method body index: 2451 method index: 2451
      1;
      
      public static const BUTTON_TYPE_Y:int = // method body index: 2451 method index: 2451
      2;
      
      public static const BUTTON_TYPE_B:int = // method body index: 2451 method index: 2451
      3;
      
      public static const BUTTON_TYPE_COUNT:int = // method body index: 2451 method index: 2451
      4;
      
      public static const EVENT_BUTTON:String = // method body index: 2451 method index: 2451
      "Frobber::ButtonEvent";
       
      
      public var Internal_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var Header_mc:MovieClip;
      
      public var Syncing_mc:MovieClip;
      
      private var m_Show:Boolean = false;
      
      private var m_ShowInventory:Boolean = false;
      
      private var m_ButtonHintData:Vector.<BSButtonHintData>;
      
      private var m_IsHolding:Boolean = false;
      
      private var m_IsSyncing:Boolean = false;
      
      private var m_HeaderTextFormat:TextFormat;
      
      private var m_ButtonInfoTap:Array;
      
      private var m_ButtonData:Array;
      
      public function HUDFrobberWidget()
      {
         // method body index: 2452 method index: 2452
         super();
         Extensions.enabled = true;
         this.ButtonHintBar_mc = this.Internal_mc.ButtonHintBar_mc;
         this.Header_mc = this.Internal_mc.Header_mc;
         this.m_HeaderTextFormat = this.Header_mc.Header_tf.getTextFormat();
         TextFieldEx.setTextAutoSize(this.Header_mc.Header_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.ButtonHintBar_mc.useVaultTecColor = true;
         this.ButtonHintBar_mc.useBackground = false;
         BSUIDataManager.Subscribe("FrobberData",this.onDataUpdate,TEST_MODE);
         if(TEST_MODE)
         {
            addEventListener(KeyboardEvent.KEY_DOWN,this.onTestKeyDown);
            addEventListener(KeyboardEvent.KEY_UP,this.onTestKeyUp);
            addEventListener(MouseEvent.MOUSE_DOWN,this.onTestMouseDown);
            addEventListener(MouseEvent.MOUSE_UP,this.onTestMouseUp);
         }
      }
      
      private function onTestMouseDown(aEvent:MouseEvent) : void
      {
         // method body index: 2453 method index: 2453
         this.ProcessUserEvent("Activate",true);
      }
      
      private function onTestMouseUp(aEvent:MouseEvent) : void
      {
         // method body index: 2454 method index: 2454
         this.ProcessUserEvent("Activate",false);
      }
      
      private function onTestKeyDown(aEvent:KeyboardEvent) : void
      {
         // method body index: 2455 method index: 2455
         if(aEvent.keyCode == Keyboard.F6)
         {
            this.ProcessUserEvent("Activate",true);
         }
      }
      
      private function onTestKeyUp(aEvent:KeyboardEvent) : void
      {
         // method body index: 2456 method index: 2456
         if(aEvent.keyCode == Keyboard.F6)
         {
            this.ProcessUserEvent("Activate",false);
         }
      }
      
      public function set isHolding(aHolding:Boolean) : void
      {
         // method body index: 2457 method index: 2457
         if(aHolding != this.m_IsHolding)
         {
            if(aHolding)
            {
               addEventListener(Event.ENTER_FRAME,this.updateHeldButtons);
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.updateHeldButtons);
            }
            this.updateHeldButtons();
         }
         this.m_IsHolding = aHolding;
      }
      
      public function get isHolding() : Boolean
      {
         // method body index: 2458 method index: 2458
         return this.m_IsHolding;
      }
      
      public function set show(aShow:Boolean) : void
      {
         // method body index: 2459 method index: 2459
         if(aShow != this.m_Show)
         {
            if(aShow)
            {
               gotoAndPlay("rollOn");
            }
            else
            {
               gotoAndPlay("rollOff");
            }
         }
         this.m_Show = aShow;
      }
      
      public function get show() : Boolean
      {
         // method body index: 2460 method index: 2460
         return this.m_Show;
      }
      
      public function set showInventory(aShow:Boolean) : void
      {
         // method body index: 2461 method index: 2461
         if(aShow != this.m_ShowInventory)
         {
            if(aShow)
            {
               this.m_HeaderTextFormat.align = TextFormatAlign.LEFT;
               this.Internal_mc.gotoAndStop("Inventory");
            }
            else
            {
               this.m_HeaderTextFormat.align = TextFormatAlign.CENTER;
               this.Internal_mc.gotoAndStop("Basic");
            }
            this.Header_mc.Header_tf.setTextFormat(this.m_HeaderTextFormat);
         }
         this.m_ShowInventory = aShow;
      }
      
      public function get showInventory() : Boolean
      {
         // method body index: 2462 method index: 2462
         return this.m_ShowInventory;
      }
      
      public function set isSyncing(aSyncing:Boolean) : void
      {
         // method body index: 2463 method index: 2463
         this.m_IsSyncing = aSyncing;
      }
      
      public function get isSyncing() : Boolean
      {
         // method body index: 2464 method index: 2464
         return this.m_IsSyncing;
      }
      
      private function getDataForButtonHint(aButtonInfo:Object) : BSButtonHintData
      {
         // method body index: 2465 method index: 2465
         var newData:BSButtonHintData = new BSButtonHintData(aButtonInfo.text,aButtonInfo.buttonHint.szTextPC,aButtonInfo.buttonHint.szTextPS4,aButtonInfo.buttonHint.szTextXB1,1,null);
         newData.canHold = aButtonInfo.pressAndHold;
         newData.ButtonEnabled = aButtonInfo.enabled;
         newData.IsWarning = aButtonInfo.isWarning;
         return newData;
      }
      
      private function buildButtonInfo(aButtonList:Array) : void
      {
         // method body index: 2466 method index: 2466
         var curButtonData:HUDFrobberButtonData = null;
         var curButtonHint:BSButtonHintData = null;
         this.m_ButtonHintData = new Vector.<BSButtonHintData>();
         this.m_ButtonData = new Array();
         for(var i:uint = 0; i < aButtonList.length; i++)
         {
            curButtonHint = this.getDataForButtonHint(aButtonList[i]);
            this.m_ButtonHintData.push(curButtonHint);
            if(aButtonList[i].type > BUTTON_TYPE_INVALID)
            {
               curButtonData = this.m_ButtonData[aButtonList[i].type];
               if(curButtonData == null)
               {
                  curButtonData = new HUDFrobberButtonData();
                  this.m_ButtonData[aButtonList[i].type] = curButtonData;
               }
               curButtonData.setInfo(aButtonList[i].pressAndHold,aButtonList[i],curButtonHint);
            }
         }
         this.ButtonHintBar_mc.SetButtonHintData(this.m_ButtonHintData);
      }
      
      private function onDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 2467 method index: 2467
         var headerMetrics:TextLineMetrics = null;
         this.buildButtonInfo(arEvent.data.buttons);
         this.show = arEvent.data.show;
         this.showInventory = false;
         this.isSyncing = arEvent.data.syncing;
         this.Header_mc.Header_tf.text = arEvent.data.headerText.toUpperCase();
         if(this.Header_mc.TaggedForSearch_mc)
         {
            this.Header_mc.TaggedForSearch_mc.visible = arEvent.data.taggedForSearch;
            if(this.Header_mc.TaggedForSearch_mc.visible)
            {
               headerMetrics = this.Header_mc.Header_tf.getLineMetrics(0);
               this.Header_mc.TaggedForSearch_mc.x = this.Header_mc.Header_tf.x + headerMetrics.x - this.Header_mc.TaggedForSearch_mc.width - ICON_SPACING;
            }
         }
         this.decideHeaderTextColor();
      }
      
      private function getButtonTypeFromEvent(aEvent:String) : int
      {
         // method body index: 2468 method index: 2468
         var buttonTypeStrings:Array = new Array("QCAButton","QCXButton","QCYButton","QCBButton");
         return buttonTypeStrings.indexOf(aEvent);
      }
      
      private function updateHeldButtons(aEvent:Event = null) : void
      {
         // method body index: 2469 method index: 2469
         var curButton:HUDFrobberButtonData = null;
         for(var i:uint = 0; i < BUTTON_TYPE_COUNT; i++)
         {
            curButton = this.m_ButtonData[i];
            if(curButton != null)
            {
               curButton.updateHoldPercent();
            }
         }
      }
      
      private function updateButtonHold(aButtonType:int, aIsHolding:Boolean) : void
      {
         // method body index: 2470 method index: 2470
         var curButton:HUDFrobberButtonData = null;
         var buttonBeingHeld:Boolean = false;
         for(var i:uint = 0; i < BUTTON_TYPE_COUNT; i++)
         {
            curButton = this.m_ButtonData[i];
            if(curButton != null)
            {
               if(curButton.canHold)
               {
                  if(aButtonType == i)
                  {
                     curButton.isHolding = aIsHolding;
                  }
                  if(curButton.isHolding)
                  {
                     buttonBeingHeld = true;
                  }
               }
            }
         }
         this.isHolding = buttonBeingHeld;
      }
      
      public function ProcessUserEvent(strEventName:String, abPressed:Boolean) : Boolean
      {
         // method body index: 2471 method index: 2471
         var curButton:HUDFrobberButtonData = null;
         var i:uint = 0;
         var bhandled:* = false;
         var buttonType:int = this.getButtonTypeFromEvent(strEventName);
         if(buttonType >= 0)
         {
            bhandled = this.m_ButtonData[buttonType] != null;
            if(abPressed)
            {
               this.updateButtonHold(buttonType,true);
            }
            else
            {
               for(i = 0; i < BUTTON_TYPE_COUNT; i++)
               {
                  curButton = this.m_ButtonData[i];
                  if(buttonType == i && curButton != null)
                  {
                     if(curButton.canHold && curButton.holdTimeMet)
                     {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_BUTTON,{
                           "eButtonType":buttonType,
                           "bPressAndHold":true
                        }));
                     }
                     else if(curButton.canTap)
                     {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_BUTTON,{
                           "eButtonType":buttonType,
                           "bPressAndHold":false
                        }));
                     }
                  }
               }
               this.updateButtonHold(buttonType,false);
            }
         }
         return bhandled;
      }
      
      private function decideHeaderTextColor() : void
      {
         // method body index: 2472 method index: 2472
         var bhData:* = undefined;
         this.Header_mc.Header_tf.textColor = GlobalFunc.COLOR_TEXT_HEADER;
         for each(bhData in this.m_ButtonHintData)
         {
            if(bhData.IsWarning)
            {
               this.Header_mc.Header_tf.textColor = GlobalFunc.COLOR_WARNING_ACCENT;
               break;
            }
         }
      }
   }
}
