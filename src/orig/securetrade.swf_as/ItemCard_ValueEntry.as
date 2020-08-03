package 
{
    import Shared.*;
    import Shared.AS3.*;
    import flash.display.*;
    import scaleform.gfx.*;
    
    public class ItemCard_ValueEntry extends ItemCard_Entry
    {
        public function ItemCard_ValueEntry()
        {
            var loc1:*=null;
            super();
            scaleform.gfx.Extensions.enabled = true;
            if (Label_tf != null) 
            {
                scaleform.gfx.TextFieldEx.setTextAutoSize(Label_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            }
            if (Value_tf != null) 
            {
                scaleform.gfx.TextFieldEx.setTextAutoSize(Value_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            }
            if (Icon_mc && Icon_mc is Shared.AS3.SWFLoaderClip) 
            {
                loc1 = Icon_mc as Shared.AS3.SWFLoaderClip;
                loc1.clipWidth = loc1.width * 1 / loc1.scaleX;
                loc1.clipHeight = loc1.height * 1 / loc1.scaleY;
            }
            return;
        }

        public function set currencyType(arg1:Number):*
        {
            this._currencyType = arg1;
            return;
        }

        public override function PopulateText(arg1:String):*
        {
            if (Label_tf != null) 
            {
                Shared.GlobalFunc.SetText(Label_tf, arg1, false);
            }
            return;
        }

        public override function PopulateEntry(arg1:Object):*
        {
            var loc1:*=null;
            this.PopulateText(arg1.text);
            if (Value_tf != null) 
            {
                loc1 = arg1.value;
                Shared.GlobalFunc.SetText(Value_tf, loc1, false);
                if (Icon_mc != null) 
                {
                    Icon_mc.x = Value_tf.x + Value_tf.width - Value_tf.getLineMetrics(0).width - Icon_mc.width - 8;
                    if (Icon_mc is Shared.AS3.SWFLoaderClip) 
                    {
                        if (this.currencyImageInstance != null) 
                        {
                            Icon_mc.removeChild(this.currencyImageInstance);
                            this.currencyImageInstance = null;
                        }
                        this.currencyImageInstance = Shared.AS3.SecureTradeShared.setCurrencyIcon(Icon_mc as Shared.AS3.SWFLoaderClip, this._currencyType);
                    }
                }
            }
            return;
        }

        internal var _currencyType:uint=0;

        internal var currencyImageInstance:flash.display.MovieClip;
    }
}
