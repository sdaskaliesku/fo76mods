package 
{
    import Shared.AS3.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class MenuListInternal extends Shared.AS3.BSScrollingList
    {
        public function MenuListInternal()
        {
            this._menuListData = new Array();
            super();
            return;
        }

        public function get Active():Boolean
        {
            return this._Active;
        }

        public function set Active(arg1:Boolean):*
        {
            this._Active = arg1;
            return;
        }

        public function set itemRendererClassName(arg1:String):void
        {
            _itemRendererClassName = arg1;
            this.InitRendererClass();
            return;
        }

        public function get itemRendererClassName():String
        {
            return _itemRendererClassName;
        }

        public function InitRendererClass():*
        {
            var loc1:*=null;
            if (this.itemRendererClassName) 
            {
                loc1 = flash.utils.getDefinitionByName(this.itemRendererClassName);
                if (loc1 is Class) 
                {
                    ListEntryClass = loc1 as Class;
                }
            }
            return;
        }

        public function get MenuListData():Array
        {
            return this._menuListData;
        }

        public function set MenuListData(arg1:Array):void
        {
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            if (arg1 == null) 
            {
                arg1 = new Array();
            }
            this._menuListData = arg1;
            entryList.splice(0);
            var loc1:*=0;
            while (loc1 < this.MenuListData.length) 
            {
                entryList.push(this.MenuListData[loc1]);
                ++loc1;
            }
            filterer.filterArray = entryList;
            return;
        }

        public function RePopulateList():*
        {
            if (this.hasBeenUpdated && selectedIndex == -1 && this.Active) 
            {
                doSetSelectedIndex(0);
            }
            InvalidateData();
            return;
        }

        public function PopulateList():*
        {
            if (this.hasBeenUpdated && selectedIndex == -1 && this.Active) 
            {
                doSetSelectedIndex(0);
            }
            this.focusRect = false;
            stage.stageFocusRect = false;
            InvalidateData();
            return;
        }

        public function Collapse():*
        {
            this._Collapsed = true;
            var loc1:*=0;
            while (loc1 < entryList.length) 
            {
                entryList[loc1].collapsed = true;
                ++loc1;
            }
            UpdateList();
            return;
        }

        public function Expand():*
        {
            this._Collapsed = false;
            var loc1:*=0;
            while (loc1 < entryList.length) 
            {
                entryList[loc1].collapsed = false;
                ++loc1;
            }
            UpdateList();
            return;
        }

        public function EnableList():*
        {
            var loc1:*=0;
            while (loc1 < entryList.length) 
            {
                entryList[loc1].listDisabled = false;
                ++loc1;
            }
            UpdateList();
            this.disableInput_Inspectable = false;
            return;
        }

        public function DisableList():*
        {
            var loc1:*=0;
            while (loc1 < entryList.length) 
            {
                entryList[loc1].listDisabled = true;
                ++loc1;
            }
            UpdateList();
            this.disableInput_Inspectable = true;
            return;
        }

        protected override function PositionEntries():*
        {
            var loc2:*=null;
            super.PositionEntries();
            var loc1:*=0;
            var loc3:*=0;
            while (loc3 < iListItemsShown) 
            {
                loc2 = GetClipByIndex(loc3);
                loc1 = Math.max(loc2.width, loc1);
                ++loc3;
            }
            border.width = loc1;
            return;
        }

        protected var _Collapsed:Boolean;

        protected var _Active:Boolean=true;

        internal var _menuListData:Array;
    }
}
