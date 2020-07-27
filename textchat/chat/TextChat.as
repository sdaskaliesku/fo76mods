 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class TextChat extends MovieClip
   {
      
      public static var testString:String;
       
      
      private var _bIsDirty:Boolean;
      
      private var topLevel = null;
      
      public var SettingsBase_mc:MovieClip;
      
      public var TextChatBase_mc:MovieClip;
      
      public var message:TextField;
      
      public var tabOneSquare:Shape;
      
      public var tabTwoSquare:Shape;
      
      public var tabThreeSquare:Shape;
      
      public var tabFourSquare:Shape;
      
      public var tabFiveSquare:Shape;
      
      public var tabSixSquare:Shape;
      
      public var chatBackGroundSquare:Shape;
      
      public var chatEntrySquare:Shape;
      
      public var focusTab:ColorTransform;
      
      public var noFocusTab:ColorTransform;
      
      public var chatBackgroundColor:ColorTransform;
      
      public var chatEntryBackgroundColor:ColorTransform;
      
      public var chatTabIndex:Number = 0;
      
      public var pBGlobal:Boolean = true;
      
      public var pBTrade:Boolean = true;
      
      public var pBEU:Boolean = true;
      
      public function TextChat()
      {
         // method body index: 263 method index: 263
         this.message = new TextField();
         this.tabOneSquare = new Shape();
         this.tabTwoSquare = new Shape();
         this.tabThreeSquare = new Shape();
         this.tabFourSquare = new Shape();
         this.tabFiveSquare = new Shape();
         this.tabSixSquare = new Shape();
         this.chatBackGroundSquare = new Shape();
         this.chatEntrySquare = new Shape();
         this.focusTab = new ColorTransform();
         this.noFocusTab = new ColorTransform();
         this.chatBackgroundColor = new ColorTransform();
         this.chatEntryBackgroundColor = new ColorTransform();
         super();
         Extensions.enabled = true;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : void
      {
         // method body index: 264 method index: 264
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         // method body index: 265 method index: 265
         this.topLevel = stage.getChildAt(0);
         if(this.topLevel != null && getQualifiedClassName(this.topLevel) == "HUDMenu")
         {
            this.initialize();
         }
         else
         {
            trace("ERROR: Not injected into HUDMenu.");
         }
      }
      
      private function initialize() : void
      {
         // method body index: 266 method index: 266
         this.SettingsBase_mc.visible = false;
      }
      
      private function displayError(param1:String) : void
      {
         // method body index: 267 method index: 267
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
      
      public function setIniProperties(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:*, param11:*, param12:*, param13:*, param14:*, param15:*, param16:*) : void
      {
         // method body index: 268 method index: 268
         var _loc19_:Number = NaN;
         var _loc17_:Number = param1;
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
         this.chatBackgroundColor.color = param7;
         this.chatEntryBackgroundColor.color = param12;
         this.chatBackGroundSquare.graphics.clear();
         this.chatBackGroundSquare.graphics.beginFill(0,1);
         this.chatBackGroundSquare.graphics.drawRect(0,0,param2,_loc17_);
         this.TextChatBase_mc.TextChatWidget_mc.ChatText_bg.addChild(this.chatBackGroundSquare);
         this.chatEntrySquare.graphics.clear();
         this.chatEntrySquare.graphics.beginFill(0,1);
         this.chatEntrySquare.graphics.drawRect(0,param1,param2,24);
         this.TextChatBase_mc.TextChatEntryWidget_mc.TextEntry_bg.addChild(this.chatEntrySquare);
         this.chatBackGroundSquare.transform.colorTransform = this.chatBackgroundColor;
         this.chatEntrySquare.transform.colorTransform = this.chatEntryBackgroundColor;
         var _loc18_:Number = param2 / 6;
         this.tabOneSquare.graphics.clear();
         this.tabTwoSquare.graphics.clear();
         this.tabThreeSquare.graphics.clear();
         this.tabFourSquare.graphics.clear();
         this.tabFiveSquare.graphics.clear();
         this.tabSixSquare.graphics.clear();
         if(_loc18_ > 85)
         {
            _loc19_ = _loc18_ - 85;
         }
         else if(_loc18_ < 85)
         {
            _loc19_ = (85 - _loc18_) * -1;
         }
         else
         {
            _loc19_ = 0;
         }
         this.tabOneSquare.graphics.beginFill(0,1);
         this.tabOneSquare.graphics.drawRect(0,0,_loc18_,30);
         this.tabTwoSquare.graphics.beginFill(0,1);
         this.tabTwoSquare.graphics.drawRect(_loc19_ * 1,0,_loc18_,30);
         this.tabThreeSquare.graphics.beginFill(0,1);
         this.tabThreeSquare.graphics.drawRect(_loc19_ * 2,0,_loc18_,30);
         this.tabFourSquare.graphics.beginFill(0,1);
         this.tabFourSquare.graphics.drawRect(_loc19_ * 3,0,_loc18_,30);
         this.tabFiveSquare.graphics.beginFill(0,1);
         this.tabFiveSquare.graphics.drawRect(_loc19_ * 4,0,_loc18_,30);
         this.tabSixSquare.graphics.beginFill(0,1);
         this.tabSixSquare.graphics.drawRect(_loc19_ * 5,0,_loc18_,30);
         this.tabOneSquare.alpha = param10;
         this.tabTwoSquare.alpha = param10;
         this.tabThreeSquare.alpha = param10;
         this.tabFourSquare.alpha = param10;
         this.tabFiveSquare.alpha = param10;
         this.tabSixSquare.alpha = param10;
         this.chatEntrySquare.alpha = param13;
         this.chatBackGroundSquare.alpha = param6;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabOne_mc.ChatTab_mc.addChild(this.tabOneSquare);
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabTwo_mc.ChatTab_mc.addChild(this.tabTwoSquare);
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTab_mc.addChild(this.tabThreeSquare);
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTab_mc.addChild(this.tabFourSquare);
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFive_mc.ChatTab_mc.addChild(this.tabFiveSquare);
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabSix_mc.ChatTab_mc.addChild(this.tabSixSquare);
         this.focusTab.color = param8;
         this.noFocusTab.color = param9;
         this.tabOneSquare.transform.colorTransform = this.noFocusTab;
         this.tabTwoSquare.transform.colorTransform = this.noFocusTab;
         this.tabThreeSquare.transform.colorTransform = this.noFocusTab;
         this.tabFourSquare.transform.colorTransform = this.noFocusTab;
         this.tabFiveSquare.transform.colorTransform = this.noFocusTab;
         this.tabSixSquare.transform.colorTransform = this.noFocusTab;
         if(param15)
         {
            this.TextChatBase_mc.TextChatTabs_mc.visible = false;
         }
         else
         {
            this.TextChatBase_mc.TextChatTabs_mc.visible = true;
         }
         if(param16)
         {
            this.chatBackGroundSquare.visible = true;
         }
         else
         {
            this.chatBackGroundSquare.visible = false;
         }
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabOne_mc.ChatTabOne_tf.textColor = param11;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabTwo_mc.ChatTabTwo_tf.textColor = param11;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.textColor = param11;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.textColor = param11;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFive_mc.ChatTabFive_tf.textColor = param11;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabSix_mc.ChatTabSix_tf.textColor = param11;
         this.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.textColor = param14;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabOne_mc.ChatTabOne_tf.width = _loc18_;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabTwo_mc.ChatTabTwo_tf.width = _loc18_;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.width = _loc18_;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.width = _loc18_;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFive_mc.ChatTabFive_tf.width = _loc18_;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabSix_mc.ChatTabSix_tf.width = _loc18_;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabOne_mc.ChatTabOne_tf.x = 0;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabTwo_mc.ChatTabTwo_tf.x = _loc18_;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.x = _loc18_ * 2;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.x = _loc18_ * 3;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFive_mc.ChatTabFive_tf.x = _loc18_ * 4;
         this.TextChatBase_mc.TextChatTabs_mc.TextChatTabSix_mc.ChatTabSix_tf.x = _loc18_ * 5;
         this.chatTabIndex = this.chatTabIndex - 1;
         this.pBGlobal = param3;
         this.pBTrade = param4;
         this.changeTab();
         if(param3 == false)
         {
            this.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.alpha = 0.1;
         }
         else
         {
            this.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.alpha = 1;
         }
         if(param4 == false)
         {
            this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.alpha = 0.1;
         }
         else
         {
            this.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.alpha = 1;
         }
      }
      
      public function getCurrentTab() : Number
      {
         // method body index: 269 method index: 269
         return this.chatTabIndex;
      }
      
      public function changeTab() : void
      {
         // method body index: 270 method index: 270
         if(this.chatTabIndex == 5)
         {
            this.chatTabIndex = 0;
         }
         else
         {
            this.chatTabIndex++;
         }
         if(this.chatTabIndex == 2 && this.pBGlobal == false)
         {
            this.chatTabIndex = 3;
         }
         if(this.chatTabIndex == 3 && this.pBTrade == false)
         {
            this.chatTabIndex = 4;
         }
         switch(this.chatTabIndex)
         {
            case 0:
               this.TextChatBase_mc.TextChatWidget_mc.swapTab(0);
               this.tabOneSquare.transform.colorTransform = this.focusTab;
               this.tabTwoSquare.transform.colorTransform = this.noFocusTab;
               this.tabThreeSquare.transform.colorTransform = this.noFocusTab;
               this.tabFourSquare.transform.colorTransform = this.noFocusTab;
               this.tabFiveSquare.transform.colorTransform = this.noFocusTab;
               this.tabSixSquare.transform.colorTransform = this.noFocusTab;
               break;
            case 1:
               this.TextChatBase_mc.TextChatWidget_mc.swapTab(1);
               this.tabTwoSquare.transform.colorTransform = this.focusTab;
               this.tabOneSquare.transform.colorTransform = this.noFocusTab;
               this.tabThreeSquare.transform.colorTransform = this.noFocusTab;
               this.tabFourSquare.transform.colorTransform = this.noFocusTab;
               this.tabFiveSquare.transform.colorTransform = this.noFocusTab;
               this.tabSixSquare.transform.colorTransform = this.noFocusTab;
               break;
            case 2:
               this.TextChatBase_mc.TextChatWidget_mc.swapTab(2);
               this.tabThreeSquare.transform.colorTransform = this.focusTab;
               this.tabOneSquare.transform.colorTransform = this.noFocusTab;
               this.tabTwoSquare.transform.colorTransform = this.noFocusTab;
               this.tabFourSquare.transform.colorTransform = this.noFocusTab;
               this.tabFiveSquare.transform.colorTransform = this.noFocusTab;
               this.tabSixSquare.transform.colorTransform = this.noFocusTab;
               break;
            case 3:
               this.TextChatBase_mc.TextChatWidget_mc.swapTab(3);
               this.tabFourSquare.transform.colorTransform = this.focusTab;
               this.tabThreeSquare.transform.colorTransform = this.noFocusTab;
               this.tabOneSquare.transform.colorTransform = this.noFocusTab;
               this.tabTwoSquare.transform.colorTransform = this.noFocusTab;
               this.tabFiveSquare.transform.colorTransform = this.noFocusTab;
               this.tabSixSquare.transform.colorTransform = this.noFocusTab;
               break;
            case 4:
               this.TextChatBase_mc.TextChatWidget_mc.swapTab(4);
               this.tabFiveSquare.transform.colorTransform = this.focusTab;
               this.tabOneSquare.transform.colorTransform = this.noFocusTab;
               this.tabTwoSquare.transform.colorTransform = this.noFocusTab;
               this.tabThreeSquare.transform.colorTransform = this.noFocusTab;
               this.tabFourSquare.transform.colorTransform = this.noFocusTab;
               this.tabSixSquare.transform.colorTransform = this.noFocusTab;
               break;
            case 5:
               this.TextChatBase_mc.TextChatWidget_mc.swapTab(5);
               this.tabSixSquare.transform.colorTransform = this.focusTab;
               this.tabOneSquare.transform.colorTransform = this.noFocusTab;
               this.tabTwoSquare.transform.colorTransform = this.noFocusTab;
               this.tabThreeSquare.transform.colorTransform = this.noFocusTab;
               this.tabFourSquare.transform.colorTransform = this.noFocusTab;
               this.tabFiveSquare.transform.colorTransform = this.noFocusTab;
         }
      }
   }
}
