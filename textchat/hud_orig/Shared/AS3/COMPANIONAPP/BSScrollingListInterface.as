 
package Shared.AS3.COMPANIONAPP
{
   import Mobile.ScrollList.MobileScrollList;
   
   public class BSScrollingListInterface
   {
      
      public static const STATS_SPECIAL_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "SPECIALListEntry";
      
      public static const STATS_PERKS_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "PerksListEntry";
      
      public static const INVENTORY_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "InvListEntry";
      
      public static const INVENTORY_COMPONENT_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "ComponentListEntry";
      
      public static const INVENTORY_COMPONENT_OWNERS_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "ComponentOwnersListEntry";
      
      public static const DATA_STATS_CATEGORIES_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "Stats_CategoriesListEntry";
      
      public static const DATA_STATS_VALUES_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "Stats_ValuesListEntry";
      
      public static const DATA_WORKSHOPS_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "WorkshopsListEntry";
      
      public static const QUEST_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "QuestsListEntry";
      
      public static const QUEST_OBJECTIVES_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "ObjectivesListEntry";
      
      public static const RADIO_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "RadioListEntry";
      
      public static const PIPBOY_MESSAGE_ENTRY_LINKAGE_ID:String = // method body index: 277 method index: 277
      "MessageBoxButtonEntry";
      
      public static const STATS_SPECIAL_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "SPECIALItemRendererMc";
      
      public static const STATS_PERKS_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "PerksItemRendererMc";
      
      public static const INVENTORY_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "InventoryItemRendererMc";
      
      public static const INVENTORY_COMPONENT_OWNERS_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "ComponentOwnersItemRendererMc";
      
      public static const DATA_STATS_CATEGORIES_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "StatsCategoriesItemRendererMc";
      
      public static const DATA_STATS_VALUES_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "StatsValuesItemRendererMc";
      
      public static const DATA_WORKSHOPS_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "WorkshopsItemRendererMc";
      
      public static const QUEST_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "QuestsItemRendererMc";
      
      public static const QUEST_OBJECTIVES_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "QuestsObjectivesItemRendererMc";
      
      public static const RADIO_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "RadioItemRendererMc";
      
      public static const PIPBOY_MESSAGE_RENDERER_LINKAGE_ID:String = // method body index: 277 method index: 277
      "PipboyMessageItemRenderer";
       
      
      public function BSScrollingListInterface()
      {

         super();
      }
      
      public static function GetMobileScrollListProperties(className:String) : MobileScrollListProperties
      {

         var props:MobileScrollListProperties = new MobileScrollListProperties();
         switch(className)
         {
            case STATS_SPECIAL_ENTRY_LINKAGE_ID:
               props.linkageId = STATS_SPECIAL_RENDERER_LINKAGE_ID;
               props.maskDimension = 450;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 0;
               props.clickable = true;
               props.reversed = false;
               break;
            case STATS_PERKS_ENTRY_LINKAGE_ID:
               props.linkageId = STATS_PERKS_RENDERER_LINKAGE_ID;
               props.maskDimension = 400;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 0;
               props.clickable = true;
               props.reversed = false;
               break;
            case INVENTORY_COMPONENT_ENTRY_LINKAGE_ID:
            case INVENTORY_ENTRY_LINKAGE_ID:
               props.linkageId = INVENTORY_RENDERER_LINKAGE_ID;
               props.maskDimension = 405;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 0;
               props.clickable = true;
               props.reversed = false;
               break;
            case INVENTORY_COMPONENT_OWNERS_ENTRY_LINKAGE_ID:
               props.linkageId = INVENTORY_COMPONENT_OWNERS_RENDERER_LINKAGE_ID;
               props.maskDimension = 400;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 0;
               props.clickable = true;
               props.reversed = false;
               break;
            case DATA_STATS_CATEGORIES_ENTRY_LINKAGE_ID:
               props.linkageId = DATA_STATS_CATEGORIES_RENDERER_LINKAGE_ID;
               props.maskDimension = 400;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 2.25;
               props.clickable = true;
               props.reversed = false;
               break;
            case DATA_STATS_VALUES_ENTRY_LINKAGE_ID:
               props.linkageId = DATA_STATS_VALUES_RENDERER_LINKAGE_ID;
               props.maskDimension = 400;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 2.75;
               props.clickable = false;
               props.reversed = false;
               break;
            case DATA_WORKSHOPS_ENTRY_LINKAGE_ID:
               props.linkageId = DATA_WORKSHOPS_RENDERER_LINKAGE_ID;
               props.maskDimension = 400;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 2.75;
               props.clickable = true;
               props.reversed = false;
               break;
            case QUEST_ENTRY_LINKAGE_ID:
               props.linkageId = QUEST_RENDERER_LINKAGE_ID;
               props.maskDimension = 400;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 1.4;
               props.clickable = true;
               props.reversed = false;
               break;
            case QUEST_OBJECTIVES_ENTRY_LINKAGE_ID:
               props.linkageId = QUEST_OBJECTIVES_RENDERER_LINKAGE_ID;
               props.maskDimension = 200;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 1.75;
               props.clickable = false;
               props.reversed = false;
               break;
            case RADIO_ENTRY_LINKAGE_ID:
               props.linkageId = RADIO_RENDERER_LINKAGE_ID;
               props.maskDimension = 400;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 1.4;
               props.clickable = true;
               props.reversed = false;
               break;
            case PIPBOY_MESSAGE_ENTRY_LINKAGE_ID:
               props.linkageId = PIPBOY_MESSAGE_RENDERER_LINKAGE_ID;
               props.maskDimension = 150;
               props.scrollDirection = MobileScrollList.VERTICAL;
               props.spaceBetweenButtons = 4;
               props.clickable = true;
               props.reversed = false;
               break;
            default:
               trace("Error: No mapping found between ListItemRenderer \'" + className + "\' used InGame and mobile ListItemRenderer");
         }
         return props;
      }
   }
}
