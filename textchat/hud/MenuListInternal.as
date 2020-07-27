 
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
         // method body index: 2767 method index: 2767
         this._menuListData = new Array();
         super();
      }
      
      public function get Active() : Boolean
      {
         // method body index: 2768 method index: 2768
         return this._Active;
      }
      
      public function set Active(param1:Boolean) : *
      {
         // method body index: 2769 method index: 2769
         this._Active = param1;
      }
      
      public function set itemRendererClassName(param1:String) : void
      {
         // method body index: 2770 method index: 2770
         _itemRendererClassName = param1;
         this.InitRendererClass();
      }
      
      public function get itemRendererClassName() : String
      {
         // method body index: 2771 method index: 2771
         return _itemRendererClassName;
      }
      
      public function InitRendererClass() : *
      {
         // method body index: 2772 method index: 2772
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
         // method body index: 2773 method index: 2773
         return this._menuListData;
      }
      
      public function set MenuListData(param1:Array) : void
      {
         // method body index: 2774 method index: 2774
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
         // method body index: 2775 method index: 2775
         if(this.hasBeenUpdated && selectedIndex == -1 && this.Active)
         {
            doSetSelectedIndex(0);
         }
         InvalidateData();
      }
      
      public function PopulateList() : *
      {
         // method body index: 2776 method index: 2776
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
         // method body index: 2777 method index: 2777
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
         // method body index: 2778 method index: 2778
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
         // method body index: 2779 method index: 2779
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
         // method body index: 2780 method index: 2780
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
         // method body index: 2781 method index: 2781
         var _loc1_:BSScrollingListEntry = null;
         super.PositionEntries();
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < iListItemsShown)
         {
            _loc1_ = GetClipByIndex(_loc3_);
            _loc2_ = Math.max(_loc1_.width,_loc2_);
            _loc3_++;
         }
         border.width = _loc2_;
      }
   }
}
