 
package Shared.AS3
{
   import Shared.AS3.COMPANIONAPP.CompanionAppMode;
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.GlobalFunc;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   
   public dynamic class BSButtonHint extends BSUIComponent
   {
      
      private static var colorMatrix:ColorMatrixFilter = // method body index: 660 method index: 660
      null;
      
      private static const DISABLED_GREY_OUT_ALPHA:Number = // method body index: 660 method index: 660
      0.5;
      
      public static const JUSTIFY_RIGHT:uint = // method body index: 660 method index: 660
      0;
      
      public static const JUSTIFY_LEFT:uint = // method body index: 660 method index: 660
      1;
      
      public static const HOLD_TEXT_OFFSET:Number = // method body index: 660 method index: 660
      10;
      
      public static const HOLD_KEY_SCALE:Number = // method body index: 660 method index: 660
      1.25;
      
      private static const DYNAMIC_MOVIE_CLIP_BUFFER = // method body index: 660 method index: 660
      3;
      
      private static const NameToTextMap:Object = // method body index: 660 method index: 660
      {
         "Xenon_A":"A",
         "Xenon_B":"B",
         "Xenon_X":"C",
         "Xenon_Y":"D",
         "Xenon_Select":"E",
         "Xenon_LS":"F",
         "Xenon_L1":"G",
         "Xenon_L3":"H",
         "Xenon_L2":"I",
         "Xenon_L2R2":"J",
         "Xenon_RS":"K",
         "Xenon_R1":"L",
         "Xenon_R3":"M",
         "Xenon_R2":"N",
         "Xenon_Start":"O",
         "Xenon_L1R1":"Z",
         "_Positive":"P",
         "_Negative":"Q",
         "_Question":"R",
         "_Neutral":"S",
         "Left":"T",
         "Right":"U",
         "Down":"V",
         "Up":"W",
         "Xenon_R2_Alt":"X",
         "Xenon_L2_Alt":"Y",
         "PSN_A":"a",
         "PSN_Y":"b",
         "PSN_X":"c",
         "PSN_B":"d",
         "PSN_Select":"z",
         "PSN_L3":"f",
         "PSN_L1":"g",
         "PSN_L1R1":"h",
         "PSN_LS":"i",
         "PSN_L2":"j",
         "PSN_L2R2":"k",
         "PSN_R3":"l",
         "PSN_R1":"m",
         "PSN_RS":"n",
         "PSN_R2":"o",
         "PSN_Start":"p",
         "_DPad_LR":"q",
         "_DPad_UD":"r",
         "_DPad_Left":"t",
         "_DPad_Right":"u",
         "_DPad_Down":"v",
         "_DPad_Up":"w",
         "PSN_R2_Alt":"x",
         "PSN_L2_Alt":"y"
      };
      
      private static const FRtoENMap:Object = // method body index: 660 method index: 660
      {
         "A":"Q",
         "Q":"A",
         "W":"Z",
         "Z":"W",
         "-":")"
      };
      
      private static const BEtoENMap:Object = // method body index: 660 method index: 660
      {
         "A":"Q",
         "Q":"A",
         "W":"Z",
         "Z":"W",
         "-":")",
         "=":"-"
      };
      
      private static const WarningColorMatrixFilter:ColorMatrixFilter = // method body index: 660 method index: 660
      new ColorMatrixFilter(new Array(1,0,0,0,-9,0,1,0,0,-141,0,0,1,0,-114,0,0,0,1,0));
       
      
      public var textField_tf:TextField;
      
      public var IconHolderInstance:MovieClip;
      
      public var SecondaryIconHolderInstance:MovieClip;
      
      public var HoldMeter_mc:MovieClip;
      
      public var Sizer_mc:MovieClip;
      
      private var m_CanHold:Boolean = false;
      
      private var m_HoldPercent:Number = 0.0;
      
      private var m_HoldFrames:int = 25;
      
      private var m_HoldStartFrame:int = 0;
      
      private var m_UseVaultTecColor:Boolean = false;
      
      private var _hitArea:Sprite;
      
      private var DynamicMovieClip:MovieClip;
      
      private var bButtonFlashing:Boolean;
      
      private var _strCurrentDynamicMovieClipName:String;
      
      private var _DyanmicMovieHeight:Number;
      
      private var _DynamicMovieY:Number;
      
      private var _buttonHintData:BSButtonHintData;
      
      var _bButtonPressed:Boolean = false;
      
      var _bMouseOver:Boolean = false;
      
      public function BSButtonHint()
      {
         // method body index: 661 method index: 661
         var _loc1_:Array = null;
         var _loc2_:FrameLabel = null;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         super();
         visible = false;
         mouseChildren = false;
         this.bButtonFlashing = false;
         this._strCurrentDynamicMovieClipName = "";
         this.DynamicMovieClip = null;
         this._DyanmicMovieHeight = this.textField_tf.height;
         this._DynamicMovieY = this.textField_tf.y;
         this.SetUpTextFields(this.textField_tf);
         this.SetUpTextFields(this.IconHolderInstance.IconAnimInstance.Icon_tf);
         this.SetUpTextFields(this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf);
         this._hitArea = new Sprite();
         this._hitArea.graphics.beginFill(0);
         this._hitArea.graphics.drawRect(0,0,1,1);
         this._hitArea.graphics.endFill();
         this._hitArea.visible = false;
         this._hitArea.mouseEnabled = false;
         addEventListener(MouseEvent.CLICK,this.onTextClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         if(this.HoldMeter_mc != null)
         {
            _loc1_ = this.HoldMeter_mc.currentLabels;
            _loc3_ = false;
            _loc4_ = 1;
            while(_loc4_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc4_] as FrameLabel;
               if(_loc3_)
               {
                  this.m_HoldFrames = _loc2_.frame - this.m_HoldStartFrame - 1;
                  break;
               }
               if(_loc2_.name == "buttonHold")
               {
                  _loc3_ = true;
                  this.m_HoldStartFrame = _loc2_.frame;
               }
               _loc4_++;
            }
         }
      }
      
      public function set ButtonHintData(param1:BSButtonHintData) : void
      {
         // method body index: 662 method index: 662
         if(this._buttonHintData)
         {
            this._buttonHintData.removeEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
         }
         this._buttonHintData = param1;
         if(this._buttonHintData)
         {
            this._buttonHintData.addEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
         }
         SetIsDirty();
      }
      
      private function onButtonHintDataDirtyEvent(param1:Event) : void
      {
         // method body index: 663 method index: 663
         SetIsDirty();
      }
      
      public function get PCKey() : String
      {
         // method body index: 664 method index: 664
         var _loc1_:String = null;
         if(this._buttonHintData.PCKey)
         {
            _loc1_ = this._buttonHintData.PCKey;
            _loc1_ = this.TranslateKey(_loc1_);
            return this.Justification == JUSTIFY_LEFT?_loc1_ + ")":"(" + _loc1_;
         }
         return "";
      }
      
      public function get SecondaryPCKey() : String
      {
         // method body index: 665 method index: 665
         var _loc1_:String = null;
         if(this._buttonHintData.SecondaryPCKey)
         {
            _loc1_ = this._buttonHintData.SecondaryPCKey;
            _loc1_ = this.TranslateKey(_loc1_);
            return "(" + _loc1_;
         }
         return "";
      }
      
      private function TranslateKey(param1:String) : String
      {
         // method body index: 666 method index: 666
         switch(uiKeyboard)
         {
            case PlatformChangeEvent.PLATFORM_PC_KB_FR:
               if(FRtoENMap.hasOwnProperty(param1))
               {
                  param1 = FRtoENMap[param1];
                  break;
               }
               break;
            case PlatformChangeEvent.PLATFORM_PC_KB_BE:
               if(BEtoENMap.hasOwnProperty(param1))
               {
                  param1 = BEtoENMap[param1];
                  break;
               }
         }
         return param1;
      }
      
      private function get UsePCKey() : Boolean
      {
         // method body index: 667 method index: 667
         return uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && !NameToTextMap.hasOwnProperty(this._buttonHintData.PCKey);
      }
      
      public function get ControllerButton() : String
      {
         // method body index: 668 method index: 668
         var _loc1_:String = "";
         if(uiController != PlatformChangeEvent.PLATFORM_MOBILE && this.UsePCKey)
         {
            _loc1_ = this.PCKey;
         }
         else
         {
            switch(uiController)
            {
               case PlatformChangeEvent.PLATFORM_PC_KB_MOUSE:
                  _loc1_ = this._buttonHintData.PCKey;
                  break;
               case PlatformChangeEvent.PLATFORM_PC_GAMEPAD:
               case PlatformChangeEvent.PLATFORM_XB1:
               default:
                  _loc1_ = this._buttonHintData.XenonButton;
                  break;
               case PlatformChangeEvent.PLATFORM_PS4:
                  _loc1_ = this._buttonHintData.PSNButton;
                  break;
               case PlatformChangeEvent.PLATFORM_MOBILE:
                  _loc1_ = "";
            }
            if(NameToTextMap.hasOwnProperty(_loc1_))
            {
               _loc1_ = NameToTextMap[_loc1_];
            }
         }
         return _loc1_;
      }
      
      public function get SecondaryControllerButton() : String
      {
         // method body index: 669 method index: 669
         var _loc1_:String = "";
         if(this._buttonHintData.hasSecondaryButton)
         {
            if(uiController != PlatformChangeEvent.PLATFORM_MOBILE && this.UsePCKey)
            {
               _loc1_ = this.SecondaryPCKey;
            }
            else
            {
               switch(uiController)
               {
                  case PlatformChangeEvent.PLATFORM_PC_KB_MOUSE:
                     _loc1_ = this._buttonHintData.SecondaryPCKey;
                     break;
                  case PlatformChangeEvent.PLATFORM_PC_GAMEPAD:
                  case PlatformChangeEvent.PLATFORM_XB1:
                  default:
                     _loc1_ = this._buttonHintData.SecondaryXenonButton;
                     break;
                  case PlatformChangeEvent.PLATFORM_PS4:
                     _loc1_ = this._buttonHintData.SecondaryPSNButton;
                     break;
                  case PlatformChangeEvent.PLATFORM_MOBILE:
                     _loc1_ = "";
               }
               if(NameToTextMap.hasOwnProperty(_loc1_))
               {
                  _loc1_ = NameToTextMap[_loc1_];
               }
            }
         }
         return _loc1_;
      }
      
      public function get ButtonText() : String
      {
         // method body index: 670 method index: 670
         return this._buttonHintData.ButtonText;
      }
      
      public function get Justification() : uint
      {
         // method body index: 671 method index: 671
         if(CompanionAppMode.isOn)
         {
            return this._buttonHintData != null?uint(this._buttonHintData.Justification):uint(JUSTIFY_LEFT);
         }
         return this._buttonHintData.Justification;
      }
      
      public function get ButtonDisabled() : Boolean
      {
         // method body index: 672 method index: 672
         return this._buttonHintData.ButtonDisabled;
      }
      
      public function get SecondaryButtonDisabled() : Boolean
      {
         // method body index: 673 method index: 673
         return this._buttonHintData.SecondaryButtonDisabled;
      }
      
      public function get AllButtonsDisabled() : Boolean
      {
         // method body index: 674 method index: 674
         return this.ButtonDisabled && (!this._buttonHintData.hasSecondaryButton || this.SecondaryButtonDisabled);
      }
      
      public function get ButtonVisible() : Boolean
      {
         // method body index: 675 method index: 675
         return this._buttonHintData && this._buttonHintData.ButtonVisible;
      }
      
      public function get UseDynamicMovieClip() : Boolean
      {
         // method body index: 676 method index: 676
         return this._buttonHintData.DynamicMovieClipName.length > 0;
      }
      
      public function onTextClick(param1:Event) : void
      {
         // method body index: 677 method index: 677
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(this.ButtonVisible)
         {
            _loc2_ = !this.ButtonDisabled;
            _loc3_ = false;
            if(this._buttonHintData.SecondaryPCKey && (param1 as MouseEvent).localX > this._hitArea.width / 2)
            {
               _loc2_ = false;
               _loc3_ = !this.SecondaryButtonDisabled;
            }
            if(_loc2_)
            {
               this._buttonHintData.onTextClick();
            }
            else if(_loc3_)
            {
               this._buttonHintData.onSecondaryButtonClick();
            }
         }
      }
      
      public function get bButtonPressed() : Boolean
      {
         // method body index: 678 method index: 678
         return this._bButtonPressed;
      }
      
      public function set bButtonPressed(param1:Boolean) : *
      {
         // method body index: 679 method index: 679
         if(this._bButtonPressed != param1)
         {
            this._bButtonPressed = param1;
            SetIsDirty();
         }
      }
      
      public function get bMouseOver() : Boolean
      {
         // method body index: 680 method index: 680
         return this._bMouseOver;
      }
      
      public function set bMouseOver(param1:Boolean) : *
      {
         // method body index: 681 method index: 681
         if(this._bMouseOver != param1)
         {
            this._bMouseOver = param1;
            SetIsDirty();
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : *
      {
         // method body index: 682 method index: 682
         this.bMouseOver = true;
      }
      
      protected function onMouseOut(param1:MouseEvent) : *
      {
         // method body index: 683 method index: 683
         this.bMouseOver = false;
      }
      
      public function get useVaultTecColor() : Boolean
      {
         // method body index: 684 method index: 684
         return this.m_UseVaultTecColor;
      }

      public function set canHold(param1:Boolean) : void
      {
         // method body index: 686 method index: 686
         this.m_CanHold = param1;
      }
      
      public function set holdPercent(param1:Number) : void
      {
         // method body index: 687 method index: 687
         if(param1 != this.m_HoldPercent)
         {
            this.m_HoldPercent = param1;
            this.redrawHoldIndicator();
         }
      }
      
      private function redrawHoldIndicator() : void
      {
         // method body index: 688 method index: 688
         if(this.HoldMeter_mc != null)
         {
            if(this.m_CanHold)
            {
               this.HoldMeter_mc.visible = true;
               if(this.m_HoldPercent >= 1)
               {
                  this.HoldMeter_mc.gotoAndPlay("buttonHoldComplete");
               }
               else if(this.m_HoldPercent > 0)
               {
                  this.HoldMeter_mc.gotoAndStop(this.m_HoldStartFrame + Math.floor(this.m_HoldFrames * this.m_HoldPercent));
               }
               else
               {
                  this.HoldMeter_mc.gotoAndStop("idle");
               }
            }
            else
            {
               this.HoldMeter_mc.visible = false;
            }
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 689 method index: 689
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         super.redrawUIComponent();
         hitArea = null;
         if(contains(this._hitArea))
         {
            removeChild(this._hitArea);
         }
         visible = this.ButtonVisible;
         if(visible)
         {
            this.canHold = this._buttonHintData.canHold;
            this.holdPercent = this._buttonHintData.holdPercent;
            this.redrawPrimaryButton();
            this.redrawDynamicMovieClip();
            this.redrawTextField();
            this.redrawSecondaryButton();
            this.SetFlashing(this._buttonHintData.ButtonFlashing);
            this.redrawHoldIndicator();
            this.updateButtonHintFilters();
            if(this.m_CanHold)
            {
               this.HoldMeter_mc.x = this.IconHolderInstance.x + this.IconHolderInstance.width / 2;
               this.HoldMeter_mc.scaleX = !!this.UsePCKey?Number(HOLD_KEY_SCALE):Number(1);
               this.HoldMeter_mc.scaleY = !!this.UsePCKey?Number(HOLD_KEY_SCALE):Number(1);
            }
            this.redrawHitArea();
            addChild(this._hitArea);
            hitArea = this._hitArea;
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = [this.IconHolderInstance,this.SecondaryIconHolderInstance,this.textField_tf];
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc2_ = Math.max(_loc2_,_loc5_[_loc6_].x + _loc5_[_loc6_].width);
               _loc4_ = Math.max(_loc4_,_loc5_[_loc6_].y + _loc5_[_loc6_].height);
               _loc6_++;
            }
            this.Sizer_mc.x = _loc1_;
            this.Sizer_mc.y = _loc3_;
            this.Sizer_mc.width = _loc2_ - _loc1_;
            this.Sizer_mc.height = _loc4_ - _loc3_;
         }
      }
      
      public function SetFlashing(param1:Boolean) : *
      {
         // method body index: 690 method index: 690
         if(param1 != this.bButtonFlashing)
         {
            this.bButtonFlashing = param1;
            this.IconHolderInstance.gotoAndPlay(!!param1?"Flashing":"Default");
         }
      }
      
      private function UpdateIconTextField(param1:TextField, param2:String) : *
      {
         // method body index: 691 method index: 691
         var _loc6_:* = undefined;
         param1.text = param2;
         var _loc3_:String = this.GetExpectedFont();
         var _loc4_:String = param1.getTextFormat().font;
         if(_loc3_ != _loc4_)
         {
            _loc6_ = new TextFormat(_loc3_);
            param1.setTextFormat(_loc6_);
         }
         var _loc5_:Number = !!this.UsePCKey?Number(1.25):Number(2.25);
         if(param1.y != _loc5_)
         {
            param1.y = _loc5_;
         }
      }
      
      private function redrawDynamicMovieClip() : void
      {
         // method body index: 692 method index: 692
         var _loc1_:Class = null;
         var _loc2_:Number = NaN;
         if(this._buttonHintData.DynamicMovieClipName != this._strCurrentDynamicMovieClipName)
         {
            if(this.DynamicMovieClip)
            {
               removeChild(this.DynamicMovieClip);
            }
            if(this.UseDynamicMovieClip)
            {
               _loc1_ = getDefinitionByName(this._buttonHintData.DynamicMovieClipName) as Class;
               this.DynamicMovieClip = new (_loc1_ as Class)();
               addChild(this.DynamicMovieClip);
               _loc2_ = this._DyanmicMovieHeight / this.DynamicMovieClip.height;
               this.DynamicMovieClip.scaleX = _loc2_;
               this.DynamicMovieClip.scaleY = _loc2_;
               this.DynamicMovieClip.alpha = !!this.AllButtonsDisabled?Number(DISABLED_GREY_OUT_ALPHA):Number(1);
               this.DynamicMovieClip.x = this.Justification == JUSTIFY_LEFT?Number(this.IconHolderInstance.width + DYNAMIC_MOVIE_CLIP_BUFFER):Number(this.IconHolderInstance.x - this.DynamicMovieClip.width - DYNAMIC_MOVIE_CLIP_BUFFER);
               this.DynamicMovieClip.y = this._DynamicMovieY;
            }
         }
      }
      
      private function redrawTextField() : void
      {
         // method body index: 693 method index: 693
         var _loc1_:* = undefined;
         this.textField_tf.visible = !this.UseDynamicMovieClip;
         if(this.textField_tf.visible)
         {
            GlobalFunc.SetText(this.textField_tf,this.ButtonText,false,true,false);
            this.textField_tf.alpha = !!this.AllButtonsDisabled?Number(DISABLED_GREY_OUT_ALPHA):Number(1);
            _loc1_ = !!this.m_CanHold?HOLD_TEXT_OFFSET:0;
            this.textField_tf.x = this.Justification == JUSTIFY_LEFT?Number(this.IconHolderInstance.width + _loc1_):Number(this.IconHolderInstance.x - this.textField_tf.width - _loc1_);
         }
      }
      
      private function redrawSecondaryButton() : void
      {
         // method body index: 694 method index: 694
         this.SecondaryIconHolderInstance.visible = this._buttonHintData.hasSecondaryButton;
         if(this.SecondaryIconHolderInstance.visible)
         {
            this.UpdateIconTextField(this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf,this.SecondaryControllerButton);
            this.SecondaryIconHolderInstance.alpha = !!this.SecondaryButtonDisabled?Number(DISABLED_GREY_OUT_ALPHA):Number(1);
            this.SecondaryIconHolderInstance.x = !!this.UseDynamicMovieClip?Number(this.DynamicMovieClip.x + this.DynamicMovieClip.width + DYNAMIC_MOVIE_CLIP_BUFFER):Number(this.textField_tf.x + this.textField_tf.width);
         }
      }
      
      private function redrawPrimaryButton() : void
      {
         // method body index: 695 method index: 695
         this.UpdateIconTextField(this.IconHolderInstance.IconAnimInstance.Icon_tf,this.ControllerButton);
         this.IconHolderInstance.alpha = !!this.ButtonDisabled?Number(DISABLED_GREY_OUT_ALPHA):Number(1);
         this.IconHolderInstance.x = this.Justification == JUSTIFY_LEFT?Number(0):Number(-this.IconHolderInstance.width);
      }
      
      private function redrawHitArea() : void
      {
         // method body index: 696 method index: 696
         var _loc1_:* = this.getBounds(this);
         this._hitArea.x = _loc1_.x;
         this._hitArea.width = _loc1_.width;
         this._hitArea.y = _loc1_.y;
         this._hitArea.height = _loc1_.height;
      }
      
      private function GetExpectedFont() : String
      {
         // method body index: 697 method index: 697
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         if(this.UsePCKey)
         {
            _loc1_ = "$MAIN_Font";
         }
         else
         {
            _loc2_ = !this.bMouseOver && !this.bButtonPressed;
            _loc1_ = !!_loc2_?"$Controller_buttons":"$Controller_buttons_inverted";
         }
         return _loc1_;
      }
      
      private function SetUpTextFields(param1:TextField) : *
      {
         // method body index: 698 method index: 698
         param1.autoSize = TextFieldAutoSize.LEFT;
         param1.antiAliasType = AntiAliasType.NORMAL;
      }
      
      private function updateButtonHintFilters() : void
      {
         // method body index: 699 method index: 699
         var _loc1_:* = this.filters.indexOf(WarningColorMatrixFilter);
         if(this._buttonHintData.IsWarning)
         {
            this.filters = [WarningColorMatrixFilter];
         }
         else
         {
            this.filters = [];
         }
      }
   }
}
