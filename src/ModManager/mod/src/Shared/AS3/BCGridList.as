 
package Shared.AS3
{
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.getDefinitionByName;
   
   public class BCGridList extends MovieClip
   {
      
      public static const TEXT_OPTION_NONE:String = // method body index: 388 method index: 388
      "None";
      
      public static const TEXT_OPTION_SHRINK_TO_FIT:String = // method body index: 388 method index: 388
      "Shrink To Fit";
      
      public static const TEXT_OPTION_MULTILINE:String = // method body index: 388 method index: 388
      "Multi-Line";
      
      public static const SELECTION_CHANGE:String = // method body index: 388 method index: 388
      "BCGridList::selectionChange";
      
      public static const ITEM_PRESS:String = // method body index: 388 method index: 388
      "BCGridList::itemPress";
      
      public static const LIST_PRESS:String = // method body index: 388 method index: 388
      "BCGridList::listPress";
      
      public static const MOUSE_OVER_ITEM:String = // method body index: 388 method index: 388
      "BCGridList::mouseOverItem";
      
      public static const LIST_UPDATED:String = // method body index: 388 method index: 388
      "BCGridList::listUpdated";
      
      public static const SELECTION_EDGE_BOUNCE:String = // method body index: 388 method index: 388
      "BCGridList::selectionEdgeBounce";
      
      public static const ITEM_CLICKED:String = // method body index: 388 method index: 388
      "BCGridList::itemClicked";
       
      
      public var Body_mc:MovieClip;
      
      public var ScrollUp_mc:MovieClip;
      
      public var ScrollDown_mc:MovieClip;
      
      public var ScrollLeft_mc:MovieClip;
      
      public var ScrollRight_mc:MovieClip;
      
      public var ScrollVert_mc:BSSlider;
      
      public var ScrollHoriz_mc:BSSlider;
      
      private var EntryHolder_mc:MovieClip;
      
      private var m_ListItemClassName:String = "BSScrollingListEntry";
      
      private var m_ListItemClass:Class;
      
      private var m_MaxRows:uint = 7;
      
      private var m_MaxCols:uint = 1;
      
      private var m_TextBehavior:String;
      
      private var m_ScrollVertical:Boolean = true;
      
      private var m_DisableSelection:Boolean = false;
      
      private var m_DisableInput:Boolean = false;
      
      private var m_WheelSelectionScroll:Boolean = false;
      
      private var m_SelectionScrollLock:Boolean = false;
      
      private var m_SelectionScrollLockOffset:int = 0;
      
      private var m_SelectedIndex:int = -1;
      
      private var m_SelectedClip:BSScrollingListEntry;
      
      private var m_SelectedDisplayIndex:int = -1;
      
      protected var m_DisplayedItemCount:uint = 0;
      
      private var m_MaxDisplayedItems:uint = 0;
      
      protected var m_ListStartIndex:uint = 0;
      
      private var m_ShowSelectedItem:Boolean = true;
      
      private var m_IsDirty:Boolean = false;
      
      private var m_NeedRecalculateScrollMax:Boolean = true;
      
      private var m_NeedRecreateClips:Boolean = false;
      
      protected var m_NeedRedraw:Boolean = true;
      
      private var m_NeedSliderUpdate:Boolean = true;
      
      private var m_QueueSelectUnderMouse:Boolean = false;
      
      private var m_RowScrollPos:uint = 0;
      
      private var m_RowScrollPosMax:int = 0;
      
      private var m_ColScrollPos:uint = 0;
      
      private var m_ColScrollPosMax:int = 0;
      
      private var m_DisplayWidth:Number = 0;
      
      private var m_DisplayHeight:Number = 0;
      
      private var m_LastNavDirection:int = -1;
      
      protected var m_Entries:Array;
      
      protected var m_ClipVector:Vector.<BSScrollingListEntry>;
      
      public function BCGridList()
      {
         // method body index: 428 method index: 428
         super();
         this.m_Entries = [];
         this.m_ClipVector = new Vector.<BSScrollingListEntry>();
         if(this.Body_mc == null)
         {
            throw new Error("BCGridList : Required instance Body_mc null or invalid.");
         }
         this.EntryHolder_mc = new MovieClip();
         this.EntryHolder_mc.name = "EntryHolder_mc";
         this.Body_mc.addChildAt(this.EntryHolder_mc,this.EntryHolder_mc.numChildren);
         if(this.ScrollUp_mc != null)
         {
            this.ScrollUp_mc.visible = false;
         }
         if(this.ScrollDown_mc != null)
         {
            this.ScrollDown_mc.visible = false;
         }
         if(this.ScrollLeft_mc != null)
         {
            this.ScrollLeft_mc.visible = false;
         }
         if(this.ScrollRight_mc != null)
         {
            this.ScrollRight_mc.visible = false;
         }
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         if(this.ScrollHoriz_mc != null)
         {
            this.ScrollHoriz_mc.visible = false;
            this.ScrollHoriz_mc.handleSizeViaContents = true;
         }
         if(this.ScrollVert_mc != null)
         {
            this.ScrollVert_mc.bVertical = true;
            this.ScrollVert_mc.visible = false;
            this.ScrollVert_mc.handleSizeViaContents = true;
         }
      }
      
      public function set showSelectedItem(param1:Boolean) : void
      {
         // method body index: 389 method index: 389
         this.m_ShowSelectedItem = param1;
         this.m_NeedRedraw = true;
         this.setIsDirty();
      }
      
      public function get showSelectedItem() : Boolean
      {
         // method body index: 390 method index: 390
         return this.m_ShowSelectedItem;
      }
      
      public function set maxRows(param1:uint) : void
      {
         // method body index: 391 method index: 391
         this.m_MaxRows = param1;
         this.m_NeedRecreateClips = true;
      }
      
      public function set maxCols(param1:uint) : void
      {
         // method body index: 392 method index: 392
         this.m_MaxCols = param1;
         this.m_NeedRecreateClips = true;
      }
      
      public function set scrollVertical(param1:Boolean) : void
      {
         // method body index: 393 method index: 393
         this.m_ScrollVertical = param1;
         this.m_NeedRecalculateScrollMax = true;
         this.m_NeedRedraw = true;
         this.setIsDirty();
      }
      
      public function get scrollVertical() : Boolean
      {
         // method body index: 394 method index: 394
         return this.m_ScrollVertical;
      }
      
      public function get selectedEntry() : Object
      {
         // method body index: 395 method index: 395
         return this.m_Entries[this.m_SelectedIndex];
      }
      
      public function get rowScrollPos() : int
      {
         // method body index: 396 method index: 396
         return this.m_RowScrollPos;
      }
      
      public function get colScrollPos() : int
      {
         // method body index: 397 method index: 397
         return this.m_ColScrollPos;
      }
      
      public function get displayWidth() : Number
      {
         // method body index: 398 method index: 398
         return this.m_DisplayWidth;
      }
      
      public function get displayHeight() : Number
      {
         // method body index: 399 method index: 399
         return this.m_DisplayHeight;
      }
      
      public function set rowScrollPos(param1:int) : void
      {
         // method body index: 400 method index: 400
         param1 = GlobalFunc.Clamp(param1,0,this.m_RowScrollPosMax);
         if(param1 != this.m_RowScrollPos)
         {
            this.m_RowScrollPos = param1;
            this.m_NeedRedraw = true;
            this.m_NeedSliderUpdate = true;
            this.setIsDirty();
         }
      }
      
      public function set colScrollPos(param1:int) : void
      {
         // method body index: 401 method index: 401
         param1 = GlobalFunc.Clamp(param1,0,this.m_ColScrollPosMax);
         if(param1 != this.m_ColScrollPos)
         {
            this.m_ColScrollPos = param1;
            this.m_NeedRedraw = true;
            this.m_NeedSliderUpdate = true;
            this.setIsDirty();
         }
      }
      
      public function set disableInput(param1:Boolean) : void
      {
         // method body index: 402 method index: 402
         this.m_DisableInput = param1;
      }
      
      public function get selectedCol() : uint
      {
         // method body index: 403 method index: 403
         return this.getColFromIndex(this.m_SelectedIndex);
      }
      
      public function get selectedRow() : uint
      {
         // method body index: 404 method index: 404
         return this.getRowFromIndex(this.m_SelectedIndex);
      }
      
      public function get displayedItemCount() : uint
      {
         // method body index: 405 method index: 405
         return this.m_DisplayedItemCount;
      }
      
      public function get maxDisplayedItems() : uint
      {
         // method body index: 406 method index: 406
         return this.m_MaxDisplayedItems;
      }
      
      public function get entryCount() : uint
      {
         // method body index: 407 method index: 407
         return this.m_Entries.length;
      }
      
      public function get selectedIndex() : int
      {
         // method body index: 408 method index: 408
         return this.m_SelectedIndex;
      }
      
      public function set selectedIndex(param1:int) : *
      {
         // method body index: 409 method index: 409
         var _loc2_:int = GlobalFunc.Clamp(param1,-1,this.m_Entries.length - 1);
         if(_loc2_ != this.m_SelectedIndex)
         {
            this.m_SelectedIndex = _loc2_;
            dispatchEvent(new Event(SELECTION_CHANGE,true,true));
            this.constrainScrollToSelection();
            this.m_NeedRedraw = true;
            this.setIsDirty();
         }
      }
      
      public function get selectedClip() : BSScrollingListEntry
      {
         // method body index: 410 method index: 410
         return this.m_SelectedClip;
      }
      
      public function set listItemClassName(param1:String) : void
      {
         // method body index: 411 method index: 411
         this.m_ListItemClass = getDefinitionByName(param1) as Class;
         this.m_ListItemClassName = param1;
         this.m_NeedRedraw = true;
      }
      
      public function get entryData() : Array
      {
         // method body index: 412 method index: 412
         return this.m_Entries;
      }
      
      public function set entryData(param1:Array) : void
      {
         // method body index: 413 method index: 413
         this.m_Entries = param1;
         this.m_NeedRecalculateScrollMax = true;
         this.m_NeedRedraw = true;
         this.setIsDirty();
      }
      
      public function set needRedraw(param1:*) : void
      {
         // method body index: 414 method index: 414
         this.m_NeedRedraw = param1;
      }
      
      public function set wheelSelectionScroll(param1:Boolean) : void
      {
         // method body index: 415 method index: 415
         this.m_WheelSelectionScroll = param1;
      }
      
      public function get wheelSelectionScroll() : Boolean
      {
         // method body index: 416 method index: 416
         return this.m_WheelSelectionScroll;
      }
      
      public function set selectionScrollLockOffset(param1:int) : void
      {
         // method body index: 417 method index: 417
         this.m_SelectionScrollLockOffset = param1;
      }
      
      public function get selectionScrollLockOffset() : int
      {
         // method body index: 418 method index: 418
         return this.m_SelectionScrollLockOffset;
      }
      
      public function set selectionScrollLock(param1:Boolean) : void
      {
         // method body index: 419 method index: 419
         this.m_SelectionScrollLock = param1;
      }
      
      public function get selectionScrollLock() : Boolean
      {
         // method body index: 420 method index: 420
         return this.m_SelectionScrollLock;
      }
      
      public function get lastNavDirection() : int
      {
         // method body index: 421 method index: 421
         return this.m_LastNavDirection;
      }
      
      private function getRowFromIndex(param1:int) : uint
      {
         // method body index: 422 method index: 422
         if(param1 > 0)
         {
            return Math.floor(param1 / (this.m_MaxCols + this.m_ColScrollPosMax));
         }
         return 0;
      }
      
      private function getColFromIndex(param1:int) : uint
      {
         // method body index: 423 method index: 423
         if(param1 > 0)
         {
            return param1 % (this.m_MaxCols + this.m_ColScrollPosMax);
         }
         return 0;
      }
      
      public function setIsDirty() : void
      {
         // method body index: 424 method index: 424
         if(!this.m_IsDirty)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.m_IsDirty = true;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         // method body index: 425 method index: 425
         this.selectedIndex = this.selectedIndex;
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.m_IsDirty = false;
         if(this.m_NeedRecalculateScrollMax)
         {
            this.calculateListScrollMax();
         }
         if(this.m_NeedRecreateClips)
         {
            this.createEntryClips();
         }
         if(this.m_NeedRedraw || this.m_QueueSelectUnderMouse)
         {
            this.m_ListStartIndex = !!this.m_ScrollVertical?uint(this.m_MaxCols * this.m_RowScrollPos):uint(this.m_MaxRows * this.m_ColScrollPos);
         }
         if(this.m_QueueSelectUnderMouse)
         {
            this.selectItemUnderMouse();
         }
         if(this.m_NeedRedraw)
         {
            this.redrawList();
         }
      }
      
      public function getIndexFromGridPos(param1:uint, param2:uint) : int
      {
         // method body index: 426 method index: 426
         return param1 * this.m_MaxCols + param2;
      }
      
      private function constrainScrollToSelection() : void
      {
         // method body index: 427 method index: 427
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(this.m_NeedRecalculateScrollMax)
         {
            this.calculateListScrollMax();
         }
         if(this.selectedIndex > 0)
         {
            _loc1_ = this.selectedRow;
            _loc2_ = this.selectedCol;
            if(this.m_SelectionScrollLock)
            {
               if(this.m_ScrollVertical)
               {
                  this.rowScrollPos = _loc1_ + this.m_SelectionScrollLockOffset;
               }
               else
               {
                  this.colScrollPos = _loc2_ + this.m_SelectionScrollLockOffset;
               }
            }
            else if(this.m_ScrollVertical)
            {
               _loc3_ = this.m_RowScrollPos;
               _loc4_ = this.m_RowScrollPos + this.m_MaxRows - 1;
               if(_loc1_ < _loc3_)
               {
                  this.rowScrollPos = _loc1_;
               }
               else if(_loc1_ > _loc4_)
               {
                  this.rowScrollPos = _loc1_ - (this.m_MaxRows - 1);
               }
            }
            else
            {
               _loc5_ = this.m_ColScrollPos;
               _loc6_ = this.m_ColScrollPos + this.m_MaxCols - 1;
               if(_loc2_ < _loc5_)
               {
                  this.colScrollPos = _loc2_;
               }
               else if(_loc2_ > _loc6_)
               {
                  this.colScrollPos = _loc2_ - (this.m_MaxCols - 1);
               }
            }
         }
         else
         {
            this.rowScrollPos = 0;
            this.colScrollPos = 0;
         }
      }
      
      public function onKeyDown(param1:KeyboardEvent) : *
      {
         // method body index: 429 method index: 429
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         if(!this.m_DisableInput)
         {
            _loc2_ = this.selectedRow;
            _loc3_ = this.selectedCol;
            _loc4_ = false;
            switch(param1.keyCode)
            {
               case Keyboard.UP:
                  if(_loc2_ > 0)
                  {
                     _loc4_ = true;
                     _loc2_--;
                  }
                  param1.stopPropagation();
                  break;
               case Keyboard.DOWN:
                  if(_loc2_ < this.getRowFromIndex(this.m_Entries.length - 1))
                  {
                     _loc4_ = true;
                     _loc2_++;
                  }
                  param1.stopPropagation();
                  break;
               case Keyboard.LEFT:
                  if(_loc3_ > 0)
                  {
                     _loc4_ = true;
                     _loc3_--;
                  }
                  param1.stopPropagation();
                  break;
               case Keyboard.RIGHT:
                  if(_loc3_ < this.m_MaxCols - 1 + this.m_ColScrollPosMax && this.selectedIndex < this.entryCount - 1)
                  {
                     _loc4_ = true;
                     _loc3_++;
                  }
                  param1.stopPropagation();
            }
            this.m_LastNavDirection = param1.keyCode;
            if(_loc4_)
            {
               this.selectedIndex = this.getIndexFromGridPos(_loc2_,_loc3_);
            }
            else
            {
               dispatchEvent(new Event(SELECTION_EDGE_BOUNCE,true,true));
            }
         }
      }
      
      public function onKeyUp(param1:KeyboardEvent) : *
      {
         // method body index: 430 method index: 430
         if(!this.m_DisableInput && !this.m_DisableSelection && param1.keyCode == Keyboard.ENTER)
         {
            this.onItemPress(param1);
            param1.stopPropagation();
         }
      }
      
      private function onItemClick(param1:Event) : void
      {
         // method body index: 431 method index: 431
         if(this.m_WheelSelectionScroll)
         {
            if((param1.target as BSScrollingListEntry).itemIndex != this.m_SelectedIndex)
            {
               this.selectedIndex = (param1.target as BSScrollingListEntry).itemIndex;
            }
            else
            {
               if(!this.m_DisableInput && !this.m_DisableSelection && this.m_SelectedIndex != -1)
               {
                  dispatchEvent(new Event(ITEM_CLICKED,true,true));
               }
               this.onItemPress(param1);
            }
         }
         else
         {
            if(!this.m_DisableInput && !this.m_DisableSelection && this.m_SelectedIndex != -1)
            {
               dispatchEvent(new Event(ITEM_CLICKED,true,true));
            }
            this.onItemPress(param1);
         }
      }
      
      public function onItemPress(param1:Event) : void
      {
         // method body index: 432 method index: 432
         if(!this.m_DisableInput && !this.m_DisableSelection && this.m_SelectedIndex != -1)
         {
            dispatchEvent(new Event(ITEM_PRESS,true,true));
         }
         else
         {
            dispatchEvent(new Event(LIST_PRESS,true,true));
         }
      }
      
      private function onItemMouseOver(param1:MouseEvent) : void
      {
         // method body index: 433 method index: 433
         if(!this.m_DisableInput && !this.m_DisableSelection && !this.m_WheelSelectionScroll)
         {
            this.selectedIndex = (param1.currentTarget as BSScrollingListEntry).itemIndex;
            dispatchEvent(new Event(MOUSE_OVER_ITEM,true,true));
         }
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         // method body index: 434 method index: 434
         var _loc2_:* = false;
         if(!this.m_DisableInput)
         {
            _loc2_ = param1.delta < 0;
            if(this.m_WheelSelectionScroll)
            {
               if(_loc2_)
               {
                  this.selectedIndex++;
               }
               else if(this.selectedIndex > 0)
               {
                  this.selectedIndex--;
               }
            }
            else
            {
               this.m_QueueSelectUnderMouse = true;
               if(this.m_ScrollVertical)
               {
                  this.scrollRow(_loc2_);
               }
               else
               {
                  this.scrollCol(_loc2_);
               }
            }
            param1.stopPropagation();
         }
      }
      
      public function scrollRow(param1:Boolean, param2:* = false) : void
      {
         // method body index: 435 method index: 435
         var _loc3_:int = !!param1?int(this.m_RowScrollPos + 1):int(this.m_RowScrollPos - 1);
         if(param2)
         {
            if(_loc3_ < 0)
            {
               _loc3_ = this.m_RowScrollPosMax - 1;
            }
            else if(_loc3_ >= this.m_RowScrollPosMax)
            {
               _loc3_ = 0;
            }
         }
         else
         {
            _loc3_ = Math.max(0,_loc3_);
         }
         this.rowScrollPos = _loc3_;
      }
      
      public function scrollCol(param1:Boolean, param2:* = false) : void
      {
         // method body index: 436 method index: 436
         var _loc3_:int = !!param1?int(this.m_ColScrollPos + 1):int(this.m_ColScrollPos - 1);
         if(param2)
         {
            if(_loc3_ < 0)
            {
               _loc3_ = this.m_ColScrollPosMax - 1;
            }
            else if(_loc3_ >= this.m_ColScrollPosMax)
            {
               _loc3_ = 0;
            }
         }
         else
         {
            _loc3_ = Math.max(0,_loc3_);
         }
         this.colScrollPos = _loc3_;
      }
      
      private function onSliderValueChange(param1:CustomEvent) : void
      {
         // method body index: 437 method index: 437
         if(this.m_ScrollVertical && this.ScrollVert_mc != null && param1.target == this.ScrollVert_mc)
         {
            this.rowScrollPos = param1.params as uint;
         }
         if(!this.m_ScrollVertical && this.ScrollHoriz_mc != null && param1.target == this.ScrollHoriz_mc)
         {
            this.colScrollPos = param1.params as uint;
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         // method body index: 442 method index: 442
         var e:Event = param1;
         if(this.ScrollUp_mc != null)
         {
            this.ScrollUp_mc.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):// method body index: 438 method index: 438
            *
            {
               // method body index: 438 method index: 438
               scrollRow(false);
            });
         }
         if(this.ScrollDown_mc != null)
         {
            this.ScrollDown_mc.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):// method body index: 439 method index: 439
            *
            {
               // method body index: 439 method index: 439
               scrollRow(true);
            });
         }
         if(this.ScrollLeft_mc != null)
         {
            this.ScrollLeft_mc.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):// method body index: 440 method index: 440
            *
            {
               // method body index: 440 method index: 440
               scrollCol(false);
            });
         }
         if(this.ScrollRight_mc != null)
         {
            this.ScrollRight_mc.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):// method body index: 441 method index: 441
            *
            {
               // method body index: 441 method index: 441
               scrollCol(true);
            });
         }
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         addEventListener(BSSlider.VALUE_CHANGED,this.onSliderValueChange);
         stage.focus = this;
      }
      
      protected function populateEntryClip(param1:BSScrollingListEntry, param2:Object) : *
      {
         // method body index: 443 method index: 443
         var aEntryClip:BSScrollingListEntry = param1;
         var aEntryData:Object = param2;
         if(aEntryClip != null)
         {
            aEntryClip.selected = aEntryData == this.selectedEntry && this.m_ShowSelectedItem;
            if(aEntryClip.selected)
            {
               this.m_SelectedClip = aEntryClip;
            }
            try
            {
               aEntryClip.SetEntryText(aEntryData,this.m_TextBehavior);
               return;
            }
            catch(e:Error)
            {
               trace("BCGridList::populateEntryClip -- SetEntryText error: " + e.getStackTrace());
               return;
            }
         }
      }
      
      private function calculateListScrollMax() : void
      {
         // method body index: 444 method index: 444
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(this.m_ScrollVertical)
         {
            this.m_ColScrollPosMax = 0;
            _loc1_ = Math.ceil(this.m_Entries.length / this.m_MaxCols);
            this.m_RowScrollPosMax = _loc1_ - this.m_MaxRows;
            if(this.ScrollVert_mc != null)
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
            _loc2_ = Math.ceil(this.m_Entries.length / this.m_MaxRows);
            this.m_ColScrollPosMax = _loc2_ - this.m_MaxCols;
            if(this.ScrollHoriz_mc != null)
            {
               this.ScrollHoriz_mc.dispatchOnValueChange = false;
               this.ScrollHoriz_mc.minValue = 0;
               this.ScrollHoriz_mc.maxValue = this.m_ColScrollPosMax;
               this.ScrollHoriz_mc.dispatchOnValueChange = true;
            }
         }
         this.m_NeedRecalculateScrollMax = false;
         this.m_NeedRedraw = true;
      }
      
      public function clearList() : void
      {
         // method body index: 445 method index: 445
         this.m_Entries.splice(0,this.m_Entries.length);
      }
      
      private function getNewEntryClip() : BSScrollingListEntry
      {
         // method body index: 446 method index: 446
         return new this.m_ListItemClass() as BSScrollingListEntry;
      }
      
      private function createEntryClip(param1:uint, param2:uint, param3:uint) : Boolean
      {
         // method body index: 447 method index: 447
         var _loc4_:BSScrollingListEntry = this.getNewEntryClip();
         if(_loc4_ != null)
         {
            _loc4_.parentClip = this.parent as MovieClip;
            _loc4_.clipIndex = param1;
            _loc4_.clipRow = param2;
            _loc4_.clipCol = param3;
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOver);
            _loc4_.addEventListener(MouseEvent.CLICK,this.onItemClick);
            this.EntryHolder_mc.addChild(_loc4_);
            this.m_ClipVector.push(_loc4_);
            return true;
         }
         trace("BCGridList::createEntryClip -- m_ListItemClass is invalid or does not derive from BSScrollingListEntry.");
         return false;
      }
      
      private function createEntryClips() : void
      {
         // method body index: 448 method index: 448
         var _loc4_:BSScrollingListEntry = null;
         while(this.EntryHolder_mc.numChildren > 0)
         {
            _loc4_ = this.getClipByIndex(0);
            _loc4_.Dtor();
            this.EntryHolder_mc.removeChildAt(0);
         }
         this.m_ClipVector = new Vector.<BSScrollingListEntry>();
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this.m_ScrollVertical)
         {
            _loc2_ = 0;
            while(_loc2_ < this.m_MaxRows)
            {
               _loc3_ = 0;
               while(_loc3_ < this.m_MaxCols)
               {
                  if(this.createEntryClip(_loc1_,_loc2_,_loc3_))
                  {
                     _loc1_++;
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < this.m_MaxCols)
            {
               _loc2_ = 0;
               while(_loc2_ < this.m_MaxRows)
               {
                  if(this.createEntryClip(_loc1_,_loc2_,_loc3_))
                  {
                     _loc1_++;
                  }
                  _loc2_++;
               }
               _loc3_++;
            }
         }
         this.m_MaxDisplayedItems = _loc1_;
         this.m_NeedRecreateClips = false;
      }
      
      public function getClipByIndex(param1:uint) : BSScrollingListEntry
      {
         // method body index: 449 method index: 449
         return param1 < this.EntryHolder_mc.numChildren?this.m_ClipVector[param1] as BSScrollingListEntry:null;
      }
      
      private function updateScrollIndicators() : void
      {
         // method body index: 450 method index: 450
         if(this.ScrollUp_mc != null)
         {
            this.ScrollUp_mc.visible = this.m_ScrollVertical && this.m_RowScrollPos > 0;
         }
         if(this.ScrollDown_mc != null)
         {
            this.ScrollDown_mc.visible = this.m_ScrollVertical && this.m_RowScrollPos < this.m_RowScrollPosMax;
         }
         if(this.ScrollLeft_mc != null)
         {
            this.ScrollLeft_mc.visible = !this.m_ScrollVertical && this.m_ColScrollPos > 0;
         }
         if(this.ScrollRight_mc != null)
         {
            this.ScrollRight_mc.visible = !this.m_ScrollVertical && this.m_ColScrollPos < this.m_ColScrollPosMax;
         }
         if(this.ScrollVert_mc != null)
         {
            if(this.m_ScrollVertical && this.m_RowScrollPosMax > 0)
            {
               if(this.m_NeedSliderUpdate)
               {
                  this.ScrollVert_mc.doSetValue(this.m_RowScrollPos,false);
               }
               this.ScrollVert_mc.visible = true;
            }
            else
            {
               this.ScrollVert_mc.visible = false;
            }
         }
         if(this.ScrollHoriz_mc != null)
         {
            if(!this.m_ScrollVertical && this.m_ColScrollPosMax > 0)
            {
               if(this.m_NeedSliderUpdate)
               {
                  this.ScrollHoriz_mc.doSetValue(this.m_ColScrollPos,false);
               }
               this.ScrollHoriz_mc.visible = true;
            }
            else
            {
               this.ScrollHoriz_mc.visible = false;
            }
         }
         this.m_NeedSliderUpdate = false;
      }
      
      private function selectItemUnderMouse() : void
      {
         // method body index: 451 method index: 451
         var _loc1_:uint = 0;
         var _loc2_:BSScrollingListEntry = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Point = null;
         if(!this.m_DisableSelection && !this.m_DisableInput)
         {
            this.m_QueueSelectUnderMouse = false;
            _loc1_ = 0;
            while(_loc1_ < this.m_MaxDisplayedItems)
            {
               _loc2_ = this.m_ClipVector[_loc1_];
               _loc3_ = _loc2_ as MovieClip;
               if(_loc2_.Sizer_mc != null)
               {
                  _loc3_ = _loc2_.Sizer_mc;
               }
               _loc4_ = localToGlobal(new Point(mouseX,mouseY));
               if(_loc3_.hitTestPoint(_loc4_.x,_loc4_.y,false))
               {
                  this.selectedIndex = this.m_ListStartIndex + _loc1_;
               }
               _loc1_++;
            }
         }
      }
      
      protected function redrawList() : void
      {
         // method body index: 452 method index: 452
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:uint = 0;
         var _loc11_:BSScrollingListEntry = null;
         this.m_DisplayWidth = 0;
         this.m_DisplayHeight = 0;
         this.m_DisplayedItemCount = 0;
         this.m_SelectedClip = null;
         if(this.m_MaxDisplayedItems > 0)
         {
            _loc1_ = this.m_ListStartIndex;
            _loc2_ = this.m_Entries.length;
            _loc3_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = 0;
            while(_loc10_ < this.m_MaxDisplayedItems)
            {
               _loc11_ = this.m_ClipVector[_loc10_];
               if(_loc11_ != null)
               {
                  if(_loc10_ + _loc1_ < _loc2_)
                  {
                     _loc11_.itemIndex = _loc10_ + _loc1_;
                     this.populateEntryClip(_loc11_,this.m_Entries[_loc10_ + _loc1_]);
                     this.m_DisplayedItemCount++;
                     if(_loc11_.Sizer_mc != null)
                     {
                        _loc4_ = _loc11_.Sizer_mc.width;
                        _loc5_ = _loc11_.Sizer_mc.height;
                     }
                     else
                     {
                        _loc4_ = _loc11_.width;
                        _loc5_ = _loc11_.height;
                     }
                     _loc11_.visible = true;
                     _loc11_.x = _loc4_ * _loc11_.clipCol;
                     _loc11_.y = _loc5_ * _loc11_.clipRow;
                     _loc8_ = Math.max(_loc8_,_loc11_.x + _loc4_);
                     _loc9_ = Math.max(_loc9_,_loc11_.y + _loc5_);
                  }
                  else
                  {
                     _loc11_.visible = false;
                     _loc11_.itemIndex = int.MAX_VALUE;
                  }
               }
               _loc10_++;
            }
            this.m_DisplayWidth = _loc8_;
            this.m_DisplayHeight = _loc9_;
            this.updateScrollIndicators();
         }
         else
         {
            trace("BCGridList::redrawList -- List configuration resulted in m_MaxDisplayedItems < 1 (unable to display any items) - " + this.name);
         }
         dispatchEvent(new Event(LIST_UPDATED,true,true));
         this.m_NeedRedraw = false;
      }
   }
}
