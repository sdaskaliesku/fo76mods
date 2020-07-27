 
package
{
   import Shared.GlobalFunc;
   
   public class HUDMessageItemUnderAttack extends HUDMessageItemBase
   {
       
      
      public function HUDMessageItemUnderAttack()
      {
         // method body index: 3542 method index: 3542
         super();
         addFrameScript(4,this.frame5,26,this.frame27,772,this.frame773);
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3543 method index: 3543
         if(data != null)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.RewardHeader_tf,m_Data.data.rewardHeader,true);
            GlobalFunc.SetText(Internal_mc.RewardValue_tf,m_Data.data.rewardValue,true);
            GlobalFunc.SetText(Internal_mc.PlayerName_tf,m_Data.data.titleText,true);
            Internal_mc.PlayerIcon_mc.gotoAndStop(GlobalFunc.ImageFrameFromCharacter(m_Data.data.playerName));
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {
         // method body index: 3544 method index: 3544
         stop();
      }
      
      function frame27() : *
      {
         // method body index: 3545 method index: 3545
         OnFadeInComplete();
         stop();
      }
      
      function frame773() : *
      {
         // method body index: 3546 method index: 3546
         OnFadeOutComplete();
         stop();
      }
   }
}
