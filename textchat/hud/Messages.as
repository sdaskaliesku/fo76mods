 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public dynamic class Messages extends BSUIComponent
   {
      
      private static var MAX_SHOWN:uint = // method body index: 2936 method index: 2936
      4;
      
      private static var THROTTLE_DURATION:uint = // method body index: 2936 method index: 2936
      5 * 1000;
       
      
      public var MessageArray:Vector.<HUDMessageItemData>;
      
      public var ShownMessageArray:Vector.<HUDMessageItemBase>;
      
      private var MessageSpacing:int = -2;
      
      private var bAnimating:Boolean;
      
      private var ySpacing:Number;
      
      private var bqueuedMessage:Boolean = false;
      
      private var fadingOutMessage:Boolean = false;
      
      private var lastTime:Number = 0;
      
      private var bPauseUpdates:Boolean = false;
      
      private var _maxClipHeight:Number = 160;
      
      private var MessagePayload:UIDataFromClient = null;
      
      private var NotificationPayload:UIDataFromClient = null;
      
      private var ThrottledMessages:Vector.<Object>;
      
      public function Messages()
      {

         super();
         var processEvent:Function = function(param1:Object, param2:Function):// method body index: 2937 method index: 2937
         *
         {

            var _loc3_:* = undefined;
            var _loc4_:* = param1.events;
            var _loc5_:* = _loc4_.length;
            var _loc6_:* = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_ = _loc4_[_loc6_];
               param2(_loc3_);
               _loc6_++;
            }
         };
         this.MessageArray = new Vector.<HUDMessageItemData>();
         this.ShownMessageArray = new Vector.<HUDMessageItemBase>();
         this.ThrottledMessages = new Vector.<Object>();
         this.bAnimating = false;
         this.alpha = 1;
         this.MessagePayload = BSUIDataManager.GetDataFromClient("HUDMessageProvider");
         BSUIDataManager.Subscribe("MessageEvents",function(param1:FromClientDataEvent):// method body index: 2939 method index: 2939
         *
         {

            var arEvent:FromClientDataEvent = param1;
            var messages:* = MessagePayload.data.messages;
            processEvent(arEvent.data,function(param1:Object):// method body index: 2938 method index: 2938
            *
            {

               var _loc2_:* = undefined;
               var _loc3_:* = undefined;
               var _loc4_:Boolean = false;
               var _loc5_:* = undefined;
               var _loc6_:* = undefined;
               var _loc7_:* = param1.eventIndex;
               switch(param1.eventType)
               {
                  case "new":
                     _loc2_ = MessagePayload.data.messages[_loc7_];
                     _loc3_ = false;
                     if(_loc2_.canBeThrottled)
                     {
                        _loc6_ = 0;
                        while(_loc6_ < ThrottledMessages.length)
                        {
                           if(ThrottledMessages[_loc6_].msg == _loc2_.messageText && ThrottledMessages[_loc6_].title == _loc2_.titleText && ThrottledMessages[_loc6_].header == _loc2_.headerText)
                           {
                              _loc3_ = true;
                              break;
                           }
                           _loc6_++;
                        }
                        if(!_loc3_)
                        {
                           ThrottledMessages.push({
                              "msg":_loc2_.messageText,
                              "title":_loc2_.titleText,
                              "header":_loc2_.headerText,
                              "throttledTime":THROTTLE_DURATION
                           });
                        }
                     }
                     _loc4_ = false;
                     _loc5_ = 0;
                     while(_loc5_ < MessageArray.length)
                     {
                        if(MessageArray[_loc5_].messageID == _loc2_.messageId && MessageArray[_loc5_].type == _loc2_.type && MessageArray[_loc5_].data == _loc2_)
                        {
                           _loc4_ = true;
                           break;
                        }
                        _loc5_++;
                     }
                     if(!_loc3_ && !_loc4_)
                     {
                        MessageArray.push(new HUDMessageItemData(_loc2_.messageId,_loc2_.type,_loc2_,_loc2_.sound));
                     }
                     else
                     {
                        DiscardMessage(_loc2_.messageId);
                     }
                     break;
                  case "remove":
                     _loc2_ = MessagePayload.data.messages[_loc7_];
                     DiscardMessage(_loc2_.messageId);
                     break;
                  case "clear":
                     RemoveMessages(false);
               }
            });
         });
         this.lastTime = getTimer();
         addEventListener(Event.ENTER_FRAME,this.Update);
      }
      
      public function get maxClipHeight_Inspectable() : Number
      {

         return this._maxClipHeight;
      }
      
      public function set maxClipHeight_Inspectable(param1:Number) : void
      {

         this._maxClipHeight = param1;
      }
      
      public function set TutorialShowing(param1:Boolean) : *
      {

         if(this.bPauseUpdates && !param1)
         {
            this.lastTime = getTimer();
         }
         this.bPauseUpdates = param1;
         this.visible = !param1;
      }
      
      public function get ShownCount() : int
      {

         return this.ShownMessageArray.length;
      }
      
      public function UpdatePositions() : *
      {

         var _loc1_:HUDFadingListItem = null;
         var _loc2_:* = undefined;
         var _loc3_:HUDMessageItemBase = null;
         var _loc4_:HUDMessageItemBase = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:* = undefined;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:int = this.ShownCount;
         if(_loc13_ == 1)
         {
            _loc1_ = this.ShownMessageArray[0];
            if(!_loc1_.fadeInStarted)
            {
               if(_loc1_.CanFadeIn())
               {
                  _loc1_.FadeIn();
               }
               this.bAnimating = true;
               this.fadingOutMessage = false;
            }
            else if(this.MessageArray.length == 0 && !this.fadingOutMessage && _loc1_.CanFadeOut())
            {
               _loc1_.FadeOut();
               this.bAnimating = false;
               this.fadingOutMessage = true;
            }
            else
            {
               this.bAnimating = false;
               this.fadingOutMessage = false;
            }
         }
         else if(_loc13_ > 1)
         {
            _loc2_ = _loc13_ - 1;
            _loc3_ = this.ShownMessageArray[_loc2_];
            _loc4_ = this.ShownMessageArray[_loc2_ - 1];
            _loc5_ = _loc3_.height;
            _loc6_ = _loc4_.y;
            _loc7_ = _loc5_ + this.MessageSpacing;
            _loc8_ = _loc7_ - _loc6_;
            this.bAnimating = _loc8_ > 0 || _loc3_.bIsDirty;
            if(!_loc3_.bIsDirty)
            {
               _loc9_ = _loc3_.CanFadeIn() && height + _loc3_.height + this.MessageSpacing < this._maxClipHeight;
               if(_loc9_)
               {
                  _loc3_.FadeIn();
               }
               if(this.bAnimating && _loc3_.fadeInStarted)
               {
                  _loc10_ = 1;
                  _loc11_ = 0;
                  while(_loc11_ < _loc2_)
                  {
                     this.ShownMessageArray[_loc11_].y = this.ShownMessageArray[_loc11_].y + _loc10_;
                     _loc11_++;
                  }
               }
               else if(!this.fadingOutMessage)
               {
                  _loc12_ = !_loc9_ && _loc3_.CanFadeIn();
                  if(!this.bqueuedMessage || _loc13_ == MAX_SHOWN || _loc12_ && this.ShownMessageArray[0].CanFadeOut())
                  {
                     this.fadingOutMessage = true;
                     this.ShownMessageArray[0].FadeOut();
                  }
               }
            }
         }
      }
      
      public function RemoveMessages(param1:Boolean) : *
      {

         var _loc2_:Vector.<HUDMessageItemBase> = null;
         var _loc3_:int = this.ShownMessageArray.length - 1;
         while(_loc3_ >= 0)
         {
            if(!param1 || this.ShownMessageArray[_loc3_].currentFrame >= this.ShownMessageArray[_loc3_].endAnimFrame)
            {
               _loc2_ = this.ShownMessageArray.splice(_loc3_,1);
               this.removeChild(_loc2_[0]);
               this.fadingOutMessage = false;
               this.DiscardMessage(_loc2_[0].data.messageID);
            }
            _loc3_--;
         }
      }
      
      private function DiscardMessage(param1:Number) : *
      {

         BSUIDataManager.dispatchEvent(new CustomEvent("HUDMessages::DiscardMessage",{"id":param1}));
      }
      
      public function get CanAddMessage() : Boolean
      {

         return !this.bAnimating && !this.fadingOutMessage && this.ShownCount < MAX_SHOWN;
      }
      
      public function Update(param1:Event) : *
      {

         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = undefined;
         var _loc8_:HUDMessageItemData = null;
         var _loc9_:HUDMessageItemBase = null;
         if(!this.bPauseUpdates)
         {
            _loc2_ = getTimer();
            _loc3_ = _loc2_ - this.lastTime;
            _loc4_ = this.ThrottledMessages.length;
            if(_loc4_ > 0)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  this.ThrottledMessages[_loc7_].throttledTime = this.ThrottledMessages[_loc7_].throttledTime - _loc3_;
                  _loc7_++;
               }
               while(_loc4_ > 0 && this.ThrottledMessages[0].throttledTime <= 0)
               {
                  this.ThrottledMessages.shift();
                  _loc4_--;
               }
            }
            this.bqueuedMessage = this.MessageArray.length > 0;
            _loc5_ = this.ShownCount > 0;
            this.RemoveMessages(true);
            if(this.bqueuedMessage && this.CanAddMessage)
            {
               _loc8_ = this.MessageArray.shift();
               switch(_loc8_.type)
               {
                  case HUDMessageItemData.TYPE_EVENT:
                     _loc9_ = new HUDMessageItemBox();
                     break;
                  case HUDMessageItemData.TYPE_KILL_SINGLE:
                     _loc9_ = new HUDMessageItemKill();
                     break;
                  case HUDMessageItemData.TYPE_KILL_TEAM:
                     _loc9_ = new HUDMessageItemTeamKill();
                     break;
                  case HUDMessageItemData.TYPE_UNDER_ATTACK:
                     _loc9_ = new HUDMessageItemUnderAttack();
                     break;
                  case HUDMessageItemData.TYPE_COMEBACK:
                     _loc9_ = new HUDMessageItemRevenge();
                     break;
                  case HUDMessageItemData.TYPE_KILL_GROUP:
                     _loc9_ = new HUDMessageItemGroupKill();
                     break;
                  default:
                     _loc9_ = new HUDMessageItem();
               }
               _loc9_.data = _loc8_;
               this.addChild(_loc9_);
               this.ShownMessageArray.push(_loc9_ as HUDMessageItemBase);
               BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":_loc9_.data.sound}));
            }
            this.UpdatePositions();
            _loc6_ = this.ShownCount > 0;
            if(_loc5_ || _loc6_)
            {
               SetIsDirty();
            }
            this.lastTime = _loc2_;
         }
      }
   }
}
