 
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

         return this._dataSubscriptionKeyword;
      }
      
      public function set dataSubscriptionKeyword_Inspectable(strNewData:String) : *
      {

         this._dataSubscriptionKeyword = strNewData;
      }
      
      public function set itemRendererClassName_Inspectable(value:String) : void
      {

         SetIsDirty();
         this._itemRendererClassName = value;
      }
      
      public function get itemRendererClassName_Inspectable() : String
      {

         return this._itemRendererClassName;
      }
      
      public function get numItems_Inspectable() : Number
      {

         return this.uiNumItems;
      }
      
      public function set numItems_Inspectable(aNumItems:Number) : *
      {

         this.uiNumItems = aNumItems;
         SetIsDirty();
      }
      
      public function get verticalSpacing_Inspectable() : *
      {

         return this.fVerticalSpacing;
      }
      
      public function set verticalSpacing_Inspectable(afSpacing:Number) : *
      {

         this.fVerticalSpacing = afSpacing;
      }
      
      public function get backgroundHeight_Inspectable() : *
      {

         return this._backgroundHeight;
      }
      
      public function set backgroundHeight_Inspectable(abackgroundHeight:Number) : *
      {

         this._backgroundHeight = abackgroundHeight;
      }
      
      public function get backgroundWidth_Inspectable() : *
      {

         return this._backgroundWidth;
      }
      
      public function set backgroundWidth_Inspectable(abackgroundWidth:Number) : *
      {

         this._backgroundWidth = abackgroundWidth;
      }
      
      public function get backgroundAlpha_Inspectable() : *
      {

         return this._backgroundAlpha;
      }
      
      public function set backgroundAlpha_Inspectable(abackgroundAlpha:Number) : *
      {

         this._backgroundAlpha = abackgroundAlpha;
      }
      
      public function get fixedBackgroundHeight_Inspectable() : *
      {

         return this._fixedBackgroundHeight;
      }
      
      public function set fixedBackgroundHeight_Inspectable(afixedBackgroundHeight:Boolean) : *
      {

         this._fixedBackgroundHeight = afixedBackgroundHeight;
      }
      
      public function get useBackground() : Boolean
      {

         return this._useBackground;
      }
      
      public function set useBackground(abUseBackground:Boolean) : *
      {

         this._useBackground = abUseBackground;
      }
      
      public function get reverseOrder() : Boolean
      {

         return this.List_mc.reverseOrder;
      }
      
      public function set reverseOrder(abFlag:Boolean) : *
      {

         this.List_mc.reverseOrder = abFlag;
      }
      
      public function get disableSelection_Inspectable() : Boolean
      {

         return this.List_mc.disableSelection_Inspectable;
      }
      
      public function set disableSelection_Inspectable(abDisabled:Boolean) : *
      {

         this.List_mc.disableSelection_Inspectable = abDisabled;
         enabled = mouseChildren = mouseEnabled = !abDisabled;
      }
      
      public function get defaultAcceptButton() : BSButtonHintData
      {

         return this._defaultAcceptButton;
      }
      
      public function get defaultBackButton() : BSButtonHintData
      {

         return this._defaultBackButton;
      }
      
      public function OnMenuListDataChanged(arEvent:FromClientDataEvent) : *
      {

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

         stage.focus = this.List_mc;
      }
      
      public function setSelectedIndex(index:Number) : void
      {

         this.List_mc.selectedIndex = index;
         this.List_mc.UpdateSelectedEntry();
      }
      
      public function get selectedIndex() : *
      {

         return this.List_mc.selectedIndex;
      }
      
      public function ChangeDataProvider(newProviderName:String) : void
      {

         this.dataSubscriptionKeyword_Inspectable = newProviderName;
         this.connectDataProvider();
      }
      
      public function connectDataProvider() : *
      {

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

         if(this.List_mc.initialized)
         {
            this.List_mc.PopulateList();
            return;
         }
         throw new Error("MenuList::error Could not initialized BSScrollingList item!");
      }
      
      private function onKeyUp(event:Event) : *
      {

      }
      
      private function onListPlayFocus(event:Event) : *
      {

      }
      
      private function onListSelectionChange(event:Event) : *
      {

         if(this.List_mc.selectedEntry)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_HOVER,this.List_mc.selectedEntry.hoveraction,this.List_mc.selectedEntry.dataKeyword,this.List_mc.selectedEntry.index,this.List_mc.selectedEntry.tooltip,this.List_mc.selectedEntry,true));
         }
      }
      
      private function onListsCreated(event:Event) : *
      {

      }
      
      private function onMenuListAccept(event:Event = null) : *
      {

         if(this.List_mc.selectedEntry != null && this.List_mc.selectedEntry.disabled != true)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_ACCEPT,this.List_mc.selectedEntry.action,this.List_mc.selectedEntry.dataKeyword,this.List_mc.selectedClipIndex,this.List_mc.selectedEntry.tooltip,this.List_mc.selectedEntry,true));
         }
      }
      
      private function onMenuListBack(event:Event = null) : *
      {

         if(this._defaultBackButton && this._defaultBackButton.ButtonVisible && this._defaultBackButton.ButtonEnabled)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_CANCEL,null,null));
         }
      }
      
      public function Collapse() : *
      {

         this.List_mc.Collapse();
         this.updateBackground();
      }
      
      public function Expand() : *
      {

         this.List_mc.Expand();
         this.updateBackground();
      }
      
      public function AddDefaultAcceptButton() : *
      {

         AddButtonHintData(this._defaultAcceptButton);
      }
      
      public function AddDefaultBackButton() : *
      {

         AddButtonHintData(this._defaultBackButton);
      }
      
      public function RemoveDefaultBackButton() : *
      {

         RemoveButtonHintData(this._defaultBackButton);
      }
   }
}
