 
package
{
   import Shared.GlobalFunc;
   
   public class HUDMessageItemRevenge extends HUDMessageItemBase
   {
       
      
      public function HUDMessageItemRevenge()
      {
         // method body index: 3553 method index: 3553
         super();
         addFrameScript(4,this.frame5,26,this.frame27,772,this.frame773);
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3549 method index: 3549
         if(data != null)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.RewardHeader_tf,m_Data.data.rewardHeader,true);
            GlobalFunc.SetText(Internal_mc.RewardValue_tf,m_Data.data.rewardValue,true);
            GlobalFunc.SetText(Internal_mc.PlayerName_tf,m_Data.data.titleText,true);
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {
         // method body index: 3550 method index: 3550
         stop();
      }
      
      function frame27() : *
      {
         // method body index: 3551 method index: 3551
         OnFadeInComplete();
         stop();
      }
      
      function frame773() : *
      {
         // method body index: 3552 method index: 3552
         OnFadeOutComplete();
         stop();
      }
   }
}
