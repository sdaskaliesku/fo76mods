 
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
      
      public static const SHARED_CARD_SPACING:Number = // method body index: 2845 method index: 2845
      12;
      
      public static const SPEAKER_ICON_SPACING:Number = // method body index: 2845 method index: 2845
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
      
      public function set showSharedPerk(aShow:Boolean) : void
      {

         if(aShow != this._showSharedPerk)
         {
            this._showSharedPerk = aShow;
            this._queuePerkAnim = true;
         }
      }
      
      public function set perkID(aNewID:Number) : void
      {

         if(aNewID != this._perkID)
         {
            this._perkID = aNewID;
            this._queuePerkAnim = true;
         }
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {

         var inConvoText_tf:TextField = null;
         var nameFieldMaxPos:Number = NaN;
         this.AccountIcon_mc.mouseEnabled = false;
         this.Background_mc.mouseEnabled = false;
         this.Meter_mc.mouseEnabled = false;
         this.SpeakerIcon_mc.mouseEnabled = false;
         this.LevelText_mc.mouseEnabled = false;
         textField.mouseEnabled = false;
         this._EntityID = aEntryObject.entityId;
         this.Emote_mc.entityID = aEntryObject.entityId;
         textField.text = "";
         if(aEntryObject.isDead)
         {
            this.nameField_mc.textField.textColor = GlobalFunc.COLOR_TEXT_UNAVAILABLE;
            this.TeammateStatus_mc.gotoAndStop("dead");
         }
         else if(aEntryObject.isBleedout)
         {
            this.nameField_mc.textField.textColor = GlobalFunc.COOR_WARNING;
            this.TeammateStatus_mc.gotoAndStop("down");
         }
         else
         {
            this.nameField_mc.textField.textColor = GlobalFunc.COLOR_TEXT_HEADER;
            this.TeammateStatus_mc.gotoAndStop("off");
         }
         this.nameField_mc.textField.text = aEntryObject.name;
         if(aEntryObject.showDetails)
         {
            this.Meter_mc.visible = true;
         }
         else
         {
            this.Meter_mc.visible = false;
         }
         if(aEntryObject.level > 0)
         {
            TextFieldEx.setTextAutoSize(this.LevelText_mc.LevelText_tf,"shrink");
            this.LevelText_mc.LevelText_tf.text = aEntryObject.level;
            this.LevelText_mc.visible = true;
         }
         else
         {
            this.LevelText_mc.LevelText_tf.text = "";
            this.LevelText_mc.visible = false;
         }
         if(aEntryObject.overseerRank >= 0)
         {
            GlobalFunc.SetText(this.OverseerRank_mc.RankText_tf,aEntryObject.overseerRank);
            this.OverseerRank_mc.visible = true;
         }
         else
         {
            this.OverseerRank_mc.RankText_tf.text = "";
            this.OverseerRank_mc.visible = false;
         }
         this.LeaderIcon_mc.visible = aEntryObject.isLeader;
         if(aEntryObject.isLeader && aEntryObject.isInConversation)
         {
            inConvoText_tf = new TextField();
            inConvoText_tf.text = " $$InConversation";
            GlobalFunc.SetText(this.nameField_mc.textField,this.nameField_mc.textField.text + inConvoText_tf.text,true);
         }
         if(aEntryObject.voiceChatStatus != null)
         {
            this.SpeakerIcon_mc.visible = aEntryObject.voiceChatStatus > GlobalFunc.VOICE_STATUS_UNAVAILABLE;
         }
         if(this.SpeakerIcon_mc.visible)
         {
            if(aEntryObject.voiceChatStatus != null)
            {
               GlobalFunc.updateVoiceIndicator(this.SpeakerIcon_mc,aEntryObject.voiceChatStatus > GlobalFunc.VOICE_STATUS_UNAVAILABLE,aEntryObject.voiceChatStatus == GlobalFunc.VOICE_STATUS_SPEAKING,aEntryObject.isSpeakingInSameChannel,true,false);
            }
            nameFieldMaxPos = this.nameField_mc.x + this.nameField_mc.textField.getLineMetrics(0).width;
            if(nameFieldMaxPos + SPEAKER_ICON_SPACING > this._SpeakerIconMinX)
            {
               this.SpeakerIcon_mc.x = nameFieldMaxPos + SPEAKER_ICON_SPACING;
            }
            else
            {
               this.SpeakerIcon_mc.x = this._SpeakerIconMinX;
            }
         }
         this.Meter_mc.gotoAndStop(aEntryObject.healthPercentage / 100 * this._hpMeterFrames);
         this.RadsMeter_mc.gotoAndStop(aEntryObject.radsPercentage / 100 * this._radsMeterFrames);
         this.AccountIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aEntryObject.avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
         this.EventIcon_mc.visible = aEntryObject.isDoingEventQuest;
         if(aEntryObject.showSharedIcon)
         {
            if(aEntryObject.perkCardData != null)
            {
               this.perkID = aEntryObject.perkCardData.perkID;
               this.SharedPerk_mc.Card_mc.Level_tf.text = aEntryObject.perkCardData.pointCost;
               this.SharedPerk_mc.Name_mc.Name_tf.text = aEntryObject.perkCardData.perkName;
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
         this.showSharedPerk = aEntryObject.showSharedIcon;
         if(this._queuePerkAnim)
         {
            this.doPerkAnim();
         }
         if(aEntryObject.hasOwnProperty("isOnServer") && !aEntryObject.isOnServer)
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
         if(aEntryObject.currentBondTime != null && aEntryObject.currentBondTime != PublicTeamsShared.HIDE_BOND_METER && !aEntryObject.isLocalPlayer)
         {
            this.BondMeter_mc.startBondMeter(aEntryObject.currentBondTime);
            this.BondMeter_mc.visible = true;
         }
         else
         {
            this.BondMeter_mc.visible = false;
         }
      }
   }
}
