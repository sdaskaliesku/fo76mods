 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ListFilterer extends EventDispatcher
   {
      
      public static const FILTER_CHANGE:String = // method body index: 690 method index: 690
      "ListFilterer::filter_change";
       
      
      private var iItemFilter:int;
      
      private var _filterArray:Array;
      
      public function ListFilterer()
      {
         // method body index: 691 method index: 691
         super();
         this.iItemFilter = 4294967295;
      }
      
      public function get itemFilter() : int
      {
         // method body index: 692 method index: 692
         return this.iItemFilter;
      }
      
      public function set itemFilter(aiNewFilter:int) : *
      {
         // method body index: 693 method index: 693
         var bdifferent:* = this.iItemFilter != aiNewFilter;
         this.iItemFilter = aiNewFilter;
         if(bdifferent == true)
         {
            dispatchEvent(new Event(FILTER_CHANGE,true,true));
         }
      }
      
      public function get filterArray() : Array
      {
         // method body index: 694 method index: 694
         return this._filterArray;
      }
      
      public function set filterArray(aNewArray:Array) : *
      {
         // method body index: 695 method index: 695
         this._filterArray = aNewArray;
      }
      
      public function EntryMatchesFilter(aEntry:Object) : Boolean
      {
         // method body index: 696 method index: 696
         return aEntry != null && (!aEntry.hasOwnProperty("filterFlag") || (aEntry.filterFlag & this.iItemFilter) != 0);
      }
      
      public function GetPrevFilterMatch(aiStartIndex:int) : int
      {
         // method body index: 697 method index: 697
         var ientry:int = 0;
         var imatchIndex:int = int.MAX_VALUE;
         if(aiStartIndex != int.MAX_VALUE && this._filterArray != null)
         {
            ientry = aiStartIndex - 1;
            while(ientry >= 0 && imatchIndex == int.MAX_VALUE)
            {
               if(this.EntryMatchesFilter(this._filterArray[ientry]))
               {
                  imatchIndex = ientry;
               }
               ientry--;
            }
         }
         return imatchIndex;
      }
      
      public function GetNextFilterMatch(aiStartIndex:int) : int
      {
         // method body index: 698 method index: 698
         var ientry:int = 0;
         var imatchIndex:int = int.MAX_VALUE;
         if(aiStartIndex != int.MAX_VALUE && this._filterArray != null)
         {
            ientry = aiStartIndex + 1;
            while(ientry < this._filterArray.length && imatchIndex == int.MAX_VALUE)
            {
               if(this.EntryMatchesFilter(this._filterArray[ientry]))
               {
                  imatchIndex = ientry;
               }
               ientry++;
            }
         }
         return imatchIndex;
      }
      
      public function FindArrayIndexOfFilteredPosition(aiFilteredListIndex:int) : int
      {
         // method body index: 699 method index: 699
         var iArrayIndex:Number = this.ClampIndex(0);
         while(aiFilteredListIndex > 0 && iArrayIndex != int.MAX_VALUE)
         {
            iArrayIndex = this.GetNextFilterMatch(iArrayIndex);
            aiFilteredListIndex--;
         }
         return iArrayIndex;
      }
      
      public function ClampIndex(aiStartIndex:int) : int
      {
         // method body index: 700 method index: 700
         var inextIndex:int = 0;
         var iprevIndex:int = 0;
         var ireturnVal:* = aiStartIndex;
         if(aiStartIndex != int.MAX_VALUE && this._filterArray != null && !this.EntryMatchesFilter(this._filterArray[ireturnVal]))
         {
            inextIndex = this.GetNextFilterMatch(ireturnVal);
            iprevIndex = this.GetPrevFilterMatch(ireturnVal);
            if(inextIndex != int.MAX_VALUE)
            {
               ireturnVal = inextIndex;
            }
            else if(iprevIndex != int.MAX_VALUE)
            {
               ireturnVal = iprevIndex;
            }
            else
            {
               ireturnVal = int.MAX_VALUE;
            }
            if(inextIndex != int.MAX_VALUE && iprevIndex != int.MAX_VALUE && iprevIndex != inextIndex && ireturnVal == inextIndex && this._filterArray[iprevIndex].text == this._filterArray[aiStartIndex].text)
            {
               ireturnVal = iprevIndex;
            }
         }
         return ireturnVal;
      }
      
      public function IsFilterEmpty(aiFilter:int) : Boolean
      {
         // method body index: 701 method index: 701
         var bresult:* = false;
         var iprevFilter:int = this.iItemFilter;
         this.iItemFilter = aiFilter;
         bresult = this.ClampIndex(0) == int.MAX_VALUE;
         this.iItemFilter = iprevFilter;
         return bresult;
      }
      
      public function IsValidIndex(aiStartIndex:int) : Boolean
      {
         // method body index: 702 method index: 702
         return aiStartIndex != int.MAX_VALUE && this._filterArray != null && this.EntryMatchesFilter(this._filterArray[aiStartIndex]);
      }
   }
}
