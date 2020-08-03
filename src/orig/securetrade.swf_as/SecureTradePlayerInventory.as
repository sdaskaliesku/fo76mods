package 
{
    import Shared.AS3.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class SecureTradePlayerInventory extends SecureTradeInventory
    {
        public function SecureTradePlayerInventory()
        {
            super();
            this.tooltip = "";
            this.UpdateTooltipVisibility();
            scaleform.gfx.Extensions.enabled = true;
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.PlayerWeight_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.PlayerCurrency_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            return;
        }

        public function set currency(arg1:Number):void
        {
            this.m_Currency = arg1;
            SetIsDirty();
            return;
        }

        public function set currencyMax(arg1:Number):void
        {
            this.m_CurrencyMax = arg1;
            return;
        }

        public function set currencyName(arg1:String):void
        {
            this.m_CurrencyName = arg1;
            return;
        }

        public function set tooltip(arg1:String):void
        {
            this.m_Tooltip = arg1;
            this.Tooltip_mc.Tooltip_tf.text = arg1;
            return;
        }

        public function get tooltip():String
        {
            return this.m_Tooltip;
        }

        public function set showTooltip(arg1:Boolean):void
        {
            this.m_showTooltip = arg1;
            this.UpdateTooltipVisibility();
            return;
        }

        public function UpdateToolTipText():void
        {
            var loc1:*=ItemList_mc.List_mc.selectedEntry;
            if (!(loc1 == null) && !(loc1.declineReason == undefined) && !(loc1.declineReason == -1)) 
            {
                this.tooltip = "$SecureTrade_" + SecureTradeDeclineItemModal.REJECT_REASONS[loc1.declineReason];
            }
            else 
            {
                this.tooltip = "";
            }
            return;
        }

        internal function UpdateTooltipVisibility():void
        {
            if (this.m_showTooltip && !hasEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE)) 
            {
                addEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE, this.onTooltipSelectionChange);
            }
            else if (!this.m_showTooltip && hasEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE)) 
            {
                removeEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE, this.onTooltipSelectionChange);
            }
            return;
        }

        internal function onTooltipSelectionChange(arg1:flash.events.Event):void
        {
            this.UpdateToolTipText();
            return;
        }

        public function get currency():Number
        {
            return this.m_Currency;
        }

        public function get currencyMax():Number
        {
            return this.m_CurrencyMax;
        }

        public function get currencyName():String
        {
            return this.m_CurrencyName;
        }

        public function set carryWeightCurrent(arg1:Number):void
        {
            this.m_CarryWeightCurrent = arg1;
            SetIsDirty();
            return;
        }

        public function set carryWeightMax(arg1:Number):void
        {
            this.m_CarryWeightMax = arg1;
            SetIsDirty();
            return;
        }

        public function set absoluteWeightLimit(arg1:Number):void
        {
            this.m_AbsoluteWeightLimit = arg1;
            SetIsDirty();
            return;
        }

        public function get carryWeightCurrent():Number
        {
            return this.m_CarryWeightCurrent;
        }

        public function get carryWeightMax():Number
        {
            return this.m_CarryWeightMax;
        }

        public function get absoluteWeightLimit():Number
        {
            return this.m_AbsoluteWeightLimit;
        }

        public override function redrawUIComponent():void
        {
            super.redrawUIComponent();
            if (this.m_CarryWeightCurrent >= this.m_AbsoluteWeightLimit) 
            {
                this.PlayerWeight_tf.text = "$AbsoluteWeightLimitDisplay";
                this.PlayerWeight_tf.text = this.PlayerWeight_tf.text.replace("{weight}", this.m_CarryWeightCurrent.toString());
            }
            else 
            {
                this.PlayerWeight_tf.text = this.m_CarryWeightCurrent + "/" + this.m_CarryWeightMax;
            }
            this.PlayerCurrency_tf.text = this.m_Currency.toString();
            return;
        }

        public var Tooltip_mc:flash.display.MovieClip;

        public var PlayerCurrency_tf:flash.text.TextField;

        public var PlayerWeight_tf:flash.text.TextField;

        internal var m_Tooltip:String;

        internal var m_Currency:Number=0;

        internal var m_CurrencyMax:Number=0;

        internal var m_CurrencyName:String="";

        internal var m_CarryWeightCurrent:Number=0;

        internal var m_CarryWeightMax:Number=0;

        internal var m_AbsoluteWeightLimit:Number=9999;

        internal var m_showTooltip:*=false;
    }
}
