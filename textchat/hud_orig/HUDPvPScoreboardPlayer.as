 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDPvPScoreboardPlayer extends MovieClip
   {
       
      
      public var capsRisk_mc:MovieClip;
      
      public var capsReward_mc:MovieClip;
      
      public var capsLost_mc:MovieClip;
      
      public var capsGained_mc:MovieClip;
      
      public var capsBonus_mc:MovieClip;
      
      public var capsBonusAvailable_mc:MovieClip;
      
      public var pvpVsText_mc:MovieClip;
      
      public var pvpIdentifier_mc:MovieClip;
      
      public var pvpPlayerIcon_mc:MovieClip;
      
      public var pvpPlayerName_mc:MovieClip;
      
      public var pvpPlayerLevelDisplay_mc:MovieClip;
      
      public var pvpPlayerScoreText_mc:MovieClip;
      
      public var pvpEnemyScoreText_mc:MovieClip;
      
      public var pvpStrokeColor_mc:MovieClip;
      
      public var PvPVaultBoys_mc:MovieClip;
      
      private var m_Data:Object;
      
      public function HUDPvPScoreboardPlayer()
      {

         super();
         TextFieldEx.setTextAutoSize(this.pvpPlayerName_mc.pvpPlayerName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         var avatarClip:ImageFixture = this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc as ImageFixture;
         avatarClip.clipWidth = avatarClip.width * (1 / avatarClip.scaleX);
         avatarClip.clipHeight = avatarClip.height * (1 / avatarClip.scaleY);
      }
      
      public function get data() : Object
      {

         return this.m_Data;
      }
      
      public function set data(aData:Object) : void
      {

         this.m_Data = aData;
         var selfColorFrame:String = "gold";
         var scoreColorFrame:String = "gold";
         var markerLabel:String = "";
         this.capsGained_mc.alpha = 0;
         this.capsLost_mc.alpha = 0;
         this.capsRisk_mc.alpha = 0;
         this.capsReward_mc.alpha = 0;
         this.capsBonus_mc.alpha = 0;
         this.capsBonusAvailable_mc.alpha = 0;
         var actingMemberIndex:Number = 0;
         var deadMemberIndex:Number = 0;
         if(this.m_Data.actingMemberIndex)
         {
            actingMemberIndex = this.m_Data.actingMemberIndex;
         }
         if(this.m_Data.deadMemberIndex)
         {
            deadMemberIndex = this.m_Data.deadMemberIndex;
         }
         switch(aData.type)
         {
            case HUDPvPScoreboard.TYPE_MURDERED:
               markerLabel = "$$MURDEREDBY";
               if(!this.m_Data.localPlayerInolved)
               {
                  markerLabel = this.m_Data.team[actingMemberIndex].playerName.toUpperCase() + " " + markerLabel;
               }
               selfColorFrame = "red";
               this.capsBonusAvailable_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("murdered");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[actingMemberIndex].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = aData.enemies[actingMemberIndex].playerName;
               break;
            case HUDPvPScoreboard.TYPE_TEAMDEATH:
            case HUDPvPScoreboard.TYPE_DEATH:
               markerLabel = "$$KILLEDBYHEADER";
               if(!this.m_Data.localPlayerInolved)
               {
                  markerLabel = this.m_Data.team[deadMemberIndex].playerName.toUpperCase() + " " + markerLabel;
               }
               selfColorFrame = "red";
               this.capsLost_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("death");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[actingMemberIndex].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = aData.enemies[actingMemberIndex].playerName;
               break;
            case HUDPvPScoreboard.TYPE_UNDERATTACK:
               markerLabel = "$$UNDERATTACK";
               if(!this.m_Data.localPlayerInolved)
               {
                  markerLabel = this.m_Data.team[deadMemberIndex].playerName.toUpperCase() + " " + markerLabel;
               }
               selfColorFrame = "gold";
               this.capsReward_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("underattack");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[actingMemberIndex].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = aData.enemies[actingMemberIndex].playerName;
               break;
            case HUDPvPScoreboard.TYPE_ATTACKINGPLAYER:
               markerLabel = "$$ATTACKINGPLAYER";
               if(!this.m_Data.localPlayerInolved)
               {
                  markerLabel = this.m_Data.team[actingMemberIndex].playerName.toUpperCase() + " " + markerLabel;
               }
               selfColorFrame = "gold";
               this.capsReward_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("attackingplayer");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[deadMemberIndex].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = aData.enemies[deadMemberIndex].playerName;
               break;
            case HUDPvPScoreboard.TYPE_TEAMKILL:
            case HUDPvPScoreboard.TYPE_KILL:
               markerLabel = "$$KILLEDHEADER";
               if(!this.m_Data.localPlayerInolved)
               {
                  markerLabel = this.m_Data.team[actingMemberIndex].playerName.toUpperCase() + " " + markerLabel;
               }
               selfColorFrame = "green";
               this.capsGained_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("kill");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[deadMemberIndex].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = aData.enemies[deadMemberIndex].playerName;
               break;
            case HUDPvPScoreboard.TYPE_REVENGE_SEEKER:
               markerLabel = "$$SEEKINGREVENGE";
               if(!this.m_Data.localPlayerInolved)
               {
                  markerLabel = this.m_Data.team[actingMemberIndex].playerName.toUpperCase() + " " + markerLabel;
               }
               selfColorFrame = "gold";
               this.capsReward_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("attackingplayer");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[deadMemberIndex].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = aData.enemies[deadMemberIndex].playerName;
               break;
            case HUDPvPScoreboard.TYPE_REVENGE_TARGET:
               markerLabel = "$$REVENGETARGET";
               if(!this.m_Data.localPlayerInolved)
               {
                  markerLabel = this.m_Data.team[deadMemberIndex].playerName.toUpperCase() + " " + markerLabel;
               }
               selfColorFrame = "gold";
               this.capsReward_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("underattack");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[actingMemberIndex].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = aData.enemies[actingMemberIndex].playerName;
         }
         this.pvpStrokeColor_mc.gotoAndStop(selfColorFrame);
         this.pvpPlayerScoreText_mc.gotoAndStop(scoreColorFrame);
         this.pvpEnemyScoreText_mc.gotoAndStop(scoreColorFrame);
         this.pvpVsText_mc.gotoAndStop(scoreColorFrame);
         TextFieldEx.setTextAutoSize(this.pvpPlayerName_mc.pvpPlayerName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.capsGained_mc.capsGained_tf.text = aData.capsGained;
         this.capsLost_mc.capsLost_tf.text = aData.capsLost;
         this.capsRisk_mc.capsRisk_tf.text = aData.capsRisk;
         this.capsReward_mc.capsReward_tf.text = aData.capsReward;
         if(aData.bountyTargetKilled)
         {
            this.capsGained_mc.Label_tf.text = "$BOUNTY";
         }
         else if(aData.revengeTargetKilled)
         {
            this.capsGained_mc.Label_tf.text = "$REVENGE";
         }
         else
         {
            this.capsGained_mc.Label_tf.text = "$REWARD";
         }
         if(aData.capsBonus > 0)
         {
            this.capsBonus_mc.capsBonus_tf.text = "+" + aData.capsBonus;
         }
         else
         {
            this.capsBonus_mc.capsBonus_tf.text = "";
         }
         this.pvpIdentifier_mc.pvpIdentifier_tf.text = markerLabel;
         this.pvpPlayerLevelDisplay_mc.pvpLevelBox_mc.pvpLevelValue_tf.text = aData.enemyLevel;
      }
   }
}
