 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   
   public class HUDMessageItemTeamKill extends HUDMessageItemBase
   {
      
      public static const MAX_TEAMS:uint = // method body index: 3534 method index: 3534
      2;
      
      public static const MAX_PLAYERS:uint = // method body index: 3534 method index: 3534
      4;
       
      
      public function HUDMessageItemTeamKill()
      {

         super();
         addFrameScript(4,this.frame5,27,this.frame28,776,this.frame777);
      }
      
      override public function redrawUIComponent() : void
      {

         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc1_:uint = 0;
         _loc2_ = 0;
         _loc3_ = null;
         if(data != null)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.Header_tf,m_Data.data.headerText,true);
            _loc1_ = 0;
            while(_loc1_ < MAX_TEAMS)
            {
               GlobalFunc.SetText(Internal_mc["Team" + _loc1_ + "Score_tf"],m_Data.data.scores[_loc1_],true);
               _loc2_ = 0;
               while(_loc2_ < MAX_PLAYERS)
               {
                  _loc3_ = Internal_mc["Team" + _loc1_ + "Player" + _loc2_ + "Image_mc"];
                  if(m_Data.data.teams[_loc1_].players[_loc2_] != null && m_Data.data.teams[_loc1_].players.length > 0 && _loc2_ < m_Data.data.teams[_loc1_].players.length)
                  {
                     _loc3_.visible = true;
                     _loc3_.gotoAndStop(GlobalFunc.ImageFrameFromCharacter(m_Data.data.teams[_loc1_].players[_loc2_].name));
                  }
                  else
                  {
                     _loc3_.visible = false;
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {

         stop();
      }
      
      function frame28() : *
      {

         OnFadeInComplete();
         stop();
      }
      
      function frame777() : *
      {

         OnFadeOutComplete();
         stop();
      }
   }
}
