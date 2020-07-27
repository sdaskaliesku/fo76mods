 
package
{
   import Overlay.PublicTeams.PublicTeamsIcon;
   import Overlay.PublicTeams.PublicTeamsShared;
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class TeammateNameplate extends BSUIComponent
   {
      
      public static const DEAD_STATE_NOTDEAD:uint = // method body index: 3068 method index: 3068
      0;
      
      public static const DEAD_STATE_DBNO:uint = // method body index: 3068 method index: 3068
      1;
      
      public static const DEAD_STATE_DEAD:uint = // method body index: 3068 method index: 3068
      2;
      
      private static const NON_ALLY_MAX_DISTANCE:Number = // method body index: 3068 method index: 3068
      26;
      
      private static const DISTANCE_VISIBLE_THRESHOLD:Number = // method body index: 3068 method index: 3068
      75;
      
      private static const ICON_SPACING:Number = // method body index: 3068 method index: 3068
      5;
      
      private static const NAME_LEVEL_SPACING:Number = // method body index: 3068 method index: 3068
      10;
      
      private static const PT_NAMEPLATE_OFFSET:Number = // method body index: 3068 method index: 3068
      18;
      
      private static const PT_NAMEPLATE_WIDTH_OFFSET:Number = // method body index: 3068 method index: 3068
      100;
      
      private static const PT_NAMEPLATE_MIN_WIDTH:Number = // method body index: 3068 method index: 3068
      218;
      
      private static const PT_NAMEPLATE_DISTANCE_THRESHOLD:Number = // method body index: 3068 method index: 3068
      8;
      
      private static const PT_SMALL_ICON_OFFSET:Number = // method body index: 3068 method index: 3068
      8;
       
      
      public var Name_tf:TextField;
      
      public var Level_tf:TextField;
      
      public var Emote_mc:EmoteWidget;
      
      public var AllyDistance_mc:MovieClip;
      
      public var AlertText_tf:TextField;
      
      public var Arrow_mc:MovieClip;
      
      public var ScreenEdgeArrow_mc:MovieClip;
      
      public var DeadState_mc:MovieClip;
      
      public var NamePlateNameGroup_mc:MovieClip;
      
      public var SpeakerIcon_mc:MovieClip;
      
      public var Bounty_mc:MovieClip;
      
      public var PTNameplate_mc:MovieClip;
      
      public var PTHUDIcon_mc:PublicTeamsIcon;
      
      public var PTHUDIconSmall_mc:PublicTeamsIcon;
      
      private var _EntityID:uint;
      
      private var _Name:String;
      
      private var _Rads:Number;
      
      private var _HPPercent:Number;
      
      private var _PlayerState:String;
      
      private var _WantedState:String;
      
      private var _IsLocalPlayer:Boolean = false;
      
      private var _Distance:Number;
      
      private var _EmoteVisible:Boolean = false;
      
      private var _IsRevengeTarget:Boolean = false;
      
      private var _IsOnScreen:Boolean = true;
      
      private var _IsBeyondRailLimits:Boolean = false;
      
      private var _OffScreenAngle:Number = 0;
      
      private var _IsFriend:Boolean = false;
      
      private var _isFriendInvitePending:Boolean = false;
      
      private var _deadState:uint = 0;
      
      private var _isTeammate:Boolean = false;
      
      private var _isLeader:Boolean = false;
      
      private var _isInConversation:Boolean = false;
      
      private var _isEventGroup:Boolean = false;
      
      private var _isHostile:Boolean = false;
      
      private var _isPvPFlagged:Boolean = false;
      
      private var _isSpeakingInSameChannel:Boolean = false;
      
      private var _voiceChatStatus:uint = 0;
      
      private var _Level:uint = 0;
      
      private var _Bounty:uint = 0;
      
      private var _inLOS:Boolean = true;
      
      private var _isNuclearWinterMode = false;
      
      private var _teamType:uint = 0;
      
      private var _isPublicTeamLeader:Boolean = false;
      
      private var DisplayedDeadState:String = "";
      
      private var DisplayedScreenEdgeArrowState:String = "";
      
      private var DisplayedArrowState:String = "";
      
      private var _deadStateBaseY:Number;
      
      private var _emoteBaseY:Number;
      
      private var _alertBaseY:Number;
      
      public function TeammateNameplate()
      {
         // method body index: 3069 method index: 3069
         super();
         addFrameScript(0,this.frame1);
         Extensions.enabled = true;
         this._EntityID = uint.MAX_VALUE;
         this._Name = "PlayerName";
         this._HPPercent = 1;
         this._Rads = 0;
         this._PlayerState = "hostile";
         this._WantedState = "notWanted";
         this._Distance = 0;
         this.Emote_mc.scale = 1.2;
         this._deadStateBaseY = this.DeadState_mc.y;
         this._emoteBaseY = this.Emote_mc.y;
         this.Name_tf = this.NamePlateNameGroup_mc.Name_tf;
         this.Level_tf = this.NamePlateNameGroup_mc.Level_mc.Level_tf;
         this._alertBaseY = this.AlertText_tf.y;
         TextFieldEx.setTextAutoSize(this.Level_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Bounty_mc.Bounty_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.PTNameplate_mc = this.NamePlateNameGroup_mc.PTNameplate_mc;
         this.PTHUDIcon_mc = this.PTNameplate_mc.PTHUDIcon_mc;
         this.PTHUDIconSmall_mc = this.PTNameplate_mc.PTHUDIconSmall_mc;
         TextFieldEx.setTextAutoSize(this.PTNameplate_mc.PTNameplateLabel_mc.PTLabel_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.__setTab_AlertText_tf_TeammateNameplate_AlertText_tf_wanted__0();
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3072 method index: 3072
         addEventListener(EmoteWidget.EVENT_CLEARED,function():// method body index: 3070 method index: 3070
         *
         {
            // method body index: 3070 method index: 3070
            if(_EmoteVisible)
            {
               _EmoteVisible = false;
               SetIsDirty();
            }
         });
         addEventListener(EmoteWidget.EVENT_ACTIVE,function():// method body index: 3071 method index: 3071
         *
         {
            // method body index: 3071 method index: 3071
            if(!_EmoteVisible)
            {
               _EmoteVisible = true;
               SetIsDirty();
            }
         });
      }
      
      public function set entityID(aVal:uint) : void
      {
         // method body index: 3073 method index: 3073
         this._EntityID = aVal;
         this.Emote_mc.entityID = aVal;
      }
      
      public function get entityID() : uint
      {
         // method body index: 3074 method index: 3074
         return this._EntityID;
      }
      
      public function set playerState(aVal:String) : void
      {
         // method body index: 3075 method index: 3075
         if(aVal != this._PlayerState)
         {
            this._PlayerState = aVal;
            SetIsDirty();
         }
      }
      
      public function set wantedState(aVal:String) : void
      {
         // method body index: 3076 method index: 3076
         if(aVal != this._WantedState)
         {
            this._WantedState = aVal;
            SetIsDirty();
         }
      }
      
      public function set displayName(aVal:String) : void
      {
         // method body index: 3077 method index: 3077
         if(aVal != this._Name)
         {
            this._Name = aVal;
            SetIsDirty();
         }
      }
      
      public function set HPPct(aVal:Number) : void
      {
         // method body index: 3078 method index: 3078
         var newHPPct:Number = Math.min(Math.max(aVal,0),1);
         if(newHPPct != this._HPPercent)
         {
            this._HPPercent = newHPPct;
            SetIsDirty();
         }
      }
      
      public function set rads(aVal:Number) : void
      {
         // method body index: 3079 method index: 3079
         if(aVal != this._Rads)
         {
            this._Rads = aVal;
            SetIsDirty();
         }
      }
      
      public function set distance(aVal:Number) : void
      {
         // method body index: 3080 method index: 3080
         if(aVal != this._Distance)
         {
            this._Distance = aVal;
            SetIsDirty();
         }
      }
      
      public function set isLocalPlayer(aVal:Boolean) : void
      {
         // method body index: 3081 method index: 3081
         if(aVal != this._IsLocalPlayer)
         {
            this._IsLocalPlayer = aVal;
            SetIsDirty();
         }
      }
      
      public function set inLOS(aVal:Boolean) : void
      {
         // method body index: 3082 method index: 3082
         if(aVal != this._inLOS)
         {
            this._inLOS = aVal;
            SetIsDirty();
         }
      }
      
      public function set revengeTarget(aVal:Boolean) : void
      {
         // method body index: 3083 method index: 3083
         if(aVal != this._IsRevengeTarget)
         {
            this._IsRevengeTarget = aVal;
            SetIsDirty();
         }
      }
      
      public function set isOnScreen(aVal:Boolean) : void
      {
         // method body index: 3084 method index: 3084
         if(aVal != this._IsOnScreen)
         {
            this._IsOnScreen = aVal;
            SetIsDirty();
         }
      }
      
      public function set offScreenAngle(aVal:Number) : void
      {
         // method body index: 3085 method index: 3085
         if(aVal != this._OffScreenAngle)
         {
            this._OffScreenAngle = aVal;
            SetIsDirty();
         }
      }
      
      public function set isBeyondRailLimits(aVal:Boolean) : void
      {
         // method body index: 3086 method index: 3086
         if(aVal != this._IsBeyondRailLimits)
         {
            this._IsBeyondRailLimits = aVal;
            SetIsDirty();
         }
      }
      
      public function set isFriend(aVal:Boolean) : void
      {
         // method body index: 3087 method index: 3087
         if(aVal != this._IsFriend)
         {
            this._IsFriend = aVal;
            SetIsDirty();
         }
      }
      
      public function set isFriendInvitePending(aVal:Boolean) : void
      {
         // method body index: 3088 method index: 3088
         if(aVal != this._isFriendInvitePending)
         {
            this._isFriendInvitePending = aVal;
            SetIsDirty();
         }
      }
      
      public function set deadState(aVal:uint) : void
      {
         // method body index: 3089 method index: 3089
         if(aVal != this._deadState)
         {
            this._deadState = aVal;
            SetIsDirty();
         }
      }
      
      public function set isTeammate(aVal:Boolean) : void
      {
         // method body index: 3090 method index: 3090
         if(aVal != this._isTeammate)
         {
            this._isTeammate = aVal;
            SetIsDirty();
         }
      }
      
      public function set isLeader(aVal:Boolean) : void
      {
         // method body index: 3091 method index: 3091
         if(aVal != this._isLeader)
         {
            this._isLeader = aVal;
            SetIsDirty();
         }
      }
      
      public function set isInConversation(aVal:Boolean) : void
      {
         // method body index: 3092 method index: 3092
         if(aVal != this._isInConversation)
         {
            this._isInConversation = aVal;
            SetIsDirty();
         }
      }
      
      public function set isEventGroup(aVal:Boolean) : void
      {
         // method body index: 3093 method index: 3093
         if(aVal != this._isEventGroup)
         {
            this._isEventGroup = aVal;
            SetIsDirty();
         }
      }
      
      public function set isHostile(aVal:Boolean) : void
      {
         // method body index: 3094 method index: 3094
         if(aVal != this._isHostile)
         {
            this._isHostile = aVal;
            SetIsDirty();
         }
      }
      
      public function set isPvPFlagged(aVal:Boolean) : void
      {
         // method body index: 3095 method index: 3095
         if(aVal != this._isPvPFlagged)
         {
            this._isPvPFlagged = aVal;
            SetIsDirty();
         }
      }
      
      public function set isSpeakingInSameChannel(aVal:Boolean) : void
      {
         // method body index: 3096 method index: 3096
         if(aVal != this._isSpeakingInSameChannel)
         {
            this._isSpeakingInSameChannel = aVal;
            SetIsDirty();
         }
      }
      
      public function set voiceChatStatus(aVal:uint) : void
      {
         // method body index: 3097 method index: 3097
         if(aVal != this._voiceChatStatus)
         {
            this._voiceChatStatus = aVal;
            SetIsDirty();
         }
      }
      
      public function set level(aVal:uint) : void
      {
         // method body index: 3098 method index: 3098
         if(aVal != this._Level)
         {
            this._Level = aVal;
            SetIsDirty();
         }
      }
      
      public function set bounty(aVal:uint) : void
      {
         // method body index: 3099 method index: 3099
         if(aVal != this._Bounty)
         {
            this._Bounty = aVal;
            SetIsDirty();
         }
      }
      
      public function set isNuclearWinterMode(aVal:Boolean) : void
      {
         // method body index: 3100 method index: 3100
         if(aVal != this._isNuclearWinterMode)
         {
            this._isNuclearWinterMode = aVal;
            SetIsDirty();
         }
      }
      
      public function set teamType(aVal:uint) : void
      {
         // method body index: 3101 method index: 3101
         if(aVal != this._teamType)
         {
            this._teamType = aVal;
            SetIsDirty();
         }
      }
      
      public function set isPublicTeamLeader(aVal:Boolean) : void
      {
         // method body index: 3102 method index: 3102
         if(aVal != this._isPublicTeamLeader)
         {
            this._isPublicTeamLeader = aVal;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3103 method index: 3103
         var inConvoText_tf:TextField = null;
         var namePointGlobal:Point = null;
         var PTHUDIconSmallPointGlobal:Point = null;
         var newPTHUDIconSmallPoint:Point = null;
         var showArrow:Boolean = false;
         var arrowAlly:Boolean = true;
         var showName:Boolean = false;
         var showDistance:Boolean = false;
         var showScreenEdgeArrow:Boolean = false;
         var nameColor:uint = GlobalFunc.COLOR_TEXT_HEADER;
         switch(this._PlayerState)
         {
            case "eventgroupmate":
               if(this._inLOS && this._Distance < DISTANCE_VISIBLE_THRESHOLD)
               {
                  showName = true;
               }
               else
               {
                  showArrow = true;
               }
               break;
            case "teammate":
               showScreenEdgeArrow = this._IsBeyondRailLimits;
               showName = true;
               if(this._Distance >= DISTANCE_VISIBLE_THRESHOLD)
               {
                  showDistance = true;
               }
               break;
            case "hostile":
            case "hostileGroup":
               arrowAlly = false;
               nameColor = GlobalFunc.COLOR_TEXT_ENEMY;
               if(this._inLOS && (this._Distance <= NON_ALLY_MAX_DISTANCE || this._isNuclearWinterMode))
               {
                  showArrow = true;
               }
               break;
            case "nonhostile":
            case "friend":
            case "potentialHostile":
               showName = this._inLOS && this._Distance <= NON_ALLY_MAX_DISTANCE;
               nameColor = GlobalFunc.COLOR_TEXT_BODY;
         }
         if(this._IsLocalPlayer)
         {
            showName = false;
         }
         var showDeadState:Boolean = false;
         if(this._isTeammate || this._isEventGroup && !this._isHostile)
         {
            if(this._deadState == DEAD_STATE_DBNO || this._deadState == DEAD_STATE_DEAD)
            {
               showDeadState = true;
               if(this._deadState == DEAD_STATE_DBNO)
               {
                  if(this.DisplayedDeadState != "dbno")
                  {
                     this.DisplayedDeadState = "dbno";
                     this.DeadState_mc.gotoAndStop("dbno");
                  }
               }
               else if(this.DisplayedDeadState != "dead")
               {
                  this.DisplayedDeadState = "dead";
                  this.DeadState_mc.gotoAndStop("dead");
               }
            }
         }
         this.DeadState_mc.visible = showDeadState;
         this.Name_tf.textColor = nameColor;
         var alertText:String = "";
         var mostWanted:* = this._WantedState == "mostWanted";
         if(!this._IsLocalPlayer && this._inLOS && this._Distance <= NON_ALLY_MAX_DISTANCE)
         {
            if(this._IsRevengeTarget)
            {
               alertText == "$REVENGE TARGET";
            }
            else if(mostWanted)
            {
               alertText = "$MOSTWANTED";
            }
            else if(this._WantedState == "wanted")
            {
               alertText = "$WANTED";
            }
         }
         GlobalFunc.SetText(this.AlertText_tf,alertText,false);
         if(!this._IsLocalPlayer && this._inLOS && (this._WantedState == "wanted" || this._WantedState == "mostWanted") && this._Distance <= NON_ALLY_MAX_DISTANCE)
         {
            this.Bounty_mc.visible = true;
            this.Bounty_mc.Bounty_tf.text = this._Bounty.toString();
            this.AlertText_tf.y = this.Bounty_mc.y - GlobalFunc.getTextfieldSize(this.AlertText_tf) - ICON_SPACING;
         }
         else
         {
            this.Bounty_mc.visible = false;
            this.AlertText_tf.y = this._alertBaseY;
         }
         this.ScreenEdgeArrow_mc.visible = showScreenEdgeArrow;
         if(this.ScreenEdgeArrow_mc.visible)
         {
            if(this._PlayerState == "teammate")
            {
               if(this.DisplayedScreenEdgeArrowState != "Ally")
               {
                  this.DisplayedScreenEdgeArrowState = "Ally";
                  this.ScreenEdgeArrow_mc.gotoAndStop("Ally");
               }
            }
            else if(this.DisplayedScreenEdgeArrowState != "Neutral")
            {
               this.DisplayedScreenEdgeArrowState = "Neutral";
               this.ScreenEdgeArrow_mc.gotoAndStop("Neutral");
            }
            this.ScreenEdgeArrow_mc.rotation = this._OffScreenAngle;
         }
         this.Arrow_mc.visible = showArrow && !showScreenEdgeArrow && this._PlayerState != "teammate";
         if(this.Arrow_mc.visible)
         {
            if(arrowAlly)
            {
               if(nameColor == GlobalFunc.COLOR_TEXT_BODY)
               {
                  if(this.DisplayedArrowState != "neutral")
                  {
                     this.DisplayedArrowState = "neutral";
                     this.Arrow_mc.gotoAndStop("neutral");
                  }
               }
               else if(this.DisplayedArrowState != "friendly")
               {
                  this.DisplayedArrowState = "friendly";
                  this.Arrow_mc.gotoAndStop("friendly");
               }
            }
            else if(this.DisplayedArrowState != "enemy")
            {
               this.DisplayedArrowState = "enemy";
               this.Arrow_mc.gotoAndStop("enemy");
            }
         }
         this.AllyDistance_mc.visible = showDistance && !this._EmoteVisible && !showScreenEdgeArrow;
         if(this.AllyDistance_mc.visible)
         {
            this.AllyDistance_mc.AllyDistance_tf.text = Math.floor(this._Distance);
         }
         this.NamePlateNameGroup_mc.visible = showName && !showScreenEdgeArrow;
         if(this.NamePlateNameGroup_mc.visible)
         {
            if(this._isLeader && this._isInConversation)
            {
               inConvoText_tf = new TextField();
               inConvoText_tf.text = " $$InConversation";
               GlobalFunc.SetText(this.Name_tf,this._Name + inConvoText_tf.text,false);
            }
            else
            {
               GlobalFunc.SetText(this.Name_tf,this._Name,false);
            }
         }
         if(this.DeadState_mc.visible)
         {
            if(this.NamePlateNameGroup_mc.visible)
            {
               this.DeadState_mc.y = this._deadStateBaseY - this.Name_tf.getLineMetrics(0).height - ICON_SPACING;
            }
            else
            {
               this.DeadState_mc.y = this._deadStateBaseY;
            }
            this.Emote_mc.y = this._emoteBaseY - (this._deadStateBaseY - this.DeadState_mc.y) - this.DeadState_mc.height - ICON_SPACING * 2;
         }
         else
         {
            this.Emote_mc.y = this._emoteBaseY;
         }
         var nameParts:Array = [];
         if(this.Arrow_mc.visible)
         {
            nameParts.push(this.Arrow_mc);
         }
         if(this.NamePlateNameGroup_mc.visible)
         {
            nameParts.push(this.Name_tf);
         }
         this.SpeakerIcon_mc.visible = (this.NamePlateNameGroup_mc.visible || showArrow && (arrowAlly || this._inLOS)) && this._voiceChatStatus != GlobalFunc.VOICE_STATUS_UNAVAILABLE;
         if(this.SpeakerIcon_mc.visible)
         {
            GlobalFunc.updateVoiceIndicator(this.SpeakerIcon_mc,this._voiceChatStatus > GlobalFunc.VOICE_STATUS_UNAVAILABLE,this._voiceChatStatus == GlobalFunc.VOICE_STATUS_SPEAKING,this._isSpeakingInSameChannel,nameColor == GlobalFunc.COLOR_TEXT_HEADER,nameColor == GlobalFunc.COLOR_TEXT_ENEMY);
         }
         if(this._Level > 0)
         {
            this.NamePlateNameGroup_mc.Level_mc.visible = true;
            nameParts.unshift(this.NamePlateNameGroup_mc.Level_mc);
            this.Level_tf.text = this._Level.toString();
            switch(nameColor)
            {
               case GlobalFunc.COLOR_TEXT_ENEMY:
                  this.NamePlateNameGroup_mc.Level_mc.gotoAndStop("red");
                  break;
               case GlobalFunc.COLOR_TEXT_HEADER:
                  this.NamePlateNameGroup_mc.Level_mc.gotoAndStop("yellow");
                  break;
               default:
                  this.NamePlateNameGroup_mc.Level_mc.gotoAndStop("white");
            }
         }
         else
         {
            this.NamePlateNameGroup_mc.Level_mc.visible = false;
         }
         nameParts.push(this.SpeakerIcon_mc);
         GlobalFunc.arrangeItems(nameParts,false,GlobalFunc.ALIGN_CENTER,NAME_LEVEL_SPACING);
         if(this._isPublicTeamLeader && PublicTeamsShared.IsValidPublicTeamType(this._teamType))
         {
            if(this._Distance >= PT_NAMEPLATE_DISTANCE_THRESHOLD)
            {
               this.PTNameplate_mc.PTNameplateBG_mc.gotoAndStop("small");
               this.PTNameplate_mc.PTNameplateLabel_mc.visible = false;
               this.PTHUDIconSmall_mc.setIconType(this._teamType);
               this.PTHUDIconSmall_mc.visible = true;
               this.PTHUDIcon_mc.visible = false;
            }
            else
            {
               this.PTNameplate_mc.PTNameplateBG_mc.gotoAndStop("large");
               this.PTNameplate_mc.PTNameplateLabel_mc.visible = true;
               this.PTHUDIcon_mc.setIconType(this._teamType);
               this.PTHUDIcon_mc.visible = true;
               this.PTHUDIconSmall_mc.visible = false;
            }
            this.PTNameplate_mc.visible = true;
            this.PTNameplate_mc.x = this.NamePlateNameGroup_mc.Level_mc.x - PT_NAMEPLATE_OFFSET;
            if(this.Name_tf.textWidth + PT_NAMEPLATE_WIDTH_OFFSET > PT_NAMEPLATE_MIN_WIDTH)
            {
               this.PTNameplate_mc.PTNameplateBG_mc.width = this.Name_tf.textWidth + PT_NAMEPLATE_WIDTH_OFFSET;
            }
            else
            {
               this.PTNameplate_mc.PTNameplateBG_mc.width = PT_NAMEPLATE_MIN_WIDTH;
            }
            if(this.PTHUDIconSmall_mc.visible)
            {
               namePointGlobal = this.NamePlateNameGroup_mc.localToGlobal(new Point(this.NamePlateNameGroup_mc.Name_tf.x,this.NamePlateNameGroup_mc.Name_tf.y));
               PTHUDIconSmallPointGlobal = this.PTNameplate_mc.localToGlobal(new Point(this.PTHUDIconSmall_mc.x,this.PTHUDIconSmall_mc.y));
               newPTHUDIconSmallPoint = this.PTNameplate_mc.globalToLocal(new Point(namePointGlobal.x + this.NamePlateNameGroup_mc.Name_tf.textWidth + PT_SMALL_ICON_OFFSET,PTHUDIconSmallPointGlobal.y));
               this.PTHUDIconSmall_mc.x = newPTHUDIconSmallPoint.x;
            }
         }
         else
         {
            this.PTNameplate_mc.visible = false;
         }
      }
      
      function __setTab_AlertText_tf_TeammateNameplate_AlertText_tf_wanted__0() : *
      {
         // method body index: 3104 method index: 3104
         this.AlertText_tf.tabIndex = 11;
      }
      
      function frame1() : *
      {
         // method body index: 3105 method index: 3105
         stop();
      }
   }
}
