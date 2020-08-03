package 
{
    import Shared.*;
    import Shared.AS3.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class ScrapComponentListEntry extends Shared.AS3.BSScrollingListEntry
    {
        public function ScrapComponentListEntry()
        {
            super();
            return;
        }

        public override function SetEntryText(arg1:Object, arg2:String):*
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (!(textField == null) && !(arg1 == null) && arg1.hasOwnProperty("text")) 
            {
                if (arg2 != Shared.AS3.BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT) 
                {
                    if (arg2 == Shared.AS3.BSScrollingList.TEXT_OPTION_MULTILINE) 
                    {
                        textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                        textField.multiline = true;
                        textField.wordWrap = true;
                    }
                }
                else 
                {
                    scaleform.gfx.TextFieldEx.setTextAutoSize(textField, "shrink");
                }
                if (arg1.text == undefined) 
                {
                    Shared.GlobalFunc.SetText(textField, " ", true);
                }
                else 
                {
                    loc1 = arg1.count == 1 ? arg1.text : arg1.text + " (" + arg1.count + ")";
                    Shared.GlobalFunc.SetText(textField, loc1, true);
                }
                textField.textColor = this.selected ? 0 : ORIG_TEXT_COLOR;
            }
            if (border != null) 
            {
                border.alpha = this.selected ? Shared.GlobalFunc.SELECTED_RECT_ALPHA : 0;
                if (!(textField == null) && arg2 == Shared.AS3.BSScrollingList.TEXT_OPTION_MULTILINE && textField.numLines > 1) 
                {
                    loc2 = textField.y - border.y;
                    border.height = textField.textHeight + loc2 * 2 + 5;
                }
                else 
                {
                    border.height = ORIG_BORDER_HEIGHT;
                }
            }
            return;
        }
    }
}
