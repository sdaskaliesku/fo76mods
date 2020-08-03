package 
{
    import Shared.*;
    import Shared.AS3.*;
    import Shared.AS3.Data.*;
    import Shared.AS3.Events.*;
    import flash.display.*;
    import flash.events.*;
    import scaleform.gfx.*;
    
    public dynamic class MenuListComponent extends Shared.AS3.MenuComponent
    {
        public function MenuListComponent()
        {
            this.Rectangle = new flash.display.Sprite();
            this.m_ListData = new Object();
            this.m_ListSubs = new Object();
            this._defaultAcceptButton = new Shared.AS3.BSButtonHintData("$ACCEPT", "Enter", "PSN_A", "Xenon_A", 1, this.onMenuListAccept);
            this._defaultBackButton = new Shared.AS3.BSButtonHintData("$BACK", "Tab", "PSN_B", "Xenon_B", 1, this.onMenuListBack);
            super();
            scaleform.gfx.Extensions.enabled = true;
            this.AddDefaultBackButton();
            return;
        }

        public function connectDataProvider():*
        {
            var loc1:*=Shared.AS3.Data.BSUIDataManager.GetDataFromClient(this.dataSubscriptionKeyword_Inspectable);
            if (!loc1) 
            {
                throw new Error("Couldn\'t get data provider for menu list");
            }
            if (!this.m_ListData) 
            {
                this.m_ListData = new Object();
            }
            this.m_ListData[this.dataSubscriptionKeyword_Inspectable] = loc1.data;
            if (this.m_ListSubs[this.dataSubscriptionKeyword_Inspectable] == null) 
            {
                this.m_ListSubs[this.dataSubscriptionKeyword_Inspectable] = Shared.AS3.Data.BSUIDataManager.Subscribe(this.dataSubscriptionKeyword_Inspectable, this.OnMenuListDataChanged);
            }
            this.OnMenuListDataChanged(new Shared.AS3.Data.FromClientDataEvent(loc1));
            return;
        }

        public function PopulateList():*
        {
            if (this.List_mc.initialized) 
            {
                this.List_mc.PopulateList();
            }
            else 
            {
                throw new Error("MenuList::error Could not initialized BSScrollingList item!");
            }
            return;
        }

        internal function onKeyUp(arg1:flash.events.Event):*
        {
            return;
        }

        internal function onListPlayFocus(arg1:flash.events.Event):*
        {
            return;
        }

        internal function onListSelectionChange(arg1:flash.events.Event):*
        {
            if (this.List_mc.selectedEntry) 
            {
                dispatchEvent(new Shared.AS3.Events.MenuActionEvent(Shared.AS3.Events.MenuActionEvent.MENU_HOVER, this.List_mc.selectedEntry.hoveraction, this.List_mc.selectedEntry.dataKeyword, this.List_mc.selectedEntry.index, this.List_mc.selectedEntry.tooltip, this.List_mc.selectedEntry, true));
            }
            return;
        }

        internal function onListsCreated(arg1:flash.events.Event):*
        {
            return;
        }

        public function get dataSubscriptionKeyword_Inspectable():String
        {
            return this._dataSubscriptionKeyword;
        }

        public function set dataSubscriptionKeyword_Inspectable(arg1:String):*
        {
            this._dataSubscriptionKeyword = arg1;
            return;
        }

        internal function onMenuListAccept(arg1:flash.events.Event=null):*
        {
            if (!(this.List_mc.selectedEntry == null) && !(this.List_mc.selectedEntry.disabled == true)) 
            {
                dispatchEvent(new Shared.AS3.Events.MenuActionEvent(Shared.AS3.Events.MenuActionEvent.MENU_ACCEPT, this.List_mc.selectedEntry.action, this.List_mc.selectedEntry.dataKeyword, this.List_mc.selectedClipIndex, this.List_mc.selectedEntry.tooltip, this.List_mc.selectedEntry, true));
            }
            return;
        }

        public function set itemRendererClassName_Inspectable(arg1:String):void
        {
            SetIsDirty();
            this._itemRendererClassName = arg1;
            return;
        }

        public function get itemRendererClassName_Inspectable():String
        {
            return this._itemRendererClassName;
        }

        internal function onMenuListBack(arg1:flash.events.Event=null):*
        {
            if (this._defaultBackButton && this._defaultBackButton.ButtonVisible && this._defaultBackButton.ButtonEnabled) 
            {
                dispatchEvent(new Shared.AS3.Events.MenuActionEvent(Shared.AS3.Events.MenuActionEvent.MENU_CANCEL, null, null));
            }
            return;
        }

        public function get numItems_Inspectable():Number
        {
            return this.uiNumItems;
        }

        public function set numItems_Inspectable(arg1:Number):*
        {
            this.uiNumItems = arg1;
            SetIsDirty();
            return;
        }

        public function Collapse():*
        {
            this.List_mc.Collapse();
            this.updateBackground();
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

        public function Expand():*
        {
            this.List_mc.Expand();
            this.updateBackground();
            return;
        }

        public function get backgroundHeight_Inspectable():*
        {
            return this._backgroundHeight;
        }

        public function set backgroundHeight_Inspectable(arg1:Number):*
        {
            this._backgroundHeight = arg1;
            return;
        }

        public function AddDefaultAcceptButton():*
        {
            AddButtonHintData(this._defaultAcceptButton);
            return;
        }

        public function get backgroundWidth_Inspectable():*
        {
            return this._backgroundWidth;
        }

        public function set backgroundWidth_Inspectable(arg1:Number):*
        {
            this._backgroundWidth = arg1;
            return;
        }

        public function set useBackground(arg1:Boolean):*
        {
            this._useBackground = arg1;
            return;
        }

        public function get backgroundAlpha_Inspectable():*
        {
            return this._backgroundAlpha;
        }

        public function set backgroundAlpha_Inspectable(arg1:Number):*
        {
            this._backgroundAlpha = arg1;
            return;
        }

        public function AddDefaultBackButton():*
        {
            AddButtonHintData(this._defaultBackButton);
            return;
        }

        public function get fixedBackgroundHeight_Inspectable():*
        {
            return this._fixedBackgroundHeight;
        }

        public function set fixedBackgroundHeight_Inspectable(arg1:Boolean):*
        {
            this._fixedBackgroundHeight = arg1;
            return;
        }

        public function RemoveDefaultBackButton():*
        {
            RemoveButtonHintData(this._defaultBackButton);
            return;
        }

        public function get useBackground():Boolean
        {
            return this._useBackground;
        }

        public function get defaultBackButton():Shared.AS3.BSButtonHintData
        {
            return this._defaultBackButton;
        }

        public function get reverseOrder():Boolean
        {
            return this.List_mc.reverseOrder;
        }

        public function set reverseOrder(arg1:Boolean):*
        {
            this.List_mc.reverseOrder = arg1;
            return;
        }

        public function get disableSelection_Inspectable():Boolean
        {
            return this.List_mc.disableSelection_Inspectable;
        }

        public function set disableSelection_Inspectable(arg1:Boolean):*
        {
            this.List_mc.disableSelection_Inspectable = arg1;
            var loc1:*;
            mouseEnabled = loc1 = !arg1;
            mouseChildren = loc1 = loc1;
            enabled = loc1;
            return;
        }

        public function get defaultAcceptButton():Shared.AS3.BSButtonHintData
        {
            return this._defaultAcceptButton;
        }

        public function OnMenuListDataChanged(arg1:Shared.AS3.Data.FromClientDataEvent):*
        {
            var loc2:*=undefined;
            var loc1:*=this.m_ListData[this.dataSubscriptionKeyword_Inspectable].dataArray as Array;
            if (loc1 == null) 
            {
                return;
            }
            this.List_mc.MenuListData = loc1;
            if (this.List_mc.MenuListData) 
            {
                loc2 = loc1.length;
                if (loc2 > 0) 
                {
                    SetIsDirty();
                }
            }
            return;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            this.focusRect = false;
            addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp);
            addEventListener(Shared.AS3.BSScrollingList.PLAY_FOCUS_SOUND, this.onListPlayFocus);
            addEventListener(Shared.GlobalFunc.PLAY_FOCUS_SOUND, this.onListPlayFocus);
            addEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE, this.onListSelectionChange);
            addEventListener(Shared.AS3.BSScrollingList.LIST_ITEMS_CREATED, this.onListsCreated);
            addEventListener(flash.events.FocusEvent.FOCUS_IN, this.onFocusIn);
            connectButtonBar();
            SetIsDirty();
            return;
        }

        public override function onLoadedInit():void
        {
            super.onLoadedInit();
            if (!(this.dataSubscriptionKeyword_Inspectable == null) && this.dataSubscriptionKeyword_Inspectable.length > 0) 
            {
                this.connectDataProvider();
            }
            this.List_mc.verticalSpacing_Inspectable = this.verticalSpacing_Inspectable;
            SetIsDirty();
            return;
        }

        public override function redrawUIComponent():void
        {
            super.redrawUIComponent();
            this.List_mc.itemRendererClassName = this.itemRendererClassName_Inspectable;
            this.List_mc.InitRendererClass();
            if (this.numItems_Inspectable != 0) 
            {
                this.List_mc.numListItems_Inspectable = this.numItems_Inspectable;
            }
            else 
            {
                this.List_mc.numListItems_Inspectable = this.List_mc.MenuListData.length;
            }
            this.List_mc.SetNumListItems(this.List_mc.numListItems_Inspectable);
            if (this.List_mc.initialized) 
            {
                this.PopulateList();
                dispatchEvent(new flash.events.Event(LIST_INITIALIZED));
                addEventListener(Shared.AS3.BSScrollingList.ITEM_PRESS, this.onMenuListAccept);
            }
            this.updateBackground();
            return;
        }

        public function updateBackground():*
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (contains(this.Rectangle)) 
            {
                removeChild(this.Rectangle);
                this.Rectangle = null;
            }
            if (this.useBackground) 
            {
                loc1 = this.List_mc.GetClipByIndex(0);
                if (loc1) 
                {
                    loc2 = loc1.width;
                    loc3 = loc1.height;
                    if (loc1.Sizer_mc != null) 
                    {
                        loc2 = loc1.Sizer_mc.width;
                        loc3 = loc1.Sizer_mc.height;
                    }
                    this.Rectangle = new flash.display.Sprite();
                    addChild(this.Rectangle);
                    this.backgroundWidth_Inspectable = loc2;
                    this.backgroundHeight_Inspectable = loc3 * this.List_mc.numListItems_Inspectable;
                    this.Rectangle.graphics.beginFill(1580061, this.backgroundAlpha_Inspectable);
                    this.Rectangle.graphics.drawRect(0, 0, this.backgroundWidth_Inspectable, this.backgroundHeight_Inspectable);
                    this.Rectangle.graphics.endFill();
                    this.Rectangle.x = loc1.x;
                    this.Rectangle.y = 0;
                    swapChildren(this.Rectangle, this.List_mc);
                }
            }
            return;
        }

        public function onFocusIn(arg1:flash.events.FocusEvent):void
        {
            stage.focus = this.List_mc;
            return;
        }

        public function setSelectedIndex(arg1:Number):void
        {
            this.List_mc.selectedIndex = arg1;
            this.List_mc.UpdateSelectedEntry();
            return;
        }

        public function get selectedIndex():*
        {
            return this.List_mc.selectedIndex;
        }

        public function ChangeDataProvider(arg1:String):void
        {
            this.dataSubscriptionKeyword_Inspectable = arg1;
            this.connectDataProvider();
            return;
        }

        public static const ON_MENULISTCANCEL:String="MenuListCancel";

        public static const LIST_INITIALIZED:String="BSScrollingList::ListInitialized";

        public var List_mc:MenuListInternal;

        internal var _bInitialized:Boolean=false;

        internal var Rectangle:flash.display.Sprite;

        internal var m_ListData:Object;

        internal var m_ListSubs:Object;

        internal var _dataSubscriptionKeyword:String="DefaultMenuListData";

        internal var _itemRendererClassName:String="MenuListEntry";

        protected var uiNumItems:Number=0;

        protected var fVerticalSpacing:Number=0;

        protected var _backgroundHeight:Number=0;

        protected var _backgroundWidth:Number=0;

        protected var _fixedBackgroundHeight:Boolean=false;

        protected var _useBackground:Boolean=true;

        internal var _defaultBackButton:Shared.AS3.BSButtonHintData;

        protected var _backgroundAlpha:Number=0.75;

        internal var _defaultAcceptButton:Shared.AS3.BSButtonHintData;
    }
}
