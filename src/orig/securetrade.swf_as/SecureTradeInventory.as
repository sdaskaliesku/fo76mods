package 
{
    import Shared.AS3.*;
    import flash.display.*;
    import flash.events.*;
    import scaleform.gfx.*;
    
    public class SecureTradeInventory extends Shared.AS3.MenuComponent
    {
        public function SecureTradeInventory()
        {
            super();
            addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver);
            scaleform.gfx.TextFieldEx.setTextAutoSize(this.Header_mc.Header_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.CurrencyIcon_mc.clipWidth = this.CurrencyIcon_mc.width * 1 / this.CurrencyIcon_mc.scaleX;
            this.CurrencyIcon_mc.clipHeight = this.CurrencyIcon_mc.height * 1 / this.CurrencyIcon_mc.scaleY;
            return;
        }

        public function set header(arg1:String):void
        {
            this.Header_mc.Header_tf.text = arg1;
            return;
        }

        internal function onMouseOver(arg1:flash.events.MouseEvent):*
        {
            dispatchEvent(new flash.events.Event(MOUSE_OVER, true, true));
            return;
        }

        public override function set Active(arg1:*):void
        {
            connectButtonBar();
            _active = arg1;
            this.ItemList_mc.Active = arg1;
            return;
        }

        public function get selectedItemIndex():Number
        {
            return this.ItemList_mc.selectedIndex;
        }

        public function set selectedItemIndex(arg1:Number):*
        {
            this.ItemList_mc.setSelectedIndex(arg1);
            return;
        }

        public override function redrawUIComponent():void
        {
            var loc1:*=this.parent as SecureTrade;
            var loc2:*=Shared.AS3.SecureTradeShared.CURRENCY_CAPS;
            if (loc1) 
            {
                loc2 = loc1.currencyType;
                if (this.m_CurrencyIconInstance != null) 
                {
                    this.CurrencyIcon_mc.removeChild(this.m_CurrencyIconInstance);
                    this.m_CurrencyIconInstance = null;
                }
                this.m_CurrencyIconInstance = Shared.AS3.SecureTradeShared.setCurrencyIcon(this.CurrencyIcon_mc, loc2);
            }
            return;
        }

        public static const MOUSE_OVER:String="SecureTradeInventory::MouseOver";

        public var ItemList_mc:MenuListComponent;

        public var Header_mc:flash.display.MovieClip;

        public var CurrencyIcon_mc:Shared.AS3.SWFLoaderClip;

        internal var m_CurrencyIconInstance:flash.display.MovieClip;
    }
}
