 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import fl.transitions.Tween;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HUDQuestTracker extends MovieClip
   {
      
      public static const QUEST_STATE_INVALID:Number = // method body index: 1914 method index: 1914
      0;
      
      public static const QUEST_STATE_INPROGRESS:Number = // method body index: 1914 method index: 1914
      1;
      
      public static const QUEST_STATE_COMPLETE:Number = // method body index: 1914 method index: 1914
      2;
      
      public static const QUEST_STATE_FAILED:Number = // method body index: 1914 method index: 1914
      3;
      
      public static const EVENT_DURATION_QUEST_FADEINOUT:Number = // method body index: 1914 method index: 1914
      1200;
      
      public static const EVENT_DURATION_OBJECTIVE_UPDATE:Number = // method body index: 1914 method index: 1914
      500;
      
      public static const EVENT_DURATION_REARRANGE:Number = // method body index: 1914 method index: 1914
      350;
      
      public static const QUEST_EVENT_INVALID:uint = // method body index: 1914 method index: 1914
      0;
      
      public static const QUEST_EVENT_COMPLETE:uint = // method body index: 1914 method index: 1914
      1;
      
      public static const QUEST_EVENT_FAIL:uint = // method body index: 1914 method index: 1914
      2;
      
      public static const QUEST_EVENT_ACTIVE:uint = // method body index: 1914 method index: 1914
      3;
      
      public static const QUEST_EVENT_INACTIVE:uint = // method body index: 1914 method index: 1914
      4;
      
      public static const QUEST_EVENT_DISPLAYEDTOTEAM:uint = // method body index: 1914 method index: 1914
      5;
      
      public static const QUEST_EVENT_UNDISPLAYEDTOTEAM:uint = // method body index: 1914 method index: 1914
      6;
      
      public static const QUEST_EVENT_FORCEREARRANGE:Number = // method body index: 1914 method index: 1914
      500;
      
      public static const OBJECTIVE_EVENT_INVALID:uint = // method body index: 1914 method index: 1914
      0;
      
      public static const OBJECTIVE_EVENT_COMPLETE:uint = // method body index: 1914 method index: 1914
      1;
      
      public static const OBJECTIVE_EVENT_FAIL:uint = // method body index: 1914 method index: 1914
      2;
      
      public static const OBJECTIVE_EVENT_UPDATE:uint = // method body index: 1914 method index: 1914
      3;
      
      public static const OBJECTIVE_EVENT_REMOVE:uint = // method body index: 1914 method index: 1914
      4;
      
      public static const OBJECTIVE_MERGE_LEADER_CHANGE:uint = // method body index: 1914 method index: 1914
      5;
      
      public static const QUEST_SPACING:Number = // method body index: 1914 method index: 1914
      16;
      
      public static const TEST_MODE:Boolean = // method body index: 1914 method index: 1914
      false;
      
      public static const ENTITY_ID_INVALID:Number = // method body index: 1914 method index: 1914
      4294967295;
      
      public static const DEBUG_SKIP_ANIMATIONS:Boolean = // method body index: 1914 method index: 1914
      false;
      
      public static const FADE_DELAY_SHORT:Number = // method body index: 1914 method index: 1914
      10000;
       
      
      public var EventQuestDivider_mc:MovieClip;
      
      private var m_EventQuestDividerVisible:Boolean = false;
      
      private var m_EventQuestDividerTween:Tween = null;
      
      private var m_DisplayedQuests:Vector.<HUDQuestTrackerEntry>;
      
      private var m_HideTimeout:int = -1;
      
      private var m_FadeTween:Tween = null;
      
      private var m_QuestData:Array = null;
      
      private var m_updateTimeout:int = -1;
      
      private var m_testEnabled:Boolean = false;
      
      private var m_BusyAnimating:Boolean = false;
      
      private var m_AnimationsBlocked:Boolean = false;
      
      private var m_EventsQueued:Boolean = false;
      
      private var m_TempNewQuestEventData:Object;
      
      private var m_PendingQuestEvents:Array;
      
      private var m_PendingObjectiveEvents:Array;
      
      private var m_NeedReposition:Boolean = false;
      
      private var m_IsValidHudMode:Boolean = true;
      
      private var m_IsShortDelayHudMode:Boolean = false;
      
      private var m_Displayed:Boolean = true;
      
      private var m_ShouldDisplay:Boolean = false;
      
      private var m_ShouldAllQuestsBeTemp:Boolean = false;
      
      private var m_ForceConsolidateAllQuests:Boolean = false;
      
      private var m_AnimationPassedRearrange:Boolean = false;
      
      private var m_Initialized:Boolean = false;
      
      private var m_CurrentHUDMode:String = "";
      
      private var m_ValidHudModes:Array;
      
      private var m_LastNonFocusAlpha = 1;
      
      private var m_FocusFadeTween:Tween = null;
      
      private var m_TempObjectivesToRemove:Vector.<HUDQuestTrackerObjective>;
      
      private var m_TempQuestObjectiveUpdates:Boolean = false;
      
      public function HUDQuestTracker()
      {
         // method body index: 1915 method index: 1915
         this.m_PendingQuestEvents = [];
         this.m_PendingObjectiveEvents = [];
         this.m_TempObjectivesToRemove = new Vector.<HUDQuestTrackerObjective>();
         super();
         this.m_ValidHudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.CAMP_PLACEMENT,HUDModes.PIPBOY,HUDModes.TERMINAL_MODE,HUDModes.INSPECT_MODE,HUDModes.DIALOGUE_MODE,HUDModes.MESSAGE_MODE);
         this.m_DisplayedQuests = new Vector.<HUDQuestTrackerEntry>();
         BSUIDataManager.Subscribe("MenuStackData",this.onMenuStackChange);
         BSUIDataManager.Subscribe("QuestEventData",this.onQuestEventsUpdate);
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         this.setDisplayed(false);
         if(TEST_MODE)
         {
            this.registerTestFunctionality();
         }
      }
      
      private function eventQuestDividerPos(param1:Number, param2:Boolean = false) : *
      {
         // method body index: 1916 method index: 1916
         if(this.m_EventQuestDividerTween != null)
         {
            this.m_EventQuestDividerTween.stop();
            this.m_EventQuestDividerTween = null;
         }
         this.m_EventQuestDividerTween = new Tween(this.EventQuestDivider_mc,"y",Regular.easeInOut,this.EventQuestDivider_mc.y,param1,HUDQuestTracker.EVENT_DURATION_REARRANGE / 1000,true);
      }
      
      public function requestRearrange() : void
      {
         // method body index: 1917 method index: 1917
         if(this.m_AnimationPassedRearrange)
         {
            this.m_TempNewQuestEventData = {
               "questEvents":[{
                  "eventType":QUEST_EVENT_FORCEREARRANGE,
                  "questID":"999"
               }],
               "objectiveEvents":[]
            };
            this.processNewQuestEventData();
         }
         else
         {
            this.m_TempQuestObjectiveUpdates = true;
            this.m_NeedReposition = true;
         }
      }
      
      public function setDisplayed(param1:Boolean) : void
      {
         // method body index: 1918 method index: 1918
         this.m_ShouldDisplay = param1;
         if(this.m_IsValidHudMode)
         {
            if(this.m_Displayed != this.m_ShouldDisplay)
            {
               if(this.m_ShouldDisplay)
               {
                  this.show();
               }
               else
               {
                  this.hide();
               }
            }
         }
         else if(this.m_Displayed)
         {
            this.hide();
         }
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 1919 method index: 1919
         this.m_CurrentHUDMode = param1.data.hudMode;
         this.m_IsValidHudMode = this.m_ValidHudModes.indexOf(param1.data.hudMode) != -1;
         var _loc2_:* = this.m_CurrentHUDMode == HUDModes.DIALOGUE_MODE;
         if(_loc2_ != this.m_ShouldAllQuestsBeTemp)
         {
            this.m_ShouldAllQuestsBeTemp = _loc2_;
            this.m_ForceConsolidateAllQuests = true;
         }
         if(this.m_CurrentHUDMode == HUDModes.ALL)
         {
            this.setDisplayed(true);
         }
         else
         {
            this.setDisplayed(this.m_ShouldDisplay);
         }
         if(this.m_ForceConsolidateAllQuests)
         {
            this.processNewQuestEventData();
         }
      }
      
      private function onMenuStackChange(param1:FromClientDataEvent) : void
      {
         // method body index: 1920 method index: 1920
         var _loc2_:* = undefined;
         var _loc3_:Boolean = false;
         if(param1.data.menuStackA.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.data.menuStackA.length)
            {
               switch(param1.data.menuStackA[_loc2_].menuName)
               {
                  case "PerksMenu":
                  case "WorkshopMenu":
                     _loc3_ = true;
                  default:
                     _loc3_ = true;
               }
               _loc2_++;
            }
            if(_loc3_)
            {
               this.setDisplayed(false);
            }
            else
            {
               this.setDisplayed(true);
            }
         }
      }
      
      private function questDataHasDisplayedObjectives(param1:Object) : Boolean
      {
         // method body index: 1921 method index: 1921
         var _loc2_:uint = param1.objectives.length;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            if(param1.objectives[_loc4_].isDisplayed && param1.objectives[_loc4_].isActive)
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_ > 0 && _loc3_;
      }
      
      private function questDataValidForDisplay(param1:Object) : Boolean
      {
         // method body index: 1922 method index: 1922
         if(param1 != null)
         {
            return (param1.isActive || param1.isDisplayedToTeam) && param1.state == QUEST_STATE_INPROGRESS && this.questDataHasDisplayedObjectives(param1);
         }
         return false;
      }
      
      public function set nonFocusOpacity(param1:Number) : void
      {
         // method body index: 1923 method index: 1923
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            if(this.m_DisplayedQuests[_loc2_].focusQuest)
            {
               this.m_DisplayedQuests[_loc2_].alpha = 1;
            }
            else
            {
               this.m_DisplayedQuests[_loc2_].alpha = param1;
            }
            _loc2_++;
         }
         this.EventQuestDivider_mc.alpha = param1;
      }
      
      private function consolidateQuestEvents() : Object
      {
         // method body index: 1924 method index: 1924
         var _loc1_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         if(this.m_ForceConsolidateAllQuests)
         {
            _loc1_ = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
            _loc2_ = [];
            _loc3_ = 0;
            while(_loc3_ < this.m_QuestData.length)
            {
               if(this.questDataValidForDisplay(_loc1_[_loc3_]))
               {
                  _loc2_.push({
                     "questID":_loc1_[_loc3_].questID,
                     "eventType":QUEST_EVENT_INVALID
                  });
               }
               _loc3_++;
            }
            _loc4_ = {
               "quests":_loc2_,
               "objectives":this.m_PendingObjectiveEvents.slice()
            };
            this.m_ForceConsolidateAllQuests = false;
         }
         else
         {
            _loc4_ = {
               "quests":this.m_PendingQuestEvents.slice(),
               "objectives":this.m_PendingObjectiveEvents.slice()
            };
         }
         this.m_PendingQuestEvents.splice(0);
         this.m_PendingObjectiveEvents.splice(0);
         return _loc4_;
      }
      
      public function SetAnimationBlocked(param1:Boolean) : void
      {
         // method body index: 1925 method index: 1925
         this.m_AnimationsBlocked = param1;
         if(this.CanAnimate() && this.m_EventsQueued)
         {
            this.processQuestUpdateEvents();
         }
      }
      
      public function CanAnimate() : Boolean
      {
         // method body index: 1926 method index: 1926
         return !this.m_AnimationsBlocked && !this.m_BusyAnimating;
      }
      
      private function processNewQuestEventData() : void
      {
         // method body index: 1927 method index: 1927
         if(DEBUG_SKIP_ANIMATIONS)
         {
            this.populateFull();
            return;
         }
         this.m_PendingQuestEvents = this.m_PendingQuestEvents.concat(this.m_TempNewQuestEventData.questEvents);
         this.m_PendingObjectiveEvents = this.m_PendingObjectiveEvents.concat(this.m_TempNewQuestEventData.objectiveEvents);
         this.m_TempNewQuestEventData = {
            "questEvents":[],
            "objectiveEvents":[]
         };
         if(this.CanAnimate())
         {
            this.processQuestUpdateEvents();
         }
         else
         {
            this.m_EventsQueued = true;
            this.UpdateTitleText();
         }
      }
      
      private function UpdateTitleText() : void
      {
         // method body index: 1928 method index: 1928
         var _loc1_:HUDQuestTrackerEntry = null;
         var _loc2_:Object = null;
         var _loc3_:HUDQuestTrackerObjective = null;
         var _loc4_:Object = null;
         for each(_loc1_ in this.m_DisplayedQuests)
         {
            for each(_loc2_ in this.m_QuestData)
            {
               if(_loc1_.questID == _loc2_.questID)
               {
                  _loc1_.title = _loc2_.title;
                  for each(_loc3_ in _loc1_.objectives)
                  {
                     for each(_loc4_ in _loc2_.objectives)
                     {
                        if(_loc3_.objectiveID == _loc4_.objectiveID && (_loc1_.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || _loc3_.contextQuestID == _loc4_.contextQuestID))
                        {
                           _loc3_.title = _loc4_.title;
                        }
                     }
                  }
                  break;
               }
            }
         }
      }
      
      private function onQuestEventsUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 1929 method index: 1929
         if(param1.data.testEnable == true && this.m_testEnabled == false)
         {
            this.registerTestFunctionality();
         }
         if(DEBUG_SKIP_ANIMATIONS)
         {
            this.populateFull();
            return;
         }
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         this.m_QuestData = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
         if(!this.m_Initialized && this.m_QuestData != null && this.m_QuestData.length > 0)
         {
            this.populateFull();
            this.m_Initialized = true;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param1.data.questEvents.length)
         {
            _loc2_.push({
               "questID":param1.data.questEvents[_loc4_].questID,
               "eventType":param1.data.questEvents[_loc4_].eventType
            });
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.data.objectiveEvents.length)
         {
            _loc3_.push({
               "questID":param1.data.objectiveEvents[_loc4_].questID,
               "objectiveID":param1.data.objectiveEvents[_loc4_].objectiveID,
               "eventType":param1.data.objectiveEvents[_loc4_].eventType,
               "contextQuestID":param1.data.objectiveEvents[_loc4_].contextQuestID
            });
            _loc4_++;
         }
         this.m_TempNewQuestEventData = {
            "questEvents":_loc2_,
            "objectiveEvents":_loc3_
         };
         if(this.m_Initialized)
         {
            this.processNewQuestEventData();
         }
         else
         {
            this.m_EventsQueued = true;
         }
      }
      
      public function show() : void
      {
         // method body index: 1930 method index: 1930
         this.m_Displayed = true;
         this.clearTween();
         this.endHideTimeout();
         this.visible = true;
         this.alpha = 1;
      }
      
      public function fadeOut() : void
      {
         // method body index: 1931 method index: 1931
         this.m_HideTimeout = -1;
         this.m_FadeTween = new Tween(this,"alpha",Regular.easeInOut,1,0,1,true);
         this.m_Displayed = false;
      }
      
      private function clearTween() : void
      {
         // method body index: 1932 method index: 1932
         if(this.m_FadeTween != null)
         {
            this.m_FadeTween.stop();
            this.m_FadeTween = null;
         }
      }
      
      private function endHideTimeout() : void
      {
         // method body index: 1933 method index: 1933
         if(this.m_HideTimeout != -1)
         {
            clearTimeout(this.m_HideTimeout);
            this.m_HideTimeout = -1;
         }
      }
      
      public function hide() : void
      {
         // method body index: 1934 method index: 1934
         this.m_Displayed = false;
         this.endHideTimeout();
         this.clearTween();
         this.visible = false;
      }
      
      private function sortDisplayedQuests(param1:HUDQuestTrackerEntry, param2:HUDQuestTrackerEntry) : Number
      {
         // method body index: 1935 method index: 1935
         if(param1.isEvent && !param2.isEvent)
         {
            return -1;
         }
         if(!param1.isEvent && param2.isEvent)
         {
            return 1;
         }
         if(!param1.tempDisplay && param2.tempDisplay)
         {
            return -1;
         }
         if(param1.tempDisplay && !param2.tempDisplay)
         {
            return 1;
         }
         return param1.sortIndex - param2.sortIndex;
      }
      
      private function eventQuestDividerVisible(param1:Boolean) : *
      {
         // method body index: 1936 method index: 1936
         if(param1)
         {
            if(!this.m_EventQuestDividerVisible)
            {
               this.EventQuestDivider_mc.gotoAndPlay("rollOn");
            }
         }
         else if(this.m_EventQuestDividerVisible)
         {
            this.EventQuestDivider_mc.gotoAndPlay("rollOff");
         }
      }
      
      public function arrangeQuests(param1:Boolean = false) : void
      {
         // method body index: 1937 method index: 1937
         var _loc2_:int = 0;
         var _loc3_:HUDQuestTrackerEntry = null;
         _loc2_ = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            this.m_DisplayedQuests[_loc2_].sortIndex = _loc2_;
            if(this.m_DisplayedQuests[_loc2_].questDisplayType == GlobalFunc.QUEST_DISPLAY_TYPE_MISC)
            {
               this.m_DisplayedQuests[_loc2_].sortIndex = int.MAX_VALUE;
            }
            _loc2_++;
         }
         this.m_DisplayedQuests.sort(this.sortDisplayedQuests);
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            if(this.m_DisplayedQuests[_loc2_].isEvent)
            {
               _loc5_ = true;
            }
            else
            {
               if(_loc5_)
               {
                  if(param1)
                  {
                     this.eventQuestDividerPos(_loc6_);
                  }
                  else
                  {
                     this.EventQuestDivider_mc.y = _loc6_ + QUEST_SPACING;
                  }
                  _loc6_ = _loc6_ + (this.EventQuestDivider_mc.Sizer_mc.height + QUEST_SPACING);
                  _loc4_ = true;
               }
               _loc5_ = false;
            }
            _loc3_ = this.m_DisplayedQuests[_loc2_];
            _loc3_.setYPos(_loc6_,param1);
            _loc6_ = _loc6_ + _loc3_.fullHeight + QUEST_SPACING;
            _loc2_++;
         }
         this.eventQuestDividerVisible(_loc4_);
         this.m_EventQuestDividerVisible = _loc4_;
      }
      
      private function initializeObjective(param1:Object) : HUDQuestTrackerObjective
      {
         // method body index: 1938 method index: 1938
         var _loc2_:HUDQuestTrackerObjective = new HUDQuestTrackerObjective();
         _loc2_.title = param1.title;
         _loc2_.state = param1.state;
         _loc2_.isOptional = param1.isOptional;
         _loc2_.objectiveID = param1.objectiveID;
         _loc2_.isOrObjective = param1.isOrObjective;
         _loc2_.useProvider = true;
         _loc2_.timer = param1.timer;
         _loc2_.progress = param1.progressMeter;
         _loc2_.alertMessage = param1.announce;
         _loc2_.alertState = param1.announceState;
         _loc2_.contextQuestID = param1.contextQuestID;
         if(_loc2_.isOrObjective)
         {
            _loc2_.title = "$$QUEST_TRACKER_OBJECTIVE_OR_PREFIX " + _loc2_.title;
         }
         _loc2_.isMergedLeaderObjective = param1.isMergedLeaderObj;
         return _loc2_;
      }
      
      private function initializeQuest(param1:Object, param2:Boolean = false) : HUDQuestTrackerEntry
      {
         // method body index: 1939 method index: 1939
         var _loc3_:HUDQuestTrackerObjective = null;
         var _loc4_:Object = null;
         var _loc5_:* = undefined;
         var _loc6_:HUDQuestTrackerEntry = new HUDQuestTrackerEntry();
         _loc6_.tracker = this;
         _loc6_.title = param1.title;
         _loc6_.questID = param1.questID;
         _loc6_.state = param1.state;
         _loc6_.isEvent = param1.isEventQuest;
         _loc6_.isDisplayedToTeam = param1.isDisplayedToTeam;
         _loc6_.questDisplayType = param1.questDisplayType;
         _loc6_.isShareable = param1.isShareable;
         _loc6_.useProvider = true;
         _loc6_.timer = param1.timer;
         for(_loc5_ in param1.objectives)
         {
            _loc4_ = param1.objectives[_loc5_];
            if(_loc4_.state == QUEST_STATE_INPROGRESS && _loc4_.isDisplayed && _loc4_.isActive)
            {
               _loc3_ = this.initializeObjective(_loc4_);
               _loc3_.questID = _loc6_.questID;
               _loc6_.addObjective(_loc3_);
               if(!param2)
               {
                  _loc3_.stateUpdate();
               }
            }
         }
         _loc6_.arrangeObjectives();
         return _loc6_;
      }
      
      private function populateFull() : void
      {
         // method body index: 1940 method index: 1940
         var _loc1_:HUDQuestTrackerEntry = null;
         var _loc2_:Object = null;
         var _loc3_:HUDQuestTrackerEntry = null;
         this.m_BusyAnimating = false;
         var _loc4_:* = this.m_DisplayedQuests.length;
         while(_loc4_ > 0)
         {
            _loc1_ = this.m_DisplayedQuests.pop();
            _loc1_.useProvider = false;
            removeChild(_loc1_);
            _loc4_--;
         }
         this.setDisplayed(true);
         var _loc5_:uint = 0;
         while(_loc5_ < this.m_QuestData.length)
         {
            _loc2_ = this.m_QuestData[_loc5_];
            if(this.questDataValidForDisplay(_loc2_))
            {
               _loc3_ = this.initializeQuest(_loc2_);
               _loc3_.stateUpdate();
               this.m_DisplayedQuests.push(_loc3_);
               addChild(_loc3_);
            }
            _loc5_++;
         }
         this.arrangeQuests();
      }
      
      private function getQuestDataByID(param1:uint) : Object
      {
         // method body index: 1941 method index: 1941
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_QuestData.length)
         {
            if(this.m_QuestData[_loc2_].questID == param1)
            {
               return this.m_QuestData[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getQuestDataObjectiveByID(param1:Object, param2:uint, param3:uint) : *
      {
         // method body index: 1942 method index: 1942
         var _loc4_:uint = 0;
         if(param1 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.objectives.length)
            {
               if(param1.objectives[_loc4_].objectiveID == param2 && (param1.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || param1.objectives[_loc4_].contextQuestID == param3))
               {
                  return param1.objectives[_loc4_];
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      private function getDisplayedQuestByID(param1:uint) : HUDQuestTrackerEntry
      {
         // method body index: 1943 method index: 1943
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            if(this.m_DisplayedQuests[_loc2_].questID == param1)
            {
               return this.m_DisplayedQuests[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getDisplayedObjectiveByID(param1:HUDQuestTrackerEntry, param2:uint, param3:uint) : HUDQuestTrackerObjective
      {
         // method body index: 1944 method index: 1944
         var _loc4_:uint = 0;
         while(_loc4_ < param1.objectives.length)
         {
            if(param1.objectives[_loc4_].objectiveID == param2 && (param1.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || param1.objectives[_loc4_].contextQuestID == param3))
            {
               return param1.objectives[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      private function animateUpdatedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : *
      {
         // method body index: 1945 method index: 1945
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].animateUpdate();
            _loc2_++;
         }
      }
      
      private function fadeDeletedQuests() : void
      {
         // method body index: 1946 method index: 1946
         var _loc1_:int = this.m_DisplayedQuests.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.m_DisplayedQuests[_loc1_].toRemove)
            {
               this.m_DisplayedQuests[_loc1_].fadeOut();
            }
            _loc1_--;
         }
      }
      
      private function fadeDeletedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 1947 method index: 1947
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].fadeOut();
            _loc2_++;
         }
      }
      
      private function removeDeletedQuests() : void
      {
         // method body index: 1948 method index: 1948
         var _loc1_:int = this.m_DisplayedQuests.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.m_DisplayedQuests[_loc1_].toRemove)
            {
               this.m_DisplayedQuests[_loc1_].useProvider = false;
               this.removeChild(this.m_DisplayedQuests[_loc1_]);
               this.m_DisplayedQuests.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      private function removeDeletedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 1949 method index: 1949
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            (param1[_loc2_].parent as HUDQuestTrackerEntry).deleteObjective(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function animateCompletedQuests(param1:Vector.<HUDQuestTrackerEntry>) : void
      {
         // method body index: 1950 method index: 1950
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].stateUpdate(true);
            _loc2_++;
         }
      }
      
      private function animateCompletedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 1951 method index: 1951
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].stateUpdate(true);
            _loc2_++;
         }
      }
      
      private function animateObjectivesWithMergeLeaderChange(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 1952 method index: 1952
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].mergeStateUpdate();
            _loc2_++;
         }
      }
      
      private function fadeInQuests(param1:Vector.<HUDQuestTrackerEntry>) : *
      {
         // method body index: 1953 method index: 1953
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].fadeIn();
            _loc2_++;
         }
      }
      
      private function fadeInObjectives(param1:Vector.<HUDQuestTrackerObjective>) : *
      {
         // method body index: 1954 method index: 1954
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].fadeIn();
            _loc2_++;
         }
      }
      
      private function focusQuestFade(param1:Number) : *
      {
         // method body index: 1955 method index: 1955
         if(this.m_FocusFadeTween != null)
         {
            this.m_FocusFadeTween.stop();
            this.m_FocusFadeTween = null;
         }
         this.m_FocusFadeTween = new Tween(this,"nonFocusOpacity",None.easeNone,this.m_LastNonFocusAlpha,param1,HUDQuestTracker.EVENT_DURATION_QUEST_FADEINOUT / 1000,true);
         this.m_LastNonFocusAlpha = param1;
      }
      
      private function arrangeQuestsObjectives() : void
      {
         // method body index: 1956 method index: 1956
         var _loc1_:uint = 0;
         while(_loc1_ < this.m_DisplayedQuests.length)
         {
            if(true || this.m_DisplayedQuests[_loc1_].needArrangeObjectives)
            {
               this.m_DisplayedQuests[_loc1_].arrangeObjectives(true);
            }
            _loc1_++;
         }
      }
      
      private function clearQuestArrangeFlags() : void
      {
         // method body index: 1957 method index: 1957
         var _loc1_:uint = 0;
         while(_loc1_ < this.m_DisplayedQuests.length)
         {
            this.m_DisplayedQuests[_loc1_].needArrangeObjectives = false;
            _loc1_++;
         }
      }
      
      private function clearQuestFocusFlags() : void
      {
         // method body index: 1958 method index: 1958
         var _loc1_:uint = 0;
         while(_loc1_ < this.m_DisplayedQuests.length)
         {
            this.m_DisplayedQuests[_loc1_].focusQuest = false;
            _loc1_++;
         }
      }
      
      public function queueRemoveQuestObjectives(param1:HUDQuestTrackerEntry, param2:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 1959 method index: 1959
         var _loc3_:* = 0;
         while(_loc3_ < param1.objectives.length)
         {
            if(!param1.objectives[_loc3_].toRemove)
            {
               param1.objectives[_loc3_].toRemove = true;
               param2.push(param1.objectives[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      private function queueRemoveObjectiveFromTracker(param1:HUDQuestTrackerObjective, param2:HUDQuestTrackerEntry) : void
      {
         // method body index: 1960 method index: 1960
         if(!param1.toRemove)
         {
            param1.toRemove = true;
            this.m_TempObjectivesToRemove.push(param1);
            param2.needArrangeObjectives = true;
            this.m_TempQuestObjectiveUpdates = true;
         }
      }
      
      private function queueAddNewQuestToTracker(param1:Object, param2:Vector.<HUDQuestTrackerEntry>, param3:Vector.<HUDQuestTrackerObjective>, param4:Boolean = false) : HUDQuestTrackerEntry
      {
         // method body index: 1961 method index: 1961
         var _loc5_:HUDQuestTrackerEntry = this.initializeQuest(param1,true);
         _loc5_.tempDisplay = param4;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.objectives.length)
         {
            param3.push(_loc5_.objectives[_loc6_]);
            _loc6_++;
         }
         param2.push(_loc5_);
         this.m_DisplayedQuests.push(_loc5_);
         addChild(_loc5_);
         return _loc5_;
      }
      
      private function initializeUpdateEventInfo(param1:String, param2:Object) : Object
      {
         // method body index: 1962 method index: 1962
         return {
            "questID":param1,
            "data":param2,
            "objectiveUpdates":new Array(),
            "tracked":(param2 != null?this.questDataValidForDisplay(param2):false)
         };
      }
      
      private function processQuestUpdateEvents() : void
      {
         // method body index: 1964 method index: 1964
         this.m_BusyAnimating = true;
         this.m_AnimationPassedRearrange = false;
         var delayMS:uint = 0;
         try
         {
            delayMS = this.doProcessQuestUpdateEvents();
         }
         catch(e:Error)
         {
            GlobalFunc.BSASSERT(false,e.getStackTrace().toString());
         }
         this.m_AnimationPassedRearrange = true;
         setTimeout(function():// method body index: 1963 method index: 1963
         void
         {
            // method body index: 1963 method index: 1963
            m_BusyAnimating = false;
            if(CanAnimate() && m_EventsQueued)
            {
               processQuestUpdateEvents();
            }
         },delayMS);
      }
      
      private function doProcessQuestUpdateEvents() : uint
      {
         // method body index: 1978 method index: 1978
         var newQuests:Vector.<HUDQuestTrackerEntry> = null;
         var objectivesUpdated:Vector.<HUDQuestTrackerObjective> = null;
         var newObjectives:Vector.<HUDQuestTrackerObjective> = null;
         var questsCompleted:Vector.<HUDQuestTrackerEntry> = null;
         var tempDisplayQuests:Vector.<HUDQuestTrackerEntry> = null;
         var tempDisplayObjectives:Vector.<HUDQuestTrackerObjective> = null;
         var objectivesCompleted:Vector.<HUDQuestTrackerObjective> = null;
         var objectivesMergeChanged:Vector.<HUDQuestTrackerObjective> = null;
         var tempQuestData:Object = null;
         var tempObjectiveData:Object = null;
         newQuests = null;
         objectivesUpdated = null;
         newObjectives = null;
         questsCompleted = null;
         tempDisplayQuests = null;
         tempDisplayObjectives = null;
         objectivesCompleted = null;
         objectivesMergeChanged = null;
         var questEvent:Object = null;
         var objectiveEvent:Object = null;
         var questEventData:Object = null;
         var showingEventQuests:Boolean = false;
         var questTrackerEntry:HUDQuestTrackerEntry = null;
         var delayMS:uint = 0;
         var trackerQuest:HUDQuestTrackerEntry = null;
         var objectiveEventData:Object = null;
         var trackerObjective:HUDQuestTrackerObjective = null;
         var sortedEvents:Object = this.consolidateQuestEvents();
         this.m_EventsQueued = false;
         this.m_NeedReposition = false;
         newQuests = new Vector.<HUDQuestTrackerEntry>();
         objectivesUpdated = new Vector.<HUDQuestTrackerObjective>();
         this.m_TempQuestObjectiveUpdates = false;
         newObjectives = new Vector.<HUDQuestTrackerObjective>();
         var questsToRemove:Boolean = false;
         this.m_TempObjectivesToRemove.splice(0,this.m_TempObjectivesToRemove.length);
         questsCompleted = new Vector.<HUDQuestTrackerEntry>();
         tempDisplayQuests = new Vector.<HUDQuestTrackerEntry>();
         tempDisplayObjectives = new Vector.<HUDQuestTrackerObjective>();
         objectivesCompleted = new Vector.<HUDQuestTrackerObjective>();
         objectivesMergeChanged = new Vector.<HUDQuestTrackerObjective>();
         var focusQuestCount:uint = 0;
         this.clearQuestFocusFlags();
         var updateEventInfo:Array = new Array();
         var findQuestEventByID:* = function(param1:*, param2:int, param3:Array):// method body index: 1965 method index: 1965
         Boolean
         {
            // method body index: 1965 method index: 1965
            if(param1.questID == this.ID)
            {
               this.matchIndex = param2;
               return true;
            }
            return false;
         };
         var findObjEventByID:* = function(param1:*, param2:int, param3:Array):// method body index: 1966 method index: 1966
         Boolean
         {
            // method body index: 1966 method index: 1966
            if(param1.objectiveID == this.ID && param1.contextQuestID == this.contextQuestID)
            {
               this.matchIndex = param2;
               return true;
            }
            return false;
         };
         var updateMatchObj:Object = {
            "ID":0,
            "contextQuestID":0,
            "matchIndex":uint.MAX_VALUE
         };
         var questEventIdx:uint = uint.MAX_VALUE;
         var objEventIdx:uint = uint.MAX_VALUE;
         for each(questEvent in sortedEvents.quests)
         {
            tempQuestData = this.getQuestDataByID(questEvent.questID);
            updateMatchObj.ID = questEvent.questID;
            if(!updateEventInfo.some(findQuestEventByID,updateMatchObj))
            {
               questEventIdx = updateEventInfo.length;
               updateEventInfo.push(this.initializeUpdateEventInfo(questEvent.questID,tempQuestData));
            }
            else
            {
               questEventIdx = updateMatchObj.matchIndex;
            }
            switch(questEvent.eventType)
            {
               case QUEST_EVENT_FORCEREARRANGE:
                  this.m_NeedReposition = true;
                  this.m_TempQuestObjectiveUpdates = true;
                  continue;
               case QUEST_EVENT_FAIL:
                  updateEventInfo[questEventIdx].failed = true;
               case QUEST_EVENT_COMPLETE:
                  updateEventInfo[questEventIdx].completed = true;
                  updateEventInfo[questEventIdx].updated = true;
                  continue;
               case QUEST_EVENT_INACTIVE:
                  updateEventInfo[questEventIdx].updated = tempQuestData == null || tempQuestData.isActive == true;
                  continue;
               case QUEST_EVENT_DISPLAYEDTOTEAM:
               case QUEST_EVENT_UNDISPLAYEDTOTEAM:
                  updateEventInfo[questEventIdx].updated = tempQuestData == null || tempQuestData.isDisplayedToTeam == true;
                  continue;
               default:
                  continue;
            }
         }
         for each(objectiveEvent in sortedEvents.objectives)
         {
            tempQuestData = this.getQuestDataByID(objectiveEvent.questID);
            tempObjectiveData = this.getQuestDataObjectiveByID(tempQuestData,objectiveEvent.objectiveID,objectiveEvent.contextQuestID);
            updateMatchObj.ID = objectiveEvent.questID;
            if(!updateEventInfo.some(findQuestEventByID,updateMatchObj))
            {
               questEventIdx = updateEventInfo.length;
               updateEventInfo.push(this.initializeUpdateEventInfo(objectiveEvent.questID,tempQuestData));
            }
            else
            {
               questEventIdx = updateMatchObj.matchIndex;
            }
            updateMatchObj.ID = objectiveEvent.objectiveID;
            updateMatchObj.contextQuestID = objectiveEvent.contextQuestID;
            if(!updateEventInfo[questEventIdx].objectiveUpdates.some(findObjEventByID,updateMatchObj))
            {
               objEventIdx = updateEventInfo[questEventIdx].objectiveUpdates.length;
               updateEventInfo[questEventIdx].objectiveUpdates.push({
                  "questID":objectiveEvent.questID,
                  "objectiveID":objectiveEvent.objectiveID,
                  "contextQuestID":objectiveEvent.contextQuestID,
                  "data":tempObjectiveData
               });
            }
            else
            {
               objEventIdx = updateMatchObj.matchIndex;
            }
            switch(objectiveEvent.eventType)
            {
               case OBJECTIVE_EVENT_FAIL:
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].failed = true;
               case OBJECTIVE_EVENT_COMPLETE:
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].completed = true;
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].remove = true;
                  updateEventInfo[questEventIdx].updated = true;
                  continue;
               case OBJECTIVE_EVENT_UPDATE:
                  updateEventInfo[questEventIdx].updated = true;
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].updated = true;
                  continue;
               case OBJECTIVE_EVENT_REMOVE:
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].remove = true;
                  continue;
               case OBJECTIVE_MERGE_LEADER_CHANGE:
                  updateEventInfo[questEventIdx].updated = true;
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].mergeChange = true;
                  continue;
               default:
                  continue;
            }
         }
         for each(questEventData in updateEventInfo)
         {
            tempQuestData = this.getQuestDataByID(questEventData.questID);
            trackerQuest = this.getDisplayedQuestByID(questEventData.questID);
            if(tempQuestData != null && !tempQuestData.isPending)
            {
               if(trackerQuest == null && (questEventData.updated || questEventData.tracked || this.m_ShouldAllQuestsBeTemp))
               {
                  if(questEventData.tracked && !this.m_ShouldAllQuestsBeTemp)
                  {
                     questEventData.nowTracked = true;
                     trackerQuest = this.queueAddNewQuestToTracker(tempQuestData,newQuests,newObjectives);
                  }
                  else if(this.questDataHasDisplayedObjectives(tempQuestData))
                  {
                     trackerQuest = this.queueAddNewQuestToTracker(tempQuestData,tempDisplayQuests,tempDisplayObjectives,true);
                  }
               }
            }
            if(trackerQuest != null)
            {
               if(questEventData.updated && !questEventData.nowTracked)
               {
                  if(tempQuestData != null)
                  {
                     trackerQuest.title = tempQuestData.title;
                     trackerQuest.isDisplayedToTeam = tempQuestData.isDisplayedToTeam;
                  }
                  trackerQuest.focusQuest = true;
                  focusQuestCount++;
               }
               if(questEventData.completed)
               {
                  questsCompleted.push(trackerQuest);
               }
               if(tempQuestData != null && !questEventData.nowTracked && questEventData.eventType != QUEST_EVENT_INVALID)
               {
                  for each(objectiveEventData in questEventData.objectiveUpdates)
                  {
                     tempObjectiveData = this.getQuestDataObjectiveByID(tempQuestData,objectiveEventData.objectiveID,objectiveEventData.contextQuestID);
                     trackerObjective = this.getDisplayedObjectiveByID(trackerQuest,objectiveEventData.objectiveID,objectiveEventData.contextQuestID);
                     if(tempObjectiveData != null && this.m_testEnabled && objectiveEventData.completed)
                     {
                        tempObjectiveData.state = !!objectiveEventData.failed?QUEST_STATE_FAILED:QUEST_STATE_COMPLETE;
                     }
                     if(trackerObjective)
                     {
                        if(tempObjectiveData != null)
                        {
                           trackerObjective.state = tempObjectiveData.state;
                        }
                        if(objectiveEventData.updated && tempObjectiveData != null)
                        {
                           trackerObjective.title = tempObjectiveData.title;
                           if(tempObjectiveData.isDisplayed && tempObjectiveData.isActive)
                           {
                              objectivesUpdated.push(trackerObjective);
                           }
                           else
                           {
                              this.queueRemoveObjectiveFromTracker(trackerObjective,trackerQuest);
                           }
                        }
                        if(objectiveEventData.completed)
                        {
                           objectivesCompleted.push(trackerObjective);
                        }
                        if(objectiveEventData.remove)
                        {
                           this.queueRemoveObjectiveFromTracker(trackerObjective,trackerQuest);
                        }
                        if(objectiveEventData.mergeChange)
                        {
                           objectivesMergeChanged.push(trackerObjective);
                        }
                     }
                     else if(tempObjectiveData != null && (tempObjectiveData.state == QUEST_STATE_INPROGRESS || objectiveEventData.completed) && tempObjectiveData.isDisplayed && tempObjectiveData.isActive)
                     {
                        trackerObjective = this.initializeObjective(tempObjectiveData);
                        trackerQuest.addObjective(trackerObjective);
                        trackerQuest.needArrangeObjectives = true;
                        this.m_TempQuestObjectiveUpdates = true;
                        if(objectiveEventData.completed)
                        {
                           trackerQuest.focusQuest = true;
                           focusQuestCount++;
                           tempDisplayObjectives.push(trackerObjective);
                           objectivesCompleted.push(trackerObjective);
                           this.queueRemoveObjectiveFromTracker(trackerObjective,trackerQuest);
                        }
                        else
                        {
                           newObjectives.push(trackerObjective);
                        }
                     }
                  }
               }
               if(tempQuestData == null || !questEventData.tracked || this.m_ShouldAllQuestsBeTemp)
               {
                  trackerQuest.toRemove = true;
                  questsToRemove = true;
               }
            }
         }
         showingEventQuests = false;
         for each(questTrackerEntry in this.m_DisplayedQuests)
         {
            if(questTrackerEntry.toRemove)
            {
               this.queueRemoveQuestObjectives(questTrackerEntry,this.m_TempObjectivesToRemove);
            }
            if(questTrackerEntry.isEvent)
            {
               showingEventQuests = true;
            }
         }
         this.setDisplayed(true);
         delayMS = 0;
         if(tempDisplayQuests.length > 0 || tempDisplayObjectives.length > 0)
         {
            setTimeout(function():// method body index: 1967 method index: 1967
            void
            {
               // method body index: 1967 method index: 1967
               if(tempDisplayObjectives.length > 0)
               {
                  arrangeQuestsObjectives();
               }
               arrangeQuests(true);
               clearQuestArrangeFlags();
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_REARRANGE;
            setTimeout(function():// method body index: 1968 method index: 1968
            void
            {
               // method body index: 1968 method index: 1968
               fadeInQuests(tempDisplayQuests);
               fadeInObjectives(tempDisplayObjectives);
            },delayMS);
            delayMS = delayMS + (EVENT_DURATION_QUEST_FADEINOUT + EVENT_DURATION_OBJECTIVE_UPDATE);
         }
         var questFocusAnim:* = focusQuestCount && focusQuestCount != this.m_DisplayedQuests.length;
         if(questFocusAnim)
         {
            setTimeout(function():// method body index: 1969 method index: 1969
            void
            {
               // method body index: 1969 method index: 1969
               focusQuestFade(0.5);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(objectivesUpdated.length > 0)
         {
            setTimeout(function():// method body index: 1970 method index: 1970
            void
            {
               // method body index: 1970 method index: 1970
               animateUpdatedObjectives(objectivesUpdated);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_OBJECTIVE_UPDATE;
         }
         if(questsCompleted.length > 0 || objectivesCompleted.length > 0)
         {
            setTimeout(function():// method body index: 1971 method index: 1971
            void
            {
               // method body index: 1971 method index: 1971
               animateCompletedQuests(questsCompleted);
               animateCompletedObjectives(objectivesCompleted);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(objectivesMergeChanged.length > 0)
         {
            setTimeout(function():// method body index: 1972 method index: 1972
            void
            {
               // method body index: 1972 method index: 1972
               animateObjectivesWithMergeLeaderChange(objectivesMergeChanged);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_OBJECTIVE_UPDATE;
         }
         if(questFocusAnim)
         {
            setTimeout(function():// method body index: 1973 method index: 1973
            void
            {
               // method body index: 1973 method index: 1973
               focusQuestFade(1);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(questsToRemove || this.m_TempObjectivesToRemove.length > 0)
         {
            setTimeout(function():// method body index: 1974 method index: 1974
            void
            {
               // method body index: 1974 method index: 1974
               fadeDeletedObjectives(m_TempObjectivesToRemove);
               fadeDeletedQuests();
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
            this.m_NeedReposition = true;
         }
         if(questsToRemove || this.m_TempObjectivesToRemove.length > 0)
         {
            setTimeout(function():// method body index: 1975 method index: 1975
            void
            {
               // method body index: 1975 method index: 1975
               removeDeletedObjectives(m_TempObjectivesToRemove);
               removeDeletedQuests();
            },delayMS);
         }
         if(newQuests.length > 0 || newObjectives.length > 0)
         {
            this.m_NeedReposition = true;
         }
         if(this.m_TempQuestObjectiveUpdates)
         {
            setTimeout(function():// method body index: 1976 method index: 1976
            void
            {
               // method body index: 1976 method index: 1976
               arrangeQuestsObjectives();
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_REARRANGE;
         }
         if(this.m_NeedReposition || newQuests.length > 0 || newObjectives.length > 0)
         {
            setTimeout(function():// method body index: 1977 method index: 1977
            void
            {
               // method body index: 1977 method index: 1977
               if(m_TempQuestObjectiveUpdates)
               {
                  arrangeQuestsObjectives();
               }
               arrangeQuests(true);
               clearQuestArrangeFlags();
               fadeInQuests(newQuests);
               fadeInObjectives(newObjectives);
            },delayMS);
            if(newQuests.length > 0 || newObjectives.length > 0)
            {
               delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
            }
            else
            {
               delayMS = delayMS + EVENT_DURATION_REARRANGE;
            }
         }
         return delayMS;
      }
      
      private function test_onKeyDown(param1:KeyboardEvent) : void
      {
         // method body index: 1979 method index: 1979
         switch(param1.keyCode)
         {
            case 116:
               if(param1.ctrlKey)
               {
                  if(param1.shiftKey)
                  {
                     this.test_questRemove();
                  }
                  else
                  {
                     this.test_questAdd();
                  }
               }
               else
               {
                  this.test_questComplete(param1.shiftKey);
               }
               break;
            case 117:
               if(param1.ctrlKey)
               {
                  if(param1.shiftKey)
                  {
                     this.test_objectiveRemove();
                  }
                  else
                  {
                     this.test_objectiveAdd();
                  }
               }
               else
               {
                  this.test_objectiveComplete(param1.shiftKey);
               }
               break;
            case 118:
               if(param1.shiftKey)
               {
                  this.test_questStateUpdate("isActive",false,QUEST_EVENT_INACTIVE);
               }
               else
               {
                  this.test_questStateUpdate("isActive",true,QUEST_EVENT_ACTIVE);
               }
               break;
            case 119:
               if(param1.shiftKey)
               {
                  this.test_questStateUpdate("isDisplayedToTeam",false,QUEST_EVENT_UNDISPLAYEDTOTEAM);
               }
               else
               {
                  this.test_questStateUpdate("isDisplayedToTeam",true,QUEST_EVENT_DISPLAYEDTOTEAM);
               }
               break;
            case 123:
               if(param1.shiftKey)
               {
                  this.test_objectiveTimerChange();
               }
               else
               {
                  this.test_questTimerChange();
               }
               break;
            case 114:
               if(param1.ctrlKey)
               {
                  if(param1.shiftKey)
                  {
                     this.test_objectiveAlertChange();
                  }
                  else
                  {
                     this.test_objectiveProgressChange();
                  }
               }
               else
               {
                  this.test_objectiveCountUpdate(param1.shiftKey);
               }
         }
      }
      
      private function registerTestFunctionality() : void
      {
         // method body index: 1980 method index: 1980
         this.m_testEnabled = true;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.test_onKeyDown);
      }
      
      private function test_forceQuestUpdateCallbacks() : *
      {
         // method body index: 1981 method index: 1981
         var _loc1_:HUDQuestTrackerEntry = null;
         var _loc2_:HUDQuestTrackerObjective = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < this.m_DisplayedQuests.length)
         {
            _loc1_ = this.m_DisplayedQuests[_loc4_];
            _loc1_.onQuestDataChange(this.m_QuestData);
            _loc3_ = 0;
            while(_loc3_ < _loc1_.objectives.length)
            {
               _loc2_ = _loc1_.objectives[_loc3_];
               _loc2_.onQuestDataChange(this.m_QuestData);
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      private function test_objectiveProgressChange() : *
      {
         // method body index: 1982 method index: 1982
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newProgress:Number = NaN;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               j = 0;
               while(j < questData.objectives.length)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.progressMax > 0)
                  {
                     foundObjective = true;
                  }
                  j++;
               }
               i++;
            }
            if(foundObjective)
            {
               newProgress = Math.random() * 0.9 + 0.1;
               trace("Progress for quest " + objectiveData.questID + " objective " + objectiveData.objectiveID + " set to " + newProgress);
               objectiveData.progressMeter = newProgress;
               this.test_forceQuestUpdateCallbacks();
            }
            else
            {
               throw new Error("test_objectiveProgressChange : Could not find objective with usable progress.");
            }
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_objectiveTimerChange() : *
      {
         // method body index: 1983 method index: 1983
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newTimer:Number = NaN;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               j = 0;
               while(j < questData.objectives.length)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.timer > 0)
                  {
                     foundObjective = true;
                     break;
                  }
                  j++;
               }
               if(foundObjective)
               {
                  break;
               }
               i++;
            }
            if(foundObjective)
            {
               newTimer = Math.random() * 2000 + 5;
               trace("Timer for quest " + objectiveData.questID + " objective " + objectiveData.objectiveID + " set to " + newTimer);
               objectiveData.timer = newTimer;
               this.test_forceQuestUpdateCallbacks();
            }
            else
            {
               throw new Error("test_objectiveTimerChange : Could not find objective with usable timer.");
            }
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_questTimerChange() : *
      {
         // method body index: 1984 method index: 1984
         var foundQuest:Boolean = false;
         var questData:Object = null;
         var i:uint = 0;
         var newTimer:Number = NaN;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               if(questData.timer > 0)
               {
                  foundQuest = true;
                  break;
               }
               i++;
            }
            if(foundQuest)
            {
               newTimer = Math.random() * 2000 + 5;
               trace("Timer for quest " + questData.questID + " set to " + newTimer);
               questData.timer = newTimer;
               this.test_forceQuestUpdateCallbacks();
            }
            else
            {
               throw new Error("test_objectiveTimerChange : Could not find quest with usable timer.");
            }
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_objectiveAlertChange() : *
      {
         // method body index: 1985 method index: 1985
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newState:uint = 0;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               j = 0;
               while(j < questData.objectives.length)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.announce.length > 0)
                  {
                     foundObjective = true;
                     break;
                  }
                  j++;
               }
               if(foundObjective)
               {
                  break;
               }
               i++;
            }
            if(foundObjective)
            {
               newState = Math.floor(Math.random() * 3) + 1;
               objectiveData.announceState = newState;
               this.test_forceQuestUpdateCallbacks();
               trace("Alert state for quest " + questData.questID + " objective " + objectiveData.objectiveID + " set to " + newState);
            }
            else
            {
               throw new Error("test_objectiveAlertChange - could not find valid objective to change alert state");
            }
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_questStateUpdate(param1:String, param2:Boolean, param3:uint) : *
      {
         // method body index: 1986 method index: 1986
         var aStateType:String = param1;
         var aStateEnabled:Boolean = param2;
         var aEventType:uint = param3;
         var foundQuest:Boolean = false;
         var questID:String = null;
         var questData:Object = null;
         var i:uint = 0;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               if(questData[aStateType] != aStateEnabled)
               {
                  questData[aStateType] = aStateEnabled;
                  foundQuest = true;
                  questID = questData.questID;
               }
               i++;
            }
            if(foundQuest)
            {
               trace("Quest " + questID + " state \'" + aStateType + "\' to " + aStateEnabled + ", event type " + aEventType + " (" + questData.title + ")");
               this.m_TempNewQuestEventData = {
                  "questEvents":[{
                     "eventType":aEventType,
                     "questID":questID
                  }],
                  "objectiveEvents":[]
               };
               this.processNewQuestEventData();
            }
            else
            {
               throw new Error("Could not find quest to change state type \'" + aStateType + "\' to " + aStateEnabled + ", event type " + aEventType);
            }
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_questComplete(param1:Boolean = false) : *
      {
         // method body index: 1987 method index: 1987
         var aFailed:Boolean = param1;
         var foundQuest:Boolean = false;
         var questData:Object = null;
         var i:uint = 0;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               if(this.m_QuestData[i].state > QUEST_STATE_INVALID)
               {
                  if(this.m_QuestData[i].state == QUEST_STATE_INPROGRESS && this.m_QuestData[i].state != (!!aFailed?QUEST_STATE_FAILED:QUEST_STATE_COMPLETE))
                  {
                     questData = this.m_QuestData[i];
                     foundQuest = true;
                     break;
                  }
               }
               i++;
            }
            if(foundQuest)
            {
               trace("TEST | Quest marked as " + (!!aFailed?"failed":"completed") + " : " + questData.title);
               questData.state = !!aFailed?QUEST_STATE_FAILED:QUEST_STATE_COMPLETE;
               this.m_TempNewQuestEventData = {
                  "questEvents":[{
                     "eventType":(!!aFailed?QUEST_EVENT_FAIL:QUEST_EVENT_COMPLETE),
                     "questID":questData.questID
                  }],
                  "objectiveEvents":[]
               };
               this.processNewQuestEventData();
            }
            else
            {
               throw new Error("Unable to find incomplete quest.");
            }
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_createObjective() : Object
      {
         // method body index: 1988 method index: 1988
         var _loc1_:uint = Math.floor(1 + Math.random() * 19);
         var _loc2_:* = Math.random() > 0.5;
         var _loc3_:Number = QUEST_STATE_INPROGRESS;
         return {
            "title":"Test objective " + Math.floor(Math.random() * 256),
            "objectiveID":"tobj" + Math.floor(Math.random() * 256),
            "isOptional":(Math.random() > 0.9?true:false),
            "countMax":(!!_loc2_?_loc1_:0),
            "count":Math.floor(Math.random() * _loc1_),
            "state":_loc3_,
            "timer":(Math.random() > 0.9?Math.floor(Math.random() * 250):false),
            "progressMeter":(Math.random() > 0.8?Math.random():-1),
            "announce":"WARNING",
            "announceState":(Math.random() > 0.9?Math.floor(Math.random() * 3) + 1:0),
            "isDisplayed":true,
            "isActive":true
         };
      }
      
      private function test_questAdd() : *
      {
         // method body index: 1989 method index: 1989
         var _loc1_:String = "tquest" + Math.floor(Math.random() * 256);
         var _loc2_:* = Math.random() > 0.4?true:false;
         var _loc3_:* = Math.random() > 0.4?_loc2_:false;
         var _loc4_:Object = {
            "title":"Test Quest " + Math.floor(Math.random() * 256),
            "questID":_loc1_,
            "state":QUEST_STATE_INPROGRESS,
            "sharedByID":(Math.random() > 0.5?1234:ENTITY_ID_INVALID),
            "objectives":[],
            "stage":100,
            "rewardXP":Math.floor(Math.random() * 240) + 5,
            "rewardCaps":Math.floor(Math.random() * 200) + 1,
            "isActive":true,
            "isDisplayedToTeam":_loc3_,
            "isEventQuest":(Math.random() > 0.4?true:false),
            "isShareable":_loc2_,
            "timer":(Math.random() > 0.25?Math.floor(Math.random() * 250):false)
         };
         var _loc5_:uint = 0;
         while(_loc5_ < Math.floor(Math.random() * 2) + 1)
         {
            _loc4_.objectives.push(this.test_createObjective());
            _loc5_++;
         }
         this.m_TempNewQuestEventData = {
            "objectiveEvents":[],
            "questEvents":[]
         };
         _loc5_ = 0;
         while(_loc5_ < _loc4_.objectives.length)
         {
            this.m_TempNewQuestEventData.objectiveEvents.push({
               "eventType":OBJECTIVE_EVENT_UPDATE,
               "questID":_loc4_.questID,
               "objectiveID":_loc4_.objectives[_loc5_].objectiveID
            });
            _loc5_++;
         }
         this.m_QuestData.push(_loc4_);
         this.processNewQuestEventData();
      }
      
      private function test_questRemove() : void
      {
         // method body index: 1990 method index: 1990
         var removedQuest:Boolean = false;
         var quest:Object = null;
         var i:int = 0;
         try
         {
            removedQuest = false;
            i = this.m_QuestData.length - 1;
            while(i >= 0)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest) && this.getDisplayedQuestByID(quest.questID) != null)
               {
                  trace("removing quest " + i + " : " + quest.title);
                  this.m_QuestData.splice(i,1);
                  removedQuest = true;
                  break;
               }
               i--;
            }
            if(removedQuest)
            {
               trace("removed quest event....");
               this.m_TempNewQuestEventData = {
                  "objectiveEvents":[],
                  "questEvents":[]
               };
               i = 0;
               while(i < quest.objectives.length)
               {
                  this.m_TempNewQuestEventData.objectiveEvents.push({
                     "eventType":OBJECTIVE_EVENT_REMOVE,
                     "questID":quest.questID,
                     "objectiveID":quest.objectives[i].objectiveID
                  });
                  i++;
               }
               this.processNewQuestEventData();
            }
            else
            {
               throw new Error("Unable to remove quest.");
            }
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_objectiveCountUpdate(param1:Boolean = true) : *
      {
         // method body index: 1991 method index: 1991
         var aAdd:Boolean = param1;
         var foundObjective:Boolean = false;
         var quest:Object = null;
         var objective:Object = null;
         var i:uint = 0;
         var oIndex:uint = 0;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(quest.objectives.length > 0 && (quest.isActive || quest.isEventQuest || quest.isDisplayedToTeam))
               {
                  oIndex = 0;
                  while(oIndex < quest.objectives.length)
                  {
                     if(quest.objectives[oIndex].countMax > 0)
                     {
                        objective = quest.objectives[oIndex];
                        foundObjective = true;
                        trace("changing objective " + oIndex + " count for quest:: " + quest.title);
                        if(aAdd)
                        {
                           if(objective.count > 0)
                           {
                              objective.count--;
                           }
                        }
                        else if(objective.count < objective.countMax)
                        {
                           objective.count++;
                        }
                        break;
                     }
                     oIndex++;
                  }
                  if(foundObjective)
                  {
                     break;
                  }
               }
               i++;
            }
            if(!foundObjective)
            {
               throw new Error("Could not find a valid quest + objective w/count.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":OBJECTIVE_EVENT_UPDATE,
                  "questID":quest.questID,
                  "objectiveID":objective.objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_objectiveRemove() : *
      {
         // method body index: 1992 method index: 1992
         var foundObjective:Boolean = false;
         var quest:Object = null;
         var objectiveID:String = null;
         var i:uint = 0;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest))
               {
                  if(quest.objectives.length > 0)
                  {
                     objectiveID = quest.objectives[quest.objectives.length - 1].objectiveID;
                     quest.objectives.splice(-1);
                     foundObjective = true;
                     break;
                  }
               }
               i++;
            }
            if(!foundObjective)
            {
               throw new Error("Could not find a quest with an objective to remove.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":OBJECTIVE_EVENT_REMOVE,
                  "questID":quest.questID,
                  "objectiveID":objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_objectiveAdd() : *
      {
         // method body index: 1993 method index: 1993
         var foundQuest:Boolean = false;
         var quest:Object = null;
         var objective:Object = null;
         var i:uint = 0;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(quest.isActive)
               {
                  trace("quest name is" + quest.title);
                  objective = this.test_createObjective();
                  quest.objectives.push(objective);
                  foundQuest = true;
                  break;
               }
               i++;
            }
            if(!foundQuest)
            {
               throw new Error("Could not find a valid quest.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":OBJECTIVE_EVENT_UPDATE,
                  "questID":quest.questID,
                  "objectiveID":objective.objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
      
      private function test_objectiveComplete(param1:Boolean = false) : *
      {
         // method body index: 1994 method index: 1994
         var aFailed:Boolean = param1;
         var foundQuest:Boolean = false;
         var quest:Object = null;
         var objectiveID:String = null;
         var i:uint = 0;
         var newState:Number = NaN;
         var oIndex:uint = 0;
         var tempQuest:HUDQuestTrackerEntry = null;
         var tempObjective:HUDQuestTrackerObjective = null;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest) && quest.objectives.length > 0)
               {
                  newState = !!aFailed?Number(Number(QUEST_STATE_FAILED)):Number(Number(QUEST_STATE_COMPLETE));
                  oIndex = 0;
                  while(oIndex < quest.objectives.length)
                  {
                     if(quest.objectives[oIndex].state == QUEST_STATE_INPROGRESS && quest.objectives[oIndex].isDisplayed && quest.objectives[oIndex].isActive)
                     {
                        foundQuest = true;
                        trace("TEST | state changed " + quest.objectives[oIndex].state + " -> " + newState);
                        quest.objectives[oIndex].state = newState;
                        objectiveID = quest.objectives[oIndex].objectiveID;
                        tempQuest = this.getDisplayedQuestByID(quest.questID);
                        tempObjective = this.getDisplayedObjectiveByID(tempQuest,quest.objectives[oIndex].objectiveID,quest.objectives[oIndex].contextQuestID);
                        tempObjective.state = newState;
                        break;
                     }
                     oIndex++;
                  }
                  if(foundQuest)
                  {
                     break;
                  }
               }
               i++;
            }
            if(!foundQuest)
            {
               throw new Error("Could not find a valid quest with an objective to modify.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":(!!aFailed?OBJECTIVE_EVENT_FAIL:OBJECTIVE_EVENT_COMPLETE),
                  "questID":quest.questID,
                  "objectiveID":objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
            return;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
            return;
         }
      }
   }
}
