 
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
      
      private static var cuiNumClips:Number = // method body index: 2966 method index: 2966
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

         var _loc1_:FrameLabel = null;
         var _loc2_:QuickContainerItem = null;
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
         var _loc3_:TextField = this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf as TextField;
         this.m_HeaderTextFormat = _loc3_.getTextFormat();
         _loc3_.multiline = false;
         _loc3_.wordWrap = false;
         var _loc4_:Number = 0;
         while(_loc4_ < cuiNumClips)
         {
            _loc2_ = this.ListItems_mc.getChildByName("ItemText" + _loc4_) as QuickContainerItem;
            this.ItemClipsA[_loc4_] = _loc2_;
            this.PositionForListSize[cuiNumClips - _loc4_] = _loc2_.y;
            _loc4_++;
         }
         this.PositionForListSize[0] = this.PositionForListSize[1];
         visible = false;
         alpha = 0;
         var _loc5_:Array = this.currentLabels;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc1_ = _loc5_[_loc4_];
            if(_loc1_.name == "rollOff")
            {
               this.m_PostInventoryFrame = _loc1_.frame;
               break;
            }
            _loc4_++;
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

         return cuiNumClips;
      }
      
      private function onCharacterInfoUpdate(param1:FromClientDataEvent) : void
      {

         var _loc2_:Number = Math.floor(param1.data.currWeight);
         var _loc3_:Number = Math.floor(param1.data.maxWeight);
         var _loc4_:Number = Math.floor(param1.data.absoluteWeightLimit);
         if(_loc2_ >= _loc4_)
         {
            this.WeightIcon_mc.gotoAndStop("warning");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COOR_WARNING;
            this.WeightText_mc.WeightText_tf.text = "$AbsoluteWeightLimitDisplay";
            this.WeightText_mc.WeightText_tf.text = this.WeightText_mc.WeightText_tf.text.replace("{weight}",_loc2_.toString());
         }
         else if(_loc2_ > _loc3_)
         {
            this.WeightIcon_mc.gotoAndStop("warning");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COOR_WARNING;
            this.WeightText_mc.WeightText_tf.text = _loc2_ + "/" + _loc3_;
         }
         else
         {
            this.WeightIcon_mc.gotoAndStop("normal");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COLOR_TEXT_BODY;
            this.WeightText_mc.WeightText_tf.text = _loc2_ + "/" + _loc3_;
         }
      }
      
      public function onQuickContainerOpen() : void
      {

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

         if(this._bracketsVisible)
         {
            this.gotoAndPlay("rollOff");
         }
         else
         {
            this.gotoAndStop("off");
         }
         this.Spinner_mc.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < cuiNumClips)
         {
            this.ItemClipsA[_loc1_].data = null;
            _loc1_++;
         }
      }
      
      public function onQuickContainerForceHide() : void
      {

         this.gotoAndStop("off");
      }
      
      protected function PopulateButtonBar() : void
      {

         var _loc1_:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         _loc1_.push(this.AButton);
         _loc1_.push(this.XButton);
         _loc1_.push(this.YButton);
         this.XButton.ButtonVisible = false;
         this.AButton.ButtonVisible = false;
         this.YButton.ButtonVisible = false;
         this.ButtonHintBar_mc.SetButtonHintData(_loc1_);
      }
      
      public function UpdateList(param1:int, param2:Boolean) : void
      {

         var _loc3_:QuickContainerItem = null;
         this._selectedIndex = param1;
         var _loc4_:uint = 0;
         while(_loc4_ < cuiNumClips)
         {
            _loc3_ = this.ItemClipsA[_loc4_];
            if(_loc4_ < this.ItemDataA.length)
            {
               _loc3_.data = this.ItemDataA[_loc4_];
               _loc3_.selected = this._selectedIndex == _loc4_;
               _loc3_.ConditionMeterEnabled = this._ConditionMeterEnabled;
            }
            else
            {
               _loc3_.data = null;
            }
            _loc4_++;
         }
         if(param2 && this._bracketsVisible && this.ItemClipsA[0].data == null)
         {
            this.Spinner_mc.gotoAndPlay(1);
            this.Spinner_mc.visible = true;
         }
      }
      
      public function onInventorySynced() : *
      {

         this.Spinner_mc.visible = false;
      }
      
      public function set containerName(param1:String) : *
      {

         GlobalFunc.SetText(this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf,param1,false,true);
      }
      
      public function set bracketsVisible(param1:Boolean) : void
      {

         this._bracketsVisible = param1;
      }
      
      public function DisableConditionMeter() : *
      {

         this._ConditionMeterEnabled = false;
      }
      
      function __setProp_ButtonHintBar_mc_QuickContainerWidget_ButtonHintBar_mc_0() : *
      {

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
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function frame1() : *
      {

         stop();
         this.visible = false;
      }
      
      function frame2() : *
      {

         stop();
      }
      
      function frame3() : *
      {

         this.visible = true;
      }
      
      function frame12() : *
      {

         stop();
      }
      
      function frame13() : *
      {

         this.visible = false;
      }
      
      function frame22() : *
      {

         stop();
      }
      
      function frame23() : *
      {

         this.visible = true;
      }
      
      function frame29() : *
      {

         stop();
      }
   }
}
