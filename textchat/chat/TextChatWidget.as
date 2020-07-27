 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public dynamic class TextChatWidget extends BSUIComponent
   {
       
      
      public var ChatText_bg:TextChatWidgetBackground;
      
      public var ChatText_tf:TextField;
      
      public var ChatTextLocal_tf:TextField;
      
      public var ChatTextGlobal_tf:TextField;
      
      public var ChatTextTrade_tf:TextField;
      
      public var ChatTextParty_tf:TextField;
      
      public var ChatTextClan_tf:TextField;
      
      public var ChatMessageArray:Array;
      
      public var GlobalMessageArray:Array;
      
      public var LocalMessageArray:Array;
      
      public var TradeMessageArray:Array;
      
      public var PartyMessageArray:Array;
      
      public var ClanMessageArray:Array;
      
      public var DefaultOnscreenTime:Number = 6000;
      
      private var bVarChatVisible:Boolean = false;
      
      private var timeOut:int = -1;
      
      public var bScrolling:Boolean = false;
      
      public var bGlobalOn:Boolean = true;
      
      public var bTradeOn:Boolean = true;
      
      public var bEUOn:Boolean = true;
      
      public var bWhisperOn:Boolean = true;
      
      public var chatOpen:Boolean = false;
      
      public var reduceTags:Boolean = true;
      
      public var timeStamps:Boolean = false;
      
      public var currentTabIndex:Number = 0;
      
      public var message:TextField;
      
      public function TextChatWidget()
      {
         // method body index: 597 method index: 597
         this.message = new TextField();
         super();
         Extensions.enabled = true;
         this.ChatMessageArray = new Array();
         this.GlobalMessageArray = new Array();
         this.LocalMessageArray = new Array();
         this.TradeMessageArray = new Array();
         this.PartyMessageArray = new Array();
         this.ClanMessageArray = new Array();
         this.ChatTextLocal_tf.visible = false;
         this.ChatTextGlobal_tf.visible = false;
         this.ChatTextTrade_tf.visible = false;
         this.ChatTextParty_tf.visible = false;
         this.ChatTextClan_tf.visible = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "$MAIN_Font";
         this.ChatText_tf.background = true;
         this.ChatText_tf.wordWrap = true;
         this.ChatText_tf.multiline = true;
         this.ChatText_tf.border = false;
         this.ChatText_tf.maxChars = 0;
         this.ChatTextLocal_tf.wordWrap = true;
         this.ChatTextLocal_tf.multiline = true;
         this.ChatTextGlobal_tf.wordWrap = true;
         this.ChatTextGlobal_tf.multiline = true;
         this.ChatTextTrade_tf.wordWrap = true;
         this.ChatTextTrade_tf.multiline = true;
         this.ChatTextParty_tf.wordWrap = true;
         this.ChatTextParty_tf.multiline = true;
         this.ChatTextClan_tf.wordWrap = true;
         this.ChatTextClan_tf.multiline = true;
         this.ChatText_tf.setTextFormat(_loc1_);
         this.ChatTextLocal_tf.setTextFormat(_loc1_);
         this.ChatTextGlobal_tf.setTextFormat(_loc1_);
         this.ChatTextTrade_tf.setTextFormat(_loc1_);
         this.ChatTextParty_tf.setTextFormat(_loc1_);
         this.ChatTextClan_tf.setTextFormat(_loc1_);
      }
      
      public function setIniProperties(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*) : void
      {
         // method body index: 598 method index: 598
         this.ChatText_tf.alpha = parseFloat("1.0");
         this.ChatText_tf.background = false;
         this.ChatText_tf.height = param6;
         this.ChatText_tf.width = param7;
         this.ChatTextLocal_tf.height = param6;
         this.ChatTextLocal_tf.width = param7;
         this.ChatTextGlobal_tf.height = param6;
         this.ChatTextGlobal_tf.width = param7;
         this.ChatTextTrade_tf.height = param6;
         this.ChatTextTrade_tf.width = param7;
         this.ChatTextParty_tf.height = param6;
         this.ChatTextParty_tf.width = param7;
         this.ChatTextClan_tf.height = param6;
         this.ChatTextClan_tf.width = param7;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 599 method index: 599
      }
      
      public function chatIsOpen() : void
      {
         // method body index: 600 method index: 600
         this.chatOpen = true;
         parent.visible = true;
      }
      
      public function chatisClosed() : void
      {
         // method body index: 601 method index: 601
         this.chatOpen = false;
      }
      
      public function updateChat() : *
      {
         // method body index: 602 method index: 602
         var _loc1_:Number = NaN;
         if(this.bScrolling == false)
         {
            if(this.currentTabIndex == 0)
            {
               this.ChatText_tf.visible = true;
            }
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
      
      public function updateComplexChat(param1:TextField, param2:Array) : *
      {
         // method body index: 603 method index: 603
         var _loc3_:Number = NaN;
         if(this.bScrolling == false)
         {
            param1.text = "";
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               TextFieldEx.appendHtml(param1,param2[_loc3_]);
               _loc3_++;
            }
            param1.setSelection(param1.length,param1.length);
            if(this.chatOpen == false)
            {
            }
         }
      }
      
      public function swapTab(param1:Number) : void
      {
         // method body index: 604 method index: 604
         this.currentTabIndex = param1;
         switch(param1)
         {
            case 0:
               this.ChatText_tf.visible = true;
               this.ChatTextClan_tf.visible = false;
               this.ChatTextLocal_tf.visible = false;
               this.ChatTextGlobal_tf.visible = false;
               this.ChatTextTrade_tf.visible = false;
               this.ChatTextParty_tf.visible = false;
               break;
            case 1:
               this.ChatTextLocal_tf.visible = true;
               this.ChatText_tf.visible = false;
               this.ChatTextClan_tf.visible = false;
               this.ChatTextGlobal_tf.visible = false;
               this.ChatTextTrade_tf.visible = false;
               this.ChatTextParty_tf.visible = false;
               break;
            case 2:
               this.ChatTextGlobal_tf.visible = true;
               this.ChatTextLocal_tf.visible = false;
               this.ChatText_tf.visible = false;
               this.ChatTextClan_tf.visible = false;
               this.ChatTextTrade_tf.visible = false;
               this.ChatTextParty_tf.visible = false;
               break;
            case 3:
               this.ChatTextTrade_tf.visible = true;
               this.ChatTextGlobal_tf.visible = false;
               this.ChatText_tf.visible = false;
               this.ChatTextClan_tf.visible = false;
               this.ChatTextLocal_tf.visible = false;
               this.ChatTextParty_tf.visible = false;
               break;
            case 4:
               this.ChatTextParty_tf.visible = true;
               this.ChatTextTrade_tf.visible = false;
               this.ChatText_tf.visible = false;
               this.ChatTextClan_tf.visible = false;
               this.ChatTextLocal_tf.visible = false;
               this.ChatTextGlobal_tf.visible = false;
               break;
            case 5:
               this.ChatTextClan_tf.visible = true;
               this.ChatTextParty_tf.visible = false;
               this.ChatText_tf.visible = false;
               this.ChatTextLocal_tf.visible = false;
               this.ChatTextGlobal_tf.visible = false;
               this.ChatTextTrade_tf.visible = false;
         }
      }
      
      public function disableGlobal(param1:*) : void
      {
         // method body index: 605 method index: 605
         this.bGlobalOn = param1;
      }
      
      public function disableTrade(param1:*) : void
      {
         // method body index: 606 method index: 606
         this.bTradeOn = param1;
      }
      
      public function disableEU(param1:*) : void
      {
         // method body index: 607 method index: 607
         this.bEUOn = param1;
      }
      
      public function disableWhisper(param1:*) : void
      {
         // method body index: 608 method index: 608
         this.bWhisperOn = param1;
      }
      
      public function startChat() : void
      {
         // method body index: 609 method index: 609
         clearTimeout(this.timeOut);
      }
      
      public function endChat() : void
      {
         // method body index: 610 method index: 610
         clearTimeout(this.timeOut);
         this.timeOut = setTimeout(this.hideChat,this.DefaultOnscreenTime);
      }
      
      public function setTimer(param1:*) : void
      {
         // method body index: 611 method index: 611
         var _loc2_:* = parseInt(param1) * 1000;
         this.DefaultOnscreenTime = _loc2_;
      }
      
      public function resetScrolling() : void
      {
         // method body index: 612 method index: 612
         this.bScrolling = false;
      }
      
      public function hideChat() : *
      {
         // method body index: 613 method index: 613
         this.bVarChatVisible = false;
         parent.visible = false;
      }
      
      public function removeChatMessage() : *
      {
         // method body index: 614 method index: 614
         this.ChatMessageArray.shift();
         this.updateChat();
      }
      
      public function scrollUp() : *
      {
         // method body index: 615 method index: 615
         this.ChatText_tf.scrollV--;
         this.ChatTextClan_tf.scrollV--;
         this.ChatTextGlobal_tf.scrollV--;
         this.ChatTextLocal_tf.scrollV--;
         this.ChatTextParty_tf.scrollV--;
         this.ChatTextTrade_tf.scrollV--;
         this.bScrolling = true;
      }
      
      public function scrollDown() : *
      {
         // method body index: 616 method index: 616
         this.ChatText_tf.scrollV++;
         this.ChatTextClan_tf.scrollV++;
         this.ChatTextGlobal_tf.scrollV++;
         this.ChatTextLocal_tf.scrollV++;
         this.ChatTextParty_tf.scrollV++;
         this.ChatTextTrade_tf.scrollV++;
         this.bScrolling = true;
      }
      
      public function scrollMax() : *
      {
         // method body index: 617 method index: 617
         this.ChatText_tf.maxScrollV;
         this.ChatTextClan_tf.maxScrollV;
         this.ChatTextGlobal_tf.maxScrollV;
         this.ChatTextLocal_tf.maxScrollV;
         this.ChatTextParty_tf.maxScrollV;
         this.ChatTextTrade_tf.maxScrollV;
      }
      
      public function setReduceTags(param1:Boolean) : *
      {
         // method body index: 618 method index: 618
         this.reduceTags = param1;
      }
      
      public function setTimeStamps(param1:Boolean) : void
      {
         // method body index: 619 method index: 619
         this.timeStamps = param1;
      }
      
      public function addChatMessage(param1:String, param2:String, param3:Number, param4:String) : *
      {
         // method body index: 620 method index: 620
         var _loc5_:* = new String();
         var _loc6_:String = "[Local]";
         var _loc7_:String = "[Global]";
         var _loc8_:String = "[Trade]";
         var _loc9_:String = "[Party]";
         var _loc10_:String = "[Clan]";
         var _loc11_:String = "[EU Global]";
         var _loc12_:String = "[Whisper]";
         var _loc13_:Date = new Date();
         var _loc14_:String = _loc13_.toLocaleTimeString();
         var _loc15_:* = _loc14_.split(/\s+/g);
         _loc14_ = _loc15_[0];
         if(this.reduceTags == true)
         {
            _loc6_ = "[L]";
            _loc7_ = "[G]";
            _loc8_ = "[T]";
            _loc9_ = "[P]";
            _loc10_ = "[C]";
            _loc11_ = "[EU]";
            _loc12_ = "[W]";
         }
         _loc14_ = _loc14_.substring(0,_loc14_.length - 3);
         if(this.timeStamps)
         {
            _loc6_ = _loc14_ + " " + _loc6_;
            _loc7_ = _loc14_ + " " + _loc7_;
            _loc8_ = _loc14_ + " " + _loc8_;
            _loc9_ = _loc14_ + " " + _loc9_;
            _loc10_ = _loc14_ + " " + _loc10_;
            _loc11_ = _loc14_ + " " + _loc11_;
            _loc12_ = _loc14_ + " " + _loc12_;
         }
         if(param3 == 0)
         {
            param1 = _loc6_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
            this.LocalMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextLocal_tf,this.LocalMessageArray);
         }
         else if(param3 == 1)
         {
            param1 = _loc7_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
            this.GlobalMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextGlobal_tf,this.GlobalMessageArray);
         }
         else if(param3 == 2)
         {
            param1 = "[ALERT]";
            _loc5_ = param4 + param1 + param2 + "</font>" + "\n";
            this.LocalMessageArray.push(_loc5_);
            this.GlobalMessageArray.push(_loc5_);
            this.TradeMessageArray.push(_loc5_);
            this.PartyMessageArray.push(_loc5_);
            this.ClanMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextLocal_tf,this.LocalMessageArray);
            this.updateComplexChat(this.ChatTextGlobal_tf,this.GlobalMessageArray);
            this.updateComplexChat(this.ChatTextTrade_tf,this.TradeMessageArray);
            this.updateComplexChat(this.ChatTextParty_tf,this.PartyMessageArray);
            this.updateComplexChat(this.ChatTextClan_tf,this.ClanMessageArray);
            this.updateComplexChat(this.ChatTextGlobal_tf,this.GlobalMessageArray);
         }
         else if(param3 == 3)
         {
            param1 = _loc8_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
            this.TradeMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextTrade_tf,this.TradeMessageArray);
         }
         else if(param3 == 4)
         {
            param1 = _loc9_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
            this.PartyMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextParty_tf,this.PartyMessageArray);
         }
         else if(param3 == 5)
         {
            param1 = _loc10_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
            this.ClanMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextClan_tf,this.ClanMessageArray);
         }
         else if(param3 == 6)
         {
            param1 = _loc11_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
            this.GlobalMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextGlobal_tf,this.GlobalMessageArray);
         }
         else if(param3 == 9)
         {
            param1 = _loc12_ + param1;
            _loc5_ = param4 + param1 + ": " + param2 + "</font>" + "\n";
            this.LocalMessageArray.push(_loc5_);
            this.GlobalMessageArray.push(_loc5_);
            this.TradeMessageArray.push(_loc5_);
            this.PartyMessageArray.push(_loc5_);
            this.ClanMessageArray.push(_loc5_);
            this.updateComplexChat(this.ChatTextLocal_tf,this.LocalMessageArray);
            this.updateComplexChat(this.ChatTextGlobal_tf,this.GlobalMessageArray);
            this.updateComplexChat(this.ChatTextTrade_tf,this.TradeMessageArray);
            this.updateComplexChat(this.ChatTextParty_tf,this.PartyMessageArray);
            this.updateComplexChat(this.ChatTextClan_tf,this.ClanMessageArray);
            this.updateComplexChat(this.ChatTextGlobal_tf,this.GlobalMessageArray);
         }
         if(this.ChatMessageArray.length == 100)
         {
            this.ChatMessageArray.shift();
         }
         if(this.GlobalMessageArray.length == 100)
         {
            this.GlobalMessageArray.shift();
         }
         if(this.ClanMessageArray.length == 100)
         {
            this.ClanMessageArray.shift();
         }
         if(this.PartyMessageArray.length == 100)
         {
            this.PartyMessageArray.shift();
         }
         if(this.TradeMessageArray.length == 100)
         {
            this.TradeMessageArray.shift();
         }
         if(this.LocalMessageArray.length == 100)
         {
            this.LocalMessageArray.shift();
         }
         parent.visible = true;
         this.ChatMessageArray.push(_loc5_);
         this.updateChat();
      }
      
      private function displayError(param1:String) : void
      {
         // method body index: 621 method index: 621
         this.message.width = 1600;
         GlobalFunc.SetText(this.message,this.message.text + "\n" + param1,false);
         TextFieldEx.setTextAutoSize(this.message,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.message.autoSize = TextFieldAutoSize.LEFT;
         this.message.wordWrap = true;
         this.message.multiline = true;
         addChild(this.message);
         this.message.visible = true;
         var _loc2_:TextFormat = new TextFormat("Arial",18,16777215);
         this.message.defaultTextFormat = _loc2_;
         this.message.setTextFormat(_loc2_);
         this.message.mouseEnabled = false;
      }
   }
}
