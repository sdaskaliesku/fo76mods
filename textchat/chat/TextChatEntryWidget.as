 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public dynamic class TextChatEntryWidget extends BSUIComponent
   {
       
      
      public var TextEntry_bg:TextChatEntryWidgetBackground;
      
      public var ChatEntryText_tf:TextField;
      
      public var ChatEntryChannel_tf:TextField;
      
      public function TextChatEntryWidget()
      {

         super();
      }
      
      public function setIniProperties(param1:*, param2:*) : void
      {

         if(param1 > 120)
         {
            param1 = param1 - 120;
         }
         else if(param1 < 120)
         {
            param1 = (120 - param1) * -1;
         }
         else
         {
            param1 = 0;
         }
         this.ChatEntryChannel_tf.y = 0;
         this.ChatEntryChannel_tf.y = param1;
         this.ChatEntryText_tf.y = 0;
         this.ChatEntryText_tf.y = param1;
         this.ChatEntryText_tf.width = param2 - 30;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = "$MAIN_Font";
         this.ChatEntryChannel_tf.setTextFormat(_loc3_);
         this.ChatEntryText_tf.maxChars = 0;
      }
      
      public function setChatTab() : void
      {

         var _loc1_:uint = this.ChatEntryChannel_tf.borderColor;
         this.ChatEntryChannel_tf.backgroundColor = _loc1_;
         this.ChatEntryChannel_tf.background = true;
         this.ChatEntryChannel_tf.textColor = 8157308;
      }
      
      override public function redrawUIComponent() : void
      {

      }
   }
}
