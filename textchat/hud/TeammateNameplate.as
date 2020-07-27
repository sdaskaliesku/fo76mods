 
package
{
   import Overlay.PublicTeams.PublicTeamsIcon;
   import Overlay.PublicTeams.PublicTeamsShared;
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class TeammateNameplate extends BSUIComponent
   {
      
      public static const DEAD_STATE_NOTDEAD:uint = // method body index: 3019 method index: 3019
      0;
      
      public static const DEAD_STATE_DBNO:uint = // method body index: 3019 method index: 3019
      1;
      
      public static const DEAD_STATE_DEAD:uint = // method body index: 3019 method index: 3019
      2;
      
      private static const NON_ALLY_MAX_DISTANCE:Number = // method body index: 3019 method index: 3019
      26;
      
      private static const DISTANCE_VISIBLE_THRESHOLD:Number = // method body index: 3019 method index: 3019
      75;
      
      private static const ICON_SPACING:Number = // method body index: 3019 method index: 3019
      5;
      
      private static const NAME_LEVEL_SPACING:Number = // method body index: 3019 method index: 3019
      10;
      
      private static const PT_NAMEPLATE_OFFSET:Number = // method body index: 3019 method index: 3019
      18;
      
      private static const PT_NAMEPLATE_WIDTH_OFFSET:Number = // method body index: 3019 method index: 3019
      100;
      
      private static const PT_NAMEPLATE_MIN_WIDTH:Number = // method body index: 3019 method index: 3019
      218;
      
      private static const PT_NAMEPLATE_DISTANCE_THRESHOLD:Number = // method body index: 3019 method index: 3019
      8;
      
      private static const PT_SMALL_ICON_OFFSET:Number = // method body index: 3019 method index: 3019
      8;
       
      
      private var message:TextField;
      
      public var Name_tf:TextField;
      
      public var Distance_tf:TextField;
      
      public var Clan_tf:TextField;
      
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
      
      public var bmodUser = false;
      
      public var effect:GlowFilter;
      
      public function TeammateNameplate()
      {

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
         this.Distance_tf = new TextField();
         this.Clan_tf = new TextField();
         this.Clan_tf.autoSize = TextFieldAutoSize.LEFT;
         this.Clan_tf.wordWrap = false;
         this.Clan_tf.multiline = false;
         this.Clan_tf.visible = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Roboto Condensed";
         _loc1_.size = 16;
         _loc1_.bold = true;
         _loc1_.color = 13545954;
         this.Clan_tf.defaultTextFormat = _loc1_;
         this.Clan_tf.setTextFormat(_loc1_);
         this.Clan_tf.mouseEnabled = false;
         this.Clan_tf.y = -20;
         this.Clan_tf.x = 0;
         this.effect = new GlowFilter(0);
         this.Clan_tf.filters = [this.effect];
         this.Name_tf.parent.addChild(this.Clan_tf);
      }
      
      override public function onAddedToStage() : void
      {

         addEventListener(EmoteWidget.EVENT_CLEARED,function():// method body index: 3021 method index: 3021
         *
         {

            if(_EmoteVisible)
            {
               _EmoteVisible = false;
               SetIsDirty();
            }
         });
         addEventListener(EmoteWidget.EVENT_ACTIVE,function():// method body index: 3022 method index: 3022
         *
         {

            if(!_EmoteVisible)
            {
               _EmoteVisible = true;
               SetIsDirty();
            }
         });
      }
      
      public function set entityID(param1:uint) : void
      {

         this._EntityID = param1;
         this.Emote_mc.entityID = param1;
      }
      
      public function get entityID() : uint
      {

         return this._EntityID;
      }
      
      public function set playerState(param1:String) : void
      {

         if(param1 != this._PlayerState)
         {
            this._PlayerState = param1;
            SetIsDirty();
         }
      }
      
      public function set wantedState(param1:String) : void
      {

         if(param1 != this._WantedState)
         {
            this._WantedState = param1;
            SetIsDirty();
         }
      }
      
      public function set displayName(param1:String) : void
      {

         if(param1 != this._Name)
         {
            this._Name = param1;
            SetIsDirty();
         }
      }
      
      public function set HPPct(param1:Number) : void
      {

         var _loc2_:Number = Math.min(Math.max(param1,0),1);
         if(_loc2_ != this._HPPercent)
         {
            this._HPPercent = _loc2_;
            SetIsDirty();
         }
      }
      
      public function set rads(param1:Number) : void
      {

         if(param1 != this._Rads)
         {
            this._Rads = param1;
            SetIsDirty();
         }
      }
      
      public function set distance(param1:Number) : void
      {

         if(param1 != this._Distance)
         {
            this._Distance = param1;
            SetIsDirty();
         }
      }
      
      public function set isLocalPlayer(param1:Boolean) : void
      {

         if(param1 != this._IsLocalPlayer)
         {
            this._IsLocalPlayer = param1;
            SetIsDirty();
         }
      }
      
      public function set inLOS(param1:Boolean) : void
      {

         if(param1 != this._inLOS)
         {
            this._inLOS = param1;
            SetIsDirty();
         }
      }
      
      public function set revengeTarget(param1:Boolean) : void
      {

         if(param1 != this._IsRevengeTarget)
         {
            this._IsRevengeTarget = param1;
            SetIsDirty();
         }
      }
      
      public function set isOnScreen(param1:Boolean) : void
      {

         if(param1 != this._IsOnScreen)
         {
            this._IsOnScreen = param1;
            SetIsDirty();
         }
      }
      
      public function set offScreenAngle(param1:Number) : void
      {

         if(param1 != this._OffScreenAngle)
         {
            this._OffScreenAngle = param1;
            SetIsDirty();
         }
      }
      
      public function set isBeyondRailLimits(param1:Boolean) : void
      {

         if(param1 != this._IsBeyondRailLimits)
         {
            this._IsBeyondRailLimits = param1;
            SetIsDirty();
         }
      }
      
      public function set isFriend(param1:Boolean) : void
      {

         if(param1 != this._IsFriend)
         {
            this._IsFriend = param1;
            SetIsDirty();
         }
      }
      
      public function set isFriendInvitePending(param1:Boolean) : void
      {

         if(param1 != this._isFriendInvitePending)
         {
            this._isFriendInvitePending = param1;
            SetIsDirty();
         }
      }
      
      public function set deadState(param1:uint) : void
      {

         if(param1 != this._deadState)
         {
            this._deadState = param1;
            SetIsDirty();
         }
      }
      
      public function set isTeammate(param1:Boolean) : void
      {

         if(param1 != this._isTeammate)
         {
            this._isTeammate = param1;
            SetIsDirty();
         }
      }
      
      public function set isLeader(param1:Boolean) : void
      {

         if(param1 != this._isLeader)
         {
            this._isLeader = param1;
            SetIsDirty();
         }
      }
      
      public function set isInConversation(param1:Boolean) : void
      {

         if(param1 != this._isInConversation)
         {
            this._isInConversation = param1;
            SetIsDirty();
         }
      }
      
      public function set isEventGroup(param1:Boolean) : void
      {

         if(param1 != this._isEventGroup)
         {
            this._isEventGroup = param1;
            SetIsDirty();
         }
      }
      
      public function set isHostile(param1:Boolean) : void
      {

         if(param1 != this._isHostile)
         {
            this._isHostile = param1;
            SetIsDirty();
         }
      }
      
      public function set isPvPFlagged(param1:Boolean) : void
      {

         if(param1 != this._isPvPFlagged)
         {
            this._isPvPFlagged = param1;
            SetIsDirty();
         }
      }
      
      public function set isSpeakingInSameChannel(param1:Boolean) : void
      {

         if(param1 != this._isSpeakingInSameChannel)
         {
            this._isSpeakingInSameChannel = param1;
            SetIsDirty();
         }
      }
      
      public function set voiceChatStatus(param1:uint) : void
      {

         if(param1 != this._voiceChatStatus)
         {
            this._voiceChatStatus = param1;
            SetIsDirty();
         }
      }
      
      public function set level(param1:uint) : void
      {

         if(param1 != this._Level)
         {
            this._Level = param1;
            SetIsDirty();
         }
      }
      
      public function set bounty(param1:uint) : void
      {

         if(param1 != this._Bounty)
         {
            this._Bounty = param1;
            SetIsDirty();
         }
      }
      
      public function set isNuclearWinterMode(param1:Boolean) : void
      {

         if(param1 != this._isNuclearWinterMode)
         {
            this._isNuclearWinterMode = param1;
            SetIsDirty();
         }
      }
      
      public function set teamType(param1:uint) : void
      {

         if(param1 != this._teamType)
         {
            this._teamType = param1;
            SetIsDirty();
         }
      }
      
      public function set isPublicTeamLeader(param1:Boolean) : void
      {

         if(param1 != this._isPublicTeamLeader)
         {
            this._isPublicTeamLeader = param1;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {

         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc1_:TextField = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = true;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:uint = GlobalFunc.COLOR_TEXT_HEADER;
         switch(this._PlayerState)
         {
            case "eventgroupmate":
               if(this._inLOS && this._Distance < DISTANCE_VISIBLE_THRESHOLD)
               {
                  _loc7_ = true;
               }
               else
               {
                  _loc5_ = true;
               }
               break;
            case "teammate":
               _loc9_ = this._IsBeyondRailLimits;
               _loc7_ = true;
               if(this._Distance >= DISTANCE_VISIBLE_THRESHOLD)
               {
                  _loc8_ = true;
               }
               break;
            case "hostile":
            case "hostileGroup":
               _loc6_ = false;
               _loc10_ = GlobalFunc.COLOR_TEXT_ENEMY;
               if(this._inLOS && (this._Distance <= NON_ALLY_MAX_DISTANCE || this._isNuclearWinterMode))
               {
                  _loc5_ = true;
               }
               break;
            case "nonhostile":
            case "friend":
            case "potentialHostile":
               _loc7_ = this._inLOS && this._Distance <= NON_ALLY_MAX_DISTANCE;
               _loc10_ = GlobalFunc.COLOR_TEXT_BODY;
         }
         this.Name_tf.text = this._Name.toString();
         this.Distance_tf.text = this._Distance.toString();
         if(this._IsLocalPlayer)
         {
            _loc7_ = false;
         }
         var _loc11_:Boolean = false;
         if(this._isTeammate || this._isEventGroup && !this._isHostile)
         {
            if(this._deadState == DEAD_STATE_DBNO || this._deadState == DEAD_STATE_DEAD)
            {
               _loc11_ = true;
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
         this.DeadState_mc.visible = _loc11_;
         this.Name_tf.textColor = _loc10_;
         var _loc12_:String = "";
         if(this.bmodUser == false)
         {
            this.Name_tf.textColor = _loc10_;
         }
         if(HUDMenu.modArray.indexOf(this.Name_tf.text.toLowerCase()) >= 0)
         {
            this.Name_tf.textColor = 1474479;
            this.bmodUser = true;
            _loc15_ = HUDMenu.modArray.indexOf(this.Name_tf.text.toLowerCase()) + 1;
            _loc16_ = HUDMenu.modArray[_loc15_];
            if(_loc16_ != "jhqtvggmgcyhrdrs")
            {
               this.Clan_tf.text = _loc16_;
               this.Clan_tf.x = this.Name_tf.x;
            }
            else
            {
               this.Clan_tf.text = "";
            }
         }
         else
         {
            this.Clan_tf.text = "";
            this.bmodUser = false;
         }
         this.Clan_tf.visible = !this._IsLocalPlayer && this._inLOS && this._Distance <= NON_ALLY_MAX_DISTANCE && this._PlayerState != "hostile" && this._PlayerState != "hostileGroup";
         var _loc13_:* = this._WantedState == "mostWanted";
         if(!this._IsLocalPlayer && this._inLOS && this._Distance <= NON_ALLY_MAX_DISTANCE)
         {
            if(this._IsRevengeTarget)
            {
               _loc12_ = "$REVENGE TARGET";
            }
            else if(_loc13_)
            {
               _loc12_ = "$MOSTWANTED";
            }
            else if(this._WantedState == "wanted")
            {
               _loc12_ = "$WANTED";
            }
         }
         GlobalFunc.SetText(this.AlertText_tf,_loc12_,false);
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
         this.ScreenEdgeArrow_mc.visible = _loc9_;
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
         this.Arrow_mc.visible = _loc5_ && !_loc9_ && this._PlayerState != "teammate";
         if(this.Arrow_mc.visible)
         {
            if(_loc6_)
            {
               if(_loc10_ == GlobalFunc.COLOR_TEXT_BODY)
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
         this.AllyDistance_mc.visible = _loc8_ && !this._EmoteVisible && !_loc9_;
         if(this.AllyDistance_mc.visible)
         {
            this.AllyDistance_mc.AllyDistance_tf.text = Math.floor(this._Distance);
         }
         this.NamePlateNameGroup_mc.visible = _loc7_ && !_loc9_;
         if(this.NamePlateNameGroup_mc.visible)
         {
            if(this._isLeader && this._isInConversation)
            {
               _loc1_ = new TextField();
               _loc1_.text = " $$InConversation";
               GlobalFunc.SetText(this.Name_tf,this._Name + _loc1_.text,false);
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
         var _loc14_:Array = [];
         if(this.Arrow_mc.visible)
         {
            _loc14_.push(this.Arrow_mc);
         }
         if(this.NamePlateNameGroup_mc.visible)
         {
            _loc14_.push(this.Name_tf);
         }
         this.SpeakerIcon_mc.visible = (this.NamePlateNameGroup_mc.visible || _loc5_ && (_loc6_ || this._inLOS)) && this._voiceChatStatus != GlobalFunc.VOICE_STATUS_UNAVAILABLE;
         if(this.SpeakerIcon_mc.visible)
         {
            GlobalFunc.updateVoiceIndicator(this.SpeakerIcon_mc,this._voiceChatStatus > GlobalFunc.VOICE_STATUS_UNAVAILABLE,this._voiceChatStatus == GlobalFunc.VOICE_STATUS_SPEAKING,this._isSpeakingInSameChannel,_loc10_ == GlobalFunc.COLOR_TEXT_HEADER,_loc10_ == GlobalFunc.COLOR_TEXT_ENEMY);
         }
         if(this._Level > 0)
         {
            this.NamePlateNameGroup_mc.Level_mc.visible = true;
            _loc14_.unshift(this.NamePlateNameGroup_mc.Level_mc);
            this.Level_tf.text = this._Level.toString();
            switch(_loc10_)
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
         _loc14_.push(this.SpeakerIcon_mc);
         GlobalFunc.arrangeItems(_loc14_,false,GlobalFunc.ALIGN_CENTER,NAME_LEVEL_SPACING);
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
               this.PTNameplate_mc.PTNameplateBG_mc.gotoAndStop("small");
               this.PTNameplate_mc.PTNameplateLabel_mc.visible = false;
               this.PTHUDIconSmall_mc.setIconType(this._teamType);
               this.PTHUDIconSmall_mc.visible = true;
               this.PTHUDIcon_mc.visible = false;
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
               _loc2_ = this.NamePlateNameGroup_mc.localToGlobal(new Point(this.NamePlateNameGroup_mc.Name_tf.x,this.NamePlateNameGroup_mc.Name_tf.y));
               _loc3_ = this.PTNameplate_mc.localToGlobal(new Point(this.PTHUDIconSmall_mc.x,this.PTHUDIconSmall_mc.y));
               _loc4_ = this.PTNameplate_mc.globalToLocal(new Point(_loc2_.x + this.NamePlateNameGroup_mc.Name_tf.textWidth + PT_SMALL_ICON_OFFSET,_loc3_.y));
               this.PTHUDIconSmall_mc.x = _loc4_.x;
            }
         }
         else
         {
            this.PTNameplate_mc.visible = false;
         }
      }
      
      function __setTab_AlertText_tf_TeammateNameplate_AlertText_tf_wanted__0() : *
      {

         this.AlertText_tf.tabIndex = 11;
      }
      
      function frame1() : *
      {

         stop();
      }
   }
}
