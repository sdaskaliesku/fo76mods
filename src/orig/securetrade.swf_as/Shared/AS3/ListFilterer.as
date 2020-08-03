package Shared.AS3 
{
    import flash.events.*;
    
    public class ListFilterer extends flash.events.EventDispatcher
    {
        public function ListFilterer()
        {
            super();
            this.iItemFilter = 4294967295;
            return;
        }

        public function get itemFilter():int
        {
            return this.iItemFilter;
        }

        public function set itemFilter(arg1:int):*
        {
            var loc1:*=!(this.iItemFilter == arg1);
            this.iItemFilter = arg1;
            if (loc1 == true) 
            {
                dispatchEvent(new flash.events.Event(FILTER_CHANGE, true, true));
            }
            return;
        }

        public function get filterArray():Array
        {
            return this._filterArray;
        }

        public function set filterArray(arg1:Array):*
        {
            this._filterArray = arg1;
            return;
        }

        public function EntryMatchesFilter(arg1:Object):Boolean
        {
            return !(arg1 == null) && (!arg1.hasOwnProperty("filterFlag") || !((arg1.filterFlag & this.iItemFilter) == 0));
        }

        public function GetPrevFilterMatch(arg1:int):int
        {
            var loc2:*=0;
            var loc1:*=int.MAX_VALUE;
            if (!(arg1 == int.MAX_VALUE) && !(this._filterArray == null)) 
            {
                --loc2;
                while (loc2 >= 0 && loc1 == int.MAX_VALUE) 
                {
                    if (this.EntryMatchesFilter(this._filterArray[loc2])) 
                    {
                        --loc1;
                    }
                    --loc2;
                }
            }
            return loc1;
        }

        public function GetNextFilterMatch(arg1:int):int
        {
            var loc2:*=0;
            var loc1:*=int.MAX_VALUE;
            if (!(arg1 == int.MAX_VALUE) && !(this._filterArray == null)) 
            {
                loc2 = arg1 + 1;
                while (loc2 < this._filterArray.length && loc1 == int.MAX_VALUE) 
                {
                    if (this.EntryMatchesFilter(this._filterArray[loc2])) 
                    {
                        loc1 = loc2;
                    }
                    ++loc2;
                }
            }
            return loc1;
        }

        public function FindArrayIndexOfFilteredPosition(arg1:int):int
        {
            var loc1:*=this.ClampIndex(0);
            while (arg1 > 0 && !(loc1 == int.MAX_VALUE)) 
            {
                loc1 = this.GetNextFilterMatch(loc1);
                --arg1;
            }
            return loc1;
        }

        public function ClampIndex(arg1:int):int
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=arg1;
            if (!(arg1 == int.MAX_VALUE) && !(this._filterArray == null) && !this.EntryMatchesFilter(this._filterArray[loc1])) 
            {
                loc2 = this.GetNextFilterMatch(loc1);
                loc3 = this.GetPrevFilterMatch(loc1);
                if (loc2 == int.MAX_VALUE) 
                {
                    if (loc3 == int.MAX_VALUE) 
                    {
                        loc1 = int.MAX_VALUE;
                    }
                    else 
                    {
                        loc1 = loc3;
                    }
                }
                else 
                {
                    loc1 = loc2;
                }
                if (!(loc2 == int.MAX_VALUE) && !(loc3 == int.MAX_VALUE) && !(loc3 == loc2) && loc1 == loc2 && this._filterArray[loc3].text == this._filterArray[arg1].text) 
                {
                    loc1 = loc3;
                }
            }
            return loc1;
        }

        public function IsFilterEmpty(arg1:int):Boolean
        {
            var loc2:*=false;
            var loc1:*=this.iItemFilter;
            this.iItemFilter = arg1;
            loc2 = this.ClampIndex(0) == int.MAX_VALUE;
            this.iItemFilter = loc1;
            return loc2;
        }

        public function IsValidIndex(arg1:int):Boolean
        {
            return !(arg1 == int.MAX_VALUE) && !(this._filterArray == null) && this.EntryMatchesFilter(this._filterArray[arg1]);
        }

        public static const FILTER_CHANGE:String="ListFilterer::filter_change";

        internal var iItemFilter:int;

        internal var _filterArray:Array;
    }
}
