package 
{
    import Shared.*;
    import Shared.AS3.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    
    public class OfferListEntry extends ItemListEntry
    {
        public function OfferListEntry()
        {
            super();
            if (this.ConditionBar_mc != null) 
            {
                this.m_ConditionInitialX = this.ConditionBar_mc.x;
            }
            if (this.Icon_mc) 
            {
                this.Icon_mc.clipWidth = this.Icon_mc.width * 1 / this.Icon_mc.scaleX;
                this.Icon_mc.clipHeight = this.Icon_mc.height * 1 / this.Icon_mc.scaleY;
            }
            this.CurrencyIcon_mc.clipWidth = this.CurrencyIcon_mc.width * 1 / this.CurrencyIcon_mc.scaleX;
            this.CurrencyIcon_mc.clipHeight = this.CurrencyIcon_mc.height * 1 / this.CurrencyIcon_mc.scaleY;
            return;
        }

        public override function SetEntryText(arg1:Object, arg2:String):*
        {
            super.SetEntryText(arg1, arg2);
            this.RaritySelector_mc.visible = false;
            if (this.m_LastCurrencyType != currencyType) 
            {
                if (this.m_CurrencyIconInstance != null) 
                {
                    this.CurrencyIcon_mc.removeChild(this.m_CurrencyIconInstance);
                    this.m_CurrencyIconInstance = null;
                }
                this.m_CurrencyIconInstance = Shared.AS3.SecureTradeShared.setCurrencyIcon(this.CurrencyIcon_mc, currencyType);
            }
            var loc1:*=arg1.vendingData;
            var loc2:*=playerLevel >= arg1.itemLevel;
            this.UpdateCurrency(arg1);
            this.UpdateCampMachineIcon(arg1);
            var loc3:*=false;
            var loc6:*=menuMode;
            switch (loc6) 
            {
                case Shared.AS3.SecureTradeShared.MODE_CONTAINER:
                {
                    loc3 = !loc2;
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_VENDING_MACHINE:
                {
                    if (ownsVendor) 
                    {
                        loc3 = loc1.isVendedOnOtherMachine;
                    }
                    else 
                    {
                        loc3 = arg1.itemValue > playerCurrency || !loc2;
                    }
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_DISPLAY_CASE:
                case Shared.AS3.SecureTradeShared.MODE_ALLY:
                case Shared.AS3.SecureTradeShared.MODE_FERMENTER:
                case Shared.AS3.SecureTradeShared.MODE_REFRIGERATOR:
                case Shared.AS3.SecureTradeShared.MODE_CAMP_DISPENSER:
                {
                    loc3 = ownsVendor && loc1.isVendedOnOtherMachine;
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_NPCVENDING:
                {
                    if (arg1.itemValue != null) 
                    {
                        loc3 = arg1.itemValue > playerCurrency || !loc2;
                    }
                    break;
                }
            }
            SetColorTransform(this.CurrencyIcon_mc, selected);
            if (selected) 
            {
                textField.filters = [];
                this.CurrencyIcon_mc.filters = [];
                if (arg1.rarity > -1) 
                {
                    border.visible = false;
                    this.RaritySelector_mc.visible = true;
                }
                else 
                {
                    this.RaritySelector_mc.visible = false;
                }
            }
            else 
            {
                textField.filters = [new flash.filters.DropShadowFilter(2, 135, 0, 1, 1, 1, 1, flash.filters.BitmapFilterQuality.HIGH)];
                this.CurrencyIcon_mc.filters = textField.filters;
            }
            var loc4:*=textField.text;
            if (arg1.isOffered != true) 
            {
                if (arg1.isRequested) 
                {
                    Shared.GlobalFunc.SetText(textField, "$REQUESTED_ITEM_NAME", true);
                    Shared.GlobalFunc.SetText(textField, textField.text.replace("{1}", loc4), true);
                }
            }
            else if (arg1.declineReason != -1) 
            {
                Shared.GlobalFunc.SetText(textField, "$DECLINED", true);
                Shared.GlobalFunc.SetText(textField, textField.text.replace("{1}", loc4), true);
                loc3 = true;
            }
            if (loc3) 
            {
                textField.textColor = Shared.GlobalFunc.COLOR_TEXT_UNAVAILABLE;
            }
            else 
            {
                textField.textColor = selected ? 0 : ORIG_TEXT_COLOR;
            }
            if (this.ConditionBar_mc != null) 
            {
                if (this.CurrencyIcon_mc.visible) 
                {
                    this.ConditionBar_mc.visible = false;
                }
                else 
                {
                    this.UpdateConditionBar(arg1);
                }
            }
            var loc5:*=new flash.geom.ColorTransform();
            this.RarityBorder_mc.visible = arg1.rarity > -1 ? true : false;
            if (arg1.rarity != 0) 
            {
                if (arg1.rarity != 1) 
                {
                    if (arg1.rarity != 2) 
                    {
                        if (arg1.rarity != 3) 
                        {
                            textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_TEXT_BODY;
                            loc5.color = Shared.GlobalFunc.COLOR_TEXT_BODY;
                            this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_NONE);
                        }
                        else 
                        {
                            textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_LEGENDARY;
                            loc5.color = Shared.GlobalFunc.COLOR_RARITY_LEGENDARY;
                            this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_LEGENDARY);
                        }
                    }
                    else 
                    {
                        textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_EPIC;
                        loc5.color = Shared.GlobalFunc.COLOR_RARITY_EPIC;
                        this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_EPIC);
                    }
                }
                else 
                {
                    textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_RARE;
                    loc5.color = Shared.GlobalFunc.COLOR_RARITY_RARE;
                    this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_RARE);
                }
            }
            else 
            {
                textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_COMMON;
                loc5.color = Shared.GlobalFunc.COLOR_RARITY_COMMON;
                this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_COMMON);
            }
            this.RaritySelector_mc.RarityOverlay_mc.transform.colorTransform = loc5;
            this.RarityBorder_mc.transform.colorTransform = loc5;
            this.RarityIndicator_mc.transform.colorTransform = loc5;
            return;
        }

        internal function UpdateCurrency(arg1:Object):*
        {
            var loc1:*=arg1.vendingData;
            this.CurrencyIcon_mc.visible = false;
            this.Price_tf.text = "";
            var loc2:*=menuMode;
            switch (loc2) 
            {
                case Shared.AS3.SecureTradeShared.MODE_CONTAINER:
                case Shared.AS3.SecureTradeShared.MODE_ALLY:
                case Shared.AS3.SecureTradeShared.MODE_VENDING_MACHINE:
                case Shared.AS3.SecureTradeShared.MODE_DISPLAY_CASE:
                case Shared.AS3.SecureTradeShared.MODE_CAMP_DISPENSER:
                case Shared.AS3.SecureTradeShared.MODE_FERMENTER:
                case Shared.AS3.SecureTradeShared.MODE_REFRIGERATOR:
                {
                    if (loc1.machineType == Shared.AS3.SecureTradeShared.MACHINE_TYPE_VENDING) 
                    {
                        this.CurrencyIcon_mc.visible = true;
                        this.Price_tf.text = loc1.price;
                    }
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_PLAYERVENDING:
                {
                    if (!(arg1.itemValue == null) && arg1.isOffered) 
                    {
                        this.CurrencyIcon_mc.visible = true;
                        this.Price_tf.text = arg1.offerValue;
                    }
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_NPCVENDING:
                {
                    if (arg1.itemValue != null) 
                    {
                        this.CurrencyIcon_mc.visible = true;
                        this.Price_tf.text = arg1.itemValue;
                    }
                    break;
                }
            }
            this.Price_tf.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : ORIG_TEXT_COLOR;
            if (selected) 
            {
                this.Price_tf.filters = [];
            }
            else 
            {
                this.Price_tf.filters = [new flash.filters.DropShadowFilter(2, 135, 0, 1, 1, 1, 1, flash.filters.BitmapFilterQuality.HIGH)];
            }
            return;
        }

        internal function GetCampMachineIconClip(arg1:uint):String
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case Shared.AS3.SecureTradeShared.MACHINE_TYPE_VENDING:
                {
                    return "IconV_Vendor";
                }
                case Shared.AS3.SecureTradeShared.MACHINE_TYPE_DISPLAY:
                {
                    return "IconV_Display";
                }
                case Shared.AS3.SecureTradeShared.MACHINE_TYPE_DISPENSER:
                {
                    return "IconV_Keg";
                }
                case Shared.AS3.SecureTradeShared.MACHINE_TYPE_FERMENTER:
                {
                    return "IconV_Fermenter";
                }
                case Shared.AS3.SecureTradeShared.MACHINE_TYPE_REFRIGERATOR:
                {
                    return "IconV_Refrigerator";
                }
                case Shared.AS3.SecureTradeShared.MACHINE_TYPE_ALLY:
                {
                    return "IconV_Ally";
                }
            }
            return null;
        }

        internal function UpdateCampMachineIcon(arg1:Object):*
        {
            if (!this.Icon_mc) 
            {
                return;
            }
            var loc1:*=arg1.vendingData;
            var loc2:*=this.GetCampMachineIconClip(loc1.machineType);
            var loc3:*=menuMode == Shared.AS3.SecureTradeShared.MODE_CONTAINER || Shared.AS3.SecureTradeShared.IsCampVendingMenuType(menuMode) && ownsVendor;
            this.Icon_mc.visible = loc3 && loc2;
            this.IconBacker_mc.visible = this.Icon_mc.visible;
            if (loc3 && loc2) 
            {
                this.Icon_mc.removeChildren();
                this.Icon_mc.setContainerIconClip(loc2);
            }
            return;
        }

        internal function UpdateConditionBar(arg1:Object):*
        {
            if (menuMode == Shared.AS3.SecureTradeShared.MODE_FERMENTER || menuMode == Shared.AS3.SecureTradeShared.MODE_REFRIGERATOR) 
            {
                Shared.GlobalFunc.updateConditionMeter(this.ConditionBar_mc, arg1.currentHealth, arg1.maximumHealth, arg1.durability);
                if (this.CurrencyIcon_mc.visible) 
                {
                    this.ConditionBar_mc.x = this.Price_tf.x - this.ConditionBar_mc.width - CONDITION_SPACING;
                }
                else 
                {
                    this.ConditionBar_mc.x = this.m_ConditionInitialX;
                }
            }
            else 
            {
                this.ConditionBar_mc.visible = false;
            }
            return;
        }

        
        {
            menuMode = Shared.AS3.SecureTradeShared.MODE_INVALID;
            ownsVendor = false;
            playerLevel = 0;
            playerCurrency = 0;
            currencyType = Shared.AS3.SecureTradeShared.CURRENCY_CAPS;
        }

        internal static const CONDITION_SPACING:Number=6;

        public var Price_tf:flash.text.TextField;

        public var CurrencyIcon_mc:Shared.AS3.SWFLoaderClip;

        public var ConditionBar_mc:flash.display.MovieClip;

        public var Icon_mc:Shared.AS3.SWFLoaderClip;

        public var IconBacker_mc:flash.display.MovieClip;

        internal var m_ConditionInitialX:Number=0;

        internal var m_LastCurrencyType:uint=4294967295;

        internal var m_CurrencyIconInstance:flash.display.MovieClip;

        public var RarityIndicator_mc:flash.display.MovieClip;

        public var RarityBorder_mc:flash.display.MovieClip;

        public var RaritySelector_mc:flash.display.MovieClip;

        public static var menuMode:uint=4294967295;

        public static var ownsVendor:Boolean=false;

        public static var playerLevel:Number=0;

        public static var playerCurrency:Number=0;

        public static var currencyType:uint=0;
    }
}
