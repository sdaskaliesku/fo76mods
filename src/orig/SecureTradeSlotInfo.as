 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.SWFLoaderClip;
   import Shared.AS3.SecureTradeShared;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class SecureTradeSlotInfo extends BSUIComponent
   {
      
      private static const FRAME_NO_ICON = // method body index: 1582 method index: 1582
      1;
      
      private static const FRAME_ICON = // method body index: 1582 method index: 1582
      2;
       
      
      public var Header_mc:MovieClip;
      
      public var Icon_mc:SWFLoaderClip;
      
      public var Slot1_mc:MovieClip;
      
      public var Slot2_mc:MovieClip;
      
      private var m_MenuMode:uint = 4.294967295E9;
      
      private var m_OwnsVendor:Boolean = false;
      
      private var m_SlotData:Array = null;
      
      private var m_SlotClips:Vector.<MovieClip>;
      
      public function SecureTradeSlotInfo()
      {
         // method body index: 1583 method index: 1583
         var slotClip:MovieClip = null;
         super();
         gotoAndStop(FRAME_ICON);
         visible = false;
         mouseEnabled = false;
         mouseChildren = false;
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.Header_mc.Text_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.m_SlotClips = new <MovieClip>[this.Slot1_mc,this.Slot2_mc];
         for each(slotClip in this.m_SlotClips)
         {
            if(slotClip)
            {
               TextFieldEx.setTextAutoSize(slotClip.Text_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            }
         }
         this.Icon_mc.clipWidth = this.Icon_mc.width * (1 / this.Icon_mc.scaleX);
         this.Icon_mc.clipHeight = this.Icon_mc.height * (1 / this.Icon_mc.scaleY);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1584 method index: 1584
         super.onAddedToStage();
         BSUIDataManager.Subscribe("OtherInventoryTypeData",this.onOtherInvTypeDataUpdate);
      }
      
      private function onOtherInvTypeDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1585 method index: 1585
         var data:Object = arEvent.data;
         this.m_SlotData = data.slotDataA;
         this.m_OwnsVendor = data.ownsVendor;
         this.m_MenuMode = data.menuType;
         visible = this.m_OwnsVendor && this.m_SlotData && this.m_SlotData.length > 0 && data.menuSubType != SecureTradeShared.SUB_MODE_ARMOR_RACK;
         if(visible)
         {
            this.Update();
         }
      }
      
      public function Update() : *
      {
         // method body index: 1586 method index: 1586
         var slotData:Object = null;
         var slotDataEntries:Array = null;
         var i:int = 0;
         var entry1:Object = null;
         var entry2:Object = null;
         var textClip:MovieClip = null;
         var textField:TextField = null;
         var localizedText:String = null;
         slotDataEntries = [];
         for each(slotData in this.m_SlotData)
         {
            slotDataEntries.push({
               "slotType":slotData.slotType,
               "slotTypeText":slotData.slotTypeText,
               "slotCountFilled":slotData.slotCountFilled,
               "slotCountMax":slotData.slotCountMax
            });
         }
         slotDataEntries.sortOn("slotType");
         for(i = slotDataEntries.length - 1; i > 0; i--)
         {
            entry1 = slotDataEntries[i - 1];
            entry2 = slotDataEntries[i];
            if(entry1.slotType == entry2.slotType)
            {
               entry1.slotCountFilled = entry1.slotCountFilled + entry2.slotCountFilled;
               entry1.slotCountMax = entry1.slotCountMax + entry2.slotCountMax;
               slotDataEntries.splice(i,1);
            }
         }
         for(i = 0; i < this.m_SlotClips.length; i++)
         {
            textClip = this.m_SlotClips[i] as MovieClip;
            if(textClip)
            {
               textField = textClip.Text_tf;
               textClip.visible = i < slotDataEntries.length;
               if(i < slotDataEntries.length)
               {
                  slotData = slotDataEntries[i];
                  if(slotData.slotType == 0)
                  {
                     GlobalFunc.SetText(textField,"$SecureTrade_ItemSlotCounts");
                     localizedText = textField.text;
                     localizedText = localizedText.replace("{1}",slotData.slotCountFilled);
                     localizedText = localizedText.replace("{2}",slotData.slotCountMax);
                  }
                  else
                  {
                     GlobalFunc.SetText(textField,"$SecureTrade_ItemSlotTypeAndCounts");
                     localizedText = textField.text;
                     localizedText = localizedText.replace("{1}",slotData.slotTypeText);
                     localizedText = localizedText.replace("{2}",slotData.slotCountFilled);
                     localizedText = localizedText.replace("{3}",slotData.slotCountMax);
                  }
                  GlobalFunc.SetText(textField,localizedText);
               }
            }
         }
         this.Icon_mc.removeChildren();
         switch(this.m_MenuMode)
         {
            case SecureTradeShared.MODE_VENDING_MACHINE:
               GlobalFunc.SetText(this.Header_mc.Text_tf,"$SecureTrade_SlotHeader_VendingMachine");
               this.Icon_mc.setContainerIconClip("IconV_Vendor");
               break;
            case SecureTradeShared.MODE_DISPLAY_CASE:
               GlobalFunc.SetText(this.Header_mc.Text_tf,"$SecureTrade_SlotHeader_DisplayCase");
               this.Icon_mc.setContainerIconClip("IconV_Display");
               break;
            case SecureTradeShared.MODE_FERMENTER:
               GlobalFunc.SetText(this.Header_mc.Text_tf,"$SecureTrade_SlotHeader_Fermenter");
               this.Icon_mc.setContainerIconClip("IconV_Fermenter");
               break;
            case SecureTradeShared.MODE_REFRIGERATOR:
               GlobalFunc.SetText(this.Header_mc.Text_tf,"$SecureTrade_SlotHeader_Refrigerator");
               this.Icon_mc.setContainerIconClip("IconV_Refrigerator");
               break;
            case SecureTradeShared.MODE_CAMP_DISPENSER:
               GlobalFunc.SetText(this.Header_mc.Text_tf,"$SecureTrade_SlotHeader_Dispenser");
               this.Icon_mc.setContainerIconClip("IconV_Keg");
               break;
            case SecureTradeShared.MODE_ALLY:
               GlobalFunc.SetText(this.Header_mc.Text_tf,"$SecureTrade_SlotHeader_Ally");
               GlobalFunc.SetText(this.Slot1_mc.Text_tf,"$SecureTrade_SlotHeader_AllyStats");
               this.Icon_mc.setContainerIconClip("IconV_Ally");
               break;
            default:
               GlobalFunc.SetText(this.Header_mc.Text_tf,"");
         }
      }
      
      public function isSlotDataValid() : Boolean
      {
         // method body index: 1587 method index: 1587
         return this.m_SlotData != null && this.m_SlotData.length > 0;
      }
      
      public function AreSlotsFull() : Boolean
      {
         // method body index: 1588 method index: 1588
         var slotData:Object = null;
         for each(slotData in this.m_SlotData)
         {
            if(slotData.slotCountFilled < slotData.slotCountMax)
            {
               return false;
            }
         }
         return true;
      }
   }
}
