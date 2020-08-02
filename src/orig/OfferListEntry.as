 
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
   
   public class OfferListEntry extends ItemListEntry
   {
      
      public static var menuMode:uint = // method body index: 1803 method index: 1803
      SecureTradeShared.MODE_INVALID;
      
      public static var ownsVendor:Boolean = // method body index: 1803 method index: 1803
      false;
      
      public static var playerLevel:Number = // method body index: 1803 method index: 1803
      0;
      
      public static var playerCurrency:Number = // method body index: 1803 method index: 1803
      0;
      
      public static var currencyType:uint = // method body index: 1803 method index: 1803
      SecureTradeShared.CURRENCY_CAPS;
      
      private static const CONDITION_SPACING:Number = // method body index: 1803 method index: 1803
      6;
       
      
      public var Price_tf:TextField;
      
      public var CurrencyIcon_mc:SWFLoaderClip;
      
      public var ConditionBar_mc:MovieClip;
      
      public var Icon_mc:SWFLoaderClip;
      
      public var IconBacker_mc:MovieClip;
      
      private var m_ConditionInitialX:Number = 0;
      
      private var m_LastCurrencyType:uint = 4.294967295E9;
      
      private var m_CurrencyIconInstance:MovieClip;
      
      public var RarityIndicator_mc:MovieClip;
      
      public var RarityBorder_mc:MovieClip;
      
      public var RaritySelector_mc:MovieClip;
      
      public function OfferListEntry()
      {
         // method body index: 1804 method index: 1804
         super();
         if(this.ConditionBar_mc != null)
         {
            this.m_ConditionInitialX = this.ConditionBar_mc.x;
         }
         if(this.Icon_mc)
         {
            this.Icon_mc.clipWidth = this.Icon_mc.width * (1 / this.Icon_mc.scaleX);
            this.Icon_mc.clipHeight = this.Icon_mc.height * (1 / this.Icon_mc.scaleY);
         }
         this.CurrencyIcon_mc.clipWidth = this.CurrencyIcon_mc.width * (1 / this.CurrencyIcon_mc.scaleX);
         this.CurrencyIcon_mc.clipHeight = this.CurrencyIcon_mc.height * (1 / this.CurrencyIcon_mc.scaleY);
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {
         // method body index: 1805 method index: 1805
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
         var vendingData:Object = aEntryObject.vendingData;
         var meetsLevelRequirement:* = playerLevel >= aEntryObject.itemLevel;
         this.UpdateCurrency(aEntryObject);
         this.UpdateCampMachineIcon(aEntryObject);
         var showAsUnavailable:* = false;
         switch(menuMode)
         {
            case SecureTradeShared.MODE_CONTAINER:
               showAsUnavailable = !meetsLevelRequirement;
               break;
            case SecureTradeShared.MODE_VENDING_MACHINE:
               if(ownsVendor)
               {
                  showAsUnavailable = Boolean(vendingData.isVendedOnOtherMachine);
               }
               else
               {
                  showAsUnavailable = Boolean(aEntryObject.itemValue > playerCurrency || !meetsLevelRequirement);
               }
               break;
            case SecureTradeShared.MODE_DISPLAY_CASE:
            case SecureTradeShared.MODE_ALLY:
            case SecureTradeShared.MODE_FERMENTER:
            case SecureTradeShared.MODE_REFRIGERATOR:
            case SecureTradeShared.MODE_CAMP_DISPENSER:
               showAsUnavailable = Boolean(ownsVendor && vendingData.isVendedOnOtherMachine);
               break;
            case SecureTradeShared.MODE_NPCVENDING:
               if(aEntryObject.itemValue != null)
               {
                  showAsUnavailable = Boolean(aEntryObject.itemValue > playerCurrency || !meetsLevelRequirement);
               }
         }
         SetColorTransform(this.CurrencyIcon_mc,selected);
         if(selected)
         {
            textField.filters = [];
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
         }
         else
         {
            textField.filters = [new DropShadowFilter(2,135,0,1,1,1,1,BitmapFilterQuality.HIGH)];
            this.CurrencyIcon_mc.filters = textField.filters;
         }
         var baseText:String = textField.text;
         if(aEntryObject.isOffered == true)
         {
            if(aEntryObject.declineReason != -1)
            {
               GlobalFunc.SetText(textField,"$DECLINED",true);
               GlobalFunc.SetText(textField,textField.text.replace("{1}",baseText),true);
               showAsUnavailable = true;
            }
         }
         else if(aEntryObject.isRequested)
         {
            GlobalFunc.SetText(textField,"$REQUESTED_ITEM_NAME",true);
            GlobalFunc.SetText(textField,textField.text.replace("{1}",baseText),true);
         }
         if(showAsUnavailable)
         {
            textField.textColor = GlobalFunc.COLOR_TEXT_UNAVAILABLE;
         }
         else
         {
            textField.textColor = !!selected?uint(0):uint(ORIG_TEXT_COLOR);
         }
         if(this.ConditionBar_mc != null)
         {
            if(this.CurrencyIcon_mc.visible)
            {
               this.ConditionBar_mc.visible = false;
            }
            else
            {
               this.UpdateConditionBar(aEntryObject);
            }
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
      
      private function UpdateCurrency(aEntryObject:Object) : *
      {
         // method body index: 1806 method index: 1806
         var vendingData:Object = aEntryObject.vendingData;
         this.CurrencyIcon_mc.visible = false;
         this.Price_tf.text = "";
         switch(menuMode)
         {
            case SecureTradeShared.MODE_CONTAINER:
            case SecureTradeShared.MODE_ALLY:
            case SecureTradeShared.MODE_VENDING_MACHINE:
            case SecureTradeShared.MODE_DISPLAY_CASE:
            case SecureTradeShared.MODE_CAMP_DISPENSER:
            case SecureTradeShared.MODE_FERMENTER:
            case SecureTradeShared.MODE_REFRIGERATOR:
               if(vendingData.machineType == SecureTradeShared.MACHINE_TYPE_VENDING)
               {
                  this.CurrencyIcon_mc.visible = true;
                  this.Price_tf.text = vendingData.price;
               }
               break;
            case SecureTradeShared.MODE_PLAYERVENDING:
               if(aEntryObject.itemValue != null && aEntryObject.isOffered)
               {
                  this.CurrencyIcon_mc.visible = true;
                  this.Price_tf.text = aEntryObject.offerValue;
               }
               break;
            case SecureTradeShared.MODE_NPCVENDING:
               if(aEntryObject.itemValue != null)
               {
                  this.CurrencyIcon_mc.visible = true;
                  this.Price_tf.text = aEntryObject.itemValue;
               }
         }
         this.Price_tf.textColor = !!selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(ORIG_TEXT_COLOR);
         if(selected)
         {
            this.Price_tf.filters = [];
         }
         else
         {
            this.Price_tf.filters = [new DropShadowFilter(2,135,0,1,1,1,1,BitmapFilterQuality.HIGH)];
         }
      }
      
      private function GetCampMachineIconClip(machineType:uint) : String
      {
         // method body index: 1807 method index: 1807
         switch(machineType)
         {
            case SecureTradeShared.MACHINE_TYPE_VENDING:
               return "IconV_Vendor";
            case SecureTradeShared.MACHINE_TYPE_DISPLAY:
               return "IconV_Display";
            case SecureTradeShared.MACHINE_TYPE_DISPENSER:
               return "IconV_Keg";
            case SecureTradeShared.MACHINE_TYPE_FERMENTER:
               return "IconV_Fermenter";
            case SecureTradeShared.MACHINE_TYPE_REFRIGERATOR:
               return "IconV_Refrigerator";
            case SecureTradeShared.MACHINE_TYPE_ALLY:
               return "IconV_Ally";
            default:
               return null;
         }
      }
      
      private function UpdateCampMachineIcon(aEntryObject:Object) : *
      {
         // method body index: 1808 method index: 1808
         if(!this.Icon_mc)
         {
            return;
         }
         var vendingData:Object = aEntryObject.vendingData;
         var iconClip:String = this.GetCampMachineIconClip(vendingData.machineType);
         var showIcon:* = menuMode == SecureTradeShared.MODE_CONTAINER || SecureTradeShared.IsCampVendingMenuType(menuMode) && ownsVendor;
         this.Icon_mc.visible = showIcon && iconClip;
         this.IconBacker_mc.visible = this.Icon_mc.visible;
         if(showIcon && iconClip)
         {
            this.Icon_mc.removeChildren();
            this.Icon_mc.setContainerIconClip(iconClip);
         }
      }
      
      private function UpdateConditionBar(aEntryObject:Object) : *
      {
         // method body index: 1809 method index: 1809
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
