 
package
{
   import Shared.AS3.ItemListEntryBase;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   
   public class ItemListEntry extends ItemListEntryBase
   {
       
      
      public var LeftIcon_mc:MovieClip;
      
      public var FavoriteIcon_mc:MovieClip;
      
      public var TaggedForSearchIcon_mc:MovieClip;
      
      public var questItemIcon_mc:MovieClip;
      
      public var SetBonusIcon_mc:MovieClip;
      
      protected var BaseTextFieldWidth:uint;
      
      protected var BaseTextFieldX:Number;
      
      public function ItemListEntry()
      {
         // method body index: 1668 method index: 1668
         super();
         this.BaseTextFieldWidth = textField.width;
         this.BaseTextFieldX = textField.x;
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {
         // method body index: 1669 method index: 1669
         var curIcon:Object = null;
         super.SetEntryText(aEntryObject,astrTextOption);
         var starsText:* = GlobalFunc.BuildLegendaryStarsGlyphString(aEntryObject);
         var barterCount:int = 0;
         if(aEntryObject.barterCount != undefined)
         {
            barterCount = GlobalFunc.Clamp(aEntryObject.barterCount,0,aEntryObject.count);
         }
         var displayCount:uint = aEntryObject.count - barterCount;
         GlobalFunc.SetText(textField,textField.text + starsText,false,false,true);
         if(displayCount != 1)
         {
            textField.appendText(" (" + displayCount + ")");
         }
         if(aEntryObject.isLearnedRecipe)
         {
            textField.text = "$$Known " + textField.text;
         }
         GlobalFunc.SetText(textField,textField.text,false);
         if(this.LeftIcon_mc != null)
         {
            SetColorTransform(this.LeftIcon_mc,this.selected);
            this.LeftIcon_mc.EquipIcon_mc.visible = aEntryObject.equipState != 0;
            this.LeftIcon_mc.BestIcon_mc.visible = aEntryObject.inContainer && aEntryObject.bestInClass == true;
            if(this.LeftIcon_mc.BarterIcon_mc != undefined)
            {
               this.LeftIcon_mc.BarterIcon_mc.visible = barterCount < 0;
            }
         }
         var iconList:Array = [];
         iconList.push({
            "clip":this.FavoriteIcon_mc,
            "visible":aEntryObject.favorite > 0
         });
         iconList.push({
            "clip":this.questItemIcon_mc,
            "visible":aEntryObject.isQuestItem || aEntryObject.isSharedQuestItem
         });
         iconList.push({
            "clip":this.TaggedForSearchIcon_mc,
            "visible":aEntryObject.taggedForSearch
         });
         iconList.push({
            "clip":this.SetBonusIcon_mc,
            "visible":aEntryObject.isSetItem
         });
         this.questItemIcon_mc.gotoAndStop(!!aEntryObject.isSharedQuestItem?"shared":"local");
         this.SetBonusIcon_mc.gotoAndStop(aEntryObject.isSetBonusActive && aEntryObject.equipState != 0?"active":"inactive");
         var xBase:* = this.textField.getLineMetrics(0).width + this.textField.x;
         var xDelta:* = 10;
         for(var i:* = 0; i < iconList.length; i++)
         {
            curIcon = iconList[i];
            if(curIcon.clip != null)
            {
               curIcon.clip.visible = curIcon.visible;
               if(curIcon.visible == true)
               {
                  SetColorTransform(curIcon.clip,this.selected);
                  curIcon.clip.x = xBase + xDelta;
                  xDelta = xDelta + (curIcon.clip.width + 3);
               }
            }
         }
         textField.width = this.BaseTextFieldWidth - xDelta;
      }
   }
}
