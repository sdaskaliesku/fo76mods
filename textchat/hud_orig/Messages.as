 
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
      
      private static var MAX_SHOWN:uint = // method body index: 2985 method index: 2985
      4;
      
      private static var THROTTLE_DURATION:uint = // method body index: 2985 method index: 2985
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
         // method body index: 2991 method index: 2991
         super();
         var processEvent:Function = function(data:Object, cb:Function):// method body index: 2988 method index: 2988
         *
         {
            // method body index: 2988 method index: 2988
            var event:* = undefined;
            var events:* = data.events;
            var numEvents:* = events.length;
            for(var eventIndex:* = 0; eventIndex < numEvents; eventIndex++)
            {
               event = events[eventIndex];
               cb(event);
            }
         };
         this.MessageArray = new Vector.<HUDMessageItemData>();
         this.ShownMessageArray = new Vector.<HUDMessageItemBase>();
         this.ThrottledMessages = new Vector.<Object>();
         this.bAnimating = false;
         this.alpha = 1;
         this.MessagePayload = BSUIDataManager.GetDataFromClient("HUDMessageProvider");
         BSUIDataManager.Subscribe("MessageEvents",function(arEvent:FromClientDataEvent):// method body index: 2990 method index: 2990
         *
         {
            // method body index: 2990 method index: 2990
            var messages:* = MessagePayload.data.messages;
            processEvent(arEvent.data,function(messageEvent:Object):// method body index: 2989 method index: 2989
            *
            {
               // method body index: 2989 method index: 2989
               var msg:* = undefined;
               var isThrottled:* = undefined;
               var alreadyShow:Boolean = false;
               var index:* = undefined;
               var throttleIndex:* = undefined;
               var msgIndex:* = messageEvent.eventIndex;
               switch(messageEvent.eventType)
               {
                  case "new":
                     msg = MessagePayload.data.messages[msgIndex];
                     isThrottled = false;
                     if(msg.canBeThrottled)
                     {
                        for(throttleIndex = 0; throttleIndex < ThrottledMessages.length; throttleIndex++)
                        {
                           if(ThrottledMessages[throttleIndex].msg == msg.messageText && ThrottledMessages[throttleIndex].title == msg.titleText && ThrottledMessages[throttleIndex].header == msg.headerText)
                           {
                              isThrottled = true;
                              break;
                           }
                        }
                        if(!isThrottled)
                        {
                           ThrottledMessages.push({
                              "msg":msg.messageText,
                              "title":msg.titleText,
                              "header":msg.headerText,
                              "throttledTime":THROTTLE_DURATION
                           });
                        }
                     }
                     alreadyShow = false;
                     for(index = 0; index < MessageArray.length; index++)
                     {
                        if(MessageArray[index].messageID == msg.messageId && MessageArray[index].type == msg.type && MessageArray[index].data == msg)
                        {
                           alreadyShow = true;
                           break;
                        }
                     }
                     if(!isThrottled && !alreadyShow)
                     {
                        MessageArray.push(new HUDMessageItemData(msg.messageId,msg.type,msg,msg.sound));
                     }
                     else
                     {
                        DiscardMessage(msg.messageId);
                     }
                     break;
                  case "remove":
                     msg = MessagePayload.data.messages[msgIndex];
                     DiscardMessage(msg.messageId);
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
         // method body index: 2986 method index: 2986
         return this._maxClipHeight;
      }
      
      public function set maxClipHeight_Inspectable(aMaxClipHeight:Number) : void
      {
         // method body index: 2987 method index: 2987
         this._maxClipHeight = aMaxClipHeight;
      }
      
      public function set TutorialShowing(aShowing:Boolean) : *
      {
         // method body index: 2992 method index: 2992
         if(this.bPauseUpdates && !aShowing)
         {
            this.lastTime = getTimer();
         }
         this.bPauseUpdates = aShowing;
         this.visible = !aShowing;
      }
      
      public function get ShownCount() : int
      {
         // method body index: 2993 method index: 2993
         return this.ShownMessageArray.length;
      }
      
      public function UpdatePositions() : *
      {
         // method body index: 2994 method index: 2994
         var onlyMessage:HUDFadingListItem = null;
         var topClipIndex:* = undefined;
         var topMessage:HUDMessageItemBase = null;
         var secondMessage:HUDMessageItemBase = null;
         var BottomOfTopMessage:uint = 0;
         var topOfSecondMessage:uint = 0;
         var topOfSecondMessageTarget:int = 0;
         var DeltaSpacing:int = 0;
         var canFadeIn:Boolean = false;
         var amountToDip:* = undefined;
         var i:Number = NaN;
         var needMoreSpace:Boolean = false;
         var numClips:int = this.ShownCount;
         if(numClips == 1)
         {
            onlyMessage = this.ShownMessageArray[0];
            if(!onlyMessage.fadeInStarted)
            {
               if(onlyMessage.CanFadeIn())
               {
                  onlyMessage.FadeIn();
               }
               this.bAnimating = true;
               this.fadingOutMessage = false;
            }
            else if(this.MessageArray.length == 0 && !this.fadingOutMessage && onlyMessage.CanFadeOut())
            {
               onlyMessage.FadeOut();
               this.bAnimating = false;
               this.fadingOutMessage = true;
            }
            else
            {
               this.bAnimating = false;
               this.fadingOutMessage = false;
            }
         }
         else if(numClips > 1)
         {
            topClipIndex = numClips - 1;
            topMessage = this.ShownMessageArray[topClipIndex];
            secondMessage = this.ShownMessageArray[topClipIndex - 1];
            BottomOfTopMessage = topMessage.height;
            topOfSecondMessage = secondMessage.y;
            topOfSecondMessageTarget = BottomOfTopMessage + this.MessageSpacing;
            DeltaSpacing = topOfSecondMessageTarget - topOfSecondMessage;
            this.bAnimating = DeltaSpacing > 0 || topMessage.bIsDirty;
            if(!topMessage.bIsDirty)
            {
               canFadeIn = topMessage.CanFadeIn() && height + topMessage.height + this.MessageSpacing < this._maxClipHeight;
               if(canFadeIn)
               {
                  topMessage.FadeIn();
               }
               if(this.bAnimating && topMessage.fadeInStarted)
               {
                  amountToDip = 1;
                  for(i = 0; i < topClipIndex; i++)
                  {
                     this.ShownMessageArray[i].y = this.ShownMessageArray[i].y + amountToDip;
                  }
               }
               else if(!this.fadingOutMessage)
               {
                  needMoreSpace = !canFadeIn && topMessage.CanFadeIn();
                  if(!this.bqueuedMessage || numClips == MAX_SHOWN || needMoreSpace && this.ShownMessageArray[0].CanFadeOut())
                  {
                     this.fadingOutMessage = true;
                     this.ShownMessageArray[0].FadeOut();
                  }
               }
            }
         }
      }
      
      public function RemoveMessages(abConditional:Boolean) : *
      {
         // method body index: 2995 method index: 2995
         var removedMessageArray:Vector.<HUDMessageItemBase> = null;
         for(var i:int = this.ShownMessageArray.length - 1; i >= 0; i--)
         {
            if(!abConditional || this.ShownMessageArray[i].currentFrame >= this.ShownMessageArray[i].endAnimFrame)
            {
               removedMessageArray = this.ShownMessageArray.splice(i,1);
               this.removeChild(removedMessageArray[0]);
               this.fadingOutMessage = false;
               this.DiscardMessage(removedMessageArray[0].data.messageID);
            }
         }
      }
      
      private function DiscardMessage(messageId:Number) : *
      {
         // method body index: 2996 method index: 2996
         BSUIDataManager.dispatchEvent(new CustomEvent("HUDMessages::DiscardMessage",{"id":messageId}));
      }
      
      public function get CanAddMessage() : Boolean
      {
         // method body index: 2997 method index: 2997
         return !this.bAnimating && !this.fadingOutMessage && this.ShownCount < MAX_SHOWN;
      }
      
      public function Update(e:Event) : *
      {
         // method body index: 2998 method index: 2998
         var frameTime:* = undefined;
         var deltaTime:* = undefined;
         var numThrottled:* = undefined;
         var showingAtStart:* = false;
         var showingAtEnd:* = false;
         var throttleIndex:* = undefined;
         var itemData:HUDMessageItemData = null;
         var messageItem:HUDMessageItemBase = null;
         if(!this.bPauseUpdates)
         {
            frameTime = getTimer();
            deltaTime = frameTime - this.lastTime;
            numThrottled = this.ThrottledMessages.length;
            if(numThrottled > 0)
            {
               for(throttleIndex = 0; throttleIndex < numThrottled; throttleIndex++)
               {
                  this.ThrottledMessages[throttleIndex].throttledTime = this.ThrottledMessages[throttleIndex].throttledTime - deltaTime;
               }
               while(numThrottled > 0 && this.ThrottledMessages[0].throttledTime <= 0)
               {
                  this.ThrottledMessages.shift();
                  numThrottled--;
               }
            }
            this.bqueuedMessage = this.MessageArray.length > 0;
            showingAtStart = this.ShownCount > 0;
            this.RemoveMessages(true);
            if(this.bqueuedMessage && this.CanAddMessage)
            {
               itemData = this.MessageArray.shift();
               switch(itemData.type)
               {
                  case HUDMessageItemData.TYPE_EVENT:
                     messageItem = new HUDMessageItemBox();
                     break;
                  case HUDMessageItemData.TYPE_KILL_SINGLE:
                     messageItem = new HUDMessageItemKill();
                     break;
                  case HUDMessageItemData.TYPE_KILL_TEAM:
                     messageItem = new HUDMessageItemTeamKill();
                     break;
                  case HUDMessageItemData.TYPE_UNDER_ATTACK:
                     messageItem = new HUDMessageItemUnderAttack();
                     break;
                  case HUDMessageItemData.TYPE_COMEBACK:
                     messageItem = new HUDMessageItemRevenge();
                     break;
                  case HUDMessageItemData.TYPE_KILL_GROUP:
                     messageItem = new HUDMessageItemGroupKill();
                     break;
                  default:
                     messageItem = new HUDMessageItem();
               }
               messageItem.data = itemData;
               this.addChild(messageItem);
               this.ShownMessageArray.push(messageItem as HUDMessageItemBase);
               BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":messageItem.data.sound}));
            }
            this.UpdatePositions();
            showingAtEnd = this.ShownCount > 0;
            if(showingAtStart || showingAtEnd)
            {
               SetIsDirty();
            }
            this.lastTime = frameTime;
         }
      }
   }
}
