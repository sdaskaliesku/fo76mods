 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public dynamic class QuickContainerItem extends BSUIComponent
   {
       
      
      public var ItemName_tf:TextField;
      
      public var LegendaryIcon_mc:MovieClip;
      
      public var TaggedForSearchIcon_mc:MovieClip;
      
      public var FavoriteIcon_mc:MovieClip;
      
      public var BetterIcon_mc:MovieClip;
      
      public var SetBonusIcon_mc:MovieClip;
      
      public var SelectionIndicator_mc:MovieClip;
      
      public var questItemIcon_mc:MovieClip;
      
      public var ConditionMeter_mc:MovieClip;
      
      public var ConditionMeterEnabled:Boolean;
      
      private var BaseTextFieldWidth:uint;
      
      private var _data:QuickContainerItemData;
      
      private var _selected:Boolean;
      
      protected var m_ConditionMeterFrames:int = 200;
      
      public var RarityIndicator_mc:MovieClip;
      
      public var RarityBorder_mc:MovieClip;
      
      public var RaritySelector_mc:MovieClip;
      
      public function QuickContainerItem()
      {

         super();
         this.BaseTextFieldWidth = this.ItemName_tf.width;
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.ItemName_tf,"shrink");
         visible = false;
         this._data = null;
         this.m_ConditionMeterFrames = this.ConditionMeter_mc.totalFrames;
         this.ConditionMeter_mc.visible = false;
         this.ConditionMeterEnabled = true;
      }
      
      protected function updateConditionMeter(param1:Object) : void
      {

         if(param1.maximumHealth > 0 && this.ConditionMeterEnabled)
         {
            GlobalFunc.updateConditionMeter(this.ConditionMeter_mc,param1.currentHealth,param1.maximumHealth,param1.durability);
         }
         else
         {
            this.ConditionMeter_mc.visible = false;
         }
      }
      
      public function get data() : QuickContainerItemData
      {

         return this._data;
      }
      
      public function set data(param1:QuickContainerItemData) : void
      {

         this._data = param1;
         SetIsDirty();
      }
      
      public function get selected() : Boolean
      {

         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {

         this._selected = param1;
         SetIsDirty();
      }
      
      private function selectedColorTransform(param1:MovieClip, param2:Boolean) : void
      {

         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redOffset = !!param2?Number(Number(255)):Number(Number(0));
         _loc3_.greenOffset = !!param2?Number(Number(255)):Number(Number(0));
         _loc3_.blueOffset = !!param2?Number(Number(255)):Number(Number(0));
         param1.transform.colorTransform = _loc3_;
      }
      
      private function BuildIconList() : Array
      {

         var _loc1_:Array = [];
         _loc1_.push({
            "clip":this.FavoriteIcon_mc,
            "visible":this.data.favorite > 0
         });
         _loc1_.push({
            "clip":this.LegendaryIcon_mc,
            "visible":this.data.isLegendary
         });
         _loc1_.push({
            "clip":this.questItemIcon_mc,
            "visible":this.data.isQuestItem || this.data.isSharedQuestItem
         });
         _loc1_.push({
            "clip":this.BetterIcon_mc,
            "visible":this.data.isBetterThanEquippedItem
         });
         _loc1_.push({
            "clip":this.TaggedForSearchIcon_mc,
            "visible":this.data.taggedForSearch
         });
         _loc1_.push({
            "clip":this.SetBonusIcon_mc,
            "visible":this.data.isSetItem
         });
         return _loc1_;
      }
      
      override public function redrawUIComponent() : void
      {

         var _loc1_:Number = NaN;
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(this.data)
         {
            _loc1_ = BSUIDataManager.GetDataFromClient("CharacterInfoData").data.level;
            _loc2_ = BSUIDataManager.GetDataFromClient("HUDModeData").data.skipLevelRequirements;
            this.updateConditionMeter(this.data);
            visible = true;
            _loc3_ = this.BuildIconList();
            _loc4_ = 0;
            _loc5_ = new ColorTransform();
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               if(_loc3_[_loc6_].clip != null && _loc3_[_loc6_].visible)
               {
                  _loc4_ = _loc4_ + (_loc3_[_loc6_].clip.width + 2);
               }
               _loc6_++;
            }
            if(this.data.maximumHealth > 0)
            {
               _loc4_ = _loc4_ + this.ConditionMeter_mc.width;
            }
            this.questItemIcon_mc.gotoAndStop(!!this.data.isSharedQuestItem?"shared":"local");
            this.SetBonusIcon_mc.gotoAndStop(this.data.isSetBonusActive && this.data.equipState != 0?"active":"inactive");
            this.ItemName_tf.width = this.BaseTextFieldWidth - _loc4_;
            this.RarityBorder_mc.visible = this.data.rarity > -1?true:false;
            if(this.data.rarity > -1)
            {
               this.ConditionMeter_mc.visible = false;
            }
            if(this.data.rarity == 0)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(uint(GlobalFunc.COLOR_TEXT_SELECTED)):uint(uint(GlobalFunc.COLOR_RARITY_COMMON));
               _loc5_.color = GlobalFunc.COLOR_RARITY_COMMON;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_COMMON);
            }
            else if(this.data.rarity == 1)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(uint(GlobalFunc.COLOR_TEXT_SELECTED)):uint(uint(GlobalFunc.COLOR_RARITY_RARE));
               _loc5_.color = GlobalFunc.COLOR_RARITY_RARE;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_RARE);
            }
            else if(this.data.rarity == 2)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(uint(GlobalFunc.COLOR_TEXT_SELECTED)):uint(uint(GlobalFunc.COLOR_RARITY_EPIC));
               _loc5_.color = GlobalFunc.COLOR_RARITY_EPIC;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_EPIC);
            }
            else if(this.data.rarity == 3)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(uint(GlobalFunc.COLOR_TEXT_SELECTED)):uint(uint(GlobalFunc.COLOR_RARITY_LEGENDARY));
               _loc5_.color = GlobalFunc.COLOR_RARITY_LEGENDARY;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_LEGENDARY);
            }
            else
            {
               this.ItemName_tf.textColor = !!this.selected?uint(uint(GlobalFunc.COLOR_TEXT_SELECTED)):uint(uint(GlobalFunc.COLOR_TEXT_BODY));
               _loc5_.color = GlobalFunc.COLOR_TEXT_BODY;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_NONE);
            }
            this.RaritySelector_mc.RarityOverlay_mc.transform.colorTransform = _loc5_;
            this.RarityIndicator_mc.transform.colorTransform = _loc5_;
            this.RarityBorder_mc.transform.colorTransform = _loc5_;
            if(this.data.count > 1)
            {
               GlobalFunc.SetText(this.ItemName_tf,this.data.text + " (" + this.data.count + ")",false,false,true);
            }
            else
            {
               GlobalFunc.SetText(this.ItemName_tf,this.data.text,false,false,true);
            }
            if(this.selected)
            {
               this.ItemName_tf.filters = [];
            }
            else
            {
               this.ItemName_tf.filters = [new DropShadowFilter(2,45,0,1,0,0,1,BitmapFilterQuality.HIGH)];
            }
            if(this.data.rarity > -1 && this.selected)
            {
               this.RaritySelector_mc.visible = true;
               this.SelectionIndicator_mc.alpha = 0;
            }
            else
            {
               this.RaritySelector_mc.visible = false;
               this.SelectionIndicator_mc.alpha = !!this.selected?Number(Number(1)):Number(Number(0));
            }
            this.AddIconsToEntry(_loc3_);
         }
         else
         {
            visible = false;
         }
      }
      
      public function AddIconsToEntry(param1:Array) : *
      {

         var _loc2_:Object = null;
         var _loc3_:* = this.ItemName_tf.getLineMetrics(0).width + this.ItemName_tf.getLineMetrics(0).x + this.ItemName_tf.x + 2;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = param1[_loc5_];
            if(_loc2_.clip != null)
            {
               _loc2_.clip.visible = _loc2_.visible;
               if(_loc2_.clip.visible)
               {
                  this.selectedColorTransform(_loc2_.clip,this.selected);
                  _loc2_.clip.x = _loc3_ + _loc4_;
                  _loc4_ = _loc4_ + (_loc2_.clip.width + 2);
               }
            }
            _loc5_++;
         }
      }
   }
}
