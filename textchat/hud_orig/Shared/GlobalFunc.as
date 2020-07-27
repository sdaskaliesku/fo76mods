 
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
      
      public static const PIPBOY_GREY_OUT_ALPHA:Number = // method body index: 108 method index: 108
      0.5;
      
      public static const SELECTED_RECT_ALPHA:Number = // method body index: 108 method index: 108
      1;
      
      public static const DIMMED_ALPHA:Number = // method body index: 108 method index: 108
      0.65;
      
      public static const NUM_DAMAGE_TYPES:uint = // method body index: 108 method index: 108
      6;
      
      public static const PLAYER_ICON_TEXTURE_BUFFER:String = // method body index: 108 method index: 108
      "AvatarTextureBuffer";
      
      public static const STORE_IMAGE_TEXTURE_BUFFER:String = // method body index: 108 method index: 108
      "StoreTextureBuffer";
      
      public static const MAP_TEXTURE_BUFFER:String = // method body index: 108 method index: 108
      "MapMenuTextureBuffer";
      
      protected static const CLOSE_ENOUGH_EPSILON:Number = // method body index: 108 method index: 108
      0.001;
      
      public static const MAX_TRUNCATED_TEXT_LENGTH = // method body index: 108 method index: 108
      42;
      
      public static const PLAY_FOCUS_SOUND:String = // method body index: 108 method index: 108
      "GlobalFunc::playFocusSound";
      
      public static const PLAY_MENU_SOUND:String = // method body index: 108 method index: 108
      "GlobalFunc::playMenuSound";
      
      public static const SHOW_HUD_MESSAGE:String = // method body index: 108 method index: 108
      "GlobalFunc::showHUDMessage";
      
      public static const MENU_SOUND_OK:String = // method body index: 108 method index: 108
      "UIMenuOK";
      
      public static const MENU_SOUND_CANCEL:String = // method body index: 108 method index: 108
      "UIMenuCancel";
      
      public static const MENU_SOUND_PREV_NEXT:String = // method body index: 108 method index: 108
      "UIMenuPrevNext";
      
      public static const MENU_SOUND_POPUP:String = // method body index: 108 method index: 108
      "UIMenuPopupGeneric";
      
      public static const MENU_SOUND_FOCUS_CHANGE:String = // method body index: 108 method index: 108
      "UIMenuFocus";
      
      public static const MENU_SOUND_FRIEND_PROMPT_OPEN:String = // method body index: 108 method index: 108
      "UIMenuPromptFriendRequestBladeOpen";
      
      public static const MENU_SOUND_FRIEND_PROMPT_CLOSE:String = // method body index: 108 method index: 108
      "UIMenuPromptFriendRequestBladeClose";
      
      public static const BUTTON_BAR_ALIGN_CENTER:uint = // method body index: 108 method index: 108
      0;
      
      public static const BUTTON_BAR_ALIGN_LEFT:uint = // method body index: 108 method index: 108
      1;
      
      public static const BUTTON_BAR_ALIGN_RIGHT:uint = // method body index: 108 method index: 108
      2;
      
      public static const COLOR_TEXT_BODY:uint = // method body index: 108 method index: 108
      16777163;
      
      public static const COLOR_TEXT_HEADER:uint = // method body index: 108 method index: 108
      16108379;
      
      public static const COLOR_TEXT_SELECTED:uint = // method body index: 108 method index: 108
      1580061;
      
      public static const COLOR_TEXT_FRIEND:uint = // method body index: 108 method index: 108
      COLOR_TEXT_HEADER;
      
      public static const COLOR_TEXT_ENEMY:uint = // method body index: 108 method index: 108
      16741472;
      
      public static const COLOR_TEXT_UNAVAILABLE:uint = // method body index: 108 method index: 108
      5661031;
      
      public static const COLOR_BACKGROUND_BOX:uint = // method body index: 108 method index: 108
      3225915;
      
      public static const COOR_WARNING:uint = // method body index: 108 method index: 108
      15089200;
      
      public static const COLOR_WARNING_ACCENT:uint = // method body index: 108 method index: 108
      16151129;
      
      public static const COLOR_RARITY_LEGENDARY:uint = // method body index: 108 method index: 108
      15046481;
      
      public static const COLOR_RARITY_EPIC:uint = // method body index: 108 method index: 108
      10763770;
      
      public static const COLOR_RARITY_RARE:uint = // method body index: 108 method index: 108
      4960214;
      
      public static const COLOR_RARITY_COMMON:uint = // method body index: 108 method index: 108
      9043803;
      
      public static const FRAME_RARITY_NONE:String = // method body index: 108 method index: 108
      "None";
      
      public static const FRAME_RARITY_COMMON:String = // method body index: 108 method index: 108
      "Common";
      
      public static const FRAME_RARITY_RARE:String = // method body index: 108 method index: 108
      "Rare";
      
      public static const FRAME_RARITY_EPIC:String = // method body index: 108 method index: 108
      "Epic";
      
      public static const FRAME_RARITY_LEGENDARY:String = // method body index: 108 method index: 108
      "Legendary";
      
      public static var TEXT_SIZE_VERYSMALL:Number = // method body index: 108 method index: 108
      16;
      
      public static var TEXT_SIZE_MIN:Number = // method body index: 108 method index: 108
      14;
      
      public static var TEXT_LEADING_MIN:Number = // method body index: 108 method index: 108
      -2;
      
      public static const VOICE_STATUS_UNAVAILABLE:uint = // method body index: 108 method index: 108
      0;
      
      public static const VOICE_STATUS_AVAILABLE:uint = // method body index: 108 method index: 108
      1;
      
      public static const VOICE_STATUS_SPEAKING:uint = // method body index: 108 method index: 108
      2;
      
      public static const WORLD_TYPE_INVALID:uint = // method body index: 108 method index: 108
      0;
      
      public static const WORLD_TYPE_NORMAL:uint = // method body index: 108 method index: 108
      1;
      
      public static const WORLD_TYPE_SURVIVAL:uint = // method body index: 108 method index: 108
      2;
      
      public static const WORLD_TYPE_NWTEMP:uint = // method body index: 108 method index: 108
      3;
      
      public static const WORLD_TYPE_NUCLEARWINTER:uint = // method body index: 108 method index: 108
      4;
      
      public static const WORLD_TYPE_PRIVATE:uint = // method body index: 108 method index: 108
      5;
      
      public static const QUEST_DISPLAY_TYPE_NONE:uint = // method body index: 108 method index: 108
      0;
      
      public static const QUEST_DISPLAY_TYPE_MAIN:uint = // method body index: 108 method index: 108
      1;
      
      public static const QUEST_DISPLAY_TYPE_SIDE:uint = // method body index: 108 method index: 108
      2;
      
      public static const QUEST_DISPLAY_TYPE_MISC:uint = // method body index: 108 method index: 108
      3;
      
      public static const QUEST_DISPLAY_TYPE_EVENT:uint = // method body index: 108 method index: 108
      4;
      
      public static const QUEST_DISPLAY_TYPE_OTHER:uint = // method body index: 108 method index: 108
      5;
      
      public static const STAT_VALUE_TYPE_INTEGER:uint = // method body index: 108 method index: 108
      0;
      
      public static const STAT_VALUE_TYPE_TIME:uint = // method body index: 108 method index: 108
      1;
      
      public static const STAT_VALUE_TYPE_CAPS:uint = // method body index: 108 method index: 108
      2;
      
      public static var STAT_TYPE_INVALID:uint = // method body index: 108 method index: 108
      20;
      
      public static var STAT_TYPE_SURVIVAL_SCORE = // method body index: 108 method index: 108
      29;
      
      public static const EVENT_USER_CONTEXT_MENU_ACTION:String = // method body index: 108 method index: 108
      "UserContextMenu::MenuOptionSelected";
      
      public static const EVENT_OPEN_USER_CONTEXT_MENU:String = // method body index: 108 method index: 108
      "UserContextMenu::UserSelected";
      
      public static const USER_MENU_CONTEXT_ALL:uint = // method body index: 108 method index: 108
      0;
      
      public static const USER_MENU_CONTEXT_FRIENDS:uint = // method body index: 108 method index: 108
      1;
      
      public static const USER_MENU_CONTEXT_TEAM:uint = // method body index: 108 method index: 108
      2;
      
      public static const USER_MENU_CONTEXT_RECENT:uint = // method body index: 108 method index: 108
      3;
      
      public static const USER_MENU_CONTEXT_BLOCKED:uint = // method body index: 108 method index: 108
      4;
      
      public static const USER_MENU_CONTEXT_MAP:uint = // method body index: 108 method index: 108
      5;
      
      public static const MTX_CURRENCY_ATOMS:uint = // method body index: 108 method index: 108
      0;
      
      public static const ALIGN_LEFT:uint = // method body index: 108 method index: 108
      0;
      
      public static const ALIGN_CENTER:uint = // method body index: 108 method index: 108
      1;
      
      public static const ALIGN_RIGHT:uint = // method body index: 108 method index: 108
      2;
      
      public static const DURABILITY_MAX:uint = // method body index: 108 method index: 108
      100;
      
      public static const DIRECTION_NONE = // method body index: 108 method index: 108
      0;
      
      public static const DIRECTION_UP = // method body index: 108 method index: 108
      1;
      
      public static const DIRECTION_RIGHT = // method body index: 108 method index: 108
      2;
      
      public static const DIRECTION_DOWN = // method body index: 108 method index: 108
      3;
      
      public static const DIRECTION_LEFT = // method body index: 108 method index: 108
      4;
      
      public static const REWARD_TYPE_ENUM_ATOMS = // method body index: 108 method index: 108
      0;
      
      public static const REWARD_TYPE_ENUM_PERK_PACKS = // method body index: 108 method index: 108
      1;
      
      public static const REWARD_TYPE_ENUM_PHOTO_FRAMES = // method body index: 108 method index: 108
      2;
      
      public static const REWARD_TYPE_ENUM_EMOTES = // method body index: 108 method index: 108
      3;
      
      public static const REWARD_TYPE_ENUM_ICONS = // method body index: 108 method index: 108
      4;
      
      public static const REWARD_TYPE_ENUM_WEAPON = // method body index: 108 method index: 108
      5;
      
      public static const REWARD_TYPE_ENUM_WEAPON_MOD = // method body index: 108 method index: 108
      6;
      
      public static const REWARD_TYPE_ENUM_ARMOR = // method body index: 108 method index: 108
      7;
      
      public static const REWARD_TYPE_ENUM_ARMOR_MOD = // method body index: 108 method index: 108
      8;
      
      public static const REWARD_TYPE_ENUM_AMMO = // method body index: 108 method index: 108
      9;
      
      public static const REWARD_TYPE_ENUM_PHOTO_POSE = // method body index: 108 method index: 108
      10;
      
      public static const REWARD_TYPE_ENUM_COMPONENTS = // method body index: 108 method index: 108
      11;
      
      public static const REWARD_TYPE_ENUM_EXPERIENCE = // method body index: 108 method index: 108
      12;
      
      public static const REWARD_TYPE_ENUM_BADGES = // method body index: 108 method index: 108
      13;
      
      public static const REWARD_TYPE_ENUM_STIMPAKS = // method body index: 108 method index: 108
      14;
      
      public static const REWARD_TYPE_ENUM_CHEMS = // method body index: 108 method index: 108
      15;
      
      public static const REWARD_TYPE_ENUM_BOOK = // method body index: 108 method index: 108
      16;
      
      public static const REWARD_TYPE_ENUM_CAPS = // method body index: 108 method index: 108
      17;
      
      public static const REWARD_TYPE_ENUM_LEGENDARY_TOKENS = // method body index: 108 method index: 108
      18;
      
      public static const REWARD_TYPE_ENUM_POSSUM_BADGES = // method body index: 108 method index: 108
      19;
      
      public static const REWARD_TYPE_ENUM_TADPOLE_BADGES = // method body index: 108 method index: 108
      20;
      
      public static const REWARD_TYPE_ENUM_CUSTOM_ICON = // method body index: 108 method index: 108
      21;
      
      public static const REWARD_TYPE_ENUM_CAMP = // method body index: 108 method index: 108
      22;
      
      public static const REWARD_TYPE_ENUM_GOLD_BULLION = // method body index: 108 method index: 108
      23;
      
      public static const REWARD_TYPE_ENUM_SCORE = // method body index: 108 method index: 108
      24;
      
      public static const REWARD_TYPE_ENUM_REPAIR_KIT = // method body index: 108 method index: 108
      25;
      
      public static const REWARD_TYPE_ENUM_LUNCH_BOX = // method body index: 108 method index: 108
      26;
      
      public static const REWARD_TYPE_ENUM_PREMIUM = // method body index: 108 method index: 108
      27;
      
      public static const IMAGE_FRAME_MAP:Object = // method body index: 108 method index: 108
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
         // method body index: 151 method index: 151
         super();
      }
      
      public static function CloneObject(aObjectToClone:Object) : *
      {
         // method body index: 109 method index: 109
         var byteArray:ByteArray = new ByteArray();
         byteArray.writeObject(aObjectToClone);
         byteArray.position = 0;
         return byteArray.readObject();
      }
      
      public static function Lerp(aTargetMin:Number, aTargetMax:Number, aSourceMin:Number, aSourceMax:Number, aSource:Number, abClamp:Boolean) : Number
      {
         // method body index: 110 method index: 110
         var fresult:Number = aTargetMin + (aSource - aSourceMin) / (aSourceMax - aSourceMin) * (aTargetMax - aTargetMin);
         if(abClamp)
         {
            if(aTargetMin < aTargetMax)
            {
               fresult = Math.min(Math.max(fresult,aTargetMin),aTargetMax);
            }
            else
            {
               fresult = Math.min(Math.max(fresult,aTargetMax),aTargetMin);
            }
         }
         return fresult;
      }
      
      public static function PadNumber(aNumber:Number, aLength:uint) : String
      {
         // method body index: 111 method index: 111
         var output:String = "" + aNumber;
         while(output.length < aLength)
         {
            output = "0" + output;
         }
         return output;
      }
      
      public static function setChallengeRewardIcon(aClip:SWFLoaderClip, aChallengeType:uint, aCustomIcon:String = "") : MovieClip
      {
         // method body index: 112 method index: 112
         var rewardIcon:String = null;
         switch(aChallengeType)
         {
            case REWARD_TYPE_ENUM_ATOMS:
               rewardIcon = "IconCR_Atoms";
               break;
            case REWARD_TYPE_ENUM_PERK_PACKS:
               rewardIcon = "IconCR_PerkPack";
               break;
            case REWARD_TYPE_ENUM_PHOTO_FRAMES:
               rewardIcon = "IconCR_PhotoMode";
               break;
            case REWARD_TYPE_ENUM_EMOTES:
               rewardIcon = "IconCR_Emote";
               break;
            case REWARD_TYPE_ENUM_ICONS:
               rewardIcon = "IconCR_PlayerIcon";
               break;
            case REWARD_TYPE_ENUM_WEAPON:
               rewardIcon = "IconCR_Weapon";
               break;
            case REWARD_TYPE_ENUM_WEAPON_MOD:
               rewardIcon = "IconCR_WeaponMod";
               break;
            case REWARD_TYPE_ENUM_ARMOR:
               rewardIcon = "IconCR_Armor";
               break;
            case REWARD_TYPE_ENUM_ARMOR_MOD:
               rewardIcon = "IconCR_ArmorMod";
               break;
            case REWARD_TYPE_ENUM_AMMO:
               rewardIcon = "IconCR_Ammo";
               break;
            case REWARD_TYPE_ENUM_PHOTO_POSE:
               rewardIcon = "IconCR_PhotoMode";
               break;
            case REWARD_TYPE_ENUM_COMPONENTS:
               rewardIcon = "IconCR_Components";
               break;
            case REWARD_TYPE_ENUM_EXPERIENCE:
               rewardIcon = "IconCR_Experience";
               break;
            case REWARD_TYPE_ENUM_BADGES:
               rewardIcon = "IconCR_Badges";
               break;
            case REWARD_TYPE_ENUM_STIMPAKS:
               rewardIcon = "IconCR_Stimpaks";
               break;
            case REWARD_TYPE_ENUM_CHEMS:
               rewardIcon = "IconCR_Chems";
               break;
            case REWARD_TYPE_ENUM_BOOK:
               rewardIcon = "IconCR_Recipe";
               break;
            case REWARD_TYPE_ENUM_CAPS:
               rewardIcon = "IconCR_Caps";
               break;
            case REWARD_TYPE_ENUM_LEGENDARY_TOKENS:
               rewardIcon = "IconCR_LegendaryToken";
               break;
            case REWARD_TYPE_ENUM_POSSUM_BADGES:
            case REWARD_TYPE_ENUM_TADPOLE_BADGES:
               rewardIcon = "IconCR_Caps";
               break;
            case REWARD_TYPE_ENUM_CUSTOM_ICON:
               if(aCustomIcon.length > 0)
               {
                  rewardIcon = aCustomIcon;
                  break;
               }
               throw new Error("GlobalFunc.setChallengeRewardIcon: No custom icon specified.");
            case REWARD_TYPE_ENUM_CAMP:
               rewardIcon = "IconCR_Camp";
               break;
            case REWARD_TYPE_ENUM_GOLD_BULLION:
               rewardIcon = "IconCR_GoldBullion";
               break;
            case REWARD_TYPE_ENUM_SCORE:
               rewardIcon = "IconCR_Score";
               break;
            case REWARD_TYPE_ENUM_REPAIR_KIT:
               rewardIcon = "IconCR_RepairKit";
               break;
            case REWARD_TYPE_ENUM_LUNCH_BOX:
               rewardIcon = "IconCR_LunchBox";
               break;
            case REWARD_TYPE_ENUM_PREMIUM:
               rewardIcon = "IconCR_Premium";
         }
         return aClip.setContainerIconClip(rewardIcon);
      }
      
      public static function parseStatValue(aValue:Number, aValueType:uint) : String
      {
         // method body index: 113 method index: 113
         switch(aValueType)
         {
            case GlobalFunc.STAT_VALUE_TYPE_TIME:
               return ShortTimeString(aValue);
            default:
               return aValue.toString();
         }
      }
      
      public static function ShortTimeString(aSeconds:Number) : String
      {
         // method body index: 114 method index: 114
         var remain:Number = 0;
         var tmpText:TextField = new TextField();
         var days:Number = Math.floor(aSeconds / 86400);
         remain = aSeconds % 86400;
         var hours:Number = Math.floor(remain / 3600);
         remain = aSeconds % 3600;
         var mins:Number = Math.floor(remain / 60);
         remain = aSeconds % 60;
         var secs:Number = Math.floor(remain);
         var timeVal:* = 0;
         if(days >= 1)
         {
            tmpText.text = "$ShortTimeDays";
            timeVal = days;
         }
         else if(hours >= 1)
         {
            tmpText.text = "$ShortTimeHours";
            timeVal = hours;
         }
         else if(mins >= 1)
         {
            tmpText.text = "$ShortTimeMinutes";
            timeVal = mins;
         }
         else if(secs >= 1)
         {
            tmpText.text = "$ShortTimeSeconds";
            timeVal = secs;
         }
         else
         {
            tmpText.text = "$ShortTimeSecond";
            timeVal = secs;
         }
         if(timeVal != 0)
         {
            tmpText.text = tmpText.text.replace("{time}",timeVal.toString());
            return tmpText.text;
         }
         return "0";
      }
      
      public static function SimpleTimeString(aSeconds:Number) : String
      {
         // method body index: 115 method index: 115
         var remain:Number = 0;
         var tmpText:TextField = new TextField();
         var days:Number = Math.floor(aSeconds / 86400);
         remain = aSeconds % 86400;
         var hours:Number = Math.floor(remain / 3600);
         remain = aSeconds % 3600;
         var mins:Number = Math.floor(remain / 60);
         remain = aSeconds % 60;
         var secs:Number = Math.floor(remain);
         var timeVal:* = 0;
         if(days > 1)
         {
            tmpText.text = "$SimpleTimeDays";
            timeVal = days;
         }
         else if(days == 1)
         {
            tmpText.text = "$SimpleTimeDay";
            timeVal = days;
         }
         else if(hours > 1)
         {
            tmpText.text = "$SimpleTimeHours";
            timeVal = hours;
         }
         else if(hours == 1)
         {
            tmpText.text = "$SimpleTimeHour";
            timeVal = hours;
         }
         else if(mins > 1)
         {
            tmpText.text = "$SimpleTimeMinutes";
            timeVal = mins;
         }
         else if(mins == 1)
         {
            tmpText.text = "$SimpleTimeMinute";
            timeVal = mins;
         }
         else if(secs > 1)
         {
            tmpText.text = "$SimpleTimeSeconds";
            timeVal = secs;
         }
         else if(secs == 1)
         {
            tmpText.text = "$SimpleTimeSecond";
            timeVal = secs;
         }
         if(timeVal != 0)
         {
            tmpText.text = tmpText.text.replace("{time}",timeVal.toString());
            return tmpText.text;
         }
         return "0";
      }
      
      public static function FormatTimeString(aSeconds:Number) : String
      {
         // method body index: 116 method index: 116
         var remain:Number = 0;
         var days:Number = Math.floor(aSeconds / 86400);
         remain = aSeconds % 86400;
         var hours:Number = Math.floor(remain / 3600);
         remain = aSeconds % 3600;
         var minutes:Number = Math.floor(remain / 60);
         remain = aSeconds % 60;
         var seconds:Number = Math.floor(remain);
         var hasTime:Boolean = false;
         var output:* = "";
         if(days > 0)
         {
            output = PadNumber(days,2);
            hasTime = true;
         }
         if(days > 0 || hours > 0)
         {
            if(hasTime)
            {
               output = output + ":";
            }
            else
            {
               hasTime = true;
            }
            output = output + PadNumber(hours,2);
         }
         if(days > 0 || hours > 0 || minutes > 0)
         {
            if(hasTime)
            {
               output = output + ":";
            }
            else
            {
               hasTime = true;
            }
            output = output + PadNumber(minutes,2);
         }
         if(days > 0 || hours > 0 || minutes > 0 || seconds > 0)
         {
            if(hasTime)
            {
               output = output + ":";
            }
            else if(days == 0 && hours == 0 && minutes == 0)
            {
               output = "0:";
            }
            output = output + PadNumber(seconds,2);
         }
         return output;
      }
      
      public static function ImageFrameFromCharacter(aInput:String) : uint
      {
         // method body index: 117 method index: 117
         var firstChar:String = null;
         if(aInput != null && aInput.length > 0)
         {
            firstChar = aInput.substring(0,1).toLowerCase();
            if(IMAGE_FRAME_MAP[firstChar] != null)
            {
               return IMAGE_FRAME_MAP[firstChar];
            }
         }
         return 1;
      }
      
      public static function GetAccountIconPath(aInput:String) : String
      {
         // method body index: 118 method index: 118
         if(aInput == null || aInput.length == 0)
         {
            aInput = "Textures/ATX/Storefront/PlayerIcons/ATX_PlayerIcon_VaultBoy_76.dds";
         }
         return aInput;
      }
      
      public static function RoundDecimal(aNumber:Number, aPrecision:Number) : Number
      {
         // method body index: 119 method index: 119
         var decimal:Number = Math.pow(10,aPrecision);
         return Math.round(decimal * aNumber) / decimal;
      }
      
      public static function CloseToNumber(aNumber1:Number, aNumber2:Number, aEpsilon:Number = 0.001) : Boolean
      {
         // method body index: 120 method index: 120
         return Math.abs(aNumber1 - aNumber2) < aEpsilon;
      }
      
      public static function Clamp(val:Number, min:Number, max:Number) : Number
      {
         // method body index: 121 method index: 121
         return Math.max(min,Math.min(max,val));
      }
      
      public static function MaintainTextFormat() : *
      {
         // method body index: 123 method index: 123
         TextField.prototype.SetText = function(aText:String, abHTMLText:Boolean = false, aUpperCase:Boolean = false):// method body index: 122 method index: 122
         *
         {
            // method body index: 122 method index: 122
            var oldSpacing:Number = NaN;
            var oldKerning:Boolean = false;
            if(!aText || aText == "")
            {
               aText = " ";
            }
            if(aUpperCase && aText.charAt(0) != "$")
            {
               aText = aText.toUpperCase();
            }
            var format:TextFormat = this.getTextFormat();
            if(abHTMLText)
            {
               oldSpacing = Number(format.letterSpacing);
               oldKerning = format.kerning;
               this.htmlText = aText;
               format = this.getTextFormat();
               format.letterSpacing = oldSpacing;
               format.kerning = oldKerning;
               this.setTextFormat(format);
               this.htmlText = aText;
            }
            else
            {
               this.text = aText;
               this.setTextFormat(format);
               this.text = aText;
            }
         };
      }
      
      public static function SetText(aTextField:TextField, aText:String, abHTMLText:Boolean = false, abUpperCase:Boolean = false, abTruncate:* = false) : *
      {
         // method body index: 124 method index: 124
         var format:TextFormat = null;
         var oldSpacing:Number = NaN;
         var oldKerning:Boolean = false;
         if(!aText || aText == "")
         {
            aText = " ";
         }
         if(abUpperCase && aText.charAt(0) != "$")
         {
            aText = aText.toUpperCase();
         }
         if(abHTMLText)
         {
            format = aTextField.getTextFormat();
            oldSpacing = Number(format.letterSpacing);
            oldKerning = format.kerning;
            aTextField.htmlText = aText;
            format = aTextField.getTextFormat();
            format.letterSpacing = oldSpacing;
            format.kerning = oldKerning;
            aTextField.setTextFormat(format);
         }
         else
         {
            aTextField.text = aText;
         }
         if(abTruncate && aTextField.text.length > MAX_TRUNCATED_TEXT_LENGTH)
         {
            aTextField.text = aTextField.text.slice(0,MAX_TRUNCATED_TEXT_LENGTH - 3) + "...";
         }
      }
      
      public static function LockToSafeRect(aDisplayObject:DisplayObject, aPosition:String, aSafeX:Number = 0, aSafeY:Number = 0) : *
      {
         // method body index: 125 method index: 125
         var visibleRect:Rectangle = Extensions.visibleRect;
         var topLeft_Global:Point = new Point(visibleRect.x + aSafeX,visibleRect.y + aSafeY);
         var bottomRight_Global:Point = new Point(visibleRect.x + visibleRect.width - aSafeX,visibleRect.y + visibleRect.height - aSafeY);
         var topLeft:Point = aDisplayObject.parent.globalToLocal(topLeft_Global);
         var bottomRight:Point = aDisplayObject.parent.globalToLocal(bottomRight_Global);
         var centerPoint:Point = Point.interpolate(topLeft,bottomRight,0.5);
         if(aPosition == "T" || aPosition == "TL" || aPosition == "TR" || aPosition == "TC")
         {
            aDisplayObject.y = topLeft.y;
         }
         if(aPosition == "CR" || aPosition == "CC" || aPosition == "CL")
         {
            aDisplayObject.y = centerPoint.y;
         }
         if(aPosition == "B" || aPosition == "BL" || aPosition == "BR" || aPosition == "BC")
         {
            aDisplayObject.y = bottomRight.y;
         }
         if(aPosition == "L" || aPosition == "TL" || aPosition == "BL" || aPosition == "CL")
         {
            aDisplayObject.x = topLeft.x;
         }
         if(aPosition == "TC" || aPosition == "CC" || aPosition == "BC")
         {
            aDisplayObject.x = centerPoint.x;
         }
         if(aPosition == "R" || aPosition == "TR" || aPosition == "BR" || aPosition == "CR")
         {
            aDisplayObject.x = bottomRight.x;
         }
      }
      
      public static function AddMovieExploreFunctions() : *
      {
         // method body index: 128 method index: 128
         MovieClip.prototype.getMovieClips = function():// method body index: 126 method index: 126
         Array
         {
            // method body index: 126 method index: 126
            var i:* = undefined;
            var movieClips:* = new Array();
            for(i in this)
            {
               if(this[i] is MovieClip && this[i] != this)
               {
                  movieClips.push(this[i]);
               }
            }
            return movieClips;
         };
         MovieClip.prototype.showMovieClips = function():// method body index: 127 method index: 127
         *
         {
            // method body index: 127 method index: 127
            var i:* = undefined;
            for(i in this)
            {
               if(this[i] is MovieClip && this[i] != this)
               {
                  trace(this[i]);
                  this[i].showMovieClips();
               }
            }
         };
      }
      
      public static function InspectObject(aObject:Object, abRecursive:Boolean = false, abIncludeProperties:Boolean = false) : void
      {
         // method body index: 129 method index: 129
         var className:String = getQualifiedClassName(aObject);
         trace("Inspecting object with type " + className);
         trace("{");
         InspectObjectHelper(aObject,abRecursive,abIncludeProperties);
         trace("}");
      }
      
      private static function InspectObjectHelper(aObject:Object, abRecursive:Boolean, abIncludeProperties:Boolean, astrIndent:String = "\t") : void
      {
         // method body index: 130 method index: 130
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
         // method body index: 135 method index: 135
         MovieClip.prototype.PlayReverseCallback = function(event:Event):// method body index: 131 method index: 131
         *
         {
            // method body index: 131 method index: 131
            if(event.currentTarget.currentFrame > 1)
            {
               event.currentTarget.gotoAndStop(event.currentTarget.currentFrame - 1);
            }
            else
            {
               event.currentTarget.removeEventListener(Event.ENTER_FRAME,event.currentTarget.PlayReverseCallback);
            }
         };
         MovieClip.prototype.PlayReverse = function():// method body index: 132 method index: 132
         *
         {
            // method body index: 132 method index: 132
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
         MovieClip.prototype.PlayForward = function(aFrameLabel:String):// method body index: 133 method index: 133
         *
         {
            // method body index: 133 method index: 133
            delete this.onEnterFrame;
            this.gotoAndPlay(aFrameLabel);
         };
         MovieClip.prototype.PlayForward = function(aFrame:Number):// method body index: 134 method index: 134
         *
         {
            // method body index: 134 method index: 134
            delete this.onEnterFrame;
            this.gotoAndPlay(aFrame);
         };
      }
      
      public static function PlayMenuSound(aSoundID:String) : *
      {
         // method body index: 136 method index: 136
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{
            "soundID":aSoundID,
            "soundFormID":0
         }));
      }
      
      public static function PlayMenuSoundWithFormID(aSoundFormID:uint) : *
      {
         // method body index: 137 method index: 137
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{
            "soundID":"",
            "soundFormID":aSoundFormID
         }));
      }
      
      public static function ShowHUDMessage(aMessage:String) : *
      {
         // method body index: 138 method index: 138
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.SHOW_HUD_MESSAGE,{"text":aMessage}));
      }
      
      public static function updateConditionMeter(aBar:MovieClip, aCurrentHealth:Number, aMaximumHealth:Number, aDurability:Number) : void
      {
         // method body index: 139 method index: 139
         var conditionInternal:MovieClip = null;
         if(aMaximumHealth > 0)
         {
            aBar.visible = true;
            conditionInternal = aBar.MeterClip_mc;
            aBar.gotoAndStop(GlobalFunc.Lerp(aBar.totalFrames,1,0,DURABILITY_MAX,aDurability,true));
            if(aCurrentHealth > 0)
            {
               conditionInternal.gotoAndStop(GlobalFunc.Lerp(conditionInternal.totalFrames,2,0,aMaximumHealth * 2,aCurrentHealth,true));
            }
            else
            {
               conditionInternal.gotoAndStop(1);
            }
         }
         else
         {
            aBar.visible = false;
         }
      }
      
      public static function updateVoiceIndicator(aClip:MovieClip, aVoiceEnabled:Boolean, aSpeaking:Boolean, aSameChannel:Boolean, aIsAlly:Boolean = true, aIsEnemy:Boolean = false) : void
      {
         // method body index: 140 method index: 140
         if(!aVoiceEnabled)
         {
            aClip.gotoAndStop("muted");
         }
         else if(!aSameChannel)
         {
            aClip.gotoAndStop("hasMicSpeakingChannel");
         }
         else if(aSpeaking)
         {
            aClip.gotoAndStop("hasMicSpeaking");
         }
         else
         {
            aClip.gotoAndStop("hasMic");
         }
         if(aClip.Icon_mc)
         {
            if(aIsEnemy)
            {
               aClip.Icon_mc.gotoAndStop("enemy");
            }
            else if(aIsAlly)
            {
               aClip.Icon_mc.gotoAndStop("ally");
            }
            else
            {
               aClip.Icon_mc.gotoAndStop("neutral");
            }
         }
      }
      
      public static function quickMultiLineShrinkToFit(aField:TextField, aBaseSize:Number = 0, aBaseLeading:Number = 0) : void
      {
         // method body index: 141 method index: 141
         var thisTextFormat:TextFormat = aField.getTextFormat();
         if(aBaseSize == 0)
         {
            aBaseSize = thisTextFormat.size as Number;
         }
         thisTextFormat.size = aBaseSize;
         thisTextFormat.leading = aBaseLeading;
         aField.setTextFormat(thisTextFormat);
         var needEvaluateSize:Boolean = false;
         if(getTextfieldSize(aField) > aField.height)
         {
            thisTextFormat.size = TEXT_SIZE_VERYSMALL;
            thisTextFormat.leading = TEXT_LEADING_MIN;
            aField.setTextFormat(thisTextFormat);
            needEvaluateSize = true;
         }
         if(needEvaluateSize && getTextfieldSize(aField) > aField.height)
         {
            thisTextFormat.size = TEXT_SIZE_MIN;
            thisTextFormat.leading = TEXT_LEADING_MIN;
            aField.setTextFormat(thisTextFormat);
         }
      }
      
      public static function shrinkMultiLineTextToFit(aField:TextField, aBaseSize:Number = 0) : void
      {
         // method body index: 142 method index: 142
         var thisTextFormat:TextFormat = aField.getTextFormat();
         if(aBaseSize == 0)
         {
            aBaseSize = thisTextFormat.size as Number;
         }
         var curSize:Number = aBaseSize;
         thisTextFormat.size = curSize;
         aField.setTextFormat(thisTextFormat);
         while(getTextfieldSize(aField) > aField.height && curSize > TEXT_SIZE_MIN)
         {
            curSize--;
            thisTextFormat.size = curSize;
            aField.setTextFormat(thisTextFormat);
         }
      }
      
      public static function getTextfieldSize(aTextfield:TextField, aVertical:Boolean = true) : *
      {
         // method body index: 143 method index: 143
         var totalSize:Number = NaN;
         var i:uint = 0;
         if(aTextfield.multiline)
         {
            totalSize = 0;
            for(i = 0; i < aTextfield.numLines; i++)
            {
               totalSize = totalSize + (!!aVertical?aTextfield.getLineMetrics(i).height:aTextfield.getLineMetrics(i).width);
            }
            return totalSize;
         }
         return !!aVertical?aTextfield.textHeight:aTextfield.textWidth;
      }
      
      public static function getDisplayObjectSize(aObject:DisplayObject, aVertical:Boolean = false) : *
      {
         // method body index: 144 method index: 144
         if(aObject is BSScrollingList)
         {
            return (aObject as BSScrollingList).shownItemsHeight;
         }
         if(aObject is BCGridList)
         {
            return (aObject as BCGridList).displayHeight;
         }
         if(aObject is MovieClip)
         {
            if(aObject["Sizer_mc"] != undefined && aObject["Sizer_mc"] != null)
            {
               return !!aVertical?aObject["Sizer_mc"].height:aObject["Sizer_mc"].width;
            }
            if(aObject["textField"] != null)
            {
               return getTextfieldSize(aObject["textField"],aVertical);
            }
            return !!aVertical?aObject.height:aObject.width;
         }
         if(aObject is TextField)
         {
            return getTextfieldSize(aObject as TextField,aVertical);
         }
         throw new Error("GlobalFunc.getDisplayObjectSize: unsupported object type");
      }
      
      public static function arrangeItems(aItems:Array, aVertical:Boolean, aAlign:uint = 0, aSpacing:Number = 0, aReverse:Boolean = false, aOffset:Number = 0) : Number
      {
         // method body index: 145 method index: 145
         var positionOrigin:Number = NaN;
         var offsetMultiplier:Number = NaN;
         var itemIndex:uint = 0;
         var curItem:Object = null;
         var itemSizes:Array = null;
         var itemCount:uint = 0;
         var itemLength:uint = aItems.length;
         var totalDistance:Number = 0;
         if(itemLength > 0)
         {
            positionOrigin = 0;
            offsetMultiplier = !!aReverse?Number(-1):Number(1);
            itemSizes = [];
            itemCount = aItems.length;
            for(itemIndex = 0; itemIndex < itemCount; itemIndex++)
            {
               if(itemIndex > 0)
               {
                  totalDistance = totalDistance + aSpacing;
               }
               itemSizes[itemIndex] = getDisplayObjectSize(aItems[itemIndex],aVertical);
               totalDistance = totalDistance + itemSizes[itemIndex];
            }
            if(aAlign == ALIGN_CENTER)
            {
               positionOrigin = totalDistance * -0.5;
            }
            else if(aAlign == ALIGN_RIGHT)
            {
               positionOrigin = -totalDistance - itemSizes[0];
            }
            if(aReverse)
            {
               aItems.reverse();
               itemSizes.reverse();
            }
            positionOrigin = positionOrigin + aOffset;
            for(itemIndex = 0; itemIndex < itemCount; itemIndex++)
            {
               if(aVertical)
               {
                  aItems[itemIndex].y = positionOrigin;
               }
               else
               {
                  aItems[itemIndex].x = positionOrigin;
               }
               positionOrigin = positionOrigin + (itemSizes[itemIndex] + aSpacing);
            }
         }
         return totalDistance;
      }
      
      public static function StringTrim(astrText:String) : String
      {
         // method body index: 146 method index: 146
         var strResult:String = null;
         var startIndex:Number = 0;
         var endIndex:Number = 0;
         var strLength:Number = astrText.length;
         while(astrText.charAt(startIndex) == " " || astrText.charAt(startIndex) == "\n" || astrText.charAt(startIndex) == "\r" || astrText.charAt(startIndex) == "\t")
         {
            startIndex++;
         }
         strResult = astrText.substring(startIndex);
         endIndex = strResult.length - 1;
         while(strResult.charAt(endIndex) == " " || strResult.charAt(endIndex) == "\n" || strResult.charAt(endIndex) == "\r" || strResult.charAt(endIndex) == "\t")
         {
            endIndex--;
         }
         strResult = strResult.substring(0,endIndex + 1);
         return strResult;
      }
      
      public static function BSASSERT(abConditional:Boolean, asMessage:String) : void
      {
         // method body index: 147 method index: 147
         var callStack:String = null;
         if(!abConditional)
         {
            callStack = new Error().getStackTrace();
            fscommand("BSASSERT",asMessage + "\nCallstack:\n" + callStack);
         }
      }
      
      public static function HasFFEvent(aDataObject:Object, asEventString:String) : Boolean
      {
         // method body index: 148 method index: 148
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
      
      public static function LocalizeFormattedString(aFormatString:String, ... aParameters) : String
      {
         // method body index: 149 method index: 149
         var resultString:String = "";
         var localizationTextField:TextField = new TextField();
         localizationTextField.text = aFormatString;
         resultString = localizationTextField.text;
         for(var i:uint = 0; i < aParameters.length; i++)
         {
            localizationTextField.text = aParameters[i];
            resultString = resultString.replace("{" + (i + 1) + "}",localizationTextField.text);
         }
         return resultString;
      }
      
      public static function BuildLegendaryStarsGlyphString(aEntryObject:Object) : String
      {
         // method body index: 150 method index: 150
         var legendaryModIndex:* = undefined;
         var textFieldTemp:TextField = null;
         var isLegendary:Boolean = false;
         var numLegendaryStars:Number = 0;
         var starsText:String = "";
         if(aEntryObject != null && aEntryObject.hasOwnProperty("isLegendary"))
         {
            isLegendary = aEntryObject.isLegendary;
            if(isLegendary && aEntryObject.hasOwnProperty("numLegendaryStars"))
            {
               numLegendaryStars = aEntryObject.numLegendaryStars;
               for(legendaryModIndex = 0; legendaryModIndex < numLegendaryStars; legendaryModIndex++)
               {
                  textFieldTemp = new TextField();
                  textFieldTemp.text = "$LegendaryModGlyph";
                  starsText = starsText + textFieldTemp.text;
               }
               starsText = " " + starsText;
            }
         }
         return starsText;
      }
   }
}
