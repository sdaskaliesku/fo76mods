package 
{
    import Shared.*;
    import flash.display.*;
    
    public class ItemCard_ItemHealthEntry extends ItemCard_Entry
    {
        public function ItemCard_ItemHealthEntry()
        {
            super();
            return;
        }

        public override function PopulateEntry(arg1:Object):*
        {
            Shared.GlobalFunc.updateConditionMeter(this.ConditionMeter_mc, arg1.currentHealth, arg1.maximumHealth, arg1.durability);
            return;
        }

        public static function IsEntryValid(arg1:Object):Boolean
        {
            return !(arg1.currentHealth == -1);
        }

        public var ConditionMeter_mc:flash.display.MovieClip;

        internal var m_ConditionLengthFrames:int=100;

        internal var m_ConditionFrames:int=110;
    }
}
