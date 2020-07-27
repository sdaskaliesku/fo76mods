 
package Shared.AS3
{
   import flash.display.MovieClip;
   
   public class SecureTradeShared
   {
      
      public static const MODE_CONTAINER:uint = // method body index: 173 method index: 173
      0;
      
      public static const MODE_PLAYERVENDING:uint = // method body index: 173 method index: 173
      1;
      
      public static const MODE_NPCVENDING:uint = // method body index: 173 method index: 173
      2;
      
      public static const MODE_VENDING_MACHINE:int = // method body index: 173 method index: 173
      3;
      
      public static const MODE_DISPLAY_CASE:int = // method body index: 173 method index: 173
      4;
      
      public static const MODE_CAMP_DISPENSER:int = // method body index: 173 method index: 173
      5;
      
      public static const MODE_FERMENTER:int = // method body index: 173 method index: 173
      6;
      
      public static const MODE_REFRIGERATOR:int = // method body index: 173 method index: 173
      7;
      
      public static const MODE_ALLY:int = // method body index: 173 method index: 173
      8;
      
      public static const MODE_INVALID:uint = // method body index: 173 method index: 173
      uint.MAX_VALUE;
      
      public static const SUB_MODE_STANDARD:uint = // method body index: 173 method index: 173
      0;
      
      public static const SUB_MODE_LEGENDARY_VENDOR:uint = // method body index: 173 method index: 173
      1;
      
      public static const SUB_MODE_LEGENDARY_VENDING_MACHINE:uint = // method body index: 173 method index: 173
      2;
      
      public static const SUB_MODE_POSSUM_VENDING_MACHINE:uint = // method body index: 173 method index: 173
      3;
      
      public static const SUB_MODE_TADPOLE_VENDING_MACHINE:uint = // method body index: 173 method index: 173
      4;
      
      public static const SUB_MODE_DISPENSER_AID_ONLY:uint = // method body index: 173 method index: 173
      5;
      
      public static const SUB_MODE_DISPENSER_AMMO_ONLY:uint = // method body index: 173 method index: 173
      6;
      
      public static const SUB_MODE_DISPENSER_JUNK_ONLY:uint = // method body index: 173 method index: 173
      7;
      
      public static const SUB_MODE_ARMOR_RACK:uint = // method body index: 173 method index: 173
      8;
      
      public static const SUB_MODE_ALLY:uint = // method body index: 173 method index: 173
      11;
      
      public static const CURRENCY_CAPS:uint = // method body index: 173 method index: 173
      0;
      
      public static const CURRENCY_LEGENDARY_TOKENS:uint = // method body index: 173 method index: 173
      1;
      
      public static const CURRENCY_POSSUM_BADGES:uint = // method body index: 173 method index: 173
      2;
      
      public static const CURRENCY_TADPOLE_BADGES:uint = // method body index: 173 method index: 173
      3;
      
      public static const CURRENCY_GOLD_BULLION:uint = // method body index: 173 method index: 173
      4;
      
      public static const CURRENCY_PERK_COINS:uint = // method body index: 173 method index: 173
      5;
      
      public static const CURRENCY_INVALID:uint = // method body index: 173 method index: 173
      uint.MAX_VALUE;
      
      public static const MACHINE_TYPE_INVALID = // method body index: 173 method index: 173
      0;
      
      public static const MACHINE_TYPE_VENDING = // method body index: 173 method index: 173
      1;
      
      public static const MACHINE_TYPE_DISPLAY = // method body index: 173 method index: 173
      2;
      
      public static const MACHINE_TYPE_DISPENSER = // method body index: 173 method index: 173
      3;
      
      public static const MACHINE_TYPE_FERMENTER = // method body index: 173 method index: 173
      4;
      
      public static const MACHINE_TYPE_REFRIGERATOR = // method body index: 173 method index: 173
      5;
      
      public static const MACHINE_TYPE_ALLY = // method body index: 173 method index: 173
      6;
       
      
      public function SecureTradeShared()
      {

         super();
      }
      
      public static function IsCampVendingMenuType(param1:uint) : Boolean
      {

         return param1 == SecureTradeShared.MODE_VENDING_MACHINE || param1 == SecureTradeShared.MODE_DISPLAY_CASE || param1 == SecureTradeShared.MODE_ALLY || param1 == SecureTradeShared.MODE_CAMP_DISPENSER || param1 == SecureTradeShared.MODE_FERMENTER || param1 == SecureTradeShared.MODE_REFRIGERATOR;
      }
      
      public static function DoesMachineTypeMatchMode(param1:uint, param2:uint) : Boolean
      {

         return param1 == MACHINE_TYPE_VENDING?param2 == MODE_VENDING_MACHINE:param1 == MACHINE_TYPE_DISPLAY?param2 == MODE_DISPLAY_CASE:param1 == MACHINE_TYPE_DISPENSER?param2 == MODE_CAMP_DISPENSER:param1 == MACHINE_TYPE_FERMENTER?param2 == MODE_FERMENTER:param1 == MACHINE_TYPE_REFRIGERATOR?param2 == MODE_REFRIGERATOR:param1 == MACHINE_TYPE_ALLY?param2 == MODE_ALLY:false;
      }
      
      public static function setCurrencyIcon(param1:SWFLoaderClip, param2:uint, param3:Boolean = false) : MovieClip
      {

         var _loc4_:String = null;
         switch(param2)
         {
            case CURRENCY_CAPS:
               if(param3)
               {
                  _loc4_ = "IconCu_CapsHUD";
               }
               else
               {
                  _loc4_ = "IconCu_Caps";
               }
               break;
            case CURRENCY_LEGENDARY_TOKENS:
               if(param3)
               {
                  _loc4_ = "IconCu_LegendaryTokenHUD";
               }
               else
               {
                  _loc4_ = "IconCu_LegendaryToken";
               }
               break;
            case CURRENCY_POSSUM_BADGES:
               _loc4_ = "IconCu_Possum";
               break;
            case CURRENCY_TADPOLE_BADGES:
               _loc4_ = "IconCu_Tadpole";
               break;
            case CURRENCY_GOLD_BULLION:
               if(param3)
               {
                  _loc4_ = "IconCu_GBHUD";
               }
               else
               {
                  _loc4_ = "IconCu_GB";
               }
               break;
            case CURRENCY_PERK_COINS:
               if(param3)
               {
                  _loc4_ = "IconCu_LGNPerkCoinHUD";
               }
               else
               {
                  _loc4_ = "IconCu_LGNPerkCoin";
               }
         }
         return param1.setContainerIconClip(_loc4_);
      }
   }
}
