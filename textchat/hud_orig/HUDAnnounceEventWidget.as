 
package
{
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.VaultBoyImageLoader;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDAnnounceEventWidget extends MovieClip
   {
      
      private static const LOC_DISCOVERED_ANIM_TIME_OFFSET = // method body index: 895 method index: 895
      2800;
      
      public static const EVENT_CONSUME:String = // method body index: 895 method index: 895
      "HUD::DiscardFanfare";
      
      public static const EVENT_CLEAR_COMPLETION_REWARD_FLAG:String = // method body index: 895 method index: 895
      "HUD::ClearCompletionRewardsFlag";
      
      public static const EVENT_UPDATEMODEL:String = // method body index: 895 method index: 895
      "HUD::UpdateInventory3DModel";
      
      public static const EVENT_PLAYITEMSOUND:String = // method body index: 895 method index: 895
      "HUD::PlaySoundForItem";
      
      public static const EVENT_CURRENCYREWARD:String = // method body index: 895 method index: 895
      "HUD::ShowCurrencyReward";
      
      public static const EVENT_XPREWARD:String = // method body index: 895 method index: 895
      "HUD::ShowXPReward";
      
      public static const EVENT_LISTENFORACCEPT:String = // method body index: 895 method index: 895
      "HUD::ListenForQuestAccept";
      
      public static const EVENT_ACCEPT:String = // method body index: 895 method index: 895
      "HUD::AcceptFanfare";
      
      public static const EVENT_LOC_BUSY:String = // method body index: 895 method index: 895
      "HUD::LocationBusy";
      
      public static const EVENT_CLEARED:String = // method body index: 895 method index: 895
      "HUDAnnounceEvent::Cleared";
      
      public static const EVENT_ACTIVE:String = // method body index: 895 method index: 895
      "HUDAnnounceEvent::Active";
      
      public static const FANFARE_TYPE_QUESTCOMPLETE:uint = // method body index: 895 method index: 895
      0;
      
      public static const FANFARE_TYPE_QUESTFAILED:uint = // method body index: 895 method index: 895
      1;
      
      public static const FANFARE_TYPE_ITEMREWARD:uint = // method body index: 895 method index: 895
      2;
      
      public static const FANFARE_TYPE_QUESTAVAILABLE:uint = // method body index: 895 method index: 895
      3;
      
      public static const FANFARE_TYPE_QUESTACTIVE:uint = // method body index: 895 method index: 895
      4;
      
      public static const FANFARE_TYPE_FEATUREDITEM:uint = // method body index: 895 method index: 895
      5;
      
      public static const FANFARE_TYPE_LOCATIONDISCOVERED:uint = // method body index: 895 method index: 895
      6;
      
      public static const FANFARE_TYPE_MESSAGETEXT:uint = // method body index: 895 method index: 895
      7;
      
      public static const FANFARE_TYPE_QUICKPLAYANNOUNCE:uint = // method body index: 895 method index: 895
      8;
      
      public static const FANFARE_TYPE_COUNT:uint = // method body index: 895 method index: 895
      9;
      
      private static const MAX_QUEST_REWARDS:uint = // method body index: 895 method index: 895
      6;
      
      private static const COMPLETION_TO_REWARDS_FADE_TIME_MS = // method body index: 895 method index: 895
      1000;
       
      
      public var UniqueItemContainer_mc:MovieClip;
      
      public var QuestRewardContainer_mc:MovieClip;
      
      public var QuestCompleteContainer_mc:MovieClip;
      
      public var AnnounceAvailableQuest_mc:MovieClip;
      
      public var AnnounceActiveQuest_mc:MovieClip;
      
      public var AnnounceLocationDiscovered_mc:MovieClip;
      
      public var AnnounceMessage_mc:MovieClip;
      
      private var m_ProcessedEventIDList:Array;
      
      private var m_IsBusy:Boolean = false;
      
      private var m_EventData:UIDataFromClient;
      
      private var m_CurEvent:Object;
      
      private var m_Active:Boolean = true;
      
      private var m_IsValidHudMode:Boolean = true;
      
      private var m_Enabled:Boolean = true;
      
      private var m_CurTimeout:int = -1;
      
      private var m_CurClip:MovieClip;
      
      private var m_ValidHudModes:Array;
      
      private var m_LocationBusy:Boolean = false;
      
      private var m_LocationDiscoverAnimTime:Number = 5500;
      
      private var m_IsAnimating:Boolean = true;
      
      private var m_AcceptButtonHint:BSButtonHintData;
      
      public function HUDAnnounceEventWidget()
      {

         this.m_ProcessedEventIDList = new Array();
         this.m_AcceptButtonHint = new BSButtonHintData("$RESET","T","PSN_Y","Xenon_Y",1,null);
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.m_LocationDiscoverAnimTime = this.AnnounceLocationDiscovered_mc.totalFrames * 1000 / stage.frameRate - LOC_DISCOVERED_ANIM_TIME_OFFSET;
      }
      
      private function updateIsAnimating() : void
      {

         var isAnimating:Boolean = this.m_IsBusy && this.m_Active;
         if(this.m_IsAnimating != isAnimating)
         {
            this.m_IsAnimating = isAnimating;
            if(this.m_IsAnimating)
            {
               dispatchEvent(new Event(EVENT_ACTIVE,true));
            }
            else
            {
               dispatchEvent(new Event(EVENT_CLEARED,true));
            }
         }
      }
      
      public function set isBusy(aBusy:Boolean) : void
      {

         if(aBusy != this.m_IsBusy)
         {
            this.m_IsBusy = aBusy;
            this.updateIsAnimating();
         }
      }
      
      public function set active(aActive:Boolean) : void
      {

         var eventArray:Array = null;
         var eventsLen:uint = 0;
         var event:Object = null;
         var i:uint = 0;
         if(aActive != this.m_Active)
         {
            this.m_Active = aActive;
            this.updateIsAnimating();
            if(!this.m_Active)
            {
               if(this.m_CurTimeout != -1)
               {
                  clearTimeout(this.m_CurTimeout);
                  this.m_CurTimeout = -1;
               }
               this.QuestCompleteContainer_mc.gotoAndStop("off");
               this.QuestRewardContainer_mc.gotoAndStop("off");
               this.UniqueItemContainer_mc.gotoAndStop("off");
               this.AnnounceAvailableQuest_mc.gotoAndStop("off");
               this.AnnounceActiveQuest_mc.gotoAndStop("off");
               this.AnnounceMessage_mc.gotoAndStop("off");
               this.onClearModel(null);
               if(this.m_CurEvent && this.m_CurEvent.markedAsDisplay && this.m_CurEvent.isCompletionRewards && this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE)
               {
                  eventArray = this.m_EventData.data.fanfareEvents;
                  eventsLen = eventArray.length;
                  for(i = 0; i < eventsLen; i++)
                  {
                     event = eventArray[i];
                     if(event.questInstanceId == this.m_CurEvent.questInstanceId && event.fanfareEventType == FANFARE_TYPE_ITEMREWARD)
                     {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CLEAR_COMPLETION_REWARD_FLAG,{"fanfareEventID":event.fanfareEventID}));
                     }
                  }
               }
               this.m_CurEvent = null;
               this.m_CurClip = null;
               this.onAnimEnd(false);
            }
         }
      }
      
      private function updateEnabled() : void
      {

         this.active = this.m_Enabled && this.m_IsValidHudMode;
      }
      
      private function onDataUpdate(arEvent:FromClientDataEvent) : void
      {

         this.m_ProcessedEventIDList = new Array();
         this.m_Enabled = arEvent.data.isFanfareEnabled;
         this.updateEnabled();
         this.evaluateQueue();
      }
      
      private function isValidFanfareQuest(aQuestID:String) : Boolean
      {

         var curQuest:Object = null;
         var oIndex:uint = 0;
         var questList:Array = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
         var qIndex:uint = 0;
         while(questList != null && qIndex < questList.length)
         {
            curQuest = questList[qIndex];
            if(curQuest.questID == aQuestID)
            {
               oIndex = 0;
               while(curQuest.objectives != null && oIndex < curQuest.objectives.length)
               {
                  if(curQuest.objectives[oIndex].isDisplayed)
                  {
                     return true;
                  }
                  oIndex++;
               }
            }
            qIndex++;
         }
         return false;
      }
      
      private function evaluateQueue(abContinuationAnim:Boolean = false) : void
      {

         var startedNewAnimation:Boolean = false;
         var onlyShowCompletionRewards:Boolean = false;
         var fanfareEvent:Object = null;
         var isEventProcessed:Boolean = false;
         var canStartNewAnimation:Boolean = false;
         if(this.m_Active && this.m_EventData.data.fanfareEvents != null)
         {
            startedNewAnimation = false;
            onlyShowCompletionRewards = this.m_CurEvent && this.m_CurEvent.isCompletionRewards && this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE;
            for each(fanfareEvent in this.m_EventData.data.fanfareEvents)
            {
               if(this.m_ProcessedEventIDList.indexOf(fanfareEvent.fanfareEventID) == -1)
               {
                  isEventProcessed = false;
                  canStartNewAnimation = !startedNewAnimation && (!this.m_IsBusy || abContinuationAnim);
                  canStartNewAnimation = canStartNewAnimation && (!onlyShowCompletionRewards || fanfareEvent.isCompletionRewards && fanfareEvent.fanfareEventType == FANFARE_TYPE_ITEMREWARD && fanfareEvent.questInstanceId == this.m_CurEvent.questInstanceId);
                  switch(fanfareEvent.fanfareEventType)
                  {
                     case FANFARE_TYPE_LOCATIONDISCOVERED:
                        if(!this.m_LocationBusy)
                        {
                           this.animateLocationDiscovered(fanfareEvent);
                           isEventProcessed = true;
                        }
                        break;
                     case FANFARE_TYPE_QUESTAVAILABLE:
                     case FANFARE_TYPE_QUESTACTIVE:
                        if(canStartNewAnimation && this.isValidFanfareQuest(fanfareEvent.questInstanceId))
                        {
                           startedNewAnimation = this.animateEvent(fanfareEvent);
                           isEventProcessed = startedNewAnimation;
                        }
                        else if(this.m_CurEvent && this.m_CurEvent.questInstanceId == fanfareEvent.questInstanceId)
                        {
                           if(this.m_CurClip == this.AnnounceAvailableQuest_mc)
                           {
                              this.AnnounceAvailableQuest_mc.Desc_mc.Desc_tf.text = fanfareEvent.shortDescription;
                           }
                           else if(this.m_CurClip == this.AnnounceActiveQuest_mc)
                           {
                              this.AnnounceActiveQuest_mc.Desc_mc.Desc_tf.text = fanfareEvent.shortDescription;
                           }
                           isEventProcessed = true;
                        }
                        break;
                     case FANFARE_TYPE_QUICKPLAYANNOUNCE:
                     case FANFARE_TYPE_QUESTCOMPLETE:
                     case FANFARE_TYPE_QUESTFAILED:
                     case FANFARE_TYPE_ITEMREWARD:
                     case FANFARE_TYPE_FEATUREDITEM:
                     case FANFARE_TYPE_MESSAGETEXT:
                        if(canStartNewAnimation)
                        {
                           startedNewAnimation = this.animateEvent(fanfareEvent);
                           isEventProcessed = startedNewAnimation;
                        }
                  }
                  if(isEventProcessed)
                  {
                     this.m_ProcessedEventIDList.push(fanfareEvent.fanfareEventID);
                  }
               }
            }
            if(abContinuationAnim)
            {
               this.isBusy = startedNewAnimation;
            }
            else
            {
               this.isBusy = this.m_IsBusy || startedNewAnimation;
            }
         }
      }
      
      private function getEventTypeData(aType:uint) : Object
      {

         return aType < FANFARE_TYPE_COUNT?this.m_EventData.data.fanfareTypes[aType]:null;
      }
      
      private function animateLocationDiscovered(discoverEvent:Object) : void
      {

         this.m_LocationBusy = true;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LOC_BUSY,{"isLocationBusy":true}));
         this.AnnounceLocationDiscovered_mc.Area_mc.Area_tf.text = discoverEvent.locationName;
         this.AnnounceLocationDiscovered_mc.gotoAndPlay("rollOn");
         if(discoverEvent.soundName && discoverEvent.soundName.length > 0)
         {
            GlobalFunc.PlayMenuSound(discoverEvent.soundName);
         }
         var titleTF:TextField = this.AnnounceLocationDiscovered_mc.Title_mc.Title_tf;
         if(discoverEvent.isRegion)
         {
            GlobalFunc.PlayMenuSound("UIDiscoverRegion");
            titleTF.text = "$DiscoveredRegion";
         }
         else
         {
            GlobalFunc.PlayMenuSound("UIDiscoverLocation");
            titleTF.text = "$Discovered";
         }
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":discoverEvent.fanfareEventID}));
         setTimeout(function():// method body index: 904 method index: 904
         *
         {

            m_LocationBusy = false;
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LOC_BUSY,{"isLocationBusy":false}));
            evaluateQueue();
         },this.m_LocationDiscoverAnimTime);
      }
      
      private function IsSimpleType(aType:String) : Boolean
      {

         return aType == "int" || aType == "uint" || aType == "Number" || aType == "String" || aType == "Boolean";
      }
      
      private function CloneKey(key:String, aClone:*, aOriginal:*) : void
      {

         var type:String = getQualifiedClassName(aOriginal[key]);
         if(type == "Object")
         {
            aClone[key] = this.CloneObjectData(aOriginal[key]);
         }
         else if(type == "Array")
         {
            aClone[key] = this.CloneArrayData(aOriginal[key]);
         }
         else
         {
            GlobalFunc.BSASSERT(this.IsSimpleType(type),"Can\'t clone non-basic types. Trying to clone a " + type);
            aClone[key] = aOriginal[key];
         }
      }
      
      private function CloneArrayData(aArray:Array) : Array
      {

         var clone:Array = new Array();
         for(var i:uint = 0; i < aArray.length; i++)
         {
            this.CloneKey(i.toString(),clone,aArray);
         }
         return clone;
      }
      
      private function CloneObjectData(aData:Object) : Object
      {

         var key:* = undefined;
         var cloneData:Object = new Object();
         for(key in aData)
         {
            this.CloneKey(key,cloneData,aData);
         }
         return cloneData;
      }
      
      private function animateEvent(aEvent:Object) : Boolean
      {

         var eventClip:MovieClip = null;
         var vaultBoyImage:VaultBoyImageLoader = null;
         var description:String = null;
         var fanfareTitle:String = null;
         var editorNewlinePattern:RegExp = null;
         var parsedDesc:String = null;
         var rewardIndex:int = 0;
         var tooManyRewards:Boolean = false;
         var reward:* = undefined;
         var nameText:String = null;
         this.m_CurEvent = this.CloneObjectData(aEvent);
         var eventTypeData:Object = this.getEventTypeData(aEvent.fanfareEventType);
         GlobalFunc.BSASSERT(eventTypeData != null,"Event type data is null.");
         var startedAnim:Boolean = false;
         switch(this.m_CurEvent.fanfareEventType)
         {
            case FANFARE_TYPE_QUESTCOMPLETE:
            case FANFARE_TYPE_QUESTFAILED:
               eventClip = this.QuestCompleteContainer_mc;
               fanfareTitle = !!this.m_CurEvent.isEvent?"$$EVENT":"$$QUEST";
               if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTFAILED)
               {
                  fanfareTitle = fanfareTitle + "FAILED";
                  GlobalFunc.PlayMenuSound("UIEventFail");
               }
               else
               {
                  fanfareTitle = fanfareTitle + "COMPLETED";
                  if(this.m_CurEvent.isEvent)
                  {
                     GlobalFunc.PlayMenuSound("UIEventComplete");
                  }
                  else
                  {
                     GlobalFunc.PlayMenuSound("UIQuestComplete");
                  }
               }
               description = this.m_CurEvent.shortDescription;
               if(description != null && description.length > 0)
               {
                  this.m_CurEvent.useDescAnim = true;
               }
               eventClip.FanfareType_mc.FanfareType_tf.text = this.m_CurEvent.sharedPlayerPrefix + fanfareTitle;
               eventClip.FanfareName_mc.FanfareName_tf.text = this.m_CurEvent.questTitle;
               vaultBoyImage = eventClip.FanfareQuestCompleted_mc.QuestAnimCatcher_mc.ClipContainer_mc;
               eventClip.FanfareDescription_mc.FanfareDescription_tf.text = !!this.m_CurEvent.useDescAnim?description:"";
               vaultBoyImage.ClipAlignment_Inspectable = "Center";
               vaultBoyImage.SWFLoad(this.m_CurEvent.swfName);
               break;
            case FANFARE_TYPE_ITEMREWARD:
               if(this.m_CurEvent.rewardsA.length > 0)
               {
                  eventClip = this.QuestRewardContainer_mc;
                  eventClip.FanfareType_mc.FanfareType_tf.text = "$$ITEMREWARD";
                  eventClip.FanfareType_mc.FanfareType_tf.text = this.m_CurEvent.sharedPlayerPrefix + eventClip.FanfareType_mc.FanfareType_tf.text;
                  rewardIndex = 1;
                  tooManyRewards = this.m_CurEvent.rewardsA.length > MAX_QUEST_REWARDS;
                  for each(reward in this.m_CurEvent.rewardsA)
                  {
                     if(tooManyRewards && rewardIndex == MAX_QUEST_REWARDS)
                     {
                        nameText = "...";
                     }
                     else
                     {
                        nameText = reward.strRewardName;
                        if(reward.uRewardCount > 1)
                        {
                           nameText = "(" + reward.uRewardCount + ") " + nameText;
                        }
                     }
                     eventClip["FanfareName_mc" + rewardIndex].FanfareName_tf.text = nameText;
                     eventClip["FanfareName_mc" + rewardIndex].visible = true;
                     rewardIndex++;
                     if(rewardIndex > MAX_QUEST_REWARDS)
                     {
                        break;
                     }
                  }
                  while(rewardIndex <= MAX_QUEST_REWARDS)
                  {
                     eventClip["FanfareName_mc" + rewardIndex].visible = false;
                     rewardIndex++;
                  }
                  GlobalFunc.PlayMenuSound("UIQuestCompleteRewardItem");
               }
               else if(!this.m_CurEvent.isCompletionRewards)
               {
                  this.DisplaySimpleRewards(this.m_CurEvent);
               }
               break;
            case FANFARE_TYPE_FEATUREDITEM:
               eventClip = this.UniqueItemContainer_mc;
               eventClip.FanfareName_mc.FanfareName_tf.text = this.m_CurEvent.featuredItem;
               editorNewlinePattern = /\r\n/g;
               parsedDesc = this.m_CurEvent.shortDescription.replace(editorNewlinePattern," \n");
               eventClip.FanfareDescription_mc.FanfareDescription_tf.text = parsedDesc;
               break;
            case FANFARE_TYPE_QUESTAVAILABLE:
               eventClip = this.AnnounceAvailableQuest_mc;
               description = this.m_CurEvent.shortDescription;
               if(description == null || description.length == 0)
               {
                  description = "INVALID DESCRIPTION";
               }
               eventClip.Title_mc.Title_tf.text = "$QUESTAVAILABLE";
               eventClip.Name_mc.Name_tf.text = this.m_CurEvent.questTitle;
               eventClip.Desc_mc.Desc_tf.text = description;
               this.m_AcceptButtonHint.ButtonText = "$ACCEPT";
               this.m_AcceptButtonHint.ButtonVisible = !this.m_CurEvent.hideOptInPrompt;
               break;
            case FANFARE_TYPE_QUESTACTIVE:
               eventClip = this.AnnounceActiveQuest_mc;
               description = this.m_CurEvent.shortDescription;
               if(description == null || description.length == 0)
               {
                  description = "INVALID DESCRIPTION";
               }
               eventClip.Title_mc.Title_tf.text = "$QUESTSTARTED";
               eventClip.Name_mc.Name_tf.text = this.m_CurEvent.questTitle;
               eventClip.Desc_mc.Desc_tf.text = description;
               this.m_AcceptButtonHint.ButtonText = "$TRACK";
               this.m_AcceptButtonHint.ButtonVisible = !this.m_CurEvent.hideOptInPrompt;
               vaultBoyImage = eventClip.QuestVaultBoy_mc;
               vaultBoyImage.ClipAlignment_Inspectable = "Center";
               vaultBoyImage.SWFLoad(this.m_CurEvent.swfName);
               if(this.m_CurEvent.isEvent)
               {
                  GlobalFunc.PlayMenuSound("UIEventStart");
               }
               else
               {
                  GlobalFunc.PlayMenuSound("UIQuestNew");
               }
               break;
            case FANFARE_TYPE_MESSAGETEXT:
               eventClip = this.AnnounceMessage_mc;
               eventClip.Text_mc.Text_tf.text = this.m_CurEvent.messageText;
               break;
            case FANFARE_TYPE_QUICKPLAYANNOUNCE:
               eventClip = this.AnnounceMessage_mc;
               eventClip.Text_mc.Text_tf.text = this.m_CurEvent.messageText;
               if(this.m_CurEvent.soundId != 0)
               {
                  GlobalFunc.PlayMenuSoundWithFormID(this.m_CurEvent.soundId);
               }
         }
         if(eventClip != null && eventTypeData != null)
         {
            startedAnim = true;
            if(this.m_CurEvent.useDescAnim)
            {
               eventClip.gotoAndPlay("rollOnDesc");
            }
            else
            {
               eventClip.gotoAndPlay("rollOn");
            }
            this.m_CurClip = eventClip;
            if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTACTIVE || this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTAVAILABLE)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LISTENFORACCEPT,{
                  "fanfareEventID":this.m_CurEvent.fanfareEventID,
                  "isQuestPending":this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTAVAILABLE
               }));
            }
            this.m_CurTimeout = setTimeout(function():// method body index: 910 method index: 910
            *
            {

               if((m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTACTIVE || m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTAVAILABLE) && m_AcceptButtonHint.holdPercent > 0)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_ACCEPT,{"fanfareEventID":m_CurEvent.fanfareEventID}));
               }
               endFanfare();
            },eventTypeData.showTimer);
         }
         else
         {
            this.m_CurClip = null;
         }
         return startedAnim;
      }
      
      private function DisplaySimpleRewards(aEvent:Object) : void
      {

         var xpReward:Number = NaN;
         this.ShowCurrencyReward(aEvent.currencyID,aEvent.currencyRewarded);
         var xpDelay:Number = 700;
         xpReward = aEvent.xpRewarded;
         setTimeout(function():// method body index: 912 method index: 912
         *
         {

            ShowXPReward(xpReward);
         },xpDelay);
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":aEvent.fanfareEventID}));
      }
      
      private function endFanfare() : void
      {

         var eventTypeData:Object = null;
         var fadeTime:Number = NaN;
         var standardRollOffAnimName:String = null;
         var pairedRewardsFanfare:* = undefined;
         var fanfareEvent:Object = null;
         if(this.m_CurClip != null)
         {
            eventTypeData = this.getEventTypeData(this.m_CurEvent.fanfareEventType);
            GlobalFunc.BSASSERT(eventTypeData != null,"Event type data is null.");
            fadeTime = eventTypeData.gapTimer;
            standardRollOffAnimName = "RollOff";
            if(this.m_CurEvent.isCompletionRewards)
            {
               if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE)
               {
                  pairedRewardsFanfare = null;
                  for each(fanfareEvent in this.m_EventData.data.fanfareEvents)
                  {
                     if(fanfareEvent.isCompletionRewards && fanfareEvent.fanfareEventType == FANFARE_TYPE_ITEMREWARD && fanfareEvent.questInstanceId == this.m_CurEvent.questInstanceId)
                     {
                        pairedRewardsFanfare = fanfareEvent;
                        break;
                     }
                  }
                  if(pairedRewardsFanfare != null && pairedRewardsFanfare.rewardsA.length > 0)
                  {
                     this.m_CurClip.gotoAndPlay("rollOffForRewards");
                     fadeTime = COMPLETION_TO_REWARDS_FADE_TIME_MS;
                  }
                  else
                  {
                     this.m_CurClip.gotoAndPlay(standardRollOffAnimName);
                     this.m_CurEvent.isCompletionRewards = false;
                     this.DisplaySimpleRewards(pairedRewardsFanfare);
                  }
               }
               else if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_ITEMREWARD)
               {
                  this.m_CurClip.gotoAndPlay(standardRollOffAnimName);
                  this.QuestCompleteContainer_mc.gotoAndPlay("rollOffAfterRewards");
               }
               else
               {
                  trace("Finished showing fanfare marked as a completion reward, but it\'s niether an item reward or quest complete. Something is wrong with the data!");
                  trace(new Error().getStackTrace());
               }
            }
            else if(this.m_CurEvent.useDescAnim)
            {
               this.m_CurClip.gotoAndPlay("rollOffDesc");
            }
            else
            {
               this.m_CurClip.gotoAndPlay(standardRollOffAnimName);
            }
            BSUIDataManager.dispatchEvent(new Event("FanfareEvent::FadeOut"));
            this.m_CurTimeout = setTimeout(this.onAnimEnd,fadeTime);
         }
         else
         {
            this.onAnimEnd();
         }
         this.m_AcceptButtonHint.holdPercent = 0;
      }
      
      public function onFarefanFullyDisplayed(e:Event) : void
      {

         this.m_CurEvent.markedAsDisplay = true;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
      }
      
      public function onShowModel(e:Event) : void
      {

         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_UPDATEMODEL,{
            "itemHandle":this.m_CurEvent.itemHandle,
            "showingItem":true
         }));
      }
      
      public function onClearModel(e:Event) : void
      {

         if(this.m_CurEvent)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_UPDATEMODEL,{
               "itemHandle":this.m_CurEvent.itemHandle,
               "showingItem":false
            }));
         }
      }
      
      private function GetOnPlayItemSoundFunc(aItemIndex:uint) : Function
      {

         return function():// method body index: 918 method index: 918
         void
         {

            if(m_CurEvent.rewardsA.length > aItemIndex)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PLAYITEMSOUND,{"uItemHandle":m_CurEvent.rewardsA[aItemIndex].uItemHandle}));
            }
         };
      }
      
      private function onShowXPReward(e:Event) : void
      {

         this.ShowXPReward(this.m_CurEvent.xpRewarded);
      }
      
      private function ShowXPReward(aXP:Number) : void
      {

         if(aXP)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_XPREWARD,{"xpRewarded":aXP}));
         }
      }
      
      private function onShowCurrencyReward(e:Event) : void
      {

         this.ShowCurrencyReward(this.m_CurEvent.currencyID,this.m_CurEvent.currencyRewarded);
      }
      
      private function ShowCurrencyReward(aCurrencyID:uint, aCurrencyRewarded:uint) : void
      {

         if(aCurrencyRewarded)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CURRENCYREWARD,{
               "currencyID":aCurrencyID,
               "currencyRewarded":aCurrencyRewarded
            }));
         }
      }
      
      public function onAnimEnd(aEvaluateQueue:Boolean = true) : void
      {

         this.m_CurTimeout = -1;
         if(aEvaluateQueue)
         {
            this.evaluateQueue(true);
         }
         else
         {
            this.isBusy = false;
         }
      }
      
      private function onQuestAcceptUpdate(arEvent:FromClientDataEvent) : void
      {

         if(arEvent.data.totalButtonHoldTime > 0)
         {
            this.m_AcceptButtonHint.holdPercent = Math.max(0,Math.min(1,arEvent.data.timeButtonHeld / arEvent.data.totalButtonHoldTime));
         }
         if(this.m_CurEvent != null && arEvent.data.fanfareEventID == this.m_CurEvent.fanfareEventID)
         {
            this.endFanfare();
         }
      }
      
      private function onHUDModeUpdate(arEvent:FromClientDataEvent) : void
      {

         this.m_IsValidHudMode = this.m_ValidHudModes.indexOf(arEvent.data.hudMode) != -1;
         this.updateEnabled();
         this.evaluateQueue();
      }
      
      private function onQuestDataUpdate(arEvent:FromClientDataEvent) : void
      {

         if(!this.m_IsBusy)
         {
            this.evaluateQueue();
         }
      }
      
      private function onAddedToStage(e:Event) : void
      {

         this.m_ValidHudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.WORKSHOP_MODE,HUDModes.CAMP_PLACEMENT,HUDModes.FURNITURE_ENTER_EXIT);
         this.m_EventData = BSUIDataManager.GetDataFromClient("FanfareData");
         BSUIDataManager.Subscribe("FanfareData",this.onDataUpdate);
         addEventListener("HUDAnnouce::MarkFanfareAsDisplayed",this.onFarefanFullyDisplayed);
         addEventListener("HUDAnnounce::ShowModel",this.onShowModel);
         addEventListener("HUDAnnounce::ClearModel",this.onClearModel);
         for(var rewardIndex:uint = 0; rewardIndex < MAX_QUEST_REWARDS; rewardIndex++)
         {
            addEventListener("HUDAnnounce::PlayQuestRewardSound" + (rewardIndex + 1),this.GetOnPlayItemSoundFunc(rewardIndex));
         }
         addEventListener("HUDAnnounce::ShowXPReward",this.onShowXPReward);
         addEventListener("HUDAnnounce::ShowCurrencyReward",this.onShowCurrencyReward);
         BSUIDataManager.Subscribe("FanfareQuestAcceptData",this.onQuestAcceptUpdate);
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("QuestEventData",this.onQuestDataUpdate);
         var buttonHintDataV:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         buttonHintDataV.push(this.m_AcceptButtonHint);
         this.m_AcceptButtonHint.canHold = true;
         this.AnnounceAvailableQuest_mc.ButtonHintBar_mc.SetButtonHintData(buttonHintDataV);
         this.AnnounceActiveQuest_mc.ButtonHintBar_mc.SetButtonHintData(buttonHintDataV);
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.UniqueItemContainer_mc.FanfareName_mc.FanfareName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AnnounceActiveQuest_mc.Name_mc.Name_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AnnounceActiveQuest_mc.Title_mc.title_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
   }
}
