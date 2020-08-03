package Shared.AS3 
{
    import Shared.*;
    import Shared.AS3.Events.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    
    public class QuantityMenu extends flash.display.MovieClip
    {
        public function QuantityMenu()
        {
            var loc1:*=null;
            this.m_AcceptButton = new Shared.AS3.BSButtonHintData("$ACCEPT", "Space", "PSN_A", "Xenon_A", 1, this.onConfirm);
            this.m_CancelButton = new Shared.AS3.BSButtonHintData("$CANCEL", "TAB", "PSN_B", "Xenon_B", 1, this.onCancel);
            super();
            this.uiScrollStartTime = 0;
            this.uiScrollCurSpeed = 1;
            this.iScrollSpeed = 1;
            this.uiQuantity = 1;
            this.uiMaxQuantity = 1;
            this.uiMinQuantity = 1;
            this.bOpened = false;
            this.bIsScrolling = false;
            addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp);
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            addEventListener(Option_Scrollbar.VALUE_CHANGE, this.onValueChange);
            this.QuantityScrollbar_mc.removeEventListener(flash.events.MouseEvent.CLICK, this.QuantityScrollbar_mc.onClick);
            this.QuantityScrollbar_mc.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onArrowMouseDown);
            if (this.Header_mc != null) 
            {
                this.Label_tf = this.Header_mc.textField;
            }
            if (this.Value_mc != null) 
            {
                this.Value_tf = this.Value_mc.Value_tf;
            }
            mouseEnabled = false;
            mouseChildren = false;
            if (this.ButtonHintBar_mc != null) 
            {
                loc1 = new Vector.<Shared.AS3.BSButtonHintData>();
                loc1.push(this.m_AcceptButton);
                loc1.push(this.m_CancelButton);
                this.ButtonHintBar_mc.SetButtonHintData(loc1);
            }
            return;
        }

        public function set quantity(arg1:uint):void
        {
            if (this.m_ValueList == null) 
            {
                this.uiQuantity = arg1;
            }
            else 
            {
                this.m_ValueList[this.uiQuantity] = arg1;
            }
            return;
        }

        public function get quantity():uint
        {
            if (this.m_ValueList != null) 
            {
                return this.m_ValueList[this.uiQuantity];
            }
            return this.uiQuantity;
        }

        public function get opened():Boolean
        {
            return this.bOpened;
        }

        public function set acceptButtonText(arg1:String):void
        {
            this.m_AcceptButton.ButtonText = arg1;
            return;
        }

        public function set cancelButtonText(arg1:String):void
        {
            this.m_CancelButton.ButtonText = arg1;
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
                                this.modifyQuantity(this.iTriggerStepSize);
                                loc1 = true;
                            }
                        }
                        else 
                        {
                            this.modifyQuantity(-this.iTriggerStepSize);
                            loc1 = true;
                        }
                    }
                    else 
                    {
                        this.modifyQuantity(this.iShoulderStepSize);
                        loc1 = true;
                    }
                }
                else 
                {
                    this.modifyQuantity(-this.iShoulderStepSize);
                    loc1 = true;
                }
            }
            return loc1;
        }

        public function OpenMenu(arg1:int, arg2:flash.display.InteractiveObject, arg3:String="", arg4:*=0, arg5:uint=1, arg6:uint=4294967295, arg7:Boolean=false):*
        {
            if (arg6 == uint.MAX_VALUE) 
            {
                this.uiQuantity = arg1;
            }
            else 
            {
                this.uiQuantity = arg6;
            }
            this.uiMinQuantity = arg5;
            this.uiMaxQuantity = arg1;
            this.QuantityScrollbar_mc.MinValue = arg5;
            this.QuantityScrollbar_mc.MaxValue = arg1;
            this.iArrowStepSize = 1;
            this.iShoulderStepSize = Math.max(arg1 / 20, 1);
            this.iTriggerStepSize = Math.max(arg1 / 4, 1);
            this.QuantityScrollbar_mc.StepSize = this.iArrowStepSize;
            this.QuantityScrollbar_mc.value = this.uiQuantity;
            this.uiItemValue = arg4;
            if (arg3.length) 
            {
                Shared.GlobalFunc.SetText(this.Label_tf, arg3, false);
            }
            if (this.QuantityBracketHolder_mc != null) 
            {
                this.FitBrackets();
            }
            this.RefreshText();
            this.prevFocusObj = arg2;
            if (arg7) 
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
            return;
        }

        public function onArrowMouseDown(arg1:flash.events.MouseEvent):*
        {
            var loc2:*=null;
            var loc1:*=arg1.target;
            if (arg1.target as flash.display.MovieClip) 
            {
                loc2 = arg1.target as flash.display.MovieClip;
                if (loc2 != this.QuantityScrollbar_mc.RightCatcher_mc) 
                {
                    if (loc2 == this.QuantityScrollbar_mc.LeftCatcher_mc) 
                    {
                        this.bIsScrolling = true;
                        this.uiScrollStartTime = flash.utils.getTimer();
                        this.iScrollSpeed = -1;
                        this.modifyQuantity(-this.iArrowStepSize);
                        stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onArrowMouseUp);
                        addEventListener(flash.events.Event.ENTER_FRAME, this.onArrowTick);
                    }
                }
                else 
                {
                    this.bIsScrolling = true;
                    this.uiScrollStartTime = flash.utils.getTimer();
                    this.iScrollSpeed = 1;
                    this.modifyQuantity(this.iArrowStepSize);
                    stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onArrowMouseUp);
                    addEventListener(flash.events.Event.ENTER_FRAME, this.onArrowTick);
                }
            }
            return;
        }

        function onValueChange(arg1:flash.events.Event):void
        {
            this.uiQuantity = this.QuantityScrollbar_mc.value;
            this.RefreshText();
            return;
        }

        function onArrowTick(arg1:flash.events.Event):void
        {
            var loc1:*=undefined;
            if (this.bIsScrolling) 
            {
                loc1 = flash.utils.getTimer() - this.uiScrollStartTime;
                if (loc1 > SCROLL_STARTSPEED) 
                {
                    this.uiScrollCurSpeed = this.uiScrollCurSpeed + int(Math.floor(this.uiScrollCurSpeed * loc1 / SCROLL_TIMECOEF));
                    this.uiScrollCurSpeed = Math.min(this.uiScrollCurSpeed, SCROLL_MAX);
                    this.modifyQuantity(this.uiScrollCurSpeed * this.iScrollSpeed);
                }
            }
            return;
        }

        function onArrowMouseUp(arg1:flash.events.Event):void
        {
            this.bIsScrolling = false;
            this.uiScrollCurSpeed = 1;
            removeEventListener(flash.events.Event.ENTER_FRAME, this.onArrowTick);
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onArrowMouseUp);
            return;
        }

        public function onMouseWheel(arg1:flash.events.MouseEvent):*
        {
            if (arg1.delta > 0) 
            {
                this.modifyQuantity(this.iArrowStepSize);
            }
            else if (arg1.delta < 0) 
            {
                this.modifyQuantity(-this.iArrowStepSize);
            }
            return;
        }

        internal function onCancel():void
        {
            this.stopScroll();
            dispatchEvent(new flash.events.Event(CANCEL, true, true));
            return;
        }

        internal function onConfirm():void
        {
            this.stopScroll();
            dispatchEvent(new flash.events.Event(CONFIRM, true, true));
            return;
        }

        public function onKeyUp(arg1:flash.events.KeyboardEvent):*
        {
            if (arg1.keyCode == flash.ui.Keyboard.UP || arg1.keyCode == flash.ui.Keyboard.DOWN || arg1.keyCode == flash.ui.Keyboard.RIGHT || arg1.keyCode == flash.ui.Keyboard.LEFT) 
            {
                this.stopScroll();
            }
            if (arg1.keyCode == flash.ui.Keyboard.ENTER) 
            {
                this.onConfirm();
                arg1.stopPropagation();
            }
            return;
        }

        public function onKeyDown(arg1:flash.events.KeyboardEvent):*
        {
            if (arg1.keyCode != flash.ui.Keyboard.RIGHT) 
            {
                if (arg1.keyCode == flash.ui.Keyboard.LEFT) 
                {
                    this.bIsScrolling = true;
                    this.uiScrollStartTime = flash.utils.getTimer();
                    this.iScrollSpeed = -1;
                    this.modifyQuantity(-1);
                    addEventListener(flash.events.Event.ENTER_FRAME, this.onArrowTick);
                    removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
                }
            }
            else 
            {
                this.bIsScrolling = true;
                this.uiScrollStartTime = flash.utils.getTimer();
                this.iScrollSpeed = 1;
                this.modifyQuantity(1);
                addEventListener(flash.events.Event.ENTER_FRAME, this.onArrowTick);
                removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            }
            return;
        }

        internal function stopScroll():*
        {
            this.bIsScrolling = false;
            this.uiScrollCurSpeed = 1;
            removeEventListener(flash.events.Event.ENTER_FRAME, this.onArrowTick);
            addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return;
        }

        internal function modifyQuantity(arg1:int):*
        {
            var loc1:*=this.uiQuantity + arg1;
            loc1 = Math.min(loc1, this.uiMaxQuantity);
            loc1 = Math.max(loc1, this.uiMinQuantity);
            if (this.uiQuantity != loc1) 
            {
                this.uiQuantity = loc1;
                this.RefreshText();
                dispatchEvent(new Shared.AS3.Events.CustomEvent(QUANTITY_CHANGED, loc1, true));
            }
            return;
        }

        internal function RefreshText():*
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=this.uiMinQuantity;
            var loc2:*=this.uiMaxQuantity;
            var loc3:*=this.uiQuantity;
            if (this.m_ValueList != null) 
            {
                loc4 = this.m_ValueList.length;
                loc1 = this.m_ValueList[0];
                loc2 = this.m_ValueList[(loc4 - 1)];
                loc3 = this.m_ValueList[this.uiQuantity];
            }
            if (this.ValueMin_tf != null) 
            {
                Shared.GlobalFunc.SetText(this.ValueMin_tf, loc1.toString(), false);
            }
            if (this.ValueMax_tf != null) 
            {
                Shared.GlobalFunc.SetText(this.ValueMax_tf, loc2.toString(), false);
            }
            if (this.Value_tf != null) 
            {
                Shared.GlobalFunc.SetText(this.Value_tf, loc3.toString(), false);
            }
            this.QuantityScrollbar_mc.value = this.uiQuantity;
            if (this.TotalValue_tf != null) 
            {
                loc5 = this.uiQuantity * this.uiItemValue;
                Shared.GlobalFunc.SetText(this.TotalValue_tf, loc5.toString(), false);
            }
            return;
        }

        internal function FitBrackets():*
        {
            var loc1:*=this.Label_tf.x + this.Label_tf.width * 0.5;
            var loc2:*=this.Label_tf.textWidth;
            var loc3:*=this.QuantityBracketHolder_mc.QuantityMenuLeftBracket_mc;
            var loc4:*=this.QuantityBracketHolder_mc.QuantityMenuRightBracket_mc;
            var loc5:*=this.QuantityBracketHolder_mc.QuantityMenuBottomBracket_mc;
            loc3.x = loc1 - loc2 * 0.5 - LabelBufferX - loc3.width - this.QuantityBracketHolder_mc.x;
            loc4.x = loc1 + loc2 * 0.5 + LabelBufferX + loc4.width - this.QuantityBracketHolder_mc.x;
            loc5.width = loc4.x - loc3.x;
            loc5.x = loc1 - loc5.width * 0.5 - this.QuantityBracketHolder_mc.x;
            if (this.QuantityScrollbar_mc.x < this.QuantityBracketHolder_mc.x + loc3.x + 20) 
            {
                this.QuantityScrollbar_mc.x = this.QuantityBracketHolder_mc.x + loc3.x + 15;
                this.QuantityScrollbar_mc.width = loc4.x - loc3.x - 15;
            }
            return;
        }

        public function CloseMenu(arg1:Boolean=false):*
        {
            this.prevFocusObj = null;
            if (arg1) 
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
            return;
        }

        public function OpenMenuList(arg1:flash.display.InteractiveObject, arg2:String, arg3:Array):*
        {
            var loc1:*=0;
            var loc2:*=(arg3.length - 1);
            this.m_ValueList = arg3;
            this.OpenMenu(loc2, arg1, arg2, 0, loc1);
            return;
        }

        public function OpenMenuRange(arg1:flash.display.InteractiveObject, arg2:String, arg3:uint, arg4:uint, arg5:uint=4294967295, arg6:*=0, arg7:Boolean=false):*
        {
            this.OpenMenu(arg4, arg1, arg2, arg6, arg3, arg5, arg7);
            return;
        }

        public function set tooltip(arg1:String):void
        {
            if (this.Tooltip_mc != null) 
            {
                this.Tooltip_mc.textField.text = arg1;
            }
            return;
        }

        public function get prevFocus():flash.display.InteractiveObject
        {
            return this.prevFocusObj;
        }

        internal static const SCROLL_TIMECOEF:Number=1000;

        internal static const SCROLL_MAX:int=10;

        public static const INV_MAX_NUM_BEFORE_QUANTITY_MENU:uint=5;

        public static const CONFIRM:String="QuantityMenu::quantityConfirmed";

        public static const CANCEL:String="QuantityMenu::quantityCancelled";

        internal static const LabelBufferX:int=3;

        public static const QUANTITY_CHANGED:String="QuantityChanged";

        internal static const SCROLL_STARTSPEED:int=300;

        public var Label_tf:flash.text.TextField;

        public var Value_tf:flash.text.TextField;

        public var ValueMin_tf:flash.text.TextField;

        public var ValueMax_tf:flash.text.TextField;

        public var TotalValue_tf:flash.text.TextField;

        protected var iShoulderStepSize:int;

        protected var iArrowStepSize:int;

        protected var uiMinQuantity:uint;

        protected var uiMaxQuantity:uint;

        protected var uiQuantity:uint;

        internal var iScrollSpeed:int;

        internal var uiScrollCurSpeed:uint;

        internal var uiScrollStartTime:uint;

        internal var bIsScrolling:Boolean;

        public var QuantityBracketHolder_mc:flash.display.MovieClip;

        public var ButtonHintBar_mc:Shared.AS3.BSButtonHintBar;

        public var Value_mc:flash.display.MovieClip;

        public var Tooltip_mc:flash.display.MovieClip;

        public var Header_mc:flash.display.MovieClip;

        public var CapsLabel_tf:flash.text.TextField;

        public var QuantityScrollbar_mc:Option_Scrollbar;

        protected var m_CancelButton:Shared.AS3.BSButtonHintData;

        protected var m_AcceptButton:Shared.AS3.BSButtonHintData;

        protected var m_ValueList:Array;

        protected var uiItemValue:uint=0;

        protected var bOpened:Boolean;

        protected var iTriggerStepSize:int;

        protected var prevFocusObj:flash.display.InteractiveObject;
    }
}
