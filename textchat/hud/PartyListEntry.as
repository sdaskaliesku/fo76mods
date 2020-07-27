 
package
{
   import Overlay.PublicTeams.PublicTeamsBondMeter;
   import Overlay.PublicTeams.PublicTeamsShared;
   import Shared.AS3.BSScrollingListFadeEntry;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class PartyListEntry extends BSScrollingListFadeEntry
   {
      
      public static const SHARED_CARD_SPACING:Number = // method body index: 2783 method index: 2783
      12;
      
      public static const SPEAKER_ICON_SPACING:Number = // method body index: 2783 method index: 2783
      10;
       
      
      public var AccountIcon_mc:MovieClip;
      
      public var Background_mc:MovieClip;
      
      public var Meter_mc:MovieClip;
      
      public var RadsMeter_mc:MovieClip;
      
      public var MeterBG_mc:MovieClip;
      
      public var SpeakerIcon_mc:MovieClip;
      
      public var nameField_mc:MovieClip;
      
      public var LevelText_mc:MovieClip;
      
      public var OverseerRank_mc:MovieClip;
      
      public var LeaderIcon_mc:MovieClip;
      
      public var Emote_mc:EmoteWidget;
      
      public var EventIcon_mc:MovieClip;
      
      public var SharedPerk_mc:MovieClip;
      
      public var TeammateStatus_mc:MovieClip;
      
      public var BondMeter_mc:PublicTeamsBondMeter;
      
      private var _hpMeterFrames:int = 100;
      
      private var _radsMeterFrames:int = 100;
      
      private var _EntityID:uint;
      
      private var _showSharedPerk:Boolean = false;
      
      private var _lastShowedPerk:Boolean = false;
      
      private var _perkID:Number;
      
      private var _queuePerkAnim:Boolean = false;
      
      private var _nameBaseX:Number = 0;
      
      private var _SpeakerIconMinX:Number;
      
      public function PartyListEntry()
      {

         super();
         if(!this.AccountIcon_mc)
         {
            trace("AccountIcon_mc doesn\'t exist");
         }
         if(!this.Background_mc)
         {
            trace("Background_mc doesn\'t exist");
         }
         if(!this.Meter_mc)
         {
            trace("Meter_mc doesn\'t exist");
         }
         if(!this.RadsMeter_mc)
         {
            trace("RadsMeter_mc doesn\'t exist");
         }
         if(!this.SpeakerIcon_mc)
         {
            trace("SpeakerIcon_mc doesn\'t exist");
         }
         if(!this.nameField_mc)
         {
            trace("nameField_mc doesn\'t exist");
         }
         if(!this.LevelText_mc)
         {
            trace("LevelText_mc doesn\'t exist");
         }
         if(!this.LeaderIcon_mc)
         {
            trace("LeaderIcon_mc doesn\'t exist");
         }
         if(!this.BondMeter_mc)
         {
            trace("BondMeter_mc doesn\'t exist");
         }
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(textField,"shrink");
         border = Sizer_mc;
         _HasDynamicHeight = false;
         ORIG_BORDER_WIDTH = Sizer_mc.width;
         ORIG_BORDER_HEIGHT = Sizer_mc.height;
         this._hpMeterFrames = this.Meter_mc.totalFrames;
         this._radsMeterFrames = this.RadsMeter_mc.totalFrames;
         this._EntityID = uint.MAX_VALUE;
         this.Emote_mc.scale = 0.5;
         this.Emote_mc.displayMax = 1;
         this._nameBaseX = this.nameField_mc.x;
         this.nameField_mc.textField.textColor = GlobalFunc.COLOR_TEXT_HEADER;
         this.AccountIcon_mc.clipWidth = this.AccountIcon_mc.width * (1 / this.AccountIcon_mc.scaleX);
         this.AccountIcon_mc.clipHeight = this.AccountIcon_mc.height * (1 / this.AccountIcon_mc.scaleY);
         this._SpeakerIconMinX = this.SpeakerIcon_mc.x;
      }
      
      private function doPerkAnim() : void
      {

         if(this._showSharedPerk)
         {
            this.SharedPerk_mc.gotoAndPlay("rollOn");
         }
         else if(this._lastShowedPerk)
         {
            this.SharedPerk_mc.gotoAndPlay("rollOff");
         }
         else
         {
            this.SharedPerk_mc.gotoAndStop("off");
         }
         this._lastShowedPerk = this._showSharedPerk;
         this._queuePerkAnim = false;
      }
      
      public function set showSharedPerk(param1:Boolean) : void
      {

         if(param1 != this._showSharedPerk)
         {
            this._showSharedPerk = param1;
            this._queuePerkAnim = true;
         }
      }
      
      public function set perkID(param1:Number) : void
      {

         if(param1 != this._perkID)
         {
            this._perkID = param1;
            this._queuePerkAnim = true;
         }
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {

         var _loc3_:TextField = null;
         var _loc4_:Number = NaN;
         this.AccountIcon_mc.mouseEnabled = false;
         this.Background_mc.mouseEnabled = false;
         this.Meter_mc.mouseEnabled = false;
         this.SpeakerIcon_mc.mouseEnabled = false;
         this.LevelText_mc.mouseEnabled = false;
         textField.mouseEnabled = false;
         this._EntityID = param1.entityId;
         this.Emote_mc.entityID = param1.entityId;
         textField.text = "";
         if(param1.isDead)
         {
            this.nameField_mc.textField.textColor = GlobalFunc.COLOR_TEXT_UNAVAILABLE;
            this.TeammateStatus_mc.gotoAndStop("dead");
         }
         else if(param1.isBleedout)
         {
            this.nameField_mc.textField.textColor = GlobalFunc.COOR_WARNING;
            this.TeammateStatus_mc.gotoAndStop("down");
         }
         else
         {
            this.nameField_mc.textField.textColor = GlobalFunc.COLOR_TEXT_HEADER;
            this.TeammateStatus_mc.gotoAndStop("off");
         }
         this.nameField_mc.textField.text = param1.name;
         if(param1.showDetails)
         {
            this.Meter_mc.visible = true;
         }
         else
         {
            this.Meter_mc.visible = false;
         }
         if(param1.level > 0)
         {
            TextFieldEx.setTextAutoSize(this.LevelText_mc.LevelText_tf,"shrink");
            this.LevelText_mc.LevelText_tf.text = param1.level;
            this.LevelText_mc.visible = true;
         }
         else
         {
            this.LevelText_mc.LevelText_tf.text = "";
            this.LevelText_mc.visible = false;
         }
         if(param1.overseerRank >= 0)
         {
            GlobalFunc.SetText(this.OverseerRank_mc.RankText_tf,param1.overseerRank);
            this.OverseerRank_mc.visible = true;
         }
         else
         {
            this.OverseerRank_mc.RankText_tf.text = "";
            this.OverseerRank_mc.visible = false;
         }
         this.LeaderIcon_mc.visible = param1.isLeader;
         if(param1.isLeader && param1.isInConversation)
         {
            _loc3_ = new TextField();
            _loc3_.text = " $$InConversation";
            GlobalFunc.SetText(this.nameField_mc.textField,this.nameField_mc.textField.text + _loc3_.text,true);
         }
         if(param1.voiceChatStatus != null)
         {
            this.SpeakerIcon_mc.visible = param1.voiceChatStatus > GlobalFunc.VOICE_STATUS_UNAVAILABLE;
         }
         if(this.SpeakerIcon_mc.visible)
         {
            if(param1.voiceChatStatus != null)
            {
               GlobalFunc.updateVoiceIndicator(this.SpeakerIcon_mc,param1.voiceChatStatus > GlobalFunc.VOICE_STATUS_UNAVAILABLE,param1.voiceChatStatus == GlobalFunc.VOICE_STATUS_SPEAKING,param1.isSpeakingInSameChannel,true,false);
            }
            _loc4_ = this.nameField_mc.x + this.nameField_mc.textField.getLineMetrics(0).width;
            if(_loc4_ + SPEAKER_ICON_SPACING > this._SpeakerIconMinX)
            {
               this.SpeakerIcon_mc.x = _loc4_ + SPEAKER_ICON_SPACING;
            }
            else
            {
               this.SpeakerIcon_mc.x = this._SpeakerIconMinX;
            }
         }
         this.Meter_mc.gotoAndStop(param1.healthPercentage / 100 * this._hpMeterFrames);
         this.RadsMeter_mc.gotoAndStop(param1.radsPercentage / 100 * this._radsMeterFrames);
         this.AccountIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
         this.EventIcon_mc.visible = param1.isDoingEventQuest;
         if(param1.showSharedIcon)
         {
            if(param1.perkCardData != null)
            {
               this.perkID = param1.perkCardData.perkID;
               this.SharedPerk_mc.Card_mc.Level_tf.text = param1.perkCardData.pointCost;
               this.SharedPerk_mc.Name_mc.Name_tf.text = param1.perkCardData.perkName;
            }
            if(this.SpeakerIcon_mc.visible)
            {
               this.SharedPerk_mc.x = this.SpeakerIcon_mc.x + this.SpeakerIcon_mc.width + SHARED_CARD_SPACING;
            }
            else
            {
               this.SharedPerk_mc.x = this.nameField_mc.x + this.nameField_mc.textField.getLineMetrics(0).width + SHARED_CARD_SPACING;
            }
         }
         this.showSharedPerk = param1.showSharedIcon;
         if(this._queuePerkAnim)
         {
            this.doPerkAnim();
         }
         if(param1.hasOwnProperty("isOnServer") && !param1.isOnServer)
         {
            this.nameField_mc.x = this._nameBaseX - this.LevelText_mc.width;
            this.Meter_mc.visible = false;
            this.MeterBG_mc.visible = false;
            this.RadsMeter_mc.visible = false;
            this.LevelText_mc.visible = false;
         }
         else
         {
            this.nameField_mc.x = this._nameBaseX;
            this.Meter_mc.visible = true;
            this.MeterBG_mc.visible = true;
            this.RadsMeter_mc.visible = true;
         }
         if(param1.currentBondTime != null && param1.currentBondTime != PublicTeamsShared.HIDE_BOND_METER && !param1.isLocalPlayer)
         {
            this.BondMeter_mc.startBondMeter(param1.currentBondTime);
            this.BondMeter_mc.visible = true;
         }
         else
         {
            this.BondMeter_mc.visible = false;
         }
      }
   }
}
