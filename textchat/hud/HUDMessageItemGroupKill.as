 
package
{
   import Shared.GlobalFunc;
   
   public class HUDMessageItemGroupKill extends HUDMessageItemBase
   {
      
      public static const MAX_TEAMS:uint = // method body index: 3513 method index: 3513
      2;
       
      
      public function HUDMessageItemGroupKill()
      {
         // method body index: 3514 method index: 3514
         super();
         addFrameScript(4,this.frame5,27,this.frame28,347,this.frame348);
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3515 method index: 3515
         var _loc1_:uint = 0;
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
            _loc1_ = 0;
            while(_loc1_ < MAX_TEAMS)
            {
               GlobalFunc.SetText(Internal_mc["Team" + _loc1_ + "Score_tf"],m_Data.data.scores[_loc1_],true);
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
         // method body index: 3516 method index: 3516
         stop();
      }
      
      function frame28() : *
      {
         // method body index: 3517 method index: 3517
         OnFadeInComplete();
         stop();
      }
      
      function frame348() : *
      {
         // method body index: 3518 method index: 3518
         OnFadeOutComplete();
         stop();
      }
   }
}
