 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ListFilterer extends EventDispatcher
   {
      
      public static const FILTER_CHANGE:String = // method body index: 177 method index: 177
      "ListFilterer::filter_change";
       
      
      private var iItemFilter:int;
      
      private var _filterArray:Array;
      
      public function ListFilterer()
      {
         // method body index: 178 method index: 178
         super();
         this.iItemFilter = 4294967295;
      }
      
      public function get itemFilter() : int
      {
         // method body index: 179 method index: 179
         return this.iItemFilter;
      }
      
      public function set itemFilter(param1:int) : *
      {
         // method body index: 180 method index: 180
         var _loc2_:* = this.iItemFilter != param1;
         this.iItemFilter = param1;
         if(_loc2_ == true)
         {
            dispatchEvent(new Event(FILTER_CHANGE,true,true));
         }
      }
      
      public function get filterArray() : Array
      {
         // method body index: 181 method index: 181
         return this._filterArray;
      }
      
      public function set filterArray(param1:Array) : *
      {
         // method body index: 182 method index: 182
         this._filterArray = param1;
      }
      
      public function EntryMatchesFilter(param1:Object) : Boolean
      {
         // method body index: 183 method index: 183
         return param1 != null && (!param1.hasOwnProperty("filterFlag") || (param1.filterFlag & this.iItemFilter) != 0);
      }
      
      public function GetPrevFilterMatch(param1:int) : int
      {
         // method body index: 184 method index: 184
         var _loc2_:int = 0;
         var _loc3_:int = int.MAX_VALUE;
         if(param1 != int.MAX_VALUE && this._filterArray != null)
         {
            _loc2_ = param1 - 1;
            while(_loc2_ >= 0 && _loc3_ == int.MAX_VALUE)
            {
               if(this.EntryMatchesFilter(this._filterArray[_loc2_]))
               {
                  _loc3_ = _loc2_;
               }
               _loc2_--;
            }
         }
         return _loc3_;
      }
      
      public function GetNextFilterMatch(param1:int) : int
      {
         // method body index: 185 method index: 185
         var _loc2_:int = 0;
         var _loc3_:int = int.MAX_VALUE;
         if(param1 != int.MAX_VALUE && this._filterArray != null)
         {
            _loc2_ = param1 + 1;
            while(_loc2_ < this._filterArray.length && _loc3_ == int.MAX_VALUE)
            {
               if(this.EntryMatchesFilter(this._filterArray[_loc2_]))
               {
                  _loc3_ = _loc2_;
               }
               _loc2_++;
            }
         }
         return _loc3_;
      }
      
      public function FindArrayIndexOfFilteredPosition(param1:int) : int
      {
         // method body index: 186 method index: 186
         var _loc2_:Number = this.ClampIndex(0);
         while(param1 > 0 && _loc2_ != int.MAX_VALUE)
         {
            _loc2_ = this.GetNextFilterMatch(_loc2_);
            param1--;
         }
         return _loc2_;
      }
      
      public function ClampIndex(param1:int) : int
      {
         // method body index: 187 method index: 187
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = param1;
         if(param1 != int.MAX_VALUE && this._filterArray != null && !this.EntryMatchesFilter(this._filterArray[_loc4_]))
         {
            _loc2_ = this.GetNextFilterMatch(_loc4_);
            _loc3_ = this.GetPrevFilterMatch(_loc4_);
            if(_loc2_ != int.MAX_VALUE)
            {
               _loc4_ = _loc2_;
            }
            else if(_loc3_ != int.MAX_VALUE)
            {
               _loc4_ = _loc3_;
            }
            else
            {
               _loc4_ = int.MAX_VALUE;
            }
            if(_loc2_ != int.MAX_VALUE && _loc3_ != int.MAX_VALUE && _loc3_ != _loc2_ && _loc4_ == _loc2_ && this._filterArray[_loc3_].text == this._filterArray[param1].text)
            {
               _loc4_ = _loc3_;
            }
         }
         return _loc4_;
      }
      
      public function IsFilterEmpty(param1:int) : Boolean
      {
         // method body index: 188 method index: 188
         var _loc2_:* = false;
         var _loc3_:int = this.iItemFilter;
         this.iItemFilter = param1;
         _loc2_ = this.ClampIndex(0) == int.MAX_VALUE;
         this.iItemFilter = _loc3_;
         return _loc2_;
      }
      
      public function IsValidIndex(param1:int) : Boolean
      {
         // method body index: 189 method index: 189
         return param1 != int.MAX_VALUE && this._filterArray != null && this.EntryMatchesFilter(this._filterArray[param1]);
      }
   }
}
