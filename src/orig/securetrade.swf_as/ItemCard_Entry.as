package 
{
    import Shared.*;
    import flash.display.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class ItemCard_Entry extends flash.display.MovieClip
    {
        public function ItemCard_Entry()
        {
            super();
            scaleform.gfx.Extensions.enabled = true;
            if (this.Label_tf != null) 
            {
                scaleform.gfx.TextFieldEx.setTextAutoSize(this.Label_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            }
            if (this.Value_tf != null) 
            {
                scaleform.gfx.TextFieldEx.setTextAutoSize(this.Value_tf, scaleform.gfx.TextFieldEx.TEXTAUTOSZ_SHRINK);
            }
            return;
        }

        public function PopulateText(arg1:String):*
        {
            if (this.Label_tf != null) 
            {
                Shared.GlobalFunc.SetText(this.Label_tf, arg1, false);
            }
            return;
        }

        public function PopulateEntry(arg1:Object):*
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=undefined;
            var loc5:*=undefined;
            this.PopulateText(arg1.text);
            if (this.Value_tf != null) 
            {
                if (arg1.value is String) 
                {
                    loc1 = arg1.value;
                }
                else 
                {
                    loc2 = arg1.value;
                    if (arg1.scaleWithDuration) 
                    {
                        loc2 = loc2 * arg1.duration;
                    }
                    loc3 = arg1.precision == undefined ? 0 : arg1.precision;
                    loc1 = loc2.toFixed(loc3);
                    if ((loc4 = loc1.indexOf(".")) > -1) 
                    {
                        loc5 = (loc1.length - 1);
                        while (loc5 > loc4) 
                        {
                            if (loc1.charAt(loc5) != "0") 
                            {
                                break;
                            }
                            --loc5;
                        }
                        loc1 = loc5 != loc4 ? loc1.substring(0, loc5 + 1) : loc1.substring(0, loc4);
                    }
                    if (arg1.showAsPercent) 
                    {
                        loc1 = loc1 + "%";
                    }
                }
                Shared.GlobalFunc.SetText(this.Value_tf, loc1, false);
                if (this.Icon_mc != null) 
                {
                    this.Icon_mc.x = this.Value_tf.x + this.Value_tf.width - this.Value_tf.getLineMetrics(0).width - this.Icon_mc.width / 2 - 8;
                }
            }
            if (!(this.Comparison_mc == null) && ShouldShowDifference(arg1)) 
            {
                var loc6:*=arg1.diffRating;
                switch (loc6) 
                {
                    case -3:
                    {
                        this.Comparison_mc.gotoAndStop("Worst");
                        break;
                    }
                    case -2:
                    {
                        this.Comparison_mc.gotoAndStop("Worse");
                        break;
                    }
                    case -1:
                    {
                        this.Comparison_mc.gotoAndStop("Bad");
                        break;
                    }
                    case 1:
                    {
                        this.Comparison_mc.gotoAndStop("Good");
                        break;
                    }
                    case 2:
                    {
                        this.Comparison_mc.gotoAndStop("Better");
                        break;
                    }
                    case 3:
                    {
                        this.Comparison_mc.gotoAndStop("Best");
                        break;
                    }
                    default:
                    {
                        this.Comparison_mc.gotoAndStop("None");
                        break;
                    }
                }
            }
            return;
        }

        public static function ShouldShowDifference(arg1:Object):Boolean
        {
            var loc1:*=arg1.precision == undefined ? 0 : arg1.precision;
            var loc2:*=1;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc2 = loc2 / 10;
                ++loc3;
            }
            return Math.abs(arg1.difference) >= loc2;
        }

        public var Label_tf:flash.text.TextField;

        public var Value_tf:flash.text.TextField;

        public var Comparison_mc:flash.display.MovieClip;

        public var Icon_mc:flash.display.MovieClip;

        public var Sizer_mc:flash.display.MovieClip;
    }
}
