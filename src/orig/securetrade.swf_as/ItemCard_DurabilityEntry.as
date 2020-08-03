package 
{
    import flash.display.*;
    
    public class ItemCard_DurabilityEntry extends ItemCard_Entry
    {
        public function ItemCard_DurabilityEntry()
        {
            super();
            return;
        }

        public function ItemCard_TimedEntry():*
        {
            this.m_DurabilityFrames = this.Durability_mc.totalFrames;
            return;
        }

        public override function PopulateEntry(arg1:Object):*
        {
            Value_tf.text = "$$ItemLevel " + arg1.itemLevel;
            this.Durability_mc.gotoAndStop(Math.min(arg1.legendaryMods + 1, this.m_DurabilityFrames));
            return;
        }

        public static function IsEntryValid(arg1:Object):Boolean
        {
            return !(arg1.itemLevel == null) && arg1.itemLevel > 0;
        }

        public var Durability_mc:flash.display.MovieClip;

        internal var m_DurabilityFrames:int=6;
    }
}
