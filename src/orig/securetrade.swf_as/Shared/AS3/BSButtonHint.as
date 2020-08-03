package Shared.AS3 
{
    import Shared.*;
    import Shared.AS3.COMPANIONAPP.*;
    import Shared.AS3.Events.*;
    import fl.motion.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    
    public dynamic class BSButtonHint extends Shared.AS3.BSUIComponent
    {
        public function BSButtonHint()
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=0;
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
            this._hitArea = new flash.display.Sprite();
            this._hitArea.graphics.beginFill(0);
            this._hitArea.graphics.drawRect(0, 0, 1, 1);
            this._hitArea.graphics.endFill();
            this._hitArea.visible = false;
            this._hitArea.mouseEnabled = false;
            addEventListener(flash.events.MouseEvent.CLICK, this.onTextClick);
            addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            if (this.HoldMeter_mc != null) 
            {
                loc1 = this.HoldMeter_mc.currentLabels;
                loc3 = false;
                loc4 = 1;
                while (loc4 < loc1.length) 
                {
                    loc2 = loc1[loc4] as flash.display.FrameLabel;
                    if (loc3) 
                    {
                        this.m_HoldFrames = (loc2.frame - this.m_HoldStartFrame - 1);
                    }
                    if (loc2.name == "buttonHold") 
                    {
                        loc3 = true;
                        this.m_HoldStartFrame = loc2.frame;
                    }
                    ++loc4;
                }
            }
            return;
        }

        protected function onMouseOut(arg1:flash.events.MouseEvent):*
        {
            this.bMouseOver = false;
            return;
        }

        public function get useVaultTecColor():Boolean
        {
            return this.m_UseVaultTecColor;
        }

        public function set useVaultTecColor(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 != this.m_UseVaultTecColor) 
            {
                this.m_UseVaultTecColor = arg1;
                if (arg1) 
                {
                    if (colorMatrix == null) 
                    {
                        loc1 = new fl.motion.AdjustColor();
                        loc1.brightness = 100;
                        loc1.contrast = 0;
                        loc1.saturation = -77;
                        loc1.hue = -55;
                        loc2 = loc1.CalculateFinalFlatArray();
                        colorMatrix = new flash.filters.ColorMatrixFilter(loc2);
                    }
                    this.HoldMeter_mc.filters = [colorMatrix];
                    this.textField_tf.textColor = 16777163;
                    this.IconHolderInstance.IconAnimInstance.Icon_tf.textColor = 16777163;
                    this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf.textColor = 16777163;
                }
                else 
                {
                    this.HoldMeter_mc.filters = null;
                    this.textField_tf.textColor = 65280;
                    this.IconHolderInstance.IconAnimInstance.Icon_tf.textColor = 65280;
                    this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf.textColor = 65280;
                }
            }
            return;
        }

        public function set canHold(arg1:Boolean):void
        {
            this.m_CanHold = arg1;
            return;
        }

        public function set holdPercent(arg1:Number):void
        {
            if (arg1 != this.m_HoldPercent) 
            {
                this.m_HoldPercent = arg1;
                this.redrawHoldIndicator();
            }
            return;
        }

        internal function redrawHoldIndicator():void
        {
            if (this.HoldMeter_mc != null) 
            {
                if (this.m_CanHold) 
                {
                    this.HoldMeter_mc.visible = true;
                    if (this.m_HoldPercent >= 1) 
                    {
                        this.HoldMeter_mc.gotoAndPlay("buttonHoldComplete");
                    }
                    else if (this.m_HoldPercent > 0) 
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
            return;
        }

        public override function redrawUIComponent():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=0;
            super.redrawUIComponent();
            hitArea = null;
            if (contains(this._hitArea)) 
            {
                removeChild(this._hitArea);
            }
            visible = this.ButtonVisible;
            if (visible) 
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
                if (this.m_CanHold) 
                {
                    this.HoldMeter_mc.x = this.IconHolderInstance.x + this.IconHolderInstance.width / 2;
                    this.HoldMeter_mc.scaleX = this.UsePCKey ? HOLD_KEY_SCALE : 1;
                    this.HoldMeter_mc.scaleY = this.UsePCKey ? HOLD_KEY_SCALE : 1;
                }
                this.redrawHitArea();
                addChild(this._hitArea);
                hitArea = this._hitArea;
                loc1 = 0;
                loc2 = 0;
                loc3 = 0;
                loc4 = 0;
                loc5 = [this.IconHolderInstance, this.SecondaryIconHolderInstance, this.textField_tf];
                loc6 = 0;
                while (loc6 < loc5.length) 
                {
                    loc2 = Math.max(loc2, loc5[loc6].x + loc5[loc6].width);
                    loc4 = Math.max(loc4, loc5[loc6].y + loc5[loc6].height);
                    ++loc6;
                }
                this.Sizer_mc.x = loc1;
                this.Sizer_mc.y = loc3;
                this.Sizer_mc.width = loc2 - loc1;
                this.Sizer_mc.height = loc4 - loc3;
            }
            return;
        }

        public function get bButtonPressed():Boolean
        {
            return this._bButtonPressed;
        }

        public function SetFlashing(arg1:Boolean):*
        {
            if (arg1 != this.bButtonFlashing) 
            {
                this.bButtonFlashing = arg1;
                this.IconHolderInstance.gotoAndPlay(arg1 ? "Flashing" : "Default");
            }
            return;
        }

        internal function UpdateIconTextField(arg1:flash.text.TextField, arg2:String):*
        {
            var loc4:*=undefined;
            arg1.text = arg2;
            var loc1:*=this.GetExpectedFont();
            var loc2:*=arg1.getTextFormat().font;
            if (loc1 != loc2) 
            {
                loc4 = new flash.text.TextFormat(loc1);
                arg1.setTextFormat(loc4);
            }
            var loc3:*=this.UsePCKey ? 1.25 : 2.25;
            if (arg1.y != loc3) 
            {
                arg1.y = loc3;
            }
            return;
        }

        internal function redrawDynamicMovieClip():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (this._buttonHintData.DynamicMovieClipName != this._strCurrentDynamicMovieClipName) 
            {
                if (this.DynamicMovieClip) 
                {
                    removeChild(this.DynamicMovieClip);
                }
                if (this.UseDynamicMovieClip) 
                {
                    loc1 = flash.utils.getDefinitionByName(this._buttonHintData.DynamicMovieClipName) as Class;
                    this.DynamicMovieClip = new (loc1 as Class)();
                    addChild(this.DynamicMovieClip);
                    loc2 = this._DyanmicMovieHeight / this.DynamicMovieClip.height;
                    this.DynamicMovieClip.scaleX = loc2;
                    this.DynamicMovieClip.scaleY = loc2;
                    this.DynamicMovieClip.alpha = this.AllButtonsDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
                    this.DynamicMovieClip.x = this.Justification != JUSTIFY_LEFT ? this.IconHolderInstance.x - this.DynamicMovieClip.width - DYNAMIC_MOVIE_CLIP_BUFFER : this.IconHolderInstance.width + DYNAMIC_MOVIE_CLIP_BUFFER;
                    this.DynamicMovieClip.y = this._DynamicMovieY;
                }
            }
            return;
        }

        internal function redrawTextField():void
        {
            var loc1:*=undefined;
            this.textField_tf.visible = !this.UseDynamicMovieClip;
            if (this.textField_tf.visible) 
            {
                Shared.GlobalFunc.SetText(this.textField_tf, this.ButtonText, false, true, false);
                this.textField_tf.alpha = this.AllButtonsDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
                loc1 = this.m_CanHold ? HOLD_TEXT_OFFSET : 0;
                this.textField_tf.x = this.Justification != JUSTIFY_LEFT ? this.IconHolderInstance.x - this.textField_tf.width - loc1 : this.IconHolderInstance.width + loc1;
            }
            return;
        }

        internal function redrawSecondaryButton():void
        {
            this.SecondaryIconHolderInstance.visible = this._buttonHintData.hasSecondaryButton;
            if (this.SecondaryIconHolderInstance.visible) 
            {
                this.UpdateIconTextField(this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf, this.SecondaryControllerButton);
                this.SecondaryIconHolderInstance.alpha = this.SecondaryButtonDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
                this.SecondaryIconHolderInstance.x = this.UseDynamicMovieClip ? this.DynamicMovieClip.x + this.DynamicMovieClip.width + DYNAMIC_MOVIE_CLIP_BUFFER : this.textField_tf.x + this.textField_tf.width;
            }
            return;
        }

        internal function redrawPrimaryButton():void
        {
            this.UpdateIconTextField(this.IconHolderInstance.IconAnimInstance.Icon_tf, this.ControllerButton);
            this.IconHolderInstance.alpha = this.ButtonDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
            this.IconHolderInstance.x = this.Justification != JUSTIFY_LEFT ? -this.IconHolderInstance.width : 0;
            return;
        }

        internal function redrawHitArea():void
        {
            var loc1:*=this.getBounds(this);
            this._hitArea.x = loc1.x;
            this._hitArea.width = loc1.width;
            this._hitArea.y = loc1.y;
            this._hitArea.height = loc1.height;
            return;
        }

        internal function GetExpectedFont():String
        {
            var loc1:*=null;
            var loc2:*=false;
            if (this.UsePCKey) 
            {
                loc1 = "$MAIN_Font";
            }
            else 
            {
                loc2 = !this.bMouseOver && !this.bButtonPressed;
                loc1 = loc2 ? "$Controller_buttons" : "$Controller_buttons_inverted";
            }
            return loc1;
        }

        internal function SetUpTextFields(arg1:flash.text.TextField):*
        {
            arg1.autoSize = flash.text.TextFieldAutoSize.LEFT;
            arg1.antiAliasType = flash.text.AntiAliasType.NORMAL;
            return;
        }

        public function set ButtonHintData(arg1:Shared.AS3.BSButtonHintData):void
        {
            if (this._buttonHintData) 
            {
                this._buttonHintData.removeEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
            }
            this._buttonHintData = arg1;
            if (this._buttonHintData) 
            {
                this._buttonHintData.addEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
            }
            SetIsDirty();
            return;
        }

        internal function onButtonHintDataDirtyEvent(arg1:flash.events.Event):void
        {
            SetIsDirty();
            return;
        }

        public function get PCKey():String
        {
            var loc1:*=null;
            if (this._buttonHintData.PCKey) 
            {
                loc1 = this._buttonHintData.PCKey;
                loc1 = this.TranslateKey(loc1);
                return this.Justification != JUSTIFY_LEFT ? "(" + loc1 : loc1 + ")";
            }
            return "";
        }

        public function get SecondaryPCKey():String
        {
            var loc1:*=null;
            if (this._buttonHintData.SecondaryPCKey) 
            {
                loc1 = this._buttonHintData.SecondaryPCKey;
                loc1 = this.TranslateKey(loc1);
                return "(" + loc1;
            }
            return "";
        }

        internal function TranslateKey(arg1:String):String
        {
            var loc1:*=uiKeyboard;
            switch (loc1) 
            {
                case Shared.AS3.Events.PlatformChangeEvent.PLATFORM_PC_KB_FR:
                {
                    if (FRtoENMap.hasOwnProperty(arg1)) 
                    {
                        arg1 = FRtoENMap[arg1];
                    }
                    break;
                }
                case Shared.AS3.Events.PlatformChangeEvent.PLATFORM_PC_KB_BE:
                {
                    if (BEtoENMap.hasOwnProperty(arg1)) 
                    {
                        arg1 = BEtoENMap[arg1];
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return arg1;
        }

        internal function get UsePCKey():Boolean
        {
            return uiController == Shared.AS3.Events.PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && !NameToTextMap.hasOwnProperty(this._buttonHintData.PCKey);
        }

        public function get ControllerButton():String
        {
            var loc1:*="";
            if (!(uiController == Shared.AS3.Events.PlatformChangeEvent.PLATFORM_MOBILE) && this.UsePCKey) 
            {
                loc1 = this.PCKey;
            }
            else 
            {
                var loc2:*=uiController;
            }
            return loc1;
        }

        public function get SecondaryControllerButton():String
        {
            var loc1:*="";
            if (this._buttonHintData.hasSecondaryButton) 
            {
                if (!(uiController == Shared.AS3.Events.PlatformChangeEvent.PLATFORM_MOBILE) && this.UsePCKey) 
                {
                    loc1 = this.SecondaryPCKey;
                }
                else 
                {
                    var loc2:*=uiController;
                }
            }
            return loc1;
        }

        public function get ButtonText():String
        {
            return this._buttonHintData.ButtonText;
        }

        public function get Justification():uint
        {
            if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                return this._buttonHintData == null ? JUSTIFY_LEFT : this._buttonHintData.Justification;
            }
            return this._buttonHintData.Justification;
        }

        public function get ButtonDisabled():Boolean
        {
            return this._buttonHintData.ButtonDisabled;
        }

        public function get SecondaryButtonDisabled():Boolean
        {
            return this._buttonHintData.SecondaryButtonDisabled;
        }

        public function get AllButtonsDisabled():Boolean
        {
            return this.ButtonDisabled && (!this._buttonHintData.hasSecondaryButton || this.SecondaryButtonDisabled);
        }

        public function get ButtonVisible():Boolean
        {
            return this._buttonHintData && this._buttonHintData.ButtonVisible;
        }

        public function get UseDynamicMovieClip():Boolean
        {
            return this._buttonHintData.DynamicMovieClipName.length > 0;
        }

        public function onTextClick(arg1:flash.events.Event):void
        {
            var loc1:*=undefined;
            var loc2:*=undefined;
            if (this.ButtonVisible) 
            {
                loc1 = !this.ButtonDisabled;
                loc2 = false;
                if (this._buttonHintData.SecondaryPCKey && (arg1 as flash.events.MouseEvent).localX > this._hitArea.width / 2) 
                {
                    loc1 = false;
                    loc2 = !this.SecondaryButtonDisabled;
                }
                if (loc1) 
                {
                    this._buttonHintData.onTextClick();
                }
                else if (loc2) 
                {
                    this._buttonHintData.onSecondaryButtonClick();
                }
            }
            return;
        }

        internal function updateButtonHintFilters():void
        {
            var loc1:*=this.filters.indexOf(WarningColorMatrixFilter);
            if (this._buttonHintData.IsWarning) 
            {
                this.filters = [WarningColorMatrixFilter];
            }
            else 
            {
                this.filters = [];
            }
            return;
        }

        
        {
            colorMatrix = null;
        }

        public function set bButtonPressed(arg1:Boolean):*
        {
            if (this._bButtonPressed != arg1) 
            {
                this._bButtonPressed = arg1;
                SetIsDirty();
            }
            return;
        }

        public function get bMouseOver():Boolean
        {
            return this._bMouseOver;
        }

        public function set bMouseOver(arg1:Boolean):*
        {
            if (this._bMouseOver != arg1) 
            {
                this._bMouseOver = arg1;
                SetIsDirty();
            }
            return;
        }

        internal function onMouseOver(arg1:flash.events.MouseEvent):*
        {
            this.bMouseOver = true;
            return;
        }

        internal static const DISABLED_GREY_OUT_ALPHA:Number=0.5;

        public static const JUSTIFY_RIGHT:uint=0;

        public static const HOLD_TEXT_OFFSET:Number=10;

        public static const HOLD_KEY_SCALE:Number=1.25;

        internal static const DYNAMIC_MOVIE_CLIP_BUFFER:int=3;

        internal static const NameToTextMap:Object={"Xenon_A":"A", "Xenon_B":"B", "Xenon_X":"C", "Xenon_Y":"D", "Xenon_Select":"E", "Xenon_LS":"F", "Xenon_L1":"G", "Xenon_L3":"H", "Xenon_L2":"I", "Xenon_L2R2":"J", "Xenon_RS":"K", "Xenon_R1":"L", "Xenon_R3":"M", "Xenon_R2":"N", "Xenon_Start":"O", "Xenon_L1R1":"Z", "_Positive":"P", "_Negative":"Q", "_Question":"R", "_Neutral":"S", "Left":"T", "Right":"U", "Down":"V", "Up":"W", "Xenon_R2_Alt":"X", "Xenon_L2_Alt":"Y", "PSN_A":"a", "PSN_Y":"b", "PSN_X":"c", "PSN_B":"d", "PSN_Select":"z", "PSN_L3":"f", "PSN_L1":"g", "PSN_L1R1":"h", "PSN_LS":"i", "PSN_L2":"j", "PSN_L2R2":"k", "PSN_R3":"l", "PSN_R1":"m", "PSN_RS":"n", "PSN_R2":"o", "PSN_Start":"p", "_DPad_LR":"q", "_DPad_UD":"r", "_DPad_Left":"t", "_DPad_Right":"u", "_DPad_Down":"v", "_DPad_Up":"w", "PSN_R2_Alt":"x", "PSN_L2_Alt":"y"};

        internal static const FRtoENMap:Object={"A":"Q", "Q":"A", "W":"Z", "Z":"W", "-":")"};

        internal static const BEtoENMap:Object={"A":"Q", "Q":"A", "W":"Z", "Z":"W", "-":")", "=":"-"};

        internal static const WarningColorMatrixFilter:flash.filters.ColorMatrixFilter=new flash.filters.ColorMatrixFilter(new Array(1, 0, 0, 0, -9, 0, 1, 0, 0, -141, 0, 0, 1, 0, -114, 0, 0, 0, 1, 0));

        public static const JUSTIFY_LEFT:uint=1;

        public var textField_tf:flash.text.TextField;

        public var IconHolderInstance:flash.display.MovieClip;

        public var SecondaryIconHolderInstance:flash.display.MovieClip;

        public var HoldMeter_mc:flash.display.MovieClip;

        public var Sizer_mc:flash.display.MovieClip;

        internal var m_CanHold:Boolean=false;

        internal var m_HoldPercent:Number=0;

        internal var m_HoldStartFrame:int=0;

        internal var m_UseVaultTecColor:Boolean=false;

        internal var _hitArea:flash.display.Sprite;

        internal var DynamicMovieClip:flash.display.MovieClip;

        internal var bButtonFlashing:Boolean;

        internal var _strCurrentDynamicMovieClipName:String;

        internal var _DyanmicMovieHeight:Number;

        internal var _DynamicMovieY:Number;

        internal var _buttonHintData:Shared.AS3.BSButtonHintData;

        var _bButtonPressed:Boolean=false;

        var _bMouseOver:Boolean=false;

        internal static var colorMatrix:flash.filters.ColorMatrixFilter=null;

        internal var m_HoldFrames:int=25;
    }
}
