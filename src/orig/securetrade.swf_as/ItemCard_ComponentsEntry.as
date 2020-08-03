package 
{
    import Shared.AS3.*;
    import flash.display.*;
    
    public class ItemCard_ComponentsEntry extends ItemCard_Entry
    {
        public function ItemCard_ComponentsEntry()
        {
            super();
            this.currY = 0;
            return;
        }

        public function get entryCount():int
        {
            return this.m_EntryCount;
        }

        public override function PopulateEntry(arg1:Object):*
        {
            var loc1:*=null;
            var loc2:*=null;
            while (this.EntryHolder_mc.numChildren > 0) 
            {
                this.EntryHolder_mc.removeChildAt(0);
            }
            this.currY = 0;
            this.m_EntryCount = 0;
            var loc3:*=0;
            var loc4:*=arg1.components;
            for each (loc1 in loc4) 
            {
                loc2 = new ItemCard_ComponentEntry_Entry();
                loc2.SetEntryText(loc1, Shared.AS3.BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT);
                this.EntryHolder_mc.addChild(loc2);
                loc2.y = this.currY;
                this.currY = this.currY + (loc2.height + this.ENTRY_SPACING);
                var loc5:*;
                var loc6:*=((loc5 = this).m_EntryCount + 1);
                loc5.m_EntryCount = loc6;
            }
            return;
        }

        internal const ENTRY_SPACING:Number=0;

        public var EntryHolder_mc:flash.display.MovieClip;

        internal var currY:Number;

        internal var m_EntryCount:int=0;
    }
}
