package Shared.AS3 
{
    import flash.display.*;
    
    public class BCBasicMenuItem extends flash.display.MovieClip
    {
        public function BCBasicMenuItem()
        {
            super();
            if (this.HitArea_mc == null) 
            {
                if (this.Sizer_mc != null) 
                {
                    this.hitArea = this.Sizer_mc;
                }
            }
            else 
            {
                this.hitArea = this.HitArea_mc;
            }
            return;
        }

        public function set text(arg1:String):void
        {
            this.m_Text = arg1;
            if (this.Text_mc != null) 
            {
                this.Text_mc.Text_tf.text = this.m_Text;
            }
            return;
        }

        public function get text():String
        {
            return this.m_Text;
        }

        internal function updateState():void
        {
            if (this.m_Disabled) 
            {
                if (this.m_Selected) 
                {
                    gotoAndPlay("rollOnDisabled");
                }
                else 
                {
                    gotoAndPlay("offDisabled");
                }
            }
            else if (this.m_Selected) 
            {
                gotoAndPlay("rollOn");
            }
            else 
            {
                gotoAndPlay("off");
            }
            return;
        }

        public function set disabled(arg1:Boolean):void
        {
            if (arg1 != this.m_Disabled) 
            {
                this.m_Disabled = arg1;
                this.updateState();
            }
            return;
        }

        public function get disabled():Boolean
        {
            return this.m_Disabled;
        }

        public function set index(arg1:uint):void
        {
            this.m_Index = arg1;
            return;
        }

        public function get index():uint
        {
            return this.m_Index;
        }

        public function set selected(arg1:Boolean):void
        {
            if (arg1 != this.m_Selected) 
            {
                this.m_Selected = arg1;
                this.updateState();
            }
            return;
        }

        public var Sizer_mc:flash.display.MovieClip;

        public var HitArea_mc:flash.display.MovieClip;

        public var Text_mc:flash.display.MovieClip;

        public var Image_mc:flash.display.MovieClip;

        internal var m_Selected:Boolean=false;

        internal var m_Disabled:Boolean=false;

        internal var m_Text:String;

        internal var m_Index:uint=0;
    }
}
