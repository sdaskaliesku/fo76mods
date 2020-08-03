package 
{
    import Shared.*;
    import Shared.AS3.*;
    import Shared.AS3.Events.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    
    public class LabelSelector extends Shared.AS3.BSUIComponent
    {
        public function LabelSelector()
        {
            this.LabelClass = LabelItem;
            this.LBButtonData = new Shared.AS3.BSButtonHintData("", "Z", "PSN_L1", "Xenon_L1", 1, null);
            this.RBButtonData = new Shared.AS3.BSButtonHintData("", "C", "PSN_R1", "Xenon_R1", 1, null);
            super();
            this.m_CenterPointOffset = this.BackerBar_mc.width / 2;
            this.Slider_mc = new flash.display.MovieClip();
            addChild(this.Slider_mc);
            this.Slider_mc.addChild(this.Selector_mc);
            if (this.SelectorGray_mc != null) 
            {
                this.Slider_mc.addChild(this.SelectorGray_mc);
            }
            this.LabelsA = new Vector.<LabelItem>();
            if (this.SelectorGray_mc != null) 
            {
                this.SelectorGray_mc.visible = false;
            }
            this.ButtonHintDataLeftV = new Vector.<Shared.AS3.BSButtonHintData>();
            this.ButtonHintDataLeftV.push(this.LBButtonData);
            this.ButtonLeft_mc.SetButtonHintData(this.ButtonHintDataLeftV);
            this.ButtonLeft_mc.useBackground = false;
            this.ButtonHintDataRightV = new Vector.<Shared.AS3.BSButtonHintData>();
            this.ButtonHintDataRightV.push(this.RBButtonData);
            this.ButtonRight_mc.SetButtonHintData(this.ButtonHintDataRightV);
            this.ButtonRight_mc.useBackground = false;
            this.AnimFrameMoveAmount = new Array(0.343588, 0.248381, 0.175842, 0.127915, 0.104275);
            return;
        }

        public function set labelWidthScale(arg1:Number):*
        {
            this.m_LabelWidthScale = arg1;
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

        public function set showDirectionalArrows(arg1:Boolean):*
        {
            this.ShowDirectionalArrows = arg1;
            return;
        }

        public function onLabelDataUpdate(arg1:Object):*
        {
            var loc3:*=undefined;
            this.Clear();
            var loc1:*=arg1.labelsA.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = arg1.labelsA[loc2];
                this.AddLabel(loc3.displayName, loc3.id, loc3.selectable);
                ++loc2;
            }
            if (loc1 > 0) 
            {
                this.Finalize();
            }
            this.SelectedID = arg1.initialSelection;
            return;
        }

        public function set showAsEnabled(arg1:Boolean):*
        {
            this.Enabled = arg1;
            var loc1:*=0;
            while (loc1 < this.LabelsA.length) 
            {
                this.LabelsA[loc1].showAsEnabled = arg1;
                this.Selector_mc.visible = arg1 && this.FoundSelection;
                if (this.SelectorGray_mc != null) 
                {
                    this.SelectorGray_mc.visible = !arg1 && this.FoundSelection;
                }
                ++loc1;
            }
            var loc2:*;
            this.RBButtonData.ButtonEnabled = loc2 = arg1;
            this.LBButtonData.ButtonEnabled = loc2;
            return;
        }

        public function Clear():void
        {
            while (this.Slider_mc.numChildren > 0) 
            {
                this.Slider_mc.removeChildAt(0);
            }
            this.Slider_mc.addChild(this.Selector_mc);
            if (this.SelectorGray_mc != null) 
            {
                this.Slider_mc.addChild(this.SelectorGray_mc);
            }
            this.LabelsA.splice(0, this.LabelsA.length);
            this.SelectedIndex = 0;
            SetIsDirty();
            return;
        }

        public function SetCodeObj(arg1:Object):*
        {
            this.BGSCodeObj = arg1;
            return;
        }

        public function get maxStringWidth():Number
        {
            return this.MaxStringWidth;
        }

        public function set maxStringWidth(arg1:Number):*
        {
            this.MaxStringWidth = arg1;
            return;
        }

        public function onCodeObjDestruction():void
        {
            this.BGSCodeObj = null;
            return;
        }

        public function AddLabel(arg1:String, arg2:uint, arg3:Boolean):*
        {
            var loc1:*=new this.LabelClass(arg1, arg2, this.m_ForceUppercase) as LabelItem;
            this.Slider_mc.addChild(loc1);
            loc1.selectable = arg3;
            loc1.addEventListener(flash.events.MouseEvent.CLICK, this.OnLabelPressed);
            this.LabelsA.push(loc1);
            return;
        }

        public function OnLabelPressed(arg1:flash.events.MouseEvent):void
        {
            var loc2:*=null;
            var loc1:*=arg1.currentTarget as LabelItem;
            if (loc1) 
            {
                loc2 = new Object();
                loc2.id = loc1.id;
                loc2.Source = this;
                dispatchEvent(new Shared.AS3.Events.CustomEvent(LABEL_MOUSE_SELECTION_EVENT, loc2, true));
            }
            return;
        }

        public function Finalize(arg1:Boolean=true):*
        {
            var loc1:*=undefined;
            if (arg1) 
            {
                loc1 = 0;
                while (loc1 < this.LabelsA.length) 
                {
                    this.MaxStringWidth = Math.max(this.MaxStringWidth, this.LabelsA[loc1].textWidth);
                    ++loc1;
                }
            }
            this.TotalWidth = 0;
            loc1 = 0;
            while (loc1 < this.LabelsA.length) 
            {
                this.LabelsA[loc1].maxWidth = this.MaxStringWidth * this.m_LabelWidthScale;
                this.LabelsA[loc1].x = this.TotalWidth;
                this.LabelsA[loc1].y = 23;
                this.TotalWidth = this.TotalWidth + this.LabelsA[loc1].maxWidth;
                ++loc1;
            }
            this.Selector_mc.width = this.LabelsA[0].maxWidth;
            if (this.SelectorGray_mc != null) 
            {
                this.SelectorGray_mc.width = this.LabelsA[0].maxWidth;
            }
            if (arg1) 
            {
                dispatchEvent(new Shared.AS3.Events.CustomEvent(LABEL_SELECTOR_FINALIZED_EVENT, null, true));
            }
            return;
        }

        public function set leftIndex(arg1:uint):*
        {
            this.LeftIndex = arg1;
            return;
        }

        public function get SelectedID():uint
        {
            if (this.SelectedIndex == uint.MAX_VALUE) 
            {
                return uint.MAX_VALUE;
            }
            return this.LabelsA[this.SelectedIndex].id;
        }

        public function get selectedIndex():uint
        {
            return this.SelectedIndex;
        }

        public function set SelectedID(arg1:uint):*
        {
            this.FoundSelection = false;
            var loc1:*=0;
            while (loc1 < this.LabelsA.length) 
            {
                if (this.LabelsA[loc1].id == arg1) 
                {
                    this.SetLeftIndex(this.GetLeftIndex(loc1), false);
                    this.SetSelection(loc1, true, false);
                    this.FoundSelection = true;
                    break;
                }
                ++loc1;
            }
            if (!this.FoundSelection) 
            {
                if (this.LabelsA.length != 0) 
                {
                    this.SetLeftIndex(this.GetLeftIndex(0), false);
                    this.SetSelection(0, true, false);
                    this.FoundSelection = true;
                }
                else 
                {
                    this.Selector_mc.visible = false;
                    this.SelectorGray_mc.visible = false;
                }
            }
            return;
        }

        public function GetLeftIndex(arg1:int):*
        {
            var loc1:*=Math.floor(this.m_MaxVisible / 2);
            var loc2:*=Math.ceil(this.m_MaxVisible / 2);
            if (arg1 < loc2) 
            {
                return 0;
            }
            if (arg1 < this.LabelsA.length - loc1) 
            {
                return Math.max(arg1 - loc1, 0);
            }
            return Math.max(this.LabelsA.length - this.m_MaxVisible, 0);
        }

        public function get SelectedText():String
        {
            return this.LabelsA[this.SelectedIndex].text;
        }

        public function RemoveSelectedItem():*
        {
            this.Slider_mc.removeChild(this.LabelsA[this.SelectedIndex]);
            this.LabelsA.splice(this.SelectedIndex, 1);
            this.Finalize(false);
            if (this.SelectedIndex < this.LabelsA.length) 
            {
                this.SetSelection(this.SelectedIndex, true, true);
            }
            else if (this.LabelsA.length > 0) 
            {
                this.SetSelection((this.SelectedIndex - 1), true, true);
            }
            return;
        }

        public function SelectPrevious(arg1:Boolean=true):void
        {
            var loc1:*=0;
            if (this.Enabled && this.SelectedIndex > 0) 
            {
                loc1 = (this.SelectedIndex - 1);
                while (loc1 > -1) 
                {
                    if (this.LabelsA[loc1].selectable) 
                    {
                        this.SetSelection(loc1, true, arg1);
                        if (this.BGSCodeObj == null) 
                        {
                            Shared.GlobalFunc.PlayMenuSound("UIWorkshopModeMenuCategoryLeft");
                        }
                        else 
                        {
                            Shared.AS3.BGSExternalInterface.call(this.BGSCodeObj, "PlaySound", "UIWorkshopModeMenuCategoryLeft");
                        }
                    }
                    --loc1;
                }
            }
            return;
        }

        public function SelectNext(arg1:Boolean=true):void
        {
            var loc2:*=0;
            var loc1:*=this.LabelsA.length;
            if (this.Enabled && this.SelectedIndex < (loc1 - 1)) 
            {
                loc2 = this.SelectedIndex + 1;
                while (loc2 < loc1) 
                {
                    if (this.LabelsA[loc2].selectable) 
                    {
                        this.SetSelection(loc2, true, arg1);
                        if (this.BGSCodeObj == null) 
                        {
                            Shared.GlobalFunc.PlayMenuSound("UIWorkshopModeMenuCategoryRight");
                        }
                        else 
                        {
                            Shared.AS3.BGSExternalInterface.call(this.BGSCodeObj, "PlaySound", "UIWorkshopModeMenuCategoryRight");
                        }
                    }
                    ++loc2;
                }
            }
            return;
        }

        internal function GetOffsetForLeftIndex(arg1:uint):*
        {
            var loc1:*=(-arg1) * this.LabelsA[0].maxWidth;
            return loc1;
        }

        internal function GetCenteredOffsetForLeftIndex(arg1:uint):*
        {
            var loc1:*=this.LabelsA[0].maxWidth * Math.min(this.m_MaxVisible, this.LabelsA.length);
            var loc2:*=this.GetOffsetForLeftIndex(arg1) + this.m_CenterPointOffset - loc1 / 2;
            return loc2;
        }

        public function SetLeftIndex(arg1:uint, arg2:Boolean):*
        {
            this.LastSliderX = this.GetCenteredOffsetForLeftIndex(this.LeftIndex);
            this.Slider_mc.x = this.LastSliderX;
            this.TargetSliderX = this.GetCenteredOffsetForLeftIndex(arg1);
            this.UpdateLabelVisibility(this.LeftIndex, true);
            this.LeftIndex = arg1;
            if (arg2) 
            {
                this.AnimationFramesLeftSlider = this.AnimFrameCount;
            }
            else 
            {
                this.Slider_mc.x = this.TargetSliderX;
                this.AnimationFramesLeftSlider = 0;
            }
            this.UpdateLabelVisibility(arg1, !arg2);
            return;
        }

        public function UpdateLabelVisibility(arg1:*, arg2:*):*
        {
            var loc1:*=this.LabelsA.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (loc2 < arg1) 
                {
                    this.LabelsA[loc2].visible = false;
                }
                else if (loc2 < arg1 + this.m_MaxVisible) 
                {
                    if (arg2) 
                    {
                        this.LabelsA[loc2].visible = true;
                    }
                }
                else 
                {
                    this.LabelsA[loc2].visible = false;
                }
                ++loc2;
            }
            return;
        }

        public function GetRelativeSelectionIndex():uint
        {
            return this.SelectedIndex - this.LeftIndex;
        }

        public function UpdateSelection():*
        {
            if (this.SelectedIndex < uint.MAX_VALUE) 
            {
                this.SetSelection(this.SelectedIndex, true, false);
                this.LBButtonData.ButtonEnabled = this.SelectedIndex > 0;
                this.RBButtonData.ButtonEnabled = this.SelectedIndex < (this.LabelsA.length - 1);
            }
            return;
        }

        public function Update(arg1:Number):*
        {
            this.UpdateSelector(arg1);
            this.UpdateSlider(arg1);
            return;
        }

        public function UpdateSelector(arg1:Number):*
        {
            var loc1:*=undefined;
            var loc2:*=undefined;
            var loc3:*=undefined;
            if (this.AnimationFramesLeftSelector > 0) 
            {
                loc1 = arg1 / (1 / 30);
                loc2 = this.TargetSelectorX - this.LastSelectorX;
                loc3 = loc2 / this.AnimFrameCount;
                this.Selector_mc.x = this.Selector_mc.x + loc3 * loc1;
                if (this.SelectorGray_mc != null) 
                {
                    this.SelectorGray_mc.x = this.SelectorGray_mc.x + loc3 * loc1;
                }
                this.AnimationFramesLeftSelector = this.AnimationFramesLeftSelector - loc1;
                this.AnimationFramesLeftSelector = Math.max(this.AnimationFramesLeftSelector, 0);
                if (this.TargetSelectorX < this.LastSelectorX && this.Selector_mc.x < this.TargetSelectorX) 
                {
                    this.Selector_mc.x = this.TargetSelectorX;
                    if (this.SelectorGray_mc != null) 
                    {
                        this.SelectorGray_mc.x = this.TargetSelectorX;
                    }
                }
                else if (this.TargetSelectorX > this.LastSelectorX && this.Selector_mc.x > this.TargetSelectorX) 
                {
                    this.Selector_mc.x = this.TargetSelectorX;
                    if (this.SelectorGray_mc != null) 
                    {
                        this.SelectorGray_mc.x = this.TargetSelectorX;
                    }
                }
                if (this.AnimationFramesLeftSelector == 0) 
                {
                    this.LabelsA[this.SelectedIndex].selected = true;
                }
            }
            return;
        }

        public function get maxVisible():uint
        {
            return this.m_MaxVisible;
        }

        public function UpdateSlider(arg1:Number):*
        {
            var loc1:*=undefined;
            var loc2:*=undefined;
            var loc3:*=undefined;
            if (this.AnimationFramesLeftSlider > 0) 
            {
                loc1 = arg1 / (1 / 30);
                loc2 = this.TargetSliderX - this.LastSliderX;
                loc3 = loc2 / this.AnimFrameCount;
                this.Slider_mc.x = this.Slider_mc.x + loc3 * loc1;
                this.AnimationFramesLeftSlider = this.AnimationFramesLeftSlider - loc1;
                this.AnimationFramesLeftSlider = Math.max(this.AnimationFramesLeftSlider, 0);
                if (this.TargetSliderX < this.LastSliderX && this.Slider_mc.x < this.TargetSliderX) 
                {
                    this.Slider_mc.x = this.TargetSliderX;
                }
                else if (this.TargetSliderX > this.LastSliderX && this.Slider_mc.x > this.TargetSliderX) 
                {
                    this.Slider_mc.x = this.TargetSliderX;
                }
                if (this.AnimationFramesLeftSlider == 0) 
                {
                    this.Selector_mc.x = this.LabelsA[this.SelectedIndex].x;
                    if (this.SelectorGray_mc != null) 
                    {
                        this.SelectorGray_mc.x = this.LabelsA[this.SelectedIndex].x;
                    }
                    this.UpdateLabelVisibility(this.LeftIndex, true);
                    this.LabelsA[this.SelectedIndex].selected = true;
                }
            }
            return;
        }

        public function SetSelectable(arg1:uint, arg2:Boolean):*
        {
            var loc1:*=0;
            while (loc1 < this.LabelsA.length) 
            {
                if (this.LabelsA[loc1].id == arg1) 
                {
                    this.LabelsA[loc1].selectable = arg2;
                }
                ++loc1;
            }
            return;
        }

        public function MakeCurrentLabelUnselectable():*
        {
            var loc1:*=0;
            var loc2:*=uint.MAX_VALUE;
            this.LabelsA[this.SelectedIndex].selectable = false;
            loc1 = (this.SelectedIndex - 1) as int;
            while (loc2 == uint.MAX_VALUE && loc1 >= 0) 
            {
                if (this.LabelsA[loc1].selectable) 
                {
                    loc2 = loc1 as uint;
                }
                --loc1;
            }
            loc1 = this.SelectedIndex + 1 as int;
            while (loc2 == uint.MAX_VALUE && loc1 < this.LabelsA.length) 
            {
                if (this.LabelsA[loc1].selectable) 
                {
                    loc2 = loc1 as uint;
                }
                ++loc1;
            }
            this.SetSelection(loc2, true, false);
            return;
        }

        public function GetLabelIndex(arg1:uint):int
        {
            var loc1:*=0;
            while (loc1 < this.LabelsA.length) 
            {
                if (this.LabelsA[loc1].id == arg1) 
                {
                    return loc1;
                }
                ++loc1;
            }
            return -1;
        }

        public function GetLabel(arg1:int):LabelItem
        {
            if (arg1 >= 0 && arg1 < this.LabelsA.length) 
            {
                return this.LabelsA[arg1];
            }
            throw new Error("LabelSelector::GetLabel() - aIndex out of range.");
        }

        public function get lButtonData():Shared.AS3.BSButtonHintData
        {
            return this.LBButtonData;
        }

        public function get rButtonData():Shared.AS3.BSButtonHintData
        {
            return this.RBButtonData;
        }

        public function set LabelClassOverride(arg1:String):void
        {
            this.LabelClass = flash.utils.getDefinitionByName(arg1) as Class;
            return;
        }

        public function set maxVisible(arg1:uint):void
        {
            this.m_MaxVisible = arg1;
            return;
        }

        public function SetSelection(arg1:uint, arg2:Boolean, arg3:Boolean):*
        {
            if (this.SelectedIndex < uint.MAX_VALUE) 
            {
                this.LabelsA[this.SelectedIndex].selected = false;
            }
            var loc1:*=0;
            if (this.LabelsA.length) 
            {
                loc1 = this.LabelsA[0].maxWidth;
            }
            this.SelectedIndex = arg1;
            if (arg3 && this.AnimFrameCount <= 0) 
            {
                this.LastSelectorX = this.Selector_mc.x;
                this.TargetSelectorX = arg1 * loc1;
                this.AnimationFramesLeftSelector = this.AnimFrameCount;
            }
            else 
            {
                this.Selector_mc.x = arg1 * loc1;
                if (this.SelectorGray_mc != null) 
                {
                    this.SelectorGray_mc.x = arg1 * loc1;
                }
                this.LabelsA[this.SelectedIndex].selected = true;
            }
            this.SetLeftIndex(this.GetLeftIndex(this.SelectedIndex), arg3);
            var loc2:*;
            (loc2 = new Object()).Text = this.LabelsA[arg1].text;
            loc2.ID = this.LabelsA[arg1].id;
            loc2.Source = this;
            loc2.HandleSelectionImmediately = arg2;
            this.LBButtonData.ButtonEnabled = arg1 > 0;
            this.RBButtonData.ButtonEnabled = arg1 < (this.LabelsA.length - 1);
            dispatchEvent(new Shared.AS3.Events.CustomEvent(LABEL_SELECTED_EVENT, loc2, true));
            return;
        }

        public function get labelWidthScale():Number
        {
            return this.m_LabelWidthScale;
        }

        public static const LABEL_SELECTOR_FINALIZED_EVENT:String="LabelSelectorFinalizedEvent";

        internal const AnimFrameCount:Number=5;

        public static const LABEL_SELECTED_EVENT:String="LabelSelectedEvent";

        public static const LABEL_MOUSE_SELECTION_EVENT:String="LabelMouseSelectionEvent";

        public var ButtonRight_mc:Shared.AS3.BSButtonHintBar;

        public var ArrowLeftKeyboard_tf:flash.text.TextField;

        public var ArrowRightKeyboard_tf:flash.text.TextField;

        public var ArrowLeftConsole_tf:flash.text.TextField;

        public var ArrowRightConsole_tf:flash.text.TextField;

        public var BackerBar_mc:flash.display.MovieClip;

        internal var LabelsA:__AS3__.vec.Vector.<LabelItem>;

        internal var LeftIndex:int=0;

        internal var SelectedIndex:uint=4294967295;

        internal var LabelClass:Class;

        internal var TotalWidth:Number=0;

        internal var MaxDisplayWidth:Number=0;

        internal var m_MaxVisible:uint=9;

        internal var ButtonHintDataLeftV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;

        internal var ButtonHintDataRightV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;

        internal var LBButtonData:Shared.AS3.BSButtonHintData;

        public var Slider_mc:flash.display.MovieClip;

        internal var LastSliderX:*=0;

        internal var TargetSliderX:*=0;

        internal var LastSelectorX:*=0;

        internal var TargetSelectorX:*=0;

        internal var AnimationFramesLeftSelector:Number=0;

        internal var AnimationFramesLeftSlider:Number=0;

        internal var m_LabelWidthScale:Number=1;

        internal var m_ForceUppercase:Boolean=true;

        internal var MaxStringWidth:*=0;

        internal var Enabled:*=true;

        internal var FoundSelection:Boolean=false;

        public var Selector_mc:flash.display.MovieClip;

        internal var AnimFrameMoveAmount:Array;

        internal var m_CenterPointOffset:Number=640;

        public var BGSCodeObj:Object;

        internal var ShowDirectionalArrows:Boolean=true;

        public var SelectorGray_mc:flash.display.MovieClip;

        public var ButtonLeft_mc:Shared.AS3.BSButtonHintBar;

        internal var RBButtonData:Shared.AS3.BSButtonHintData;
    }
}
