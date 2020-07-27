 
package
{
   import Shared.GlobalFunc;
   import flash.text.TextFieldAutoSize;
   
   public class HUDMessageItemBox extends HUDMessageItemBase
   {
       
      
      public function HUDMessageItemBox()
      {
         // method body index: 3507 method index: 3507
         super();
         addFrameScript(4,this.frame5,15,this.frame16,177,this.frame178);
         Internal_mc.BodyText_tf.autoSize = TextFieldAutoSize.LEFT;
         Internal_mc.BodyText_tf.multiline = true;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3508 method index: 3508
         if(data)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.HeaderText_tf,m_Data.data.headerText,true);
            GlobalFunc.SetText(Internal_mc.TitleText_tf,m_Data.data.titleText,true);
            GlobalFunc.SetText(Internal_mc.BodyText_tf,m_Data.data.messageText,true);
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {
         // method body index: 3509 method index: 3509
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3510 method index: 3510
         OnFadeInComplete();
         stop();
      }
      
      function frame178() : *
      {
         // method body index: 3511 method index: 3511
         OnFadeOutComplete();
         stop();
      }
   }
}
