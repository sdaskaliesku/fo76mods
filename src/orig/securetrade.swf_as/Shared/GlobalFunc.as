package Shared 
{
    import Shared.AS3.*;
    import Shared.AS3.Data.*;
    import Shared.AS3.Events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import scaleform.gfx.*;
    
    public class GlobalFunc extends Object
    {
        public function GlobalFunc()
        {
            super();
            return;
        }

        public static function Lerp(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Boolean):Number
        {
            var loc1:*=arg1 + (arg5 - arg3) / (arg4 - arg3) * (arg2 - arg1);
            if (arg6) 
            {
                if (arg1 < arg2) 
                {
                    loc1 = Math.min(Math.max(loc1, arg1), arg2);
                }
                else 
                {
                    loc1 = Math.min(Math.max(loc1, arg2), arg1);
                }
            }
            return loc1;
        }

        public static function CloneObject(arg1:Object):*
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeObject(arg1);
            loc1.position = 0;
            return loc1.readObject();
        }

        public static function parseStatValue(arg1:Number, arg2:uint):String
        {
            var loc1:*=arg2;
            switch (loc1) 
            {
                case Shared.GlobalFunc.STAT_VALUE_TYPE_TIME:
                {
                    return ShortTimeString(arg1);
                }
            }
            return arg1.toString();
        }

        public static function setChallengeRewardIcon(arg1:Shared.AS3.SWFLoaderClip, arg2:uint, arg3:String=""):flash.display.MovieClip
        {
            var loc1:*=null;
            var loc2:*=arg2;
            switch (loc2) 
            {
                case REWARD_TYPE_ENUM_ATOMS:
                {
                    loc1 = "IconCR_Atoms";
                    break;
                }
                case REWARD_TYPE_ENUM_PERK_PACKS:
                {
                    loc1 = "IconCR_PerkPack";
                    break;
                }
                case REWARD_TYPE_ENUM_PHOTO_FRAMES:
                {
                    loc1 = "IconCR_PhotoMode";
                    break;
                }
                case REWARD_TYPE_ENUM_EMOTES:
                {
                    loc1 = "IconCR_Emote";
                    break;
                }
                case REWARD_TYPE_ENUM_ICONS:
                {
                    loc1 = "IconCR_PlayerIcon";
                    break;
                }
                case REWARD_TYPE_ENUM_WEAPON:
                {
                    loc1 = "IconCR_Weapon";
                    break;
                }
                case REWARD_TYPE_ENUM_WEAPON_MOD:
                {
                    loc1 = "IconCR_WeaponMod";
                    break;
                }
                case REWARD_TYPE_ENUM_ARMOR:
                {
                    loc1 = "IconCR_Armor";
                    break;
                }
                case REWARD_TYPE_ENUM_ARMOR_MOD:
                {
                    loc1 = "IconCR_ArmorMod";
                    break;
                }
                case REWARD_TYPE_ENUM_AMMO:
                {
                    loc1 = "IconCR_Ammo";
                    break;
                }
                case REWARD_TYPE_ENUM_PHOTO_POSE:
                {
                    loc1 = "IconCR_PhotoMode";
                    break;
                }
                case REWARD_TYPE_ENUM_COMPONENTS:
                {
                    loc1 = "IconCR_Components";
                    break;
                }
                case REWARD_TYPE_ENUM_EXPERIENCE:
                {
                    loc1 = "IconCR_Experience";
                    break;
                }
                case REWARD_TYPE_ENUM_BADGES:
                {
                    loc1 = "IconCR_Badges";
                    break;
                }
                case REWARD_TYPE_ENUM_STIMPAKS:
                {
                    loc1 = "IconCR_Stimpaks";
                    break;
                }
                case REWARD_TYPE_ENUM_CHEMS:
                {
                    loc1 = "IconCR_Chems";
                    break;
                }
                case REWARD_TYPE_ENUM_BOOK:
                {
                    loc1 = "IconCR_Recipe";
                    break;
                }
                case REWARD_TYPE_ENUM_CAPS:
                {
                    loc1 = "IconCR_Caps";
                    break;
                }
                case REWARD_TYPE_ENUM_LEGENDARY_TOKENS:
                {
                    loc1 = "IconCR_LegendaryToken";
                    break;
                }
                case REWARD_TYPE_ENUM_POSSUM_BADGES:
                case REWARD_TYPE_ENUM_TADPOLE_BADGES:
                {
                    loc1 = "IconCR_Caps";
                    break;
                }
                case REWARD_TYPE_ENUM_CUSTOM_ICON:
                {
                    if (arg3.length > 0) 
                    {
                        loc1 = arg3;
                    }
                    else 
                    {
                        throw new Error("GlobalFunc.setChallengeRewardIcon: No custom icon specified.");
                    }
                    break;
                }
                case REWARD_TYPE_ENUM_CAMP:
                {
                    loc1 = "IconCR_Camp";
                    break;
                }
                case REWARD_TYPE_ENUM_GOLD_BULLION:
                {
                    loc1 = "IconCR_GoldBullion";
                    break;
                }
                case REWARD_TYPE_ENUM_SCORE:
                {
                    loc1 = "IconCR_Score";
                    break;
                }
                case REWARD_TYPE_ENUM_REPAIR_KIT:
                {
                    loc1 = "IconCR_RepairKit";
                    break;
                }
                case REWARD_TYPE_ENUM_LUNCH_BOX:
                {
                    loc1 = "IconCR_LunchBox";
                    break;
                }
                case REWARD_TYPE_ENUM_PREMIUM:
                {
                    loc1 = "IconCR_Premium";
                    break;
                }
            }
            return arg1.setContainerIconClip(loc1);
        }

        public static function PadNumber(arg1:Number, arg2:uint):String
        {
            var loc1:*="" + arg1;
            while (loc1.length < arg2) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        public static function InspectObject(arg1:Object, arg2:Boolean=false, arg3:Boolean=false):void
        {
            var loc1:*=flash.utils.getQualifiedClassName(arg1);
            trace("Inspecting object with type " + loc1);
            trace("{");
            InspectObjectHelper(arg1, arg2, arg3);
            trace("}");
            return;
        }

        public static function ShortTimeString(arg1:Number):String
        {
            var loc1:*=0;
            var loc2:*=new flash.text.TextField();
            var loc3:*=Math.floor(arg1 / 86400);
            loc1 = arg1 % 86400;
            var loc4:*=Math.floor(loc1 / 3600);
            loc1 = arg1 % 3600;
            var loc5:*=Math.floor(loc1 / 60);
            loc1 = arg1 % 60;
            var loc6:*=Math.floor(loc1);
            var loc7:*=0;
            if (loc3 >= 1) 
            {
                loc2.text = "$ShortTimeDays";
                loc7 = loc3;
            }
            else if (loc4 >= 1) 
            {
                loc2.text = "$ShortTimeHours";
                loc7 = loc4;
            }
            else if (loc5 >= 1) 
            {
                loc2.text = "$ShortTimeMinutes";
                loc7 = loc5;
            }
            else if (loc6 >= 1) 
            {
                loc2.text = "$ShortTimeSeconds";
                loc7 = loc6;
            }
            else 
            {
                loc2.text = "$ShortTimeSecond";
                loc7 = loc6;
            }
            if (loc7 != 0) 
            {
                loc2.text = loc2.text.replace("{time}", loc7.toString());
                return loc2.text;
            }
            return "0";
        }

        public static function SimpleTimeString(arg1:Number):String
        {
            var loc1:*=0;
            var loc2:*=new flash.text.TextField();
            var loc3:*=Math.floor(arg1 / 86400);
            loc1 = arg1 % 86400;
            var loc4:*=Math.floor(loc1 / 3600);
            loc1 = arg1 % 3600;
            var loc5:*=Math.floor(loc1 / 60);
            loc1 = arg1 % 60;
            var loc6:*=Math.floor(loc1);
            var loc7:*=0;
            if (loc3 > 1) 
            {
                loc2.text = "$SimpleTimeDays";
                loc7 = loc3;
            }
            else if (loc3 != 1) 
            {
                if (loc4 > 1) 
                {
                    loc2.text = "$SimpleTimeHours";
                    loc7 = loc4;
                }
                else if (loc4 != 1) 
                {
                    if (loc5 > 1) 
                    {
                        loc2.text = "$SimpleTimeMinutes";
                        loc7 = loc5;
                    }
                    else if (loc5 != 1) 
                    {
                        if (loc6 > 1) 
                        {
                            loc2.text = "$SimpleTimeSeconds";
                            loc7 = loc6;
                        }
                        else if (loc6 == 1) 
                        {
                            loc2.text = "$SimpleTimeSecond";
                            loc7 = loc6;
                        }
                    }
                    else 
                    {
                        loc2.text = "$SimpleTimeMinute";
                        loc7 = loc5;
                    }
                }
                else 
                {
                    loc2.text = "$SimpleTimeHour";
                    loc7 = loc4;
                }
            }
            else 
            {
                loc2.text = "$SimpleTimeDay";
                loc7 = loc3;
            }
            if (loc7 != 0) 
            {
                loc2.text = loc2.text.replace("{time}", loc7.toString());
                return loc2.text;
            }
            return "0";
        }

        public static function FormatTimeString(arg1:Number):String
        {
            var loc1:*=0;
            var loc2:*=Math.floor(arg1 / 86400);
            loc1 = arg1 % 86400;
            var loc3:*=Math.floor(loc1 / 3600);
            loc1 = arg1 % 3600;
            var loc4:*=Math.floor(loc1 / 60);
            loc1 = arg1 % 60;
            var loc5:*=Math.floor(loc1);
            var loc6:*=false;
            var loc7:*="";
            if (loc2 > 0) 
            {
                loc7 = PadNumber(loc2, 2);
                loc6 = true;
            }
            if (loc2 > 0 || loc3 > 0) 
            {
                if (loc6) 
                {
                    loc7 = loc7 + ":";
                }
                else 
                {
                    loc6 = true;
                }
                loc7 = loc7 + PadNumber(loc3, 2);
            }
            if (loc2 > 0 || loc3 > 0 || loc4 > 0) 
            {
                if (loc6) 
                {
                    loc7 = loc7 + ":";
                }
                else 
                {
                    loc6 = true;
                }
                loc7 = loc7 + PadNumber(loc4, 2);
            }
            if (loc2 > 0 || loc3 > 0 || loc4 > 0 || loc5 > 0) 
            {
                if (loc6) 
                {
                    loc7 = loc7 + ":";
                }
                else if (loc2 == 0 && loc3 == 0 && loc4 == 0) 
                {
                    loc7 = "0:";
                }
                loc7 = loc7 + PadNumber(loc5, 2);
            }
            return loc7;
        }

        public static function ImageFrameFromCharacter(arg1:String):uint
        {
            var loc1:*=null;
            if (!(arg1 == null) && arg1.length > 0) 
            {
                loc1 = arg1.substring(0, 1).toLowerCase();
                if (IMAGE_FRAME_MAP[loc1] != null) 
                {
                    return IMAGE_FRAME_MAP[loc1];
                }
            }
            return 1;
        }

        public static function GetAccountIconPath(arg1:String):String
        {
            if (arg1 == null || arg1.length == 0) 
            {
                arg1 = "Textures/ATX/Storefront/PlayerIcons/ATX_PlayerIcon_VaultBoy_76.dds";
            }
            return arg1;
        }

        public static function RoundDecimal(arg1:Number, arg2:Number):Number
        {
            var loc1:*=Math.pow(10, arg2);
            return Math.round(loc1 * arg1) / loc1;
        }

        public static function CloseToNumber(arg1:Number, arg2:Number, arg3:Number=0.001):Boolean
        {
            return Math.abs(arg1 - arg2) < arg3;
        }

        public static function Clamp(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return Math.max(arg2, Math.min(arg3, arg1));
        }

        public static function MaintainTextFormat():*
        {
            var loc1:*;
            flash.text.TextField.prototype.SetText = function (arg1:String, arg2:Boolean=false, arg3:Boolean=false):*
            {
                var loc2:*=NaN;
                var loc3:*=false;
                if (!arg1 || arg1 == "") 
                {
                    arg1 = " ";
                }
                if (arg3 && !(arg1.charAt(0) == "$")) 
                {
                    arg1 = arg1.toUpperCase();
                }
                var loc1:*=this.getTextFormat();
                if (arg2) 
                {
                    loc2 = Number(loc1.letterSpacing);
                    loc3 = loc1.kerning;
                    this.htmlText = arg1;
                    (loc1 = this.getTextFormat()).letterSpacing = loc2;
                    loc1.kerning = loc3;
                    this.setTextFormat(loc1);
                    this.htmlText = arg1;
                }
                else 
                {
                    this.text = arg1;
                    this.setTextFormat(loc1);
                    this.text = arg1;
                }
                return;
            }
            return;
        }

        public static function SetText(arg1:flash.text.TextField, arg2:String, arg3:Boolean=false, arg4:Boolean=false, arg5:*=false):*
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=false;
            if (!arg2 || arg2 == "") 
            {
                arg2 = " ";
            }
            if (arg4 && !(arg2.charAt(0) == "$")) 
            {
                arg2 = arg2.toUpperCase();
            }
            if (arg3) 
            {
                loc1 = arg1.getTextFormat();
                loc2 = Number(loc1.letterSpacing);
                loc3 = loc1.kerning;
                arg1.htmlText = arg2;
                (loc1 = arg1.getTextFormat()).letterSpacing = loc2;
                loc1.kerning = loc3;
                arg1.setTextFormat(loc1);
            }
            else 
            {
                arg1.text = arg2;
            }
            if (arg5 && arg1.text.length > MAX_TRUNCATED_TEXT_LENGTH) 
            {
                arg1.text = arg1.text.slice(0, MAX_TRUNCATED_TEXT_LENGTH - 3) + "...";
            }
            return;
        }

        public static function LockToSafeRect(arg1:flash.display.DisplayObject, arg2:String, arg3:Number=0, arg4:Number=0):*
        {
            var loc1:*=scaleform.gfx.Extensions.visibleRect;
            var loc2:*=new flash.geom.Point(loc1.x + arg3, loc1.y + arg4);
            var loc3:*=new flash.geom.Point(loc1.x + loc1.width - arg3, loc1.y + loc1.height - arg4);
            var loc4:*=arg1.parent.globalToLocal(loc2);
            var loc5:*=arg1.parent.globalToLocal(loc3);
            var loc6:*=flash.geom.Point.interpolate(loc4, loc5, 0.5);
            if (arg2 == "T" || arg2 == "TL" || arg2 == "TR" || arg2 == "TC") 
            {
                arg1.y = loc4.y;
            }
            if (arg2 == "CR" || arg2 == "CC" || arg2 == "CL") 
            {
                arg1.y = loc6.y;
            }
            if (arg2 == "B" || arg2 == "BL" || arg2 == "BR" || arg2 == "BC") 
            {
                arg1.y = loc5.y;
            }
            if (arg2 == "L" || arg2 == "TL" || arg2 == "BL" || arg2 == "CL") 
            {
                arg1.x = loc4.x;
            }
            if (arg2 == "TC" || arg2 == "CC" || arg2 == "BC") 
            {
                arg1.x = loc6.x;
            }
            if (arg2 == "R" || arg2 == "TR" || arg2 == "BR" || arg2 == "CR") 
            {
                arg1.x = loc5.x;
            }
            return;
        }

        public static function AddMovieExploreFunctions():*
        {
            var loc1:*;
            flash.display.MovieClip.prototype.getMovieClips = function ():Array
            {
                var loc2:*=undefined;
                var loc1:*=new Array();
                var loc3:*=0;
                var loc4:*=this;
                for (loc2 in loc4) 
                {
                    if (!(this[loc2] is flash.display.MovieClip && !(this[loc2] == this))) 
                    {
                        continue;
                    }
                    loc1.push(this[loc2]);
                }
                return loc1;
            }
            flash.display.MovieClip.prototype.showMovieClips = function ():*
            {
                var loc1:*=undefined;
                var loc2:*=0;
                var loc3:*=this;
                for (loc1 in loc3) 
                {
                    if (!(this[loc1] is flash.display.MovieClip && !(this[loc1] == this))) 
                    {
                        continue;
                    }
                    trace(this[loc1]);
                    this[loc1].showMovieClips();
                }
                return;
            }
            return;
        }

        internal static function InspectObjectHelper(arg1:Object, arg2:Boolean, arg3:Boolean, arg4:String="\t"):void
        {
            var aObject:Object;
            var abRecursive:Boolean;
            var abIncludeProperties:Boolean;
            var astrIndent:String="\t";
            var typeDef:XML;
            var member:XML;
            var constMember:XML;
            var id:String;
            var prop:XML;
            var propName:String;
            var propValue:Object;
            var memberName:String;
            var memberValue:Object;
            var constMemberName:String;
            var constMemberValue:Object;
            var value:Object;
            var subid:String;
            var subvalue:Object;

            var loc1:*;
            member = null;
            constMember = null;
            id = null;
            prop = null;
            propName = null;
            propValue = null;
            memberName = null;
            memberValue = null;
            constMemberName = null;
            constMemberValue = null;
            value = null;
            subid = null;
            subvalue = null;
            aObject = arg1;
            abRecursive = arg2;
            abIncludeProperties = arg3;
            astrIndent = arg4;
            typeDef = flash.utils.describeType(aObject);
            if (abIncludeProperties) 
            {
                var loc2:*=0;
                var loc5:*=0;
                var loc6:*=typeDef.accessor;
                var loc4:*=new XMLList("");
                for each (var loc7:* in loc6) 
                {
                    var loc8:*;
                    with (loc8 = loc7) 
                    {
                        if (@access == "readwrite" || @access == "readonly") 
                        {
                            loc4[loc5] = loc7;
                        }
                    }
                }
                var loc3:*=loc4;
                for each (prop in loc3) 
                {
                    propName = prop.@name;
                    propValue = aObject[prop.@name];
                    trace(astrIndent + propName + " = " + propValue);
                    if (!abRecursive) 
                    {
                        continue;
                    }
                    InspectObjectHelper(propValue, abRecursive, abIncludeProperties, astrIndent + "\t");
                }
            }
            loc2 = 0;
            loc3 = typeDef.variable;
            for each (member in loc3) 
            {
                memberName = member.@name;
                memberValue = aObject[memberName];
                trace(astrIndent + memberName + " = " + memberValue);
                if (!abRecursive) 
                {
                    continue;
                }
                InspectObjectHelper(memberValue, true, abIncludeProperties, astrIndent + "\t");
            }
            loc2 = 0;
            loc3 = typeDef.constant;
            for each (constMember in loc3) 
            {
                constMemberName = constMember.@name;
                constMemberValue = aObject[constMemberName];
                trace(astrIndent + constMemberName + " = " + constMemberValue + " --const");
                if (!abRecursive) 
                {
                    continue;
                }
                InspectObjectHelper(constMemberValue, true, abIncludeProperties, astrIndent + "\t");
            }
            loc2 = 0;
            loc3 = aObject;
            for (id in loc3) 
            {
                value = aObject[id];
                trace(astrIndent + id + " = " + value);
                if (abRecursive) 
                {
                    InspectObjectHelper(value, true, abIncludeProperties, astrIndent + "\t");
                    continue;
                }
                loc4 = 0;
                loc5 = value;
                for (subid in loc5) 
                {
                    subvalue = value[subid];
                    trace(astrIndent + "\t" + subid + " = " + subvalue);
                }
            }
            return;
        }

        public static function AddReverseFunctions():*
        {
            var loc1:*;
            flash.display.MovieClip.prototype.PlayReverseCallback = function (arg1:flash.events.Event):*
            {
                if (arg1.currentTarget.currentFrame > 1) 
                {
                    arg1.currentTarget.gotoAndStop((arg1.currentTarget.currentFrame - 1));
                }
                else 
                {
                    arg1.currentTarget.removeEventListener(flash.events.Event.ENTER_FRAME, arg1.currentTarget.PlayReverseCallback);
                }
                return;
            }
            flash.display.MovieClip.prototype.PlayReverse = function ():*
            {
                if (this.currentFrame > 1) 
                {
                    this.gotoAndStop((this.currentFrame - 1));
                    this.addEventListener(flash.events.Event.ENTER_FRAME, this.PlayReverseCallback);
                }
                else 
                {
                    this.gotoAndStop(1);
                }
                return;
            }
            flash.display.MovieClip.prototype.PlayForward = function (arg1:String):*
            {
                delete this.onEnterFrame;
                this.gotoAndPlay(arg1);
                return;
            }
            flash.display.MovieClip.prototype.PlayForward = function (arg1:Number):*
            {
                delete this.onEnterFrame;
                this.gotoAndPlay(arg1);
                return;
            }
            return;
        }

        public static function PlayMenuSound(arg1:String):*
        {
            Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(Shared.GlobalFunc.PLAY_MENU_SOUND, {"soundID":arg1, "soundFormID":0}));
            return;
        }

        public static function PlayMenuSoundWithFormID(arg1:uint):*
        {
            Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(Shared.GlobalFunc.PLAY_MENU_SOUND, {"soundID":"", "soundFormID":arg1}));
            return;
        }

        public static function ShowHUDMessage(arg1:String):*
        {
            Shared.AS3.Data.BSUIDataManager.dispatchEvent(new Shared.AS3.Events.CustomEvent(Shared.GlobalFunc.SHOW_HUD_MESSAGE, {"text":arg1}));
            return;
        }

        public static function updateConditionMeter(arg1:flash.display.MovieClip, arg2:Number, arg3:Number, arg4:Number):void
        {
            var loc1:*=null;
            if (arg3 > 0) 
            {
                arg1.visible = true;
                loc1 = arg1.MeterClip_mc;
                arg1.gotoAndStop(Shared.GlobalFunc.Lerp(arg1.totalFrames, 1, 0, DURABILITY_MAX, arg4, true));
                if (arg2 > 0) 
                {
                    loc1.gotoAndStop(Shared.GlobalFunc.Lerp(loc1.totalFrames, 2, 0, arg3 * 2, arg2, true));
                }
                else 
                {
                    loc1.gotoAndStop(1);
                }
            }
            else 
            {
                arg1.visible = false;
            }
            return;
        }

        public static function updateVoiceIndicator(arg1:flash.display.MovieClip, arg2:Boolean, arg3:Boolean, arg4:Boolean, arg5:Boolean=true, arg6:Boolean=false):void
        {
            if (arg2) 
            {
                if (arg4) 
                {
                    if (arg3) 
                    {
                        arg1.gotoAndStop("hasMicSpeaking");
                    }
                    else 
                    {
                        arg1.gotoAndStop("hasMic");
                    }
                }
                else 
                {
                    arg1.gotoAndStop("hasMicSpeakingChannel");
                }
            }
            else 
            {
                arg1.gotoAndStop("muted");
            }
            if (arg1.Icon_mc) 
            {
                if (arg6) 
                {
                    arg1.Icon_mc.gotoAndStop("enemy");
                }
                else if (arg5) 
                {
                    arg1.Icon_mc.gotoAndStop("ally");
                }
                else 
                {
                    arg1.Icon_mc.gotoAndStop("neutral");
                }
            }
            return;
        }

        public static function quickMultiLineShrinkToFit(arg1:flash.text.TextField, arg2:Number=0, arg3:Number=0):void
        {
            var loc1:*=arg1.getTextFormat();
            if (arg2 == 0) 
            {
                arg2 = loc1.size as Number;
            }
            loc1.size = arg2;
            loc1.leading = arg3;
            arg1.setTextFormat(loc1);
            var loc2:*=false;
            if (getTextfieldSize(arg1) > arg1.height) 
            {
                loc1.size = TEXT_SIZE_VERYSMALL;
                loc1.leading = TEXT_LEADING_MIN;
                arg1.setTextFormat(loc1);
                loc2 = true;
            }
            if (loc2 && getTextfieldSize(arg1) > arg1.height) 
            {
                loc1.size = TEXT_SIZE_MIN;
                loc1.leading = TEXT_LEADING_MIN;
                arg1.setTextFormat(loc1);
            }
            return;
        }

        public static function shrinkMultiLineTextToFit(arg1:flash.text.TextField, arg2:Number=0):void
        {
            var loc1:*=arg1.getTextFormat();
            if (arg2 == 0) 
            {
                arg2 = loc1.size as Number;
            }
            var loc2:*=arg2;
            loc1.size = loc2;
            arg1.setTextFormat(loc1);
            while (getTextfieldSize(arg1) > arg1.height && loc2 > TEXT_SIZE_MIN) 
            {
                --loc2;
                loc1.size = loc2;
                arg1.setTextFormat(loc1);
            }
            return;
        }

        public static function getTextfieldSize(arg1:flash.text.TextField, arg2:Boolean=true):*
        {
            var loc1:*=NaN;
            var loc2:*=0;
            if (arg1.multiline) 
            {
                loc1 = 0;
                loc2 = 0;
                while (loc2 < arg1.numLines) 
                {
                    loc1 = loc1 + (arg2 ? arg1.getLineMetrics(loc2).height : arg1.getLineMetrics(loc2).width);
                    ++loc2;
                }
                return loc1;
            }
            return arg2 ? arg1.textHeight : arg1.textWidth;
        }

        public static function getDisplayObjectSize(arg1:flash.display.DisplayObject, arg2:Boolean=false):*
        {
            if (arg1 is Shared.AS3.BSScrollingList) 
            {
                return (arg1 as Shared.AS3.BSScrollingList).shownItemsHeight;
            }
            if (arg1 is Shared.AS3.BCGridList) 
            {
                return (arg1 as Shared.AS3.BCGridList).displayHeight;
            }
            if (arg1 is flash.display.MovieClip) 
            {
                if (!(arg1["Sizer_mc"] == undefined) && !(arg1["Sizer_mc"] == null)) 
                {
                    return arg2 ? arg1["Sizer_mc"].height : arg1["Sizer_mc"].width;
                }
                if (arg1["textField"] != null) 
                {
                    return getTextfieldSize(arg1["textField"], arg2);
                }
                return arg2 ? arg1.height : arg1.width;
            }
            if (arg1 is flash.text.TextField) 
            {
                return getTextfieldSize(arg1 as flash.text.TextField, arg2);
            }
            throw new Error("GlobalFunc.getDisplayObjectSize: unsupported object type");
        }

        public static function arrangeItems(arg1:Array, arg2:Boolean, arg3:uint=0, arg4:Number=0, arg5:Boolean=false, arg6:Number=0):Number
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=0;
            var loc1:*=arg1.length;
            var loc2:*=0;
            if (loc1 > 0) 
            {
                loc3 = 0;
                loc4 = arg5 ? -1 : 1;
                loc7 = [];
                loc8 = arg1.length;
                loc5 = 0;
                while (loc5 < loc8) 
                {
                    if (loc5 > 0) 
                    {
                        loc2 = loc2 + arg4;
                    }
                    loc7[loc5] = getDisplayObjectSize(arg1[loc5], arg2);
                    loc2 = loc2 + loc7[loc5];
                    ++loc5;
                }
                if (arg3 != ALIGN_CENTER) 
                {
                    if (arg3 == ALIGN_RIGHT) 
                    {
                        loc3 = -loc2 - loc7[0];
                    }
                }
                else 
                {
                    loc3 = loc2 * -0.5;
                }
                if (arg5) 
                {
                    arg1.reverse();
                    loc7.reverse();
                }
                loc3 = loc3 + arg6;
                loc5 = 0;
                while (loc5 < loc8) 
                {
                    if (arg2) 
                    {
                        arg1[loc5].y = loc3;
                    }
                    else 
                    {
                        arg1[loc5].x = loc3;
                    }
                    loc3 = loc3 + (loc7[loc5] + arg4);
                    ++loc5;
                }
            }
            return loc2;
        }

        public static function StringTrim(arg1:String):String
        {
            var loc4:*=null;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.length;
            while (arg1.charAt(loc1) == " " || arg1.charAt(loc1) == "\n" || arg1.charAt(loc1) == "\r" || arg1.charAt(loc1) == "\t") 
            {
                ++loc1;
            }
            loc2 = ((loc4 = arg1.substring(loc1)).length - 1);
            while (loc4.charAt(loc2) == " " || loc4.charAt(loc2) == "\n" || loc4.charAt(loc2) == "\r" || loc4.charAt(loc2) == "\t") 
            {
                --loc2;
            }
            return loc4 = loc4.substring(0, loc2 + 1);
        }

        public static function BSASSERT(arg1:Boolean, arg2:String):void
        {
            var loc1:*=null;
            if (!arg1) 
            {
                loc1 = new Error().getStackTrace();
                flash.system.fscommand("BSASSERT", arg2 + "\nCallstack:\n" + loc1);
            }
            return;
        }

        public static function HasFFEvent(arg1:Object, arg2:String):Boolean
        {
            var aDataObject:Object;
            var asEventString:String;
            var result:Boolean;
            var obj:Object;

            var loc1:*;
            obj = null;
            aDataObject = arg1;
            asEventString = arg2;
            result = false;
            try 
            {
                if (aDataObject.eventArray.length > 0) 
                {
                    loc2 = 0;
                    var loc3:*=aDataObject.eventArray;
                    for each (obj in loc3) 
                    {
                        if (obj.eventName != asEventString) 
                        {
                            continue;
                        }
                        result = true;
                        break;
                    }
                }
            }
            catch (e:Error)
            {
                trace(e.getStackTrace() + " The following Fire Forget Event object could not be parsed:");
                Shared.GlobalFunc.InspectObject(aDataObject, true);
            }
            return result;
        }

        public static function LocalizeFormattedString(arg1:String, ... rest):String
        {
            var loc1:*="";
            var loc2:*;
            (loc2 = new flash.text.TextField()).text = arg1;
            loc1 = loc2.text;
            var loc3:*=0;
            while (loc3 < rest.length) 
            {
                loc2.text = rest[loc3];
                loc1 = loc1.replace("{" + (loc3 + 1) + "}", loc2.text);
                ++loc3;
            }
            return loc1;
        }

        public static function BuildLegendaryStarsGlyphString(arg1:Object):String
        {
            var loc4:*=undefined;
            var loc5:*=null;
            var loc1:*=false;
            var loc2:*=0;
            var loc3:*="";
            if (!(arg1 == null) && arg1.hasOwnProperty("isLegendary")) 
            {
                loc1 = arg1.isLegendary;
                if (loc1 && arg1.hasOwnProperty("numLegendaryStars")) 
                {
                    loc2 = arg1.numLegendaryStars;
                    loc4 = 0;
                    while (loc4 < loc2) 
                    {
                        (loc5 = new flash.text.TextField()).text = "$LegendaryModGlyph";
                        loc3 = loc3 + loc5.text;
                        ++loc4;
                    }
                    loc3 = " " + loc3;
                }
            }
            return loc3;
        }

        
        {
            TEXT_SIZE_VERYSMALL = 16;
            TEXT_SIZE_MIN = 14;
            TEXT_LEADING_MIN = -2;
            STAT_TYPE_INVALID = 20;
            STAT_TYPE_SURVIVAL_SCORE = 29;
        }

        public static const COLOR_RARITY_LEGENDARY:uint=15046481;

        public static const COLOR_RARITY_EPIC:uint=10763770;

        public static const COLOR_RARITY_RARE:uint=4960214;

        public static const COLOR_RARITY_COMMON:uint=9043803;

        public static const FRAME_RARITY_NONE:String="None";

        public static const FRAME_RARITY_COMMON:String="Common";

        public static const FRAME_RARITY_RARE:String="Rare";

        public static const FRAME_RARITY_EPIC:String="Epic";

        public static const FRAME_RARITY_LEGENDARY:String="Legendary";

        public static const VOICE_STATUS_UNAVAILABLE:uint=0;

        public static const VOICE_STATUS_AVAILABLE:uint=1;

        public static const VOICE_STATUS_SPEAKING:uint=2;

        public static const WORLD_TYPE_INVALID:uint=0;

        public static const WORLD_TYPE_NORMAL:uint=1;

        public static const WORLD_TYPE_SURVIVAL:uint=2;

        public static const WORLD_TYPE_NWTEMP:uint=3;

        public static const WORLD_TYPE_NUCLEARWINTER:uint=4;

        public static const WORLD_TYPE_PRIVATE:uint=5;

        public static const QUEST_DISPLAY_TYPE_NONE:uint=0;

        public static const QUEST_DISPLAY_TYPE_MAIN:uint=1;

        public static const QUEST_DISPLAY_TYPE_SIDE:uint=2;

        public static const QUEST_DISPLAY_TYPE_MISC:uint=3;

        public static const QUEST_DISPLAY_TYPE_EVENT:uint=4;

        public static const QUEST_DISPLAY_TYPE_OTHER:uint=5;

        public static const STAT_VALUE_TYPE_INTEGER:uint=0;

        public static const STAT_VALUE_TYPE_TIME:uint=1;

        public static const STAT_VALUE_TYPE_CAPS:uint=2;

        public static const EVENT_USER_CONTEXT_MENU_ACTION:String="UserContextMenu::MenuOptionSelected";

        public static const EVENT_OPEN_USER_CONTEXT_MENU:String="UserContextMenu::UserSelected";

        public static const USER_MENU_CONTEXT_ALL:uint=0;

        public static const USER_MENU_CONTEXT_FRIENDS:uint=1;

        public static const USER_MENU_CONTEXT_TEAM:uint=2;

        public static const USER_MENU_CONTEXT_RECENT:uint=3;

        public static const USER_MENU_CONTEXT_BLOCKED:uint=4;

        public static const USER_MENU_CONTEXT_MAP:uint=5;

        public static const MTX_CURRENCY_ATOMS:uint=0;

        public static const MENU_SOUND_FRIEND_PROMPT_OPEN:String="UIMenuPromptFriendRequestBladeOpen";

        public static const ALIGN_CENTER:uint=1;

        public static const ALIGN_RIGHT:uint=2;

        public static const DURABILITY_MAX:uint=100;

        public static const DIRECTION_NONE:int=0;

        public static const DIRECTION_UP:int=1;

        public static const DIRECTION_RIGHT:int=2;

        public static const DIRECTION_DOWN:int=3;

        public static const DIRECTION_LEFT:int=4;

        public static const REWARD_TYPE_ENUM_ATOMS:int=0;

        public static const REWARD_TYPE_ENUM_PERK_PACKS:int=1;

        public static const REWARD_TYPE_ENUM_PHOTO_FRAMES:int=2;

        public static const REWARD_TYPE_ENUM_EMOTES:int=3;

        public static const REWARD_TYPE_ENUM_ICONS:int=4;

        public static const REWARD_TYPE_ENUM_WEAPON:int=5;

        public static const REWARD_TYPE_ENUM_WEAPON_MOD:int=6;

        public static const REWARD_TYPE_ENUM_ARMOR:int=7;

        public static const REWARD_TYPE_ENUM_ARMOR_MOD:int=8;

        public static const REWARD_TYPE_ENUM_AMMO:int=9;

        public static const REWARD_TYPE_ENUM_PHOTO_POSE:int=10;

        public static const REWARD_TYPE_ENUM_COMPONENTS:int=11;

        public static const REWARD_TYPE_ENUM_EXPERIENCE:int=12;

        public static const REWARD_TYPE_ENUM_BADGES:int=13;

        public static const REWARD_TYPE_ENUM_STIMPAKS:int=14;

        public static const REWARD_TYPE_ENUM_CHEMS:int=15;

        public static const REWARD_TYPE_ENUM_BOOK:int=16;

        public static const REWARD_TYPE_ENUM_CAPS:int=17;

        public static const REWARD_TYPE_ENUM_LEGENDARY_TOKENS:int=18;

        public static const REWARD_TYPE_ENUM_POSSUM_BADGES:int=19;

        public static const REWARD_TYPE_ENUM_TADPOLE_BADGES:int=20;

        public static const REWARD_TYPE_ENUM_CUSTOM_ICON:int=21;

        public static const REWARD_TYPE_ENUM_CAMP:int=22;

        public static const REWARD_TYPE_ENUM_GOLD_BULLION:int=23;

        public static const REWARD_TYPE_ENUM_SCORE:int=24;

        public static const REWARD_TYPE_ENUM_REPAIR_KIT:int=25;

        public static const REWARD_TYPE_ENUM_LUNCH_BOX:int=26;

        public static const REWARD_TYPE_ENUM_PREMIUM:int=27;

        public static const PIPBOY_GREY_OUT_ALPHA:Number=0.5;

        public static const SELECTED_RECT_ALPHA:Number=1;

        public static const DIMMED_ALPHA:Number=0.65;

        public static const IMAGE_FRAME_MAP:Object={"a":1, "b":2, "c":3, "d":4, "e":5, "f":6, "g":7, "h":8, "i":9, "j":10, "k":11, "l":12, "m":13, "n":14, "o":15, "p":16, "q":17, "r":18, "s":19, "t":20, "u":21, "v":22, "w":23, "x":24, "y":25, "z":26, 0:1, 1:2, 2:3, 3:4, 4:5, 5:6, 6:7, 7:8, 8:9, 9:10};

        public static const NUM_DAMAGE_TYPES:uint=6;

        public static const PLAYER_ICON_TEXTURE_BUFFER:String="AvatarTextureBuffer";

        public static const STORE_IMAGE_TEXTURE_BUFFER:String="StoreTextureBuffer";

        public static const MAP_TEXTURE_BUFFER:String="MapMenuTextureBuffer";

        protected static const CLOSE_ENOUGH_EPSILON:Number=0.001;

        public static const MAX_TRUNCATED_TEXT_LENGTH:int=42;

        public static const PLAY_FOCUS_SOUND:String="GlobalFunc::playFocusSound";

        public static const PLAY_MENU_SOUND:String="GlobalFunc::playMenuSound";

        public static const SHOW_HUD_MESSAGE:String="GlobalFunc::showHUDMessage";

        public static const ALIGN_LEFT:uint=0;

        public static const MENU_SOUND_OK:String="UIMenuOK";

        public static const MENU_SOUND_CANCEL:String="UIMenuCancel";

        public static const MENU_SOUND_PREV_NEXT:String="UIMenuPrevNext";

        public static const MENU_SOUND_POPUP:String="UIMenuPopupGeneric";

        public static const MENU_SOUND_FOCUS_CHANGE:String="UIMenuFocus";

        public static const MENU_SOUND_FRIEND_PROMPT_CLOSE:String="UIMenuPromptFriendRequestBladeClose";

        public static const BUTTON_BAR_ALIGN_CENTER:uint=0;

        public static const BUTTON_BAR_ALIGN_LEFT:uint=1;

        public static const BUTTON_BAR_ALIGN_RIGHT:uint=2;

        public static const COLOR_TEXT_BODY:uint=16777163;

        public static const COLOR_TEXT_HEADER:uint=16108379;

        public static const COLOR_TEXT_SELECTED:uint=1580061;

        public static const COLOR_TEXT_FRIEND:uint=COLOR_TEXT_HEADER;

        public static const COLOR_TEXT_ENEMY:uint=16741472;

        public static const COLOR_TEXT_UNAVAILABLE:uint=5661031;

        public static const COLOR_BACKGROUND_BOX:uint=3225915;

        public static const COOR_WARNING:uint=15089200;

        public static const COLOR_WARNING_ACCENT:uint=16151129;

        public static var TEXT_LEADING_MIN:Number=-2;

        public static var TEXT_SIZE_MIN:Number=14;

        public static var TEXT_SIZE_VERYSMALL:Number=16;

        public static var STAT_TYPE_SURVIVAL_SCORE:*=29;

        public static var STAT_TYPE_INVALID:uint=20;
    }
}
