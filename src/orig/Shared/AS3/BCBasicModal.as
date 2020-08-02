 
package Shared.AS3
{
   import Shared.AS3.Styles.MessageBoxButtonListStyle;
   import Shared.GlobalFunc;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import scaleform.gfx.TextFieldEx;
   
   public class BCBasicModal extends BSUIComponent
   {
      
      public static const EVENT_CONFIRM = // method body index: 1513 method index: 1513
      "BSBasicModal::Confirm";
      
      public static const EVENT_CANCEL:String = // method body index: 1513 method index: 1513
      "BSBasicModal::Cancel";
      
      public static const EVENT_ENTRY_SELECTED:String = // method body index: 1513 method index: 1513
      "BSBasicModal::EntrySelected";
      
      public static const VALUE_ICON_SPACING:Number = // method body index: 1513 method index: 1513
      6;
      
      public static const ELEMENT_X_PADDING:Number = // method body index: 1513 method index: 1513
      24;
      
      public static const ELEMENT_Y_SPACING:Number = // method body index: 1513 method index: 1513
      12;
      
      public static const ELEMENT_Y_PADDING:Number = // method body index: 1513 method index: 1513
      25;
      
      public static const BUTTON_MODE_NONE:uint = // method body index: 1513 method index: 1513
      0;
      
      public static const BUTTON_MODE_LIST:uint = // method body index: 1513 method index: 1513
      1;
      
      public static const BUTTON_MODE_BAR:uint = // method body index: 1513 method index: 1513
      2;
      
      public static const BACKGROUND_MINWIDTH:Number = // method body index: 1513 method index: 1513
      750;
       
      
      public var Header_mc:MovieClip;
      
      public var Tooltip_mc:MovieClip;
      
      public var TooltipExtra_mc:MovieClip;
      
      public var Value_mc:MovieClip;
      
      public var Background_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var ButtonList_mc:MessageBoxButtonList;
      
      public var ComponentList_mc:BSScrollingList;
      
      public var Internal_mc:MovieClip;
      
      private var m_PreviousFocus:InteractiveObject;
      
      private var m_ChoiceButtonMode:uint = 0;
      
      private var m_Tooltip:String;
      
      private var m_TooltipExtra:String;
      
      private var m_ButtonBarInitialized:Boolean = false;
      
      private var m_ButtonListInitialized:Boolean = false;
      
      private var m_ButtonListCustom:Array;
      
      private var m_DynamicLayout:Boolean = true;
      
      protected var m_AcceptButton:BSButtonHintData;
      
      protected var m_CancelButton:BSButtonHintData;
      
      private var m_Open:Boolean = false;
      
      public function BCBasicModal()
      {
         // method body index: 1534 method index: 1534
         this.m_AcceptButton = new BSButtonHintData("$ACCEPT","Space","PSN_A","Xenon_A",1,this.onConfirm);
         this.m_CancelButton = new BSButtonHintData("$CANCEL","TAB","PSN_B","Xenon_B",1,this.onCancel);
         super();
         if(this.Internal_mc != null)
         {
            this.Header_mc = this.Internal_mc.Header_mc;
            this.Tooltip_mc = this.Internal_mc.Tooltip_mc;
            this.TooltipExtra_mc = this.Internal_mc.TooltipExtra_mc;
            this.Value_mc = this.Internal_mc.Value_mc;
            this.Background_mc = this.Internal_mc.Background_mc;
            this.ButtonHintBar_mc = this.Internal_mc.ButtonHintBar_mc;
            this.ButtonList_mc = this.Internal_mc.ButtonList_mc;
            this.ComponentList_mc = this.Internal_mc.ComponentList_mc;
         }
         TextFieldEx.setTextAutoSize(this.Header_mc.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
         if(this.ButtonList_mc != null)
         {
            StyleSheet.apply(this.ButtonList_mc,false,MessageBoxButtonListStyle);
         }
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         mouseEnabled = false;
         mouseChildren = false;
         SetIsDirty();
      }
      
      public function set dynamicLayout(aDynamic:Boolean) : void
      {
         // method body index: 1514 method index: 1514
         this.m_DynamicLayout = aDynamic;
         SetIsDirty();
      }
      
      public function set customButtonList(aList:Array) : void
      {
         // method body index: 1515 method index: 1515
         var listLen:uint = 0;
         if(aList != null)
         {
            listLen = aList.length;
            if(listLen > 0 && listLen <= 10)
            {
               this.m_ButtonListCustom = aList;
               SetIsDirty();
            }
            else
            {
               trace("WARNING: BCBasicModal::customButtonList - List expects 1-10 entries, but has " + listLen);
            }
         }
      }
      
      public function set choiceButtonMode(aMode:uint) : void
      {
         // method body index: 1516 method index: 1516
         this.m_ChoiceButtonMode = aMode;
         SetIsDirty();
      }
      
      public function get choiceButtonMode() : uint
      {
         // method body index: 1517 method index: 1517
         return this.m_ChoiceButtonMode;
      }
      
      public function set previousFocus(aFocus:InteractiveObject) : void
      {
         // method body index: 1518 method index: 1518
         this.m_PreviousFocus = aFocus;
      }
      
      public function get previousFocus() : InteractiveObject
      {
         // method body index: 1519 method index: 1519
         return this.m_PreviousFocus;
      }
      
      public function set header(aHeader:String) : *
      {
         // method body index: 1520 method index: 1520
         this.Header_mc.textField.text = aHeader;
         SetIsDirty();
      }
      
      public function get tooltip() : String
      {
         // method body index: 1521 method index: 1521
         return this.Tooltip_mc.textField.text;
      }
      
      public function set tooltip(aTip:String) : *
      {
         // method body index: 1522 method index: 1522
         this.Tooltip_mc.textField.text = aTip;
         this.m_Tooltip = aTip;
         if(this.Tooltip_mc != null)
         {
            if(this.m_Tooltip.length > 0)
            {
               this.Tooltip_mc.visible = true;
            }
            else
            {
               this.Tooltip_mc.visible = false;
            }
         }
         SetIsDirty();
      }
      
      public function set tooltipExtra(aTip:String) : *
      {
         // method body index: 1523 method index: 1523
         this.TooltipExtra_mc.textField.text = aTip;
         this.m_TooltipExtra = aTip;
         if(this.TooltipExtra_mc != null)
         {
            if(this.m_TooltipExtra.length > 0)
            {
               this.TooltipExtra_mc.visible = true;
            }
            else
            {
               this.TooltipExtra_mc.visible = false;
            }
         }
         SetIsDirty();
      }
      
      public function set value(aValue:String) : *
      {
         // method body index: 1524 method index: 1524
         if(this.Value_mc != null)
         {
            this.Value_mc.Value_tf.text = aValue;
            SetIsDirty();
         }
      }
      
      public function get open() : Boolean
      {
         // method body index: 1525 method index: 1525
         return this.m_Open;
      }
      
      public function set open(aOpen:Boolean) : *
      {
         // method body index: 1526 method index: 1526
         if(aOpen != this.m_Open)
         {
            this.m_Open = aOpen;
            if(this.m_Open)
            {
               gotoAndPlay("rollOn");
               if(this.ButtonList_mc != null && this.m_ChoiceButtonMode == BUTTON_MODE_LIST)
               {
                  this.ButtonList_mc.selectedIndex = 0;
                  stage.focus = this.ButtonList_mc;
               }
            }
            else
            {
               gotoAndPlay("rollOff");
            }
            mouseEnabled = this.m_Open;
            mouseChildren = this.m_Open;
         }
      }
      
      public function onKeyUp(event:KeyboardEvent) : *
      {
         // method body index: 1527 method index: 1527
         if(event.keyCode == Keyboard.ENTER)
         {
            this.onConfirm();
         }
      }
      
      protected function onConfirm() : void
      {
         // method body index: 1528 method index: 1528
         dispatchEvent(new Event(EVENT_CONFIRM,true,true));
      }
      
      protected function onCancel() : void
      {
         // method body index: 1529 method index: 1529
         dispatchEvent(new Event(EVENT_CANCEL,true,true));
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1530 method index: 1530
         var valueChildren:Array = null;
         var totalWidth:Number = NaN;
         var xOrigin:Number = NaN;
         var elementCenterX:Number = NaN;
         var itemsToArrange:Array = null;
         var totalHeight:Number = NaN;
         var yOrigin:Number = NaN;
         var i:uint = 0;
         if(this.Value_mc != null)
         {
            valueChildren = [this.Value_mc.Value_tf];
            if(this.Value_mc.Icon_mc != null)
            {
               valueChildren.push(this.Value_mc.Icon_mc);
            }
            GlobalFunc.arrangeItems(valueChildren,false,GlobalFunc.ALIGN_CENTER,VALUE_ICON_SPACING);
         }
         if(this.ButtonHintBar_mc != null)
         {
            this.ButtonHintBar_mc.redrawUIComponent();
            if(this.m_ChoiceButtonMode == BUTTON_MODE_BAR)
            {
               this.initializeButtonBar();
            }
            this.ButtonHintBar_mc.visible = this.m_ChoiceButtonMode == BUTTON_MODE_BAR;
         }
         if(this.ButtonList_mc != null)
         {
            if(this.m_ChoiceButtonMode == BUTTON_MODE_LIST)
            {
               this.populateButtonList();
            }
            this.ButtonList_mc.visible = this.m_ChoiceButtonMode == BUTTON_MODE_LIST;
         }
         if(this.ComponentList_mc != null)
         {
            if(this.ComponentList_mc.ScrollUp != null)
            {
               this.ComponentList_mc.ScrollUp.y = this.ComponentList_mc.ScrollUp.height / 2;
            }
            if(this.ComponentList_mc.ScrollDown != null)
            {
               this.ComponentList_mc.ScrollDown.y = this.ComponentList_mc.shownItemsHeight - this.ComponentList_mc.ScrollDown.height / 2;
            }
         }
         if(this.m_DynamicLayout)
         {
            this.Background_mc.width = Math.max(BACKGROUND_MINWIDTH,this.Background_mc.width);
            this.Header_mc.textField.width = this.Background_mc.width - ELEMENT_X_PADDING * 2;
            this.Header_mc.textField.x = this.Header_mc.textField.width / -2;
            totalWidth = this.Background_mc.width;
            xOrigin = (loaderInfo.width - totalWidth) / 2;
            elementCenterX = xOrigin + totalWidth / 2;
            itemsToArrange = [this.Header_mc];
            if(this.Tooltip_mc != null && this.m_Tooltip != null && this.m_Tooltip.length > 0)
            {
               itemsToArrange.push(this.Tooltip_mc);
            }
            if(this.TooltipExtra_mc != null && this.m_TooltipExtra != null && this.m_TooltipExtra.length > 0)
            {
               itemsToArrange.push(this.TooltipExtra_mc);
            }
            if(this.ComponentList_mc != null)
            {
               this.ComponentList_mc.x = elementCenterX;
               itemsToArrange.push(this.ComponentList_mc);
            }
            if(this.Value_mc != null)
            {
               itemsToArrange.push(this.Value_mc);
            }
            if(this.ButtonHintBar_mc != null && this.ButtonHintBar_mc.visible)
            {
               this.ButtonHintBar_mc.x = elementCenterX;
               itemsToArrange.push(this.ButtonHintBar_mc);
            }
            if(this.ButtonList_mc != null && this.ButtonList_mc.visible)
            {
               this.ButtonList_mc.x = elementCenterX;
               itemsToArrange.push(this.ButtonList_mc);
            }
            totalHeight = GlobalFunc.arrangeItems(itemsToArrange,true,GlobalFunc.ALIGN_LEFT,ELEMENT_Y_SPACING,false,ELEMENT_Y_PADDING) + ELEMENT_Y_PADDING * 2;
            yOrigin = (stage.stageHeight - totalHeight) / 2;
            this.Background_mc.x = xOrigin;
            this.Background_mc.y = yOrigin;
            this.Background_mc.height = totalHeight;
            for(i = 0; i < itemsToArrange.length; i++)
            {
               itemsToArrange[i].y = itemsToArrange[i].y + yOrigin;
            }
         }
      }
      
      private function onItemPress(e:Event) : void
      {
         // method body index: 1531 method index: 1531
         dispatchEvent(new Event(EVENT_ENTRY_SELECTED,true,true));
         if(this.ButtonList_mc.selectedIndex == 0)
         {
            this.onConfirm();
         }
         else
         {
            this.onCancel();
         }
         e.stopPropagation();
      }
      
      private function populateButtonList() : void
      {
         // method body index: 1532 method index: 1532
         if(!this.m_ButtonListInitialized)
         {
            addEventListener(BSScrollingList.ITEM_PRESS,this.onItemPress);
         }
         if(this.m_ButtonListCustom != null)
         {
            this.ButtonList_mc.entryList = this.m_ButtonListCustom;
         }
         else
         {
            this.ButtonList_mc.entryList = [{"text":"$OK"},{"text":"$CANCEL"}];
         }
         this.ButtonList_mc.InvalidateData();
         this.ButtonList_mc.selectedIndex = 0;
      }
      
      private function initializeButtonBar() : void
      {
         // method body index: 1533 method index: 1533
         var buttonHintDataV:Vector.<BSButtonHintData> = null;
         if(!this.m_ButtonBarInitialized)
         {
            buttonHintDataV = new Vector.<BSButtonHintData>();
            buttonHintDataV.push(this.m_AcceptButton);
            buttonHintDataV.push(this.m_CancelButton);
            this.ButtonHintBar_mc.SetButtonHintData(buttonHintDataV);
         }
      }
   }
}
