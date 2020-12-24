package
{
import Shared.AS3.BSScrollingList;
import Shared.AS3.BSScrollingListEntry;
import flash.events.Event;
import flash.utils.getDefinitionByName;

public class MenuListInternal extends BSScrollingList
{


    protected var _Collapsed:Boolean;

    protected var _Active:Boolean = true;

    private var _menuListData:Array;

    public function MenuListInternal()
    {
        this._menuListData = new Array();
        super();
    }

    public function get Active() : Boolean
    {
        return this._Active;
    }

    public function set Active(param1:Boolean) : void
    {
        this._Active = param1;
    }

    public function set itemRendererClassName(param1:String) : void
    {
        _itemRendererClassName = param1;
        this.InitRendererClass();
    }

    public function get itemRendererClassName() : String
    {
        return _itemRendererClassName;
    }

    public function InitRendererClass() : *
    {
        var _loc1_:Object = null;
        if(this.itemRendererClassName)
        {
            _loc1_ = getDefinitionByName(this.itemRendererClassName);
            if(_loc1_ is Class)
            {
                ListEntryClass = _loc1_ as Class;
            }
        }
    }

    public function get MenuListData() : Array
    {
        return this._menuListData;
    }

    public function set MenuListData(param1:Array) : void
    {
        dispatchEvent(new Event(Event.CHANGE));
        if(param1 == null)
        {
            param1 = new Array();
        }
        this._menuListData = param1;
        entryList.splice(0);
        var _loc2_:Number = 0;
        while(_loc2_ < this.MenuListData.length)
        {
            entryList.push(this.MenuListData[_loc2_]);
            _loc2_++;
        }
        filterer.filterArray = entryList;
    }

    public function RePopulateList() : *
    {
        if(this.hasBeenUpdated && selectedIndex == -1 && this.Active)
        {
            doSetSelectedIndex(0);
        }
        InvalidateData();
    }

    public function PopulateList() : *
    {
        if(this.hasBeenUpdated && selectedIndex == -1 && this.Active)
        {
            doSetSelectedIndex(0);
        }
        this.focusRect = false;
        stage.stageFocusRect = false;
        InvalidateData();
    }

    public function Collapse() : *
    {
        this._Collapsed = true;
        var _loc1_:Number = 0;
        while(_loc1_ < entryList.length)
        {
            entryList[_loc1_].collapsed = true;
            _loc1_++;
        }
        UpdateList();
    }

    public function Expand() : *
    {
        this._Collapsed = false;
        var _loc1_:Number = 0;
        while(_loc1_ < entryList.length)
        {
            entryList[_loc1_].collapsed = false;
            _loc1_++;
        }
        UpdateList();
    }

    public function EnableList() : *
    {
        var _loc1_:Number = 0;
        while(_loc1_ < entryList.length)
        {
            entryList[_loc1_].listDisabled = false;
            _loc1_++;
        }
        UpdateList();
        this.disableInput_Inspectable = false;
    }

    public function DisableList() : *
    {
        var _loc1_:Number = 0;
        while(_loc1_ < entryList.length)
        {
            entryList[_loc1_].listDisabled = true;
            _loc1_++;
        }
        UpdateList();
        this.disableInput_Inspectable = true;
    }

    override protected function PositionEntries() : *
    {
        var _loc2_:BSScrollingListEntry = null;
        super.PositionEntries();
        var _loc1_:Number = 0;
        var _loc3_:int = 0;
        while(_loc3_ < iListItemsShown)
        {
            _loc2_ = GetClipByIndex(_loc3_);
            _loc1_ = Math.max(_loc2_.width,_loc1_);
            _loc3_++;
        }
        border.width = _loc1_;
    }
}
}
