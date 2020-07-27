 
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
         // method body index: 3010 method index: 3010
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
      
      protected function updateConditionMeter(aEntryObject:Object) : void
      {
         // method body index: 3004 method index: 3004
         if(aEntryObject.maximumHealth > 0 && this.ConditionMeterEnabled)
         {
            GlobalFunc.updateConditionMeter(this.ConditionMeter_mc,aEntryObject.currentHealth,aEntryObject.maximumHealth,aEntryObject.durability);
         }
         else
         {
            this.ConditionMeter_mc.visible = false;
         }
      }
      
      public function get data() : QuickContainerItemData
      {
         // method body index: 3005 method index: 3005
         return this._data;
      }
      
      public function set data(value:QuickContainerItemData) : void
      {
         // method body index: 3006 method index: 3006
         this._data = value;
         SetIsDirty();
      }
      
      public function get selected() : Boolean
      {
         // method body index: 3007 method index: 3007
         return this._selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         // method body index: 3008 method index: 3008
         this._selected = value;
         SetIsDirty();
      }
      
      private function selectedColorTransform(aClip:MovieClip, aSelected:Boolean) : void
      {
         // method body index: 3009 method index: 3009
         var colorTrans:ColorTransform = aClip.transform.colorTransform;
         colorTrans.redOffset = !!aSelected?Number(255):Number(0);
         colorTrans.greenOffset = !!aSelected?Number(255):Number(0);
         colorTrans.blueOffset = !!aSelected?Number(255):Number(0);
         aClip.transform.colorTransform = colorTrans;
      }
      
      private function BuildIconList() : Array
      {
         // method body index: 3011 method index: 3011
         var iconList:Array = [];
         iconList.push({
            "clip":this.FavoriteIcon_mc,
            "visible":this.data.favorite > 0
         });
         iconList.push({
            "clip":this.LegendaryIcon_mc,
            "visible":this.data.isLegendary
         });
         iconList.push({
            "clip":this.questItemIcon_mc,
            "visible":this.data.isQuestItem || this.data.isSharedQuestItem
         });
         iconList.push({
            "clip":this.BetterIcon_mc,
            "visible":this.data.isBetterThanEquippedItem
         });
         iconList.push({
            "clip":this.TaggedForSearchIcon_mc,
            "visible":this.data.taggedForSearch
         });
         iconList.push({
            "clip":this.SetBonusIcon_mc,
            "visible":this.data.isSetItem
         });
         return iconList;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3012 method index: 3012
         var playerLevel:Number = NaN;
         var skipLevel:Boolean = false;
         var iconList:Array = null;
         var iconWidth:Number = NaN;
         var itemLevelColor:* = undefined;
         var i:* = undefined;
         if(this.data)
         {
            playerLevel = BSUIDataManager.GetDataFromClient("CharacterInfoData").data.level;
            skipLevel = BSUIDataManager.GetDataFromClient("HUDModeData").data.skipLevelRequirements;
            this.updateConditionMeter(this.data);
            visible = true;
            iconList = this.BuildIconList();
            iconWidth = 0;
            itemLevelColor = new ColorTransform();
            for(i = 0; i < iconList.length; i++)
            {
               if(iconList[i].clip != null && iconList[i].visible)
               {
                  iconWidth = iconWidth + (iconList[i].clip.width + 2);
               }
            }
            if(this.data.maximumHealth > 0)
            {
               iconWidth = iconWidth + this.ConditionMeter_mc.width;
            }
            this.questItemIcon_mc.gotoAndStop(!!this.data.isSharedQuestItem?"shared":"local");
            this.SetBonusIcon_mc.gotoAndStop(this.data.isSetBonusActive && this.data.equipState != 0?"active":"inactive");
            this.ItemName_tf.width = this.BaseTextFieldWidth - iconWidth;
            this.RarityBorder_mc.visible = this.data.rarity > -1?true:false;
            if(this.data.rarity > -1)
            {
               this.ConditionMeter_mc.visible = false;
            }
            if(this.data.rarity == 0)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_COMMON);
               itemLevelColor.color = GlobalFunc.COLOR_RARITY_COMMON;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_COMMON);
            }
            else if(this.data.rarity == 1)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_RARE);
               itemLevelColor.color = GlobalFunc.COLOR_RARITY_RARE;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_RARE);
            }
            else if(this.data.rarity == 2)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_EPIC);
               itemLevelColor.color = GlobalFunc.COLOR_RARITY_EPIC;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_EPIC);
            }
            else if(this.data.rarity == 3)
            {
               this.ItemName_tf.textColor = !!this.selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_RARITY_LEGENDARY);
               itemLevelColor.color = GlobalFunc.COLOR_RARITY_LEGENDARY;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_LEGENDARY);
            }
            else
            {
               this.ItemName_tf.textColor = !!this.selected?uint(GlobalFunc.COLOR_TEXT_SELECTED):uint(GlobalFunc.COLOR_TEXT_BODY);
               itemLevelColor.color = GlobalFunc.COLOR_TEXT_BODY;
               this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_NONE);
            }
            this.RaritySelector_mc.RarityOverlay_mc.transform.colorTransform = itemLevelColor;
            this.RarityIndicator_mc.transform.colorTransform = itemLevelColor;
            this.RarityBorder_mc.transform.colorTransform = itemLevelColor;
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
               this.SelectionIndicator_mc.alpha = !!this.selected?Number(1):Number(0);
            }
            this.AddIconsToEntry(iconList);
         }
         else
         {
            visible = false;
         }
      }
      
      public function AddIconsToEntry(aIconList:Array) : *
      {
         // method body index: 3013 method index: 3013
         var curIcon:Object = null;
         var xBase:* = this.ItemName_tf.getLineMetrics(0).width + this.ItemName_tf.getLineMetrics(0).x + this.ItemName_tf.x + 2;
         var xDelta:* = 0;
         for(var i:* = 0; i < aIconList.length; i++)
         {
            curIcon = aIconList[i];
            if(curIcon.clip != null)
            {
               curIcon.clip.visible = curIcon.visible;
               if(curIcon.clip.visible)
               {
                  this.selectedColorTransform(curIcon.clip,this.selected);
                  curIcon.clip.x = xBase + xDelta;
                  xDelta = xDelta + (curIcon.clip.width + 2);
               }
            }
         }
      }
   }
}
