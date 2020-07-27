 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public dynamic class HUDChatWidget extends BSUIComponent
   {
       
      
      public var ChatText_tf:TextField;
      
      public var ChatMessageArray:Array;
      
      public var DefaultOnscreenTime:Number = 6000;
      
      private var bVarChatVisible = false;
      
      private var timeOut:int = -1;
      
      public var bScrolling = false;
      
      public var bGlobalOn = true;
      
      public var bTradeOn = true;
      
      public var bEUOn = true;
      
      public var iniLocation;
      
      public var iniBackgroundEnabled;
      
      public var iniBackgroundColor;
      
      public var iniBackgroundOpacity;
      
      public var chatOpen = false;
      
      public function HUDChatWidget()
      {

         super();
         Extensions.enabled = true;
         this.ChatMessageArray = new Array();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "$MAIN_Font";
         this.ChatText_tf.background = true;
         this.ChatText_tf.wordWrap = true;
         this.ChatText_tf.multiline = true;
         this.ChatText_tf.border = false;
         this.ChatText_tf.maxChars = 0;
         this.ChatText_tf.setTextFormat(_loc1_);
      }
      
      public function setIniProperties(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*) : *
      {

         this.ChatText_tf.alpha = param1;
         this.ChatText_tf.background = param3;
         this.ChatText_tf.backgroundColor = param2;
         var _loc8_:* = 120.4;
         if(param6 > 120)
         {
            this.ChatText_tf.y = (param6 - _loc8_) * -1;
         }
         else if(param6 < 120)
         {
            this.ChatText_tf.y = _loc8_ - param6;
         }
         this.ChatText_tf.height = param6;
         this.ChatText_tf.width = param7;
      }
      
      override public function redrawUIComponent() : void
      {

      }
      
      public function chatIsOpen() : *
      {

         this.chatOpen = true;
      }
      
      public function chatisClosed() : *
      {

         this.chatOpen = false;
      }
      
      public function updateChat() : *
      {

         var _loc1_:Number = NaN;
         if(this.bScrolling == false)
         {
            this.ChatText_tf.visible = true;
            this.ChatText_tf.text = "";
            _loc1_ = 0;
            while(_loc1_ < this.ChatMessageArray.length)
            {
               if(this.ChatMessageArray[_loc1_].substr(22,8) == "[Global]")
               {
                  if(this.bGlobalOn == true)
                  {
                     TextFieldEx.appendHtml(this.ChatText_tf,this.ChatMessageArray[_loc1_]);
                     _loc1_++;
                  }
                  else
                  {
                     _loc1_++;
                  }
               }
               else if(this.ChatMessageArray[_loc1_].substr(22,7) == "[Trade]")
               {
                  if(this.bTradeOn == true)
                  {
                     TextFieldEx.appendHtml(this.ChatText_tf,this.ChatMessageArray[_loc1_]);
                     _loc1_++;
                  }
                  else
                  {
                     _loc1_++;
                  }
               }
               else if(this.ChatMessageArray[_loc1_].substr(22,11) == "[EU Global]")
               {
                  if(this.bEUOn == true)
                  {
                     TextFieldEx.appendHtml(this.ChatText_tf,this.ChatMessageArray[_loc1_]);
                     _loc1_++;
                  }
                  else
                  {
                     _loc1_++;
                  }
               }
               else
               {
                  TextFieldEx.appendHtml(this.ChatText_tf,this.ChatMessageArray[_loc1_]);
                  _loc1_++;
               }
            }
            this.ChatText_tf.setSelection(this.ChatText_tf.length,this.ChatText_tf.length);
            this.bVarChatVisible = true;
            if(this.chatOpen == false)
            {
               this.endChat();
            }
         }
      }
      
      public function disableGlobal(param1:*) : *
      {

         this.bGlobalOn = param1;
      }
      
      public function disableTrade(param1:*) : *
      {

         this.bTradeOn = param1;
      }
      
      public function disableEU(param1:*) : *
      {

         this.bEUOn = param1;
      }
      
      public function startChat() : *
      {

         clearTimeout(this.timeOut);
      }
      
      public function endChat() : *
      {

         clearTimeout(this.timeOut);
         this.timeOut = setTimeout(this.hideChat,this.DefaultOnscreenTime);
      }
      
      public function setTimer(param1:*) : *
      {

         var _loc2_:* = parseInt(param1) * 1000;
         this.DefaultOnscreenTime = _loc2_;
      }
      
      public function resetScrolling() : *
      {

         this.bScrolling = false;
      }
      
      public function hideChat() : *
      {

         this.bVarChatVisible = false;
         this.ChatText_tf.visible = false;
      }
      
      public function removeChatMessage() : *
      {

         this.ChatMessageArray.shift();
         this.updateChat();
      }
      
      public function scrollUp() : *
      {

         this.ChatText_tf.scrollV--;
         this.bScrolling = true;
      }
      
      public function scrollDown() : *
      {

         this.ChatText_tf.scrollV++;
         this.bScrolling = true;
      }
      
      public function addChatMessage(param1:String, param2:String, param3:Number, param4:String) : *
      {

         var _loc5_:* = new String();
         var _loc6_:String = "[Local]";
         var _loc7_:String = "[Global]";
         var _loc8_:String = "[Trade]";
         var _loc9_:String = "[Party]";
         var _loc10_:String = "[Clan]";
         var _loc11_:String = "[EU Global]";
         if(HUDMenu.reduceTags == true)
         {
            _loc6_ = "[L]";
            _loc7_ = "[G]";
            _loc8_ = "[T]";
            _loc9_ = "[P]";
            _loc10_ = "[C]";
            _loc11_ = "[EU]";
         }
         if(param3 == 0)
         {
            param1 = _loc6_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
         }
         else if(param3 == 1)
         {
            param1 = _loc7_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
         }
         else if(param3 == 2)
         {
            param1 = "[ALERT]";
            _loc5_ = param4 + param1 + param2 + "</font>" + "\n";
         }
         else if(param3 == 3)
         {
            param1 = _loc8_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
         }
         else if(param3 == 4)
         {
            param1 = _loc9_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
         }
         else if(param3 == 5)
         {
            param1 = _loc10_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
         }
         else if(param3 == 6)
         {
            param1 = _loc11_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
         }
         if(this.ChatMessageArray.length == 100)
         {
            this.ChatMessageArray.shift();
         }
         this.ChatMessageArray.push(_loc5_);
         this.updateChat();
      }
   }
}
