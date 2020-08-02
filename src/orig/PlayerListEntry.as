 
package
{
   import Shared.AS3.SWFLoaderClip;
   import Shared.AS3.SecureTradeShared;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class PlayerListEntry extends ItemListEntry
   {
      
      public static var menuMode:uint = // method body index: 1798 method index: 1798
      SecureTradeShared.MODE_INVALID;
      
      public static var showCurrency:Boolean = // method body index: 1798 method index: 1798
      true;
      
      public static var playerLevel:Number = // method body index: 1798 method index: 1798
      0;
      
      public static var currencyType:uint = // method body index: 1798 method index: 1798
      SecureTradeShared.CURRENCY_CAPS;
      
      private static const CONDITION_SPACING:Number = // method body index: 1798 method index: 1798
      6;
       
      
      public var Price_tf:TextField;
      
      public var CurrencyIcon_mc:SWFLoaderClip;
      
      public var ConditionBar_mc:MovieClip;
      
      public var RequestedTextField:TextField;
      
      private var m_ConditionInitialX:Number = 0;
      
      private var m_LastCurrencyType:uint = 4.294967295E9;
      
      private var m_CurrencyIconInstance:MovieClip;
      
      public var RarityIndicator_mc:MovieClip;
      
      public var RarityBorder_mc:MovieClip;
      
      public var RaritySelector_mc:MovieClip;
      
      public function PlayerListEntry()
      {
         // method body index: 1799 method index: 1799
         super();
         if(this.RequestedTextField)
         {
            TextFieldEx.setTextAutoSize(this.RequestedTextField,"shrink");
         }
         if(this.ConditionBar_mc != null)
         {
            this.m_ConditionInitialX = this.ConditionBar_mc.x;
         }
         this.CurrencyIcon_mc.clipWidth = this.CurrencyIcon_mc.width * (1 / this.CurrencyIcon_mc.scaleX);
         this.CurrencyIcon_mc.clipHeight = this.CurrencyIcon_mc.height * (1 / this.CurrencyIcon_mc.scaleY);
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {
         // method body index: 1800 method index: 1800
         super.SetEntryText(aEntryObject,astrTextOption);
         this.RaritySelector_mc.visible = false;
         if(this.m_LastCurrencyType != currencyType)
         {
            if(this.m_CurrencyIconInstance != null)
            {
               this.CurrencyIcon_mc.removeChild(this.m_CurrencyIconInstance);
               this.m_CurrencyIconInstance = null;
            }
            this.m_CurrencyIconInstance = SecureTradeShared.setCurrencyIcon(this.CurrencyIcon_mc,currencyType);
         }
         if(aEntryObject.isOffered)
         {
            this.CurrencyIcon_mc.visible = true;
            this.Price_tf.text = aEntryObject.offerValue;
         }
         else
         {
            this.CurrencyIcon_mc.visible = false;
            this.Price_tf.text = "";
         }
         this.Price_tf.textColor = !!this.selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(ORIG_TEXT_COLOR);
         if(this.RequestedTextField != null)
         {
            this.RequestedTextField.textColor = !!this.selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(ORIG_TEXT_COLOR);
         }
         SetColorTransform(this.CurrencyIcon_mc,selected);
         if(selected)
         {
            textField.filters = [];
            this.Price_tf.filters = [];
            this.CurrencyIcon_mc.filters = [];
            if(aEntryObject.rarity > -1)
            {
               border.visible = false;
               this.RaritySelector_mc.visible = true;
            }
            else
            {
               this.RaritySelector_mc.visible = false;
            }
            if(this.RequestedTextField != null)
            {
               this.RequestedTextField.filters = [];
            }
         }
         else
         {
            textField.filters = [new DropShadowFilter(2,135,0,1,1,1,1,BitmapFilterQuality.HIGH)];
            this.Price_tf.filters = textField.filters;
            this.CurrencyIcon_mc.filters = textField.filters;
            if(this.RequestedTextField != null)
            {
               this.RequestedTextField.filters = [new DropShadowFilter(2,135,0,1,1,1,1,BitmapFilterQuality.HIGH)];
            }
         }
         if(playerLevel >= aEntryObject.itemLevel)
         {
            textField.textColor = !!selected?uint(0):uint(ORIG_TEXT_COLOR);
         }
         else
         {
            textField.textColor = !!selected?uint(GlobalFunc.COLOR_TEXT_UNAVAILABLE):uint(GlobalFunc.COLOR_TEXT_UNAVAILABLE);
         }
         if(aEntryObject.isOffered == true && aEntryObject.hasOwnProperty("declineReason") && aEntryObject.declineReason != -1)
         {
            GlobalFunc.SetText(textField,"$DECLINED",true);
            GlobalFunc.SetText(textField,textField.text.replace("{1}",aEntryObject.text),true);
         }
         if(aEntryObject.hasOwnProperty("isRequested") && this.RequestedTextField != null)
         {
            this.RequestedTextField.visible = aEntryObject.isRequested;
            this.RequestedTextField.text = "$REQUESTED";
         }
         if(this.ConditionBar_mc != null)
         {
            this.UpdateConditionBar(aEntryObject);
         }
         var rarityColor:* = new ColorTransform();
         this.RarityBorder_mc.visible = aEntryObject.rarity > -1?true:false;
         if(aEntryObject.rarity == 0)
         {
            textField.textColor = !!selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_COMMON);
            rarityColor.color = GlobalFunc.COLOR_RARITY_COMMON;
            this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_COMMON);
         }
         else if(aEntryObject.rarity == 1)
         {
            textField.textColor = !!selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_RARE);
            rarityColor.color = GlobalFunc.COLOR_RARITY_RARE;
            this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_RARE);
         }
         else if(aEntryObject.rarity == 2)
         {
            textField.textColor = !!selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_EPIC);
            rarityColor.color = GlobalFunc.COLOR_RARITY_EPIC;
            this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_EPIC);
         }
         else if(aEntryObject.rarity == 3)
         {
            textField.textColor = !!selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_LEGENDARY);
            rarityColor.color = GlobalFunc.COLOR_RARITY_LEGENDARY;
            this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_LEGENDARY);
         }
         else
         {
            textField.textColor = !!selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_TEXT_BODY);
            rarityColor.color = GlobalFunc.COLOR_TEXT_BODY;
            this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_NONE);
         }
         this.RaritySelector_mc.RarityOverlay_mc.transform.colorTransform = rarityColor;
         this.RarityBorder_mc.transform.colorTransform = rarityColor;
         this.RarityIndicator_mc.transform.colorTransform = rarityColor;
      }
      
      private function UpdateConditionBar(aEntryObject:Object) : *
      {
         // method body index: 1801 method index: 1801
         if(menuMode == SecureTradeShared.MODE_FERMENTER || menuMode == SecureTradeShared.MODE_REFRIGERATOR)
         {
            GlobalFunc.updateConditionMeter(this.ConditionBar_mc,aEntryObject.currentHealth,aEntryObject.maximumHealth,aEntryObject.durability);
            if(this.CurrencyIcon_mc.visible)
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
      }
   }
}
