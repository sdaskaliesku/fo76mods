 
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
         // method body index: 1904 method index: 1904
         super();
         TextFieldEx.setTextAutoSize(this.pvpPlayerName_mc.pvpPlayerName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         var _loc1_:ImageFixture = this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc as ImageFixture;
         _loc1_.clipWidth = _loc1_.width * (1 / _loc1_.scaleX);
         _loc1_.clipHeight = _loc1_.height * (1 / _loc1_.scaleY);
      }
      
      public function get data() : Object
      {
         // method body index: 1905 method index: 1905
         return this.m_Data;
      }
      
      public function set data(param1:Object) : void
      {
         // method body index: 1906 method index: 1906
         this.m_Data = param1;
         var _loc2_:String = "gold";
         var _loc3_:String = "gold";
         var _loc4_:String = "";
         this.capsGained_mc.alpha = 0;
         this.capsLost_mc.alpha = 0;
         this.capsRisk_mc.alpha = 0;
         this.capsReward_mc.alpha = 0;
         this.capsBonus_mc.alpha = 0;
         this.capsBonusAvailable_mc.alpha = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         if(this.m_Data.actingMemberIndex)
         {
            _loc5_ = this.m_Data.actingMemberIndex;
         }
         if(this.m_Data.deadMemberIndex)
         {
            _loc6_ = this.m_Data.deadMemberIndex;
         }
         switch(param1.type)
         {
            case HUDPvPScoreboard.TYPE_MURDERED:
               _loc4_ = "$$MURDEREDBY";
               if(!this.m_Data.localPlayerInolved)
               {
                  _loc4_ = this.m_Data.team[_loc5_].playerName.toUpperCase() + " " + _loc4_;
               }
               _loc2_ = "red";
               this.capsBonusAvailable_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("murdered");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.enemies[_loc5_].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = param1.enemies[_loc5_].playerName;
               break;
            case HUDPvPScoreboard.TYPE_TEAMDEATH:
            case HUDPvPScoreboard.TYPE_DEATH:
               _loc4_ = "$$KILLEDBYHEADER";
               if(!this.m_Data.localPlayerInolved)
               {
                  _loc4_ = this.m_Data.team[_loc6_].playerName.toUpperCase() + " " + _loc4_;
               }
               _loc2_ = "red";
               this.capsLost_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("death");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.enemies[_loc5_].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = param1.enemies[_loc5_].playerName;
               break;
            case HUDPvPScoreboard.TYPE_UNDERATTACK:
               _loc4_ = "$$UNDERATTACK";
               if(!this.m_Data.localPlayerInolved)
               {
                  _loc4_ = this.m_Data.team[_loc6_].playerName.toUpperCase() + " " + _loc4_;
               }
               _loc2_ = "gold";
               this.capsReward_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("underattack");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.enemies[_loc5_].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = param1.enemies[_loc5_].playerName;
               break;
            case HUDPvPScoreboard.TYPE_ATTACKINGPLAYER:
               _loc4_ = "$$ATTACKINGPLAYER";
               if(!this.m_Data.localPlayerInolved)
               {
                  _loc4_ = this.m_Data.team[_loc5_].playerName.toUpperCase() + " " + _loc4_;
               }
               _loc2_ = "gold";
               this.capsReward_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("attackingplayer");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.enemies[_loc6_].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = param1.enemies[_loc6_].playerName;
               break;
            case HUDPvPScoreboard.TYPE_TEAMKILL:
            case HUDPvPScoreboard.TYPE_KILL:
               _loc4_ = "$$KILLEDHEADER";
               if(!this.m_Data.localPlayerInolved)
               {
                  _loc4_ = this.m_Data.team[_loc5_].playerName.toUpperCase() + " " + _loc4_;
               }
               _loc2_ = "green";
               this.capsGained_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("kill");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.enemies[_loc6_].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = param1.enemies[_loc6_].playerName;
               break;
            case HUDPvPScoreboard.TYPE_REVENGE_SEEKER:
               _loc4_ = "$$SEEKINGREVENGE";
               if(!this.m_Data.localPlayerInolved)
               {
                  _loc4_ = this.m_Data.team[_loc5_].playerName.toUpperCase() + " " + _loc4_;
               }
               _loc2_ = "gold";
               this.capsReward_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("attackingplayer");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.enemies[_loc6_].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = param1.enemies[_loc6_].playerName;
               break;
            case HUDPvPScoreboard.TYPE_REVENGE_TARGET:
               _loc4_ = "$$REVENGETARGET";
               if(!this.m_Data.localPlayerInolved)
               {
                  _loc4_ = this.m_Data.team[_loc6_].playerName.toUpperCase() + " " + _loc4_;
               }
               _loc2_ = "gold";
               this.capsReward_mc.alpha = 1;
               this.capsBonus_mc.alpha = 1;
               this.PvPVaultBoys_mc.gotoAndStop("underattack");
               this.pvpPlayerIcon_mc.pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(param1.enemies[_loc5_].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.pvpPlayerName_mc.pvpPlayerName_tf.text = param1.enemies[_loc5_].playerName;
         }
         this.pvpStrokeColor_mc.gotoAndStop(_loc2_);
         this.pvpPlayerScoreText_mc.gotoAndStop(_loc3_);
         this.pvpEnemyScoreText_mc.gotoAndStop(_loc3_);
         this.pvpVsText_mc.gotoAndStop(_loc3_);
         TextFieldEx.setTextAutoSize(this.pvpPlayerName_mc.pvpPlayerName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.capsGained_mc.capsGained_tf.text = param1.capsGained;
         this.capsLost_mc.capsLost_tf.text = param1.capsLost;
         this.capsRisk_mc.capsRisk_tf.text = param1.capsRisk;
         this.capsReward_mc.capsReward_tf.text = param1.capsReward;
         if(param1.bountyTargetKilled)
         {
            this.capsGained_mc.Label_tf.text = "$BOUNTY";
         }
         else if(param1.revengeTargetKilled)
         {
            this.capsGained_mc.Label_tf.text = "$REVENGE";
         }
         else
         {
            this.capsGained_mc.Label_tf.text = "$REWARD";
         }
         if(param1.capsBonus > 0)
         {
            this.capsBonus_mc.capsBonus_tf.text = "+" + param1.capsBonus;
         }
         else
         {
            this.capsBonus_mc.capsBonus_tf.text = "";
         }
         this.pvpIdentifier_mc.pvpIdentifier_tf.text = _loc4_;
         this.pvpPlayerLevelDisplay_mc.pvpLevelBox_mc.pvpLevelValue_tf.text = param1.enemyLevel;
      }
   }
}
