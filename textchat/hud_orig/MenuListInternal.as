 
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
      
      public function set Active(aActive:Boolean) : *
      {

         this._Active = aActive;
      }
      
      public function set itemRendererClassName(value:String) : void
      {

         _itemRendererClassName = value;
         this.InitRendererClass();
      }
      
      public function get itemRendererClassName() : String
      {

         return _itemRendererClassName;
      }
      
      public function InitRendererClass() : *
      {

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

         return this._menuListData;
      }
      
      public function set MenuListData(aValue:Array) : void
      {

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
         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].collapsed = true;
         }
         UpdateList();
      }
      
      public function Expand() : *
      {

         this._Collapsed = false;
         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].collapsed = false;
         }
         UpdateList();
      }
      
      public function EnableList() : *
      {

         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].listDisabled = false;
         }
         UpdateList();
         this.disableInput_Inspectable = false;
      }
      
      public function DisableList() : *
      {

         for(var i:Number = 0; i < entryList.length; i++)
         {
            entryList[i].listDisabled = true;
         }
         UpdateList();
         this.disableInput_Inspectable = true;
      }
      
      override protected function PositionEntries() : *
      {

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
