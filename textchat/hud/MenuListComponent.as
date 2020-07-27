 
package
{
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.BSScrollingListEntry;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.MenuActionEvent;
   import Shared.AS3.MenuComponent;
   import Shared.GlobalFunc;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import scaleform.gfx.Extensions;
   
   public dynamic class MenuListComponent extends MenuComponent
   {
      
      public static const ON_MENULISTCANCEL:String = // method body index: 3437 method index: 3437
      "MenuListCancel";
      
      public static const LIST_INITIALIZED:String = // method body index: 3437 method index: 3437
      "BSScrollingList::ListInitialized";
       
      
      public var List_mc:MenuListInternal;
      
      private var _bInitialized:Boolean = false;
      
      private var Rectangle:Sprite;
      
      private var m_ListData:Object;
      
      private var m_ListSubs:Object;
      
      private var _dataSubscriptionKeyword:String = "DefaultMenuListData";
      
      private var _itemRendererClassName:String = "MenuListEntry";
      
      protected var uiNumItems:Number = 0;
      
      protected var fVerticalSpacing:Number = 0;
      
      protected var _backgroundHeight:Number = 0;
      
      protected var _backgroundWidth:Number = 0;
      
      protected var _backgroundAlpha:Number = 0.75;
      
      protected var _fixedBackgroundHeight:Boolean = false;
      
      protected var _useBackground:Boolean = true;
      
      private var _defaultAcceptButton:BSButtonHintData;
      
      private var _defaultBackButton:BSButtonHintData;
      
      public function MenuListComponent()
      {
         // method body index: 3438 method index: 3438
         this.Rectangle = new Sprite();
         this.m_ListData = new Object();
         this.m_ListSubs = new Object();
         this._defaultAcceptButton = new BSButtonHintData("$ACCEPT","Enter","PSN_A","Xenon_A",1,this.onMenuListAccept);
         this._defaultBackButton = new BSButtonHintData("$BACK","Tab","PSN_B","Xenon_B",1,this.onMenuListBack);
         super();
         Extensions.enabled = true;
         this.AddDefaultBackButton();
      }
      
      public function get dataSubscriptionKeyword_Inspectable() : String
      {
         // method body index: 3439 method index: 3439
         return this._dataSubscriptionKeyword;
      }
      
      public function set dataSubscriptionKeyword_Inspectable(param1:String) : *
      {
         // method body index: 3440 method index: 3440
         this._dataSubscriptionKeyword = param1;
      }
      
      public function set itemRendererClassName_Inspectable(param1:String) : void
      {
         // method body index: 3441 method index: 3441
         SetIsDirty();
         this._itemRendererClassName = param1;
      }
      
      public function get itemRendererClassName_Inspectable() : String
      {
         // method body index: 3442 method index: 3442
         return this._itemRendererClassName;
      }
      
      public function get numItems_Inspectable() : Number
      {
         // method body index: 3443 method index: 3443
         return this.uiNumItems;
      }
      
      public function set numItems_Inspectable(param1:Number) : *
      {
         // method body index: 3444 method index: 3444
         this.uiNumItems = param1;
         SetIsDirty();
      }
      
      public function get verticalSpacing_Inspectable() : *
      {
         // method body index: 3445 method index: 3445
         return this.fVerticalSpacing;
      }
      
      public function set verticalSpacing_Inspectable(param1:Number) : *
      {
         // method body index: 3446 method index: 3446
         this.fVerticalSpacing = param1;
      }
      
      public function get backgroundHeight_Inspectable() : *
      {
         // method body index: 3447 method index: 3447
         return this._backgroundHeight;
      }
      
      public function set backgroundHeight_Inspectable(param1:Number) : *
      {
         // method body index: 3448 method index: 3448
         this._backgroundHeight = param1;
      }
      
      public function get backgroundWidth_Inspectable() : *
      {
         // method body index: 3449 method index: 3449
         return this._backgroundWidth;
      }
      
      public function set backgroundWidth_Inspectable(param1:Number) : *
      {
         // method body index: 3450 method index: 3450
         this._backgroundWidth = param1;
      }
      
      public function get backgroundAlpha_Inspectable() : *
      {
         // method body index: 3451 method index: 3451
         return this._backgroundAlpha;
      }
      
      public function set backgroundAlpha_Inspectable(param1:Number) : *
      {
         // method body index: 3452 method index: 3452
         this._backgroundAlpha = param1;
      }
      
      public function get fixedBackgroundHeight_Inspectable() : *
      {
         // method body index: 3453 method index: 3453
         return this._fixedBackgroundHeight;
      }
      
      public function set fixedBackgroundHeight_Inspectable(param1:Boolean) : *
      {
         // method body index: 3454 method index: 3454
         this._fixedBackgroundHeight = param1;
      }
      
      public function get useBackground() : Boolean
      {
         // method body index: 3455 method index: 3455
         return this._useBackground;
      }
      
      public function set useBackground(param1:Boolean) : *
      {
         // method body index: 3456 method index: 3456
         this._useBackground = param1;
      }
      
      public function get reverseOrder() : Boolean
      {
         // method body index: 3457 method index: 3457
         return this.List_mc.reverseOrder;
      }
      
      public function set reverseOrder(param1:Boolean) : *
      {
         // method body index: 3458 method index: 3458
         this.List_mc.reverseOrder = param1;
      }
      
      public function get disableSelection_Inspectable() : Boolean
      {
         // method body index: 3459 method index: 3459
         return this.List_mc.disableSelection_Inspectable;
      }
      
      public function set disableSelection_Inspectable(param1:Boolean) : *
      {
         // method body index: 3460 method index: 3460
         this.List_mc.disableSelection_Inspectable = param1;
         enabled = mouseChildren = mouseEnabled = !param1;
      }
      
      public function get defaultAcceptButton() : BSButtonHintData
      {
         // method body index: 3461 method index: 3461
         return this._defaultAcceptButton;
      }
      
      public function get defaultBackButton() : BSButtonHintData
      {
         // method body index: 3462 method index: 3462
         return this._defaultBackButton;
      }
      
      public function OnMenuListDataChanged(param1:FromClientDataEvent) : *
      {
         // method body index: 3463 method index: 3463
         var _loc2_:* = undefined;
         var _loc3_:Array = this.m_ListData[this.dataSubscriptionKeyword_Inspectable].dataArray as Array;
         if(_loc3_ == null)
         {
            return;
         }
         this.List_mc.MenuListData = _loc3_;
         if(this.List_mc.MenuListData)
         {
            _loc2_ = _loc3_.length;
            if(_loc2_ > 0)
            {
               SetIsDirty();
            }
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3464 method index: 3464
         super.onAddedToStage();
         this.focusRect = false;
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         addEventListener(BSScrollingList.PLAY_FOCUS_SOUND,this.onListPlayFocus);
         addEventListener(GlobalFunc.PLAY_FOCUS_SOUND,this.onListPlayFocus);
         addEventListener(BSScrollingList.SELECTION_CHANGE,this.onListSelectionChange);
         addEventListener(BSScrollingList.LIST_ITEMS_CREATED,this.onListsCreated);
         addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         connectButtonBar();
         SetIsDirty();
      }
      
      override public function onLoadedInit() : void
      {
         // method body index: 3465 method index: 3465
         super.onLoadedInit();
         if(this.dataSubscriptionKeyword_Inspectable != null && this.dataSubscriptionKeyword_Inspectable.length > 0)
         {
            this.connectDataProvider();
         }
         this.List_mc.verticalSpacing_Inspectable = this.verticalSpacing_Inspectable;
         SetIsDirty();
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3466 method index: 3466
         super.redrawUIComponent();
         this.List_mc.itemRendererClassName = this.itemRendererClassName_Inspectable;
         this.List_mc.InitRendererClass();
         if(this.numItems_Inspectable == 0)
         {
            this.List_mc.numListItems_Inspectable = this.List_mc.MenuListData.length;
         }
         else
         {
            this.List_mc.numListItems_Inspectable = this.numItems_Inspectable;
         }
         this.List_mc.SetNumListItems(this.List_mc.numListItems_Inspectable);
         if(this.List_mc.initialized)
         {
            this.PopulateList();
            dispatchEvent(new Event(LIST_INITIALIZED));
            addEventListener(BSScrollingList.ITEM_PRESS,this.onMenuListAccept);
         }
         this.updateBackground();
      }
      
      public function updateBackground() : *
      {
         // method body index: 3467 method index: 3467
         var _loc1_:BSScrollingListEntry = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(contains(this.Rectangle))
         {
            removeChild(this.Rectangle);
            this.Rectangle = null;
         }
         if(this.useBackground)
         {
            _loc1_ = this.List_mc.GetClipByIndex(0);
            if(_loc1_)
            {
               _loc2_ = _loc1_.width;
               _loc3_ = _loc1_.height;
               if(_loc1_.Sizer_mc != null)
               {
                  _loc2_ = _loc1_.Sizer_mc.width;
                  _loc3_ = _loc1_.Sizer_mc.height;
               }
               this.Rectangle = new Sprite();
               addChild(this.Rectangle);
               this.backgroundWidth_Inspectable = _loc2_;
               this.backgroundHeight_Inspectable = _loc3_ * this.List_mc.numListItems_Inspectable;
               this.Rectangle.graphics.beginFill(1580061,this.backgroundAlpha_Inspectable);
               this.Rectangle.graphics.drawRect(0,0,this.backgroundWidth_Inspectable,this.backgroundHeight_Inspectable);
               this.Rectangle.graphics.endFill();
               this.Rectangle.x = _loc1_.x;
               this.Rectangle.y = 0;
               swapChildren(this.Rectangle,this.List_mc);
            }
         }
      }
      
      public function onFocusIn(param1:FocusEvent) : void
      {
         // method body index: 3468 method index: 3468
         stage.focus = this.List_mc;
      }
      
      public function setSelectedIndex(param1:Number) : void
      {
         // method body index: 3469 method index: 3469
         this.List_mc.selectedIndex = param1;
         this.List_mc.UpdateSelectedEntry();
      }
      
      public function get selectedIndex() : *
      {
         // method body index: 3470 method index: 3470
         return this.List_mc.selectedIndex;
      }
      
      public function ChangeDataProvider(param1:String) : void
      {
         // method body index: 3471 method index: 3471
         this.dataSubscriptionKeyword_Inspectable = param1;
         this.connectDataProvider();
      }
      
      public function connectDataProvider() : *
      {
         // method body index: 3472 method index: 3472
         var _loc1_:UIDataFromClient = BSUIDataManager.GetDataFromClient(this.dataSubscriptionKeyword_Inspectable);
         if(!_loc1_)
         {
            throw new Error("Couldn\'t get data provider for menu list");
         }
         if(!this.m_ListData)
         {
            this.m_ListData = new Object();
         }
         this.m_ListData[this.dataSubscriptionKeyword_Inspectable] = _loc1_.data;
         if(this.m_ListSubs[this.dataSubscriptionKeyword_Inspectable] == null)
         {
            this.m_ListSubs[this.dataSubscriptionKeyword_Inspectable] = BSUIDataManager.Subscribe(this.dataSubscriptionKeyword_Inspectable,this.OnMenuListDataChanged);
         }
         this.OnMenuListDataChanged(new FromClientDataEvent(_loc1_));
      }
      
      public function PopulateList() : *
      {
         // method body index: 3473 method index: 3473
         if(this.List_mc.initialized)
         {
            this.List_mc.PopulateList();
            return;
         }
         throw new Error("MenuList::error Could not initialized BSScrollingList item!");
      }
      
      private function onKeyUp(param1:Event) : *
      {
         // method body index: 3474 method index: 3474
      }
      
      private function onListPlayFocus(param1:Event) : *
      {
         // method body index: 3475 method index: 3475
      }
      
      private function onListSelectionChange(param1:Event) : *
      {
         // method body index: 3476 method index: 3476
         if(this.List_mc.selectedEntry)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_HOVER,this.List_mc.selectedEntry.hoveraction,this.List_mc.selectedEntry.dataKeyword,this.List_mc.selectedEntry.index,this.List_mc.selectedEntry.tooltip,this.List_mc.selectedEntry,true));
         }
      }
      
      private function onListsCreated(param1:Event) : *
      {
         // method body index: 3477 method index: 3477
      }
      
      private function onMenuListAccept(param1:Event = null) : *
      {
         // method body index: 3478 method index: 3478
         if(this.List_mc.selectedEntry != null && this.List_mc.selectedEntry.disabled != true)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_ACCEPT,this.List_mc.selectedEntry.action,this.List_mc.selectedEntry.dataKeyword,this.List_mc.selectedClipIndex,this.List_mc.selectedEntry.tooltip,this.List_mc.selectedEntry,true));
         }
      }
      
      private function onMenuListBack(param1:Event = null) : *
      {
         // method body index: 3479 method index: 3479
         if(this._defaultBackButton && this._defaultBackButton.ButtonVisible && this._defaultBackButton.ButtonEnabled)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_CANCEL,null,null));
         }
      }
      
      public function Collapse() : *
      {
         // method body index: 3480 method index: 3480
         this.List_mc.Collapse();
         this.updateBackground();
      }
      
      public function Expand() : *
      {
         // method body index: 3481 method index: 3481
         this.List_mc.Expand();
         this.updateBackground();
      }
      
      public function AddDefaultAcceptButton() : *
      {
         // method body index: 3482 method index: 3482
         AddButtonHintData(this._defaultAcceptButton);
      }
      
      public function AddDefaultBackButton() : *
      {
         // method body index: 3483 method index: 3483
         AddButtonHintData(this._defaultBackButton);
      }
      
      public function RemoveDefaultBackButton() : *
      {
         // method body index: 3484 method index: 3484
         RemoveButtonHintData(this._defaultBackButton);
      }
   }
}
