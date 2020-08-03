package 
{
    import Shared.AS3.*;
    
    public class MessageBoxButtonEntry extends Shared.AS3.BSScrollingListEntry
    {
        public function MessageBoxButtonEntry()
        {
            super();
            this.m_BaseFilters = textField.filters;
            return;
        }

        public function CalculateBorderWidth():Number
        {
            return textField.getLineMetrics(0).width + ENTRY_BORDER_PAD;
        }

        public function SetBorderWidth(arg1:Number):*
        {
            border.width = arg1;
            border.x = arg1 * -0.5;
            return;
        }

        public override function SetEntryText(arg1:Object, arg2:String):*
        {
            super.SetEntryText(arg1, arg2);
            if (selected) 
            {
                textField.filters = [];
            }
            else 
            {
                textField.filters = this.m_BaseFilters;
            }
            return;
        }

        public static const ENTRY_BORDER_PAD:Number=30;

        internal var m_BaseFilters:Array;
    }
}
