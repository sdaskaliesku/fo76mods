package Shared.AS3 
{
    import Shared.*;
    import Shared.AS3.Styles.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import scaleform.gfx.*;
    
    public class BCBasicModal extends Shared.AS3.BSUIComponent
    {
        public function BCBasicModal()
        {
            this.m_AcceptButton = new Shared.AS3.BSButtonHintData("$ACCEPT", "Space", "PSN_A", "Xenon_A", 1, this.onConfirm);
            this.m_CancelButton = new Shared.AS3.BSButtonHintData("$CANCEL", "TAB", "PSN_B", "Xenon_B", 1, this.onCancel);
            super();
            if (this.Internal_mc != null) 
            {
                this.Header_mc = this.Internal_mc.Header_mc;
                this.Tooltip_mc = this.Internal_mc.Tooltip_mc;
                this.TooltipExtra_mc = this.Internal_mc.TooltipExtra_mc;
                this.Value_mc = this.Internal_mc.Value_mc;
                this.Background_mc = this.Internal_mc.Background_mc;
                this.ButtonHintBar_mc = this.Internal_mc.ButtonHintBar_mc;
                this.ButtonList_mc = this.Internal_mc.ButtonList_mc;
                this.ComponentList_mc = this.Internal_mc.ComponentList_mc;
            }
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.Header_mc.textField, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            if (this.ButtonList_mc != null) 
            {
                Shared.AS3.StyleSheet.apply(this.ButtonList_mc, false, Shared.AS3.Styles.MessageBoxButtonListStyle);
            }
            addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp);
            mouseEnabled = false;
            mouseChildren = false;
            SetIsDirty();
            return;
        }

        public function set customButtonList(arg1:Array):void
        {
            var loc1:*=0;
            if (arg1 != null) 
            {
                loc1 = arg1.length;
                if (loc1 > 0 && loc1 <= 10) 
                {
                    this.m_ButtonListCustom = arg1;
                    SetIsDirty();
                }
                else 
                {
                    trace("WARNING: BCBasicModal::customButtonList - List expects 1-10 entries, but has " + loc1);
                }
            }
            return;
        }

        public function set choiceButtonMode(arg1:uint):void
        {
            this.m_ChoiceButtonMode = arg1;
            SetIsDirty();
            return;
        }

        public function get choiceButtonMode():uint
        {
            return this.m_ChoiceButtonMode;
        }

        public function set previousFocus(arg1:flash.display.InteractiveObject):void
        {
            this.m_PreviousFocus = arg1;
            return;
        }

        public function get previousFocus():flash.display.InteractiveObject
        {
            return this.m_PreviousFocus;
        }

        public function set header(arg1:String):*
        {
            this.Header_mc.textField.text = arg1;
            SetIsDirty();
            return;
        }

        internal function initializeButtonBar():void
        {
            var loc1:*=null;
            if (!this.m_ButtonBarInitialized) 
            {
                loc1 = new Vector.<Shared.AS3.BSButtonHintData>();
                loc1.push(this.m_AcceptButton);
                loc1.push(this.m_CancelButton);
                this.ButtonHintBar_mc.SetButtonHintData(loc1);
            }
            return;
        }

        internal function populateButtonList():void
        {
            if (!this.m_ButtonListInitialized) 
            {
                addEventListener(Shared.AS3.BSScrollingList.ITEM_PRESS, this.onItemPress);
            }
            if (this.m_ButtonListCustom == null) 
            {
                this.ButtonList_mc.entryList = [{"text":"$OK"}, {"text":"$CANCEL"}];
            }
            else 
            {
                this.ButtonList_mc.entryList = this.m_ButtonListCustom;
            }
            this.ButtonList_mc.InvalidateData();
            this.ButtonList_mc.selectedIndex = 0;
            return;
        }

        internal function onItemPress(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event(EVENT_ENTRY_SELECTED, true, true));
            if (this.ButtonList_mc.selectedIndex != 0) 
            {
                this.onCancel();
            }
            else 
            {
                this.onConfirm();
            }
            arg1.stopPropagation();
            return;
        }

        public override function redrawUIComponent():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=0;
            if (this.Value_mc != null) 
            {
                loc1 = [this.Value_mc.Value_tf];
                if (this.Value_mc.Icon_mc != null) 
                {
                    loc1.push(this.Value_mc.Icon_mc);
                }
                Shared.GlobalFunc.arrangeItems(loc1, false, Shared.GlobalFunc.ALIGN_CENTER, VALUE_ICON_SPACING);
            }
            if (this.ButtonHintBar_mc != null) 
            {
                this.ButtonHintBar_mc.redrawUIComponent();
                if (this.m_ChoiceButtonMode == BUTTON_MODE_BAR) 
                {
                    this.initializeButtonBar();
                }
                this.ButtonHintBar_mc.visible = this.m_ChoiceButtonMode == BUTTON_MODE_BAR;
            }
            if (this.ButtonList_mc != null) 
            {
                if (this.m_ChoiceButtonMode == BUTTON_MODE_LIST) 
                {
                    this.populateButtonList();
                }
                this.ButtonList_mc.visible = this.m_ChoiceButtonMode == BUTTON_MODE_LIST;
            }
            if (this.ComponentList_mc != null) 
            {
                if (this.ComponentList_mc.ScrollUp != null) 
                {
                    this.ComponentList_mc.ScrollUp.y = this.ComponentList_mc.ScrollUp.height / 2;
                }
                if (this.ComponentList_mc.ScrollDown != null) 
                {
                    this.ComponentList_mc.ScrollDown.y = this.ComponentList_mc.shownItemsHeight - this.ComponentList_mc.ScrollDown.height / 2;
                }
            }
            if (this.m_DynamicLayout) 
            {
                this.Background_mc.width = Math.max(BACKGROUND_MINWIDTH, this.Background_mc.width);
                this.Header_mc.textField.width = this.Background_mc.width - ELEMENT_X_PADDING * 2;
                this.Header_mc.textField.x = this.Header_mc.textField.width / -2;
                loc2 = this.Background_mc.width;
                loc3 = (loaderInfo.width - loc2) / 2;
                loc4 = loc3 + loc2 / 2;
                loc5 = [this.Header_mc];
                if (!(this.Tooltip_mc == null) && !(this.m_Tooltip == null) && this.m_Tooltip.length > 0) 
                {
                    loc5.push(this.Tooltip_mc);
                }
                if (!(this.TooltipExtra_mc == null) && !(this.m_TooltipExtra == null) && this.m_TooltipExtra.length > 0) 
                {
                    loc5.push(this.TooltipExtra_mc);
                }
                if (this.ComponentList_mc != null) 
                {
                    this.ComponentList_mc.x = loc4;
                    loc5.push(this.ComponentList_mc);
                }
                if (this.Value_mc != null) 
                {
                    loc5.push(this.Value_mc);
                }
                if (!(this.ButtonHintBar_mc == null) && this.ButtonHintBar_mc.visible) 
                {
                    this.ButtonHintBar_mc.x = loc4;
                    loc5.push(this.ButtonHintBar_mc);
                }
                if (!(this.ButtonList_mc == null) && this.ButtonList_mc.visible) 
                {
                    this.ButtonList_mc.x = loc4;
                    loc5.push(this.ButtonList_mc);
                }
                loc6 = Shared.GlobalFunc.arrangeItems(loc5, true, Shared.GlobalFunc.ALIGN_LEFT, ELEMENT_Y_SPACING, false, ELEMENT_Y_PADDING) + ELEMENT_Y_PADDING * 2;
                loc7 = (stage.stageHeight - loc6) / 2;
                this.Background_mc.x = loc3;
                this.Background_mc.y = loc7;
                this.Background_mc.height = loc6;
                loc8 = 0;
                while (loc8 < loc5.length) 
                {
                    loc5[loc8].y = loc5[loc8].y + loc7;
                    ++loc8;
                }
            }
            return;
        }

        protected function onCancel():void
        {
            dispatchEvent(new flash.events.Event(EVENT_CANCEL, true, true));
            return;
        }

        protected function onConfirm():void
        {
            dispatchEvent(new flash.events.Event(EVENT_CONFIRM, true, true));
            return;
        }

        public function onKeyUp(arg1:flash.events.KeyboardEvent):*
        {
            if (arg1.keyCode == flash.ui.Keyboard.ENTER) 
            {
                this.onConfirm();
            }
            return;
        }

        public function set open(arg1:Boolean):*
        {
            if (arg1 != this.m_Open) 
            {
                this.m_Open = arg1;
                if (this.m_Open) 
                {
                    gotoAndPlay("rollOn");
                    if (!(this.ButtonList_mc == null) && this.m_ChoiceButtonMode == BUTTON_MODE_LIST) 
                    {
                        this.ButtonList_mc.selectedIndex = 0;
                        stage.focus = this.ButtonList_mc;
                    }
                }
                else 
                {
                    gotoAndPlay("rollOff");
                }
                mouseEnabled = this.m_Open;
                mouseChildren = this.m_Open;
            }
            return;
        }

        public function get open():Boolean
        {
            return this.m_Open;
        }

        public function set value(arg1:String):*
        {
            if (this.Value_mc != null) 
            {
                this.Value_mc.Value_tf.text = arg1;
                SetIsDirty();
            }
            return;
        }

        public function set tooltipExtra(arg1:String):*
        {
            this.TooltipExtra_mc.textField.text = arg1;
            this.m_TooltipExtra = arg1;
            if (this.TooltipExtra_mc != null) 
            {
                if (this.m_TooltipExtra.length > 0) 
                {
                    this.TooltipExtra_mc.visible = true;
                }
                else 
                {
                    this.TooltipExtra_mc.visible = false;
                }
            }
            SetIsDirty();
            return;
        }

        public function set tooltip(arg1:String):*
        {
            this.Tooltip_mc.textField.text = arg1;
            this.m_Tooltip = arg1;
            if (this.Tooltip_mc != null) 
            {
                if (this.m_Tooltip.length > 0) 
                {
                    this.Tooltip_mc.visible = true;
                }
                else 
                {
                    this.Tooltip_mc.visible = false;
                }
            }
            SetIsDirty();
            return;
        }

        public function get tooltip():String
        {
            return this.Tooltip_mc.textField.text;
        }

        public function set dynamicLayout(arg1:Boolean):void
        {
            this.m_DynamicLayout = arg1;
            SetIsDirty();
            return;
        }

        public static const ELEMENT_Y_PADDING:Number=25;

        public static const BUTTON_MODE_NONE:uint=0;

        public static const BUTTON_MODE_LIST:uint=1;

        public static const BUTTON_MODE_BAR:uint=2;

        public static const BACKGROUND_MINWIDTH:Number=750;

        public static const ELEMENT_X_PADDING:Number=24;

        public static const EVENT_CONFIRM:String="BSBasicModal::Confirm";

        public static const EVENT_CANCEL:String="BSBasicModal::Cancel";

        public static const EVENT_ENTRY_SELECTED:String="BSBasicModal::EntrySelected";

        public static const VALUE_ICON_SPACING:Number=6;

        public static const ELEMENT_Y_SPACING:Number=12;

        public var Header_mc:flash.display.MovieClip;

        public var Tooltip_mc:flash.display.MovieClip;

        public var TooltipExtra_mc:flash.display.MovieClip;

        public var Value_mc:flash.display.MovieClip;

        public var Background_mc:flash.display.MovieClip;

        internal var m_PreviousFocus:flash.display.InteractiveObject;

        public var Internal_mc:flash.display.MovieClip;

        public var ComponentList_mc:Shared.AS3.BSScrollingList;

        public var ButtonList_mc:MessageBoxButtonList;

        protected var m_CancelButton:Shared.AS3.BSButtonHintData;

        protected var m_AcceptButton:Shared.AS3.BSButtonHintData;

        internal var m_DynamicLayout:Boolean=true;

        internal var m_ButtonListCustom:Array;

        public var ButtonHintBar_mc:Shared.AS3.BSButtonHintBar;

        internal var m_Open:Boolean=false;

        internal var m_ButtonListInitialized:Boolean=false;

        internal var m_ButtonBarInitialized:Boolean=false;

        internal var m_TooltipExtra:String;

        internal var m_Tooltip:String;

        internal var m_ChoiceButtonMode:uint=0;
    }
}
