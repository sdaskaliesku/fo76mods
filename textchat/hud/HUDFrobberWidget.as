 
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
      
      public static const TEST_MODE:Boolean = // method body index: 2399 method index: 2399
      false;
      
      private static const ICON_SPACING:Number = // method body index: 2399 method index: 2399
      2;
      
      public static const BUTTON_TYPE_INVALID:int = // method body index: 2399 method index: 2399
      -1;
      
      public static const BUTTON_TYPE_A:int = // method body index: 2399 method index: 2399
      0;
      
      public static const BUTTON_TYPE_X:int = // method body index: 2399 method index: 2399
      1;
      
      public static const BUTTON_TYPE_Y:int = // method body index: 2399 method index: 2399
      2;
      
      public static const BUTTON_TYPE_B:int = // method body index: 2399 method index: 2399
      3;
      
      public static const BUTTON_TYPE_COUNT:int = // method body index: 2399 method index: 2399
      4;
      
      public static const EVENT_BUTTON:String = // method body index: 2399 method index: 2399
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
         // method body index: 2400 method index: 2400
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
      
      private function onTestMouseDown(param1:MouseEvent) : void
      {
         // method body index: 2401 method index: 2401
         this.ProcessUserEvent("Activate",true);
      }
      
      private function onTestMouseUp(param1:MouseEvent) : void
      {
         // method body index: 2402 method index: 2402
         this.ProcessUserEvent("Activate",false);
      }
      
      private function onTestKeyDown(param1:KeyboardEvent) : void
      {
         // method body index: 2403 method index: 2403
         if(param1.keyCode == Keyboard.F6)
         {
            this.ProcessUserEvent("Activate",true);
         }
      }
      
      private function onTestKeyUp(param1:KeyboardEvent) : void
      {
         // method body index: 2404 method index: 2404
         if(param1.keyCode == Keyboard.F6)
         {
            this.ProcessUserEvent("Activate",false);
         }
      }
      
      public function set isHolding(param1:Boolean) : void
      {
         // method body index: 2405 method index: 2405
         if(param1 != this.m_IsHolding)
         {
            if(param1)
            {
               addEventListener(Event.ENTER_FRAME,this.updateHeldButtons);
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.updateHeldButtons);
            }
            this.updateHeldButtons();
         }
         this.m_IsHolding = param1;
      }
      
      public function get isHolding() : Boolean
      {
         // method body index: 2406 method index: 2406
         return this.m_IsHolding;
      }
      
      public function set show(param1:Boolean) : void
      {
         // method body index: 2407 method index: 2407
         if(param1 != this.m_Show)
         {
            if(param1)
            {
               gotoAndPlay("rollOn");
            }
            else
            {
               gotoAndPlay("rollOff");
            }
         }
         this.m_Show = param1;
      }
      
      public function get show() : Boolean
      {
         // method body index: 2408 method index: 2408
         return this.m_Show;
      }
      
      public function set showInventory(param1:Boolean) : void
      {
         // method body index: 2409 method index: 2409
         if(param1 != this.m_ShowInventory)
         {
            if(param1)
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
         this.m_ShowInventory = param1;
      }
      
      public function get showInventory() : Boolean
      {
         // method body index: 2410 method index: 2410
         return this.m_ShowInventory;
      }
      
      public function set isSyncing(param1:Boolean) : void
      {
         // method body index: 2411 method index: 2411
         this.m_IsSyncing = param1;
      }
      
      public function get isSyncing() : Boolean
      {
         // method body index: 2412 method index: 2412
         return this.m_IsSyncing;
      }
      
      private function getDataForButtonHint(param1:Object) : BSButtonHintData
      {
         // method body index: 2413 method index: 2413
         var _loc2_:BSButtonHintData = new BSButtonHintData(param1.text,param1.buttonHint.szTextPC,param1.buttonHint.szTextPS4,param1.buttonHint.szTextXB1,1,null);
         _loc2_.canHold = param1.pressAndHold;
         _loc2_.ButtonEnabled = param1.enabled;
         _loc2_.IsWarning = param1.isWarning;
         return _loc2_;
      }
      
      private function buildButtonInfo(param1:Array) : void
      {
         // method body index: 2414 method index: 2414
         var _loc2_:HUDFrobberButtonData = null;
         var _loc3_:BSButtonHintData = null;
         this.m_ButtonHintData = new Vector.<BSButtonHintData>();
         this.m_ButtonData = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = this.getDataForButtonHint(param1[_loc4_]);
            this.m_ButtonHintData.push(_loc3_);
            if(param1[_loc4_].type > BUTTON_TYPE_INVALID)
            {
               _loc2_ = this.m_ButtonData[param1[_loc4_].type];
               if(_loc2_ == null)
               {
                  _loc2_ = new HUDFrobberButtonData();
                  this.m_ButtonData[param1[_loc4_].type] = _loc2_;
               }
               _loc2_.setInfo(param1[_loc4_].pressAndHold,param1[_loc4_],_loc3_);
            }
            _loc4_++;
         }
         this.ButtonHintBar_mc.SetButtonHintData(this.m_ButtonHintData);
      }
      
      private function onDataUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 2415 method index: 2415
         var _loc2_:TextLineMetrics = null;
         this.buildButtonInfo(param1.data.buttons);
         this.show = param1.data.show;
         this.showInventory = false;
         this.isSyncing = param1.data.syncing;
         this.Header_mc.Header_tf.text = param1.data.headerText.toUpperCase();
         if(this.Header_mc.TaggedForSearch_mc)
         {
            this.Header_mc.TaggedForSearch_mc.visible = param1.data.taggedForSearch;
            if(this.Header_mc.TaggedForSearch_mc.visible)
            {
               _loc2_ = this.Header_mc.Header_tf.getLineMetrics(0);
               this.Header_mc.TaggedForSearch_mc.x = this.Header_mc.Header_tf.x + _loc2_.x - this.Header_mc.TaggedForSearch_mc.width - ICON_SPACING;
            }
         }
         this.decideHeaderTextColor();
      }
      
      private function getButtonTypeFromEvent(param1:String) : int
      {
         // method body index: 2416 method index: 2416
         var _loc2_:Array = new Array("QCAButton","QCXButton","QCYButton","QCBButton");
         return _loc2_.indexOf(param1);
      }
      
      private function updateHeldButtons(param1:Event = null) : void
      {
         // method body index: 2417 method index: 2417
         var _loc2_:HUDFrobberButtonData = null;
         var _loc3_:uint = 0;
         while(_loc3_ < BUTTON_TYPE_COUNT)
         {
            _loc2_ = this.m_ButtonData[_loc3_];
            if(_loc2_ != null)
            {
               _loc2_.updateHoldPercent();
            }
            _loc3_++;
         }
      }
      
      private function updateButtonHold(param1:int, param2:Boolean) : void
      {
         // method body index: 2418 method index: 2418
         var _loc3_:HUDFrobberButtonData = null;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         while(_loc5_ < BUTTON_TYPE_COUNT)
         {
            _loc3_ = this.m_ButtonData[_loc5_];
            if(_loc3_ != null)
            {
               if(_loc3_.canHold)
               {
                  if(param1 == _loc5_)
                  {
                     _loc3_.isHolding = param2;
                  }
                  if(_loc3_.isHolding)
                  {
                     _loc4_ = true;
                  }
               }
            }
            _loc5_++;
         }
         this.isHolding = _loc4_;
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         // method body index: 2419 method index: 2419
         var _loc3_:HUDFrobberButtonData = null;
         var _loc4_:uint = 0;
         var _loc5_:* = false;
         var _loc6_:int = this.getButtonTypeFromEvent(param1);
         if(_loc6_ >= 0)
         {
            _loc5_ = this.m_ButtonData[_loc6_] != null;
            if(param2)
            {
               this.updateButtonHold(_loc6_,true);
            }
            else
            {
               _loc4_ = 0;
               while(_loc4_ < BUTTON_TYPE_COUNT)
               {
                  _loc3_ = this.m_ButtonData[_loc4_];
                  if(_loc6_ == _loc4_ && _loc3_ != null)
                  {
                     if(_loc3_.canHold && _loc3_.holdTimeMet)
                     {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_BUTTON,{
                           "eButtonType":_loc6_,
                           "bPressAndHold":true
                        }));
                     }
                     else if(_loc3_.canTap)
                     {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_BUTTON,{
                           "eButtonType":_loc6_,
                           "bPressAndHold":false
                        }));
                     }
                  }
                  _loc4_++;
               }
               this.updateButtonHold(_loc6_,false);
            }
         }
         return _loc5_;
      }
      
      private function decideHeaderTextColor() : void
      {
         // method body index: 2420 method index: 2420
         var _loc1_:* = undefined;
         this.Header_mc.Header_tf.textColor = GlobalFunc.COLOR_TEXT_HEADER;
         for each(_loc1_ in this.m_ButtonHintData)
         {
            if(_loc1_.IsWarning)
            {
               this.Header_mc.Header_tf.textColor = GlobalFunc.COLOR_WARNING_ACCENT;
               break;
            }
         }
      }
   }
}
