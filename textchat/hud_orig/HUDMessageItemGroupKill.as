 
package
{
   import Shared.GlobalFunc;
   
   public class HUDMessageItemGroupKill extends HUDMessageItemBase
   {
      
      public static const MAX_TEAMS:uint = // method body index: 3534 method index: 3534
      2;
       
      
      public function HUDMessageItemGroupKill()
      {
         // method body index: 3539 method index: 3539
         super();
         addFrameScript(4,this.frame5,27,this.frame28,347,this.frame348);
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3535 method index: 3535
         var teamIndex:uint = 0;
         if(data != null)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.Header_tf,m_Data.data.headerText,true);
            if(m_Data.data.isWarning)
            {
               Internal_mc.gotoAndStop("enemy");
            }
            else
            {
               Internal_mc.gotoAndStop("friendly");
            }
            for(teamIndex = 0; teamIndex < MAX_TEAMS; teamIndex++)
            {
               GlobalFunc.SetText(Internal_mc["Team" + teamIndex + "Score_tf"],m_Data.data.scores[teamIndex],true);
            }
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {
         // method body index: 3536 method index: 3536
         stop();
      }
      
      function frame28() : *
      {
         // method body index: 3537 method index: 3537
         OnFadeInComplete();
         stop();
      }
      
      function frame348() : *
      {
         // method body index: 3538 method index: 3538
         OnFadeOutComplete();
         stop();
      }
   }
}
