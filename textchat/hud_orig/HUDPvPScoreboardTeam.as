 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   
   public class HUDPvPScoreboardTeam extends MovieClip
   {
      
      public static const PLAYERS_MAX:uint = // method body index: 1982 method index: 1982
      4;
       
      
      public var capsGained_mc:MovieClip;
      
      public var capsBonus_mc:MovieClip;
      
      public var pvpVsText_mc:MovieClip;
      
      public var pvpPlayerIcon0:MovieClip;
      
      public var pvpPlayerIcon1:MovieClip;
      
      public var pvpPlayerIcon2:MovieClip;
      
      public var pvpPlayerIcon3:MovieClip;
      
      public var pvpEnemyIcon0:MovieClip;
      
      public var pvpEnemyIcon1:MovieClip;
      
      public var pvpEnemyIcon2:MovieClip;
      
      public var pvpEnemyIcon3:MovieClip;
      
      public var pvpPlayerScoreText_mc:MovieClip;
      
      public var pvpEnemyScoreText_mc:MovieClip;
      
      public var pvpStrokeColor_mc:MovieClip;
      
      public var pvpDeathXFrames_mc:MovieClip;
      
      public var pvpArrowMarkerFrames_mc:MovieClip;
      
      public var pvpIdentifierFrames_mc:MovieClip;
      
      private var m_Data:Object;
      
      public function HUDPvPScoreboardTeam()
      {

         var i:uint = 0;
         var avatarClip:ImageFixture = null;
         super();
         addFrameScript(9,this.frame10);
         for(i = 0; i < PLAYERS_MAX; i++)
         {
            avatarClip = this["pvpPlayerIcon" + i].pvpIconTransform_mc.PlayerIcon_mc as ImageFixture;
            avatarClip.clipWidth = avatarClip.width * (1 / avatarClip.scaleX);
            avatarClip.clipHeight = avatarClip.height * (1 / avatarClip.scaleY);
            avatarClip = this["pvpEnemyIcon" + i].pvpIconTransform_mc.PlayerIcon_mc as ImageFixture;
            avatarClip.clipWidth = avatarClip.width * (1 / avatarClip.scaleX);
            avatarClip.clipHeight = avatarClip.height * (1 / avatarClip.scaleY);
         }
      }
      
      public function get data() : Object
      {

         return this.m_Data;
      }
      
      public function set data(aData:Object) : void
      {

         var i:uint = 0;
         this.m_Data = aData;
         this.capsGained_mc.capsGained_tf.text = aData.capsGained;
         this.capsBonus_mc.capsBonus_tf.text = aData.capsBonus;
         var killerType:String = "Player";
         var victimType:String = "Enemy";
         var boardColorFrame:String = "gold";
         if(this.m_Data.type == HUDPvPScoreboard.TYPE_TEAMDEATH)
         {
            killerType = "Enemy";
            victimType = "Player";
            boardColorFrame = "red";
         }
         this.pvpStrokeColor_mc.gotoAndStop(boardColorFrame);
         this.pvpVsText_mc.gotoAndStop(boardColorFrame);
         this.pvpPlayerScoreText_mc.gotoAndStop(boardColorFrame);
         this.pvpEnemyScoreText_mc.gotoAndStop(boardColorFrame);
         this.pvpIdentifierFrames_mc.pvpIdentifier_mc.gotoAndStop(boardColorFrame);
         this.pvpArrowMarkerFrames_mc.pvpArrowMarker_mc.pvpArrowMarkerContainer_mc.gotoAndStop(boardColorFrame);
         this.pvpDeathXFrames_mc.gotoAndStop(victimType + this.m_Data.deadMemberIndex);
         this.pvpArrowMarkerFrames_mc.gotoAndStop(killerType + this.m_Data.actingMemberIndex);
         this.pvpIdentifierFrames_mc.gotoAndStop(killerType + this.m_Data.actingMemberIndex);
         for(i = 0; i < PLAYERS_MAX; i++)
         {
            if(i < aData.team.length)
            {
               this["pvpPlayerIcon" + i].visible = true;
               this["pvpPlayerIcon" + i].pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.team[i].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
            }
            else
            {
               this["pvpPlayerIcon" + i].visible = false;
            }
            if(i < aData.enemies.length)
            {
               this["pvpEnemyIcon" + i].visible = true;
               this["pvpEnemyIcon" + i].pvpIconTransform_mc.PlayerIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(aData.enemies[i].avatarId),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
            }
            else
            {
               this["pvpEnemyIcon" + i].visible = false;
            }
            if(this.m_Data.type == HUDPvPScoreboard.TYPE_TEAMDEATH)
            {
               if(i == this.m_Data.deadMemberIndex)
               {
                  this["pvpPlayerIcon" + i].gotoAndStop("teamInactive");
               }
               else
               {
                  this["pvpPlayerIcon" + i].gotoAndStop("teamActive");
               }
               this["pvpEnemyIcon" + i].gotoAndStop("teamActive");
            }
            else
            {
               if(i == this.m_Data.deadMemberIndex)
               {
                  this["pvpEnemyIcon" + i].gotoAndStop("teamInactive");
               }
               else
               {
                  this["pvpEnemyIcon" + i].gotoAndStop("teamActive");
               }
               this["pvpPlayerIcon" + i].gotoAndStop("teamActive");
            }
         }
         this.pvpPlayerScoreText_mc.pvpPlayerScoreText_tf.text = aData.playerScore;
         this.pvpEnemyScoreText_mc.pvpEnemyScoreText_tf.text = aData.enemyScore;
         this.pvpIdentifierFrames_mc.pvpIdentifier_mc.pvpIdentifier_tf.text = "$KILLER";
         this.pvpDeathXFrames_mc.pvpDeathX_mc.gotoAndPlay("rollOn");
      }
      
      function frame10() : *
      {

         stop();
      }
   }
}
