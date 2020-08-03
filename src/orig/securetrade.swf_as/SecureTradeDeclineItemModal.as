package 
{
    import Shared.AS3.*;
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    
    public class SecureTradeDeclineItemModal extends Shared.AS3.BCBasicMenu
    {
        public function SecureTradeDeclineItemModal()
        {
            addFrameScript(0, this.frame1, 10, this.frame11, 21, this.frame22);
            mouseEnabled = false;
            mouseChildren = false;
            m_Horizontal = true;
            addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            super();
            return;
        }

        protected override function setActive(arg1:Boolean):void
        {
            super.setActive(arg1);
            if (arg1 != _active) 
            {
                if (arg1) 
                {
                    gotoAndPlay("rollOn");
                }
                else 
                {
                    gotoAndPlay("rollOff");
                }
                mouseEnabled = arg1;
                mouseChildren = arg1;
            }
            return;
        }

        protected override function onItemPress():*
        {
            dispatchEvent(new flash.events.Event(CONFIRM, true, true));
            return;
        }

        public override function onKeyDown(arg1:flash.events.KeyboardEvent):*
        {
            if (arg1.keyCode != flash.ui.Keyboard.UP) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.DOWN) 
                {
                    if (arg1.keyCode != flash.ui.Keyboard.LEFT) 
                    {
                        if (arg1.keyCode == flash.ui.Keyboard.RIGHT) 
                        {
                            this.selectHorizontalDelta(1);
                            arg1.stopPropagation();
                        }
                    }
                    else 
                    {
                        this.selectHorizontalDelta(-1);
                        arg1.stopPropagation();
                    }
                }
                else 
                {
                    this.selectVerticalDelta(1);
                    arg1.stopPropagation();
                }
            }
            else 
            {
                this.selectVerticalDelta(-1);
                arg1.stopPropagation();
            }
            return;
        }

        internal function selectVerticalDelta(arg1:int):void
        {
            selectedIndex = this.clampIndex(selectedIndex + arg1 * COLUMNS);
            return;
        }

        internal function selectHorizontalDelta(arg1:int):void
        {
            selectedIndex = this.clampIndex(selectedIndex + arg1);
            return;
        }

        internal function clampIndex(arg1:int):int
        {
            var loc1:*=arg1;
            if (arg1 < 0) 
            {
                loc1 = 0;
            }
            else if (arg1 > (m_Entries.length - 1)) 
            {
                loc1 = selectedIndex;
            }
            return loc1;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            this.Header_mc.textField.text = "$DeclineItem";
            this.Tooltip_mc.textField.text = "$DeclineItemSetReason";
            var loc1:*=0;
            while (loc1 < REJECT_REASONS.length) 
            {
                addItem(this.DeclineButtons_mc["ReasonButton_" + REJECT_REASONS[loc1]] as Shared.AS3.BCBasicMenuItem);
                ++loc1;
            }
            return;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        internal function frame11():*
        {
            stop();
            return;
        }

        internal function frame22():*
        {
            stop();
            return;
        }

        public static const REJECT_REASONS:Array=["DontWant", "DontWantType", "NotEnoughCaps", "PriceTooHigh", "MoreOfThis", "LessOfThis"];

        public static const CONFIRM:String="DeclineItemModal::declineConfirm";

        public static const ROWS:Number=2;

        public static const COLUMNS:Number=3;

        public var DeclineButtons_mc:flash.display.MovieClip;

        public var Header_mc:flash.display.MovieClip;

        public var Tooltip_mc:flash.display.MovieClip;

        public var ItemServerHandleId:Number=0;
    }
}
