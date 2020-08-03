package 
{
    import Shared.*;
    import flash.display.*;
    
    public class ItemCard_MultiEntry extends ItemCard_Entry
    {
        public function ItemCard_MultiEntry()
        {
            super();
            return;
        }

        public function set entrySpacing(arg1:Number):*
        {
            this.m_EntrySpacing = arg1;
            return;
        }

        public function get entryCount():int
        {
            return this.m_EntryCount;
        }

        public function PopulateMultiEntry(arg1:Array, arg2:String):*
        {
            var loc3:*=null;
            if (Label_tf != null) 
            {
                Shared.GlobalFunc.SetText(Label_tf, arg2, false);
            }
            while (this.EntryHolder_mc.numChildren > 0) 
            {
                this.EntryHolder_mc.removeChildAt(0);
            }
            var loc1:*=0;
            this.m_EntryCount = 0;
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if (arg1[loc2].text == arg2 && IsEntryValid(arg1[loc2])) 
                {
                    (loc3 = new ItemCard_MultiEntry_Value()).Icon_mc.gotoAndStop(arg2 != DMG_WEAP_ID ? arg1[loc2].damageType : arg1[loc2].damageType + Shared.GlobalFunc.NUM_DAMAGE_TYPES);
                    loc3.PopulateEntry(arg1[loc2]);
                    this.EntryHolder_mc.addChild(loc3);
                    var loc4:*;
                    var loc5:*=((loc4 = this).m_EntryCount + 1);
                    loc4.m_EntryCount = loc5;
                    if (loc1 > 0) 
                    {
                        loc1 = loc1 + this.m_EntrySpacing;
                    }
                    loc3.y = loc1;
                    if (loc3.Sizer_mc == null) 
                    {
                        loc1 = loc1 + loc3.height;
                    }
                    else 
                    {
                        loc1 = loc1 + loc3.Sizer_mc.height;
                    }
                }
                ++loc2;
            }
            if (this.Background_mc != null) 
            {
                this.Background_mc.height = loc1;
            }
            return;
        }

        public static function IsEntryValid(arg1:Object):Boolean
        {
            return arg1.value > 0 || ShouldShowDifference(arg1) && arg1.text == DMG_ARMO_ID;
        }

        public static const DMG_WEAP_ID:String="$dmg";

        public static const DMG_ARMO_ID:String="$dr";

        public var EntryHolder_mc:flash.display.MovieClip;

        public var Background_mc:flash.display.MovieClip;

        internal var m_EntrySpacing:Number=3.5;

        internal var m_EntryCount:int=0;
    }
}
