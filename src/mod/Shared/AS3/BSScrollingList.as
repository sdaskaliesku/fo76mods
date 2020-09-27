 
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
      
      public static const TEXT_OPTION_NONE:String = // method body index: 454 method index: 454
      "None";
      
      public static const TEXT_OPTION_SHRINK_TO_FIT:String = // method body index: 454 method index: 454
      "Shrink To Fit";
      
      public static const TEXT_OPTION_MULTILINE:String = // method body index: 454 method index: 454
      "Multi-Line";
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT:uint = // method body index: 454 method index: 454
      9;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRL:uint = // method body index: 454 method index: 454
      6;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_SHIFT:uint = // method body index: 454 method index: 454
      3;
      
      public static const MOUSEWHEEL_SCROLL_DISTANCE_BASE:uint = // method body index: 454 method index: 454
      1;
      
      public static const SELECTION_CHANGE:String = // method body index: 454 method index: 454
      "BSScrollingList::selectionChange";
      
      public static const ITEM_PRESS:String = // method body index: 454 method index: 454
      "BSScrollingList::itemPress";
      
      public static const LIST_PRESS:String = // method body index: 454 method index: 454
      "BSScrollingList::listPress";
      
      public static const LIST_ITEMS_CREATED:String = // method body index: 454 method index: 454
      "BSScrollingList::listItemsCreated";
      
      public static const PLAY_FOCUS_SOUND:String = // method body index: 454 method index: 454
      "BSScrollingList::playFocusSound";
      
      public static const MOBILE_ITEM_PRESS:String = // method body index: 454 method index: 454
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
         // method body index: 456 method index: 456
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
         // method body index: 455 method index: 455
         return CompanionAppMode.isOn;
      }
      
      public function onComponentInit(param1:Event) : *
      {
         // method body index: 457 method index: 457
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
         // method body index: 458 method index: 458
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
         // method body index: 459 method index: 459
         var _loc3_:BSScrollingListEntry = null;
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
         var _loc2_:uint = 0;
         while(_loc2_ < this.EntryHolder_mc.numChildren)
         {
            _loc3_ = this.GetClipByIndex(_loc2_);
            _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.onEntryRollover);
            _loc3_.removeEventListener(MouseEvent.CLICK,this.onEntryPress);
            _loc2_++;
         }
         if(this.needMobileScrollList)
         {
            this.destroyMobileScrollingList();
         }
      }
      
      protected function onRender(param1:Event) : *
      {
         // method body index: 460 method index: 460
         if(!this.bInitialized)
         {
            this.SetNumListItems(this.uiNumListItems);
         }
         removeEventListener(Event.RENDER,this.onRender);
      }
      
      public function onScrollArrowClick(param1:Event) : *
      {
         // method body index: 461 method index: 461
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
         // method body index: 462 method index: 462
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
         // method body index: 463 method index: 463
         param1.stopPropagation();
         this.bMouseDrivenNav = true;
         this.onItemPress();
      }
      
      public function ClearList() : *
      {
         // method body index: 464 method index: 464
         this.EntriesA.splice(0,this.EntriesA.length);
      }
      
      public function GetClipByIndex(param1:uint) : BSScrollingListEntry
      {
         // method body index: 465 method index: 465
         return param1 < this.EntryHolder_mc.numChildren?this.EntryHolder_mc.getChildAt(param1) as BSScrollingListEntry:null;
      }
      
      public function FindClipForEntry(param1:int) : BSScrollingListEntry
      {
         // method body index: 466 method index: 466
         var _loc4_:* = undefined;
         var _loc5_:BSScrollingListEntry = null;
         if(!this.bUpdated)
         {
            trace("WARNING: FindClipForEntry will always fail to find a clip before Update() has been called at least once");
            _loc4_ = new Error();
            trace(_loc4_.getStackTrace());
         }
         if(param1 == -1 || param1 == int.MAX_VALUE || param1 >= this.EntriesA.length)
         {
            return null;
         }
         var _loc2_:BSScrollingListEntry = null;
         var _loc3_:uint = 0;
         while(_loc3_ < this.EntryHolder_mc.numChildren)
         {
            _loc5_ = this.GetClipByIndex(_loc3_);
            if(_loc5_.visible == true && _loc5_.itemIndex == param1)
            {
               _loc2_ = _loc5_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function GetEntryFromClipIndex(param1:uint) : int
      {
         // method body index: 467 method index: 467
         var _loc2_:BSScrollingListEntry = this.GetClipByIndex(param1);
         return !!_loc2_?int(_loc2_.itemIndex):-1;
      }
      
      public function onKeyDown(param1:KeyboardEvent) : *
      {
         // method body index: 468 method index: 468
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
         // method body index: 469 method index: 469
         if(!this.bDisableInput && !this.bDisableSelection && param1.keyCode == Keyboard.ENTER)
         {
            this.onItemPress();
            param1.stopPropagation();
         }
      }
      
      public function onMouseWheel(param1:MouseEvent) : *
      {
         // method body index: 470 method index: 470
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
         // method body index: 471 method index: 471
         var _loc2_:BSScrollingListEntry = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Point = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.iListItemsShown)
         {
            _loc2_ = this.GetClipByIndex(_loc1_);
            _loc3_ = _loc2_.border;
            _loc4_ = localToGlobal(new Point(mouseX,mouseY));
            if(_loc2_.hitTestPoint(_loc4_.x,_loc4_.y,false))
            {
               this.selectedIndex = _loc2_.itemIndex;
            }
            _loc1_++;
         }
      }
      
      public function get hasBeenUpdated() : Boolean
      {
         // method body index: 472 method index: 472
         return this.bUpdated;
      }
      
      public function get mouseDrivenNav() : Boolean
      {
         // method body index: 473 method index: 473
         return this.bMouseDrivenNav;
      }
      
      public function get filterer() : ListFilterer
      {
         // method body index: 474 method index: 474
         return this._filterer;
      }
      
      public function get itemsShown() : uint
      {
         // method body index: 475 method index: 475
         return this.iListItemsShown;
      }
      
      public function get initialized() : Boolean
      {
         // method body index: 476 method index: 476
         return this.bInitialized;
      }
      
      public function get selectedIndex() : int
      {
         // method body index: 477 method index: 477
         return this.iSelectedIndex;
      }
      
      public function set selectedIndex(param1:int) : *
      {
         // method body index: 478 method index: 478
         this.doSetSelectedIndex(param1);
      }
      
      public function get selectedClipIndex() : int
      {
         // method body index: 479 method index: 479
         var _loc1_:BSScrollingListEntry = this.FindClipForEntry(this.iSelectedIndex);
         return _loc1_ != null?int(_loc1_.clipIndex):-1;
      }
      
      public function set selectedClipIndex(param1:int) : *
      {
         // method body index: 480 method index: 480
         this.doSetSelectedIndex(this.GetEntryFromClipIndex(param1));
      }
      
      public function set filterer(param1:ListFilterer) : *
      {
         // method body index: 481 method index: 481
         this._filterer = param1;
      }
      
      public function get shownItemsHeight() : Number
      {
         // method body index: 482 method index: 482
         return this.fShownItemsHeight;
      }
      
      protected function doSetSelectedIndex(param1:int) : *
      {
         // method body index: 483 method index: 483
         var _loc3_:int = 0;
         var _loc4_:BSScrollingListEntry = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc2_:BSScrollingListEntry = null;
         if(!this.bDisableSelection && param1 != this.iSelectedIndex)
         {
            _loc3_ = this.iSelectedIndex;
            this.iSelectedIndex = param1;
            if(this.EntriesA.length == 0)
            {
               this.iSelectedIndex = -1;
            }
            if(_loc3_ != -1 && _loc3_ < this.EntriesA.length)
            {
               _loc4_ = this.FindClipForEntry(_loc3_);
               if(_loc4_ != null)
               {
                  this.SetEntry(_loc4_,this.EntriesA[_loc3_]);
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
               _loc2_ = this.FindClipForEntry(this.iSelectedIndex);
               if(_loc2_ == null)
               {
                  this.InvalidateData();
                  _loc2_ = this.FindClipForEntry(this.iSelectedIndex);
               }
               if(this.iSelectedIndex != -1 && _loc3_ != this.iSelectedIndex)
               {
                  if(_loc2_ != null)
                  {
                     this.SetEntry(_loc2_,this.EntriesA[this.iSelectedIndex]);
                  }
                  else if(this.iListItemsShown > 0)
                  {
                     _loc5_ = this.GetEntryFromClipIndex(0);
                     _loc6_ = this.GetEntryFromClipIndex(this.iListItemsShown - 1);
                     _loc8_ = 0;
                     if(this.iSelectedIndex < _loc5_)
                     {
                        _loc7_ = _loc5_;
                        do
                        {
                           _loc7_ = this._filterer.GetPrevFilterMatch(_loc7_);
                           _loc8_--;
                        }
                        while(_loc7_ != this.iSelectedIndex && _loc7_ != -1 && _loc7_ != int.MAX_VALUE);
                        
                     }
                     else if(this.iSelectedIndex > _loc6_)
                     {
                        _loc7_ = _loc6_;
                        do
                        {
                           _loc7_ = this._filterer.GetNextFilterMatch(_loc7_);
                           _loc8_++;
                        }
                        while(_loc7_ != this.iSelectedIndex && _loc7_ != -1 && _loc7_ != int.MAX_VALUE);
                        
                     }
                     this.scrollPosition = this.scrollPosition + _loc8_;
                  }
                  if(this.textOption_Inspectable == TEXT_OPTION_MULTILINE)
                  {
                     _loc9_ = 0;
                     _loc2_ = this.FindClipForEntry(this.iSelectedIndex);
                     while(_loc9_ < this.uiNumListItems && _loc2_ != null && _loc2_.y + _loc2_.height > this.fListHeight)
                     {
                        this.scrollPosition = this.scrollPosition + 1;
                        _loc2_ = this.FindClipForEntry(this.iSelectedIndex);
                        _loc9_++;
                     }
                     if(_loc9_ == this.uiNumListItems)
                     {
                        throw new Error("Force-exited list selection loop before the selected entry could be fully scrolled on-screen.  Shouldn\'t be possible!");
                     }
                  }
               }
            }
            if(_loc3_ != this.iSelectedIndex)
            {
               dispatchEvent(new Event(SELECTION_CHANGE,true,true));
            }
            if(this.needMobileScrollList)
            {
               if(this.scrollList != null)
               {
                  if(this.iSelectedIndex != -1)
                  {
                     _loc10_ = this.selectedClipIndex;
                     _loc11_ = 0;
                     while(_loc11_ < this.scrollList.data.length)
                     {
                        if(this.EntriesA[this.iSelectedIndex] == this.scrollList.data[_loc11_])
                        {
                           _loc10_ = _loc11_;
                           break;
                        }
                        _loc11_++;
                     }
                     this.scrollList.selectedIndex = _loc10_;
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
         // method body index: 484 method index: 484
         return this.iScrollPosition;
      }
      
      public function get maxScrollPosition() : uint
      {
         // method body index: 485 method index: 485
         return this.iMaxScrollPosition;
      }
      
      public function set scrollPosition(param1:uint) : *
      {
         // method body index: 486 method index: 486
         if(param1 != this.iScrollPosition && param1 >= 0 && param1 <= this.iMaxScrollPosition)
         {
            this.updateScrollPosition(param1);
         }
      }
      
      protected function updateScrollPosition(param1:uint) : *
      {
         // method body index: 487 method index: 487
         this.iScrollPosition = param1;
         this.UpdateList();
      }
      
      public function get selectedEntry() : Object
      {
         // method body index: 488 method index: 488
         return this.EntriesA[this.iSelectedIndex];
      }
      
      public function get entryList() : Array
      {
         // method body index: 489 method index: 489
         return this.EntriesA;
      }
      
      public function set entryList(param1:Array) : *
      {
         // method body index: 490 method index: 490
         this.EntriesA = param1;
         if(this.EntriesA == null)
         {
            this.EntriesA = new Array();
         }
      }
      
      public function get disableInput_Inspectable() : Boolean
      {
         // method body index: 491 method index: 491
         return this.bDisableInput;
      }
      
      public function set disableInput_Inspectable(param1:Boolean) : *
      {
         // method body index: 492 method index: 492
         this.bDisableInput = param1;
      }
      
      public function get textOption_Inspectable() : String
      {
         // method body index: 493 method index: 493
         return this.strTextOption;
      }
      
      public function set textOption_Inspectable(param1:String) : *
      {
         // method body index: 494 method index: 494
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
         // method body index: 495 method index: 495
         return this.fVerticalSpacing;
      }
      
      public function set verticalSpacing_Inspectable(param1:Number) : *
      {
         // method body index: 496 method index: 496
         this.fVerticalSpacing = param1;
      }
      
      public function get numListItems_Inspectable() : uint
      {
         // method body index: 497 method index: 497
         return this.uiNumListItems;
      }
      
      public function set numListItems_Inspectable(param1:uint) : *
      {
         // method body index: 498 method index: 498
         this.uiNumListItems = param1;
      }
      
      public function get listEntryClass_Inspectable() : String
      {
         // method body index: 499 method index: 499
         return this._itemRendererClassName;
      }
      
      public function set listEntryClass_Inspectable(param1:String) : *
      {
         // method body index: 500 method index: 500
         this.ListEntryClass = getDefinitionByName(param1) as Class;
         this._itemRendererClassName = param1;
      }
      
      public function get restoreListIndex_Inspectable() : Boolean
      {
         // method body index: 501 method index: 501
         return this.bRestoreListIndex;
      }
      
      public function set restoreListIndex_Inspectable(param1:Boolean) : *
      {
         // method body index: 502 method index: 502
         this.bRestoreListIndex = param1;
      }
      
      public function get disableSelection_Inspectable() : Boolean
      {
         // method body index: 503 method index: 503
         return this.bDisableSelection;
      }
      
      public function set disableSelection_Inspectable(param1:Boolean) : *
      {
         // method body index: 504 method index: 504
         this.bDisableSelection = param1;
      }
      
      public function set allowWheelScrollNoSelectionChange(param1:Boolean) : *
      {
         // method body index: 505 method index: 505
         this.bAllowSelectionDisabledListNav = param1;
      }
      
      public function get reverseOrder() : Boolean
      {
         // method body index: 506 method index: 506
         return this.bReverseOrder;
      }
      
      public function set reverseOrder(param1:Boolean) : *
      {
         // method body index: 507 method index: 507
         this.bReverseOrder = param1;
      }
      
      public function SetNumListItems(param1:uint) : *
      {
         // method body index: 508 method index: 508
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
         // method body index: 509 method index: 509
         return new this.ListEntryClass() as BSScrollingListEntry;
      }
      
      public function UpdateList() : *
      {
         // method body index: 510 method index: 510
         var _loc6_:BSScrollingListEntry = null;
         var _loc7_:BSScrollingListEntry = null;
         var _loc1_:Number = 0;
         var _loc2_:Number = this._filterer.FindArrayIndexOfFilteredPosition(this.iScrollPosition);
         var _loc3_:Number = _loc2_;
         var _loc4_:uint = 0;
         while(_loc4_ < this.uiNumListItems)
         {
            _loc6_ = this.GetClipByIndex(_loc4_);
            if(_loc6_)
            {
               _loc6_.visible = false;
               _loc6_.itemIndex = int.MAX_VALUE;
            }
            _loc4_++;
         }
         var _loc5_:Vector.<Object> = new Vector.<Object>();
         this.iListItemsShown = 0;
         if(this.needMobileScrollList)
         {
            while(_loc3_ != int.MAX_VALUE && _loc3_ != -1 && _loc3_ < this.EntriesA.length && _loc1_ <= this.fListHeight)
            {
               _loc5_.push(this.EntriesA[_loc3_]);
               _loc3_ = this._filterer.GetNextFilterMatch(_loc3_);
            }
         }
         while(_loc2_ != int.MAX_VALUE && _loc2_ != -1 && _loc2_ < this.EntriesA.length && this.iListItemsShown < this.uiNumListItems && _loc1_ <= this.fListHeight)
         {
            _loc7_ = this.GetClipByIndex(this.iListItemsShown);
            if(_loc7_)
            {
               this.SetEntry(_loc7_,this.EntriesA[_loc2_]);
               _loc7_.itemIndex = _loc2_;
               _loc7_.visible = !this.needMobileScrollList;
               if(_loc7_.Sizer_mc)
               {
                  _loc1_ = _loc1_ + _loc7_.Sizer_mc.height;
               }
               else
               {
                  _loc1_ = _loc1_ + _loc7_.height;
               }
               if(_loc1_ <= this.fListHeight && this.iListItemsShown < this.uiNumListItems)
               {
                  _loc1_ = _loc1_ + this.fVerticalSpacing;
                  this.iListItemsShown++;
               }
               else if(this.textOption_Inspectable != TEXT_OPTION_MULTILINE)
               {
                  _loc7_.itemIndex = int.MAX_VALUE;
                  _loc7_.visible = false;
               }
               else
               {
                  this.iListItemsShown++;
               }
            }
            _loc2_ = this._filterer.GetNextFilterMatch(_loc2_);
         }
         if(this.needMobileScrollList)
         {
            this.setMobileScrollingListData(_loc5_);
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
         // method body index: 511 method index: 511
         var _loc3_:BSScrollingListEntry = null;
         var _loc5_:int = 0;
         var _loc1_:Number = 0;
         var _loc2_:Number = this.border.y;
         var _loc4_:Number = 1;
         if(this.reverseOrder)
         {
            _loc4_ = -1;
         }
         if(this.iListItemsShown > 0)
         {
            if(this.reverseOrder)
            {
               _loc2_ = this.fBorderHeight;
               _loc3_ = this.GetClipByIndex(_loc5_);
               if(_loc3_.Sizer_mc)
               {
                  _loc2_ = _loc2_ - _loc3_.Sizer_mc.height;
               }
               else
               {
                  _loc2_ = _loc2_ - _loc3_.height;
               }
            }
            _loc5_ = 0;
            while(_loc5_ < this.iListItemsShown)
            {
               _loc3_ = this.GetClipByIndex(_loc5_);
               _loc3_.y = _loc2_ + _loc1_ * _loc4_;
               if(_loc3_.Sizer_mc)
               {
                  _loc1_ = _loc1_ + (_loc3_.Sizer_mc.height + this.fVerticalSpacing);
               }
               else
               {
                  _loc1_ = _loc1_ + (_loc3_.height + this.fVerticalSpacing);
               }
               _loc5_++;
            }
         }
         this.fShownItemsHeight = _loc1_;
      }
      
      public function InvalidateData() : *
      {
         // method body index: 512 method index: 512
         var _loc7_:int = 0;
         var _loc1_:int = !!this.bUpdated?int(this.selectedClipIndex):-1;
         var _loc2_:Boolean = false;
         this._filterer.filterArray = this.EntriesA;
         var _loc3_:Object = this.border.getBounds(this);
         var _loc4_:Point = new Point(_loc3_.x,_loc3_.y);
         var _loc5_:Point = new Point(_loc3_.x + _loc3_.width,_loc3_.y + _loc3_.height);
         this.localToGlobal(_loc4_);
         this.localToGlobal(_loc5_);
         this.fListHeight = _loc5_.y - _loc4_.y;
         this.CalculateMaxScrollPosition();
         if(this.iSelectedIndex >= this.EntriesA.length)
         {
            this.iSelectedIndex = this.EntriesA.length - 1;
            _loc2_ = true;
         }
         var _loc6_:* = false;
         if(!this._filterer.IsValidIndex(this.iSelectedIndex))
         {
            _loc7_ = this._filterer.GetPrevFilterMatch(this.iSelectedIndex);
            if(_loc7_ == int.MAX_VALUE)
            {
               if(this._filterer.GetNextFilterMatch(this.iSelectedIndex) == int.MAX_VALUE)
               {
                  this.iSelectedIndex = -1;
               }
            }
            else
            {
               this.iSelectedIndex = _loc7_;
               _loc2_ = true;
               _loc6_ = true;
            }
         }
         if(this.iScrollPosition > this.iMaxScrollPosition)
         {
            this.iScrollPosition = this.iMaxScrollPosition;
         }
         this.UpdateList();
         if(_loc1_ != -1 && this.restoreListIndex_Inspectable && !this.needMobileScrollList && !_loc6_)
         {
            this.selectedClipIndex = _loc1_;
         }
         else if(_loc2_)
         {
            dispatchEvent(new Event(SELECTION_CHANGE,true,true));
         }
      }
      
      public function UpdateSelectedEntry() : *
      {
         // method body index: 513 method index: 513
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
         // method body index: 514 method index: 514
         var _loc2_:Object = this.EntriesA[param1];
         var _loc3_:BSScrollingListEntry = this.FindClipForEntry(param1);
         this.SetEntry(_loc3_,_loc2_);
      }
      
      public function onFilterChange() : *
      {
         // method body index: 515 method index: 515
         this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
         this.CalculateMaxScrollPosition();
      }
      
      protected function CalculateMaxScrollPosition() : *
      {
         // method body index: 516 method index: 516
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = !!this._filterer.EntryMatchesFilter(this.EntriesA[this.EntriesA.length - 1])?int(this.EntriesA.length - 1):int(this._filterer.GetPrevFilterMatch(this.EntriesA.length - 1));
         if(_loc1_ == int.MAX_VALUE)
         {
            this.iMaxScrollPosition = 0;
         }
         else
         {
            _loc2_ = this.GetEntryHeight(_loc1_);
            _loc3_ = _loc1_;
            _loc4_ = 1;
            while(_loc3_ != int.MAX_VALUE && _loc2_ < this.fListHeight && _loc4_ < this.uiNumListItems)
            {
               _loc5_ = _loc3_;
               _loc3_ = this._filterer.GetPrevFilterMatch(_loc3_);
               if(_loc3_ != int.MAX_VALUE)
               {
                  _loc2_ = _loc2_ + (this.GetEntryHeight(_loc3_) + this.fVerticalSpacing);
                  if(_loc2_ < this.fListHeight)
                  {
                     _loc4_++;
                  }
                  else
                  {
                     _loc3_ = _loc5_;
                  }
               }
            }
            if(_loc3_ == int.MAX_VALUE)
            {
               this.iMaxScrollPosition = 0;
            }
            else
            {
               _loc6_ = 0;
               _loc7_ = this._filterer.GetPrevFilterMatch(_loc3_);
               while(_loc7_ != int.MAX_VALUE)
               {
                  _loc6_++;
                  _loc7_ = this._filterer.GetPrevFilterMatch(_loc7_);
               }
               this.iMaxScrollPosition = _loc6_;
            }
         }
      }
      
      protected function GetEntryHeight(param1:Number) : Number
      {
         // method body index: 517 method index: 517
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
         // method body index: 518 method index: 518
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
         // method body index: 519 method index: 519
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
         // method body index: 520 method index: 520
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
         // method body index: 521 method index: 521
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
         // method body index: 522 method index: 522
         var _loc2_:PlatformChangeEvent = param1 as PlatformChangeEvent;
         this.SetPlatform(_loc2_.uiPlatform,_loc2_.bPS3Switch,_loc2_.uiController,_loc2_.uiKeyboard);
      }
      
      public function SetPlatform(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {
         // method body index: 523 method index: 523
         this.uiPlatform = param1;
         this.uiController = this.uiController;
         this.bMouseDrivenNav = this.uiController == 0?true:false;
      }
      
      protected function createMobileScrollingList() : void
      {
         // method body index: 524 method index: 524
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
         // method body index: 525 method index: 525
         if(this.scrollList != null)
         {
            this.scrollList.removeEventListener(MobileScrollList.ITEM_SELECT,this.onMobileScrollListItemSelected);
            removeChild(this.scrollList);
            this.scrollList.destroy();
         }
      }
      
      protected function onMobileScrollListItemSelected(param1:EventWithParams) : void
      {
         // method body index: 526 method index: 526
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
         // method body index: 527 method index: 527
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
