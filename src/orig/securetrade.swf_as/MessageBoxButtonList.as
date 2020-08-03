package 
{
    import Shared.AS3.*;
    
    public class MessageBoxButtonList extends Shared.AS3.BSScrollingList
    {
        public function MessageBoxButtonList()
        {
            super();
            return;
        }

        public function get greatestWidth():Number
        {
            return this.m_GreatestWidth;
        }

        public override function InvalidateData():*
        {
            super.InvalidateData();
            this.SetEntryBorderWidths();
            return;
        }

        internal function SetEntryBorderWidths():*
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=null;
            this.m_GreatestWidth = 0;
            var loc1:*=0;
            while (loc1 < uiNumListItems) 
            {
                loc3 = GetClipByIndex(loc1) as MessageBoxButtonEntry;
                if (loc3 && loc3.textField) 
                {
                    if ((loc4 = loc3.CalculateBorderWidth()) > this.m_GreatestWidth) 
                    {
                        this.m_GreatestWidth = loc4;
                    }
                }
                ++loc1;
            }
            var loc2:*=0;
            while (loc2 < uiNumListItems) 
            {
                if (loc5 == GetClipByIndex(loc2) as MessageBoxButtonEntry) 
                {
                    loc5.SetBorderWidth(this.m_GreatestWidth);
                }
                ++loc2;
            }
            border.x = this.greatestWidth * -0.5;
            border.width = this.greatestWidth;
            if (ScrollUp != null) 
            {
                ScrollUp.x = this.greatestWidth * -0.5 - 50;
            }
            if (ScrollDown != null) 
            {
                ScrollDown.x = ScrollUp.x;
            }
            if (Mask_mc != null) 
            {
                Mask_mc.x = border.x;
                Mask_mc.width = border.width;
            }
            return;
        }

        protected override function updateScrollPosition(arg1:uint):*
        {
            super.updateScrollPosition(arg1);
            this.SetEntryBorderWidths();
            return;
        }

        internal var m_GreatestWidth:Number=0;
    }
}
