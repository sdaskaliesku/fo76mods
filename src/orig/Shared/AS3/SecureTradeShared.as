 
package Shared.AS3
{
   import flash.display.MovieClip;
   
   public class SecureTradeShared
   {
      
      public static const MODE_CONTAINER:uint = // method body index: 80 method index: 80
      0;
      
      public static const MODE_PLAYERVENDING:uint = // method body index: 80 method index: 80
      1;
      
      public static const MODE_NPCVENDING:uint = // method body index: 80 method index: 80
      2;
      
      public static const MODE_VENDING_MACHINE:int = // method body index: 80 method index: 80
      3;
      
      public static const MODE_DISPLAY_CASE:int = // method body index: 80 method index: 80
      4;
      
      public static const MODE_CAMP_DISPENSER:int = // method body index: 80 method index: 80
      5;
      
      public static const MODE_FERMENTER:int = // method body index: 80 method index: 80
      6;
      
      public static const MODE_REFRIGERATOR:int = // method body index: 80 method index: 80
      7;
      
      public static const MODE_ALLY:int = // method body index: 80 method index: 80
      8;
      
      public static const MODE_INVALID:uint = // method body index: 80 method index: 80
      uint.MAX_VALUE;
      
      public static const SUB_MODE_STANDARD:uint = // method body index: 80 method index: 80
      0;
      
      public static const SUB_MODE_LEGENDARY_VENDOR:uint = // method body index: 80 method index: 80
      1;
      
      public static const SUB_MODE_LEGENDARY_VENDING_MACHINE:uint = // method body index: 80 method index: 80
      2;
      
      public static const SUB_MODE_POSSUM_VENDING_MACHINE:uint = // method body index: 80 method index: 80
      3;
      
      public static const SUB_MODE_TADPOLE_VENDING_MACHINE:uint = // method body index: 80 method index: 80
      4;
      
      public static const SUB_MODE_DISPENSER_AID_ONLY:uint = // method body index: 80 method index: 80
      5;
      
      public static const SUB_MODE_DISPENSER_AMMO_ONLY:uint = // method body index: 80 method index: 80
      6;
      
      public static const SUB_MODE_DISPENSER_JUNK_ONLY:uint = // method body index: 80 method index: 80
      7;
      
      public static const SUB_MODE_ARMOR_RACK:uint = // method body index: 80 method index: 80
      8;
      
      public static const SUB_MODE_ALLY:uint = // method body index: 80 method index: 80
      11;
      
      public static const CURRENCY_CAPS:uint = // method body index: 80 method index: 80
      0;
      
      public static const CURRENCY_LEGENDARY_TOKENS:uint = // method body index: 80 method index: 80
      1;
      
      public static const CURRENCY_POSSUM_BADGES:uint = // method body index: 80 method index: 80
      2;
      
      public static const CURRENCY_TADPOLE_BADGES:uint = // method body index: 80 method index: 80
      3;
      
      public static const CURRENCY_GOLD_BULLION:uint = // method body index: 80 method index: 80
      4;
      
      public static const CURRENCY_PERK_COINS:uint = // method body index: 80 method index: 80
      5;
      
      public static const CURRENCY_INVALID:uint = // method body index: 80 method index: 80
      uint.MAX_VALUE;
      
      public static const MACHINE_TYPE_INVALID = // method body index: 80 method index: 80
      0;
      
      public static const MACHINE_TYPE_VENDING = // method body index: 80 method index: 80
      1;
      
      public static const MACHINE_TYPE_DISPLAY = // method body index: 80 method index: 80
      2;
      
      public static const MACHINE_TYPE_DISPENSER = // method body index: 80 method index: 80
      3;
      
      public static const MACHINE_TYPE_FERMENTER = // method body index: 80 method index: 80
      4;
      
      public static const MACHINE_TYPE_REFRIGERATOR = // method body index: 80 method index: 80
      5;
      
      public static const MACHINE_TYPE_ALLY = // method body index: 80 method index: 80
      6;
       
      
      public function SecureTradeShared()
      {
         // method body index: 84 method index: 84
         super();
      }
      
      public static function IsCampVendingMenuType(aMode:uint) : Boolean
      {
         // method body index: 81 method index: 81
         return aMode == SecureTradeShared.MODE_VENDING_MACHINE || aMode == SecureTradeShared.MODE_DISPLAY_CASE || aMode == SecureTradeShared.MODE_ALLY || aMode == SecureTradeShared.MODE_CAMP_DISPENSER || aMode == SecureTradeShared.MODE_FERMENTER || aMode == SecureTradeShared.MODE_REFRIGERATOR;
      }
      
      public static function DoesMachineTypeMatchMode(aMachineType:uint, aMode:uint) : Boolean
      {
         // method body index: 82 method index: 82
         return aMachineType == MACHINE_TYPE_VENDING?aMode == MODE_VENDING_MACHINE:aMachineType == MACHINE_TYPE_DISPLAY?aMode == MODE_DISPLAY_CASE:aMachineType == MACHINE_TYPE_DISPENSER?aMode == MODE_CAMP_DISPENSER:aMachineType == MACHINE_TYPE_FERMENTER?aMode == MODE_FERMENTER:aMachineType == MACHINE_TYPE_REFRIGERATOR?aMode == MODE_REFRIGERATOR:aMachineType == MACHINE_TYPE_ALLY?aMode == MODE_ALLY:false;
      }
      
      public static function setCurrencyIcon(aClip:SWFLoaderClip, aCurrencyType:uint, aIsHUD:Boolean = false) : MovieClip
      {
         // method body index: 83 method index: 83
         var currencyIcon:String = null;
         switch(aCurrencyType)
         {
            case CURRENCY_CAPS:
               if(aIsHUD)
               {
                  currencyIcon = "IconCu_CapsHUD";
               }
               else
               {
                  currencyIcon = "IconCu_Caps";
               }
               break;
            case CURRENCY_LEGENDARY_TOKENS:
               if(aIsHUD)
               {
                  currencyIcon = "IconCu_LegendaryTokenHUD";
               }
               else
               {
                  currencyIcon = "IconCu_LegendaryToken";
               }
               break;
            case CURRENCY_POSSUM_BADGES:
               currencyIcon = "IconCu_Possum";
               break;
            case CURRENCY_TADPOLE_BADGES:
               currencyIcon = "IconCu_Tadpole";
               break;
            case CURRENCY_GOLD_BULLION:
               if(aIsHUD)
               {
                  currencyIcon = "IconCu_GBHUD";
               }
               else
               {
                  currencyIcon = "IconCu_GB";
               }
               break;
            case CURRENCY_PERK_COINS:
               if(aIsHUD)
               {
                  currencyIcon = "IconCu_LGNPerkCoinHUD";
               }
               else
               {
                  currencyIcon = "IconCu_LGNPerkCoin";
               }
         }
         return aClip.setContainerIconClip(currencyIcon);
      }
   }
}
