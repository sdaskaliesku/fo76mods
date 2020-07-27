 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDMessageItem extends HUDMessageItemBase
   {
       
      
      private var BaseTextFieldWidth:uint = 0;
      
      public function HUDMessageItem()
      {
         // method body index: 3497 method index: 3497
         super();
         addFrameScript(4,this.frame5,18,this.frame19,123,this.frame124);
         this.BaseTextFieldWidth = this.MessageText_tf.width;
         this.MessageText_tf.autoSize = TextFieldAutoSize.LEFT;
         this.MessageText_tf.multiline = true;
      }
      
      private function get MessageText_tf() : TextField
      {
         // method body index: 3498 method index: 3498
         return Internal_mc.MessageText_tf as TextField;
      }
      
      private function get RadioStationIcon_mc() : MovieClip
      {
         // method body index: 3499 method index: 3499
         return Internal_mc.RadioStationIcon_mc as MovieClip;
      }
      
      public function CalcIconWidth() : uint
      {
         // method body index: 3500 method index: 3500
         var _loc1_:uint = 0;
         if(m_Data.data.isRadioStation)
         {
            _loc1_ = _loc1_ + (this.RadioStationIcon_mc.width + 2);
         }
         return _loc1_;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3501 method index: 3501
         var _loc1_:uint = 0;
         if(data)
         {
            visible = true;
            this.RadioStationIcon_mc.visible = m_Data.data.isRadioStation;
            _loc1_ = this.CalcIconWidth();
            this.MessageText_tf.width = this.BaseTextFieldWidth - _loc1_;
            this.MessageText_tf.x = _loc1_;
            TextFieldEx.setNoTranslate(this.MessageText_tf,true);
            GlobalFunc.SetText(this.MessageText_tf,m_Data.data.messageText,true);
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {
         // method body index: 3502 method index: 3502
         stop();
      }
      
      function frame19() : *
      {
         // method body index: 3503 method index: 3503
         OnFadeInComplete();
         stop();
      }
      
      function frame124() : *
      {
         // method body index: 3504 method index: 3504
         OnFadeOutComplete();
         stop();
      }
   }
}
