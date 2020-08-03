package 
{
    import Shared.*;
    import Shared.AS3.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class PlayerListEntry extends ItemListEntry
    {
        public function PlayerListEntry()
        {
            super();
            if (this.RequestedTextField) 
            {
                scaleform.gfx.TextFieldEx.setTextAutoSize(this.RequestedTextField, "shrink");
            }
            if (this.ConditionBar_mc != null) 
            {
                this.m_ConditionInitialX = this.ConditionBar_mc.x;
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
            if (arg1.isOffered) 
            {
                this.CurrencyIcon_mc.visible = true;
                this.Price_tf.text = arg1.offerValue;
            }
            else 
            {
                this.CurrencyIcon_mc.visible = false;
                this.Price_tf.text = "";
            }
            this.Price_tf.textColor = this.selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : ORIG_TEXT_COLOR;
            if (this.RequestedTextField != null) 
            {
                this.RequestedTextField.textColor = this.selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : ORIG_TEXT_COLOR;
            }
            SetColorTransform(this.CurrencyIcon_mc, selected);
            if (selected) 
            {
                textField.filters = [];
                this.Price_tf.filters = [];
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
                if (this.RequestedTextField != null) 
                {
                    this.RequestedTextField.filters = [];
                }
            }
            else 
            {
                textField.filters = [new flash.filters.DropShadowFilter(2, 135, 0, 1, 1, 1, 1, flash.filters.BitmapFilterQuality.HIGH)];
                this.Price_tf.filters = textField.filters;
                this.CurrencyIcon_mc.filters = textField.filters;
                if (this.RequestedTextField != null) 
                {
                    this.RequestedTextField.filters = [new flash.filters.DropShadowFilter(2, 135, 0, 1, 1, 1, 1, flash.filters.BitmapFilterQuality.HIGH)];
                }
            }
            if (playerLevel >= arg1.itemLevel) 
            {
                textField.textColor = selected ? 0 : ORIG_TEXT_COLOR;
            }
            else 
            {
                textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_UNAVAILABLE : Shared.GlobalFunc.COLOR_TEXT_UNAVAILABLE;
            }
            if (arg1.isOffered == true && arg1.hasOwnProperty("declineReason") && !(arg1.declineReason == -1)) 
            {
                Shared.GlobalFunc.SetText(textField, "$DECLINED", true);
                Shared.GlobalFunc.SetText(textField, textField.text.replace("{1}", arg1.text), true);
            }
            if (arg1.hasOwnProperty("isRequested") && !(this.RequestedTextField == null)) 
            {
                this.RequestedTextField.visible = arg1.isRequested;
                this.RequestedTextField.text = "$REQUESTED";
            }
            if (this.ConditionBar_mc != null) 
            {
                this.UpdateConditionBar(arg1);
            }
            var loc1:*=new flash.geom.ColorTransform();
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
                            loc1.color = Shared.GlobalFunc.COLOR_TEXT_BODY;
                            this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_NONE);
                        }
                        else 
                        {
                            textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_LEGENDARY;
                            loc1.color = Shared.GlobalFunc.COLOR_RARITY_LEGENDARY;
                            this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_LEGENDARY);
                        }
                    }
                    else 
                    {
                        textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_EPIC;
                        loc1.color = Shared.GlobalFunc.COLOR_RARITY_EPIC;
                        this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_EPIC);
                    }
                }
                else 
                {
                    textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_RARE;
                    loc1.color = Shared.GlobalFunc.COLOR_RARITY_RARE;
                    this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_RARE);
                }
            }
            else 
            {
                textField.textColor = selected ? Shared.GlobalFunc.COLOR_TEXT_SELECTED : Shared.GlobalFunc.COLOR_RARITY_COMMON;
                loc1.color = Shared.GlobalFunc.COLOR_RARITY_COMMON;
                this.RarityIndicator_mc.gotoAndStop(Shared.GlobalFunc.FRAME_RARITY_COMMON);
            }
            this.RaritySelector_mc.RarityOverlay_mc.transform.colorTransform = loc1;
            this.RarityBorder_mc.transform.colorTransform = loc1;
            this.RarityIndicator_mc.transform.colorTransform = loc1;
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
            showCurrency = true;
            playerLevel = 0;
            currencyType = Shared.AS3.SecureTradeShared.CURRENCY_CAPS;
        }

        internal static const CONDITION_SPACING:Number=6;

        public var Price_tf:flash.text.TextField;

        public var CurrencyIcon_mc:Shared.AS3.SWFLoaderClip;

        public var ConditionBar_mc:flash.display.MovieClip;

        public var RequestedTextField:flash.text.TextField;

        internal var m_ConditionInitialX:Number=0;

        internal var m_LastCurrencyType:uint=4294967295;

        internal var m_CurrencyIconInstance:flash.display.MovieClip;

        public var RarityIndicator_mc:flash.display.MovieClip;

        public var RarityBorder_mc:flash.display.MovieClip;

        public var RaritySelector_mc:flash.display.MovieClip;

        public static var menuMode:uint=4294967295;

        public static var showCurrency:Boolean=true;

        public static var playerLevel:Number=0;

        public static var currencyType:uint=0;
    }
}
