 
package
{
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.SecureTradeShared;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class SecureTradeOfferInventory extends SecureTradeInventory
   {
       
      
      public var Tooltip_mc:MovieClip;
      
      public var miniTooltip_mc:MovieClip;
      
      public var OfferCurrency_tf:TextField;
      
      public var OfferWeight_tf:TextField;
      
      public var OfferWeightIcon:MovieClip;
      
      private var m_menuMode:uint = 4.294967295E9;
      
      private var m_subMenuMode:uint = 0;
      
      private var m_machineTypeMode:uint = 0;
      
      private var m_CarryWeightCurrent:Number = 0;
      
      private var m_CarryWeightMax:Number = 0;
      
      private var m_showTooltip = false;
      
      private var m_Currency:Number = 0;
      
      private var m_ownsVendor:Boolean = false;
      
      public function SecureTradeOfferInventory()
      {
         // method body index: 1842 method index: 1842
         super();
         this.Tooltip_mc.Tooltip_tf.text = "";
         this.miniTooltip_mc.textField_tf.text = "";
         this.m_Currency = 0;
         this.UpdateTooltipVisibility();
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.OfferWeight_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.OfferCurrency_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Tooltip_mc.Tooltip_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.miniTooltip_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function set ownsVendor(aOwnsVendor:Boolean) : *
      {
         // method body index: 1835 method index: 1835
         this.m_ownsVendor = aOwnsVendor;
      }
      
      public function get carryWeightCurrent() : Number
      {
         // method body index: 1836 method index: 1836
         return this.m_CarryWeightCurrent;
      }
      
      public function set carryWeightCurrent(aWeight:Number) : void
      {
         // method body index: 1837 method index: 1837
         this.m_CarryWeightCurrent = aWeight;
         SetIsDirty();
      }
      
      public function get carryWeightMax() : Number
      {
         // method body index: 1838 method index: 1838
         return this.m_CarryWeightMax;
      }
      
      public function set carryWeightMax(aWeight:Number) : void
      {
         // method body index: 1839 method index: 1839
         this.m_CarryWeightMax = aWeight;
         SetIsDirty();
      }
      
      public function set currency(aCurrency:Number) : void
      {
         // method body index: 1840 method index: 1840
         this.m_Currency = aCurrency;
         SetIsDirty();
      }
      
      public function get currency() : Number
      {
         // method body index: 1841 method index: 1841
         return this.m_Currency;
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1843 method index: 1843
         super.onAddedToStage();
      }
      
      public function set menuMode(aMode:uint) : void
      {
         // method body index: 1844 method index: 1844
         this.m_menuMode = aMode;
      }
      
      public function set subMenuMode(aMode:uint) : void
      {
         // method body index: 1845 method index: 1845
         this.m_subMenuMode = aMode;
      }
      
      public function set machineTypeMode(aMode:uint) : void
      {
         // method body index: 1846 method index: 1846
         this.m_machineTypeMode = aMode;
      }
      
      public function set showTooltip(aVal:Boolean) : void
      {
         // method body index: 1847 method index: 1847
         this.m_showTooltip = aVal;
         this.UpdateTooltipVisibility();
      }
      
      public function set showCurrency(aVal:Boolean) : void
      {
         // method body index: 1848 method index: 1848
         this.OfferCurrency_tf.visible = aVal;
         CurrencyIcon_mc.visible = aVal;
      }
      
      public function set showCarryWeight(aVal:Boolean) : void
      {
         // method body index: 1849 method index: 1849
         this.OfferWeight_tf.visible = aVal;
         this.OfferWeightIcon.visible = aVal;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1850 method index: 1850
         super.redrawUIComponent();
         this.OfferCurrency_tf.text = this.m_Currency.toString();
         this.OfferWeight_tf.text = this.m_CarryWeightCurrent + " / " + this.m_CarryWeightMax;
      }
      
      public function UpdateTooltips() : void
      {
         // method body index: 1851 method index: 1851
         this.UpdateToolTipText();
         this.UpdateMiniTooltipText();
      }
      
      private function UpdateToolTipText() : void
      {
         // method body index: 1852 method index: 1852
         this.Tooltip_mc.Tooltip_tf.text = "";
         var selectedEntry:Object = ItemList_mc.List_mc.selectedEntry;
         if(this.m_menuMode == SecureTradeShared.MODE_NPCVENDING)
         {
            switch(this.m_subMenuMode)
            {
               case SecureTradeShared.SUB_MODE_LEGENDARY_VENDING_MACHINE:
                  if(selectedEntry != null)
                  {
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_VendingMachineLegendary";
                  }
                  else
                  {
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_LegendaryVendingMachineHint";
                  }
                  break;
               case SecureTradeShared.SUB_MODE_POSSUM_VENDING_MACHINE:
                  this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_PossumVendingMachineHint";
                  break;
               case SecureTradeShared.SUB_MODE_TADPOLE_VENDING_MACHINE:
                  this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_TadpoleVendingMachineHint";
            }
         }
         if(selectedEntry != null)
         {
            if(SecureTradeShared.IsCampVendingMenuType(this.m_menuMode) && this.m_ownsVendor)
            {
               switch(this.m_menuMode)
               {
                  case SecureTradeShared.MODE_VENDING_MACHINE:
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_VendingMachine";
                     break;
                  case SecureTradeShared.MODE_DISPLAY_CASE:
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_DisplayCase";
                     break;
                  case SecureTradeShared.MODE_FERMENTER:
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Fermenter";
                     break;
                  case SecureTradeShared.MODE_REFRIGERATOR:
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Refrigerator";
                     break;
                  case SecureTradeShared.MODE_CAMP_DISPENSER:
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Dispenser";
                     break;
                  case SecureTradeShared.MODE_ALLY:
                     this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_SlotTooltip_Ally";
               }
            }
            else if(selectedEntry.declineReason != undefined && selectedEntry.declineReason != -1)
            {
               this.Tooltip_mc.Tooltip_tf.text = "$SecureTrade_" + SecureTradeDeclineItemModal.REJECT_REASONS[selectedEntry.declineReason];
            }
         }
      }
      
      private function UpdateMiniTooltipText() : void
      {
         // method body index: 1853 method index: 1853
         var vendingData:Object = null;
         var formatString:String = null;
         var machineTypeString:String = null;
         this.miniTooltip_mc.textField_tf.text = "";
         var selectedEntry:Object = ItemList_mc.List_mc.selectedEntry;
         if(selectedEntry == null)
         {
            return;
         }
         if(this.m_menuMode == SecureTradeShared.MODE_CONTAINER || this.m_ownsVendor && SecureTradeShared.IsCampVendingMenuType(this.m_menuMode))
         {
            vendingData = selectedEntry.vendingData;
            if(vendingData.machineType != SecureTradeShared.MACHINE_TYPE_INVALID)
            {
               formatString = null;
               if(vendingData.machineType == SecureTradeShared.MACHINE_TYPE_ALLY)
               {
                  formatString = "$SecureTrade_ItemSetToYourAlly";
               }
               else if(!vendingData.isVendedOnOtherMachine)
               {
                  formatString = "$SecureTrade_ItemSetToThisMachine";
               }
               else if(SecureTradeShared.DoesMachineTypeMatchMode(vendingData.machineType,this.m_menuMode))
               {
                  formatString = "$SecureTrade_ItemSetToAnotherMachine";
               }
               else
               {
                  formatString = "$SecureTrade_ItemSetToAMachine";
               }
               machineTypeString = null;
               switch(vendingData.machineType)
               {
                  case SecureTradeShared.MACHINE_TYPE_VENDING:
                     machineTypeString = "$SecureTrade_MachineTypeVendingMachine";
                     break;
                  case SecureTradeShared.MACHINE_TYPE_DISPLAY:
                     machineTypeString = "$SecureTrade_MachineTypeDisplay";
                     break;
                  case SecureTradeShared.MACHINE_TYPE_DISPENSER:
                     machineTypeString = "$SecureTrade_MachineTypeDispenser";
                     break;
                  case SecureTradeShared.MACHINE_TYPE_FERMENTER:
                     machineTypeString = "$SecureTrade_MachineTypeFermenter";
                     break;
                  case SecureTradeShared.MACHINE_TYPE_REFRIGERATOR:
                     machineTypeString = "$SecureTrade_MachineTypeRefrigerator";
                     break;
                  case SecureTradeShared.MACHINE_TYPE_ALLY:
                     machineTypeString = "$SecureTrade_ItemSetToYourAlly";
               }
               if(formatString && machineTypeString)
               {
                  this.miniTooltip_mc.textField_tf.text = GlobalFunc.LocalizeFormattedString(formatString,machineTypeString);
               }
            }
         }
      }
      
      private function UpdateTooltipVisibility() : void
      {
         // method body index: 1854 method index: 1854
         trace("UpdateTooltipVisibility");
         if(this.m_showTooltip && !hasEventListener(BSScrollingList.SELECTION_CHANGE))
         {
            addEventListener(BSScrollingList.SELECTION_CHANGE,this.onTooltipSelectionChange);
         }
         else if(!this.m_showTooltip && hasEventListener(BSScrollingList.SELECTION_CHANGE))
         {
            removeEventListener(BSScrollingList.SELECTION_CHANGE,this.onTooltipSelectionChange);
         }
         this.Tooltip_mc.visible = this.m_showTooltip;
         this.miniTooltip_mc.visible = this.m_showTooltip;
      }
      
      private function onTooltipSelectionChange(e:Event) : void
      {
         // method body index: 1855 method index: 1855
         this.UpdateToolTipText();
         this.UpdateMiniTooltipText();
      }
   }
}
