 
package
{
   import Shared.AS3.BSScrollingList;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class SecureTradePlayerInventory extends SecureTradeInventory
   {
       
      
      public var Tooltip_mc:MovieClip;
      
      public var PlayerCurrency_tf:TextField;
      
      public var PlayerWeight_tf:TextField;
      
      private var m_Tooltip:String;
      
      private var m_Currency:Number = 0;
      
      private var m_CurrencyMax:Number = 0;
      
      private var m_CurrencyName:String = "";
      
      private var m_CarryWeightCurrent:Number = 0;
      
      private var m_CarryWeightMax:Number = 0;
      
      private var m_AbsoluteWeightLimit:Number = 9999;
      
      private var m_showTooltip = false;
      
      public function SecureTradePlayerInventory()
      {
         // method body index: 1831 method index: 1831
         super();
         addFrameScript(0,this.frame1);
         this.tooltip = "";
         this.UpdateTooltipVisibility();
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.PlayerWeight_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.PlayerCurrency_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function set currency(aCurrency:Number) : void
      {
         // method body index: 1812 method index: 1812
         this.m_Currency = aCurrency;
         SetIsDirty();
      }
      
      public function set currencyMax(aCurrencyMax:Number) : void
      {
         // method body index: 1813 method index: 1813
         this.m_CurrencyMax = aCurrencyMax;
      }
      
      public function set currencyName(aCurrencyName:String) : void
      {
         // method body index: 1814 method index: 1814
         this.m_CurrencyName = aCurrencyName;
      }
      
      public function set tooltip(aTip:String) : void
      {
         // method body index: 1815 method index: 1815
         this.m_Tooltip = aTip;
         this.Tooltip_mc.Tooltip_tf.text = aTip;
      }
      
      public function get tooltip() : String
      {
         // method body index: 1816 method index: 1816
         return this.m_Tooltip;
      }
      
      public function set showTooltip(aVal:Boolean) : void
      {
         // method body index: 1817 method index: 1817
         this.m_showTooltip = aVal;
         this.UpdateTooltipVisibility();
      }
      
      public function UpdateToolTipText() : void
      {
         // method body index: 1818 method index: 1818
         var selectedEntry:Object = ItemList_mc.List_mc.selectedEntry;
         if(selectedEntry != null && selectedEntry.declineReason != undefined && selectedEntry.declineReason != -1)
         {
            this.tooltip = "$SecureTrade_" + SecureTradeDeclineItemModal.REJECT_REASONS[selectedEntry.declineReason];
         }
         else
         {
            this.tooltip = "";
         }
      }
      
      private function UpdateTooltipVisibility() : void
      {
         // method body index: 1819 method index: 1819
         if(this.m_showTooltip && !hasEventListener(BSScrollingList.SELECTION_CHANGE))
         {
            addEventListener(BSScrollingList.SELECTION_CHANGE,this.onTooltipSelectionChange);
         }
         else if(!this.m_showTooltip && hasEventListener(BSScrollingList.SELECTION_CHANGE))
         {
            removeEventListener(BSScrollingList.SELECTION_CHANGE,this.onTooltipSelectionChange);
         }
      }
      
      private function onTooltipSelectionChange(e:Event) : void
      {
         // method body index: 1820 method index: 1820
         this.UpdateToolTipText();
      }
      
      public function get currency() : Number
      {
         // method body index: 1821 method index: 1821
         return this.m_Currency;
      }
      
      public function get currencyMax() : Number
      {
         // method body index: 1822 method index: 1822
         return this.m_CurrencyMax;
      }
      
      public function get currencyName() : String
      {
         // method body index: 1823 method index: 1823
         return this.m_CurrencyName;
      }
      
      public function set carryWeightCurrent(aWeight:Number) : void
      {
         // method body index: 1824 method index: 1824
         this.m_CarryWeightCurrent = aWeight;
         SetIsDirty();
      }
      
      public function set carryWeightMax(aWeight:Number) : void
      {
         // method body index: 1825 method index: 1825
         this.m_CarryWeightMax = aWeight;
         SetIsDirty();
      }
      
      public function set absoluteWeightLimit(aWeight:Number) : void
      {
         // method body index: 1826 method index: 1826
         this.m_AbsoluteWeightLimit = aWeight;
         SetIsDirty();
      }
      
      public function get carryWeightCurrent() : Number
      {
         // method body index: 1827 method index: 1827
         return this.m_CarryWeightCurrent;
      }
      
      public function get carryWeightMax() : Number
      {
         // method body index: 1828 method index: 1828
         return this.m_CarryWeightMax;
      }
      
      public function get absoluteWeightLimit() : Number
      {
         // method body index: 1829 method index: 1829
         return this.m_AbsoluteWeightLimit;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1830 method index: 1830
         super.redrawUIComponent();
         if(this.m_CarryWeightCurrent >= this.m_AbsoluteWeightLimit)
         {
            this.PlayerWeight_tf.text = "$AbsoluteWeightLimitDisplay";
            this.PlayerWeight_tf.text = this.PlayerWeight_tf.text.replace("{weight}",this.m_CarryWeightCurrent.toString());
         }
         else
         {
            this.PlayerWeight_tf.text = this.m_CarryWeightCurrent + "/" + this.m_CarryWeightMax;
         }
         this.PlayerCurrency_tf.text = this.m_Currency.toString();
      }
      
      function frame1() : *
      {
         // method body index: 1832 method index: 1832
      }
   }
}
