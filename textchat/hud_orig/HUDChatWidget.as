 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public dynamic class HUDChatWidget extends BSUIComponent
   {
       
      
      public var ChatText_tf:TextField;
      
      public var ChatMessageArray:Array;
      
      private var DefaultOnscreenTime:Number = 10000;
      
      public function HUDChatWidget()
      {

         super();
         this.ChatMessageArray = new Array();
      }
      
      override public function redrawUIComponent() : void
      {

      }
      
      public function updateChat() : *
      {

         this.ChatText_tf.text = "";
         for(var i:Number = 0; i < this.ChatMessageArray.length; i++)
         {
            this.ChatText_tf.appendText(this.ChatMessageArray[i]);
         }
         this.ChatText_tf.setSelection(this.ChatText_tf.length,this.ChatText_tf.length);
      }
      
      public function removeChatMessage() : *
      {

         this.ChatMessageArray.shift();
         this.updateChat();
      }
      
      public function addChatMessage(ChatMessage:String, Sender:String = "") : *
      {

         var FormattedMessage:* = new String();
         setTimeout(this.removeChatMessage,this.DefaultOnscreenTime);
         FormattedMessage = Sender + ": " + ChatMessage + "\n";
         this.ChatMessageArray.push(FormattedMessage);
         this.updateChat();
      }
   }
}
