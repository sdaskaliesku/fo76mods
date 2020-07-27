 
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
         // method body index: 2831 method index: 2831
         this._menuListData = new Array();
         super();
      }
      
      public function get Active() : Boolean
      {
         // method body index: 2829 method index: 2829
         return this._Active;
      }
      
      public function set Active(aActive:Boolean) : *
      {
         // method body index: 2830 method index: 2830
         this._Active = aActive;
      }
      
      public function set itemRendererClassName(value:String) : void
      {
         // method body index: 2832 method index: 2832
         _itemRendererClassName = value;
         this.InitRendererClass();
      }
      
      public function get itemRendererClassName() : String
      {
         // method body index: 2833 method index: 2833
         return _itemRendererClassName;
      }
      
      public function InitRendererClass() : *
      {
         // method body index: 2834 method index: 2834
         var classDef:Object = null;
         if(this.itemRendererClassName)
         {
            classDef = getDefinitionByName(this.itemRendererClassName);
            if(classDef is Class)
            {
               ListEntryClass = classDef as Class;
            }
         }
      }
      
      public function get MenuListData() : Array
      {
         // method body index: 2835 method index: 2835
         return this._menuListData;
      }
      
      public function set MenuListData(aValue:Array) : void
      {
         // method body index: 2836 method index: 2836
         dispatchEvent(new Event(Event.CHANGE));
         if(aValue == null)
         {
            aValue = new Array();
         }
         this._menuListData = aValue;
         entryList.splice(0);
         for(var i:Number = 0; i < this.MenuListData.length; i++)
         {
            entryList.push(this.MenuListData[i]);
         }
         filterer.filterArray = entryList;
      }
      
      public function RePopulateList() : *
      {
         // method body index: 2837 method index: 2837
         if(this.hasBeenUpdated && selectedIndex == -1 && this.Active)
         {
            doSetSelectedIndex(0);
         }
         InvalidateData();
      }
      
      public function PopulateList() : *
      {
         // method body index: 2838 method index: 2838
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
         // method body index: 2839 method index: 2839
         this._Collapsed = true;
         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].collapsed = true;
         }
         UpdateList();
      }
      
      public function Expand() : *
      {
         // method body index: 2840 method index: 2840
         this._Collapsed = false;
         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].collapsed = false;
         }
         UpdateList();
      }
      
      public function EnableList() : *
      {
         // method body index: 2841 method index: 2841
         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].listDisabled = false;
         }
         UpdateList();
         this.disableInput_Inspectable = false;
      }
      
      public function DisableList() : *
      {
         // method body index: 2842 method index: 2842
         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].listDisabled = true;
         }
         UpdateList();
         this.disableInput_Inspectable = true;
      }
      
      override protected function PositionEntries() : *
      {
         // method body index: 2843 method index: 2843
         var clip:BSScrollingListEntry = null;
         super.PositionEntries();
         var maxWidth:Number = 0;
         for(var ientryCt:int = 0; ientryCt < iListItemsShown; ientryCt++)
         {
            clip = GetClipByIndex(ientryCt);
            maxWidth = Math.max(clip.width,maxWidth);
         }
         border.width = maxWidth;
      }
   }
}
