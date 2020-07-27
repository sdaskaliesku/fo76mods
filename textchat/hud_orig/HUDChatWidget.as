 
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
         // method body index: 2922 method index: 2922
         super();
         this.ChatMessageArray = new Array();
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 2923 method index: 2923
      }
      
      public function updateChat() : *
      {
         // method body index: 2924 method index: 2924
         this.ChatText_tf.text = "";
         for(var i:Number = 0; i < this.ChatMessageArray.length; i++)
         {
            this.ChatText_tf.appendText(this.ChatMessageArray[i]);
         }
         this.ChatText_tf.setSelection(this.ChatText_tf.length,this.ChatText_tf.length);
      }
      
      public function removeChatMessage() : *
      {
         // method body index: 2925 method index: 2925
         this.ChatMessageArray.shift();
         this.updateChat();
      }
      
      public function addChatMessage(ChatMessage:String, Sender:String = "") : *
      {
         // method body index: 2926 method index: 2926
         var FormattedMessage:* = new String();
         setTimeout(this.removeChatMessage,this.DefaultOnscreenTime);
         FormattedMessage = Sender + ": " + ChatMessage + "\n";
         this.ChatMessageArray.push(FormattedMessage);
         this.updateChat();
      }
   }
}
