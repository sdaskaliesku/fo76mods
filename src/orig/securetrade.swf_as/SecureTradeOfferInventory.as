package 
{
    import Shared.*;
    import Shared.AS3.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class SecureTradeOfferInventory extends SecureTradeInventory
    {
        public function SecureTradeOfferInventory()
        {
            super();
            this.Tooltip_mc.Tooltip_tf.text = "";
            this.miniTooltip_mc.textField_tf.text = "";
            this.m_Currency = 0;
            this.UpdateTooltipVisibility();
            scaleform.gfx.Extensions.enabled = true;
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.OfferWeight_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.OfferCurrency_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.Tooltip_mc.Tooltip_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.miniTooltip_mc.textField_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            return;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            return;
        }

        public function set menuMode(arg1:uint):void
        {
            this.m_menuMode = arg1;
            return;
        }

        public function set subMenuMode(arg1:uint):void
        {
            this.m_subMenuMode = arg1;
            return;
        }

        public function set machineTypeMode(arg1:uint):void
        {
            this.m_machineTypeMode = arg1;
            return;
        }

        public function set showTooltip(arg1:Boolean):void
        {
            this.m_showTooltip = arg1;
            this.UpdateTooltipVisibility();
            return;
        }

        public function set showCurrency(arg1:Boolean):void
        {
            this.OfferCurrency_tf.visible = arg1;
            CurrencyIcon_mc.visible = arg1;
            return;
        }

        public function set showCarryWeight(arg1:Boolean):void
        {
            this.OfferWeight_tf.visible = arg1;
            this.OfferWeightIcon.visible = arg1;
            return;
        }

        public override function redrawUIComponent():void
        {
            super.redrawUIComponent();
            this.OfferCurrency_tf.text = this.m_Currency.toString();
            this.OfferWeight_tf.text = this.m_CarryWeightCurrent + " / " + this.m_CarryWeightMax;
            return;
        }

        public function UpdateTooltips():void
        {
            this.UpdateToolTipText();
            this.UpdateMiniTooltipText();
            return;
        }

        internal function UpdateToolTipText():void
        {
            this.Tooltip_mc.Tooltip_tf.text = "";
            var loc1:*=ItemList_mc.List_mc.selectedEntry;
            if (this.m_menuMode == Shared.AS3.SecureTradeShared.MODE_NPCVENDING) 
            {
                var loc2:*=this.m_subMenuMode;
                switch (loc2) 
                {
                    case Shared.AS3.SecureTradeShared.SUB_MODE_LEGENDARY_VENDING_MACHINE:
                    {
                        if (loc1 == null) 
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_LegendaryVendingMachineHint";
                        }
                        else 
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_VendingMachineLegendary";
                        }
                        break;
                    }
                    case Shared.AS3.SecureTradeShared.SUB_MODE_POSSUM_VENDING_MACHINE:
                    {
                        this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_PossumVendingMachineHint";
                        break;
                    }
                    case Shared.AS3.SecureTradeShared.SUB_MODE_TADPOLE_VENDING_MACHINE:
                    {
                        this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_TadpoleVendingMachineHint";
                        break;
                    }
                }
            }
            if (loc1 != null) 
            {
                if (Shared.AS3.SecureTradeShared.IsCampVendingMenuType(this.m_menuMode) && this.m_ownsVendor) 
                {
                    loc2 = this.m_menuMode;
                    switch (loc2) 
                    {
                        case Shared.AS3.SecureTradeShared.MODE_VENDING_MACHINE:
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_VendingMachine";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MODE_DISPLAY_CASE:
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_DisplayCase";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MODE_FERMENTER:
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Fermenter";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MODE_REFRIGERATOR:
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Refrigerator";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MODE_CAMP_DISPENSER:
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Dispenser";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MODE_ALLY:
                        {
                            this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Ally";
                            break;
                        }
                    }
                }
                else if (!(loc1.declineReason == undefined) && !(loc1.declineReason == -1)) 
                {
                    this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_" + SecureTradeDeclineItemModal.REJECT_REASONS[loc1.declineReason];
                }
            }
            return;
        }

        internal function UpdateMiniTooltipText():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.miniTooltip_mc.textField_tf.text = "";
            var loc1:*=ItemList_mc.List_mc.selectedEntry;
            if (loc1 == null) 
            {
                return;
            }
            if (this.m_menuMode == Shared.AS3.SecureTradeShared.MODE_CONTAINER || this.m_ownsVendor && Shared.AS3.SecureTradeShared.IsCampVendingMenuType(this.m_menuMode)) 
            {
                loc2 = loc1.vendingData;
                if (loc2.machineType != Shared.AS3.SecureTradeShared.MACHINE_TYPE_INVALID) 
                {
                    loc3 = null;
                    if (loc2.machineType != Shared.AS3.SecureTradeShared.MACHINE_TYPE_ALLY) 
                    {
                        if (loc2.isVendedOnOtherMachine) 
                        {
                            if (Shared.AS3.SecureTradeShared.DoesMachineTypeMatchMode(loc2.machineType, this.m_menuMode)) 
                            {
                                loc3 = "$SecureTrade_ItemSetToAnotherMachine";
                            }
                            else 
                            {
                                loc3 = "$SecureTrade_ItemSetToAMachine";
                            }
                        }
                        else 
                        {
                            loc3 = "$SecureTrade_ItemSetToThisMachine";
                        }
                    }
                    else 
                    {
                        loc3 = "$SecureTrade_ItemSetToYourAlly";
                    }
                    loc4 = null;
                    var loc5:*=loc2.machineType;
                    switch (loc5) 
                    {
                        case Shared.AS3.SecureTradeShared.MACHINE_TYPE_VENDING:
                        {
                            loc4 = "$SecureTrade_MachineTypeVendingMachine";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MACHINE_TYPE_DISPLAY:
                        {
                            loc4 = "$SecureTrade_MachineTypeDisplay";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MACHINE_TYPE_DISPENSER:
                        {
                            loc4 = "$SecureTrade_MachineTypeDispenser";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MACHINE_TYPE_FERMENTER:
                        {
                            loc4 = "$SecureTrade_MachineTypeFermenter";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MACHINE_TYPE_REFRIGERATOR:
                        {
                            loc4 = "$SecureTrade_MachineTypeRefrigerator";
                            break;
                        }
                        case Shared.AS3.SecureTradeShared.MACHINE_TYPE_ALLY:
                        {
                            loc4 = "$SecureTrade_ItemSetToYourAlly";
                            break;
                        }
                    }
                    if (loc3 && loc4) 
                    {
                        this.miniTooltip_mc.textField_tf.text = Shared.GlobalFunc.LocalizeFormattedString(loc3, loc4);
                    }
                }
            }
            return;
        }

        internal function UpdateTooltipVisibility():void
        {
            trace("UpdateTooltipVisibility");
            if (this.m_showTooltip && !hasEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE)) 
            {
                addEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE, this.onTooltipSelectionChange);
            }
            else if (!this.m_showTooltip && hasEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE)) 
            {
                removeEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE, this.onTooltipSelectionChange);
            }
            this.Tooltip_mc.visible = this.m_showTooltip;
            this.miniTooltip_mc.visible = this.m_showTooltip;
            return;
        }

        internal function onTooltipSelectionChange(arg1:flash.events.Event):void
        {
            this.UpdateToolTipText();
            this.UpdateMiniTooltipText();
            return;
        }

        public function set ownsVendor(arg1:Boolean):*
        {
            this.m_ownsVendor = arg1;
            return;
        }

        public function get carryWeightCurrent():Number
        {
            return this.m_CarryWeightCurrent;
        }

        public function set carryWeightCurrent(arg1:Number):void
        {
            this.m_CarryWeightCurrent = arg1;
            SetIsDirty();
            return;
        }

        public function get carryWeightMax():Number
        {
            return this.m_CarryWeightMax;
        }

        public function set carryWeightMax(arg1:Number):void
        {
            this.m_CarryWeightMax = arg1;
            SetIsDirty();
            return;
        }

        public function set currency(arg1:Number):void
        {
            this.m_Currency = arg1;
            SetIsDirty();
            return;
        }

        public function get currency():Number
        {
            return this.m_Currency;
        }

        public var Tooltip_mc:flash.display.MovieClip;

        public var miniTooltip_mc:flash.display.MovieClip;

        public var OfferCurrency_tf:flash.text.TextField;

        public var OfferWeight_tf:flash.text.TextField;

        public var OfferWeightIcon:flash.display.MovieClip;

        internal var m_menuMode:uint=4294967295;

        internal var m_subMenuMode:uint=0;

        internal var m_machineTypeMode:uint=0;

        internal var m_CarryWeightCurrent:Number=0;

        internal var m_CarryWeightMax:Number=0;

        internal var m_showTooltip:*=false;

        internal var m_Currency:Number=0;

        internal var m_ownsVendor:Boolean=false;
    }
}
