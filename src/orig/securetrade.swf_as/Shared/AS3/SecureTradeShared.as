package Shared.AS3 
{
    import flash.display.*;
    
    public class SecureTradeShared extends Object
    {
        public function SecureTradeShared()
        {
            super();
            return;
        }

        public static function setCurrencyIcon(arg1:Shared.AS3.SWFLoaderClip, arg2:uint, arg3:Boolean=false):flash.display.MovieClip
        {
            var loc1:*=null;
            var loc2:*=arg2;
            switch (loc2) 
            {
                case CURRENCY_CAPS:
                {
                    if (arg3) 
                    {
                        loc1 = "IconCu_CapsHUD";
                    }
                    else 
                    {
                        loc1 = "IconCu_Caps";
                    }
                    break;
                }
                case CURRENCY_LEGENDARY_TOKENS:
                {
                    if (arg3) 
                    {
                        loc1 = "IconCu_LegendaryTokenHUD";
                    }
                    else 
                    {
                        loc1 = "IconCu_LegendaryToken";
                    }
                    break;
                }
                case CURRENCY_POSSUM_BADGES:
                {
                    loc1 = "IconCu_Possum";
                    break;
                }
                case CURRENCY_TADPOLE_BADGES:
                {
                    loc1 = "IconCu_Tadpole";
                    break;
                }
                case CURRENCY_GOLD_BULLION:
                {
                    if (arg3) 
                    {
                        loc1 = "IconCu_GBHUD";
                    }
                    else 
                    {
                        loc1 = "IconCu_GB";
                    }
                    break;
                }
                case CURRENCY_PERK_COINS:
                {
                    if (arg3) 
                    {
                        loc1 = "IconCu_LGNPerkCoinHUD";
                    }
                    else 
                    {
                        loc1 = "IconCu_LGNPerkCoin";
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return arg1.setContainerIconClip(loc1);
        }

        public static function IsCampVendingMenuType(arg1:uint):Boolean
        {
            return arg1 == Shared.AS3.SecureTradeShared.MODE_VENDING_MACHINE || arg1 == Shared.AS3.SecureTradeShared.MODE_DISPLAY_CASE || arg1 == Shared.AS3.SecureTradeShared.MODE_ALLY || arg1 == Shared.AS3.SecureTradeShared.MODE_CAMP_DISPENSER || arg1 == Shared.AS3.SecureTradeShared.MODE_FERMENTER || arg1 == Shared.AS3.SecureTradeShared.MODE_REFRIGERATOR;
        }

        public static function DoesMachineTypeMatchMode(arg1:uint, arg2:uint):Boolean
        {
            return arg1 != MACHINE_TYPE_VENDING ? arg1 != MACHINE_TYPE_DISPLAY ? arg1 != MACHINE_TYPE_DISPENSER ? arg1 != MACHINE_TYPE_FERMENTER ? arg1 != MACHINE_TYPE_REFRIGERATOR ? arg1 != MACHINE_TYPE_ALLY ? false : arg2 == MODE_ALLY : arg2 == MODE_REFRIGERATOR : arg2 == MODE_FERMENTER : arg2 == MODE_CAMP_DISPENSER : arg2 == MODE_DISPLAY_CASE : arg2 == MODE_VENDING_MACHINE;
        }

        public static const MODE_CONTAINER:uint=0;

        public static const MODE_PLAYERVENDING:uint=1;

        public static const MODE_NPCVENDING:uint=2;

        public static const MODE_VENDING_MACHINE:int=3;

        public static const MODE_DISPLAY_CASE:int=4;

        public static const MODE_CAMP_DISPENSER:int=5;

        public static const MODE_FERMENTER:int=6;

        public static const MODE_REFRIGERATOR:int=7;

        public static const MODE_ALLY:int=8;

        public static const MODE_INVALID:uint=uint.MAX_VALUE;

        public static const SUB_MODE_STANDARD:uint=0;

        public static const SUB_MODE_LEGENDARY_VENDOR:uint=1;

        public static const SUB_MODE_LEGENDARY_VENDING_MACHINE:uint=2;

        public static const SUB_MODE_POSSUM_VENDING_MACHINE:uint=3;

        public static const SUB_MODE_TADPOLE_VENDING_MACHINE:uint=4;

        public static const SUB_MODE_DISPENSER_AID_ONLY:uint=5;

        public static const SUB_MODE_DISPENSER_AMMO_ONLY:uint=6;

        public static const SUB_MODE_DISPENSER_JUNK_ONLY:uint=7;

        public static const CURRENCY_LEGENDARY_TOKENS:uint=1;

        public static const CURRENCY_POSSUM_BADGES:uint=2;

        public static const CURRENCY_TADPOLE_BADGES:uint=3;

        public static const CURRENCY_GOLD_BULLION:uint=4;

        public static const CURRENCY_PERK_COINS:uint=5;

        public static const CURRENCY_INVALID:uint=uint.MAX_VALUE;

        public static const MACHINE_TYPE_INVALID:int=0;

        public static const MACHINE_TYPE_VENDING:int=1;

        public static const MACHINE_TYPE_DISPLAY:int=2;

        public static const MACHINE_TYPE_DISPENSER:int=3;

        public static const MACHINE_TYPE_FERMENTER:int=4;

        public static const MACHINE_TYPE_REFRIGERATOR:int=5;

        public static const MACHINE_TYPE_ALLY:int=6;

        public static const SUB_MODE_ALLY:uint=11;

        public static const CURRENCY_CAPS:uint=0;

        public static const SUB_MODE_ARMOR_RACK:uint=8;
    }
}
