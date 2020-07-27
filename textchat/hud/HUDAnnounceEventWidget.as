 
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
      
      private static const LOC_DISCOVERED_ANIM_TIME_OFFSET = // method body index: 821 method index: 821
      2800;
      
      public static const EVENT_CONSUME:String = // method body index: 821 method index: 821
      "HUD::DiscardFanfare";
      
      public static const EVENT_CLEAR_COMPLETION_REWARD_FLAG:String = // method body index: 821 method index: 821
      "HUD::ClearCompletionRewardsFlag";
      
      public static const EVENT_UPDATEMODEL:String = // method body index: 821 method index: 821
      "HUD::UpdateInventory3DModel";
      
      public static const EVENT_PLAYITEMSOUND:String = // method body index: 821 method index: 821
      "HUD::PlaySoundForItem";
      
      public static const EVENT_CURRENCYREWARD:String = // method body index: 821 method index: 821
      "HUD::ShowCurrencyReward";
      
      public static const EVENT_XPREWARD:String = // method body index: 821 method index: 821
      "HUD::ShowXPReward";
      
      public static const EVENT_LISTENFORACCEPT:String = // method body index: 821 method index: 821
      "HUD::ListenForQuestAccept";
      
      public static const EVENT_ACCEPT:String = // method body index: 821 method index: 821
      "HUD::AcceptFanfare";
      
      public static const EVENT_LOC_BUSY:String = // method body index: 821 method index: 821
      "HUD::LocationBusy";
      
      public static const EVENT_CLEARED:String = // method body index: 821 method index: 821
      "HUDAnnounceEvent::Cleared";
      
      public static const EVENT_ACTIVE:String = // method body index: 821 method index: 821
      "HUDAnnounceEvent::Active";
      
      public static const FANFARE_TYPE_QUESTCOMPLETE:uint = // method body index: 821 method index: 821
      0;
      
      public static const FANFARE_TYPE_QUESTFAILED:uint = // method body index: 821 method index: 821
      1;
      
      public static const FANFARE_TYPE_ITEMREWARD:uint = // method body index: 821 method index: 821
      2;
      
      public static const FANFARE_TYPE_QUESTAVAILABLE:uint = // method body index: 821 method index: 821
      3;
      
      public static const FANFARE_TYPE_QUESTACTIVE:uint = // method body index: 821 method index: 821
      4;
      
      public static const FANFARE_TYPE_FEATUREDITEM:uint = // method body index: 821 method index: 821
      5;
      
      public static const FANFARE_TYPE_LOCATIONDISCOVERED:uint = // method body index: 821 method index: 821
      6;
      
      public static const FANFARE_TYPE_MESSAGETEXT:uint = // method body index: 821 method index: 821
      7;
      
      public static const FANFARE_TYPE_QUICKPLAYANNOUNCE:uint = // method body index: 821 method index: 821
      8;
      
      public static const FANFARE_TYPE_COUNT:uint = // method body index: 821 method index: 821
      9;
      
      private static const MAX_QUEST_REWARDS:uint = // method body index: 821 method index: 821
      6;
      
      private static const COMPLETION_TO_REWARDS_FADE_TIME_MS = // method body index: 821 method index: 821
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
         // method body index: 822 method index: 822
         this.m_ProcessedEventIDList = new Array();
         this.m_AcceptButtonHint = new BSButtonHintData("$RESET","T","PSN_Y","Xenon_Y",1,null);
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.m_LocationDiscoverAnimTime = this.AnnounceLocationDiscovered_mc.totalFrames * 1000 / stage.frameRate - LOC_DISCOVERED_ANIM_TIME_OFFSET;
      }
      
      private function updateIsAnimating() : void
      {
         // method body index: 823 method index: 823
         var _loc1_:Boolean = this.m_IsBusy && this.m_Active;
         if(this.m_IsAnimating != _loc1_)
         {
            this.m_IsAnimating = _loc1_;
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
      
      public function set isBusy(param1:Boolean) : void
      {
         // method body index: 824 method index: 824
         if(param1 != this.m_IsBusy)
         {
            this.m_IsBusy = param1;
            this.updateIsAnimating();
         }
      }
      
      public function set active(param1:Boolean) : void
      {
         // method body index: 825 method index: 825
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         if(param1 != this.m_Active)
         {
            this.m_Active = param1;
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
                  _loc2_ = this.m_EventData.data.fanfareEvents;
                  _loc3_ = _loc2_.length;
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_)
                  {
                     _loc4_ = _loc2_[_loc5_];
                     if(_loc4_.questInstanceId == this.m_CurEvent.questInstanceId && _loc4_.fanfareEventType == FANFARE_TYPE_ITEMREWARD)
                     {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CLEAR_COMPLETION_REWARD_FLAG,{"fanfareEventID":_loc4_.fanfareEventID}));
                     }
                     _loc5_++;
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
         // method body index: 826 method index: 826
         this.active = this.m_Enabled && this.m_IsValidHudMode;
      }
      
      private function onDataUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 827 method index: 827
         this.m_ProcessedEventIDList = new Array();
         this.m_Enabled = param1.data.isFanfareEnabled;
         this.updateEnabled();
         this.evaluateQueue();
      }
      
      private function isValidFanfareQuest(param1:String) : Boolean
      {
         // method body index: 828 method index: 828
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:Array = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
         var _loc5_:uint = 0;
         while(_loc4_ != null && _loc5_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc5_];
            if(_loc2_.questID == param1)
            {
               _loc3_ = 0;
               while(_loc2_.objectives != null && _loc3_ < _loc2_.objectives.length)
               {
                  if(_loc2_.objectives[_loc3_].isDisplayed)
                  {
                     return true;
                  }
                  _loc3_++;
               }
            }
            _loc5_++;
         }
         return false;
      }
      
      private function evaluateQueue(param1:Boolean = false) : void
      {
         // method body index: 829 method index: 829
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(this.m_Active && this.m_EventData.data.fanfareEvents != null)
         {
            _loc2_ = false;
            _loc3_ = this.m_CurEvent && this.m_CurEvent.isCompletionRewards && this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE;
            for each(_loc4_ in this.m_EventData.data.fanfareEvents)
            {
               if(this.m_ProcessedEventIDList.indexOf(_loc4_.fanfareEventID) == -1)
               {
                  _loc5_ = false;
                  _loc6_ = !_loc2_ && (!this.m_IsBusy || param1);
                  _loc6_ = _loc6_ && (!_loc3_ || _loc4_.isCompletionRewards && _loc4_.fanfareEventType == FANFARE_TYPE_ITEMREWARD && _loc4_.questInstanceId == this.m_CurEvent.questInstanceId);
                  switch(_loc4_.fanfareEventType)
                  {
                     case FANFARE_TYPE_LOCATIONDISCOVERED:
                        if(!this.m_LocationBusy)
                        {
                           this.animateLocationDiscovered(_loc4_);
                           _loc5_ = true;
                        }
                        break;
                     case FANFARE_TYPE_QUESTAVAILABLE:
                     case FANFARE_TYPE_QUESTACTIVE:
                        if(_loc6_ && this.isValidFanfareQuest(_loc4_.questInstanceId))
                        {
                           _loc2_ = this.animateEvent(_loc4_);
                           _loc5_ = _loc2_;
                        }
                        else if(this.m_CurEvent && this.m_CurEvent.questInstanceId == _loc4_.questInstanceId)
                        {
                           if(this.m_CurClip == this.AnnounceAvailableQuest_mc)
                           {
                              this.AnnounceAvailableQuest_mc.Desc_mc.Desc_tf.text = _loc4_.shortDescription;
                           }
                           else if(this.m_CurClip == this.AnnounceActiveQuest_mc)
                           {
                              this.AnnounceActiveQuest_mc.Desc_mc.Desc_tf.text = _loc4_.shortDescription;
                           }
                           _loc5_ = true;
                        }
                        break;
                     case FANFARE_TYPE_QUICKPLAYANNOUNCE:
                     case FANFARE_TYPE_QUESTCOMPLETE:
                     case FANFARE_TYPE_QUESTFAILED:
                     case FANFARE_TYPE_ITEMREWARD:
                     case FANFARE_TYPE_FEATUREDITEM:
                     case FANFARE_TYPE_MESSAGETEXT:
                        if(_loc6_)
                        {
                           _loc2_ = this.animateEvent(_loc4_);
                           _loc5_ = _loc2_;
                        }
                  }
                  if(_loc5_)
                  {
                     this.m_ProcessedEventIDList.push(_loc4_.fanfareEventID);
                  }
               }
            }
            if(param1)
            {
               this.isBusy = _loc2_;
            }
            else
            {
               this.isBusy = this.m_IsBusy || _loc2_;
            }
         }
      }
      
      private function getEventTypeData(param1:uint) : Object
      {
         // method body index: 830 method index: 830
         return param1 < FANFARE_TYPE_COUNT?this.m_EventData.data.fanfareTypes[param1]:null;
      }
      
      private function animateLocationDiscovered(param1:Object) : void
      {
         // method body index: 832 method index: 832
         var discoverEvent:Object = param1;
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
         setTimeout(function():// method body index: 831 method index: 831
         *
         {
            // method body index: 831 method index: 831
            m_LocationBusy = false;
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LOC_BUSY,{"isLocationBusy":false}));
            evaluateQueue();
         },this.m_LocationDiscoverAnimTime);
      }
      
      private function IsSimpleType(param1:String) : Boolean
      {
         // method body index: 833 method index: 833
         return param1 == "int" || param1 == "uint" || param1 == "Number" || param1 == "String" || param1 == "Boolean";
      }
      
      private function CloneKey(param1:String, param2:*, param3:*) : void
      {
         // method body index: 834 method index: 834
         var _loc4_:String = getQualifiedClassName(param3[param1]);
         if(_loc4_ == "Object")
         {
            param2[param1] = this.CloneObjectData(param3[param1]);
         }
         else if(_loc4_ == "Array")
         {
            param2[param1] = this.CloneArrayData(param3[param1]);
         }
         else
         {
            GlobalFunc.BSASSERT(this.IsSimpleType(_loc4_),"Can\'t clone non-basic types. Trying to clone a " + _loc4_);
            param2[param1] = param3[param1];
         }
      }
      
      private function CloneArrayData(param1:Array) : Array
      {
         // method body index: 835 method index: 835
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            this.CloneKey(_loc3_.toString(),_loc2_,param1);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function CloneObjectData(param1:Object) : Object
      {
         // method body index: 836 method index: 836
         var _loc2_:* = undefined;
         var _loc3_:Object = new Object();
         for(_loc2_ in param1)
         {
            this.CloneKey(_loc2_,_loc3_,param1);
         }
         return _loc3_;
      }
      
      private function animateEvent(param1:Object) : Boolean
      {
         // method body index: 838 method index: 838
         var aEvent:Object = param1;
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
            this.m_CurTimeout = setTimeout(function():// method body index: 837 method index: 837
            *
            {
               // method body index: 837 method index: 837
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
      
      private function DisplaySimpleRewards(param1:Object) : void
      {
         // method body index: 840 method index: 840
         var xpReward:Number = NaN;
         var aEvent:Object = param1;
         xpReward = NaN;
         this.ShowCurrencyReward(aEvent.currencyID,aEvent.currencyRewarded);
         var xpDelay:Number = 700;
         xpReward = aEvent.xpRewarded;
         setTimeout(function():// method body index: 839 method index: 839
         *
         {
            // method body index: 839 method index: 839
            ShowXPReward(xpReward);
         },xpDelay);
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":aEvent.fanfareEventID}));
      }
      
      private function endFanfare() : void
      {
         // method body index: 841 method index: 841
         var _loc1_:Object = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         if(this.m_CurClip != null)
         {
            _loc1_ = this.getEventTypeData(this.m_CurEvent.fanfareEventType);
            GlobalFunc.BSASSERT(_loc1_ != null,"Event type data is null.");
            _loc2_ = _loc1_.gapTimer;
            _loc3_ = "RollOff";
            if(this.m_CurEvent.isCompletionRewards)
            {
               if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE)
               {
                  _loc4_ = null;
                  for each(_loc5_ in this.m_EventData.data.fanfareEvents)
                  {
                     if(_loc5_.isCompletionRewards && _loc5_.fanfareEventType == FANFARE_TYPE_ITEMREWARD && _loc5_.questInstanceId == this.m_CurEvent.questInstanceId)
                     {
                        _loc4_ = _loc5_;
                        break;
                     }
                  }
                  if(_loc4_ != null && _loc4_.rewardsA.length > 0)
                  {
                     this.m_CurClip.gotoAndPlay("rollOffForRewards");
                     _loc2_ = COMPLETION_TO_REWARDS_FADE_TIME_MS;
                  }
                  else
                  {
                     this.m_CurClip.gotoAndPlay(_loc3_);
                     this.m_CurEvent.isCompletionRewards = false;
                     this.DisplaySimpleRewards(_loc4_);
                  }
               }
               else if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_ITEMREWARD)
               {
                  this.m_CurClip.gotoAndPlay(_loc3_);
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
               this.m_CurClip.gotoAndPlay(_loc3_);
            }
            BSUIDataManager.dispatchEvent(new Event("FanfareEvent::FadeOut"));
            this.m_CurTimeout = setTimeout(this.onAnimEnd,_loc2_);
         }
         else
         {
            this.onAnimEnd();
         }
         this.m_AcceptButtonHint.holdPercent = 0;
      }
      
      public function onFarefanFullyDisplayed(param1:Event) : void
      {
         // method body index: 842 method index: 842
         this.m_CurEvent.markedAsDisplay = true;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
      }
      
      public function onShowModel(param1:Event) : void
      {
         // method body index: 843 method index: 843
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_UPDATEMODEL,{
            "itemHandle":this.m_CurEvent.itemHandle,
            "showingItem":true
         }));
      }
      
      public function onClearModel(param1:Event) : void
      {
         // method body index: 844 method index: 844
         if(this.m_CurEvent)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_UPDATEMODEL,{
               "itemHandle":this.m_CurEvent.itemHandle,
               "showingItem":false
            }));
         }
      }
      
      private function GetOnPlayItemSoundFunc(param1:uint) : Function
      {
         // method body index: 846 method index: 846
         var aItemIndex:uint = param1;
         return function():// method body index: 845 method index: 845
         void
         {
            // method body index: 845 method index: 845
            if(m_CurEvent.rewardsA.length > aItemIndex)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PLAYITEMSOUND,{"uItemHandle":m_CurEvent.rewardsA[aItemIndex].uItemHandle}));
            }
         };
      }
      
      private function onShowXPReward(param1:Event) : void
      {
         // method body index: 847 method index: 847
         this.ShowXPReward(this.m_CurEvent.xpRewarded);
      }
      
      private function ShowXPReward(param1:Number) : void
      {
         // method body index: 848 method index: 848
         if(param1)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_XPREWARD,{"xpRewarded":param1}));
         }
      }
      
      private function onShowCurrencyReward(param1:Event) : void
      {
         // method body index: 849 method index: 849
         this.ShowCurrencyReward(this.m_CurEvent.currencyID,this.m_CurEvent.currencyRewarded);
      }
      
      private function ShowCurrencyReward(param1:uint, param2:uint) : void
      {
         // method body index: 850 method index: 850
         if(param2)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CURRENCYREWARD,{
               "currencyID":param1,
               "currencyRewarded":param2
            }));
         }
      }
      
      public function onAnimEnd(param1:Boolean = true) : void
      {
         // method body index: 851 method index: 851
         this.m_CurTimeout = -1;
         if(param1)
         {
            this.evaluateQueue(true);
         }
         else
         {
            this.isBusy = false;
         }
      }
      
      private function onQuestAcceptUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 852 method index: 852
         if(param1.data.totalButtonHoldTime > 0)
         {
            this.m_AcceptButtonHint.holdPercent = Math.max(0,Math.min(1,param1.data.timeButtonHeld / param1.data.totalButtonHoldTime));
         }
         if(this.m_CurEvent != null && param1.data.fanfareEventID == this.m_CurEvent.fanfareEventID)
         {
            this.endFanfare();
         }
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 853 method index: 853
         this.m_IsValidHudMode = this.m_ValidHudModes.indexOf(param1.data.hudMode) != -1;
         this.updateEnabled();
         this.evaluateQueue();
      }
      
      private function onQuestDataUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 854 method index: 854
         if(!this.m_IsBusy)
         {
            this.evaluateQueue();
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         // method body index: 855 method index: 855
         this.m_ValidHudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.WORKSHOP_MODE,HUDModes.CAMP_PLACEMENT,HUDModes.FURNITURE_ENTER_EXIT);
         this.m_EventData = BSUIDataManager.GetDataFromClient("FanfareData");
         BSUIDataManager.Subscribe("FanfareData",this.onDataUpdate);
         addEventListener("HUDAnnouce::MarkFanfareAsDisplayed",this.onFarefanFullyDisplayed);
         addEventListener("HUDAnnounce::ShowModel",this.onShowModel);
         addEventListener("HUDAnnounce::ClearModel",this.onClearModel);
         var _loc2_:uint = 0;
         while(_loc2_ < MAX_QUEST_REWARDS)
         {
            addEventListener("HUDAnnounce::PlayQuestRewardSound" + (_loc2_ + 1),this.GetOnPlayItemSoundFunc(_loc2_));
            _loc2_++;
         }
         addEventListener("HUDAnnounce::ShowXPReward",this.onShowXPReward);
         addEventListener("HUDAnnounce::ShowCurrencyReward",this.onShowCurrencyReward);
         BSUIDataManager.Subscribe("FanfareQuestAcceptData",this.onQuestAcceptUpdate);
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("QuestEventData",this.onQuestDataUpdate);
         var _loc3_:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         _loc3_.push(this.m_AcceptButtonHint);
         this.m_AcceptButtonHint.canHold = true;
         this.AnnounceAvailableQuest_mc.ButtonHintBar_mc.SetButtonHintData(_loc3_);
         this.AnnounceActiveQuest_mc.ButtonHintBar_mc.SetButtonHintData(_loc3_);
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.UniqueItemContainer_mc.FanfareName_mc.FanfareName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AnnounceActiveQuest_mc.Name_mc.Name_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AnnounceActiveQuest_mc.Title_mc.title_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
   }
}
