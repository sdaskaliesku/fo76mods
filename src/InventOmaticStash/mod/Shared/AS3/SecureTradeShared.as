package Shared.AS3
{
import flash.display.MovieClip;

public class SecureTradeShared
{

    public static const MODE_CONTAINER:uint = 0;

    public static const MODE_PLAYERVENDING:uint = 1;

    public static const MODE_NPCVENDING:uint = 2;

    public static const MODE_VENDING_MACHINE:int = 3;

    public static const MODE_DISPLAY_CASE:int = 4;

    public static const MODE_CAMP_DISPENSER:int = 5;

    public static const MODE_FERMENTER:int = 6;

    public static const MODE_REFRIGERATOR:int = 7;

    public static const MODE_ALLY:int = 8;

    public static const MODE_INVALID:uint = uint.MAX_VALUE;

    public static const SUB_MODE_STANDARD:uint = 0;

    public static const SUB_MODE_LEGENDARY_VENDOR:uint = 1;

    public static const SUB_MODE_LEGENDARY_VENDING_MACHINE:uint = 2;

    public static const SUB_MODE_POSSUM_VENDING_MACHINE:uint = 3;

    public static const SUB_MODE_TADPOLE_VENDING_MACHINE:uint = 4;

    public static const SUB_MODE_DISPENSER_AID_ONLY:uint = 5;

    public static const SUB_MODE_DISPENSER_AMMO_ONLY:uint = 6;

    public static const SUB_MODE_DISPENSER_JUNK_ONLY:uint = 7;

    public static const SUB_MODE_ARMOR_RACK:uint = 8;

    public static const SUB_MODE_ALLY:uint = 11;

    public static const CURRENCY_CAPS:uint = 0;

    public static const CURRENCY_LEGENDARY_TOKENS:uint = 1;

    public static const CURRENCY_POSSUM_BADGES:uint = 2;

    public static const CURRENCY_TADPOLE_BADGES:uint = 3;

    public static const CURRENCY_GOLD_BULLION:uint = 4;

    public static const CURRENCY_PERK_COINS:uint = 5;

    public static const CURRENCY_INVALID:uint = uint.MAX_VALUE;

    public static const MACHINE_TYPE_INVALID = 0;

    public static const MACHINE_TYPE_VENDING = 1;

    public static const MACHINE_TYPE_DISPLAY = 2;

    public static const MACHINE_TYPE_DISPENSER = 3;

    public static const MACHINE_TYPE_FERMENTER = 4;

    public static const MACHINE_TYPE_REFRIGERATOR = 5;

    public static const MACHINE_TYPE_ALLY = 6;


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
