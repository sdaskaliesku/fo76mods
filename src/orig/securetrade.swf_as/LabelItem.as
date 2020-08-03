package 
{
    import Shared.*;
    import flash.display.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class LabelItem extends flash.display.MovieClip
    {
        public function LabelItem(arg1:String, arg2:uint, arg3:Boolean)
        {
            super();
            this.m_ForceUppercase = arg3;
            this.AssociatedID = arg2;
            this.DisplayText = Shared.GlobalFunc.LocalizeFormattedString(arg1);
            this.DisplayText = this.m_ForceUppercase ? this.DisplayText.toUpperCase() : this.DisplayText;
            Shared.GlobalFunc.SetText(this.Label_tf, "<b>" + this.DisplayText + "</b>", true);
            if (this.textWidth > MaxTextWidth) 
            {
                this.Label_tf.width = MaxTextWidth;
                scaleform.gfx.TextFieldEx.setTextAutoSize(this.Label_tf, "shrink");
                Shared.GlobalFunc.SetText(this.Label_tf, "<b>" + this.DisplayText + "</b>", true);
            }
            this.Selected = false;
            return;
        }

        public function get forceUppercase():Boolean
        {
            return this.m_ForceUppercase;
        }

        public function set forceUppercase(arg1:Boolean):*
        {
            this.m_ForceUppercase = arg1;
            return;
        }

        public function get selectable():Boolean
        {
            return this.Selectable;
        }

        public function set selectable(arg1:Boolean):*
        {
            this.Selectable = arg1;
            this.selected = this.Selected;
            return;
        }

        public function get id():uint
        {
            return this.AssociatedID;
        }

        public function get text():String
        {
            return this.DisplayText;
        }

        public function get textWidth():*
        {
            return this.Label_tf.textWidth;
        }

        public function set selected(arg1:Boolean):*
        {
            this.Selected = arg1;
            this.colorUpdate();
            return;
        }

        public function set showAsEnabled(arg1:Boolean):*
        {
            this.Enabled = arg1;
            this.colorUpdate();
            return;
        }

        public function set maxWidth(arg1:*):*
        {
            this.StringWidth = arg1;
            this.Label_tf.width = this.maxWidth;
            return;
        }

        public function get maxWidth():*
        {
            return this.StringWidth + LABEL_BUFFER_X + LABEL_BUFFER_X;
        }

        internal function colorUpdate():*
        {
            var loc1:*=0;
            if (!this.Selected) 
            {
                loc1 = this.Enabled ? 16777163 : 5661031;
            }
            this.Label_tf.textColor = loc1;
            this.Label_tf.alpha = this.Selectable ? 1 : Shared.GlobalFunc.DIMMED_ALPHA;
            return;
        }

        internal static const MaxTextWidth:int=130;

        internal static const LABEL_BUFFER_X:Number=8.35;

        internal var DisplayText:String;

        internal var AssociatedID:uint;

        public var Label_tf:flash.text.TextField;

        protected var Selected:Boolean=false;

        protected var Enabled:Boolean=true;

        protected var Selectable:Boolean=true;

        protected var StringWidth:Number=0;

        internal var m_ForceUppercase:Boolean=true;
    }
}
