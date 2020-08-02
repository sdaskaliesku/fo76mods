 
package
{
   import Shared.AS3.SWFLoaderClip;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   public class RadialInventoryListEntry extends PlayerListEntry
   {
       
      
      public var Icon_mc:MovieClip;
      
      protected var m_IconClip:SWFLoaderClip;
      
      protected var m_IconInstance:MovieClip;
      
      private var m_Icon:String;
      
      public function RadialInventoryListEntry()
      {
         // method body index: 1869 method index: 1869
         super();
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {
         // method body index: 1868 method index: 1868
         super.SetEntryText(aEntryObject,astrTextOption);
         var rarityColor:* = new ColorTransform();
         RarityBorder_mc.visible = aEntryObject.rarity > -1?true:false;
         RaritySelector_mc.visible = false;
         if(aEntryObject.rarity == 0)
         {
            rarityColor.color = GlobalFunc.COLOR_RARITY_COMMON;
            RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_COMMON);
         }
         else if(aEntryObject.rarity == 1)
         {
            rarityColor.color = GlobalFunc.COLOR_RARITY_RARE;
            RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_RARE);
         }
         else if(aEntryObject.rarity == 2)
         {
            rarityColor.color = GlobalFunc.COLOR_RARITY_EPIC;
            RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_EPIC);
         }
         else if(aEntryObject.rarity == 3)
         {
            rarityColor.color = GlobalFunc.COLOR_RARITY_LEGENDARY;
            RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_LEGENDARY);
         }
         else
         {
            rarityColor.color = GlobalFunc.COLOR_TEXT_BODY;
            RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_NONE);
         }
         RaritySelector_mc.RarityOverlay_mc.transform.colorTransform = rarityColor;
         RarityBorder_mc.transform.colorTransform = rarityColor;
         RarityIndicator_mc.transform.colorTransform = rarityColor;
         if(selected)
         {
            if(aEntryObject.rarity > -1)
            {
               border.visible = false;
               RaritySelector_mc.visible = true;
            }
         }
         if(playerLevel >= aEntryObject.itemLevel)
         {
         }
      }
   }
}
