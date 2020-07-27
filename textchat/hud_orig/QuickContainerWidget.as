 
package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public dynamic class QuickContainerWidget extends BSUIComponent
   {
      
      private static var cuiNumClips:Number = // method body index: 3015 method index: 3015
      5;
       
      
      public var ListHeaderAndBracket_mc:MovieClip;
      
      public var Spinner_mc:MovieClip;
      
      public var ListItems_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var WeightIcon_mc:MovieClip;
      
      public var WeightText_mc:MovieClip;
      
      public var ItemDataA:Vector.<QuickContainerItemData>;
      
      private var _selectedIndex:int;
      
      private var _bracketsVisible:Boolean;
      
      private var _ConditionMeterEnabled:Boolean;
      
      public var AButton:BSButtonHintData;
      
      public var XButton:BSButtonHintData;
      
      public var YButton:BSButtonHintData;
      
      private var ItemClipsA:Vector.<QuickContainerItem>;
      
      private var m_HeaderTextFormat:TextFormat;
      
      private var PositionForListSize:Vector.<int>;
      
      private var m_PostInventoryFrame:int = 31;
      
      public function QuickContainerWidget()
      {
         // method body index: 3018 method index: 3018
         var curFrame:FrameLabel = null;
         var clip:QuickContainerItem = null;
         this.AButton = new BSButtonHintData("$TAKE","E","PSN_A","Xenon_A",1,null);
         this.XButton = new BSButtonHintData("$QuickContainerTransfer","R","PSN_X","Xenon_X",1,null);
         this.YButton = new BSButtonHintData("Special Action","$SPACEBAR","PSN_Y","Xenon_Y",1,null);
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,11,this.frame12,12,this.frame13,21,this.frame22,22,this.frame23,28,this.frame29);
         Extensions.enabled = true;
         this._ConditionMeterEnabled = true;
         this._selectedIndex = -1;
         this.PopulateButtonBar();
         this.ItemDataA = new Vector.<QuickContainerItemData>();
         this.ItemClipsA = new Vector.<QuickContainerItem>(cuiNumClips,true);
         this.PositionForListSize = new Vector.<int>(cuiNumClips + 1,true);
         var containerName_tf:TextField = this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf as TextField;
         this.m_HeaderTextFormat = containerName_tf.getTextFormat();
         containerName_tf.multiline = false;
         containerName_tf.wordWrap = false;
         for(var i:Number = 0; i < cuiNumClips; i++)
         {
            clip = this.ListItems_mc.getChildByName("ItemText" + i) as QuickContainerItem;
            this.ItemClipsA[i] = clip;
            this.PositionForListSize[cuiNumClips - i] = clip.y;
         }
         this.PositionForListSize[0] = this.PositionForListSize[1];
         visible = false;
         alpha = 0;
         var frameList:Array = this.currentLabels;
         for(i = 0; i < frameList.length; i++)
         {
            curFrame = frameList[i];
            if(curFrame.name == "rollOff")
            {
               this.m_PostInventoryFrame = curFrame.frame;
               break;
            }
         }
         this.ButtonHintBar_mc.useVaultTecColor = true;
         this.ButtonHintBar_mc.useBackground = false;
         BSUIDataManager.Subscribe("CharacterInfoData",this.onCharacterInfoUpdate);
         TextFieldEx.setTextAutoSize(this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.WeightText_mc.WeightText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.__setProp_ButtonHintBar_mc_QuickContainerWidget_ButtonHintBar_mc_0();
      }
      
      public function get numClips() : uint
      {
         // method body index: 3016 method index: 3016
         return cuiNumClips;
      }
      
      private function onCharacterInfoUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 3017 method index: 3017
         var weightCur:Number = Math.floor(arEvent.data.currWeight);
         var weightMax:Number = Math.floor(arEvent.data.maxWeight);
         var weightLimit:Number = Math.floor(arEvent.data.absoluteWeightLimit);
         if(weightCur >= weightLimit)
         {
            this.WeightIcon_mc.gotoAndStop("warning");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COOR_WARNING;
            this.WeightText_mc.WeightText_tf.text = "$AbsoluteWeightLimitDisplay";
            this.WeightText_mc.WeightText_tf.text = this.WeightText_mc.WeightText_tf.text.replace("{weight}",weightCur.toString());
         }
         else if(weightCur > weightMax)
         {
            this.WeightIcon_mc.gotoAndStop("warning");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COOR_WARNING;
            this.WeightText_mc.WeightText_tf.text = weightCur + "/" + weightMax;
         }
         else
         {
            this.WeightIcon_mc.gotoAndStop("normal");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COLOR_TEXT_BODY;
            this.WeightText_mc.WeightText_tf.text = weightCur + "/" + weightMax;
         }
      }
      
      public function onQuickContainerOpen() : void
      {
         // method body index: 3019 method index: 3019
         alpha = 1;
         if(this._bracketsVisible)
         {
            if(this.currentFrame == 1 || this.currentFrame >= this.m_PostInventoryFrame)
            {
               this.m_HeaderTextFormat.align = "left";
               this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf.setTextFormat(this.m_HeaderTextFormat);
               this.gotoAndPlay("rollOn");
            }
         }
         else
         {
            this.m_HeaderTextFormat.align = "center";
            this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf.setTextFormat(this.m_HeaderTextFormat);
            this.gotoAndStop("onWorkshop");
         }
      }
      
      public function onQuickContainerClose() : void
      {
         // method body index: 3020 method index: 3020
         if(this._bracketsVisible)
         {
            this.gotoAndPlay("rollOff");
         }
         else
         {
            this.gotoAndStop("off");
         }
         this.Spinner_mc.visible = false;
         for(var i:uint = 0; i < cuiNumClips; i++)
         {
            this.ItemClipsA[i].data = null;
         }
      }
      
      public function onQuickContainerForceHide() : void
      {
         // method body index: 3021 method index: 3021
         this.gotoAndStop("off");
      }
      
      protected function PopulateButtonBar() : void
      {
         // method body index: 3022 method index: 3022
         var buttonHintDataV:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         buttonHintDataV.push(this.AButton);
         buttonHintDataV.push(this.XButton);
         buttonHintDataV.push(this.YButton);
         this.XButton.ButtonVisible = false;
         this.AButton.ButtonVisible = false;
         this.YButton.ButtonVisible = false;
         this.ButtonHintBar_mc.SetButtonHintData(buttonHintDataV);
      }
      
      public function UpdateList(aSelectedIndex:int, aIsNewContainer:Boolean) : void
      {
         // method body index: 3023 method index: 3023
         var clip:QuickContainerItem = null;
         this._selectedIndex = aSelectedIndex;
         for(var i:uint = 0; i < cuiNumClips; i++)
         {
            clip = this.ItemClipsA[i];
            if(i < this.ItemDataA.length)
            {
               clip.data = this.ItemDataA[i];
               clip.selected = this._selectedIndex == i;
               clip.ConditionMeterEnabled = this._ConditionMeterEnabled;
            }
            else
            {
               clip.data = null;
            }
         }
         if(aIsNewContainer && this._bracketsVisible && this.ItemClipsA[0].data == null)
         {
            this.Spinner_mc.gotoAndPlay(1);
            this.Spinner_mc.visible = true;
         }
      }
      
      public function onInventorySynced() : *
      {
         // method body index: 3024 method index: 3024
         this.Spinner_mc.visible = false;
      }
      
      public function set containerName(astrName:String) : *
      {
         // method body index: 3025 method index: 3025
         GlobalFunc.SetText(this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf,astrName,false,true);
      }
      
      public function set bracketsVisible(value:Boolean) : void
      {
         // method body index: 3026 method index: 3026
         this._bracketsVisible = value;
      }
      
      public function DisableConditionMeter() : *
      {
         // method body index: 3027 method index: 3027
         this._ConditionMeterEnabled = false;
      }
      
      function __setProp_ButtonHintBar_mc_QuickContainerWidget_ButtonHintBar_mc_0() : *
      {
         // method body index: 3028 method index: 3028
         try
         {
            this.ButtonHintBar_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.ButtonHintBar_mc.BackgroundAlpha = 1;
         this.ButtonHintBar_mc.BackgroundColor = 0;
         this.ButtonHintBar_mc.bracketCornerLength = 6;
         this.ButtonHintBar_mc.bracketLineWidth = 1.5;
         this.ButtonHintBar_mc.BracketStyle = "horizontal";
         this.ButtonHintBar_mc.bRedirectToButtonBarMenu = false;
         this.ButtonHintBar_mc.bShowBrackets = false;
         this.ButtonHintBar_mc.bUseShadedBackground = false;
         this.ButtonHintBar_mc.ShadedBackgroundMethod = "Shader";
         this.ButtonHintBar_mc.ShadedBackgroundType = "normal";
         try
         {
            this.ButtonHintBar_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function frame1() : *
      {
         // method body index: 3029 method index: 3029
         stop();
         this.visible = false;
      }
      
      function frame2() : *
      {
         // method body index: 3030 method index: 3030
         stop();
      }
      
      function frame3() : *
      {
         // method body index: 3031 method index: 3031
         this.visible = true;
      }
      
      function frame12() : *
      {
         // method body index: 3032 method index: 3032
         stop();
      }
      
      function frame13() : *
      {
         // method body index: 3033 method index: 3033
         this.visible = false;
      }
      
      function frame22() : *
      {
         // method body index: 3034 method index: 3034
         stop();
      }
      
      function frame23() : *
      {
         // method body index: 3035 method index: 3035
         this.visible = true;
      }
      
      function frame29() : *
      {
         // method body index: 3036 method index: 3036
         stop();
      }
   }
}
