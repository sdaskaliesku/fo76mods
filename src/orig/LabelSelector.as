 
package
{
   import Shared.AS3.BGSExternalInterface;
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class LabelSelector extends BSUIComponent
   {
      
      public static const LABEL_SELECTED_EVENT:String = // method body index: 1536 method index: 1536
      "LabelSelectedEvent";
      
      public static const LABEL_MOUSE_SELECTION_EVENT:String = // method body index: 1536 method index: 1536
      "LabelMouseSelectionEvent";
      
      public static const LABEL_SELECTOR_FINALIZED_EVENT:String = // method body index: 1536 method index: 1536
      "LabelSelectorFinalizedEvent";
       
      
      public var Slider_mc:MovieClip;
      
      public var Selector_mc:MovieClip;
      
      public var SelectorGray_mc:MovieClip;
      
      public var ButtonLeft_mc:BSButtonHintBar;
      
      public var ButtonRight_mc:BSButtonHintBar;
      
      public var ArrowLeftKeyboard_tf:TextField;
      
      public var ArrowRightKeyboard_tf:TextField;
      
      public var ArrowLeftConsole_tf:TextField;
      
      public var ArrowRightConsole_tf:TextField;
      
      public var BGSCodeObj:Object;
      
      public var BackerBar_mc:MovieClip;
      
      private var LabelsA:Vector.<LabelItem>;
      
      private var LeftIndex:int = 0;
      
      private var SelectedIndex:uint = 4.294967295E9;
      
      private var LabelClass:Class;
      
      private var TotalWidth:Number = 0.0;
      
      private var MaxDisplayWidth:Number = 0.0;
      
      private var m_MaxVisible:uint = 9;
      
      private var ButtonHintDataLeftV:Vector.<BSButtonHintData>;
      
      private var ButtonHintDataRightV:Vector.<BSButtonHintData>;
      
      private var LBButtonData:BSButtonHintData;
      
      private var RBButtonData:BSButtonHintData;
      
      private var LastSliderX = 0;
      
      private var TargetSliderX = 0;
      
      private var LastSelectorX = 0;
      
      private var TargetSelectorX = 0;
      
      private var AnimationFramesLeftSelector:Number = 0;
      
      private var AnimationFramesLeftSlider:Number = 0;
      
      private var m_LabelWidthScale:Number = 1;
      
      private var m_ForceUppercase:Boolean = true;
      
      private var MaxStringWidth = 0;
      
      private var ShowDirectionalArrows:Boolean = true;
      
      private var Enabled = true;
      
      private var FoundSelection:Boolean = false;
      
      private const AnimFrameCount:Number = 5;
      
      private var AnimFrameMoveAmount:Array;
      
      private var m_CenterPointOffset:Number = 640;
      
      public function LabelSelector()
      {
         // method body index: 1542 method index: 1542
         this.LabelClass = LabelItem;
         this.LBButtonData = new BSButtonHintData("","Z","PSN_L1","Xenon_L1",1,null);
         this.RBButtonData = new BSButtonHintData("","C","PSN_R1","Xenon_R1",1,null);
         super();
         this.m_CenterPointOffset = this.BackerBar_mc.width / 2;
         this.Slider_mc = new MovieClip();
         addChild(this.Slider_mc);
         this.Slider_mc.addChild(this.Selector_mc);
         if(this.SelectorGray_mc != null)
         {
            this.Slider_mc.addChild(this.SelectorGray_mc);
         }
         this.LabelsA = new Vector.<LabelItem>();
         if(this.SelectorGray_mc != null)
         {
            this.SelectorGray_mc.visible = false;
         }
         this.ButtonHintDataLeftV = new Vector.<BSButtonHintData>();
         this.ButtonHintDataLeftV.push(this.LBButtonData);
         this.ButtonLeft_mc.SetButtonHintData(this.ButtonHintDataLeftV);
         this.ButtonLeft_mc.useBackground = false;
         this.ButtonHintDataRightV = new Vector.<BSButtonHintData>();
         this.ButtonHintDataRightV.push(this.RBButtonData);
         this.ButtonRight_mc.SetButtonHintData(this.ButtonHintDataRightV);
         this.ButtonRight_mc.useBackground = false;
         this.AnimFrameMoveAmount = new Array(0.343588,0.248381,0.175842,0.127915,0.104275);
      }
      
      public function get lButtonData() : BSButtonHintData
      {
         // method body index: 1537 method index: 1537
         return this.LBButtonData;
      }
      
      public function get rButtonData() : BSButtonHintData
      {
         // method body index: 1538 method index: 1538
         return this.RBButtonData;
      }
      
      public function set LabelClassOverride(aClassName:String) : void
      {
         // method body index: 1539 method index: 1539
         this.LabelClass = getDefinitionByName(aClassName) as Class;
      }
      
      public function set maxVisible(aMax:uint) : void
      {
         // method body index: 1540 method index: 1540
         this.m_MaxVisible = aMax;
      }
      
      public function get maxVisible() : uint
      {
         // method body index: 1541 method index: 1541
         return this.m_MaxVisible;
      }
      
      public function get labelWidthScale() : Number
      {
         // method body index: 1543 method index: 1543
         return this.m_LabelWidthScale;
      }
      
      public function set labelWidthScale(aScale:Number) : *
      {
         // method body index: 1544 method index: 1544
         this.m_LabelWidthScale = aScale;
      }
      
      public function get forceUppercase() : Boolean
      {
         // method body index: 1545 method index: 1545
         return this.m_ForceUppercase;
      }
      
      public function set forceUppercase(aUpper:Boolean) : *
      {
         // method body index: 1546 method index: 1546
         this.m_ForceUppercase = aUpper;
      }
      
      public function set showDirectionalArrows(aShow:Boolean) : *
      {
         // method body index: 1547 method index: 1547
         this.ShowDirectionalArrows = aShow;
      }
      
      public function onLabelDataUpdate(aData:Object) : *
      {
         // method body index: 1548 method index: 1548
         var l:* = undefined;
         this.Clear();
         var numLabels:* = aData.labelsA.length;
         for(var i:* = 0; i < numLabels; i++)
         {
            l = aData.labelsA[i];
            this.AddLabel(l.displayName,l.id,l.selectable);
         }
         if(numLabels > 0)
         {
            this.Finalize();
         }
         this.SelectedID = aData.initialSelection;
      }
      
      public function set showAsEnabled(aEnabled:Boolean) : *
      {
         // method body index: 1549 method index: 1549
         this.Enabled = aEnabled;
         for(var i:* = 0; i < this.LabelsA.length; i++)
         {
            this.LabelsA[i].showAsEnabled = aEnabled;
            this.Selector_mc.visible = aEnabled && this.FoundSelection;
            if(this.SelectorGray_mc != null)
            {
               this.SelectorGray_mc.visible = !aEnabled && this.FoundSelection;
            }
         }
         this.LBButtonData.ButtonEnabled = this.RBButtonData.ButtonEnabled = aEnabled;
      }
      
      public function Clear() : void
      {
         // method body index: 1550 method index: 1550
         while(this.Slider_mc.numChildren > 0)
         {
            this.Slider_mc.removeChildAt(0);
         }
         this.Slider_mc.addChild(this.Selector_mc);
         if(this.SelectorGray_mc != null)
         {
            this.Slider_mc.addChild(this.SelectorGray_mc);
         }
         this.LabelsA.splice(0,this.LabelsA.length);
         this.SelectedIndex = 0;
         SetIsDirty();
      }
      
      public function SetCodeObj(aBGSCodeObj:Object) : *
      {
         // method body index: 1551 method index: 1551
         this.BGSCodeObj = aBGSCodeObj;
      }
      
      public function set maxStringWidth(aMaxStringWidth:Number) : *
      {
         // method body index: 1552 method index: 1552
         this.MaxStringWidth = aMaxStringWidth;
      }
      
      public function get maxStringWidth() : Number
      {
         // method body index: 1553 method index: 1553
         return this.MaxStringWidth;
      }
      
      public function onCodeObjDestruction() : void
      {
         // method body index: 1554 method index: 1554
         this.BGSCodeObj = null;
      }
      
      public function AddLabel(aName:String, aID:uint, aSelectable:Boolean) : *
      {
         // method body index: 1555 method index: 1555
         var newLabel:* = new this.LabelClass(aName,aID,this.m_ForceUppercase) as LabelItem;
         this.Slider_mc.addChild(newLabel);
         newLabel.selectable = aSelectable;
         newLabel.addEventListener(MouseEvent.CLICK,this.OnLabelPressed);
         this.LabelsA.push(newLabel);
      }
      
      public function OnLabelPressed(event:MouseEvent) : void
      {
         // method body index: 1556 method index: 1556
         var data:Object = null;
         var labelItem:LabelItem = event.currentTarget as LabelItem;
         if(labelItem)
         {
            data = new Object();
            data.id = labelItem.id;
            data.Source = this;
            dispatchEvent(new CustomEvent(LABEL_MOUSE_SELECTION_EVENT,data,true));
         }
      }
      
      public function Finalize(aCalcStringWidths:Boolean = true) : *
      {
         // method body index: 1557 method index: 1557
         var i:* = undefined;
         if(aCalcStringWidths)
         {
            for(i = 0; i < this.LabelsA.length; i++)
            {
               this.MaxStringWidth = Math.max(this.MaxStringWidth,this.LabelsA[i].textWidth);
            }
         }
         this.TotalWidth = 0;
         for(i = 0; i < this.LabelsA.length; i++)
         {
            this.LabelsA[i].maxWidth = this.MaxStringWidth * this.m_LabelWidthScale;
            this.LabelsA[i].x = this.TotalWidth;
            this.LabelsA[i].y = 23;
            this.TotalWidth = this.TotalWidth + this.LabelsA[i].maxWidth;
         }
         this.Selector_mc.width = this.LabelsA[0].maxWidth;
         if(this.SelectorGray_mc != null)
         {
            this.SelectorGray_mc.width = this.LabelsA[0].maxWidth;
         }
         if(aCalcStringWidths)
         {
            dispatchEvent(new CustomEvent(LABEL_SELECTOR_FINALIZED_EVENT,null,true));
         }
      }
      
      public function set leftIndex(aVal:uint) : *
      {
         // method body index: 1558 method index: 1558
         this.LeftIndex = aVal;
      }
      
      public function get SelectedID() : uint
      {
         // method body index: 1559 method index: 1559
         if(this.SelectedIndex == uint.MAX_VALUE)
         {
            return uint.MAX_VALUE;
         }
         return this.LabelsA[this.SelectedIndex].id;
      }
      
      public function get selectedIndex() : uint
      {
         // method body index: 1560 method index: 1560
         return this.SelectedIndex;
      }
      
      public function set SelectedID(aSelectedID:uint) : *
      {
         // method body index: 1561 method index: 1561
         this.FoundSelection = false;
         for(var i:int = 0; i < this.LabelsA.length; i++)
         {
            if(this.LabelsA[i].id == aSelectedID)
            {
               this.SetLeftIndex(this.GetLeftIndex(i),false);
               this.SetSelection(i,true,false);
               this.FoundSelection = true;
               break;
            }
         }
         if(!this.FoundSelection)
         {
            if(this.LabelsA.length == 0)
            {
               this.Selector_mc.visible = false;
               this.SelectorGray_mc.visible = false;
            }
            else
            {
               this.SetLeftIndex(this.GetLeftIndex(0),false);
               this.SetSelection(0,true,false);
               this.FoundSelection = true;
            }
         }
      }
      
      public function GetLeftIndex(aSel:int) : *
      {
         // method body index: 1562 method index: 1562
         var floor:* = Math.floor(this.m_MaxVisible / 2);
         var ceiling:* = Math.ceil(this.m_MaxVisible / 2);
         if(aSel < ceiling)
         {
            return 0;
         }
         if(aSel < this.LabelsA.length - floor)
         {
            return Math.max(aSel - floor,0);
         }
         return Math.max(this.LabelsA.length - this.m_MaxVisible,0);
      }
      
      public function get SelectedText() : String
      {
         // method body index: 1563 method index: 1563
         return this.LabelsA[this.SelectedIndex].text;
      }
      
      public function RemoveSelectedItem() : *
      {
         // method body index: 1564 method index: 1564
         this.Slider_mc.removeChild(this.LabelsA[this.SelectedIndex]);
         this.LabelsA.splice(this.SelectedIndex,1);
         this.Finalize(false);
         if(this.SelectedIndex < this.LabelsA.length)
         {
            this.SetSelection(this.SelectedIndex,true,true);
         }
         else if(this.LabelsA.length > 0)
         {
            this.SetSelection(this.SelectedIndex - 1,true,true);
         }
      }
      
      public function SelectPrevious(aAnimate:Boolean = true) : void
      {
         // method body index: 1565 method index: 1565
         var indexToSelect:int = 0;
         if(this.Enabled && this.SelectedIndex > 0)
         {
            for(indexToSelect = this.SelectedIndex - 1; indexToSelect > -1; indexToSelect--)
            {
               if(this.LabelsA[indexToSelect].selectable)
               {
                  this.SetSelection(indexToSelect,true,aAnimate);
                  if(this.BGSCodeObj != null)
                  {
                     BGSExternalInterface.call(this.BGSCodeObj,"PlaySound","UIWorkshopModeMenuCategoryLeft");
                  }
                  else
                  {
                     GlobalFunc.PlayMenuSound("UIWorkshopModeMenuCategoryLeft");
                  }
                  break;
               }
            }
         }
      }
      
      public function SelectNext(aAnimate:Boolean = true) : void
      {
         // method body index: 1566 method index: 1566
         var indexToSelect:int = 0;
         var numLabels:* = this.LabelsA.length;
         if(this.Enabled && this.SelectedIndex < numLabels - 1)
         {
            for(indexToSelect = this.SelectedIndex + 1; indexToSelect < numLabels; indexToSelect++)
            {
               if(this.LabelsA[indexToSelect].selectable)
               {
                  this.SetSelection(indexToSelect,true,aAnimate);
                  if(this.BGSCodeObj != null)
                  {
                     BGSExternalInterface.call(this.BGSCodeObj,"PlaySound","UIWorkshopModeMenuCategoryRight");
                  }
                  else
                  {
                     GlobalFunc.PlayMenuSound("UIWorkshopModeMenuCategoryRight");
                  }
                  break;
               }
            }
         }
      }
      
      private function GetOffsetForLeftIndex(aIndex:uint) : *
      {
         // method body index: 1567 method index: 1567
         var offset:* = -aIndex * this.LabelsA[0].maxWidth;
         return offset;
      }
      
      private function GetCenteredOffsetForLeftIndex(aIndex:uint) : *
      {
         // method body index: 1568 method index: 1568
         var currentWidth:* = this.LabelsA[0].maxWidth * Math.min(this.m_MaxVisible,this.LabelsA.length);
         var offset:* = this.GetOffsetForLeftIndex(aIndex) + this.m_CenterPointOffset - currentWidth / 2;
         return offset;
      }
      
      public function SetLeftIndex(aIndex:uint, aAnimate:Boolean) : *
      {
         // method body index: 1569 method index: 1569
         this.LastSliderX = this.GetCenteredOffsetForLeftIndex(this.LeftIndex);
         this.Slider_mc.x = this.LastSliderX;
         this.TargetSliderX = this.GetCenteredOffsetForLeftIndex(aIndex);
         this.UpdateLabelVisibility(this.LeftIndex,true);
         this.LeftIndex = aIndex;
         if(aAnimate)
         {
            this.AnimationFramesLeftSlider = this.AnimFrameCount;
         }
         else
         {
            this.Slider_mc.x = this.TargetSliderX;
            this.AnimationFramesLeftSlider = 0;
         }
         this.UpdateLabelVisibility(aIndex,!aAnimate);
      }
      
      public function UpdateLabelVisibility(aLeftIndex:*, aShow:*) : *
      {
         // method body index: 1570 method index: 1570
         var numLabels:* = this.LabelsA.length;
         for(var i:* = 0; i < numLabels; i++)
         {
            if(i < aLeftIndex)
            {
               this.LabelsA[i].visible = false;
            }
            else if(i < aLeftIndex + this.m_MaxVisible)
            {
               if(aShow)
               {
                  this.LabelsA[i].visible = true;
               }
            }
            else
            {
               this.LabelsA[i].visible = false;
            }
         }
      }
      
      public function GetRelativeSelectionIndex() : uint
      {
         // method body index: 1571 method index: 1571
         return this.SelectedIndex - this.LeftIndex;
      }
      
      public function UpdateSelection() : *
      {
         // method body index: 1572 method index: 1572
         if(this.SelectedIndex < uint.MAX_VALUE)
         {
            this.SetSelection(this.SelectedIndex,true,false);
            this.LBButtonData.ButtonEnabled = this.SelectedIndex > 0;
            this.RBButtonData.ButtonEnabled = this.SelectedIndex < this.LabelsA.length - 1;
         }
      }
      
      public function SetSelection(aSel:uint, aHandleSelectionImmediately:Boolean, aAnimate:Boolean) : *
      {
         // method body index: 1573 method index: 1573
         if(this.SelectedIndex < uint.MAX_VALUE)
         {
            this.LabelsA[this.SelectedIndex].selected = false;
         }
         var maxLabelWidth:* = 0;
         if(this.LabelsA.length)
         {
            maxLabelWidth = this.LabelsA[0].maxWidth;
         }
         this.SelectedIndex = aSel;
         if(aAnimate && this.AnimFrameCount <= 0)
         {
            this.LastSelectorX = this.Selector_mc.x;
            this.TargetSelectorX = aSel * maxLabelWidth;
            this.AnimationFramesLeftSelector = this.AnimFrameCount;
         }
         else
         {
            this.Selector_mc.x = aSel * maxLabelWidth;
            if(this.SelectorGray_mc != null)
            {
               this.SelectorGray_mc.x = aSel * maxLabelWidth;
            }
            this.LabelsA[this.SelectedIndex].selected = true;
         }
         this.SetLeftIndex(this.GetLeftIndex(this.SelectedIndex),aAnimate);
         var data:Object = new Object();
         data.Text = this.LabelsA[aSel].text;
         data.ID = this.LabelsA[aSel].id;
         data.Source = this;
         data.HandleSelectionImmediately = aHandleSelectionImmediately;
         this.LBButtonData.ButtonEnabled = aSel > 0;
         this.RBButtonData.ButtonEnabled = aSel < this.LabelsA.length - 1;
         dispatchEvent(new CustomEvent(LABEL_SELECTED_EVENT,data,true));
      }
      
      public function Update(aDelta:Number) : *
      {
         // method body index: 1574 method index: 1574
         this.UpdateSelector(aDelta);
         this.UpdateSlider(aDelta);
      }
      
      public function UpdateSelector(aDelta:Number) : *
      {
         // method body index: 1575 method index: 1575
         var numFramesToAdvanceBy:* = undefined;
         var targetDelta:* = undefined;
         var advancementPerFrame:* = undefined;
         if(this.AnimationFramesLeftSelector > 0)
         {
            numFramesToAdvanceBy = aDelta / (1 / 30);
            targetDelta = this.TargetSelectorX - this.LastSelectorX;
            advancementPerFrame = targetDelta / this.AnimFrameCount;
            this.Selector_mc.x = this.Selector_mc.x + advancementPerFrame * numFramesToAdvanceBy;
            if(this.SelectorGray_mc != null)
            {
               this.SelectorGray_mc.x = this.SelectorGray_mc.x + advancementPerFrame * numFramesToAdvanceBy;
            }
            this.AnimationFramesLeftSelector = this.AnimationFramesLeftSelector - numFramesToAdvanceBy;
            this.AnimationFramesLeftSelector = Math.max(this.AnimationFramesLeftSelector,0);
            if(this.TargetSelectorX < this.LastSelectorX && this.Selector_mc.x < this.TargetSelectorX)
            {
               this.Selector_mc.x = this.TargetSelectorX;
               if(this.SelectorGray_mc != null)
               {
                  this.SelectorGray_mc.x = this.TargetSelectorX;
               }
            }
            else if(this.TargetSelectorX > this.LastSelectorX && this.Selector_mc.x > this.TargetSelectorX)
            {
               this.Selector_mc.x = this.TargetSelectorX;
               if(this.SelectorGray_mc != null)
               {
                  this.SelectorGray_mc.x = this.TargetSelectorX;
               }
            }
            if(this.AnimationFramesLeftSelector == 0)
            {
               this.LabelsA[this.SelectedIndex].selected = true;
            }
         }
      }
      
      public function UpdateSlider(aDelta:Number) : *
      {
         // method body index: 1576 method index: 1576
         var numFramesToAdvanceBy:* = undefined;
         var targetDelta:* = undefined;
         var advancementPerFrame:* = undefined;
         if(this.AnimationFramesLeftSlider > 0)
         {
            numFramesToAdvanceBy = aDelta / (1 / 30);
            targetDelta = this.TargetSliderX - this.LastSliderX;
            advancementPerFrame = targetDelta / this.AnimFrameCount;
            this.Slider_mc.x = this.Slider_mc.x + advancementPerFrame * numFramesToAdvanceBy;
            this.AnimationFramesLeftSlider = this.AnimationFramesLeftSlider - numFramesToAdvanceBy;
            this.AnimationFramesLeftSlider = Math.max(this.AnimationFramesLeftSlider,0);
            if(this.TargetSliderX < this.LastSliderX && this.Slider_mc.x < this.TargetSliderX)
            {
               this.Slider_mc.x = this.TargetSliderX;
            }
            else if(this.TargetSliderX > this.LastSliderX && this.Slider_mc.x > this.TargetSliderX)
            {
               this.Slider_mc.x = this.TargetSliderX;
            }
            if(this.AnimationFramesLeftSlider == 0)
            {
               this.Selector_mc.x = this.LabelsA[this.SelectedIndex].x;
               if(this.SelectorGray_mc != null)
               {
                  this.SelectorGray_mc.x = this.LabelsA[this.SelectedIndex].x;
               }
               this.UpdateLabelVisibility(this.LeftIndex,true);
               this.LabelsA[this.SelectedIndex].selected = true;
            }
         }
      }
      
      public function SetSelectable(aID:uint, aSelectable:Boolean) : *
      {
         // method body index: 1577 method index: 1577
         for(var i:uint = 0; i < this.LabelsA.length; i++)
         {
            if(this.LabelsA[i].id == aID)
            {
               this.LabelsA[i].selectable = aSelectable;
            }
         }
      }
      
      public function MakeCurrentLabelUnselectable() : *
      {
         // method body index: 1578 method index: 1578
         var i:int = 0;
         var labelToSelect:* = uint.MAX_VALUE;
         this.LabelsA[this.SelectedIndex].selectable = false;
         i = this.SelectedIndex - 1 as int;
         while(labelToSelect == uint.MAX_VALUE && i >= 0)
         {
            if(this.LabelsA[i].selectable)
            {
               labelToSelect = i as uint;
            }
            i--;
         }
         i = this.SelectedIndex + 1 as int;
         while(labelToSelect == uint.MAX_VALUE && i < this.LabelsA.length)
         {
            if(this.LabelsA[i].selectable)
            {
               labelToSelect = i as uint;
            }
            i++;
         }
         this.SetSelection(labelToSelect,true,false);
      }
      
      public function GetLabelIndex(aID:uint) : int
      {
         // method body index: 1579 method index: 1579
         for(var i:uint = 0; i < this.LabelsA.length; i++)
         {
            if(this.LabelsA[i].id == aID)
            {
               return i;
            }
         }
         return -1;
      }
      
      public function GetLabel(aIndex:int) : LabelItem
      {
         // method body index: 1580 method index: 1580
         if(aIndex >= 0 && aIndex < this.LabelsA.length)
         {
            return this.LabelsA[aIndex];
         }
         throw new Error("LabelSelector::GetLabel() - aIndex out of range.");
      }
   }
}
