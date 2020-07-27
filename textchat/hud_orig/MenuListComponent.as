 
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
      
      public static const ON_MENULISTCANCEL:String = // method body index: 3458 method index: 3458
      "MenuListCancel";
      
      public static const LIST_INITIALIZED:String = // method body index: 3458 method index: 3458
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
         // method body index: 3484 method index: 3484
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
         // method body index: 3459 method index: 3459
         return this._dataSubscriptionKeyword;
      }
      
      public function set dataSubscriptionKeyword_Inspectable(strNewData:String) : *
      {
         // method body index: 3460 method index: 3460
         this._dataSubscriptionKeyword = strNewData;
      }
      
      public function set itemRendererClassName_Inspectable(value:String) : void
      {
         // method body index: 3461 method index: 3461
         SetIsDirty();
         this._itemRendererClassName = value;
      }
      
      public function get itemRendererClassName_Inspectable() : String
      {
         // method body index: 3462 method index: 3462
         return this._itemRendererClassName;
      }
      
      public function get numItems_Inspectable() : Number
      {
         // method body index: 3463 method index: 3463
         return this.uiNumItems;
      }
      
      public function set numItems_Inspectable(aNumItems:Number) : *
      {
         // method body index: 3464 method index: 3464
         this.uiNumItems = aNumItems;
         SetIsDirty();
      }
      
      public function get verticalSpacing_Inspectable() : *
      {
         // method body index: 3465 method index: 3465
         return this.fVerticalSpacing;
      }
      
      public function set verticalSpacing_Inspectable(afSpacing:Number) : *
      {
         // method body index: 3466 method index: 3466
         this.fVerticalSpacing = afSpacing;
      }
      
      public function get backgroundHeight_Inspectable() : *
      {
         // method body index: 3467 method index: 3467
         return this._backgroundHeight;
      }
      
      public function set backgroundHeight_Inspectable(abackgroundHeight:Number) : *
      {
         // method body index: 3468 method index: 3468
         this._backgroundHeight = abackgroundHeight;
      }
      
      public function get backgroundWidth_Inspectable() : *
      {
         // method body index: 3469 method index: 3469
         return this._backgroundWidth;
      }
      
      public function set backgroundWidth_Inspectable(abackgroundWidth:Number) : *
      {
         // method body index: 3470 method index: 3470
         this._backgroundWidth = abackgroundWidth;
      }
      
      public function get backgroundAlpha_Inspectable() : *
      {
         // method body index: 3471 method index: 3471
         return this._backgroundAlpha;
      }
      
      public function set backgroundAlpha_Inspectable(abackgroundAlpha:Number) : *
      {
         // method body index: 3472 method index: 3472
         this._backgroundAlpha = abackgroundAlpha;
      }
      
      public function get fixedBackgroundHeight_Inspectable() : *
      {
         // method body index: 3473 method index: 3473
         return this._fixedBackgroundHeight;
      }
      
      public function set fixedBackgroundHeight_Inspectable(afixedBackgroundHeight:Boolean) : *
      {
         // method body index: 3474 method index: 3474
         this._fixedBackgroundHeight = afixedBackgroundHeight;
      }
      
      public function get useBackground() : Boolean
      {
         // method body index: 3475 method index: 3475
         return this._useBackground;
      }
      
      public function set useBackground(abUseBackground:Boolean) : *
      {
         // method body index: 3476 method index: 3476
         this._useBackground = abUseBackground;
      }
      
      public function get reverseOrder() : Boolean
      {
         // method body index: 3477 method index: 3477
         return this.List_mc.reverseOrder;
      }
      
      public function set reverseOrder(abFlag:Boolean) : *
      {
         // method body index: 3478 method index: 3478
         this.List_mc.reverseOrder = abFlag;
      }
      
      public function get disableSelection_Inspectable() : Boolean
      {
         // method body index: 3479 method index: 3479
         return this.List_mc.disableSelection_Inspectable;
      }
      
      public function set disableSelection_Inspectable(abDisabled:Boolean) : *
      {
         // method body index: 3480 method index: 3480
         this.List_mc.disableSelection_Inspectable = abDisabled;
         enabled = mouseChildren = mouseEnabled = !abDisabled;
      }
      
      public function get defaultAcceptButton() : BSButtonHintData
      {
         // method body index: 3481 method index: 3481
         return this._defaultAcceptButton;
      }
      
      public function get defaultBackButton() : BSButtonHintData
      {
         // method body index: 3482 method index: 3482
         return this._defaultBackButton;
      }
      
      public function OnMenuListDataChanged(arEvent:FromClientDataEvent) : *
      {
         // method body index: 3483 method index: 3483
         var dataLength:* = undefined;
         var newDataArray:Array = this.m_ListData[this.dataSubscriptionKeyword_Inspectable].dataArray as Array;
         if(newDataArray == null)
         {
            return;
         }
         this.List_mc.MenuListData = newDataArray;
         if(this.List_mc.MenuListData)
         {
            dataLength = newDataArray.length;
            if(dataLength > 0)
            {
               SetIsDirty();
            }
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3485 method index: 3485
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
         // method body index: 3486 method index: 3486
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
         // method body index: 3487 method index: 3487
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
         // method body index: 3488 method index: 3488
         var clip:BSScrollingListEntry = null;
         var clipWidth:Number = NaN;
         var clipHeight:Number = NaN;
         if(contains(this.Rectangle))
         {
            removeChild(this.Rectangle);
            this.Rectangle = null;
         }
         if(this.useBackground)
         {
            clip = this.List_mc.GetClipByIndex(0);
            if(clip)
            {
               clipWidth = clip.width;
               clipHeight = clip.height;
               if(clip.Sizer_mc != null)
               {
                  clipWidth = clip.Sizer_mc.width;
                  clipHeight = clip.Sizer_mc.height;
               }
               this.Rectangle = new Sprite();
               addChild(this.Rectangle);
               this.backgroundWidth_Inspectable = clipWidth;
               this.backgroundHeight_Inspectable = clipHeight * this.List_mc.numListItems_Inspectable;
               this.Rectangle.graphics.beginFill(1580061,this.backgroundAlpha_Inspectable);
               this.Rectangle.graphics.drawRect(0,0,this.backgroundWidth_Inspectable,this.backgroundHeight_Inspectable);
               this.Rectangle.graphics.endFill();
               this.Rectangle.x = clip.x;
               this.Rectangle.y = 0;
               swapChildren(this.Rectangle,this.List_mc);
            }
         }
      }
      
      public function onFocusIn(e:FocusEvent) : void
      {
         // method body index: 3489 method index: 3489
         stage.focus = this.List_mc;
      }
      
      public function setSelectedIndex(index:Number) : void
      {
         // method body index: 3490 method index: 3490
         this.List_mc.selectedIndex = index;
         this.List_mc.UpdateSelectedEntry();
      }
      
      public function get selectedIndex() : *
      {
         // method body index: 3491 method index: 3491
         return this.List_mc.selectedIndex;
      }
      
      public function ChangeDataProvider(newProviderName:String) : void
      {
         // method body index: 3492 method index: 3492
         this.dataSubscriptionKeyword_Inspectable = newProviderName;
         this.connectDataProvider();
      }
      
      public function connectDataProvider() : *
      {
         // method body index: 3493 method index: 3493
         var dataFromClient:UIDataFromClient = BSUIDataManager.GetDataFromClient(this.dataSubscriptionKeyword_Inspectable);
         if(!dataFromClient)
         {
            throw new Error("Couldn\'t get data provider for menu list");
         }
         if(!this.m_ListData)
         {
            this.m_ListData = new Object();
         }
         this.m_ListData[this.dataSubscriptionKeyword_Inspectable] = dataFromClient.data;
         if(this.m_ListSubs[this.dataSubscriptionKeyword_Inspectable] == null)
         {
            this.m_ListSubs[this.dataSubscriptionKeyword_Inspectable] = BSUIDataManager.Subscribe(this.dataSubscriptionKeyword_Inspectable,this.OnMenuListDataChanged);
         }
         this.OnMenuListDataChanged(new FromClientDataEvent(dataFromClient));
      }
      
      public function PopulateList() : *
      {
         // method body index: 3494 method index: 3494
         if(this.List_mc.initialized)
         {
            this.List_mc.PopulateList();
            return;
         }
         throw new Error("MenuList::error Could not initialized BSScrollingList item!");
      }
      
      private function onKeyUp(event:Event) : *
      {
         // method body index: 3495 method index: 3495
      }
      
      private function onListPlayFocus(event:Event) : *
      {
         // method body index: 3496 method index: 3496
      }
      
      private function onListSelectionChange(event:Event) : *
      {
         // method body index: 3497 method index: 3497
         if(this.List_mc.selectedEntry)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_HOVER,this.List_mc.selectedEntry.hoveraction,this.List_mc.selectedEntry.dataKeyword,this.List_mc.selectedEntry.index,this.List_mc.selectedEntry.tooltip,this.List_mc.selectedEntry,true));
         }
      }
      
      private function onListsCreated(event:Event) : *
      {
         // method body index: 3498 method index: 3498
      }
      
      private function onMenuListAccept(event:Event = null) : *
      {
         // method body index: 3499 method index: 3499
         if(this.List_mc.selectedEntry != null && this.List_mc.selectedEntry.disabled != true)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_ACCEPT,this.List_mc.selectedEntry.action,this.List_mc.selectedEntry.dataKeyword,this.List_mc.selectedClipIndex,this.List_mc.selectedEntry.tooltip,this.List_mc.selectedEntry,true));
         }
      }
      
      private function onMenuListBack(event:Event = null) : *
      {
         // method body index: 3500 method index: 3500
         if(this._defaultBackButton && this._defaultBackButton.ButtonVisible && this._defaultBackButton.ButtonEnabled)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_CANCEL,null,null));
         }
      }
      
      public function Collapse() : *
      {
         // method body index: 3501 method index: 3501
         this.List_mc.Collapse();
         this.updateBackground();
      }
      
      public function Expand() : *
      {
         // method body index: 3502 method index: 3502
         this.List_mc.Expand();
         this.updateBackground();
      }
      
      public function AddDefaultAcceptButton() : *
      {
         // method body index: 3503 method index: 3503
         AddButtonHintData(this._defaultAcceptButton);
      }
      
      public function AddDefaultBackButton() : *
      {
         // method body index: 3504 method index: 3504
         AddButtonHintData(this._defaultBackButton);
      }
      
      public function RemoveDefaultBackButton() : *
      {
         // method body index: 3505 method index: 3505
         RemoveButtonHintData(this._defaultBackButton);
      }
   }
}
