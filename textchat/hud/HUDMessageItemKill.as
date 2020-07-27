 
package
{
   import Shared.GlobalFunc;
   
   public class HUDMessageItemKill extends HUDMessageItemBase
   {
       
      
      public function HUDMessageItemKill()
      {

         super();
         addFrameScript(4,this.frame5,27,this.frame28,772,this.frame773);
      }
      
      override public function redrawUIComponent() : void
      {

         if(data != null)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.Header_tf,m_Data.data.headerText,true);
            if(m_Data.data.teams != null)
            {
               if(m_Data.data.teams[0].players[0] != null)
               {
                  GlobalFunc.SetText(Internal_mc.PlayerAValue_tf,m_Data.data.scores[0],true);
                  Internal_mc.PlayerAIcon_mc.gotoAndStop(GlobalFunc.ImageFrameFromCharacter(m_Data.data.teams[0].players[0].name));
               }
               if(m_Data.data.teams[1].players[0] != null)
               {
                  GlobalFunc.SetText(Internal_mc.PlayerBValue_tf,m_Data.data.scores[1],true);
                  Internal_mc.PlayerBIcon_mc.gotoAndStop(GlobalFunc.ImageFrameFromCharacter(m_Data.data.teams[1].players[0].name));
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

         stop();
      }
      
      function frame28() : *
      {

         OnFadeInComplete();
         stop();
      }
      
      function frame773() : *
      {

         OnFadeOutComplete();
         stop();
      }
   }
}
