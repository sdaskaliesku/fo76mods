 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ListFilterer extends EventDispatcher
   {
      
      public static const FILTER_CHANGE:String = // method body index: 202 method index: 202
      "ListFilterer::filter_change";
       
      
      private var iItemFilter:int;
      
      private var _filterArray:Array;
      
      public function ListFilterer()
      {
         // method body index: 203 method index: 203
         super();
         this.iItemFilter = 4294967295;
      }
      
      public function get itemFilter() : int
      {
         // method body index: 204 method index: 204
         return this.iItemFilter;
      }
      
      public function set itemFilter(param1:int) : *
      {
         // method body index: 205 method index: 205
         var _loc2_:* = this.iItemFilter != param1;
         this.iItemFilter = param1;
         if(_loc2_ == true)
         {
            dispatchEvent(new Event(FILTER_CHANGE,true,true));
         }
      }
      
      public function get filterArray() : Array
      {
         // method body index: 206 method index: 206
         return this._filterArray;
      }
      
      public function set filterArray(param1:Array) : *
      {
         // method body index: 207 method index: 207
         this._filterArray = param1;
      }
      
      public function EntryMatchesFilter(param1:Object) : Boolean
      {
         // method body index: 208 method index: 208
         return param1 != null && (!param1.hasOwnProperty("filterFlag") || (param1.filterFlag & this.iItemFilter) != 0);
      }
      
      public function GetPrevFilterMatch(param1:int) : int
      {
         // method body index: 209 method index: 209
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
         // method body index: 210 method index: 210
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
         // method body index: 211 method index: 211
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
         // method body index: 212 method index: 212
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
         // method body index: 213 method index: 213
         var _loc2_:* = false;
         var _loc3_:int = this.iItemFilter;
         this.iItemFilter = param1;
         _loc2_ = this.ClampIndex(0) == int.MAX_VALUE;
         this.iItemFilter = _loc3_;
         return _loc2_;
      }
      
      public function IsValidIndex(param1:int) : Boolean
      {
         // method body index: 214 method index: 214
         return param1 != int.MAX_VALUE && this._filterArray != null && this.EntryMatchesFilter(this._filterArray[param1]);
      }
   }
}
