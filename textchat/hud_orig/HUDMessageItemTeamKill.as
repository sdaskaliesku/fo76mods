 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   
   public class HUDMessageItemTeamKill extends HUDMessageItemBase
   {
      
      public static const MAX_TEAMS:uint = // method body index: 3555 method index: 3555
      2;
      
      public static const MAX_PLAYERS:uint = // method body index: 3555 method index: 3555
      4;
       
      
      public function HUDMessageItemTeamKill()
      {
         // method body index: 3560 method index: 3560
         super();
         addFrameScript(4,this.frame5,27,this.frame28,776,this.frame777);
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3556 method index: 3556
         var teamIndex:uint = 0;
         var playerIndex:uint = 0;
         var playerImage:MovieClip = null;
         if(data != null)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.Header_tf,m_Data.data.headerText,true);
            for(teamIndex = 0; teamIndex < MAX_TEAMS; teamIndex++)
            {
               GlobalFunc.SetText(Internal_mc["Team" + teamIndex + "Score_tf"],m_Data.data.scores[teamIndex],true);
               for(playerIndex = 0; playerIndex < MAX_PLAYERS; playerIndex++)
               {
                  playerImage = Internal_mc["Team" + teamIndex + "Player" + playerIndex + "Image_mc"];
                  if(m_Data.data.teams[teamIndex].players[playerIndex] != null && m_Data.data.teams[teamIndex].players.length > 0 && playerIndex < m_Data.data.teams[teamIndex].players.length)
                  {
                     playerImage.visible = true;
                     playerImage.gotoAndStop(GlobalFunc.ImageFrameFromCharacter(m_Data.data.teams[teamIndex].players[playerIndex].name));
                  }
                  else
                  {
                     playerImage.visible = false;
                  }
               }
            }
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {
         // method body index: 3557 method index: 3557
         stop();
      }
      
      function frame28() : *
      {
         // method body index: 3558 method index: 3558
         OnFadeInComplete();
         stop();
      }
      
      function frame777() : *
      {
         // method body index: 3559 method index: 3559
         OnFadeOutComplete();
         stop();
      }
   }
}
