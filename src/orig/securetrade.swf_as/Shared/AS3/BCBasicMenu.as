package Shared.AS3 
{
    import Shared.AS3.Events.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    
    public class BCBasicMenu extends Shared.AS3.MenuComponent
    {
        public function BCBasicMenu()
        {
            this.m_AcceptButton = new Shared.AS3.BSButtonHintData("$ACCEPT", "Enter", "PSN_A", "Xenon_A", 1, this.onItemPress);
            this.m_CancelButton = new Shared.AS3.BSButtonHintData("$CANCEL", "Esc", "PSN_B", "Xenon_B", 1, this.onMenuCancel);
            super();
            addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp);
            addEventListener(flash.events.FocusEvent.FOCUS_IN, this.onFocusIn);
            this.m_Entries = new Vector.<Shared.AS3.BCBasicMenuItem>();
            return;
        }

        protected function onItemPress():*
        {
            return;
        }

        internal function setFocusUnderMouse():void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < this.m_Entries.length) 
            {
                loc2 = localToGlobal(new flash.geom.Point(mouseX, mouseY));
                if (this.m_Entries[loc1].hitTestPoint(loc2.x, loc2.y, false)) 
                {
                    this.selectedIndex = loc1;
                }
                ++loc1;
            }
            return;
        }

        public function onMouseWheel(arg1:flash.events.MouseEvent):*
        {
            if (arg1.delta < 0) 
            {
                this.selectIncrease();
            }
            else if (arg1.delta > 0) 
            {
                this.selectDecrease();
            }
            this.setFocusUnderMouse();
            arg1.stopPropagation();
            return;
        }

        public function onFocusIn(arg1:flash.events.FocusEvent):void
        {
            return;
        }

        internal function onMenuCancel(arg1:flash.events.Event=null):*
        {
            if (this.m_CancelButton.ButtonVisible && this.m_CancelButton.ButtonEnabled) 
            {
                dispatchEvent(new Shared.AS3.Events.MenuActionEvent(Shared.AS3.Events.MenuActionEvent.MENU_CANCEL, null, null));
            }
            return;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            this.focusRect = false;
            buttonData.push(this.m_AcceptButton);
            buttonData.push(this.m_CancelButton);
            connectButtonBar();
            return;
        }

        public function collapse():void
        {
            return;
        }

        public function expand():void
        {
            return;
        }

        protected function setActive(arg1:Boolean):void
        {
            if (arg1 != _active) 
            {
                if (arg1) 
                {
                    if (this.m_SaveSelection) 
                    {
                        this.selectedIndex = this.m_StoredSelectedIndex;
                    }
                    else 
                    {
                        this.selectedIndex = 0;
                    }
                }
                else 
                {
                    this.m_StoredSelectedIndex = this.m_SelectedIndex;
                    this.selectedIndex = -1;
                }
            }
            return;
        }

        public override function set Active(arg1:*):void
        {
            this.setActive(arg1);
            connectButtonBar();
            _active = arg1;
            return;
        }

        public function get selectedIndex():int
        {
            if (_active) 
            {
                return this.m_SelectedIndex;
            }
            return this.m_StoredSelectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            if (this.m_SelectedIndex != arg1) 
            {
                this.m_SelectedIndex = arg1;
                this.updateSelection();
            }
            return;
        }

        internal function clampIndex(arg1:*):int
        {
            return Math.max(0, Math.min(arg1, (this.m_Entries.length - 1)));
        }

        public function selectIncrease():*
        {
            this.selectedIndex = this.clampIndex(this.selectedIndex + 1);
            return;
        }

        public function selectDecrease():*
        {
            this.selectedIndex = this.clampIndex((this.selectedIndex - 1));
            return;
        }

        public function onKeyDown(arg1:flash.events.KeyboardEvent):*
        {
            var loc1:*=0;
            var loc2:*=0;
            if (!this.m_DisableInput) 
            {
                loc1 = flash.ui.Keyboard.UP;
                loc2 = flash.ui.Keyboard.DOWN;
                if (this.m_Horizontal) 
                {
                    loc1 = flash.ui.Keyboard.LEFT;
                    loc2 = flash.ui.Keyboard.RIGHT;
                }
                if (arg1.keyCode != loc1) 
                {
                    if (arg1.keyCode == loc2) 
                    {
                        this.selectIncrease();
                        arg1.stopPropagation();
                    }
                }
                else 
                {
                    this.selectDecrease();
                    arg1.stopPropagation();
                }
            }
            return;
        }

        public function onKeyUp(arg1:flash.events.KeyboardEvent):*
        {
            if (!this.m_DisableInput && !this.m_DisableSelection && arg1.keyCode == flash.ui.Keyboard.ENTER) 
            {
                this.onItemPress();
                arg1.stopPropagation();
            }
            return;
        }

        internal function updateSelection():void
        {
            var loc1:*=0;
            while (loc1 < this.m_Entries.length) 
            {
                this.m_Entries[loc1].selected = this.m_SelectedIndex == loc1;
                ++loc1;
            }
            return;
        }

        public function onEntryRollover(arg1:flash.events.Event):*
        {
            var loc1:*=undefined;
            if (!this.m_DisableInput && !this.m_DisableSelection) 
            {
                loc1 = this.m_SelectedIndex;
                this.selectedIndex = (arg1.currentTarget as Shared.AS3.BCBasicMenuItem).index;
                if (loc1 != this.m_SelectedIndex) 
                {
                    dispatchEvent(new flash.events.Event(PLAY_FOCUS_SOUND, true, true));
                }
            }
            return;
        }

        public function onEntryPress(arg1:flash.events.MouseEvent):*
        {
            arg1.stopPropagation();
            this.onItemPress();
            return;
        }

        public function addItem(arg1:Shared.AS3.BCBasicMenuItem):void
        {
            arg1.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onEntryRollover);
            arg1.addEventListener(flash.events.MouseEvent.CLICK, this.onEntryPress);
            arg1.index = this.m_Entries.length;
            this.m_Entries.push(arg1);
            return;
        }

        public function set buttonPressAction(arg1:Function):*
        {
            this.m_ButtonPressAction = arg1;
            return;
        }

        public static const SELECTION_CHANGE:String="BSScrollingList::selectionChange";

        public static const ITEM_PRESS:String="BSScrollingList::itemPress";

        public static const LIST_PRESS:String="BSScrollingList::listPress";

        public static const LIST_ITEMS_CREATED:String="BSScrollingList::listItemsCreated";

        public static const PLAY_FOCUS_SOUND:String="BSScrollingList::playFocusSound";

        public var Backer_mc:flash.display.MovieClip;

        protected var m_Entries:__AS3__.vec.Vector.<Shared.AS3.BCBasicMenuItem>;

        internal var m_DisableInput:Boolean=false;

        internal var m_DisableSelection:Boolean=false;

        internal var m_SelectedIndex:int=-1;

        internal var m_StoredSelectedIndex:int=0;

        protected var m_Horizontal:Boolean=false;

        protected var m_SaveSelection:Boolean=false;

        internal var m_ButtonPressAction:Function;

        internal var m_AcceptButton:Shared.AS3.BSButtonHintData;

        internal var m_CancelButton:Shared.AS3.BSButtonHintData;
    }
}
