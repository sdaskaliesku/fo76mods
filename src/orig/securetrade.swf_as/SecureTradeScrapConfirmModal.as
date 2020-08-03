package 
{
    import Shared.*;
    import Shared.AS3.*;
    import Shared.AS3.Data.*;
    import Shared.AS3.Events.*;
    import Shared.AS3.Styles.*;
    
    public class SecureTradeScrapConfirmModal extends Shared.AS3.BCBasicModal
    {
        public function SecureTradeScrapConfirmModal()
        {
            super();
            choiceButtonMode = Shared.AS3.BCBasicModal.BUTTON_MODE_BAR;
            this.m_BackgroundDefaultWidth = Background_mc.width;
            return;
        }

        public override function onAddedToStage():void
        {
            Shared.AS3.StyleSheet.apply(ComponentList_mc, false, Shared.AS3.Styles.ScrapComponentListStyle);
            Shared.AS3.Data.BSUIDataManager.Subscribe("ContainerOptionsData", this.OnContainerOptionsData);
            return;
        }

        public function OnContainerOptionsData(arg1:Shared.AS3.Data.FromClientDataEvent):*
        {
            var loc1:*=arg1.data;
            ComponentList_mc.entryList = loc1.scrapComponentArray.sortOn("text");
            ComponentList_mc.InvalidateData();
            ComponentList_mc.allowWheelScrollNoSelectionChange = ComponentList_mc.entryList.length > Shared.AS3.Styles.ScrapComponentListStyle.numListItems_Inspectable;
            SetIsDirty();
            return;
        }

        public function ShowScrapModal(arg1:Object, arg2:uint):*
        {
            this.m_State = STATE_SCRAP;
            this.m_ScrapQuantity = arg2;
            this.m_ItemData = {"text":arg1.text, "serverHandleId":arg1.serverHandleId, "favorite":arg1.favorite};
            header = "$SCRAPTHISITEM";
            tooltip = arg2 != 1 ? this.m_ItemData.text + " (" + arg2 + ")" : this.m_ItemData.text;
            m_AcceptButton.ButtonText = "$ACCEPT";
            m_CancelButton.ButtonText = "$CANCEL";
            Background_mc.width = this.m_BackgroundDefaultWidth;
            Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_PREP_SCRAP_PROMPT, {"serverHandleId":this.m_ItemData.serverHandleId, "quantity":arg2}));
            stage.focus = ComponentList_mc;
            open = true;
            Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_POPUP);
            return;
        }

        public function ShowScrapAllModal():void
        {
            this.m_State = STATE_SCRAP_ALL;
            header = "$ConfirmScrapAll";
            tooltip = "";
            m_AcceptButton.ButtonText = "$ACCEPT";
            m_CancelButton.ButtonText = "$CANCEL";
            Background_mc.width = this.m_BackgroundDefaultWidth;
            Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_PREP_AUTO_SCRAP, {}));
            stage.focus = ComponentList_mc;
            open = true;
            Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_POPUP);
            return;
        }

        public function ShowScrapboxTransferModal():void
        {
            this.m_State = STATE_SCRAPBOX_TRANSFER_JUNK;
            header = "$ConfirmScrapAllStoreStashbox";
            tooltip = "";
            m_AcceptButton.ButtonText = "$ACCEPT";
            m_CancelButton.ButtonText = "$CANCEL";
            Background_mc.width = this.m_BackgroundDefaultWidth;
            Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_PREP_SCRAPBOX_TRANSFER, {}));
            stage.focus = ComponentList_mc;
            open = true;
            Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_POPUP);
            return;
        }

        public function ShowScrapboxScrapTransferSelectionModal(arg1:Object, arg2:uint):void
        {
            this.m_State = STATE_SCRAPBOX_SCRAP_TRANSFER_SELECTION;
            this.m_ScrapQuantity = arg2;
            this.m_ItemData = {"text":arg1.text, "clientHandleId":arg1.clientHandleId, "serverHandleId":arg1.serverHandleId, "favorite":arg1.favorite};
            header = "$SCRAPANDSTASHTHISITEM";
            tooltip = arg2 != 1 ? this.m_ItemData.text + " (" + arg2 + ")" : this.m_ItemData.text;
            m_AcceptButton.ButtonText = "$ACCEPT";
            m_CancelButton.ButtonText = "$CANCEL";
            Background_mc.width = this.m_BackgroundDefaultWidth;
            Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_SCRAPBOX_SCRAP_TRANSFER_PREP, {"serverHandleId":this.m_ItemData.serverHandleId, "quantity":arg2}));
            stage.focus = ComponentList_mc;
            open = true;
            Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_POPUP);
            return;
        }

        public function HandlePrimaryAction():*
        {
            open = false;
            var loc1:*=this.m_State;
            switch (loc1) 
            {
                case STATE_SCRAP:
                {
                    Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_SCRAP_ITEM, {"serverHandleId":this.m_ItemData.serverHandleId, "quantity":this.m_ScrapQuantity}));
                    Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_OK);
                    dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_CLOSED, {"accepted":true, "favorite":this.m_ItemData.favorite}, true, true));
                    break;
                }
                case STATE_SCRAP_ALL:
                {
                    Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_SCRAP_ALL_JUNK, {}));
                    Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_OK);
                    dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_CLOSED, {"accepted":true}, true, true));
                    break;
                }
                case STATE_SCRAPBOX_TRANSFER_JUNK:
                {
                    Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_SCRAPBOX_TRANSFER_JUNK, {}));
                    Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_OK);
                    dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_CLOSED, {"accepted":true}, true, true));
                    break;
                }
                case STATE_SCRAPBOX_SCRAP_TRANSFER_SELECTION:
                {
                    Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_SCRAPBOX_SCRAP_TRANSFER_CONFIRM, {"serverHandleId":this.m_ItemData.serverHandleId, "quantity":this.m_ScrapQuantity}));
                    Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_OK);
                    dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_CLOSED, {"accepted":true}, true, true));
                    break;
                }
            }
            return;
        }

        public function HandleSecondaryAction():*
        {
            open = false;
            Shared.GlobalFunc.PlayMenuSound(Shared.GlobalFunc.MENU_SOUND_CANCEL);
            dispatchEvent(new Shared.AS3.Events.CustomEvent(EVENT_CLOSED, {"accepted":false}, true, true));
            return;
        }

        internal static const STATE_SCRAP:uint=1;

        internal static const STATE_SCRAP_ALL:uint=2;

        internal static const STATE_SCRAPBOX_TRANSFER_JUNK:uint=3;

        internal static const STATE_SCRAPBOX_SCRAP_TRANSFER_SELECTION:uint=4;

        internal static const EVENT_PREP_SCRAP_PROMPT:String="Workbench::PrepScrapPrompt";

        internal static const EVENT_PREP_AUTO_SCRAP:String="Workbench::PrepAutoScrap";

        internal static const EVENT_PREP_SCRAPBOX_TRANSFER:String="Container::transferToScrapboxPrepDialog";

        internal static const EVENT_SCRAP_ITEM:String="Workbench::ScrapItem";

        internal static const EVENT_SCRAP_ALL_JUNK:String="Workbench::ScrapAllJunk";

        internal static const EVENT_SCRAPBOX_TRANSFER_JUNK:String="Container::transferToScrapboxConfirm";

        internal static const EVENT_SCRAPBOX_SCRAP_TRANSFER_PREP:String="Container::transferSelectionToScrapPrepDialog";

        internal static const EVENT_SCRAPBOX_SCRAP_TRANSFER_CONFIRM:String="Container::transferSelectionToScrapConfirm";

        public static const EVENT_CLOSED:String="SecureTradeScrapConfirmModal::EVENT_CLOSED";

        internal var m_State:uint=0;

        internal var m_ItemData:Object;

        internal var m_ScrapQuantity:uint;

        internal var m_BackgroundDefaultWidth:Number;
    }
}
