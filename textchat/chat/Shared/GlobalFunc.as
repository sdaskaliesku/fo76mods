 
package Shared
{
   import Shared.AS3.BCGridList;
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.SWFLoaderClip;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import scaleform.gfx.Extensions;
   
   public class GlobalFunc
   {
      
      public static const PIPBOY_GREY_OUT_ALPHA:Number = // method body index: 17 method index: 17
      0.5;
      
      public static const SELECTED_RECT_ALPHA:Number = // method body index: 17 method index: 17
      1;
      
      public static const DIMMED_ALPHA:Number = // method body index: 17 method index: 17
      0.65;
      
      public static const NUM_DAMAGE_TYPES:uint = // method body index: 17 method index: 17
      6;
      
      public static const PLAYER_ICON_TEXTURE_BUFFER:String = // method body index: 17 method index: 17
      "AvatarTextureBuffer";
      
      public static const STORE_IMAGE_TEXTURE_BUFFER:String = // method body index: 17 method index: 17
      "StoreTextureBuffer";
      
      public static const MAP_TEXTURE_BUFFER:String = // method body index: 17 method index: 17
      "MapMenuTextureBuffer";
      
      protected static const CLOSE_ENOUGH_EPSILON:Number = // method body index: 17 method index: 17
      0.001;
      
      public static const MAX_TRUNCATED_TEXT_LENGTH = // method body index: 17 method index: 17
      42;
      
      public static const PLAY_FOCUS_SOUND:String = // method body index: 17 method index: 17
      "GlobalFunc::playFocusSound";
      
      public static const PLAY_MENU_SOUND:String = // method body index: 17 method index: 17
      "GlobalFunc::playMenuSound";
      
      public static const SHOW_HUD_MESSAGE:String = // method body index: 17 method index: 17
      "GlobalFunc::showHUDMessage";
      
      public static const MENU_SOUND_OK:String = // method body index: 17 method index: 17
      "UIMenuOK";
      
      public static const MENU_SOUND_CANCEL:String = // method body index: 17 method index: 17
      "UIMenuCancel";
      
      public static const MENU_SOUND_PREV_NEXT:String = // method body index: 17 method index: 17
      "UIMenuPrevNext";
      
      public static const MENU_SOUND_POPUP:String = // method body index: 17 method index: 17
      "UIMenuPopupGeneric";
      
      public static const MENU_SOUND_FOCUS_CHANGE:String = // method body index: 17 method index: 17
      "UIMenuFocus";
      
      public static const MENU_SOUND_FRIEND_PROMPT_OPEN:String = // method body index: 17 method index: 17
      "UIMenuPromptFriendRequestBladeOpen";
      
      public static const MENU_SOUND_FRIEND_PROMPT_CLOSE:String = // method body index: 17 method index: 17
      "UIMenuPromptFriendRequestBladeClose";
      
      public static const BUTTON_BAR_ALIGN_CENTER:uint = // method body index: 17 method index: 17
      0;
      
      public static const BUTTON_BAR_ALIGN_LEFT:uint = // method body index: 17 method index: 17
      1;
      
      public static const BUTTON_BAR_ALIGN_RIGHT:uint = // method body index: 17 method index: 17
      2;
      
      public static const COLOR_TEXT_BODY:uint = // method body index: 17 method index: 17
      16777163;
      
      public static const COLOR_TEXT_HEADER:uint = // method body index: 17 method index: 17
      16108379;
      
      public static const COLOR_TEXT_SELECTED:uint = // method body index: 17 method index: 17
      1580061;
      
      public static const COLOR_TEXT_FRIEND:uint = // method body index: 17 method index: 17
      COLOR_TEXT_HEADER;
      
      public static const COLOR_TEXT_ENEMY:uint = // method body index: 17 method index: 17
      16741472;
      
      public static const COLOR_TEXT_UNAVAILABLE:uint = // method body index: 17 method index: 17
      5661031;
      
      public static const COLOR_BACKGROUND_BOX:uint = // method body index: 17 method index: 17
      3225915;
      
      public static const COOR_WARNING:uint = // method body index: 17 method index: 17
      15089200;
      
      public static const COLOR_WARNING_ACCENT:uint = // method body index: 17 method index: 17
      16151129;
      
      public static const COLOR_RARITY_LEGENDARY:uint = // method body index: 17 method index: 17
      15046481;
      
      public static const COLOR_RARITY_EPIC:uint = // method body index: 17 method index: 17
      10763770;
      
      public static const COLOR_RARITY_RARE:uint = // method body index: 17 method index: 17
      4960214;
      
      public static const COLOR_RARITY_COMMON:uint = // method body index: 17 method index: 17
      9043803;
      
      public static const FRAME_RARITY_NONE:String = // method body index: 17 method index: 17
      "None";
      
      public static const FRAME_RARITY_COMMON:String = // method body index: 17 method index: 17
      "Common";
      
      public static const FRAME_RARITY_RARE:String = // method body index: 17 method index: 17
      "Rare";
      
      public static const FRAME_RARITY_EPIC:String = // method body index: 17 method index: 17
      "Epic";
      
      public static const FRAME_RARITY_LEGENDARY:String = // method body index: 17 method index: 17
      "Legendary";
      
      public static var TEXT_SIZE_VERYSMALL:Number = // method body index: 17 method index: 17
      16;
      
      public static var TEXT_SIZE_MIN:Number = // method body index: 17 method index: 17
      14;
      
      public static var TEXT_LEADING_MIN:Number = // method body index: 17 method index: 17
      -2;
      
      public static const VOICE_STATUS_UNAVAILABLE:uint = // method body index: 17 method index: 17
      0;
      
      public static const VOICE_STATUS_AVAILABLE:uint = // method body index: 17 method index: 17
      1;
      
      public static const VOICE_STATUS_SPEAKING:uint = // method body index: 17 method index: 17
      2;
      
      public static const WORLD_TYPE_INVALID:uint = // method body index: 17 method index: 17
      0;
      
      public static const WORLD_TYPE_NORMAL:uint = // method body index: 17 method index: 17
      1;
      
      public static const WORLD_TYPE_SURVIVAL:uint = // method body index: 17 method index: 17
      2;
      
      public static const WORLD_TYPE_NWTEMP:uint = // method body index: 17 method index: 17
      3;
      
      public static const WORLD_TYPE_NUCLEARWINTER:uint = // method body index: 17 method index: 17
      4;
      
      public static const WORLD_TYPE_PRIVATE:uint = // method body index: 17 method index: 17
      5;
      
      public static const QUEST_DISPLAY_TYPE_NONE:uint = // method body index: 17 method index: 17
      0;
      
      public static const QUEST_DISPLAY_TYPE_MAIN:uint = // method body index: 17 method index: 17
      1;
      
      public static const QUEST_DISPLAY_TYPE_SIDE:uint = // method body index: 17 method index: 17
      2;
      
      public static const QUEST_DISPLAY_TYPE_MISC:uint = // method body index: 17 method index: 17
      3;
      
      public static const QUEST_DISPLAY_TYPE_EVENT:uint = // method body index: 17 method index: 17
      4;
      
      public static const QUEST_DISPLAY_TYPE_OTHER:uint = // method body index: 17 method index: 17
      5;
      
      public static const STAT_VALUE_TYPE_INTEGER:uint = // method body index: 17 method index: 17
      0;
      
      public static const STAT_VALUE_TYPE_TIME:uint = // method body index: 17 method index: 17
      1;
      
      public static const STAT_VALUE_TYPE_CAPS:uint = // method body index: 17 method index: 17
      2;
      
      public static var STAT_TYPE_INVALID:uint = // method body index: 17 method index: 17
      20;
      
      public static var STAT_TYPE_SURVIVAL_SCORE = // method body index: 17 method index: 17
      29;
      
      public static const EVENT_USER_CONTEXT_MENU_ACTION:String = // method body index: 17 method index: 17
      "UserContextMenu::MenuOptionSelected";
      
      public static const EVENT_OPEN_USER_CONTEXT_MENU:String = // method body index: 17 method index: 17
      "UserContextMenu::UserSelected";
      
      public static const USER_MENU_CONTEXT_ALL:uint = // method body index: 17 method index: 17
      0;
      
      public static const USER_MENU_CONTEXT_FRIENDS:uint = // method body index: 17 method index: 17
      1;
      
      public static const USER_MENU_CONTEXT_TEAM:uint = // method body index: 17 method index: 17
      2;
      
      public static const USER_MENU_CONTEXT_RECENT:uint = // method body index: 17 method index: 17
      3;
      
      public static const USER_MENU_CONTEXT_BLOCKED:uint = // method body index: 17 method index: 17
      4;
      
      public static const USER_MENU_CONTEXT_MAP:uint = // method body index: 17 method index: 17
      5;
      
      public static const MTX_CURRENCY_ATOMS:uint = // method body index: 17 method index: 17
      0;
      
      public static const ALIGN_LEFT:uint = // method body index: 17 method index: 17
      0;
      
      public static const ALIGN_CENTER:uint = // method body index: 17 method index: 17
      1;
      
      public static const ALIGN_RIGHT:uint = // method body index: 17 method index: 17
      2;
      
      public static const DURABILITY_MAX:uint = // method body index: 17 method index: 17
      100;
      
      public static const DIRECTION_NONE = // method body index: 17 method index: 17
      0;
      
      public static const DIRECTION_UP = // method body index: 17 method index: 17
      1;
      
      public static const DIRECTION_RIGHT = // method body index: 17 method index: 17
      2;
      
      public static const DIRECTION_DOWN = // method body index: 17 method index: 17
      3;
      
      public static const DIRECTION_LEFT = // method body index: 17 method index: 17
      4;
      
      public static const REWARD_TYPE_ENUM_ATOMS = // method body index: 17 method index: 17
      0;
      
      public static const REWARD_TYPE_ENUM_PERK_PACKS = // method body index: 17 method index: 17
      1;
      
      public static const REWARD_TYPE_ENUM_PHOTO_FRAMES = // method body index: 17 method index: 17
      2;
      
      public static const REWARD_TYPE_ENUM_EMOTES = // method body index: 17 method index: 17
      3;
      
      public static const REWARD_TYPE_ENUM_ICONS = // method body index: 17 method index: 17
      4;
      
      public static const REWARD_TYPE_ENUM_WEAPON = // method body index: 17 method index: 17
      5;
      
      public static const REWARD_TYPE_ENUM_WEAPON_MOD = // method body index: 17 method index: 17
      6;
      
      public static const REWARD_TYPE_ENUM_ARMOR = // method body index: 17 method index: 17
      7;
      
      public static const REWARD_TYPE_ENUM_ARMOR_MOD = // method body index: 17 method index: 17
      8;
      
      public static const REWARD_TYPE_ENUM_AMMO = // method body index: 17 method index: 17
      9;
      
      public static const REWARD_TYPE_ENUM_PHOTO_POSE = // method body index: 17 method index: 17
      10;
      
      public static const REWARD_TYPE_ENUM_COMPONENTS = // method body index: 17 method index: 17
      11;
      
      public static const REWARD_TYPE_ENUM_EXPERIENCE = // method body index: 17 method index: 17
      12;
      
      public static const REWARD_TYPE_ENUM_BADGES = // method body index: 17 method index: 17
      13;
      
      public static const REWARD_TYPE_ENUM_STIMPAKS = // method body index: 17 method index: 17
      14;
      
      public static const REWARD_TYPE_ENUM_CHEMS = // method body index: 17 method index: 17
      15;
      
      public static const REWARD_TYPE_ENUM_BOOK = // method body index: 17 method index: 17
      16;
      
      public static const REWARD_TYPE_ENUM_CAPS = // method body index: 17 method index: 17
      17;
      
      public static const REWARD_TYPE_ENUM_LEGENDARY_TOKENS = // method body index: 17 method index: 17
      18;
      
      public static const REWARD_TYPE_ENUM_POSSUM_BADGES = // method body index: 17 method index: 17
      19;
      
      public static const REWARD_TYPE_ENUM_TADPOLE_BADGES = // method body index: 17 method index: 17
      20;
      
      public static const REWARD_TYPE_ENUM_CUSTOM_ICON = // method body index: 17 method index: 17
      21;
      
      public static const REWARD_TYPE_ENUM_CAMP = // method body index: 17 method index: 17
      22;
      
      public static const REWARD_TYPE_ENUM_GOLD_BULLION = // method body index: 17 method index: 17
      23;
      
      public static const REWARD_TYPE_ENUM_SCORE = // method body index: 17 method index: 17
      24;
      
      public static const REWARD_TYPE_ENUM_REPAIR_KIT = // method body index: 17 method index: 17
      25;
      
      public static const REWARD_TYPE_ENUM_LUNCH_BOX = // method body index: 17 method index: 17
      26;
      
      public static const REWARD_TYPE_ENUM_PREMIUM = // method body index: 17 method index: 17
      27;
      
      public static const IMAGE_FRAME_MAP:Object = // method body index: 17 method index: 17
      {
         "a":1,
         "b":2,
         "c":3,
         "d":4,
         "e":5,
         "f":6,
         "g":7,
         "h":8,
         "i":9,
         "j":10,
         "k":11,
         "l":12,
         "m":13,
         "n":14,
         "o":15,
         "p":16,
         "q":17,
         "r":18,
         "s":19,
         "t":20,
         "u":21,
         "v":22,
         "w":23,
         "x":24,
         "y":25,
         "z":26,
         0:1,
         1:2,
         2:3,
         3:4,
         4:5,
         5:6,
         6:7,
         7:8,
         8:9,
         9:10
      };
       
      
      public function GlobalFunc()
      {
         // method body index: 60 method index: 60
         super();
      }
      
      public static function CloneObject(param1:Object) : *
      {
         // method body index: 18 method index: 18
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function Lerp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean) : Number
      {
         // method body index: 19 method index: 19
         var _loc7_:Number = param1 + (param5 - param3) / (param4 - param3) * (param2 - param1);
         if(param6)
         {
            if(param1 < param2)
            {
               _loc7_ = Math.min(Math.max(_loc7_,param1),param2);
            }
            else
            {
               _loc7_ = Math.min(Math.max(_loc7_,param2),param1);
            }
         }
         return _loc7_;
      }
      
      public static function PadNumber(param1:Number, param2:uint) : String
      {
         // method body index: 20 method index: 20
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      public static function setChallengeRewardIcon(param1:SWFLoaderClip, param2:uint, param3:String = "") : MovieClip
      {
         // method body index: 21 method index: 21
         var _loc4_:String = null;
         switch(param2)
         {
            case REWARD_TYPE_ENUM_ATOMS:
               _loc4_ = "IconCR_Atoms";
               break;
            case REWARD_TYPE_ENUM_PERK_PACKS:
               _loc4_ = "IconCR_PerkPack";
               break;
            case REWARD_TYPE_ENUM_PHOTO_FRAMES:
               _loc4_ = "IconCR_PhotoMode";
               break;
            case REWARD_TYPE_ENUM_EMOTES:
               _loc4_ = "IconCR_Emote";
               break;
            case REWARD_TYPE_ENUM_ICONS:
               _loc4_ = "IconCR_PlayerIcon";
               break;
            case REWARD_TYPE_ENUM_WEAPON:
               _loc4_ = "IconCR_Weapon";
               break;
            case REWARD_TYPE_ENUM_WEAPON_MOD:
               _loc4_ = "IconCR_WeaponMod";
               break;
            case REWARD_TYPE_ENUM_ARMOR:
               _loc4_ = "IconCR_Armor";
               break;
            case REWARD_TYPE_ENUM_ARMOR_MOD:
               _loc4_ = "IconCR_ArmorMod";
               break;
            case REWARD_TYPE_ENUM_AMMO:
               _loc4_ = "IconCR_Ammo";
               break;
            case REWARD_TYPE_ENUM_PHOTO_POSE:
               _loc4_ = "IconCR_PhotoMode";
               break;
            case REWARD_TYPE_ENUM_COMPONENTS:
               _loc4_ = "IconCR_Components";
               break;
            case REWARD_TYPE_ENUM_EXPERIENCE:
               _loc4_ = "IconCR_Experience";
               break;
            case REWARD_TYPE_ENUM_BADGES:
               _loc4_ = "IconCR_Badges";
               break;
            case REWARD_TYPE_ENUM_STIMPAKS:
               _loc4_ = "IconCR_Stimpaks";
               break;
            case REWARD_TYPE_ENUM_CHEMS:
               _loc4_ = "IconCR_Chems";
               break;
            case REWARD_TYPE_ENUM_BOOK:
               _loc4_ = "IconCR_Recipe";
               break;
            case REWARD_TYPE_ENUM_CAPS:
               _loc4_ = "IconCR_Caps";
               break;
            case REWARD_TYPE_ENUM_LEGENDARY_TOKENS:
               _loc4_ = "IconCR_LegendaryToken";
               break;
            case REWARD_TYPE_ENUM_POSSUM_BADGES:
            case REWARD_TYPE_ENUM_TADPOLE_BADGES:
               _loc4_ = "IconCR_Caps";
               break;
            case REWARD_TYPE_ENUM_CUSTOM_ICON:
               if(param3.length > 0)
               {
                  _loc4_ = param3;
                  break;
               }
               throw new Error("GlobalFunc.setChallengeRewardIcon: No custom icon specified.");
            case REWARD_TYPE_ENUM_CAMP:
               _loc4_ = "IconCR_Camp";
               break;
            case REWARD_TYPE_ENUM_GOLD_BULLION:
               _loc4_ = "IconCR_GoldBullion";
               break;
            case REWARD_TYPE_ENUM_SCORE:
               _loc4_ = "IconCR_Score";
               break;
            case REWARD_TYPE_ENUM_REPAIR_KIT:
               _loc4_ = "IconCR_RepairKit";
               break;
            case REWARD_TYPE_ENUM_LUNCH_BOX:
               _loc4_ = "IconCR_LunchBox";
               break;
            case REWARD_TYPE_ENUM_PREMIUM:
               _loc4_ = "IconCR_Premium";
         }
         return param1.setContainerIconClip(_loc4_);
      }
      
      public static function parseStatValue(param1:Number, param2:uint) : String
      {
         // method body index: 22 method index: 22
         switch(param2)
         {
            case GlobalFunc.STAT_VALUE_TYPE_TIME:
               return ShortTimeString(param1);
            default:
               return param1.toString();
         }
      }
      
      public static function ShortTimeString(param1:Number) : String
      {
         // method body index: 23 method index: 23
         var _loc2_:Number = 0;
         var _loc3_:TextField = new TextField();
         var _loc4_:Number = Math.floor(param1 / 86400);
         _loc2_ = param1 % 86400;
         var _loc5_:Number = Math.floor(_loc2_ / 3600);
         _loc2_ = param1 % 3600;
         var _loc6_:Number = Math.floor(_loc2_ / 60);
         _loc2_ = param1 % 60;
         var _loc7_:Number = Math.floor(_loc2_);
         var _loc8_:* = 0;
         if(_loc4_ >= 1)
         {
            _loc3_.text = "$ShortTimeDays";
            _loc8_ = _loc4_;
         }
         else if(_loc5_ >= 1)
         {
            _loc3_.text = "$ShortTimeHours";
            _loc8_ = _loc5_;
         }
         else if(_loc6_ >= 1)
         {
            _loc3_.text = "$ShortTimeMinutes";
            _loc8_ = _loc6_;
         }
         else if(_loc7_ >= 1)
         {
            _loc3_.text = "$ShortTimeSeconds";
            _loc8_ = _loc7_;
         }
         else
         {
            _loc3_.text = "$ShortTimeSecond";
            _loc8_ = _loc7_;
         }
         if(_loc8_ != 0)
         {
            _loc3_.text = _loc3_.text.replace("{time}",_loc8_.toString());
            return _loc3_.text;
         }
         return "0";
      }
      
      public static function SimpleTimeString(param1:Number) : String
      {
         // method body index: 24 method index: 24
         var _loc2_:Number = 0;
         var _loc3_:TextField = new TextField();
         var _loc4_:Number = Math.floor(param1 / 86400);
         _loc2_ = param1 % 86400;
         var _loc5_:Number = Math.floor(_loc2_ / 3600);
         _loc2_ = param1 % 3600;
         var _loc6_:Number = Math.floor(_loc2_ / 60);
         _loc2_ = param1 % 60;
         var _loc7_:Number = Math.floor(_loc2_);
         var _loc8_:* = 0;
         if(_loc4_ > 1)
         {
            _loc3_.text = "$SimpleTimeDays";
            _loc8_ = _loc4_;
         }
         else if(_loc4_ == 1)
         {
            _loc3_.text = "$SimpleTimeDay";
            _loc8_ = _loc4_;
         }
         else if(_loc5_ > 1)
         {
            _loc3_.text = "$SimpleTimeHours";
            _loc8_ = _loc5_;
         }
         else if(_loc5_ == 1)
         {
            _loc3_.text = "$SimpleTimeHour";
            _loc8_ = _loc5_;
         }
         else if(_loc6_ > 1)
         {
            _loc3_.text = "$SimpleTimeMinutes";
            _loc8_ = _loc6_;
         }
         else if(_loc6_ == 1)
         {
            _loc3_.text = "$SimpleTimeMinute";
            _loc8_ = _loc6_;
         }
         else if(_loc7_ > 1)
         {
            _loc3_.text = "$SimpleTimeSeconds";
            _loc8_ = _loc7_;
         }
         else if(_loc7_ == 1)
         {
            _loc3_.text = "$SimpleTimeSecond";
            _loc8_ = _loc7_;
         }
         if(_loc8_ != 0)
         {
            _loc3_.text = _loc3_.text.replace("{time}",_loc8_.toString());
            return _loc3_.text;
         }
         return "0";
      }
      
      public static function FormatTimeString(param1:Number) : String
      {
         // method body index: 25 method index: 25
         var _loc2_:Number = 0;
         var _loc3_:Number = Math.floor(param1 / 86400);
         _loc2_ = param1 % 86400;
         var _loc4_:Number = Math.floor(_loc2_ / 3600);
         _loc2_ = param1 % 3600;
         var _loc5_:Number = Math.floor(_loc2_ / 60);
         _loc2_ = param1 % 60;
         var _loc6_:Number = Math.floor(_loc2_);
         var _loc7_:Boolean = false;
         var _loc8_:* = "";
         if(_loc3_ > 0)
         {
            _loc8_ = PadNumber(_loc3_,2);
            _loc7_ = true;
         }
         if(_loc3_ > 0 || _loc4_ > 0)
         {
            if(_loc7_)
            {
               _loc8_ = _loc8_ + ":";
            }
            else
            {
               _loc7_ = true;
            }
            _loc8_ = _loc8_ + PadNumber(_loc4_,2);
         }
         if(_loc3_ > 0 || _loc4_ > 0 || _loc5_ > 0)
         {
            if(_loc7_)
            {
               _loc8_ = _loc8_ + ":";
            }
            else
            {
               _loc7_ = true;
            }
            _loc8_ = _loc8_ + PadNumber(_loc5_,2);
         }
         if(_loc3_ > 0 || _loc4_ > 0 || _loc5_ > 0 || _loc6_ > 0)
         {
            if(_loc7_)
            {
               _loc8_ = _loc8_ + ":";
            }
            else if(_loc3_ == 0 && _loc4_ == 0 && _loc5_ == 0)
            {
               _loc8_ = "0:";
            }
            _loc8_ = _loc8_ + PadNumber(_loc6_,2);
         }
         return _loc8_;
      }
      
      public static function ImageFrameFromCharacter(param1:String) : uint
      {
         // method body index: 26 method index: 26
         var _loc2_:String = null;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = param1.substring(0,1).toLowerCase();
            if(IMAGE_FRAME_MAP[_loc2_] != null)
            {
               return IMAGE_FRAME_MAP[_loc2_];
            }
         }
         return 1;
      }
      
      public static function GetAccountIconPath(param1:String) : String
      {
         // method body index: 27 method index: 27
         if(param1 == null || param1.length == 0)
         {
            param1 = "Textures/ATX/Storefront/PlayerIcons/ATX_PlayerIcon_VaultBoy_76.dds";
         }
         return param1;
      }
      
      public static function RoundDecimal(param1:Number, param2:Number) : Number
      {
         // method body index: 28 method index: 28
         var _loc3_:Number = Math.pow(10,param2);
         return Math.round(_loc3_ * param1) / _loc3_;
      }
      
      public static function CloseToNumber(param1:Number, param2:Number, param3:Number = 0.001) : Boolean
      {
         // method body index: 29 method index: 29
         return Math.abs(param1 - param2) < param3;
      }
      
      public static function Clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         // method body index: 30 method index: 30
         return Math.max(param2,Math.min(param3,param1));
      }
      
      public static function MaintainTextFormat() : *
      {
         // method body index: 32 method index: 32
         TextField.prototype.SetText = function(param1:String, param2:Boolean = false, param3:Boolean = false):// method body index: 31 method index: 31
         *
         {
            // method body index: 31 method index: 31
            var _loc4_:Number = NaN;
            var _loc5_:Boolean = false;
            if(!param1 || param1 == "")
            {
               param1 = " ";
            }
            if(param3 && param1.charAt(0) != "$")
            {
               param1 = param1.toUpperCase();
            }
            var _loc6_:TextFormat = this.getTextFormat();
            if(param2)
            {
               _loc4_ = Number(_loc6_.letterSpacing);
               _loc5_ = _loc6_.kerning;
               this.htmlText = param1;
               _loc6_ = this.getTextFormat();
               _loc6_.letterSpacing = _loc4_;
               _loc6_.kerning = _loc5_;
               this.setTextFormat(_loc6_);
               this.htmlText = param1;
            }
            else
            {
               this.text = param1;
               this.setTextFormat(_loc6_);
               this.text = param1;
            }
         };
      }
      
      public static function SetText(param1:TextField, param2:String, param3:Boolean = false, param4:Boolean = false, param5:* = false) : *
      {
         // method body index: 33 method index: 33
         var _loc6_:TextFormat = null;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         if(!param2 || param2 == "")
         {
            param2 = " ";
         }
         if(param4 && param2.charAt(0) != "$")
         {
            param2 = param2.toUpperCase();
         }
         if(param3)
         {
            _loc6_ = param1.getTextFormat();
            _loc7_ = Number(_loc6_.letterSpacing);
            _loc8_ = _loc6_.kerning;
            param1.htmlText = param2;
            _loc6_ = param1.getTextFormat();
            _loc6_.letterSpacing = _loc7_;
            _loc6_.kerning = _loc8_;
            param1.setTextFormat(_loc6_);
         }
         else
         {
            param1.text = param2;
         }
         if(param5 && param1.text.length > MAX_TRUNCATED_TEXT_LENGTH)
         {
            param1.text = param1.text.slice(0,MAX_TRUNCATED_TEXT_LENGTH - 3) + "...";
         }
      }
      
      public static function LockToSafeRect(param1:DisplayObject, param2:String, param3:Number = 0, param4:Number = 0) : *
      {
         // method body index: 34 method index: 34
         var _loc5_:Rectangle = Extensions.visibleRect;
         var _loc6_:Point = new Point(_loc5_.x + param3,_loc5_.y + param4);
         var _loc7_:Point = new Point(_loc5_.x + _loc5_.width - param3,_loc5_.y + _loc5_.height - param4);
         var _loc8_:Point = param1.parent.globalToLocal(_loc6_);
         var _loc9_:Point = param1.parent.globalToLocal(_loc7_);
         var _loc10_:Point = Point.interpolate(_loc8_,_loc9_,0.5);
         if(param2 == "T" || param2 == "TL" || param2 == "TR" || param2 == "TC")
         {
            param1.y = _loc8_.y;
         }
         if(param2 == "CR" || param2 == "CC" || param2 == "CL")
         {
            param1.y = _loc10_.y;
         }
         if(param2 == "B" || param2 == "BL" || param2 == "BR" || param2 == "BC")
         {
            param1.y = _loc9_.y;
         }
         if(param2 == "L" || param2 == "TL" || param2 == "BL" || param2 == "CL")
         {
            param1.x = _loc8_.x;
         }
         if(param2 == "TC" || param2 == "CC" || param2 == "BC")
         {
            param1.x = _loc10_.x;
         }
         if(param2 == "R" || param2 == "TR" || param2 == "BR" || param2 == "CR")
         {
            param1.x = _loc9_.x;
         }
      }
      
      public static function AddMovieExploreFunctions() : *
      {
         // method body index: 37 method index: 37
         MovieClip.prototype.getMovieClips = function():// method body index: 35 method index: 35
         Array
         {
            // method body index: 35 method index: 35
            var _loc1_:* = undefined;
            var _loc2_:* = new Array();
            for(_loc1_ in this)
            {
               if(this[_loc1_] is MovieClip && this[_loc1_] != this)
               {
                  _loc2_.push(this[_loc1_]);
               }
            }
            return _loc2_;
         };
         MovieClip.prototype.showMovieClips = function():// method body index: 36 method index: 36
         *
         {
            // method body index: 36 method index: 36
            var _loc1_:* = undefined;
            for(_loc1_ in this)
            {
               if(this[_loc1_] is MovieClip && this[_loc1_] != this)
               {
                  trace(this[_loc1_]);
                  this[_loc1_].showMovieClips();
               }
            }
         };
      }
      
      public static function InspectObject(param1:Object, param2:Boolean = false, param3:Boolean = false) : void
      {
         // method body index: 38 method index: 38
         var _loc4_:String = getQualifiedClassName(param1);
         trace("Inspecting object with type " + _loc4_);
         trace("{");
         InspectObjectHelper(param1,param2,param3);
         trace("}");
      }
      
      private static function InspectObjectHelper(param1:Object, param2:Boolean, param3:Boolean, param4:String = "\t") : void
      {
         // method body index: 39 method index: 39
         var aObject:Object = param1;
         var abRecursive:Boolean = param2;
         var abIncludeProperties:Boolean = param3;
         var astrIndent:String = param4;
         var member:XML = null;
         var constMember:XML = null;
         var id:String = null;
         var prop:XML = null;
         var propName:String = null;
         var propValue:Object = null;
         var memberName:String = null;
         var memberValue:Object = null;
         var constMemberName:String = null;
         var constMemberValue:Object = null;
         var value:Object = null;
         var subid:String = null;
         var subvalue:Object = null;
         var typeDef:XML = describeType(aObject);
         if(abIncludeProperties)
         {
            for each(prop in typeDef.accessor.(@access == "readwrite" || @access == "readonly"))
            {
               propName = prop.@name;
               propValue = aObject[prop.@name];
               trace(astrIndent + propName + " = " + propValue);
               if(abRecursive)
               {
                  InspectObjectHelper(propValue,abRecursive,abIncludeProperties,astrIndent + "\t");
               }
            }
         }
         for each(member in typeDef.variable)
         {
            memberName = member.@name;
            memberValue = aObject[memberName];
            trace(astrIndent + memberName + " = " + memberValue);
            if(abRecursive)
            {
               InspectObjectHelper(memberValue,true,abIncludeProperties,astrIndent + "\t");
            }
         }
         for each(constMember in typeDef.constant)
         {
            constMemberName = constMember.@name;
            constMemberValue = aObject[constMemberName];
            trace(astrIndent + constMemberName + " = " + constMemberValue + " --const");
            if(abRecursive)
            {
               InspectObjectHelper(constMemberValue,true,abIncludeProperties,astrIndent + "\t");
            }
         }
         for(id in aObject)
         {
            value = aObject[id];
            trace(astrIndent + id + " = " + value);
            if(abRecursive)
            {
               InspectObjectHelper(value,true,abIncludeProperties,astrIndent + "\t");
            }
            else
            {
               for(subid in value)
               {
                  subvalue = value[subid];
                  trace(astrIndent + "\t" + subid + " = " + subvalue);
               }
            }
         }
      }
      
      public static function AddReverseFunctions() : *
      {
         // method body index: 44 method index: 44
         MovieClip.prototype.PlayReverseCallback = function(param1:Event):// method body index: 40 method index: 40
         *
         {
            // method body index: 40 method index: 40
            if(param1.currentTarget.currentFrame > 1)
            {
               param1.currentTarget.gotoAndStop(param1.currentTarget.currentFrame - 1);
            }
            else
            {
               param1.currentTarget.removeEventListener(Event.ENTER_FRAME,param1.currentTarget.PlayReverseCallback);
            }
         };
         MovieClip.prototype.PlayReverse = function():// method body index: 41 method index: 41
         *
         {
            // method body index: 41 method index: 41
            if(this.currentFrame > 1)
            {
               this.gotoAndStop(this.currentFrame - 1);
               this.addEventListener(Event.ENTER_FRAME,this.PlayReverseCallback);
            }
            else
            {
               this.gotoAndStop(1);
            }
         };
         MovieClip.prototype.PlayForward = function(param1:String):// method body index: 42 method index: 42
         *
         {
            // method body index: 42 method index: 42
            delete this.onEnterFrame;
            this.gotoAndPlay(param1);
         };
         MovieClip.prototype.PlayForward = function(param1:Number):// method body index: 43 method index: 43
         *
         {
            // method body index: 43 method index: 43
            delete this.onEnterFrame;
            this.gotoAndPlay(param1);
         };
      }
      
      public static function PlayMenuSound(param1:String) : *
      {
         // method body index: 45 method index: 45
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{
            "soundID":param1,
            "soundFormID":0
         }));
      }
      
      public static function PlayMenuSoundWithFormID(param1:uint) : *
      {
         // method body index: 46 method index: 46
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{
            "soundID":"",
            "soundFormID":param1
         }));
      }
      
      public static function ShowHUDMessage(param1:String) : *
      {
         // method body index: 47 method index: 47
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.SHOW_HUD_MESSAGE,{"text":param1}));
      }
      
      public static function updateConditionMeter(param1:MovieClip, param2:Number, param3:Number, param4:Number) : void
      {
         // method body index: 48 method index: 48
         var _loc5_:MovieClip = null;
         if(param3 > 0)
         {
            param1.visible = true;
            _loc5_ = param1.MeterClip_mc;
            param1.gotoAndStop(GlobalFunc.Lerp(param1.totalFrames,1,0,DURABILITY_MAX,param4,true));
            if(param2 > 0)
            {
               _loc5_.gotoAndStop(GlobalFunc.Lerp(_loc5_.totalFrames,2,0,param3 * 2,param2,true));
            }
            else
            {
               _loc5_.gotoAndStop(1);
            }
         }
         else
         {
            param1.visible = false;
         }
      }
      
      public static function updateVoiceIndicator(param1:MovieClip, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean = true, param6:Boolean = false) : void
      {
         // method body index: 49 method index: 49
         if(!param2)
         {
            param1.gotoAndStop("muted");
         }
         else if(!param4)
         {
            param1.gotoAndStop("hasMicSpeakingChannel");
         }
         else if(param3)
         {
            param1.gotoAndStop("hasMicSpeaking");
         }
         else
         {
            param1.gotoAndStop("hasMic");
         }
         if(param1.Icon_mc)
         {
            if(param6)
            {
               param1.Icon_mc.gotoAndStop("enemy");
            }
            else if(param5)
            {
               param1.Icon_mc.gotoAndStop("ally");
            }
            else
            {
               param1.Icon_mc.gotoAndStop("neutral");
            }
         }
      }
      
      public static function quickMultiLineShrinkToFit(param1:TextField, param2:Number = 0, param3:Number = 0) : void
      {
         // method body index: 50 method index: 50
         var _loc4_:TextFormat = param1.getTextFormat();
         if(param2 == 0)
         {
            param2 = _loc4_.size as Number;
         }
         _loc4_.size = param2;
         _loc4_.leading = param3;
         param1.setTextFormat(_loc4_);
         var _loc5_:Boolean = false;
         if(getTextfieldSize(param1) > param1.height)
         {
            _loc4_.size = TEXT_SIZE_VERYSMALL;
            _loc4_.leading = TEXT_LEADING_MIN;
            param1.setTextFormat(_loc4_);
            _loc5_ = true;
         }
         if(_loc5_ && getTextfieldSize(param1) > param1.height)
         {
            _loc4_.size = TEXT_SIZE_MIN;
            _loc4_.leading = TEXT_LEADING_MIN;
            param1.setTextFormat(_loc4_);
         }
      }
      
      public static function shrinkMultiLineTextToFit(param1:TextField, param2:Number = 0) : void
      {
         // method body index: 51 method index: 51
         var _loc3_:TextFormat = param1.getTextFormat();
         if(param2 == 0)
         {
            param2 = _loc3_.size as Number;
         }
         var _loc4_:Number = param2;
         _loc3_.size = _loc4_;
         param1.setTextFormat(_loc3_);
         while(getTextfieldSize(param1) > param1.height && _loc4_ > TEXT_SIZE_MIN)
         {
            _loc4_--;
            _loc3_.size = _loc4_;
            param1.setTextFormat(_loc3_);
         }
      }
      
      public static function getTextfieldSize(param1:TextField, param2:Boolean = true) : *
      {
         // method body index: 52 method index: 52
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         if(param1.multiline)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < param1.numLines)
            {
               _loc3_ = _loc3_ + (!!param2?param1.getLineMetrics(_loc4_).height:param1.getLineMetrics(_loc4_).width);
               _loc4_++;
            }
            return _loc3_;
         }
         return !!param2?param1.textHeight:param1.textWidth;
      }
      
      public static function getDisplayObjectSize(param1:DisplayObject, param2:Boolean = false) : *
      {
         // method body index: 53 method index: 53
         if(param1 is BSScrollingList)
         {
            return (param1 as BSScrollingList).shownItemsHeight;
         }
         if(param1 is BCGridList)
         {
            return (param1 as BCGridList).displayHeight;
         }
         if(param1 is MovieClip)
         {
            if(param1["Sizer_mc"] != undefined && param1["Sizer_mc"] != null)
            {
               return !!param2?param1["Sizer_mc"].height:param1["Sizer_mc"].width;
            }
            if(param1["textField"] != null)
            {
               return getTextfieldSize(param1["textField"],param2);
            }
            return !!param2?param1.height:param1.width;
         }
         if(param1 is TextField)
         {
            return getTextfieldSize(param1 as TextField,param2);
         }
         throw new Error("GlobalFunc.getDisplayObjectSize: unsupported object type");
      }
      
      public static function arrangeItems(param1:Array, param2:Boolean, param3:uint = 0, param4:Number = 0, param5:Boolean = false, param6:Number = 0) : Number
      {
         // method body index: 54 method index: 54
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:Object = null;
         var _loc11_:Array = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = param1.length;
         var _loc14_:Number = 0;
         if(_loc13_ > 0)
         {
            _loc7_ = 0;
            _loc8_ = !!param5?Number(Number(-1)):Number(Number(1));
            _loc11_ = [];
            _loc12_ = param1.length;
            _loc9_ = 0;
            while(_loc9_ < _loc12_)
            {
               if(_loc9_ > 0)
               {
                  _loc14_ = _loc14_ + param4;
               }
               _loc11_[_loc9_] = getDisplayObjectSize(param1[_loc9_],param2);
               _loc14_ = _loc14_ + _loc11_[_loc9_];
               _loc9_++;
            }
            if(param3 == ALIGN_CENTER)
            {
               _loc7_ = _loc14_ * -0.5;
            }
            else if(param3 == ALIGN_RIGHT)
            {
               _loc7_ = -_loc14_ - _loc11_[0];
            }
            if(param5)
            {
               param1.reverse();
               _loc11_.reverse();
            }
            _loc7_ = _loc7_ + param6;
            _loc9_ = 0;
            while(_loc9_ < _loc12_)
            {
               if(param2)
               {
                  param1[_loc9_].y = _loc7_;
               }
               else
               {
                  param1[_loc9_].x = _loc7_;
               }
               _loc7_ = _loc7_ + (_loc11_[_loc9_] + param4);
               _loc9_++;
            }
         }
         return _loc14_;
      }
      
      public static function StringTrim(param1:String) : String
      {
         // method body index: 55 method index: 55
         var _loc2_:String = null;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = param1.length;
         while(param1.charAt(_loc3_) == " " || param1.charAt(_loc3_) == "\n" || param1.charAt(_loc3_) == "\r" || param1.charAt(_loc3_) == "\t")
         {
            _loc3_++;
         }
         _loc2_ = param1.substring(_loc3_);
         _loc4_ = _loc2_.length - 1;
         while(_loc2_.charAt(_loc4_) == " " || _loc2_.charAt(_loc4_) == "\n" || _loc2_.charAt(_loc4_) == "\r" || _loc2_.charAt(_loc4_) == "\t")
         {
            _loc4_--;
         }
         _loc2_ = _loc2_.substring(0,_loc4_ + 1);
         return _loc2_;
      }
      
      public static function BSASSERT(param1:Boolean, param2:String) : void
      {
         // method body index: 56 method index: 56
         var _loc3_:String = null;
         if(!param1)
         {
            _loc3_ = new Error().getStackTrace();
            fscommand("BSASSERT",param2 + "\nCallstack:\n" + _loc3_);
         }
      }
      
      public static function HasFFEvent(param1:Object, param2:String) : Boolean
      {
         // method body index: 57 method index: 57
         var aDataObject:Object = param1;
         var asEventString:String = param2;
         var obj:Object = null;
         var result:Boolean = false;
         try
         {
            if(aDataObject.eventArray.length > 0)
            {
               for each(obj in aDataObject.eventArray)
               {
                  if(obj.eventName == asEventString)
                  {
                     result = true;
                     break;
                  }
               }
            }
         }
         catch(e:Error)
         {
            trace(e.getStackTrace() + " The following Fire Forget Event object could not be parsed:");
            GlobalFunc.InspectObject(aDataObject,true);
         }
         return result;
      }
      
      public static function LocalizeFormattedString(param1:String, ... rest) : String
      {
         // method body index: 58 method index: 58
         var _loc3_:String = "";
         var _loc4_:TextField = new TextField();
         _loc4_.text = param1;
         _loc3_ = _loc4_.text;
         var _loc5_:uint = 0;
         while(_loc5_ < rest.length)
         {
            _loc4_.text = rest[_loc5_];
            _loc3_ = _loc3_.replace("{" + (_loc5_ + 1) + "}",_loc4_.text);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function BuildLegendaryStarsGlyphString(param1:Object) : String
      {
         // method body index: 59 method index: 59
         var _loc2_:* = undefined;
         var _loc3_:TextField = null;
         var _loc4_:Boolean = false;
         var _loc5_:Number = 0;
         var _loc6_:String = "";
         if(param1 != null && param1.hasOwnProperty("isLegendary"))
         {
            _loc4_ = param1.isLegendary;
            if(_loc4_ && param1.hasOwnProperty("numLegendaryStars"))
            {
               _loc5_ = param1.numLegendaryStars;
               _loc2_ = 0;
               while(_loc2_ < _loc5_)
               {
                  _loc3_ = new TextField();
                  _loc3_.text = "$LegendaryModGlyph";
                  _loc6_ = _loc6_ + _loc3_.text;
                  _loc2_++;
               }
               _loc6_ = " " + _loc6_;
            }
         }
         return _loc6_;
      }
   }
}
