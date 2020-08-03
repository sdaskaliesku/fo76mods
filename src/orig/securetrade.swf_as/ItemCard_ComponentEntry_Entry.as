package 
{
    import Shared.AS3.*;
    import flash.display.*;
    import flash.text.*;
    
    public class ItemCard_ComponentEntry_Entry extends Shared.AS3.BSScrollingListEntry
    {
        public function ItemCard_ComponentEntry_Entry()
        {
            super();
            return;
        }

        public override function SetEntryText(arg1:Object, arg2:String):*
        {
            var loc1:*=null;
            var loc2:*=NaN;
            super.SetEntryText(arg1, arg2);
            if (!(arg1.count == 1) && !(arg1.count == undefined)) 
            {
                textField.appendText(" (" + arg1.count + ")");
            }
            if (this.FavIcon_mc != null) 
            {
                loc1 = textField.getLineMetrics(0);
                loc2 = textField.x + loc1.x + loc1.width + this.FavIcon_mc.width / 2 + ICON_SPACING;
                this.FavIcon_mc.x = loc2;
                this.FavIcon_mc.visible = arg1.favorite > 0 || arg1.taggedForSearch;
            }
            return;
        }

        public static const ICON_SPACING:Number=15;

        public var FavIcon_mc:flash.display.MovieClip;
    }
}
