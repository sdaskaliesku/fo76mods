package 
{
    import flash.display.*;
    
    public class ItemCard_TimedEntry extends ItemCard_Entry
    {
        public function ItemCard_TimedEntry()
        {
            super();
            this.TIMER_ORIG_X = this.TimerIcon_mc.x;
            return;
        }

        public override function PopulateEntry(arg1:Object):*
        {
            super.PopulateEntry(arg1);
            var loc1:*=Value_tf.x + Value_tf.getLineMetrics(0).x - this.TimerIcon_mc.width / 2 - 10;
            if (loc1 < this.TIMER_ORIG_X) 
            {
                this.TimerIcon_mc.x = loc1;
            }
            return;
        }

        public var TimerIcon_mc:flash.display.MovieClip;

        internal var TIMER_ORIG_X:Number;
    }
}
