package Shared.AS3 
{
    import Shared.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class BSScrollingListEntry extends flash.display.MovieClip
    {
        public function BSScrollingListEntry()
        {
            super();
            scaleform.gfx.Extensions.enabled = true;
            this.ORIG_BORDER_HEIGHT = this.border == null ? 0 : this.border.height;
            this.ORIG_BORDER_WIDTH = this.border == null ? 0 : this.border.width;
            this.ORIG_TEXT_COLOR = this.textField == null ? 16777163 : this.textField.textColor;
            if (this.textField != null) 
            {
                this.textField.mouseEnabled = false;
                if (this.textField.multiline) 
                {
                    this._HasDynamicHeight = true;
                }
            }
            if (this.Sizer_mc) 
            {
                this.hitArea = this.Sizer_mc;
            }
            return;
        }

        public function Dtor():*
        {
            return;
        }

        public function get parentClip():flash.display.MovieClip
        {
            return this._parentClip;
        }

        public function set parentClip(arg1:flash.display.MovieClip):*
        {
            this._parentClip = arg1;
            return;
        }

        public function get clipIndex():uint
        {
            return this._clipIndex;
        }

        public function set clipIndex(arg1:uint):*
        {
            this._clipIndex = arg1;
            return;
        }

        public function get clipRow():uint
        {
            return this._clipRow;
        }

        public function set clipRow(arg1:uint):*
        {
            this._clipRow = arg1;
            return;
        }

        public function get clipCol():uint
        {
            return this._clipCol;
        }

        public function set clipCol(arg1:uint):*
        {
            this._clipCol = arg1;
            return;
        }

        public function get itemIndex():uint
        {
            return this._itemIndex;
        }

        public function set itemIndex(arg1:uint):*
        {
            this._itemIndex = arg1;
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):*
        {
            this._selected = arg1;
            return;
        }

        public function get hasDynamicHeight():Boolean
        {
            return this._HasDynamicHeight;
        }

        public function get defaultHeight():Number
        {
            return this.ORIG_BORDER_HEIGHT;
        }

        public function get defaultWidth():Number
        {
            return this.ORIG_BORDER_WIDTH;
        }

        protected function SetColorTransform(arg1:Object, arg2:Boolean):*
        {
            var loc1:*=arg1.transform.colorTransform;
            loc1.redOffset = arg2 ? -255 : 0;
            loc1.greenOffset = arg2 ? -255 : 0;
            loc1.blueOffset = arg2 ? -255 : 0;
            arg1.transform.colorTransform = loc1;
            return;
        }

        public function SetEntryText(arg1:Object, arg2:String):*
        {
            var loc1:*=NaN;
            if (!(this.textField == null) && !(arg1 == null) && arg1.hasOwnProperty("text")) 
            {
                if (arg2 != Shared.AS3.BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT) 
                {
                    if (arg2 == Shared.AS3.BSScrollingList.TEXT_OPTION_MULTILINE) 
                    {
                        this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                        this.textField.multiline = true;
                        this.textField.wordWrap = true;
                    }
                }
                else 
                {
                    scaleform.gfx.TextFieldEx.setTextAutoSize(this.textField, "shrink");
                }
                if (arg1.text == undefined) 
                {
                    Shared.GlobalFunc.SetText(this.textField, " ", true);
                }
                else 
                {
                    Shared.GlobalFunc.SetText(this.textField, arg1.text, true);
                }
                this.textField.textColor = this.selected ? 0 : this.ORIG_TEXT_COLOR;
            }
            if (this.border != null) 
            {
                this.border.alpha = this.selected ? Shared.GlobalFunc.SELECTED_RECT_ALPHA : 0;
                if (!(this.textField == null) && arg2 == Shared.AS3.BSScrollingList.TEXT_OPTION_MULTILINE && this.textField.numLines > 1) 
                {
                    loc1 = this.textField.y - this.border.y;
                    this.border.height = this.textField.textHeight + loc1 * 2 + 5;
                }
                else 
                {
                    this.border.height = this.ORIG_BORDER_HEIGHT;
                }
            }
            return;
        }

        public var border:flash.display.MovieClip;

        public var textField:flash.text.TextField;

        public var Sizer_mc:flash.display.MovieClip;

        protected var _clipIndex:uint;

        protected var _clipRow:uint;

        protected var _clipCol:uint;

        protected var _itemIndex:uint;

        protected var _selected:Boolean;

        protected var _parentClip:flash.display.MovieClip;

        public var ORIG_BORDER_HEIGHT:Number;

        public var ORIG_BORDER_WIDTH:Number;

        public var ORIG_TEXT_COLOR:Number;

        protected var _HasDynamicHeight:Boolean=false;
    }
}
