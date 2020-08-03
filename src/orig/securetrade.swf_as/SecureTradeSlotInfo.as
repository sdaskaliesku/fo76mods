package 
{
    import Shared.*;
    import Shared.AS3.*;
    import Shared.AS3.Data.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class SecureTradeSlotInfo extends Shared.AS3.BSUIComponent
    {
        public function SecureTradeSlotInfo()
        {
            var loc1:*=null;
            super();
            addFrameScript(0, this.frame1, 1, this.frame2);
            gotoAndStop(FRAME_ICON);
            visible = false;
            mouseEnabled = false;
            mouseChildren = false;
            scaleform.gfx.Extensions.enabled = true;
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.Header_mc.Text_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            new Vector.<flash.display.MovieClip>(2)[0] = this.Slot1_mc;
            new Vector.<flash.display.MovieClip>(2)[1] = this.Slot2_mc;
            this.m_SlotClips = new Vector.<flash.display.MovieClip>(2);
            var loc2:*=0;
            var loc3:*=this.m_SlotClips;
            for each (loc1 in loc3) 
            {
                if (!loc1) 
                {
                    continue;
                }
                scaleform.gfx.TextFieldEx.setTextAutoSize(loc1.Text_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            }
            this.Icon_mc.clipWidth = this.Icon_mc.width * 1 / this.Icon_mc.scaleX;
            this.Icon_mc.clipHeight = this.Icon_mc.height * 1 / this.Icon_mc.scaleY;
            return;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            Shared.AS3.Data.BSUIDataManager.Subscribe("OtherInventoryTypeData", this.onOtherInvTypeDataUpdate);
            return;
        }

        internal function onOtherInvTypeDataUpdate(arg1:Shared.AS3.Data.FromClientDataEvent):void
        {
            var loc1:*=arg1.data;
            this.m_SlotData = loc1.slotDataA;
            this.m_OwnsVendor = loc1.ownsVendor;
            this.m_MenuMode = loc1.menuType;
            visible = this.m_OwnsVendor && this.m_SlotData && this.m_SlotData.length > 0 && !(loc1.menuSubType == Shared.AS3.SecureTradeShared.SUB_MODE_ARMOR_RACK);
            if (visible) 
            {
                this.Update();
            }
            return;
        }

        public function Update():*
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            loc2 = [];
            var loc10:*=0;
            var loc11:*=this.m_SlotData;
            for each (loc1 in loc11) 
            {
                loc2.push({"slotType":loc1.slotType, "slotTypeText":loc1.slotTypeText, "slotCountFilled":loc1.slotCountFilled, "slotCountMax":loc1.slotCountMax});
            }
            loc2.sortOn("slotType");
            loc3 = (loc2.length - 1);
            while (loc3 > 0) 
            {
                loc5 = loc2[(loc3 - 1)];
                loc6 = loc2[loc3];
                if (loc5.slotType == loc6.slotType) 
                {
                    loc5.slotCountFilled = loc5.slotCountFilled + loc6.slotCountFilled;
                    loc5.slotCountMax = loc5.slotCountMax + loc6.slotCountMax;
                    loc2.splice(loc3, 1);
                }
                --loc3;
            }
            var loc4:*=2;
            loc3 = 0;
            while (loc3 < this.m_SlotClips.length) 
            {
                if (loc7 == this.m_SlotClips[loc3] as flash.display.MovieClip) 
                {
                    loc8 = loc7.Text_tf;
                    loc7.visible = loc3 < loc2.length;
                    if (loc3 < loc2.length) 
                    {
                        loc1 = loc2[loc3];
                        if (loc1.slotType != 0) 
                        {
                            Shared.GlobalFunc.SetText(loc8, "$SecureTrade_ItemSlotTypeAndCounts");
                            loc9 = (loc9 = (loc9 = (loc9 = loc8.text).replace("{1}", loc1.slotTypeText)).replace("{2}", loc1.slotCountFilled)).replace("{3}", loc1.slotCountMax);
                        }
                        else 
                        {
                            Shared.GlobalFunc.SetText(loc8, "$SecureTrade_ItemSlotCounts");
                            loc9 = (loc9 = (loc9 = loc8.text).replace("{1}", loc1.slotCountFilled)).replace("{2}", loc1.slotCountMax);
                        }
                        Shared.GlobalFunc.SetText(loc8, loc9);
                    }
                }
                ++loc3;
            }
            this.Icon_mc.removeChildren();
            loc10 = this.m_MenuMode;
            switch (loc10) 
            {
                case Shared.AS3.SecureTradeShared.MODE_VENDING_MACHINE:
                {
                    Shared.GlobalFunc.SetText(this.Header_mc.Text_tf, "$SecureTrade_SlotHeader_VendingMachine");
                    this.Icon_mc.setContainerIconClip("IconV_Vendor");
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_DISPLAY_CASE:
                {
                    Shared.GlobalFunc.SetText(this.Header_mc.Text_tf, "$SecureTrade_SlotHeader_DisplayCase");
                    this.Icon_mc.setContainerIconClip("IconV_Display");
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_FERMENTER:
                {
                    Shared.GlobalFunc.SetText(this.Header_mc.Text_tf, "$SecureTrade_SlotHeader_Fermenter");
                    this.Icon_mc.setContainerIconClip("IconV_Fermenter");
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_REFRIGERATOR:
                {
                    Shared.GlobalFunc.SetText(this.Header_mc.Text_tf, "$SecureTrade_SlotHeader_Refrigerator");
                    this.Icon_mc.setContainerIconClip("IconV_Refrigerator");
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_CAMP_DISPENSER:
                {
                    Shared.GlobalFunc.SetText(this.Header_mc.Text_tf, "$SecureTrade_SlotHeader_Dispenser");
                    this.Icon_mc.setContainerIconClip("IconV_Keg");
                    break;
                }
                case Shared.AS3.SecureTradeShared.MODE_ALLY:
                {
                    Shared.GlobalFunc.SetText(this.Header_mc.Text_tf, "$SecureTrade_SlotHeader_Ally");
                    Shared.GlobalFunc.SetText(this.Slot1_mc.Text_tf, "$SecureTrade_SlotHeader_AllyStats");
                    this.Icon_mc.setContainerIconClip("IconV_Ally");
                    break;
                }
                default:
                {
                    Shared.GlobalFunc.SetText(this.Header_mc.Text_tf, "");
                    break;
                }
            }
            return;
        }

        public function isSlotDataValid():Boolean
        {
            return !(this.m_SlotData == null) && this.m_SlotData.length > 0;
        }

        public function AreSlotsFull():Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.m_SlotData;
            for each (loc1 in loc3) 
            {
                if (!(loc1.slotCountFilled < loc1.slotCountMax)) 
                {
                    continue;
                }
                return false;
            }
            return true;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        internal function frame2():*
        {
            stop();
            return;
        }

        internal static const FRAME_NO_ICON:int=1;

        internal static const FRAME_ICON:int=2;

        public var Header_mc:flash.display.MovieClip;

        public var Icon_mc:Shared.AS3.SWFLoaderClip;

        public var Slot1_mc:flash.display.MovieClip;

        public var Slot2_mc:flash.display.MovieClip;

        internal var m_MenuMode:uint=4294967295;

        internal var m_OwnsVendor:Boolean=false;

        internal var m_SlotData:Array=null;

        internal var m_SlotClips:__AS3__.vec.Vector.<flash.display.MovieClip>;
    }
}
