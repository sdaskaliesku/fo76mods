 
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
      
      public static const TEXT_OPTION_NONE:String = // method body index: 341 method index: 341
      "None";
      
      public static const TEXT_OPTION_SHRINK_TO_FIT:String = // method body index: 341 method index: 341
      "Shrink To Fit";
      
      public static const TEXT_OPTION_MULTILINE:String = // method body index: 341 method index: 341
      "Multi-Line";
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT:uint = // method body index: 341 method index: 341
      9;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRL:uint = // method body index: 341 method index: 341
      6;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_SHIFT:uint = // method body index: 341 method index: 341
      3;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_BASE:uint = // method body index: 341 method index: 341
      1;
      
      public static const SELECTION_CHANGE:String = // method body index: 341 method index: 341
      "BSScrollingList::selectionChange";
      
      public static const ITEM_PRESS:String = // method body index: 341 method index: 341
      "BSScrollingList::itemPress";
      
      public static const LIST_PRESS:String = // method body index: 341 method index: 341
      "BSScrollingList::listPress";
      
      public static const LIST_ITEMS_CREATED:String = // method body index: 341 method index: 341
      "BSScrollingList::listItemsCreated";
      
      public static const PLAY_FOCUS_SOUND:String = // method body index: 341 method index: 341
      "BSScrollingList::playFocusSound";
      
      public static const MOBILE_ITEM_PRESS:String = // method body index: 341 method index: 341
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

         return CompanionAppMode.isOn;
      }
      
      public function onComponentInit(param1:Event) : *
      {

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
      
      protected function onStageInit(param1:Event) : *
      {

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
      
      protected function onStageDestruct(param1:Event) : *
      {

         var _loc2_:BSScrollingListEntry = null;
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
         var _loc3_:uint = 0;
         while(_loc3_ < this.EntryHolder_mc.numChildren)
         {
            _loc2_ = this.GetClipByIndex(_loc3_);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.onEntryRollover);
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onEntryPress);
            _loc3_++;
         }
         if(this.needMobileScrollList)
         {
            this.destroyMobileScrollingList();
         }
      }
      
      protected function onRender(param1:Event) : *
      {

         if(!this.bInitialized)
         {
            this.SetNumListItems(this.uiNumListItems);
         }
         removeEventListener(Event.RENDER,this.onRender);
      }
      
      public function onScrollArrowClick(param1:Event) : *
      {

         if(!this.bDisableInput && (!this.bDisableSelection || this.bAllowSelectionDisabledListNav))
         {
            this.doSetSelectedIndex(-1);
            if(param1.target == this.ScrollUp || param1.target.parent == this.ScrollUp)
            {
               this.scrollPosition = this.scrollPosition - 1;
            }
            else if(param1.target == this.ScrollDown || param1.target.parent == this.ScrollDown)
            {
               this.scrollPosition = this.scrollPosition + 1;
            }
            param1.stopPropagation();
         }
      }
      
      public function onEntryRollover(param1:Event) : *
      {

         var _loc2_:* = undefined;
         this.bMouseDrivenNav = true;
         if(!this.bDisableInput && !this.bDisableSelection)
         {
            _loc2_ = this.iSelectedIndex;
            this.doSetSelectedIndex((param1.currentTarget as BSScrollingListEntry).itemIndex);
            if(_loc2_ != this.iSelectedIndex)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      public function onEntryPress(param1:MouseEvent) : *
      {

         param1.stopPropagation();
         this.bMouseDrivenNav = true;
         this.onItemPress();
      }
      
      public function ClearList() : *
      {

         this.EntriesA.splice(0,this.EntriesA.length);
      }
      
      public function GetClipByIndex(param1:uint) : BSScrollingListEntry
      {

         return param1 < this.EntryHolder_mc.numChildren?this.EntryHolder_mc.getChildAt(param1) as BSScrollingListEntry:null;
      }
      
      public function FindClipForEntry(param1:int) : BSScrollingListEntry
      {

         var _loc2_:* = undefined;
         var _loc3_:BSScrollingListEntry = null;
         if(!this.bUpdated)
         {
            trace("WARNING: FindClipForEntry will always fail to find a clip before Update() has been called at least once");
            _loc2_ = new Error();
            trace(_loc2_.getStackTrace());
         }
         if(param1 == -1 || param1 == int.MAX_VALUE || param1 >= this.EntriesA.length)
         {
            return null;
         }
         var _loc4_:BSScrollingListEntry = null;
         var _loc5_:uint = 0;
         while(_loc5_ < this.EntryHolder_mc.numChildren)
         {
            _loc3_ = this.GetClipByIndex(_loc5_);
            if(_loc3_.visible == true && _loc3_.itemIndex == param1)
            {
               _loc4_ = _loc3_;
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function GetEntryFromClipIndex(param1:uint) : int
      {

         var _loc2_:BSScrollingListEntry = this.GetClipByIndex(param1);
         return !!_loc2_?int(int(_loc2_.itemIndex)):-1;
      }
      
      public function onKeyDown(param1:KeyboardEvent) : *
      {

         if(!this.bDisableInput)
         {
            if(param1.keyCode == Keyboard.UP)
            {
               this.moveSelectionUp();
               param1.stopPropagation();
            }
            else if(param1.keyCode == Keyboard.DOWN)
            {
               this.moveSelectionDown();
               param1.stopPropagation();
            }
         }
      }
      
      public function onKeyUp(param1:KeyboardEvent) : *
      {

         if(!this.bDisableInput && !this.bDisableSelection && param1.keyCode == Keyboard.ENTER)
         {
            this.onItemPress();
            param1.stopPropagation();
         }
      }
      
      public function onMouseWheel(param1:MouseEvent) : *
      {

         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(!this.bDisableInput && (!this.bDisableSelection || this.bAllowSelectionDisabledListNav) && this.iMaxScrollPosition > 0)
         {
            _loc2_ = MOUSEWHEEL_SCROLL_DISTANCE_BASE;
            if(param1.ctrlKey && param1.shiftKey)
            {
               _loc2_ = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT,this.numListItems_Inspectable);
            }
            else if(param1.ctrlKey)
            {
               _loc2_ = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRL,this.numListItems_Inspectable);
            }
            else if(param1.shiftKey)
            {
               _loc2_ = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_SHIFT,this.numListItems_Inspectable);
            }
            _loc3_ = this.scrollPosition;
            _loc4_ = _loc3_;
            if(param1.delta < 0)
            {
               _loc4_ = this.scrollPosition + _loc2_;
            }
            else if(param1.delta > 0)
            {
               _loc4_ = this.scrollPosition - _loc2_;
            }
            this.scrollPosition = GlobalFunc.Clamp(_loc4_,0,this.iMaxScrollPosition);
            this.SetFocusUnderMouse();
            param1.stopPropagation();
            if(_loc3_ != this.scrollPosition)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      private function SetFocusUnderMouse() : *
      {

         var _loc1_:BSScrollingListEntry = null;
         var _loc2_:MovieClip = null;
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.iListItemsShown)
         {
            _loc1_ = this.GetClipByIndex(_loc4_);
            _loc2_ = _loc1_.border;
            _loc3_ = localToGlobal(new Point(mouseX,mouseY));
            if(_loc1_.hitTestPoint(_loc3_.x,_loc3_.y,false))
            {
               this.selectedIndex = _loc1_.itemIndex;
            }
            _loc4_++;
         }
      }
      
      public function get hasBeenUpdated() : Boolean
      {

         return this.bUpdated;
      }
      
      public function get mouseDrivenNav() : Boolean
      {

         return this.bMouseDrivenNav;
      }
      
      public function get filterer() : ListFilterer
      {

         return this._filterer;
      }
      
      public function get itemsShown() : uint
      {

         return this.iListItemsShown;
      }
      
      public function get initialized() : Boolean
      {

         return this.bInitialized;
      }
      
      public function get selectedIndex() : int
      {

         return this.iSelectedIndex;
      }
      
      public function set selectedIndex(param1:int) : *
      {

         this.doSetSelectedIndex(param1);
      }
      
      public function get selectedClipIndex() : int
      {

         var _loc1_:BSScrollingListEntry = this.FindClipForEntry(this.iSelectedIndex);
         return _loc1_ != null?int(int(_loc1_.clipIndex)):-1;
      }
      
      public function set selectedClipIndex(param1:int) : *
      {

         this.doSetSelectedIndex(this.GetEntryFromClipIndex(param1));
      }
      
      public function set filterer(param1:ListFilterer) : *
      {

         this._filterer = param1;
      }
      
      public function get shownItemsHeight() : Number
      {

         return this.fShownItemsHeight;
      }
      
      protected function doSetSelectedIndex(param1:int) : *
      {

         var _loc2_:int = 0;
         var _loc3_:BSScrollingListEntry = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:BSScrollingListEntry = null;
         if(!this.bDisableSelection && param1 != this.iSelectedIndex)
         {
            _loc2_ = this.iSelectedIndex;
            this.iSelectedIndex = param1;
            if(this.EntriesA.length == 0)
            {
               this.iSelectedIndex = -1;
            }
            if(_loc2_ != -1 && _loc2_ < this.EntriesA.length)
            {
               _loc3_ = this.FindClipForEntry(_loc2_);
               if(_loc3_ != null)
               {
                  this.SetEntry(_loc3_,this.EntriesA[_loc2_]);
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
               _loc11_ = this.FindClipForEntry(this.iSelectedIndex);
               if(_loc11_ == null)
               {
                  this.InvalidateData();
                  _loc11_ = this.FindClipForEntry(this.iSelectedIndex);
               }
               if(this.iSelectedIndex != -1 && _loc2_ != this.iSelectedIndex)
               {
                  if(_loc11_ != null)
                  {
                     this.SetEntry(_loc11_,this.EntriesA[this.iSelectedIndex]);
                  }
                  else if(this.iListItemsShown > 0)
                  {
                     _loc4_ = this.GetEntryFromClipIndex(0);
                     _loc5_ = this.GetEntryFromClipIndex(this.iListItemsShown - 1);
                     _loc7_ = 0;
                     if(this.iSelectedIndex < _loc4_)
                     {
                        _loc6_ = _loc4_;
                        do
                        {
                           _loc6_ = this._filterer.GetPrevFilterMatch(_loc6_);
                           _loc7_--;
                        }
                        while(_loc6_ != this.iSelectedIndex && _loc6_ != -1 && _loc6_ != int.MAX_VALUE);
                        
                     }
                     else if(this.iSelectedIndex > _loc5_)
                     {
                        _loc6_ = _loc5_;
                        do
                        {
                           _loc6_ = this._filterer.GetNextFilterMatch(_loc6_);
                           _loc7_++;
                        }
                        while(_loc6_ != this.iSelectedIndex && _loc6_ != -1 && _loc6_ != int.MAX_VALUE);
                        
                     }
                     this.scrollPosition = this.scrollPosition + _loc7_;
                  }
                  if(this.textOption_Inspectable == TEXT_OPTION_MULTILINE)
                  {
                     _loc8_ = 0;
                     _loc11_ = this.FindClipForEntry(this.iSelectedIndex);
                     while(_loc8_ < this.uiNumListItems && _loc11_ != null && _loc11_.y + _loc11_.height > this.fListHeight)
                     {
                        this.scrollPosition = this.scrollPosition + 1;
                        _loc11_ = this.FindClipForEntry(this.iSelectedIndex);
                        _loc8_++;
                     }
                     if(_loc8_ == this.uiNumListItems)
                     {
                        throw new Error("Force-exited list selection loop before the selected entry could be fully scrolled on-screen.  Shouldn\'t be possible!");
                     }
                  }
               }
            }
            if(_loc2_ != this.iSelectedIndex)
            {
               dispatchEvent(new Event(SELECTION_CHANGE,true,true));
            }
            if(this.needMobileScrollList)
            {
               if(this.scrollList != null)
               {
                  if(this.iSelectedIndex != -1)
                  {
                     _loc9_ = this.selectedClipIndex;
                     _loc10_ = 0;
                     while(_loc10_ < this.scrollList.data.length)
                     {
                        if(this.EntriesA[this.iSelectedIndex] == this.scrollList.data[_loc10_])
                        {
                           _loc9_ = _loc10_;
                           break;
                        }
                        _loc10_++;
                     }
                     this.scrollList.selectedIndex = _loc9_;
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

         return this.iScrollPosition;
      }
      
      public function get maxScrollPosition() : uint
      {

         return this.iMaxScrollPosition;
      }
      
      public function set scrollPosition(param1:uint) : *
      {

         if(param1 != this.iScrollPosition && param1 >= 0 && param1 <= this.iMaxScrollPosition)
         {
            this.updateScrollPosition(param1);
         }
      }
      
      protected function updateScrollPosition(param1:uint) : *
      {

         this.iScrollPosition = param1;
         this.UpdateList();
      }
      
      public function get selectedEntry() : Object
      {

         return this.EntriesA[this.iSelectedIndex];
      }
      
      public function get entryList() : Array
      {

         return this.EntriesA;
      }
      
      public function set entryList(param1:Array) : *
      {

         this.EntriesA = param1;
         if(this.EntriesA == null)
         {
            this.EntriesA = new Array();
         }
      }
      
      public function get disableInput_Inspectable() : Boolean
      {

         return this.bDisableInput;
      }
      
      public function set disableInput_Inspectable(param1:Boolean) : *
      {

         this.bDisableInput = param1;
      }
      
      public function get textOption_Inspectable() : String
      {

         return this.strTextOption;
      }
      
      public function set textOption_Inspectable(param1:String) : *
      {

         this.strTextOption = param1;
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

         return this.fVerticalSpacing;
      }
      
      public function set verticalSpacing_Inspectable(param1:Number) : *
      {

         this.fVerticalSpacing = param1;
      }
      
      public function get numListItems_Inspectable() : uint
      {

         return this.uiNumListItems;
      }
      
      public function set numListItems_Inspectable(param1:uint) : *
      {

         this.uiNumListItems = param1;
      }
      
      public function get listEntryClass_Inspectable() : String
      {

         return this._itemRendererClassName;
      }
      
      public function set listEntryClass_Inspectable(param1:String) : *
      {

         this.ListEntryClass = getDefinitionByName(param1) as Class;
         this._itemRendererClassName = param1;
      }
      
      public function get restoreListIndex_Inspectable() : Boolean
      {

         return this.bRestoreListIndex;
      }
      
      public function set restoreListIndex_Inspectable(param1:Boolean) : *
      {

         this.bRestoreListIndex = param1;
      }
      
      public function get disableSelection_Inspectable() : Boolean
      {

         return this.bDisableSelection;
      }
      
      public function set disableSelection_Inspectable(param1:Boolean) : *
      {

         this.bDisableSelection = param1;
      }
      
      public function set allowWheelScrollNoSelectionChange(param1:Boolean) : *
      {

         this.bAllowSelectionDisabledListNav = param1;
      }
      
      public function get reverseOrder() : Boolean
      {

         return this.bReverseOrder;
      }
      
      public function set reverseOrder(param1:Boolean) : *
      {

         this.bReverseOrder = param1;
      }
      
      public function SetNumListItems(param1:uint) : *
      {

         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         if(param1 != this._DisplayNumListItems)
         {
            this._DisplayNumListItems = param1;
            if(this.ListEntryClass != null && param1 > 0)
            {
               while(this.EntryHolder_mc.numChildren > 0)
               {
                  this.EntryHolder_mc.removeChildAt(0);
               }
               _loc2_ = 0;
               while(_loc2_ < param1)
               {
                  _loc3_ = this.GetNewListEntry(_loc2_);
                  if(_loc3_ != null)
                  {
                     _loc3_.clipIndex = _loc2_;
                     _loc3_.name = this._itemRendererClassName + _loc2_.toString();
                     _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.onEntryRollover);
                     _loc3_.addEventListener(MouseEvent.CLICK,this.onEntryPress);
                     this.EntryHolder_mc.addChild(_loc3_);
                  }
                  else
                  {
                     trace("BSScrollingList::SetNumListItems -- List Entry Class " + this._itemRendererClassName + " is invalid or does not derive from BSScrollingListEntry.");
                  }
                  _loc2_++;
               }
               this.bInitialized = true;
               dispatchEvent(new Event(LIST_ITEMS_CREATED,true,true));
            }
         }
      }
      
      protected function GetNewListEntry(param1:uint) : BSScrollingListEntry
      {

         return new this.ListEntryClass() as BSScrollingListEntry;
      }
      
      public function UpdateList() : *
      {

         var _loc1_:BSScrollingListEntry = null;
         var _loc2_:BSScrollingListEntry = null;
         var _loc3_:Number = 0;
         var _loc4_:Number = this._filterer.FindArrayIndexOfFilteredPosition(this.iScrollPosition);
         var _loc5_:Number = _loc4_;
         var _loc6_:uint = 0;
         while(_loc6_ < this.uiNumListItems)
         {
            _loc1_ = this.GetClipByIndex(_loc6_);
            if(_loc1_)
            {
               _loc1_.visible = false;
               _loc1_.itemIndex = int.MAX_VALUE;
            }
            _loc6_++;
         }
         var _loc7_:Vector.<Object> = new Vector.<Object>();
         this.iListItemsShown = 0;
         if(this.needMobileScrollList)
         {
            while(_loc5_ != int.MAX_VALUE && _loc5_ != -1 && _loc5_ < this.EntriesA.length && _loc3_ <= this.fListHeight)
            {
               _loc7_.push(this.EntriesA[_loc5_]);
               _loc5_ = this._filterer.GetNextFilterMatch(_loc5_);
            }
         }
         while(_loc4_ != int.MAX_VALUE && _loc4_ != -1 && _loc4_ < this.EntriesA.length && this.iListItemsShown < this.uiNumListItems && _loc3_ <= this.fListHeight)
         {
            _loc2_ = this.GetClipByIndex(this.iListItemsShown);
            if(_loc2_)
            {
               this.SetEntry(_loc2_,this.EntriesA[_loc4_]);
               _loc2_.itemIndex = _loc4_;
               _loc2_.visible = !this.needMobileScrollList;
               if(_loc2_.Sizer_mc)
               {
                  _loc3_ = _loc3_ + _loc2_.Sizer_mc.height;
               }
               else
               {
                  _loc3_ = _loc3_ + _loc2_.height;
               }
               if(_loc3_ <= this.fListHeight && this.iListItemsShown < this.uiNumListItems)
               {
                  _loc3_ = _loc3_ + this.fVerticalSpacing;
                  this.iListItemsShown++;
               }
               else if(this.textOption_Inspectable != TEXT_OPTION_MULTILINE)
               {
                  _loc2_.itemIndex = int.MAX_VALUE;
                  _loc2_.visible = false;
               }
               else
               {
                  this.iListItemsShown++;
               }
            }
            _loc4_ = this._filterer.GetNextFilterMatch(_loc4_);
         }
         if(this.needMobileScrollList)
         {
            this.setMobileScrollingListData(_loc7_);
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

         var _loc1_:BSScrollingListEntry = null;
         var _loc2_:int = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = this.border.y;
         var _loc5_:Number = 1;
         if(this.reverseOrder)
         {
            _loc5_ = -1;
         }
         if(this.iListItemsShown > 0)
         {
            if(this.reverseOrder)
            {
               _loc4_ = this.fBorderHeight;
               _loc1_ = this.GetClipByIndex(_loc2_);
               if(_loc1_.Sizer_mc)
               {
                  _loc4_ = _loc4_ - _loc1_.Sizer_mc.height;
               }
               else
               {
                  _loc4_ = _loc4_ - _loc1_.height;
               }
            }
            _loc2_ = 0;
            while(_loc2_ < this.iListItemsShown)
            {
               _loc1_ = this.GetClipByIndex(_loc2_);
               _loc1_.y = _loc4_ + _loc3_ * _loc5_;
               if(_loc1_.Sizer_mc)
               {
                  _loc3_ = _loc3_ + (_loc1_.Sizer_mc.height + this.fVerticalSpacing);
               }
               else
               {
                  _loc3_ = _loc3_ + (_loc1_.height + this.fVerticalSpacing);
               }
               _loc2_++;
            }
         }
         this.fShownItemsHeight = _loc3_;
      }
      
      public function InvalidateData() : *
      {

         var _loc1_:int = 0;
         var _loc2_:int = !!this.bUpdated?int(int(this.selectedClipIndex)):-1;
         var _loc3_:Boolean = false;
         this._filterer.filterArray = this.EntriesA;
         var _loc4_:Object = this.border.getBounds(this);
         var _loc5_:Point = new Point(_loc4_.x,_loc4_.y);
         var _loc6_:Point = new Point(_loc4_.x + _loc4_.width,_loc4_.y + _loc4_.height);
         this.localToGlobal(_loc5_);
         this.localToGlobal(_loc6_);
         this.fListHeight = _loc6_.y - _loc5_.y;
         this.CalculateMaxScrollPosition();
         if(this.iSelectedIndex >= this.EntriesA.length)
         {
            this.iSelectedIndex = this.EntriesA.length - 1;
            _loc3_ = true;
         }
         var _loc7_:* = false;
         if(!this._filterer.IsValidIndex(this.iSelectedIndex))
         {
            _loc1_ = this._filterer.GetPrevFilterMatch(this.iSelectedIndex);
            if(_loc1_ == int.MAX_VALUE)
            {
               if(this._filterer.GetNextFilterMatch(this.iSelectedIndex) == int.MAX_VALUE)
               {
                  this.iSelectedIndex = -1;
               }
            }
            else
            {
               this.iSelectedIndex = _loc1_;
               _loc3_ = true;
               _loc7_ = true;
            }
         }
         if(this.iScrollPosition > this.iMaxScrollPosition)
         {
            this.iScrollPosition = this.iMaxScrollPosition;
         }
         this.UpdateList();
         if(_loc2_ != -1 && this.restoreListIndex_Inspectable && !this.needMobileScrollList && !_loc7_)
         {
            this.selectedClipIndex = _loc2_;
         }
         else if(_loc3_)
         {
            dispatchEvent(new Event(SELECTION_CHANGE,true,true));
         }
      }
      
      public function UpdateSelectedEntry() : *
      {

         var _loc1_:BSScrollingListEntry = null;
         if(this.iSelectedIndex != -1)
         {
            _loc1_ = this.FindClipForEntry(this.iSelectedIndex);
            if(_loc1_ != null)
            {
               this.SetEntry(_loc1_,this.EntriesA[this.iSelectedIndex]);
            }
         }
      }
      
      public function UpdateEntry(param1:int) : *
      {

         var _loc2_:Object = this.EntriesA[param1];
         var _loc3_:BSScrollingListEntry = this.FindClipForEntry(param1);
         this.SetEntry(_loc3_,_loc2_);
      }
      
      public function onFilterChange() : *
      {

         this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
         this.CalculateMaxScrollPosition();
      }
      
      protected function CalculateMaxScrollPosition() : *
      {

         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = !!this._filterer.EntryMatchesFilter(this.EntriesA[this.EntriesA.length - 1])?int(int(this.EntriesA.length - 1)):int(int(this._filterer.GetPrevFilterMatch(this.EntriesA.length - 1)));
         if(_loc7_ == int.MAX_VALUE)
         {
            this.iMaxScrollPosition = 0;
         }
         else
         {
            _loc1_ = this.GetEntryHeight(_loc7_);
            _loc2_ = _loc7_;
            _loc3_ = 1;
            while(_loc2_ != int.MAX_VALUE && _loc1_ < this.fListHeight && _loc3_ < this.uiNumListItems)
            {
               _loc4_ = _loc2_;
               _loc2_ = this._filterer.GetPrevFilterMatch(_loc2_);
               if(_loc2_ != int.MAX_VALUE)
               {
                  _loc1_ = _loc1_ + (this.GetEntryHeight(_loc2_) + this.fVerticalSpacing);
                  if(_loc1_ < this.fListHeight)
                  {
                     _loc3_++;
                  }
                  else
                  {
                     _loc2_ = _loc4_;
                  }
               }
            }
            if(_loc2_ == int.MAX_VALUE)
            {
               this.iMaxScrollPosition = 0;
            }
            else
            {
               _loc5_ = 0;
               _loc6_ = this._filterer.GetPrevFilterMatch(_loc2_);
               while(_loc6_ != int.MAX_VALUE)
               {
                  _loc5_++;
                  _loc6_ = this._filterer.GetPrevFilterMatch(_loc6_);
               }
               this.iMaxScrollPosition = _loc5_;
            }
         }
      }
      
      protected function GetEntryHeight(param1:Number) : Number
      {

         var _loc2_:BSScrollingListEntry = this.GetClipByIndex(0);
         var _loc3_:Number = 0;
         if(_loc2_ != null)
         {
            if(_loc2_.hasDynamicHeight || this.textOption_Inspectable == TEXT_OPTION_MULTILINE)
            {
               this.SetEntry(_loc2_,this.EntriesA[param1]);
               if(_loc2_.Sizer_mc)
               {
                  _loc3_ = _loc2_.Sizer_mc.height;
               }
               else
               {
                  _loc3_ = _loc2_.height;
               }
            }
            else
            {
               _loc3_ = _loc2_.defaultHeight;
            }
         }
         return _loc3_;
      }
      
      public function moveSelectionUp() : *
      {

         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         if(!this.bDisableSelection)
         {
            if(this.selectedIndex > 0)
            {
               _loc1_ = this._filterer.GetPrevFilterMatch(this.selectedIndex);
               if(_loc1_ != int.MAX_VALUE)
               {
                  this.selectedIndex = _loc1_;
                  this.bMouseDrivenNav = false;
                  dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
               }
            }
         }
         else if(this.bAllowSelectionDisabledListNav)
         {
            _loc2_ = this.scrollPosition;
            this.scrollPosition = this.scrollPosition - 1;
            if(_loc2_ != this.scrollPosition)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      public function moveSelectionDown() : *
      {

         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         if(!this.bDisableSelection)
         {
            if(this.selectedIndex < this.EntriesA.length - 1)
            {
               _loc1_ = this._filterer.GetNextFilterMatch(this.selectedIndex);
               if(_loc1_ != int.MAX_VALUE)
               {
                  this.selectedIndex = _loc1_;
                  this.bMouseDrivenNav = false;
                  dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
               }
            }
         }
         else if(this.bAllowSelectionDisabledListNav)
         {
            _loc2_ = this.scrollPosition;
            this.scrollPosition = this.scrollPosition + 1;
            if(_loc2_ != this.scrollPosition)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      protected function onItemPress() : *
      {

         if(!this.bDisableInput && !this.bDisableSelection && this.iSelectedIndex != -1)
         {
            dispatchEvent(new Event(ITEM_PRESS,true,true));
         }
         else
         {
            dispatchEvent(new Event(LIST_PRESS,true,true));
         }
      }
      
      protected function SetEntry(param1:BSScrollingListEntry, param2:Object) : *
      {

         var aEntryClip:BSScrollingListEntry = param1;
         var aEntryObject:Object = param2;
         if(aEntryClip != null)
         {
            aEntryClip.selected = aEntryObject == this.selectedEntry;
            try
            {
               aEntryClip.SetEntryText(aEntryObject,this.strTextOption);
               return;
            }
            catch(e:Error)
            {
               trace("BSScrollingList::SetEntry -- SetEntryText error: " + e.getStackTrace());
               return;
            }
         }
      }
      
      protected function onSetPlatform(param1:Event) : *
      {

         var _loc2_:PlatformChangeEvent = param1 as PlatformChangeEvent;
         this.SetPlatform(_loc2_.uiPlatform,_loc2_.bPS3Switch,_loc2_.uiController,_loc2_.uiKeyboard);
      }
      
      public function SetPlatform(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {

         this.uiPlatform = param1;
         this.uiController = this.uiController;
         this.bMouseDrivenNav = this.uiController == 0?true:false;
      }
      
      protected function createMobileScrollingList() : void
      {

         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(this._itemRendererClassName != null)
         {
            _loc1_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).maskDimension;
            _loc2_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).spaceBetweenButtons;
            _loc3_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).scrollDirection;
            _loc4_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).linkageId;
            _loc5_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).clickable;
            _loc6_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).reversed;
            this.scrollList = new MobileScrollList(_loc1_,_loc2_,_loc3_);
            this.scrollList.itemRendererLinkageId = _loc4_;
            this.scrollList.noScrollShortList = true;
            this.scrollList.clickable = _loc5_;
            this.scrollList.endListAlign = _loc6_;
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

         if(this.scrollList != null)
         {
            this.scrollList.removeEventListener(MobileScrollList.ITEM_SELECT,this.onMobileScrollListItemSelected);
            removeChild(this.scrollList);
            this.scrollList.destroy();
         }
      }
      
      protected function onMobileScrollListItemSelected(param1:EventWithParams) : void
      {

         var _loc2_:MobileListItemRenderer = param1.params.renderer as MobileListItemRenderer;
         if(_loc2_.data == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.data.id;
         var _loc4_:* = this.iSelectedIndex;
         this.iSelectedIndex = this.GetEntryFromClipIndex(_loc3_);
         var _loc5_:uint = 0;
         while(_loc5_ < this.EntriesA.length)
         {
            if(this.EntriesA[_loc5_] == _loc2_.data)
            {
               this.iSelectedIndex = _loc5_;
               break;
            }
            _loc5_++;
         }
         if(!this.EntriesA[this.iSelectedIndex].isDivider)
         {
            if(_loc4_ != this.iSelectedIndex)
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
      
      protected function setMobileScrollingListData(param1:Vector.<Object>) : void
      {

         if(param1 != null)
         {
            if(param1.length > 0)
            {
               this.scrollList.setData(param1);
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
