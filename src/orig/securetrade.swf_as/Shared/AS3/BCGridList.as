package Shared.AS3 
{
    import Shared.*;
    import Shared.AS3.Events.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    
    public class BCGridList extends flash.display.MovieClip
    {
        public function BCGridList()
        {
            super();
            this.m_Entries = [];
            this.m_ClipVector = new Vector.<Shared.AS3.BSScrollingListEntry>();
            if (this.Body_mc == null) 
            {
                throw new Error("BCGridList : Required instance Body_mc null or invalid.");
            }
            this.EntryHolder_mc = new flash.display.MovieClip();
            this.EntryHolder_mc.name = "EntryHolder_mc";
            this.Body_mc.addChildAt(this.EntryHolder_mc, this.EntryHolder_mc.numChildren);
            if (this.ScrollUp_mc != null) 
            {
                this.ScrollUp_mc.visible = false;
            }
            if (this.ScrollDown_mc != null) 
            {
                this.ScrollDown_mc.visible = false;
            }
            if (this.ScrollLeft_mc != null) 
            {
                this.ScrollLeft_mc.visible = false;
            }
            if (this.ScrollRight_mc != null) 
            {
                this.ScrollRight_mc.visible = false;
            }
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            if (this.ScrollHoriz_mc != null) 
            {
                this.ScrollHoriz_mc.visible = false;
                this.ScrollHoriz_mc.handleSizeViaContents = true;
            }
            if (this.ScrollVert_mc != null) 
            {
                this.ScrollVert_mc.bVertical = true;
                this.ScrollVert_mc.visible = false;
                this.ScrollVert_mc.handleSizeViaContents = true;
            }
            return;
        }

        public function get entryCount():uint
        {
            return this.m_Entries.length;
        }

        public function get selectedIndex():int
        {
            return this.m_SelectedIndex;
        }

        public function set selectedIndex(arg1:int):*
        {
            var loc1:*=Shared.GlobalFunc.Clamp(arg1, -1, (this.m_Entries.length - 1));
            if (loc1 != this.m_SelectedIndex) 
            {
                this.m_SelectedIndex = loc1;
                dispatchEvent(new flash.events.Event(SELECTION_CHANGE, true, true));
                this.constrainScrollToSelection();
                this.m_NeedRedraw = true;
                this.setIsDirty();
            }
            return;
        }

        public function get selectedClip():Shared.AS3.BSScrollingListEntry
        {
            return this.m_SelectedClip;
        }

        public function set listItemClassName(arg1:String):void
        {
            this.m_ListItemClass = flash.utils.getDefinitionByName(arg1) as Class;
            this.m_ListItemClassName = arg1;
            this.m_NeedRedraw = true;
            return;
        }

        public function get entryData():Array
        {
            return this.m_Entries;
        }

        public function set entryData(arg1:Array):void
        {
            this.m_Entries = arg1;
            this.m_NeedRecalculateScrollMax = true;
            this.m_NeedRedraw = true;
            this.setIsDirty();
            return;
        }

        public function set needRedraw(arg1:*):void
        {
            this.m_NeedRedraw = arg1;
            return;
        }

        public function set wheelSelectionScroll(arg1:Boolean):void
        {
            this.m_WheelSelectionScroll = arg1;
            return;
        }

        public function get wheelSelectionScroll():Boolean
        {
            return this.m_WheelSelectionScroll;
        }

        public function set selectionScrollLockOffset(arg1:int):void
        {
            this.m_SelectionScrollLockOffset = arg1;
            return;
        }

        public function get selectionScrollLockOffset():int
        {
            return this.m_SelectionScrollLockOffset;
        }

        public function set disableInput(arg1:Boolean):void
        {
            this.m_DisableInput = arg1;
            return;
        }

        public function set selectionScrollLock(arg1:Boolean):void
        {
            this.m_SelectionScrollLock = arg1;
            return;
        }

        public function get selectionScrollLock():Boolean
        {
            return this.m_SelectionScrollLock;
        }

        public function get lastNavDirection():int
        {
            return this.m_LastNavDirection;
        }

        internal function getRowFromIndex(arg1:int):uint
        {
            if (arg1 > 0) 
            {
                return Math.floor(arg1 / (this.m_MaxCols + this.m_ColScrollPosMax));
            }
            return 0;
        }

        internal function getColFromIndex(arg1:int):uint
        {
            if (arg1 > 0) 
            {
                return arg1 % (this.m_MaxCols + this.m_ColScrollPosMax);
            }
            return 0;
        }

        public function setIsDirty():void
        {
            if (!this.m_IsDirty) 
            {
                addEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame);
                this.m_IsDirty = true;
            }
            return;
        }

        internal function onEnterFrame(arg1:flash.events.Event):void
        {
            this.selectedIndex = this.selectedIndex;
            removeEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame);
            this.m_IsDirty = false;
            if (this.m_NeedRecalculateScrollMax) 
            {
                this.calculateListScrollMax();
            }
            if (this.m_NeedRecreateClips) 
            {
                this.createEntryClips();
            }
            if (this.m_NeedRedraw || this.m_QueueSelectUnderMouse) 
            {
                this.m_ListStartIndex = this.m_ScrollVertical ? this.m_MaxCols * this.m_RowScrollPos : this.m_MaxRows * this.m_ColScrollPos;
            }
            if (this.m_QueueSelectUnderMouse) 
            {
                this.selectItemUnderMouse();
            }
            if (this.m_NeedRedraw) 
            {
                this.redrawList();
            }
            return;
        }

        public function getIndexFromGridPos(arg1:uint, arg2:uint):int
        {
            return arg1 * this.m_MaxCols + arg2;
        }

        internal function constrainScrollToSelection():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            if (this.m_NeedRecalculateScrollMax) 
            {
                this.calculateListScrollMax();
            }
            if (this.selectedIndex > 0) 
            {
                loc1 = this.selectedRow;
                loc2 = this.selectedCol;
                if (this.m_SelectionScrollLock) 
                {
                    if (this.m_ScrollVertical) 
                    {
                        this.rowScrollPos = loc1 + this.m_SelectionScrollLockOffset;
                    }
                    else 
                    {
                        this.colScrollPos = loc2 + this.m_SelectionScrollLockOffset;
                    }
                }
                else if (this.m_ScrollVertical) 
                {
                    loc3 = this.m_RowScrollPos;
                    loc4 = (this.m_RowScrollPos + this.m_MaxRows - 1);
                    if (loc1 < loc3) 
                    {
                        this.rowScrollPos = loc1;
                    }
                    else if (loc1 > loc4) 
                    {
                        this.rowScrollPos = loc1 - (this.m_MaxRows - 1);
                    }
                }
                else 
                {
                    loc5 = this.m_ColScrollPos;
                    loc6 = (this.m_ColScrollPos + this.m_MaxCols - 1);
                    if (loc2 < loc5) 
                    {
                        this.colScrollPos = loc2;
                    }
                    else if (loc2 > loc6) 
                    {
                        this.colScrollPos = loc2 - (this.m_MaxCols - 1);
                    }
                }
            }
            else 
            {
                this.rowScrollPos = 0;
                this.colScrollPos = 0;
            }
            return;
        }

        public function onKeyDown(arg1:flash.events.KeyboardEvent):*
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=false;
            if (!this.m_DisableInput) 
            {
                loc1 = this.selectedRow;
                loc2 = this.selectedCol;
                loc3 = false;
                var loc4:*=arg1.keyCode;
                switch (loc4) 
                {
                    case flash.ui.Keyboard.UP:
                    {
                        if (loc1 > 0) 
                        {
                            loc3 = true;
                            --loc1;
                        }
                        arg1.stopPropagation();
                        break;
                    }
                    case flash.ui.Keyboard.DOWN:
                    {
                        if (loc1 < this.getRowFromIndex((this.m_Entries.length - 1))) 
                        {
                            loc3 = true;
                            ++loc1;
                        }
                        arg1.stopPropagation();
                        break;
                    }
                    case flash.ui.Keyboard.LEFT:
                    {
                        if (loc2 > 0) 
                        {
                            loc3 = true;
                            --loc2;
                        }
                        arg1.stopPropagation();
                        break;
                    }
                    case flash.ui.Keyboard.RIGHT:
                    {
                        if (loc2 < (this.m_MaxCols - 1) + this.m_ColScrollPosMax && this.selectedIndex < (this.entryCount - 1)) 
                        {
                            loc3 = true;
                            ++loc2;
                        }
                        arg1.stopPropagation();
                        break;
                    }
                }
                this.m_LastNavDirection = arg1.keyCode;
                if (loc3) 
                {
                    this.selectedIndex = this.getIndexFromGridPos(loc1, loc2);
                }
                else 
                {
                    dispatchEvent(new flash.events.Event(SELECTION_EDGE_BOUNCE, true, true));
                }
            }
            return;
        }

        public function onKeyUp(arg1:flash.events.KeyboardEvent):*
        {
            if (!this.m_DisableInput && !this.m_DisableSelection && arg1.keyCode == flash.ui.Keyboard.ENTER) 
            {
                this.onItemPress(arg1);
                arg1.stopPropagation();
            }
            return;
        }

        internal function onItemClick(arg1:flash.events.Event):void
        {
            if (this.m_WheelSelectionScroll) 
            {
                if ((arg1.target as Shared.AS3.BSScrollingListEntry).itemIndex == this.m_SelectedIndex) 
                {
                    if (!this.m_DisableInput && !this.m_DisableSelection && !(this.m_SelectedIndex == -1)) 
                    {
                        dispatchEvent(new flash.events.Event(ITEM_CLICKED, true, true));
                    }
                    this.onItemPress(arg1);
                }
                else 
                {
                    this.selectedIndex = (arg1.target as Shared.AS3.BSScrollingListEntry).itemIndex;
                }
            }
            else 
            {
                if (!this.m_DisableInput && !this.m_DisableSelection && !(this.m_SelectedIndex == -1)) 
                {
                    dispatchEvent(new flash.events.Event(ITEM_CLICKED, true, true));
                }
                this.onItemPress(arg1);
            }
            return;
        }

        public function onItemPress(arg1:flash.events.Event):void
        {
            if (!this.m_DisableInput && !this.m_DisableSelection && !(this.m_SelectedIndex == -1)) 
            {
                dispatchEvent(new flash.events.Event(ITEM_PRESS, true, true));
            }
            else 
            {
                dispatchEvent(new flash.events.Event(LIST_PRESS, true, true));
            }
            return;
        }

        internal function onItemMouseOver(arg1:flash.events.MouseEvent):void
        {
            if (!this.m_DisableInput && !this.m_DisableSelection && !this.m_WheelSelectionScroll) 
            {
                this.selectedIndex = (arg1.currentTarget as Shared.AS3.BSScrollingListEntry).itemIndex;
                dispatchEvent(new flash.events.Event(MOUSE_OVER_ITEM, true, true));
            }
            return;
        }

        internal function onMouseWheel(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=false;
            if (!this.m_DisableInput) 
            {
                loc1 = arg1.delta < 0;
                if (this.m_WheelSelectionScroll) 
                {
                    if (loc1) 
                    {
                        var loc2:*;
                        var loc3:*=((loc2 = this).selectedIndex + 1);
                        loc2.selectedIndex = loc3;
                    }
                    else if (this.selectedIndex > 0) 
                    {
                        loc3 = ((loc2 = this).selectedIndex - 1);
                        loc2.selectedIndex = loc3;
                    }
                }
                else 
                {
                    this.m_QueueSelectUnderMouse = true;
                    if (this.m_ScrollVertical) 
                    {
                        this.scrollRow(loc1);
                    }
                    else 
                    {
                        this.scrollCol(loc1);
                    }
                }
                arg1.stopPropagation();
            }
            return;
        }

        public function scrollRow(arg1:Boolean, arg2:*=false):void
        {
            var loc1:*=arg1 ? this.m_RowScrollPos + 1 : (this.m_RowScrollPos - 1);
            if (arg2) 
            {
                if (loc1 < 0) 
                {
                    loc1 = (this.m_RowScrollPosMax - 1);
                }
                else if (loc1 >= this.m_RowScrollPosMax) 
                {
                    loc1 = 0;
                }
            }
            else 
            {
                loc1 = Math.max(0, loc1);
            }
            this.rowScrollPos = loc1;
            return;
        }

        public function scrollCol(arg1:Boolean, arg2:*=false):void
        {
            var loc1:*=arg1 ? this.m_ColScrollPos + 1 : (this.m_ColScrollPos - 1);
            if (arg2) 
            {
                if (loc1 < 0) 
                {
                    loc1 = (this.m_ColScrollPosMax - 1);
                }
                else if (loc1 >= this.m_ColScrollPosMax) 
                {
                    loc1 = 0;
                }
            }
            else 
            {
                loc1 = Math.max(0, loc1);
            }
            this.colScrollPos = loc1;
            return;
        }

        internal function onSliderValueChange(arg1:Shared.AS3.Events.CustomEvent):void
        {
            if (this.m_ScrollVertical && !(this.ScrollVert_mc == null) && arg1.target == this.ScrollVert_mc) 
            {
                this.rowScrollPos = arg1.params as uint;
            }
            if (!this.m_ScrollVertical && !(this.ScrollHoriz_mc == null) && arg1.target == this.ScrollHoriz_mc) 
            {
                this.colScrollPos = arg1.params as uint;
            }
            return;
        }

        internal function onAddedToStage(arg1:flash.events.Event):void
        {
            var e:flash.events.Event;

            var loc1:*;
            e = arg1;
            if (this.ScrollUp_mc != null) 
            {
                this.ScrollUp_mc.addEventListener(flash.events.MouseEvent.CLICK, function (arg1:flash.events.MouseEvent):*
                {
                    scrollRow(false);
                    return;
                })
            }
            if (this.ScrollDown_mc != null) 
            {
                this.ScrollDown_mc.addEventListener(flash.events.MouseEvent.CLICK, function (arg1:flash.events.MouseEvent):*
                {
                    scrollRow(true);
                    return;
                })
            }
            if (this.ScrollLeft_mc != null) 
            {
                this.ScrollLeft_mc.addEventListener(flash.events.MouseEvent.CLICK, function (arg1:flash.events.MouseEvent):*
                {
                    scrollCol(false);
                    return;
                })
            }
            if (this.ScrollRight_mc != null) 
            {
                this.ScrollRight_mc.addEventListener(flash.events.MouseEvent.CLICK, function (arg1:flash.events.MouseEvent):*
                {
                    scrollCol(true);
                    return;
                })
            }
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp);
            addEventListener(Shared.AS3.BSSlider.VALUE_CHANGED, this.onSliderValueChange);
            stage.focus = this;
            return;
        }

        protected function populateEntryClip(arg1:Shared.AS3.BSScrollingListEntry, arg2:Object):*
        {
            var aEntryClip:Shared.AS3.BSScrollingListEntry;
            var aEntryData:Object;

            var loc1:*;
            aEntryClip = arg1;
            aEntryData = arg2;
            if (aEntryClip != null) 
            {
                aEntryClip.selected = aEntryData == this.selectedEntry && this.m_ShowSelectedItem;
                if (aEntryClip.selected) 
                {
                    this.m_SelectedClip = aEntryClip;
                }
                try 
                {
                    aEntryClip.SetEntryText(aEntryData, this.m_TextBehavior);
                }
                catch (e:Error)
                {
                    trace("BCGridList::populateEntryClip -- SetEntryText error: " + e.getStackTrace());
                }
            }
            return;
        }

        internal function calculateListScrollMax():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this.m_ScrollVertical) 
            {
                this.m_ColScrollPosMax = 0;
                loc1 = Math.ceil(this.m_Entries.length / this.m_MaxCols);
                this.m_RowScrollPosMax = loc1 - this.m_MaxRows;
                if (this.ScrollVert_mc != null) 
                {
                    this.ScrollVert_mc.dispatchOnValueChange = false;
                    this.ScrollVert_mc.minValue = 0;
                    this.ScrollVert_mc.maxValue = this.m_RowScrollPosMax;
                    this.ScrollVert_mc.dispatchOnValueChange = true;
                }
            }
            else 
            {
                this.m_RowScrollPosMax = 0;
                loc2 = Math.ceil(this.m_Entries.length / this.m_MaxRows);
                this.m_ColScrollPosMax = loc2 - this.m_MaxCols;
                if (this.ScrollHoriz_mc != null) 
                {
                    this.ScrollHoriz_mc.dispatchOnValueChange = false;
                    this.ScrollHoriz_mc.minValue = 0;
                    this.ScrollHoriz_mc.maxValue = this.m_ColScrollPosMax;
                    this.ScrollHoriz_mc.dispatchOnValueChange = true;
                }
            }
            this.m_NeedRecalculateScrollMax = false;
            this.m_NeedRedraw = true;
            return;
        }

        public function clearList():void
        {
            this.m_Entries.splice(0, this.m_Entries.length);
            return;
        }

        internal function getNewEntryClip():Shared.AS3.BSScrollingListEntry
        {
            return new this.m_ListItemClass() as Shared.AS3.BSScrollingListEntry;
        }

        internal function createEntryClip(arg1:uint, arg2:uint, arg3:uint):Boolean
        {
            var loc1:*;
            if ((loc1 = this.getNewEntryClip()) != null) 
            {
                loc1.parentClip = this.parent as flash.display.MovieClip;
                loc1.clipIndex = arg1;
                loc1.clipRow = arg2;
                loc1.clipCol = arg3;
                loc1.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onItemMouseOver);
                loc1.addEventListener(flash.events.MouseEvent.CLICK, this.onItemClick);
                this.EntryHolder_mc.addChild(loc1);
                this.m_ClipVector.push(loc1);
                return true;
            }
            trace("BCGridList::createEntryClip -- m_ListItemClass is invalid or does not derive from BSScrollingListEntry.");
            return false;
        }

        internal function createEntryClips():void
        {
            var loc4:*=null;
            while (this.EntryHolder_mc.numChildren > 0) 
            {
                (loc4 = this.getClipByIndex(0)).Dtor();
                this.EntryHolder_mc.removeChildAt(0);
            }
            this.m_ClipVector = new Vector.<Shared.AS3.BSScrollingListEntry>();
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            if (this.m_ScrollVertical) 
            {
                loc2 = 0;
                while (loc2 < this.m_MaxRows) 
                {
                    loc3 = 0;
                    while (loc3 < this.m_MaxCols) 
                    {
                        if (this.createEntryClip(loc1, loc2, loc3)) 
                        {
                            ++loc1;
                        }
                        ++loc3;
                    }
                    ++loc2;
                }
            }
            else 
            {
                loc3 = 0;
                while (loc3 < this.m_MaxCols) 
                {
                    loc2 = 0;
                    while (loc2 < this.m_MaxRows) 
                    {
                        if (this.createEntryClip(loc1, loc2, loc3)) 
                        {
                            ++loc1;
                        }
                        ++loc2;
                    }
                    ++loc3;
                }
            }
            this.m_MaxDisplayedItems = loc1;
            this.m_NeedRecreateClips = false;
            return;
        }

        internal function updateScrollIndicators():void
        {
            if (this.ScrollUp_mc != null) 
            {
                this.ScrollUp_mc.visible = this.m_ScrollVertical && this.m_RowScrollPos > 0;
            }
            if (this.ScrollDown_mc != null) 
            {
                this.ScrollDown_mc.visible = this.m_ScrollVertical && this.m_RowScrollPos < this.m_RowScrollPosMax;
            }
            if (this.ScrollLeft_mc != null) 
            {
                this.ScrollLeft_mc.visible = !this.m_ScrollVertical && this.m_ColScrollPos > 0;
            }
            if (this.ScrollRight_mc != null) 
            {
                this.ScrollRight_mc.visible = !this.m_ScrollVertical && this.m_ColScrollPos < this.m_ColScrollPosMax;
            }
            if (this.ScrollVert_mc != null) 
            {
                if (this.m_ScrollVertical && this.m_RowScrollPosMax > 0) 
                {
                    if (this.m_NeedSliderUpdate) 
                    {
                        this.ScrollVert_mc.doSetValue(this.m_RowScrollPos, false);
                    }
                    this.ScrollVert_mc.visible = true;
                }
                else 
                {
                    this.ScrollVert_mc.visible = false;
                }
            }
            if (this.ScrollHoriz_mc != null) 
            {
                if (!this.m_ScrollVertical && this.m_ColScrollPosMax > 0) 
                {
                    if (this.m_NeedSliderUpdate) 
                    {
                        this.ScrollHoriz_mc.doSetValue(this.m_ColScrollPos, false);
                    }
                    this.ScrollHoriz_mc.visible = true;
                }
                else 
                {
                    this.ScrollHoriz_mc.visible = false;
                }
            }
            this.m_NeedSliderUpdate = false;
            return;
        }

        internal function selectItemUnderMouse():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (!this.m_DisableSelection && !this.m_DisableInput) 
            {
                this.m_QueueSelectUnderMouse = false;
                loc1 = 0;
                while (loc1 < this.m_MaxDisplayedItems) 
                {
                    loc2 = this.m_ClipVector[loc1];
                    loc3 = loc2 as flash.display.MovieClip;
                    if (loc2.Sizer_mc != null) 
                    {
                        loc3 = loc2.Sizer_mc;
                    }
                    loc4 = localToGlobal(new flash.geom.Point(mouseX, mouseY));
                    if (loc3.hitTestPoint(loc4.x, loc4.y, false)) 
                    {
                        this.selectedIndex = this.m_ListStartIndex + loc1;
                    }
                    ++loc1;
                }
            }
            return;
        }

        protected function redrawList():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=0;
            var loc11:*=null;
            this.m_DisplayWidth = 0;
            this.m_DisplayHeight = 0;
            this.m_DisplayedItemCount = 0;
            this.m_SelectedClip = null;
            if (this.m_MaxDisplayedItems > 0) 
            {
                loc1 = this.m_ListStartIndex;
                loc2 = this.m_Entries.length;
                loc3 = 0;
                loc6 = 0;
                loc7 = 0;
                loc8 = 0;
                loc9 = 0;
                loc10 = 0;
                while (loc10 < this.m_MaxDisplayedItems) 
                {
                    if ((loc11 = this.m_ClipVector[loc10]) != null) 
                    {
                        if (loc10 + loc1 < loc2) 
                        {
                            loc11.itemIndex = loc10 + loc1;
                            this.populateEntryClip(loc11, this.m_Entries[loc10 + loc1]);
                            var loc12:*;
                            var loc13:*=((loc12 = this).m_DisplayedItemCount + 1);
                            loc12.m_DisplayedItemCount = loc13;
                            if (loc11.Sizer_mc == null) 
                            {
                                loc4 = loc11.width;
                                loc5 = loc11.height;
                            }
                            else 
                            {
                                loc4 = loc11.Sizer_mc.width;
                                loc5 = loc11.Sizer_mc.height;
                            }
                            loc11.visible = true;
                            loc11.x = loc4 * loc11.clipCol;
                            loc11.y = loc5 * loc11.clipRow;
                            loc8 = Math.max(loc8, loc11.x + loc4);
                            loc9 = Math.max(loc9, loc11.y + loc5);
                        }
                        else 
                        {
                            loc11.visible = false;
                            loc11.itemIndex = int.MAX_VALUE;
                        }
                    }
                    ++loc10;
                }
                this.m_DisplayWidth = loc8;
                this.m_DisplayHeight = loc9;
                this.updateScrollIndicators();
            }
            else 
            {
                trace("BCGridList::redrawList -- List configuration resulted in m_MaxDisplayedItems < 1 (unable to display any items) - " + this.name);
            }
            dispatchEvent(new flash.events.Event(LIST_UPDATED, true, true));
            this.m_NeedRedraw = false;
            return;
        }

        public function set showSelectedItem(arg1:Boolean):void
        {
            this.m_ShowSelectedItem = arg1;
            this.m_NeedRedraw = true;
            this.setIsDirty();
            return;
        }

        public function get showSelectedItem():Boolean
        {
            return this.m_ShowSelectedItem;
        }

        public function set maxRows(arg1:uint):void
        {
            this.m_MaxRows = arg1;
            this.m_NeedRecreateClips = true;
            return;
        }

        public function set maxCols(arg1:uint):void
        {
            this.m_MaxCols = arg1;
            this.m_NeedRecreateClips = true;
            return;
        }

        public function set scrollVertical(arg1:Boolean):void
        {
            this.m_ScrollVertical = arg1;
            this.m_NeedRecalculateScrollMax = true;
            this.m_NeedRedraw = true;
            this.setIsDirty();
            return;
        }

        public function get scrollVertical():Boolean
        {
            return this.m_ScrollVertical;
        }

        public function get selectedEntry():Object
        {
            return this.m_Entries[this.m_SelectedIndex];
        }

        public function get rowScrollPos():int
        {
            return this.m_RowScrollPos;
        }

        public function get colScrollPos():int
        {
            return this.m_ColScrollPos;
        }

        public function get displayWidth():Number
        {
            return this.m_DisplayWidth;
        }

        public function get displayHeight():Number
        {
            return this.m_DisplayHeight;
        }

        public function set rowScrollPos(arg1:int):void
        {
            arg1 = Shared.GlobalFunc.Clamp(arg1, 0, this.m_RowScrollPosMax);
            if (arg1 != this.m_RowScrollPos) 
            {
                this.m_RowScrollPos = arg1;
                this.m_NeedRedraw = true;
                this.m_NeedSliderUpdate = true;
                this.setIsDirty();
            }
            return;
        }

        public function set colScrollPos(arg1:int):void
        {
            arg1 = Shared.GlobalFunc.Clamp(arg1, 0, this.m_ColScrollPosMax);
            if (arg1 != this.m_ColScrollPos) 
            {
                this.m_ColScrollPos = arg1;
                this.m_NeedRedraw = true;
                this.m_NeedSliderUpdate = true;
                this.setIsDirty();
            }
            return;
        }

        public function getClipByIndex(arg1:uint):Shared.AS3.BSScrollingListEntry
        {
            return arg1 < this.EntryHolder_mc.numChildren ? this.m_ClipVector[arg1] as Shared.AS3.BSScrollingListEntry : null;
        }

        public function get selectedCol():uint
        {
            return this.getColFromIndex(this.m_SelectedIndex);
        }

        public function get selectedRow():uint
        {
            return this.getRowFromIndex(this.m_SelectedIndex);
        }

        public function get displayedItemCount():uint
        {
            return this.m_DisplayedItemCount;
        }

        public function get maxDisplayedItems():uint
        {
            return this.m_MaxDisplayedItems;
        }

        public static const ITEM_CLICKED:String="BCGridList::itemClicked";

        public static const SELECTION_CHANGE:String="BCGridList::selectionChange";

        public static const TEXT_OPTION_NONE:String="None";

        public static const TEXT_OPTION_SHRINK_TO_FIT:String="Shrink To Fit";

        public static const TEXT_OPTION_MULTILINE:String="Multi-Line";

        public static const ITEM_PRESS:String="BCGridList::itemPress";

        public static const LIST_PRESS:String="BCGridList::listPress";

        public static const MOUSE_OVER_ITEM:String="BCGridList::mouseOverItem";

        public static const LIST_UPDATED:String="BCGridList::listUpdated";

        public static const SELECTION_EDGE_BOUNCE:String="BCGridList::selectionEdgeBounce";

        internal var m_MaxRows:uint=7;

        internal var m_MaxCols:uint=1;

        internal var m_ScrollVertical:Boolean=true;

        internal var m_DisableSelection:Boolean=false;

        internal var m_DisableInput:Boolean=false;

        internal var m_WheelSelectionScroll:Boolean=false;

        internal var m_SelectionScrollLock:Boolean=false;

        internal var m_SelectionScrollLockOffset:int=0;

        internal var m_SelectedIndex:int=-1;

        internal var m_SelectedClip:Shared.AS3.BSScrollingListEntry;

        internal var m_SelectedDisplayIndex:int=-1;

        protected var m_DisplayedItemCount:uint=0;

        internal var m_MaxDisplayedItems:uint=0;

        protected var m_ListStartIndex:uint=0;

        internal var m_ShowSelectedItem:Boolean=true;

        public var ScrollHoriz_mc:Shared.AS3.BSSlider;

        internal var m_NeedRecalculateScrollMax:Boolean=true;

        internal var m_NeedRecreateClips:Boolean=false;

        protected var m_NeedRedraw:Boolean=true;

        internal var m_NeedSliderUpdate:Boolean=true;

        internal var m_QueueSelectUnderMouse:Boolean=false;

        internal var m_RowScrollPos:uint=0;

        internal var m_RowScrollPosMax:int=0;

        internal var m_ColScrollPos:uint=0;

        internal var m_ColScrollPosMax:int=0;

        internal var m_DisplayWidth:Number=0;

        internal var m_DisplayHeight:Number=0;

        internal var m_LastNavDirection:int=-1;

        public var Body_mc:flash.display.MovieClip;

        protected var m_ClipVector:__AS3__.vec.Vector.<Shared.AS3.BSScrollingListEntry>;

        internal var m_TextBehavior:String;

        public var ScrollUp_mc:flash.display.MovieClip;

        public var ScrollDown_mc:flash.display.MovieClip;

        public var ScrollLeft_mc:flash.display.MovieClip;

        internal var m_IsDirty:Boolean=false;

        public var ScrollRight_mc:flash.display.MovieClip;

        public var ScrollVert_mc:Shared.AS3.BSSlider;

        internal var EntryHolder_mc:flash.display.MovieClip;

        internal var m_ListItemClassName:String="BSScrollingListEntry";

        internal var m_ListItemClass:Class;

        protected var m_Entries:Array;
    }
}
