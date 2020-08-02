 
package
{
   import Shared.AS3.BCBasicModal;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.StyleSheet;
   import Shared.AS3.Styles.ScrapComponentListStyle;
   import Shared.GlobalFunc;
   
   public class SecureTradeScrapConfirmModal extends BCBasicModal
   {
      
      private static const STATE_SCRAP:uint = // method body index: 1777 method index: 1777
      1;
      
      private static const STATE_SCRAP_ALL:uint = // method body index: 1777 method index: 1777
      2;
      
      private static const STATE_SCRAPBOX_TRANSFER_JUNK:uint = // method body index: 1777 method index: 1777
      3;
      
      private static const STATE_SCRAPBOX_SCRAP_TRANSFER_SELECTION:uint = // method body index: 1777 method index: 1777
      4;
      
      private static const EVENT_PREP_SCRAP_PROMPT:String = // method body index: 1777 method index: 1777
      "Workbench::PrepScrapPrompt";
      
      private static const EVENT_PREP_AUTO_SCRAP:String = // method body index: 1777 method index: 1777
      "Workbench::PrepAutoScrap";
      
      private static const EVENT_PREP_SCRAPBOX_TRANSFER:String = // method body index: 1777 method index: 1777
      "Container::transferToScrapboxPrepDialog";
      
      private static const EVENT_SCRAP_ITEM:String = // method body index: 1777 method index: 1777
      "Workbench::ScrapItem";
      
      private static const EVENT_SCRAP_ALL_JUNK:String = // method body index: 1777 method index: 1777
      "Workbench::ScrapAllJunk";
      
      private static const EVENT_SCRAPBOX_TRANSFER_JUNK:String = // method body index: 1777 method index: 1777
      "Container::transferToScrapboxConfirm";
      
      private static const EVENT_SCRAPBOX_SCRAP_TRANSFER_PREP = // method body index: 1777 method index: 1777
      "Container::transferSelectionToScrapPrepDialog";
      
      private static const EVENT_SCRAPBOX_SCRAP_TRANSFER_CONFIRM = // method body index: 1777 method index: 1777
      "Container::transferSelectionToScrapConfirm";
      
      public static const EVENT_CLOSED:String = // method body index: 1777 method index: 1777
      "SecureTradeScrapConfirmModal::EVENT_CLOSED";
       
      
      private var m_State:uint = 0;
      
      private var m_ItemData:Object;
      
      private var m_ScrapQuantity:uint;
      
      private var m_BackgroundDefaultWidth:Number;
      
      public function SecureTradeScrapConfirmModal()
      {
         // method body index: 1778 method index: 1778
         super();
         choiceButtonMode = BCBasicModal.BUTTON_MODE_BAR;
         this.m_BackgroundDefaultWidth = Background_mc.width;
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1779 method index: 1779
         StyleSheet.apply(ComponentList_mc,false,ScrapComponentListStyle);
         BSUIDataManager.Subscribe("ContainerOptionsData",this.OnContainerOptionsData);
      }
      
      public function OnContainerOptionsData(arEvent:FromClientDataEvent) : *
      {
         // method body index: 1780 method index: 1780
         var data:Object = arEvent.data;
         ComponentList_mc.entryList = data.scrapComponentArray.sortOn("text");
         ComponentList_mc.InvalidateData();
         ComponentList_mc.allowWheelScrollNoSelectionChange = ComponentList_mc.entryList.length > ScrapComponentListStyle.numListItems_Inspectable;
         SetIsDirty();
      }
      
      public function ShowScrapModal(aItemData:Object, aScrapQuantity:uint) : *
      {
         // method body index: 1781 method index: 1781
         this.m_State = STATE_SCRAP;
         this.m_ScrapQuantity = aScrapQuantity;
         this.m_ItemData = {
            "text":aItemData.text,
            "serverHandleId":aItemData.serverHandleId,
            "favorite":aItemData.favorite
         };
         header = "$SCRAPTHISITEM";
         tooltip = aScrapQuantity == 1?this.m_ItemData.text:this.m_ItemData.text + " (" + aScrapQuantity + ")";
         m_AcceptButton.ButtonText = "$ACCEPT";
         m_CancelButton.ButtonText = "$CANCEL";
         Background_mc.width = this.m_BackgroundDefaultWidth;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PREP_SCRAP_PROMPT,{
            "serverHandleId":this.m_ItemData.serverHandleId,
            "quantity":aScrapQuantity
         }));
         stage.focus = ComponentList_mc;
         open = true;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
      }
      
      public function ShowScrapAllModal() : void
      {
         // method body index: 1782 method index: 1782
         this.m_State = STATE_SCRAP_ALL;
         header = "$ConfirmScrapAll";
         tooltip = "";
         m_AcceptButton.ButtonText = "$ACCEPT";
         m_CancelButton.ButtonText = "$CANCEL";
         Background_mc.width = this.m_BackgroundDefaultWidth;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PREP_AUTO_SCRAP,{}));
         stage.focus = ComponentList_mc;
         open = true;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
      }
      
      public function ShowScrapboxTransferModal() : void
      {
         // method body index: 1783 method index: 1783
         this.m_State = STATE_SCRAPBOX_TRANSFER_JUNK;
         header = "$ConfirmScrapAllStoreStashbox";
         tooltip = "";
         m_AcceptButton.ButtonText = "$ACCEPT";
         m_CancelButton.ButtonText = "$CANCEL";
         Background_mc.width = this.m_BackgroundDefaultWidth;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PREP_SCRAPBOX_TRANSFER,{}));
         stage.focus = ComponentList_mc;
         open = true;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
      }
      
      public function ShowScrapboxScrapTransferSelectionModal(aItemData:Object, aScrapQuantity:uint) : void
      {
         // method body index: 1784 method index: 1784
         this.m_State = STATE_SCRAPBOX_SCRAP_TRANSFER_SELECTION;
         this.m_ScrapQuantity = aScrapQuantity;
         this.m_ItemData = {
            "text":aItemData.text,
            "clientHandleId":aItemData.clientHandleId,
            "serverHandleId":aItemData.serverHandleId,
            "favorite":aItemData.favorite
         };
         header = "$SCRAPANDSTASHTHISITEM";
         tooltip = aScrapQuantity == 1?this.m_ItemData.text:this.m_ItemData.text + " (" + aScrapQuantity + ")";
         m_AcceptButton.ButtonText = "$ACCEPT";
         m_CancelButton.ButtonText = "$CANCEL";
         Background_mc.width = this.m_BackgroundDefaultWidth;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCRAPBOX_SCRAP_TRANSFER_PREP,{
            "serverHandleId":this.m_ItemData.serverHandleId,
            "quantity":aScrapQuantity
         }));
         stage.focus = ComponentList_mc;
         open = true;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_POPUP);
      }
      
      public function HandlePrimaryAction() : *
      {
         // method body index: 1785 method index: 1785
         open = false;
         switch(this.m_State)
         {
            case STATE_SCRAP:
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCRAP_ITEM,{
                  "serverHandleId":this.m_ItemData.serverHandleId,
                  "quantity":this.m_ScrapQuantity
               }));
               GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
               dispatchEvent(new CustomEvent(EVENT_CLOSED,{
                  "accepted":true,
                  "favorite":this.m_ItemData.favorite
               },true,true));
               break;
            case STATE_SCRAP_ALL:
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCRAP_ALL_JUNK,{}));
               GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
               dispatchEvent(new CustomEvent(EVENT_CLOSED,{"accepted":true},true,true));
               break;
            case STATE_SCRAPBOX_TRANSFER_JUNK:
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCRAPBOX_TRANSFER_JUNK,{}));
               GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
               dispatchEvent(new CustomEvent(EVENT_CLOSED,{"accepted":true},true,true));
               break;
            case STATE_SCRAPBOX_SCRAP_TRANSFER_SELECTION:
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCRAPBOX_SCRAP_TRANSFER_CONFIRM,{
                  "serverHandleId":this.m_ItemData.serverHandleId,
                  "quantity":this.m_ScrapQuantity
               }));
               GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
               dispatchEvent(new CustomEvent(EVENT_CLOSED,{"accepted":true},true,true));
         }
      }
      
      public function HandleSecondaryAction() : *
      {
         // method body index: 1786 method index: 1786
         open = false;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_CANCEL);
         dispatchEvent(new CustomEvent(EVENT_CLOSED,{"accepted":false},true,true));
      }
   }
}
