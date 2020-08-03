package Shared.AS3 
{
    import Mobile.ScrollList.*;
    import Shared.*;
    import Shared.AS3.COMPANIONAPP.*;
    import Shared.AS3.Events.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    
    public class BSScrollingList extends flash.display.MovieClip
    {
        public function BSScrollingList()
        {
            super();
            this.EntriesA = new Array();
            this._filterer = new Shared.AS3.ListFilterer();
            addEventListener(Shared.AS3.ListFilterer.FILTER_CHANGE, this.onFilterChange, false, 0, true);
            this.strTextOption = TEXT_OPTION_NONE;
            this.fVerticalSpacing = 0;
            this.uiNumListItems = 0;
            this.bRestoreListIndex = true;
            this.bDisableSelection = false;
            this.bAllowSelectionDisabledListNav = false;
            this.bDisableInput = false;
            this.bMouseDrivenNav = false;
            this.bReverseList = false;
            this.bUpdated = false;
            this.bInitialized = false;
            if (loaderInfo != null) 
            {
                loaderInfo.addEventListener(flash.events.Event.INIT, this.onComponentInit, false, 0, true);
            }
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onStageInit);
            addEventListener(flash.events.Event.RENDER, this.onRender);
            addEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.onStageDestruct, false, 0, true);
            addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 0, true);
            addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp, false, 0, true);
            if (!this.needMobileScrollList) 
            {
                addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel, false, 0, true);
            }
            if (this.border == null) 
            {
                throw new Error("No \'border\' clip found.  BSScrollingList requires a border rect to define its extents.");
            }
            this.fBorderHeight = this.border.height;
            this.EntryHolder_mc = new flash.display.MovieClip();
            this.EntryHolder_mc.name = "EntryHolder_mc";
            this.addChildAt(this.EntryHolder_mc, this.getChildIndex(this.border) + 1);
            this.iSelectedIndex = -1;
            this.iScrollPosition = 0;
            this.iMaxScrollPosition = 0;
            this.iListItemsShown = 0;
            this.fListHeight = 0;
            this.uiPlatform = 1;
            if (this.ScrollUp != null) 
            {
                this.ScrollUp.visible = false;
            }
            if (this.ScrollDown != null) 
            {
                this.ScrollDown.visible = false;
            }
            return;
        }

        public function get numListItems_Inspectable():uint
        {
            return this.uiNumListItems;
        }

        public function set numListItems_Inspectable(arg1:uint):*
        {
            this.uiNumListItems = arg1;
            return;
        }

        protected function get needMobileScrollList():Boolean
        {
            return Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn;
        }

        public function get listEntryClass_Inspectable():String
        {
            return this._itemRendererClassName;
        }

        public function set listEntryClass_Inspectable(arg1:String):*
        {
            this.ListEntryClass = flash.utils.getDefinitionByName(arg1) as Class;
            this._itemRendererClassName = arg1;
            return;
        }

        public function get restoreListIndex_Inspectable():Boolean
        {
            return this.bRestoreListIndex;
        }

        public function set restoreListIndex_Inspectable(arg1:Boolean):*
        {
            this.bRestoreListIndex = arg1;
            return;
        }

        public function get disableSelection_Inspectable():Boolean
        {
            return this.bDisableSelection;
        }

        public function set disableSelection_Inspectable(arg1:Boolean):*
        {
            this.bDisableSelection = arg1;
            return;
        }

        public function set allowWheelScrollNoSelectionChange(arg1:Boolean):*
        {
            this.bAllowSelectionDisabledListNav = arg1;
            return;
        }

        public function get reverseOrder():Boolean
        {
            return this.bReverseOrder;
        }

        public function set reverseOrder(arg1:Boolean):*
        {
            this.bReverseOrder = arg1;
            return;
        }

        public function SetNumListItems(arg1:uint):*
        {
            var loc1:*=0;
            var loc2:*=null;
            if (arg1 != this._DisplayNumListItems) 
            {
                this._DisplayNumListItems = arg1;
                if (!(this.ListEntryClass == null) && arg1 > 0) 
                {
                    while (this.EntryHolder_mc.numChildren > 0) 
                    {
                        this.EntryHolder_mc.removeChildAt(0);
                    }
                    loc1 = 0;
                    while (loc1 < arg1) 
                    {
                        loc2 = this.GetNewListEntry(loc1);
                        if (loc2 == null) 
                        {
                            trace("BSScrollingList::SetNumListItems -- List Entry Class " + this._itemRendererClassName + " is invalid or does not derive from BSScrollingListEntry.");
                        }
                        else 
                        {
                            loc2.clipIndex = loc1;
                            loc2.name = this._itemRendererClassName + loc1.toString();
                            loc2.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onEntryRollover);
                            loc2.addEventListener(flash.events.MouseEvent.CLICK, this.onEntryPress);
                            this.EntryHolder_mc.addChild(loc2);
                        }
                        ++loc1;
                    }
                    this.bInitialized = true;
                    dispatchEvent(new flash.events.Event(LIST_ITEMS_CREATED, true, true));
                }
            }
            return;
        }

        protected function doSetSelectedIndex(arg1:int):*
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc1:*=null;
            if (!this.bDisableSelection && !(arg1 == this.iSelectedIndex)) 
            {
                loc2 = this.iSelectedIndex;
                this.iSelectedIndex = arg1;
                if (this.EntriesA.length == 0) 
                {
                    this.iSelectedIndex = -1;
                }
                if (!(loc2 == -1) && loc2 < this.EntriesA.length) 
                {
                    if ((loc3 = this.FindClipForEntry(loc2)) != null) 
                    {
                        this.SetEntry(loc3, this.EntriesA[loc2]);
                    }
                }
                if (this.iSelectedIndex != -1) 
                {
                    this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
                    if (this.iSelectedIndex == int.MAX_VALUE) 
                    {
                        this.iSelectedIndex = -1;
                    }
                }
                if (this.iSelectedIndex != -1) 
                {
                    loc1 = this.FindClipForEntry(this.iSelectedIndex);
                    if (loc1 == null) 
                    {
                        this.InvalidateData();
                        loc1 = this.FindClipForEntry(this.iSelectedIndex);
                    }
                    if (!(this.iSelectedIndex == -1) && !(loc2 == this.iSelectedIndex)) 
                    {
                        if (loc1 == null) 
                        {
                            if (this.iListItemsShown > 0) 
                            {
                                loc4 = this.GetEntryFromClipIndex(0);
                                loc5 = this.GetEntryFromClipIndex((this.iListItemsShown - 1));
                                loc7 = 0;
                                if (this.iSelectedIndex < loc4) 
                                {
                                    loc6 = loc4;
                                    do 
                                    {
                                        loc6 = this._filterer.GetPrevFilterMatch(loc6);
                                        --loc7;
                                    }
                                    while (!(loc6 == this.iSelectedIndex) && !(loc6 == -1) && !(loc6 == int.MAX_VALUE));
                                }
                                else if (this.iSelectedIndex > loc5) 
                                {
                                    loc6 = loc5;
                                    do 
                                    {
                                        loc6 = this._filterer.GetNextFilterMatch(loc6);
                                        ++loc7;
                                    }
                                    while (!(loc6 == this.iSelectedIndex) && !(loc6 == -1) && !(loc6 == int.MAX_VALUE));
                                }
                                this.scrollPosition = this.scrollPosition + loc7;
                            }
                        }
                        else 
                        {
                            this.SetEntry(loc1, this.EntriesA[this.iSelectedIndex]);
                        }
                        if (this.textOption_Inspectable == TEXT_OPTION_MULTILINE) 
                        {
                            loc8 = 0;
                            loc1 = this.FindClipForEntry(this.iSelectedIndex);
                            while (loc8 < this.uiNumListItems && !(loc1 == null) && loc1.y + loc1.height > this.fListHeight) 
                            {
                                this.scrollPosition = this.scrollPosition + 1;
                                loc1 = this.FindClipForEntry(this.iSelectedIndex);
                                ++loc8;
                            }
                            if (loc8 == this.uiNumListItems) 
                            {
                                throw new Error("Force-exited list selection loop before the selected entry could be fully scrolled on-screen.  Shouldn\'t be possible!");
                            }
                        }
                    }
                }
                if (loc2 != this.iSelectedIndex) 
                {
                    dispatchEvent(new flash.events.Event(SELECTION_CHANGE, true, true));
                }
                if (this.needMobileScrollList) 
                {
                    if (this.scrollList != null) 
                    {
                        if (this.iSelectedIndex == -1) 
                        {
                            this.scrollList.selectedIndex = -1;
                        }
                        else 
                        {
                            loc9 = this.selectedClipIndex;
                            loc10 = 0;
                            while (loc10 < this.scrollList.data.length) 
                            {
                                if (this.EntriesA[this.iSelectedIndex] == this.scrollList.data[loc10]) 
                                {
                                    loc9 = loc10;
                                    break;
                                }
                                ++loc10;
                            }
                            this.scrollList.selectedIndex = loc9;
                        }
                    }
                }
            }
            return;
        }

        protected function GetNewListEntry(arg1:uint):Shared.AS3.BSScrollingListEntry
        {
            return new this.ListEntryClass() as Shared.AS3.BSScrollingListEntry;
        }

        public function UpdateList():*
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=0;
            var loc2:*=this._filterer.FindArrayIndexOfFilteredPosition(this.iScrollPosition);
            var loc3:*=loc2;
            var loc4:*=0;
            while (loc4 < this.uiNumListItems) 
            {
                if (loc6 == this.GetClipByIndex(loc4)) 
                {
                    loc6.visible = false;
                    loc6.itemIndex = int.MAX_VALUE;
                }
                ++loc4;
            }
            var loc5:*=new Vector.<Object>();
            this.iListItemsShown = 0;
            if (this.needMobileScrollList) 
            {
                while (!(loc3 == int.MAX_VALUE) && !(loc3 == -1) && loc3 < this.EntriesA.length && loc1 <= this.fListHeight) 
                {
                    loc5.push(this.EntriesA[loc3]);
                    loc3 = this._filterer.GetNextFilterMatch(loc3);
                }
            }
            while (!(loc2 == int.MAX_VALUE) && !(loc2 == -1) && loc2 < this.EntriesA.length && this.iListItemsShown < this.uiNumListItems && loc1 <= this.fListHeight) 
            {
                if (loc7 == this.GetClipByIndex(this.iListItemsShown)) 
                {
                    this.SetEntry(loc7, this.EntriesA[loc2]);
                    loc7.itemIndex = loc2;
                    loc7.visible = !this.needMobileScrollList;
                    if (loc7.Sizer_mc) 
                    {
                        loc1 = loc1 + loc7.Sizer_mc.height;
                    }
                    else 
                    {
                        loc1 = loc1 + loc7.height;
                    }
                    if (loc1 <= this.fListHeight && this.iListItemsShown < this.uiNumListItems) 
                    {
                        loc1 = loc1 + this.fVerticalSpacing;
                        var loc8:*;
                        var loc9:*=((loc8 = this).iListItemsShown + 1);
                        loc8.iListItemsShown = loc9;
                    }
                    else if (this.textOption_Inspectable == TEXT_OPTION_MULTILINE) 
                    {
                        loc9 = ((loc8 = this).iListItemsShown + 1);
                        loc8.iListItemsShown = loc9;
                    }
                    else 
                    {
                        loc7.itemIndex = int.MAX_VALUE;
                        loc7.visible = false;
                    }
                }
                loc2 = this._filterer.GetNextFilterMatch(loc2);
            }
            if (this.needMobileScrollList) 
            {
                this.setMobileScrollingListData(loc5);
            }
            this.PositionEntries();
            if (this.ScrollUp != null) 
            {
                this.ScrollUp.visible = this.scrollPosition > 0;
            }
            if (this.ScrollDown != null) 
            {
                this.ScrollDown.visible = this.scrollPosition < this.iMaxScrollPosition;
            }
            this.bUpdated = true;
            return;
        }

        protected function PositionEntries():*
        {
            var loc3:*=null;
            var loc5:*=0;
            var loc1:*=0;
            var loc2:*=this.border.y;
            var loc4:*=1;
            if (this.reverseOrder) 
            {
                loc4 = -1;
            }
            if (this.iListItemsShown > 0) 
            {
                if (this.reverseOrder) 
                {
                    loc2 = this.fBorderHeight;
                    loc3 = this.GetClipByIndex(loc5);
                    if (loc3.Sizer_mc) 
                    {
                        loc2 = loc2 - loc3.Sizer_mc.height;
                    }
                    else 
                    {
                        loc2 = loc2 - loc3.height;
                    }
                }
                loc5 = 0;
                while (loc5 < this.iListItemsShown) 
                {
                    loc3 = this.GetClipByIndex(loc5);
                    loc3.y = loc2 + loc1 * loc4;
                    if (loc3.Sizer_mc) 
                    {
                        loc1 = loc1 + (loc3.Sizer_mc.height + this.fVerticalSpacing);
                    }
                    else 
                    {
                        loc1 = loc1 + (loc3.height + this.fVerticalSpacing);
                    }
                    ++loc5;
                }
            }
            this.fShownItemsHeight = loc1;
            return;
        }

        public function InvalidateData():*
        {
            var loc7:*=0;
            var loc1:*=this.bUpdated ? this.selectedClipIndex : -1;
            var loc2:*=false;
            this._filterer.filterArray = this.EntriesA;
            var loc3:*=this.border.getBounds(this);
            var loc4:*=new flash.geom.Point(loc3.x, loc3.y);
            var loc5:*=new flash.geom.Point(loc3.x + loc3.width, loc3.y + loc3.height);
            this.localToGlobal(loc4);
            this.localToGlobal(loc5);
            this.fListHeight = loc5.y - loc4.y;
            this.CalculateMaxScrollPosition();
            if (this.iSelectedIndex >= this.EntriesA.length) 
            {
                this.iSelectedIndex = (this.EntriesA.length - 1);
                loc2 = true;
            }
            var loc6:*=false;
            if (!this._filterer.IsValidIndex(this.iSelectedIndex)) 
            {
                if ((loc7 = this._filterer.GetPrevFilterMatch(this.iSelectedIndex)) != int.MAX_VALUE) 
                {
                    this.iSelectedIndex = loc7;
                    loc2 = true;
                    loc6 = true;
                }
                else if (this._filterer.GetNextFilterMatch(this.iSelectedIndex) == int.MAX_VALUE) 
                {
                    this.iSelectedIndex = -1;
                }
            }
            if (this.iScrollPosition > this.iMaxScrollPosition) 
            {
                this.iScrollPosition = this.iMaxScrollPosition;
            }
            this.UpdateList();
            if (!(loc1 == -1) && this.restoreListIndex_Inspectable && !this.needMobileScrollList && !loc6) 
            {
                this.selectedClipIndex = loc1;
            }
            else if (loc2) 
            {
                dispatchEvent(new flash.events.Event(SELECTION_CHANGE, true, true));
            }
            return;
        }

        public function UpdateSelectedEntry():*
        {
            var loc1:*=null;
            if (this.iSelectedIndex != -1) 
            {
                loc1 = this.FindClipForEntry(this.iSelectedIndex);
                if (loc1 != null) 
                {
                    this.SetEntry(loc1, this.EntriesA[this.iSelectedIndex]);
                }
            }
            return;
        }

        public function UpdateEntry(arg1:int):*
        {
            var loc1:*=this.EntriesA[arg1];
            var loc2:*=this.FindClipForEntry(arg1);
            this.SetEntry(loc2, loc1);
            return;
        }

        public function onFilterChange():*
        {
            this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
            this.CalculateMaxScrollPosition();
            return;
        }

        protected function CalculateMaxScrollPosition():*
        {
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc1:*=this._filterer.EntryMatchesFilter(this.EntriesA[(this.EntriesA.length - 1)]) ? (this.EntriesA.length - 1) : this._filterer.GetPrevFilterMatch((this.EntriesA.length - 1));
            if (loc1 != int.MAX_VALUE) 
            {
                loc2 = this.GetEntryHeight(loc1);
                loc3 = loc1;
                loc4 = 1;
                while (!(loc3 == int.MAX_VALUE) && loc2 < this.fListHeight && loc4 < this.uiNumListItems) 
                {
                    loc5 = loc3;
                    loc3 = this._filterer.GetPrevFilterMatch(loc3);
                    if (loc3 == int.MAX_VALUE) 
                    {
                        continue;
                    }
                    loc2 = loc2 + (this.GetEntryHeight(loc3) + this.fVerticalSpacing);
                    if (loc2 < this.fListHeight) 
                    {
                        ++loc4;
                        continue;
                    }
                    loc3 = loc5;
                }
                if (loc3 != int.MAX_VALUE) 
                {
                    loc6 = 0;
                    loc7 = this._filterer.GetPrevFilterMatch(loc3);
                    while (loc7 != int.MAX_VALUE) 
                    {
                        ++loc6;
                        loc7 = this._filterer.GetPrevFilterMatch(loc7);
                    }
                    this.iMaxScrollPosition = loc6;
                }
                else 
                {
                    this.iMaxScrollPosition = 0;
                }
            }
            else 
            {
                this.iMaxScrollPosition = 0;
            }
            return;
        }

        protected function GetEntryHeight(arg1:Number):Number
        {
            var loc1:*=this.GetClipByIndex(0);
            var loc2:*=0;
            if (loc1 != null) 
            {
                if (loc1.hasDynamicHeight || this.textOption_Inspectable == TEXT_OPTION_MULTILINE) 
                {
                    this.SetEntry(loc1, this.EntriesA[arg1]);
                    if (loc1.Sizer_mc) 
                    {
                        loc2 = loc1.Sizer_mc.height;
                    }
                    else 
                    {
                        loc2 = loc1.height;
                    }
                }
                else 
                {
                    loc2 = loc1.defaultHeight;
                }
            }
            return loc2;
        }

        public function moveSelectionUp():*
        {
            var loc1:*=NaN;
            var loc2:*=undefined;
            if (this.bDisableSelection) 
            {
                if (this.bAllowSelectionDisabledListNav) 
                {
                    loc2 = this.scrollPosition;
                    --this.scrollPosition;
                    if (loc2 != this.scrollPosition) 
                    {
                        dispatchEvent(new flash.events.Event(PLAY_FOCUS_SOUND, true, true));
                    }
                }
            }
            else if (this.selectedIndex > 0) 
            {
                loc1 = this._filterer.GetPrevFilterMatch(this.selectedIndex);
                if (loc1 != int.MAX_VALUE) 
                {
                    this.selectedIndex = loc1;
                    this.bMouseDrivenNav = false;
                    dispatchEvent(new flash.events.Event(PLAY_FOCUS_SOUND, true, true));
                }
            }
            return;
        }

        public function moveSelectionDown():*
        {
            var loc1:*=NaN;
            var loc2:*=undefined;
            if (this.bDisableSelection) 
            {
                if (this.bAllowSelectionDisabledListNav) 
                {
                    loc2 = this.scrollPosition;
                    this.scrollPosition = this.scrollPosition + 1;
                    if (loc2 != this.scrollPosition) 
                    {
                        dispatchEvent(new flash.events.Event(PLAY_FOCUS_SOUND, true, true));
                    }
                }
            }
            else if (this.selectedIndex < (this.EntriesA.length - 1)) 
            {
                loc1 = this._filterer.GetNextFilterMatch(this.selectedIndex);
                if (loc1 != int.MAX_VALUE) 
                {
                    this.selectedIndex = loc1;
                    this.bMouseDrivenNav = false;
                    dispatchEvent(new flash.events.Event(PLAY_FOCUS_SOUND, true, true));
                }
            }
            return;
        }

        protected function onItemPress():*
        {
            if (!this.bDisableInput && !this.bDisableSelection && !(this.iSelectedIndex == -1)) 
            {
                dispatchEvent(new flash.events.Event(ITEM_PRESS, true, true));
            }
            else 
            {
                dispatchEvent(new flash.events.Event(LIST_PRESS, true, true));
            }
            return;
        }

        protected function SetEntry(arg1:Shared.AS3.BSScrollingListEntry, arg2:Object):*
        {
            var aEntryClip:Shared.AS3.BSScrollingListEntry;
            var aEntryObject:Object;

            var loc1:*;
            aEntryClip = arg1;
            aEntryObject = arg2;
            if (aEntryClip != null) 
            {
                aEntryClip.selected = aEntryObject == this.selectedEntry;
                try 
                {
                    aEntryClip.SetEntryText(aEntryObject, this.strTextOption);
                }
                catch (e:Error)
                {
                    trace("BSScrollingList::SetEntry -- SetEntryText error: " + e.getStackTrace());
                }
            }
            return;
        }

        protected function onSetPlatform(arg1:flash.events.Event):*
        {
            var loc1:*=arg1 as Shared.AS3.Events.PlatformChangeEvent;
            this.SetPlatform(loc1.uiPlatform, loc1.bPS3Switch, loc1.uiController, loc1.uiKeyboard);
            return;
        }

        public function SetPlatform(arg1:uint, arg2:Boolean, arg3:uint, arg4:uint):*
        {
            this.uiPlatform = arg1;
            this.uiController = this.uiController;
            this.bMouseDrivenNav = this.uiController != 0 ? false : true;
            return;
        }

        protected function createMobileScrollingList():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=null;
            var loc5:*=false;
            var loc6:*=false;
            if (this._itemRendererClassName != null) 
            {
                loc1 = Shared.AS3.COMPANIONAPP.BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).maskDimension;
                loc2 = Shared.AS3.COMPANIONAPP.BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).spaceBetweenButtons;
                loc3 = Shared.AS3.COMPANIONAPP.BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).scrollDirection;
                loc4 = Shared.AS3.COMPANIONAPP.BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).linkageId;
                loc5 = Shared.AS3.COMPANIONAPP.BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).clickable;
                loc6 = Shared.AS3.COMPANIONAPP.BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).reversed;
                this.scrollList = new Mobile.ScrollList.MobileScrollList(loc1, loc2, loc3);
                this.scrollList.itemRendererLinkageId = loc4;
                this.scrollList.noScrollShortList = true;
                this.scrollList.clickable = loc5;
                this.scrollList.endListAlign = loc6;
                this.scrollList.textOption = this.strTextOption;
                this.scrollList.setScrollIndicators(this.ScrollUp, this.ScrollDown);
                this.scrollList.x = 0;
                this.scrollList.y = 0;
                addChild(this.scrollList);
                this.scrollList.addEventListener(Mobile.ScrollList.MobileScrollList.ITEM_SELECT, this.onMobileScrollListItemSelected, false, 0, true);
            }
            return;
        }

        protected function destroyMobileScrollingList():void
        {
            if (this.scrollList != null) 
            {
                this.scrollList.removeEventListener(Mobile.ScrollList.MobileScrollList.ITEM_SELECT, this.onMobileScrollListItemSelected);
                removeChild(this.scrollList);
                this.scrollList.destroy();
            }
            return;
        }

        protected function setMobileScrollingListData(arg1:__AS3__.vec.Vector.<Object>):void
        {
            if (arg1 == null) 
            {
                trace("setMobileScrollingListData::Error: No data received to display List Items!");
            }
            else if (arg1.length > 0) 
            {
                this.scrollList.setData(arg1);
            }
            else 
            {
                this.scrollList.invalidateData();
            }
            return;
        }

        public function onComponentInit(arg1:flash.events.Event):*
        {
            if (this.needMobileScrollList) 
            {
                this.createMobileScrollingList();
                if (this.border != null) 
                {
                    this.border.alpha = 0;
                }
            }
            if (loaderInfo != null) 
            {
                loaderInfo.removeEventListener(flash.events.Event.INIT, this.onComponentInit);
            }
            if (!this.bInitialized) 
            {
                this.SetNumListItems(this.uiNumListItems);
            }
            return;
        }

        protected function onStageInit(arg1:flash.events.Event):*
        {
            stage.addEventListener(Shared.AS3.Events.PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatform);
            if (!this.bInitialized) 
            {
                this.SetNumListItems(this.uiNumListItems);
            }
            if (!(this.ScrollUp == null) && !Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                this.ScrollUp.addEventListener(flash.events.MouseEvent.CLICK, this.onScrollArrowClick, false, 0, true);
            }
            if (!(this.ScrollDown == null) && !Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                this.ScrollDown.addEventListener(flash.events.MouseEvent.CLICK, this.onScrollArrowClick, false, 0, true);
            }
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.onStageInit);
            return;
        }

        protected function onStageDestruct(arg1:flash.events.Event):*
        {
            var loc2:*=null;
            stage.removeEventListener(Shared.AS3.Events.PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatform);
            removeEventListener(Shared.AS3.ListFilterer.FILTER_CHANGE, this.onFilterChange);
            loaderInfo.removeEventListener(flash.events.Event.INIT, this.onComponentInit);
            removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.onStageDestruct);
            removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            removeEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp);
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            if (this.ScrollUp) 
            {
                this.ScrollUp.removeEventListener(flash.events.MouseEvent.CLICK, this.onScrollArrowClick);
            }
            if (this.ScrollDown) 
            {
                this.ScrollDown.removeEventListener(flash.events.MouseEvent.CLICK, this.onScrollArrowClick);
            }
            var loc1:*=0;
            while (loc1 < this.EntryHolder_mc.numChildren) 
            {
                loc2 = this.GetClipByIndex(loc1);
                loc2.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onEntryRollover);
                loc2.removeEventListener(flash.events.MouseEvent.CLICK, this.onEntryPress);
                ++loc1;
            }
            if (this.needMobileScrollList) 
            {
                this.destroyMobileScrollingList();
            }
            return;
        }

        protected function onRender(arg1:flash.events.Event):*
        {
            if (!this.bInitialized) 
            {
                this.SetNumListItems(this.uiNumListItems);
            }
            removeEventListener(flash.events.Event.RENDER, this.onRender);
            return;
        }

        public function onScrollArrowClick(arg1:flash.events.Event):*
        {
            if (!this.bDisableInput && (!this.bDisableSelection || this.bAllowSelectionDisabledListNav)) 
            {
                this.doSetSelectedIndex(-1);
                if (arg1.target == this.ScrollUp || arg1.target.parent == this.ScrollUp) 
                {
                    --this.scrollPosition;
                }
                else if (arg1.target == this.ScrollDown || arg1.target.parent == this.ScrollDown) 
                {
                    this.scrollPosition = this.scrollPosition + 1;
                }
                arg1.stopPropagation();
            }
            return;
        }

        public function onEntryRollover(arg1:flash.events.Event):*
        {
            var loc1:*=undefined;
            this.bMouseDrivenNav = true;
            if (!this.bDisableInput && !this.bDisableSelection) 
            {
                loc1 = this.iSelectedIndex;
                this.doSetSelectedIndex((arg1.currentTarget as Shared.AS3.BSScrollingListEntry).itemIndex);
                if (loc1 != this.iSelectedIndex) 
                {
                    dispatchEvent(new flash.events.Event(PLAY_FOCUS_SOUND, true, true));
                }
            }
            return;
        }

        public function onEntryPress(arg1:flash.events.MouseEvent):*
        {
            arg1.stopPropagation();
            this.bMouseDrivenNav = true;
            this.onItemPress();
            return;
        }

        public function ClearList():*
        {
            this.EntriesA.splice(0, this.EntriesA.length);
            return;
        }

        public function GetClipByIndex(arg1:uint):Shared.AS3.BSScrollingListEntry
        {
            return arg1 < this.EntryHolder_mc.numChildren ? this.EntryHolder_mc.getChildAt(arg1) as Shared.AS3.BSScrollingListEntry : null;
        }

        public function FindClipForEntry(arg1:int):Shared.AS3.BSScrollingListEntry
        {
            var loc3:*=undefined;
            var loc4:*=null;
            if (!this.bUpdated) 
            {
                trace("WARNING: FindClipForEntry will always fail to find a clip before Update() has been called at least once");
                loc3 = new Error();
                trace(loc3.getStackTrace());
            }
            if (arg1 == -1 || arg1 == int.MAX_VALUE || arg1 >= this.EntriesA.length) 
            {
                return null;
            }
            var loc1:*=null;
            var loc2:*=0;
            while (loc2 < this.EntryHolder_mc.numChildren) 
            {
                if ((loc4 = this.GetClipByIndex(loc2)).visible == true && loc4.itemIndex == arg1) 
                {
                    loc1 = loc4;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        public function GetEntryFromClipIndex(arg1:uint):int
        {
            var loc1:*=this.GetClipByIndex(arg1);
            return loc1 ? loc1.itemIndex : -1;
        }

        public function onKeyDown(arg1:flash.events.KeyboardEvent):*
        {
            if (!this.bDisableInput) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.UP) 
                {
                    if (arg1.keyCode == flash.ui.Keyboard.DOWN) 
                    {
                        this.moveSelectionDown();
                        arg1.stopPropagation();
                    }
                }
                else 
                {
                    this.moveSelectionUp();
                    arg1.stopPropagation();
                }
            }
            return;
        }

        public function onKeyUp(arg1:flash.events.KeyboardEvent):*
        {
            if (!this.bDisableInput && !this.bDisableSelection && arg1.keyCode == flash.ui.Keyboard.ENTER) 
            {
                this.onItemPress();
                arg1.stopPropagation();
            }
            return;
        }

        public function onMouseWheel(arg1:flash.events.MouseEvent):*
        {
            var loc1:*=0;
            var loc2:*=undefined;
            var loc3:*=undefined;
            if (!this.bDisableInput && (!this.bDisableSelection || this.bAllowSelectionDisabledListNav) && this.iMaxScrollPosition > 0) 
            {
                loc1 = MOUSEWHEEL_SCROLL_DISTANCE_BASE;
                if (arg1.ctrlKey && arg1.shiftKey) 
                {
                    loc1 = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT, this.numListItems_Inspectable);
                }
                else if (arg1.ctrlKey) 
                {
                    loc1 = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRL, this.numListItems_Inspectable);
                }
                else if (arg1.shiftKey) 
                {
                    loc1 = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_SHIFT, this.numListItems_Inspectable);
                }
                loc2 = this.scrollPosition;
                loc3 = loc2;
                if (arg1.delta < 0) 
                {
                    loc3 = this.scrollPosition + loc1;
                }
                else if (arg1.delta > 0) 
                {
                    loc3 = this.scrollPosition - loc1;
                }
                this.scrollPosition = Shared.GlobalFunc.Clamp(loc3, 0, this.iMaxScrollPosition);
                this.SetFocusUnderMouse();
                arg1.stopPropagation();
                if (loc2 != this.scrollPosition) 
                {
                    dispatchEvent(new flash.events.Event(PLAY_FOCUS_SOUND, true, true));
                }
            }
            return;
        }

        internal function SetFocusUnderMouse():*
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=0;
            while (loc1 < this.iListItemsShown) 
            {
                loc2 = this.GetClipByIndex(loc1);
                loc3 = loc2.border;
                loc4 = localToGlobal(new flash.geom.Point(mouseX, mouseY));
                if (loc2.hitTestPoint(loc4.x, loc4.y, false)) 
                {
                    this.selectedIndex = loc2.itemIndex;
                }
                ++loc1;
            }
            return;
        }

        public function get hasBeenUpdated():Boolean
        {
            return this.bUpdated;
        }

        public function get mouseDrivenNav():Boolean
        {
            return this.bMouseDrivenNav;
        }

        public function get filterer():Shared.AS3.ListFilterer
        {
            return this._filterer;
        }

        public function get itemsShown():uint
        {
            return this.iListItemsShown;
        }

        public function get initialized():Boolean
        {
            return this.bInitialized;
        }

        public function get selectedIndex():int
        {
            return this.iSelectedIndex;
        }

        public function set selectedIndex(arg1:int):*
        {
            this.doSetSelectedIndex(arg1);
            return;
        }

        public function get selectedClipIndex():int
        {
            var loc1:*=this.FindClipForEntry(this.iSelectedIndex);
            return loc1 == null ? -1 : loc1.clipIndex;
        }

        public function set selectedClipIndex(arg1:int):*
        {
            this.doSetSelectedIndex(this.GetEntryFromClipIndex(arg1));
            return;
        }

        public function set filterer(arg1:Shared.AS3.ListFilterer):*
        {
            this._filterer = arg1;
            return;
        }

        public function get shownItemsHeight():Number
        {
            return this.fShownItemsHeight;
        }

        protected function onMobileScrollListItemSelected(arg1:Mobile.ScrollList.EventWithParams):void
        {
            var loc1:*=arg1.params.renderer as Mobile.ScrollList.MobileListItemRenderer;
            if (loc1.data == null) 
            {
                return;
            }
            var loc2:*=loc1.data.id;
            var loc3:*=this.iSelectedIndex;
            this.iSelectedIndex = this.GetEntryFromClipIndex(loc2);
            var loc4:*=0;
            while (loc4 < this.EntriesA.length) 
            {
                if (this.EntriesA[loc4] == loc1.data) 
                {
                    this.iSelectedIndex = loc4;
                    break;
                }
                ++loc4;
            }
            if (!this.EntriesA[this.iSelectedIndex].isDivider) 
            {
                if (loc3 == this.iSelectedIndex) 
                {
                    if (this.scrollList.itemRendererLinkageId == Shared.AS3.COMPANIONAPP.BSScrollingListInterface.RADIO_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == Shared.AS3.COMPANIONAPP.BSScrollingListInterface.QUEST_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == Shared.AS3.COMPANIONAPP.BSScrollingListInterface.QUEST_OBJECTIVES_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == Shared.AS3.COMPANIONAPP.BSScrollingListInterface.INVENTORY_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == Shared.AS3.COMPANIONAPP.BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID) 
                    {
                        this.onItemPress();
                    }
                }
                else 
                {
                    dispatchEvent(new flash.events.Event(SELECTION_CHANGE, true, true));
                    if (this.scrollList.itemRendererLinkageId == Shared.AS3.COMPANIONAPP.BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID) 
                    {
                        this.onItemPress();
                    }
                    dispatchEvent(new flash.events.Event(MOBILE_ITEM_PRESS, true, true));
                }
            }
            return;
        }

        public function get scrollPosition():uint
        {
            return this.iScrollPosition;
        }

        public function get maxScrollPosition():uint
        {
            return this.iMaxScrollPosition;
        }

        public function set scrollPosition(arg1:uint):*
        {
            if (!(arg1 == this.iScrollPosition) && arg1 >= 0 && arg1 <= this.iMaxScrollPosition) 
            {
                this.updateScrollPosition(arg1);
            }
            return;
        }

        protected function updateScrollPosition(arg1:uint):*
        {
            this.iScrollPosition = arg1;
            this.UpdateList();
            return;
        }

        public function get selectedEntry():Object
        {
            return this.EntriesA[this.iSelectedIndex];
        }

        public function get entryList():Array
        {
            return this.EntriesA;
        }

        public function set entryList(arg1:Array):*
        {
            this.EntriesA = arg1;
            if (this.EntriesA == null) 
            {
                this.EntriesA = new Array();
            }
            return;
        }

        public function get disableInput_Inspectable():Boolean
        {
            return this.bDisableInput;
        }

        public function set disableInput_Inspectable(arg1:Boolean):*
        {
            this.bDisableInput = arg1;
            return;
        }

        public function get textOption_Inspectable():String
        {
            return this.strTextOption;
        }

        public function set textOption_Inspectable(arg1:String):*
        {
            this.strTextOption = arg1;
            if (this.strTextOption == TEXT_OPTION_MULTILINE && this.Mask_mc == null) 
            {
                this.Mask_mc = new flash.display.MovieClip();
                this.Mask_mc.name = "MultilineMask_mc";
                this.Mask_mc.graphics.clear();
                this.Mask_mc.graphics.beginFill(16777215);
                this.Mask_mc.graphics.drawRect(0, 0, this.border.width, this.border.height);
                this.Mask_mc.graphics.endFill();
                this.addChildAt(this.Mask_mc, getChildIndex(this.EntryHolder_mc) + 1);
                this.Mask_mc.x = this.border.x;
                this.Mask_mc.y = this.border.y;
                this.Mask_mc.mouseEnabled = false;
                this.Mask_mc.alpha = 0;
                this.EntryHolder_mc.mask = this.Mask_mc;
            }
            return;
        }

        public function get verticalSpacing_Inspectable():*
        {
            return this.fVerticalSpacing;
        }

        public function set verticalSpacing_Inspectable(arg1:Number):*
        {
            this.fVerticalSpacing = arg1;
            return;
        }

        public static const SELECTION_CHANGE:String="BSScrollingList::selectionChange";

        public static const TEXT_OPTION_NONE:String="None";

        public static const TEXT_OPTION_SHRINK_TO_FIT:String="Shrink To Fit";

        public static const TEXT_OPTION_MULTILINE:String="Multi-Line";

        public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT:uint=9;

        public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRL:uint=6;

        public static const MOUSEWHEEL_SCROLL_DISTANCE_SHIFT:uint=3;

        public static const MOUSEWHEEL_SCROLL_DISTANCE_BASE:uint=1;

        public static const ITEM_PRESS:String="BSScrollingList::itemPress";

        public static const LIST_PRESS:String="BSScrollingList::listPress";

        public static const LIST_ITEMS_CREATED:String="BSScrollingList::listItemsCreated";

        public static const PLAY_FOCUS_SOUND:String="BSScrollingList::playFocusSound";

        public static const MOBILE_ITEM_PRESS:String="BSScrollingList::mobileItemPress";

        protected var fListHeight:Number;

        protected var fVerticalSpacing:Number;

        protected var iScrollPosition:uint;

        protected var iMaxScrollPosition:uint;

        protected var bMouseDrivenNav:Boolean;

        protected var fShownItemsHeight:Number;

        protected var uiPlatform:uint;

        protected var uiController:uint;

        protected var bInitialized:Boolean;

        public var Mask_mc:flash.display.MovieClip;

        protected var bDisableSelection:Boolean;

        protected var bAllowSelectionDisabledListNav:Boolean;

        protected var bDisableInput:Boolean;

        protected var bReverseList:Boolean;

        protected var bReverseOrder:Boolean=false;

        protected var bUpdated:Boolean;

        internal var fBorderHeight:Number=0;

        protected var uiNumListItems:uint;

        internal var _DisplayNumListItems:uint=0;

        public var scrollList:Mobile.ScrollList.MobileScrollList;

        protected var _itemRendererClassName:String="BSScrollingListEntry";

        public var border:flash.display.MovieClip;

        public var ScrollUp:flash.display.MovieClip;

        public var ScrollDown:flash.display.MovieClip;

        protected var EntriesA:Array;

        protected var EntryHolder_mc:flash.display.MovieClip;

        protected var strTextOption:String;

        protected var _filterer:Shared.AS3.ListFilterer;

        protected var iSelectedIndex:int;

        protected var bRestoreListIndex:Boolean;

        protected var iListItemsShown:uint;

        protected var ListEntryClass:Class;
    }
}
