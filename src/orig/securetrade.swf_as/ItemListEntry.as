package 
{
    import Shared.*;
    import Shared.AS3.*;
    import flash.display.*;
    
    public class ItemListEntry extends Shared.AS3.ItemListEntryBase
    {
        public function ItemListEntry()
        {
            super();
            this.BaseTextFieldWidth = textField.width;
            this.BaseTextFieldX = textField.x;
            return;
        }

        public override function SetEntryText(arg1:Object, arg2:String):*
        {
            var loc7:*=null;
            super.SetEntryText(arg1, arg2);
            var loc1:*=Shared.GlobalFunc.BuildLegendaryStarsGlyphString(arg1);
            var loc2:*=0;
            if (arg1.barterCount != undefined) 
            {
                loc2 = Shared.GlobalFunc.Clamp(arg1.barterCount, 0, arg1.count);
            }
            var loc3:*=arg1.count - loc2;
            Shared.GlobalFunc.SetText(textField, textField.text + loc1, false, false, true);
            if (loc3 != 1) 
            {
                textField.appendText(" (" + loc3 + ")");
            }
            if (arg1.isLearnedRecipe) 
            {
                textField.text = "$$Known " + textField.text;
            }
            Shared.GlobalFunc.SetText(textField, textField.text, false);
            if (this.LeftIcon_mc != null) 
            {
                SetColorTransform(this.LeftIcon_mc, this.selected);
                this.LeftIcon_mc.EquipIcon_mc.visible = !(arg1.equipState == 0);
                this.LeftIcon_mc.BestIcon_mc.visible = arg1.inContainer && arg1.bestInClass == true;
                if (this.LeftIcon_mc.BarterIcon_mc != undefined) 
                {
                    this.LeftIcon_mc.BarterIcon_mc.visible = loc2 < 0;
                }
            }
            var loc4:*;
            (loc4 = []).push({"clip":this.FavoriteIcon_mc, "visible":arg1.favorite > 0});
            loc4.push({"clip":this.questItemIcon_mc, "visible":arg1.isQuestItem || arg1.isSharedQuestItem});
            loc4.push({"clip":this.TaggedForSearchIcon_mc, "visible":arg1.taggedForSearch});
            loc4.push({"clip":this.SetBonusIcon_mc, "visible":arg1.isSetItem});
            this.questItemIcon_mc.gotoAndStop(arg1.isSharedQuestItem ? "shared" : "local");
            this.SetBonusIcon_mc.gotoAndStop(arg1.isSetBonusActive && !(arg1.equipState == 0) ? "active" : "inactive");
            var loc5:*=this.textField.getLineMetrics(0).width + this.textField.x;
            var loc6:*=10;
            var loc8:*=0;
            while (loc8 < loc4.length) 
            {
                if ((loc7 = loc4[loc8]).clip != null) 
                {
                    loc7.clip.visible = loc7.visible;
                    if (loc7.visible == true) 
                    {
                        SetColorTransform(loc7.clip, this.selected);
                        loc7.clip.x = loc5 + loc6;
                        loc6 = loc6 + (loc7.clip.width + 3);
                    }
                }
                ++loc8;
            }
            textField.width = this.BaseTextFieldWidth - loc6;
            return;
        }

        public var LeftIcon_mc:flash.display.MovieClip;

        public var FavoriteIcon_mc:flash.display.MovieClip;

        public var TaggedForSearchIcon_mc:flash.display.MovieClip;

        public var questItemIcon_mc:flash.display.MovieClip;

        public var SetBonusIcon_mc:flash.display.MovieClip;

        protected var BaseTextFieldWidth:uint;

        protected var BaseTextFieldX:Number;
    }
}
