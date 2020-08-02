 
package Shared.AS3
{
   import Mobile.ScrollList.EventWithParams;
   import Mobile.ScrollList.MobileListItemRenderer;
   import Mobile.ScrollList.MobileScrollList;
   import Shared.AS3.COMPANIONAPP.BSScrollingListInterface;
   import Shared.AS3.COMPANIONAPP.CompanionAppMode;
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.getDefinitionByName;
   
   public class BSScrollingList extends MovieClip
   {
      
      public static const TEXT_OPTION_NONE:String = // method body index: 896 method index: 896
      "None";
      
      public static const TEXT_OPTION_SHRINK_TO_FIT:String = // method body index: 896 method index: 896
      "Shrink To Fit";
      
      public static const TEXT_OPTION_MULTILINE:String = // method body index: 896 method index: 896
      "Multi-Line";
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT:uint = // method body index: 896 method index: 896
      9;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRL:uint = // method body index: 896 method index: 896
      6;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_SHIFT:uint = // method body index: 896 method index: 896
      3;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_BASE:uint = // method body index: 896 method index: 896
      1;
      
      public static const SELECTION_CHANGE:String = // method body index: 896 method index: 896
      "BSScrollingList::selectionChange";
      
      public static const ITEM_PRESS:String = // method body index: 896 method index: 896
      "BSScrollingList::itemPress";
      
      public static const LIST_PRESS:String = // method body index: 896 method index: 896
      "BSScrollingList::listPress";
      
      public static const LIST_ITEMS_CREATED:String = // method body index: 896 method index: 896
      "BSScrollingList::listItemsCreated";
      
      public static const PLAY_FOCUS_SOUND:String = // method body index: 896 method index: 896
      "BSScrollingList::playFocusSound";
      
      public static const MOBILE_ITEM_PRESS:String = // method body index: 896 method index: 896
      "BSScrollingList::mobileItemPress";
       
      
      public var scrollList:MobileScrollList;
      
      protected var _itemRendererClassName:String = "BSScrollingListEntry";
      
      public var border:MovieClip;
      
      public var ScrollUp:MovieClip;
      
      public var ScrollDown:MovieClip;
      
      public var Mask_mc:MovieClip;
      
      protected var EntriesA:Array;
      
      protected var EntryHolder_mc:MovieClip;
      
      protected var _filterer:ListFilterer;
      
      protected var iSelectedIndex:int;
      
      protected var bRestoreListIndex:Boolean;
      
      protected var iListItemsShown:uint;
      
      protected var uiNumListItems:uint;
      
      protected var ListEntryClass:Class;
      
      protected var fListHeight:Number;
      
      protected var fVerticalSpacing:Number;
      
      protected var iScrollPosition:uint;
      
      protected var iMaxScrollPosition:uint;
      
      protected var bMouseDrivenNav:Boolean;
      
      protected var fShownItemsHeight:Number;
      
      protected var uiPlatform:uint;
      
      protected var uiController:uint;
      
      protected var bInitialized:Boolean;
      
      protected var strTextOption:String;
      
      protected var bDisableSelection:Boolean;
      
      protected var bAllowSelectionDisabledListNav:Boolean;
      
      protected var bDisableInput:Boolean;
      
      protected var bReverseList:Boolean;
      
      protected var bReverseOrder:Boolean = false;
      
      protected var bUpdated:Boolean;
      
      private var fBorderHeight:Number = 0;
      
      private var _DisplayNumListItems:uint = 0;
      
      public function BSScrollingList()
      {
         // method body index: 898 method index: 898
         super();
         this.EntriesA = new Array();
         this._filterer = new ListFilterer();
         addEventListener(ListFilterer.FILTER_CHANGE,this.onFilterChange,false,0,true);
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
         if(loaderInfo != null)
         {
            loaderInfo.addEventListener(Event.INIT,this.onComponentInit,false,0,true);
         }
         addEventListener(Event.ADDED_TO_STAGE,this.onStageInit);
         addEventListener(Event.RENDER,this.onRender);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onStageDestruct,false,0,true);
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,0,true);
         if(!this.needMobileScrollList)
         {
            addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,false,0,true);
         }
         if(this.border == null)
         {
            throw new Error("No \'border\' clip found.  BSScrollingList requires a border rect to define its extents.");
         }
         this.fBorderHeight = this.border.height;
         this.EntryHolder_mc = new MovieClip();
         this.EntryHolder_mc.name = "EntryHolder_mc";
         this.addChildAt(this.EntryHolder_mc,this.getChildIndex(this.border) + 1);
         this.iSelectedIndex = -1;
         this.iScrollPosition = 0;
         this.iMaxScrollPosition = 0;
         this.iListItemsShown = 0;
         this.fListHeight = 0;
         this.uiPlatform = 1;
         if(this.ScrollUp != null)
         {
            this.ScrollUp.visible = false;
         }
         if(this.ScrollDown != null)
         {
            this.ScrollDown.visible = false;
         }
      }
      
      protected function get needMobileScrollList() : Boolean
      {
         // method body index: 897 method index: 897
         return CompanionAppMode.isOn;
      }
      
      public function onComponentInit(event:Event) : *
      {
         // method body index: 899 method index: 899
         if(this.needMobileScrollList)
         {
            this.createMobileScrollingList();
            if(this.border != null)
            {
               this.border.alpha = 0;
            }
         }
         if(loaderInfo != null)
         {
            loaderInfo.removeEventListener(Event.INIT,this.onComponentInit);
         }
         if(!this.bInitialized)
         {
            this.SetNumListItems(this.uiNumListItems);
         }
      }
      
      protected function onStageInit(event:Event) : *
      {
         // method body index: 900 method index: 900
         stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatform);
         if(!this.bInitialized)
         {
            this.SetNumListItems(this.uiNumListItems);
         }
         if(this.ScrollUp != null && !CompanionAppMode.isOn)
         {
            this.ScrollUp.addEventListener(MouseEvent.CLICK,this.onScrollArrowClick,false,0,true);
         }
         if(this.ScrollDown != null && !CompanionAppMode.isOn)
         {
            this.ScrollDown.addEventListener(MouseEvent.CLICK,this.onScrollArrowClick,false,0,true);
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.onStageInit);
      }
      
      protected function onStageDestruct(event:Event) : *
      {
         // method body index: 901 method index: 901
         var curClip:BSScrollingListEntry = null;
         stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatform);
         removeEventListener(ListFilterer.FILTER_CHANGE,this.onFilterChange);
         loaderInfo.removeEventListener(Event.INIT,this.onComponentInit);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onStageDestruct);
         removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         if(this.ScrollUp)
         {
            this.ScrollUp.removeEventListener(MouseEvent.CLICK,this.onScrollArrowClick);
         }
         if(this.ScrollDown)
         {
            this.ScrollDown.removeEventListener(MouseEvent.CLICK,this.onScrollArrowClick);
         }
         for(var i:uint = 0; i < this.EntryHolder_mc.numChildren; i++)
         {
            curClip = this.GetClipByIndex(i);
            curClip.removeEventListener(MouseEvent.MOUSE_OVER,this.onEntryRollover);
            curClip.removeEventListener(MouseEvent.CLICK,this.onEntryPress);
         }
         if(this.needMobileScrollList)
         {
            this.destroyMobileScrollingList();
         }
      }
      
      protected function onRender(event:Event) : *
      {
         // method body index: 902 method index: 902
         if(!this.bInitialized)
         {
            this.SetNumListItems(this.uiNumListItems);
         }
         removeEventListener(Event.RENDER,this.onRender);
      }
      
      public function onScrollArrowClick(event:Event) : *
      {
         // method body index: 903 method index: 903
         if(!this.bDisableInput && (!this.bDisableSelection || this.bAllowSelectionDisabledListNav))
         {
            this.doSetSelectedIndex(-1);
            if(event.target == this.ScrollUp || event.target.parent == this.ScrollUp)
            {
               this.scrollPosition = this.scrollPosition - 1;
            }
            else if(event.target == this.ScrollDown || event.target.parent == this.ScrollDown)
            {
               this.scrollPosition = this.scrollPosition + 1;
            }
            event.stopPropagation();
         }
      }
      
      public function onEntryRollover(event:Event) : *
      {
         // method body index: 904 method index: 904
         var prevSelection:* = undefined;
         this.bMouseDrivenNav = true;
         if(!this.bDisableInput && !this.bDisableSelection)
         {
            prevSelection = this.iSelectedIndex;
            this.doSetSelectedIndex((event.currentTarget as BSScrollingListEntry).itemIndex);
            if(prevSelection != this.iSelectedIndex)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      public function onEntryPress(event:MouseEvent) : *
      {
         // method body index: 905 method index: 905
         event.stopPropagation();
         this.bMouseDrivenNav = true;
         this.onItemPress();
      }
      
      public function ClearList() : *
      {
         // method body index: 906 method index: 906
         this.EntriesA.splice(0,this.EntriesA.length);
      }
      
      public function GetClipByIndex(auiIndex:uint) : BSScrollingListEntry
      {
         // method body index: 907 method index: 907
         return auiIndex < this.EntryHolder_mc.numChildren?this.EntryHolder_mc.getChildAt(auiIndex) as BSScrollingListEntry:null;
      }
      
      public function FindClipForEntry(aEntryIndex:int) : BSScrollingListEntry
      {
         // method body index: 908 method index: 908
         var e:* = undefined;
         var curClip:BSScrollingListEntry = null;
         if(!this.bUpdated)
         {
            trace("WARNING: FindClipForEntry will always fail to find a clip before Update() has been called at least once");
            e = new Error();
            trace(e.getStackTrace());
         }
         if(aEntryIndex == -1 || aEntryIndex == int.MAX_VALUE || aEntryIndex >= this.EntriesA.length)
         {
            return null;
         }
         var clip:BSScrollingListEntry = null;
         for(var i:uint = 0; i < this.EntryHolder_mc.numChildren; i++)
         {
            curClip = this.GetClipByIndex(i);
            if(curClip.visible == true && curClip.itemIndex == aEntryIndex)
            {
               clip = curClip;
               break;
            }
         }
         return clip;
      }
      
      public function GetEntryFromClipIndex(aiClipIndex:uint) : int
      {
         // method body index: 909 method index: 909
         var clip:BSScrollingListEntry = this.GetClipByIndex(aiClipIndex);
         return !!clip?int(clip.itemIndex):-1;
      }
      
      public function onKeyDown(event:KeyboardEvent) : *
      {
         // method body index: 910 method index: 910
         if(!this.bDisableInput)
         {
            if(event.keyCode == Keyboard.UP)
            {
               this.moveSelectionUp();
               event.stopPropagation();
            }
            else if(event.keyCode == Keyboard.DOWN)
            {
               this.moveSelectionDown();
               event.stopPropagation();
            }
         }
      }
      
      public function onKeyUp(event:KeyboardEvent) : *
      {
         // method body index: 911 method index: 911
         if(!this.bDisableInput && !this.bDisableSelection && event.keyCode == Keyboard.ENTER)
         {
            this.onItemPress();
            event.stopPropagation();
         }
      }
      
      public function onMouseWheel(event:MouseEvent) : *
      {
         // method body index: 912 method index: 912
         var scrollDistance:uint = 0;
         var prevScrollPos:* = undefined;
         var newScrollPos:* = undefined;
         if(!this.bDisableInput && (!this.bDisableSelection || this.bAllowSelectionDisabledListNav) && this.iMaxScrollPosition > 0)
         {
            scrollDistance = MOUSEWHEEL_SCROLL_DISTANCE_BASE;
            if(event.ctrlKey && event.shiftKey)
            {
               scrollDistance = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT,this.numListItems_Inspectable);
            }
            else if(event.ctrlKey)
            {
               scrollDistance = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRL,this.numListItems_Inspectable);
            }
            else if(event.shiftKey)
            {
               scrollDistance = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_SHIFT,this.numListItems_Inspectable);
            }
            prevScrollPos = this.scrollPosition;
            newScrollPos = prevScrollPos;
            if(event.delta < 0)
            {
               newScrollPos = this.scrollPosition + scrollDistance;
            }
            else if(event.delta > 0)
            {
               newScrollPos = this.scrollPosition - scrollDistance;
            }
            this.scrollPosition = GlobalFunc.Clamp(newScrollPos,0,this.iMaxScrollPosition);
            this.SetFocusUnderMouse();
            event.stopPropagation();
            if(prevScrollPos != this.scrollPosition)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      private function SetFocusUnderMouse() : *
      {
         // method body index: 913 method index: 913
         var objectListEntry:BSScrollingListEntry = null;
         var borderObject:MovieClip = null;
         var testPoint:Point = null;
         for(var ientryCt:int = 0; ientryCt < this.iListItemsShown; ientryCt++)
         {
            objectListEntry = this.GetClipByIndex(ientryCt);
            borderObject = objectListEntry.border;
            testPoint = localToGlobal(new Point(mouseX,mouseY));
            if(objectListEntry.hitTestPoint(testPoint.x,testPoint.y,false))
            {
               this.selectedIndex = objectListEntry.itemIndex;
            }
         }
      }
      
      public function get hasBeenUpdated() : Boolean
      {
         // method body index: 914 method index: 914
         return this.bUpdated;
      }
      
      public function get mouseDrivenNav() : Boolean
      {
         // method body index: 915 method index: 915
         return this.bMouseDrivenNav;
      }
      
      public function get filterer() : ListFilterer
      {
         // method body index: 916 method index: 916
         return this._filterer;
      }
      
      public function get itemsShown() : uint
      {
         // method body index: 917 method index: 917
         return this.iListItemsShown;
      }
      
      public function get initialized() : Boolean
      {
         // method body index: 918 method index: 918
         return this.bInitialized;
      }
      
      public function get selectedIndex() : int
      {
         // method body index: 919 method index: 919
         return this.iSelectedIndex;
      }
      
      public function set selectedIndex(aiNewIndex:int) : *
      {
         // method body index: 920 method index: 920
         this.doSetSelectedIndex(aiNewIndex);
      }
      
      public function get selectedClipIndex() : int
      {
         // method body index: 921 method index: 921
         var selectedClip:BSScrollingListEntry = this.FindClipForEntry(this.iSelectedIndex);
         return selectedClip != null?int(selectedClip.clipIndex):-1;
      }
      
      public function set selectedClipIndex(aiNewIndex:int) : *
      {
         // method body index: 922 method index: 922
         this.doSetSelectedIndex(this.GetEntryFromClipIndex(aiNewIndex));
      }
      
      public function set filterer(newFilter:ListFilterer) : *
      {
         // method body index: 923 method index: 923
         this._filterer = newFilter;
      }
      
      public function get shownItemsHeight() : Number
      {
         // method body index: 924 method index: 924
         return this.fShownItemsHeight;
      }
      
      protected function doSetSelectedIndex(aiNewIndex:int) : *
      {
         // method body index: 925 method index: 925
         var ioldSelection:int = 0;
         var oldClip:BSScrollingListEntry = null;
         var currTopIndex:int = 0;
         var currBottomIndex:int = 0;
         var currIndex:int = 0;
         var ioffset:int = 0;
         var loopIndex:uint = 0;
         var index:int = 0;
         var i:uint = 0;
         var selectedClip:BSScrollingListEntry = null;
         if(!this.bDisableSelection && aiNewIndex != this.iSelectedIndex)
         {
            ioldSelection = this.iSelectedIndex;
            this.iSelectedIndex = aiNewIndex;
            if(this.EntriesA.length == 0)
            {
               this.iSelectedIndex = -1;
            }
            if(ioldSelection != -1 && ioldSelection < this.EntriesA.length)
            {
               oldClip = this.FindClipForEntry(ioldSelection);
               if(oldClip != null)
               {
                  this.SetEntry(oldClip,this.EntriesA[ioldSelection]);
               }
            }
            if(this.iSelectedIndex != -1)
            {
               this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
               if(this.iSelectedIndex == int.MAX_VALUE)
               {
                  this.iSelectedIndex = -1;
               }
            }
            if(this.iSelectedIndex != -1)
            {
               selectedClip = this.FindClipForEntry(this.iSelectedIndex);
               if(selectedClip == null)
               {
                  this.InvalidateData();
                  selectedClip = this.FindClipForEntry(this.iSelectedIndex);
               }
               if(this.iSelectedIndex != -1 && ioldSelection != this.iSelectedIndex)
               {
                  if(selectedClip != null)
                  {
                     this.SetEntry(selectedClip,this.EntriesA[this.iSelectedIndex]);
                  }
                  else if(this.iListItemsShown > 0)
                  {
                     currTopIndex = this.GetEntryFromClipIndex(0);
                     currBottomIndex = this.GetEntryFromClipIndex(this.iListItemsShown - 1);
                     ioffset = 0;
                     if(this.iSelectedIndex < currTopIndex)
                     {
                        currIndex = currTopIndex;
                        do
                        {
                           currIndex = this._filterer.GetPrevFilterMatch(currIndex);
                           ioffset--;
                        }
                        while(currIndex != this.iSelectedIndex && currIndex != -1 && currIndex != int.MAX_VALUE);
                        
                     }
                     else if(this.iSelectedIndex > currBottomIndex)
                     {
                        currIndex = currBottomIndex;
                        do
                        {
                           currIndex = this._filterer.GetNextFilterMatch(currIndex);
                           ioffset++;
                        }
                        while(currIndex != this.iSelectedIndex && currIndex != -1 && currIndex != int.MAX_VALUE);
                        
                     }
                     this.scrollPosition = this.scrollPosition + ioffset;
                  }
                  if(this.textOption_Inspectable == TEXT_OPTION_MULTILINE)
                  {
                     loopIndex = 0;
                     selectedClip = this.FindClipForEntry(this.iSelectedIndex);
                     while(loopIndex < this.uiNumListItems && selectedClip != null && selectedClip.y + selectedClip.height > this.fListHeight)
                     {
                        this.scrollPosition = this.scrollPosition + 1;
                        selectedClip = this.FindClipForEntry(this.iSelectedIndex);
                        loopIndex++;
                     }
                     if(loopIndex == this.uiNumListItems)
                     {
                        throw new Error("Force-exited list selection loop before the selected entry could be fully scrolled on-screen.  Shouldn\'t be possible!");
                     }
                  }
               }
            }
            if(ioldSelection != this.iSelectedIndex)
            {
               dispatchEvent(new Event(SELECTION_CHANGE,true,true));
            }
            if(this.needMobileScrollList)
            {
               if(this.scrollList != null)
               {
                  if(this.iSelectedIndex != -1)
                  {
                     index = this.selectedClipIndex;
                     for(i = 0; i < this.scrollList.data.length; i++)
                     {
                        if(this.EntriesA[this.iSelectedIndex] == this.scrollList.data[i])
                        {
                           index = i;
                           break;
                        }
                     }
                     this.scrollList.selectedIndex = index;
                  }
                  else
                  {
                     this.scrollList.selectedIndex = -1;
                  }
               }
            }
         }
      }
      
      public function get scrollPosition() : uint
      {
         // method body index: 926 method index: 926
         return this.iScrollPosition;
      }
      
      public function get maxScrollPosition() : uint
      {
         // method body index: 927 method index: 927
         return this.iMaxScrollPosition;
      }
      
      public function set scrollPosition(aiNewPosition:uint) : *
      {
         // method body index: 928 method index: 928
         if(aiNewPosition != this.iScrollPosition && aiNewPosition >= 0 && aiNewPosition <= this.iMaxScrollPosition)
         {
            this.updateScrollPosition(aiNewPosition);
         }
      }
      
      protected function updateScrollPosition(aiPosition:uint) : *
      {
         // method body index: 929 method index: 929
         this.iScrollPosition = aiPosition;
         this.UpdateList();
      }
      
      public function get selectedEntry() : Object
      {
         // method body index: 930 method index: 930
         return this.EntriesA[this.iSelectedIndex];
      }
      
      public function get entryList() : Array
      {
         // method body index: 931 method index: 931
         return this.EntriesA;
      }
      
      public function set entryList(anewArray:Array) : *
      {
         // method body index: 932 method index: 932
         this.EntriesA = anewArray;
         if(this.EntriesA == null)
         {
            this.EntriesA = new Array();
         }
      }
      
      public function get disableInput_Inspectable() : Boolean
      {
         // method body index: 933 method index: 933
         return this.bDisableInput;
      }
      
      public function set disableInput_Inspectable(abFlag:Boolean) : *
      {
         // method body index: 934 method index: 934
         this.bDisableInput = abFlag;
      }
      
      public function get textOption_Inspectable() : String
      {
         // method body index: 935 method index: 935
         return this.strTextOption;
      }
      
      public function set textOption_Inspectable(strNewOption:String) : *
      {
         // method body index: 936 method index: 936
         this.strTextOption = strNewOption;
         if(this.strTextOption == TEXT_OPTION_MULTILINE && this.Mask_mc == null)
         {
            this.Mask_mc = new MovieClip();
            this.Mask_mc.name = "MultilineMask_mc";
            this.Mask_mc.graphics.clear();
            this.Mask_mc.graphics.beginFill(16777215);
            this.Mask_mc.graphics.drawRect(0,0,this.border.width,this.border.height);
            this.Mask_mc.graphics.endFill();
            this.addChildAt(this.Mask_mc,getChildIndex(this.EntryHolder_mc) + 1);
            this.Mask_mc.x = this.border.x;
            this.Mask_mc.y = this.border.y;
            this.Mask_mc.mouseEnabled = false;
            this.Mask_mc.alpha = 0;
            this.EntryHolder_mc.mask = this.Mask_mc;
         }
      }
      
      public function get verticalSpacing_Inspectable() : *
      {
         // method body index: 937 method index: 937
         return this.fVerticalSpacing;
      }
      
      public function set verticalSpacing_Inspectable(afSpacing:Number) : *
      {
         // method body index: 938 method index: 938
         this.fVerticalSpacing = afSpacing;
      }
      
      public function get numListItems_Inspectable() : uint
      {
         // method body index: 939 method index: 939
         return this.uiNumListItems;
      }
      
      public function set numListItems_Inspectable(auiNumItems:uint) : *
      {
         // method body index: 940 method index: 940
         this.uiNumListItems = auiNumItems;
      }
      
      public function get listEntryClass_Inspectable() : String
      {
         // method body index: 941 method index: 941
         return this._itemRendererClassName;
      }
      
      public function set listEntryClass_Inspectable(strClass:String) : *
      {
         // method body index: 942 method index: 942
         this.ListEntryClass = getDefinitionByName(strClass) as Class;
         this._itemRendererClassName = strClass;
      }
      
      public function get restoreListIndex_Inspectable() : Boolean
      {
         // method body index: 943 method index: 943
         return this.bRestoreListIndex;
      }
      
      public function set restoreListIndex_Inspectable(abFlag:Boolean) : *
      {
         // method body index: 944 method index: 944
         this.bRestoreListIndex = abFlag;
      }
      
      public function get disableSelection_Inspectable() : Boolean
      {
         // method body index: 945 method index: 945
         return this.bDisableSelection;
      }
      
      public function set disableSelection_Inspectable(abFlag:Boolean) : *
      {
         // method body index: 946 method index: 946
         this.bDisableSelection = abFlag;
      }
      
      public function set allowWheelScrollNoSelectionChange(abFlag:Boolean) : *
      {
         // method body index: 947 method index: 947
         this.bAllowSelectionDisabledListNav = abFlag;
      }
      
      public function get reverseOrder() : Boolean
      {
         // method body index: 948 method index: 948
         return this.bReverseOrder;
      }
      
      public function set reverseOrder(abFlag:Boolean) : *
      {
         // method body index: 949 method index: 949
         this.bReverseOrder = abFlag;
      }
      
      public function SetNumListItems(auiNumItems:uint) : *
      {
         // method body index: 950 method index: 950
         var i:uint = 0;
         var newClip:MovieClip = null;
         if(auiNumItems != this._DisplayNumListItems)
         {
            this._DisplayNumListItems = auiNumItems;
            if(this.ListEntryClass != null && auiNumItems > 0)
            {
               while(this.EntryHolder_mc.numChildren > 0)
               {
                  this.EntryHolder_mc.removeChildAt(0);
               }
               for(i = 0; i < auiNumItems; i++)
               {
                  newClip = this.GetNewListEntry(i);
                  if(newClip != null)
                  {
                     newClip.clipIndex = i;
                     newClip.name = this._itemRendererClassName + i.toString();
                     newClip.addEventListener(MouseEvent.MOUSE_OVER,this.onEntryRollover);
                     newClip.addEventListener(MouseEvent.CLICK,this.onEntryPress);
                     this.EntryHolder_mc.addChild(newClip);
                  }
                  else
                  {
                     trace("BSScrollingList::SetNumListItems -- List Entry Class " + this._itemRendererClassName + " is invalid or does not derive from BSScrollingListEntry.");
                  }
               }
               this.bInitialized = true;
               dispatchEvent(new Event(LIST_ITEMS_CREATED,true,true));
            }
         }
      }
      
      protected function GetNewListEntry(auiClipIndex:uint) : BSScrollingListEntry
      {
         // method body index: 951 method index: 951
         return new this.ListEntryClass() as BSScrollingListEntry;
      }
      
      public function UpdateList() : *
      {
         // method body index: 952 method index: 952
         var curClip:BSScrollingListEntry = null;
         var currEntry:BSScrollingListEntry = null;
         var faccumHeight:Number = 0;
         var iupdateIndex:Number = this._filterer.FindArrayIndexOfFilteredPosition(this.iScrollPosition);
         var iupdateMobileIndex:Number = iupdateIndex;
         for(var uiclip:uint = 0; uiclip < this.uiNumListItems; uiclip++)
         {
            curClip = this.GetClipByIndex(uiclip);
            if(curClip)
            {
               curClip.visible = false;
               curClip.itemIndex = int.MAX_VALUE;
            }
         }
         var fileteredData:Vector.<Object> = new Vector.<Object>();
         this.iListItemsShown = 0;
         if(this.needMobileScrollList)
         {
            while(iupdateMobileIndex != int.MAX_VALUE && iupdateMobileIndex != -1 && iupdateMobileIndex < this.EntriesA.length && faccumHeight <= this.fListHeight)
            {
               fileteredData.push(this.EntriesA[iupdateMobileIndex]);
               iupdateMobileIndex = this._filterer.GetNextFilterMatch(iupdateMobileIndex);
            }
         }
         while(iupdateIndex != int.MAX_VALUE && iupdateIndex != -1 && iupdateIndex < this.EntriesA.length && this.iListItemsShown < this.uiNumListItems && faccumHeight <= this.fListHeight)
         {
            currEntry = this.GetClipByIndex(this.iListItemsShown);
            if(currEntry)
            {
               this.SetEntry(currEntry,this.EntriesA[iupdateIndex]);
               currEntry.itemIndex = iupdateIndex;
               currEntry.visible = !this.needMobileScrollList;
               if(currEntry.Sizer_mc)
               {
                  faccumHeight = faccumHeight + currEntry.Sizer_mc.height;
               }
               else
               {
                  faccumHeight = faccumHeight + currEntry.height;
               }
               if(faccumHeight <= this.fListHeight && this.iListItemsShown < this.uiNumListItems)
               {
                  faccumHeight = faccumHeight + this.fVerticalSpacing;
                  this.iListItemsShown++;
               }
               else if(this.textOption_Inspectable != TEXT_OPTION_MULTILINE)
               {
                  currEntry.itemIndex = int.MAX_VALUE;
                  currEntry.visible = false;
               }
               else
               {
                  this.iListItemsShown++;
               }
            }
            iupdateIndex = this._filterer.GetNextFilterMatch(iupdateIndex);
         }
         if(this.needMobileScrollList)
         {
            this.setMobileScrollingListData(fileteredData);
         }
         this.PositionEntries();
         if(this.ScrollUp != null)
         {
            this.ScrollUp.visible = this.scrollPosition > 0;
         }
         if(this.ScrollDown != null)
         {
            this.ScrollDown.visible = this.scrollPosition < this.iMaxScrollPosition;
         }
         this.bUpdated = true;
      }
      
      protected function PositionEntries() : *
      {
         // method body index: 953 method index: 953
         var clip:BSScrollingListEntry = null;
         var ientryCt:int = 0;
         var faccumHeight:Number = 0;
         var forigY:Number = this.border.y;
         var direction:Number = 1;
         if(this.reverseOrder)
         {
            direction = -1;
         }
         if(this.iListItemsShown > 0)
         {
            if(this.reverseOrder)
            {
               forigY = this.fBorderHeight;
               clip = this.GetClipByIndex(ientryCt);
               if(clip.Sizer_mc)
               {
                  forigY = forigY - clip.Sizer_mc.height;
               }
               else
               {
                  forigY = forigY - clip.height;
               }
            }
            for(ientryCt = 0; ientryCt < this.iListItemsShown; ientryCt++)
            {
               clip = this.GetClipByIndex(ientryCt);
               clip.y = forigY + faccumHeight * direction;
               if(clip.Sizer_mc)
               {
                  faccumHeight = faccumHeight + (clip.Sizer_mc.height + this.fVerticalSpacing);
               }
               else
               {
                  faccumHeight = faccumHeight + (clip.height + this.fVerticalSpacing);
               }
            }
         }
         this.fShownItemsHeight = faccumHeight;
      }
      
      public function InvalidateData() : *
      {
         // method body index: 954 method index: 954
         var iprevFilteredItem:int = 0;
         var prevSelectedClipIndex:int = !!this.bUpdated?int(this.selectedClipIndex):-1;
         var btriggerSelectionChangeEvent:Boolean = false;
         this._filterer.filterArray = this.EntriesA;
         var borderBounds:Object = this.border.getBounds(this);
         var borderPointStart:Point = new Point(borderBounds.x,borderBounds.y);
         var borderPointEnd:Point = new Point(borderBounds.x + borderBounds.width,borderBounds.y + borderBounds.height);
         this.localToGlobal(borderPointStart);
         this.localToGlobal(borderPointEnd);
         this.fListHeight = borderPointEnd.y - borderPointStart.y;
         this.CalculateMaxScrollPosition();
         if(this.iSelectedIndex >= this.EntriesA.length)
         {
            this.iSelectedIndex = this.EntriesA.length - 1;
            btriggerSelectionChangeEvent = true;
         }
         var bFilteredItem:* = false;
         if(!this._filterer.IsValidIndex(this.iSelectedIndex))
         {
            iprevFilteredItem = this._filterer.GetPrevFilterMatch(this.iSelectedIndex);
            if(iprevFilteredItem == int.MAX_VALUE)
            {
               if(this._filterer.GetNextFilterMatch(this.iSelectedIndex) == int.MAX_VALUE)
               {
                  this.iSelectedIndex = -1;
               }
            }
            else
            {
               this.iSelectedIndex = iprevFilteredItem;
               btriggerSelectionChangeEvent = true;
               bFilteredItem = true;
            }
         }
         if(this.iScrollPosition > this.iMaxScrollPosition)
         {
            this.iScrollPosition = this.iMaxScrollPosition;
         }
         this.UpdateList();
         if(prevSelectedClipIndex != -1 && this.restoreListIndex_Inspectable && !this.needMobileScrollList && !bFilteredItem)
         {
            this.selectedClipIndex = prevSelectedClipIndex;
         }
         else if(btriggerSelectionChangeEvent)
         {
            dispatchEvent(new Event(SELECTION_CHANGE,true,true));
         }
      }
      
      public function UpdateSelectedEntry() : *
      {
         // method body index: 955 method index: 955
         var selectedClip:BSScrollingListEntry = null;
         if(this.iSelectedIndex != -1)
         {
            selectedClip = this.FindClipForEntry(this.iSelectedIndex);
            if(selectedClip != null)
            {
               this.SetEntry(selectedClip,this.EntriesA[this.iSelectedIndex]);
            }
         }
      }
      
      public function UpdateEntry(aEntryIndex:int) : *
      {
         // method body index: 956 method index: 956
         var entry:Object = this.EntriesA[aEntryIndex];
         var clip:BSScrollingListEntry = this.FindClipForEntry(aEntryIndex);
         this.SetEntry(clip,entry);
      }
      
      public function onFilterChange() : *
      {
         // method body index: 957 method index: 957
         this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
         this.CalculateMaxScrollPosition();
      }
      
      protected function CalculateMaxScrollPosition() : *
      {
         // method body index: 958 method index: 958
         var faccumHeight:Number = NaN;
         var iLastPageTopIndex:int = 0;
         var inumItemsShown:int = 0;
         var prevTopIndex:int = 0;
         var ioffset:int = 0;
         var iprevInFilterIndex:int = 0;
         var imaxIndex:int = !!this._filterer.EntryMatchesFilter(this.EntriesA[this.EntriesA.length - 1])?int(this.EntriesA.length - 1):int(this._filterer.GetPrevFilterMatch(this.EntriesA.length - 1));
         if(imaxIndex == int.MAX_VALUE)
         {
            this.iMaxScrollPosition = 0;
         }
         else
         {
            faccumHeight = this.GetEntryHeight(imaxIndex);
            iLastPageTopIndex = imaxIndex;
            inumItemsShown = 1;
            while(iLastPageTopIndex != int.MAX_VALUE && faccumHeight < this.fListHeight && inumItemsShown < this.uiNumListItems)
            {
               prevTopIndex = iLastPageTopIndex;
               iLastPageTopIndex = this._filterer.GetPrevFilterMatch(iLastPageTopIndex);
               if(iLastPageTopIndex != int.MAX_VALUE)
               {
                  faccumHeight = faccumHeight + (this.GetEntryHeight(iLastPageTopIndex) + this.fVerticalSpacing);
                  if(faccumHeight < this.fListHeight)
                  {
                     inumItemsShown++;
                  }
                  else
                  {
                     iLastPageTopIndex = prevTopIndex;
                  }
               }
            }
            if(iLastPageTopIndex == int.MAX_VALUE)
            {
               this.iMaxScrollPosition = 0;
            }
            else
            {
               ioffset = 0;
               iprevInFilterIndex = this._filterer.GetPrevFilterMatch(iLastPageTopIndex);
               while(iprevInFilterIndex != int.MAX_VALUE)
               {
                  ioffset++;
                  iprevInFilterIndex = this._filterer.GetPrevFilterMatch(iprevInFilterIndex);
               }
               this.iMaxScrollPosition = ioffset;
            }
         }
      }
      
      protected function GetEntryHeight(aiEntryIndex:Number) : Number
      {
         // method body index: 959 method index: 959
         var tempClip:BSScrollingListEntry = this.GetClipByIndex(0);
         var returnHeight:Number = 0;
         if(tempClip != null)
         {
            if(tempClip.hasDynamicHeight || this.textOption_Inspectable == TEXT_OPTION_MULTILINE)
            {
               this.SetEntry(tempClip,this.EntriesA[aiEntryIndex]);
               if(tempClip.Sizer_mc)
               {
                  returnHeight = tempClip.Sizer_mc.height;
               }
               else
               {
                  returnHeight = tempClip.height;
               }
            }
            else
            {
               returnHeight = tempClip.defaultHeight;
            }
         }
         return returnHeight;
      }
      
      public function moveSelectionUp() : *
      {
         // method body index: 960 method index: 960
         var iprevFilterMatch:Number = NaN;
         var prevScrollPos:* = undefined;
         if(!this.bDisableSelection)
         {
            if(this.selectedIndex > 0)
            {
               iprevFilterMatch = this._filterer.GetPrevFilterMatch(this.selectedIndex);
               if(iprevFilterMatch != int.MAX_VALUE)
               {
                  this.selectedIndex = iprevFilterMatch;
                  this.bMouseDrivenNav = false;
                  dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
               }
            }
         }
         else if(this.bAllowSelectionDisabledListNav)
         {
            prevScrollPos = this.scrollPosition;
            this.scrollPosition = this.scrollPosition - 1;
            if(prevScrollPos != this.scrollPosition)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      public function moveSelectionDown() : *
      {
         // method body index: 961 method index: 961
         var inextFilterMatch:Number = NaN;
         var prevScrollPos:* = undefined;
         if(!this.bDisableSelection)
         {
            if(this.selectedIndex < this.EntriesA.length - 1)
            {
               inextFilterMatch = this._filterer.GetNextFilterMatch(this.selectedIndex);
               if(inextFilterMatch != int.MAX_VALUE)
               {
                  this.selectedIndex = inextFilterMatch;
                  this.bMouseDrivenNav = false;
                  dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
               }
            }
         }
         else if(this.bAllowSelectionDisabledListNav)
         {
            prevScrollPos = this.scrollPosition;
            this.scrollPosition = this.scrollPosition + 1;
            if(prevScrollPos != this.scrollPosition)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      protected function onItemPress() : *
      {
         // method body index: 962 method index: 962
         if(!this.bDisableInput && !this.bDisableSelection && this.iSelectedIndex != -1)
         {
            dispatchEvent(new Event(ITEM_PRESS,true,true));
         }
         else
         {
            dispatchEvent(new Event(LIST_PRESS,true,true));
         }
      }
      
      protected function SetEntry(aEntryClip:BSScrollingListEntry, aEntryObject:Object) : *
      {
         // method body index: 963 method index: 963
         if(aEntryClip != null)
         {
            aEntryClip.selected = aEntryObject == this.selectedEntry;
            try
            {
               aEntryClip.SetEntryText(aEntryObject,this.strTextOption);
            }
            catch(e:Error)
            {
               trace("BSScrollingList::SetEntry -- SetEntryText error: " + e.getStackTrace());
            }
         }
      }
      
      protected function onSetPlatform(event:Event) : *
      {
         // method body index: 964 method index: 964
         var e:PlatformChangeEvent = event as PlatformChangeEvent;
         this.SetPlatform(e.uiPlatform,e.bPS3Switch,e.uiController,e.uiKeyboard);
      }
      
      public function SetPlatform(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : *
      {
         // method body index: 965 method index: 965
         this.uiPlatform = auiPlatform;
         this.uiController = this.uiController;
         this.bMouseDrivenNav = this.uiController == 0?true:false;
      }
      
      protected function createMobileScrollingList() : void
      {
         // method body index: 966 method index: 966
         var maskDimension:Number = NaN;
         var spaceBetweenButtons:Number = NaN;
         var scrollDirection:Number = NaN;
         var linkageId:String = null;
         var clickable:Boolean = false;
         var reversed:Boolean = false;
         if(this._itemRendererClassName != null)
         {
            maskDimension = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).maskDimension;
            spaceBetweenButtons = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).spaceBetweenButtons;
            scrollDirection = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).scrollDirection;
            linkageId = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).linkageId;
            clickable = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).clickable;
            reversed = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).reversed;
            this.scrollList = new MobileScrollList(maskDimension,spaceBetweenButtons,scrollDirection);
            this.scrollList.itemRendererLinkageId = linkageId;
            this.scrollList.noScrollShortList = true;
            this.scrollList.clickable = clickable;
            this.scrollList.endListAlign = reversed;
            this.scrollList.textOption = this.strTextOption;
            this.scrollList.setScrollIndicators(this.ScrollUp,this.ScrollDown);
            this.scrollList.x = 0;
            this.scrollList.y = 0;
            addChild(this.scrollList);
            this.scrollList.addEventListener(MobileScrollList.ITEM_SELECT,this.onMobileScrollListItemSelected,false,0,true);
         }
      }
      
      protected function destroyMobileScrollingList() : void
      {
         // method body index: 967 method index: 967
         if(this.scrollList != null)
         {
            this.scrollList.removeEventListener(MobileScrollList.ITEM_SELECT,this.onMobileScrollListItemSelected);
            removeChild(this.scrollList);
            this.scrollList.destroy();
         }
      }
      
      protected function onMobileScrollListItemSelected(e:EventWithParams) : void
      {
         // method body index: 968 method index: 968
         var renderer:MobileListItemRenderer = e.params.renderer as MobileListItemRenderer;
         if(renderer.data == null)
         {
            return;
         }
         var rendererId:int = renderer.data.id;
         var ioldSelection:* = this.iSelectedIndex;
         this.iSelectedIndex = this.GetEntryFromClipIndex(rendererId);
         for(var i:uint = 0; i < this.EntriesA.length; i++)
         {
            if(this.EntriesA[i] == renderer.data)
            {
               this.iSelectedIndex = i;
               break;
            }
         }
         if(!this.EntriesA[this.iSelectedIndex].isDivider)
         {
            if(ioldSelection != this.iSelectedIndex)
            {
               dispatchEvent(new Event(SELECTION_CHANGE,true,true));
               if(this.scrollList.itemRendererLinkageId == BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID)
               {
                  this.onItemPress();
               }
               dispatchEvent(new Event(MOBILE_ITEM_PRESS,true,true));
            }
            else if(this.scrollList.itemRendererLinkageId == BSScrollingListInterface.RADIO_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.QUEST_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.QUEST_OBJECTIVES_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.INVENTORY_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID)
            {
               this.onItemPress();
            }
         }
      }
      
      protected function setMobileScrollingListData(data:Vector.<Object>) : void
      {
         // method body index: 969 method index: 969
         if(data != null)
         {
            if(data.length > 0)
            {
               this.scrollList.setData(data);
            }
            else
            {
               this.scrollList.invalidateData();
            }
         }
         else
         {
            trace("setMobileScrollingListData::Error: No data received to display List Items!");
         }
      }
   }
}
