 
package
{
   import Shared.GlobalFunc;
   import flash.text.TextFieldAutoSize;
   
   public class HUDMessageItemBox extends HUDMessageItemBase
   {
       
      
      public function HUDMessageItemBox()
      {
         // method body index: 3528 method index: 3528
         super();
         addFrameScript(4,this.frame5,15,this.frame16,177,this.frame178);
         Internal_mc.BodyText_tf.autoSize = TextFieldAutoSize.LEFT;
         Internal_mc.BodyText_tf.multiline = true;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3529 method index: 3529
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
         // method body index: 3530 method index: 3530
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 3531 method index: 3531
         OnFadeInComplete();
         stop();
      }
      
      function frame178() : *
      {
         // method body index: 3532 method index: 3532
         OnFadeOutComplete();
         stop();
      }
   }
}
