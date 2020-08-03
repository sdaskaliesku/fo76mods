package 
{
    import flash.display.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class ItemCard_DescriptionEntry extends ItemCard_Entry
    {
        public function ItemCard_DescriptionEntry()
        {
            super();
            scaleform.gfx.TextFieldEx.setTextAutoSize(Label_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_NONE);
            Label_tf.autoSize = flash.text.TextFieldAutoSize.LEFT;
            Label_tf.multiline = true;
            Label_tf.wordWrap = true;
            return;
        }

        public override function PopulateEntry(arg1:Object):*
        {
            super.PopulateEntry(arg1);
            this.Background_mc.height = Label_tf.textHeight + 5;
            return;
        }

        public function PopulateEntries(arg1:Array):*
        {
            var loc2:*=null;
            super.PopulateEntry(arg1[0]);
            var loc1:*="";
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
            {
                if (loc1 == "") 
                {
                    loc1 = loc2.text;
                    continue;
                }
                loc1 = loc1 + ("$$ItemCard_DescriptionEntryConcatenator " + loc2.text);
            }
            PopulateText(loc1);
            this.Background_mc.height = Label_tf.textHeight + 5;
            return;
        }

        public var Background_mc:flash.display.MovieClip;
    }
}
