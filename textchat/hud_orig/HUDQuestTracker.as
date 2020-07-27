 
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
      
      public static const QUEST_STATE_INVALID:Number = // method body index: 1988 method index: 1988
      0;
      
      public static const QUEST_STATE_INPROGRESS:Number = // method body index: 1988 method index: 1988
      1;
      
      public static const QUEST_STATE_COMPLETE:Number = // method body index: 1988 method index: 1988
      2;
      
      public static const QUEST_STATE_FAILED:Number = // method body index: 1988 method index: 1988
      3;
      
      public static const EVENT_DURATION_QUEST_FADEINOUT:Number = // method body index: 1988 method index: 1988
      1200;
      
      public static const EVENT_DURATION_OBJECTIVE_UPDATE:Number = // method body index: 1988 method index: 1988
      500;
      
      public static const EVENT_DURATION_REARRANGE:Number = // method body index: 1988 method index: 1988
      350;
      
      public static const QUEST_EVENT_INVALID:uint = // method body index: 1988 method index: 1988
      0;
      
      public static const QUEST_EVENT_COMPLETE:uint = // method body index: 1988 method index: 1988
      1;
      
      public static const QUEST_EVENT_FAIL:uint = // method body index: 1988 method index: 1988
      2;
      
      public static const QUEST_EVENT_ACTIVE:uint = // method body index: 1988 method index: 1988
      3;
      
      public static const QUEST_EVENT_INACTIVE:uint = // method body index: 1988 method index: 1988
      4;
      
      public static const QUEST_EVENT_DISPLAYEDTOTEAM:uint = // method body index: 1988 method index: 1988
      5;
      
      public static const QUEST_EVENT_UNDISPLAYEDTOTEAM:uint = // method body index: 1988 method index: 1988
      6;
      
      public static const QUEST_EVENT_FORCEREARRANGE:Number = // method body index: 1988 method index: 1988
      500;
      
      public static const OBJECTIVE_EVENT_INVALID:uint = // method body index: 1988 method index: 1988
      0;
      
      public static const OBJECTIVE_EVENT_COMPLETE:uint = // method body index: 1988 method index: 1988
      1;
      
      public static const OBJECTIVE_EVENT_FAIL:uint = // method body index: 1988 method index: 1988
      2;
      
      public static const OBJECTIVE_EVENT_UPDATE:uint = // method body index: 1988 method index: 1988
      3;
      
      public static const OBJECTIVE_EVENT_REMOVE:uint = // method body index: 1988 method index: 1988
      4;
      
      public static const OBJECTIVE_MERGE_LEADER_CHANGE:uint = // method body index: 1988 method index: 1988
      5;
      
      public static const QUEST_SPACING:Number = // method body index: 1988 method index: 1988
      16;
      
      public static const TEST_MODE:Boolean = // method body index: 1988 method index: 1988
      false;
      
      public static const ENTITY_ID_INVALID:Number = // method body index: 1988 method index: 1988
      4294967295;
      
      public static const DEBUG_SKIP_ANIMATIONS:Boolean = // method body index: 1988 method index: 1988
      false;
      
      public static const FADE_DELAY_SHORT:Number = // method body index: 1988 method index: 1988
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
         // method body index: 1993 method index: 1993
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
      
      private function eventQuestDividerPos(aPos:Number, aAnimate:Boolean = false) : *
      {
         // method body index: 1989 method index: 1989
         if(this.m_EventQuestDividerTween != null)
         {
            this.m_EventQuestDividerTween.stop();
            this.m_EventQuestDividerTween = null;
         }
         this.m_EventQuestDividerTween = new Tween(this.EventQuestDivider_mc,"y",Regular.easeInOut,this.EventQuestDivider_mc.y,aPos,HUDQuestTracker.EVENT_DURATION_REARRANGE / 1000,true);
      }
      
      public function requestRearrange() : void
      {
         // method body index: 1990 method index: 1990
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
      
      public function setDisplayed(aDisplayed:Boolean) : void
      {
         // method body index: 1991 method index: 1991
         this.m_ShouldDisplay = aDisplayed;
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
      
      private function onHUDModeUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1992 method index: 1992
         this.m_CurrentHUDMode = arEvent.data.hudMode;
         this.m_IsValidHudMode = this.m_ValidHudModes.indexOf(arEvent.data.hudMode) != -1;
         var tmp:* = this.m_CurrentHUDMode == HUDModes.DIALOGUE_MODE;
         if(tmp != this.m_ShouldAllQuestsBeTemp)
         {
            this.m_ShouldAllQuestsBeTemp = tmp;
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
      
      private function onMenuStackChange(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1994 method index: 1994
         var i:* = undefined;
         var invalidMenuFound:Boolean = false;
         if(arEvent.data.menuStackA.length > 0)
         {
            for(i = 0; i < arEvent.data.menuStackA.length; i++)
            {
               switch(arEvent.data.menuStackA[i].menuName)
               {
                  case "PerksMenu":
                  case "WorkshopMenu":
                     invalidMenuFound = true;
               }
            }
            if(invalidMenuFound)
            {
               this.setDisplayed(false);
            }
            else
            {
               this.setDisplayed(true);
            }
         }
      }
      
      private function questDataHasDisplayedObjectives(aQuestData:Object) : Boolean
      {
         // method body index: 1995 method index: 1995
         var objectiveCount:uint = aQuestData.objectives.length;
         var hasDisplayedObjective:Boolean = false;
         for(var i:uint = 0; i < objectiveCount; i++)
         {
            if(aQuestData.objectives[i].isDisplayed && aQuestData.objectives[i].isActive)
            {
               hasDisplayedObjective = true;
               break;
            }
         }
         return objectiveCount > 0 && hasDisplayedObjective;
      }
      
      private function questDataValidForDisplay(aQuestData:Object) : Boolean
      {
         // method body index: 1996 method index: 1996
         if(aQuestData != null)
         {
            return (aQuestData.isActive || aQuestData.isDisplayedToTeam) && aQuestData.state == QUEST_STATE_INPROGRESS && this.questDataHasDisplayedObjectives(aQuestData);
         }
         return false;
      }
      
      public function set nonFocusOpacity(aOpacity:Number) : void
      {
         // method body index: 1997 method index: 1997
         for(var i:uint = 0; i < this.m_DisplayedQuests.length; i++)
         {
            if(this.m_DisplayedQuests[i].focusQuest)
            {
               this.m_DisplayedQuests[i].alpha = 1;
            }
            else
            {
               this.m_DisplayedQuests[i].alpha = aOpacity;
            }
         }
         this.EventQuestDivider_mc.alpha = aOpacity;
      }
      
      private function consolidateQuestEvents() : Object
      {
         // method body index: 1998 method index: 1998
         var questData:* = undefined;
         var questEvents:Array = null;
         var i:uint = 0;
         var sortedEvents:Object = null;
         if(this.m_ForceConsolidateAllQuests)
         {
            questData = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
            questEvents = [];
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               if(this.questDataValidForDisplay(questData[i]))
               {
                  questEvents.push({
                     "questID":questData[i].questID,
                     "eventType":QUEST_EVENT_INVALID
                  });
               }
            }
            sortedEvents = {
               "quests":questEvents,
               "objectives":this.m_PendingObjectiveEvents.slice()
            };
            this.m_ForceConsolidateAllQuests = false;
         }
         else
         {
            sortedEvents = {
               "quests":this.m_PendingQuestEvents.slice(),
               "objectives":this.m_PendingObjectiveEvents.slice()
            };
         }
         this.m_PendingQuestEvents.splice(0);
         this.m_PendingObjectiveEvents.splice(0);
         return sortedEvents;
      }
      
      public function SetAnimationBlocked(aBlock:Boolean) : void
      {
         // method body index: 1999 method index: 1999
         this.m_AnimationsBlocked = aBlock;
         if(this.CanAnimate() && this.m_EventsQueued)
         {
            this.processQuestUpdateEvents();
         }
      }
      
      public function CanAnimate() : Boolean
      {
         // method body index: 2000 method index: 2000
         return !this.m_AnimationsBlocked && !this.m_BusyAnimating;
      }
      
      private function processNewQuestEventData() : void
      {
         // method body index: 2001 method index: 2001
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
         // method body index: 2002 method index: 2002
         var trackerQuest:HUDQuestTrackerEntry = null;
         var questData:Object = null;
         var trackerObjective:HUDQuestTrackerObjective = null;
         var objectiveData:Object = null;
         for each(trackerQuest in this.m_DisplayedQuests)
         {
            for each(questData in this.m_QuestData)
            {
               if(trackerQuest.questID == questData.questID)
               {
                  trackerQuest.title = questData.title;
                  for each(trackerObjective in trackerQuest.objectives)
                  {
                     for each(objectiveData in questData.objectives)
                     {
                        if(trackerObjective.objectiveID == objectiveData.objectiveID && (trackerQuest.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || trackerObjective.contextQuestID == objectiveData.contextQuestID))
                        {
                           trackerObjective.title = objectiveData.title;
                        }
                     }
                  }
                  break;
               }
            }
         }
      }
      
      private function onQuestEventsUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 2003 method index: 2003
         if(arEvent.data.testEnable == true && this.m_testEnabled == false)
         {
            this.registerTestFunctionality();
         }
         if(DEBUG_SKIP_ANIMATIONS)
         {
            this.populateFull();
            return;
         }
         var newQuestEvents:Array = [];
         var newObjectiveEvents:Array = [];
         this.m_QuestData = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
         if(!this.m_Initialized && this.m_QuestData != null && this.m_QuestData.length > 0)
         {
            this.populateFull();
            this.m_Initialized = true;
         }
         for(var i:uint = 0; i < arEvent.data.questEvents.length; i++)
         {
            newQuestEvents.push({
               "questID":arEvent.data.questEvents[i].questID,
               "eventType":arEvent.data.questEvents[i].eventType
            });
         }
         for(i = 0; i < arEvent.data.objectiveEvents.length; i++)
         {
            newObjectiveEvents.push({
               "questID":arEvent.data.objectiveEvents[i].questID,
               "objectiveID":arEvent.data.objectiveEvents[i].objectiveID,
               "eventType":arEvent.data.objectiveEvents[i].eventType,
               "contextQuestID":arEvent.data.objectiveEvents[i].contextQuestID
            });
         }
         this.m_TempNewQuestEventData = {
            "questEvents":newQuestEvents,
            "objectiveEvents":newObjectiveEvents
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
         // method body index: 2004 method index: 2004
         this.m_Displayed = true;
         this.clearTween();
         this.endHideTimeout();
         this.visible = true;
         this.alpha = 1;
      }
      
      public function fadeOut() : void
      {
         // method body index: 2005 method index: 2005
         this.m_HideTimeout = -1;
         this.m_FadeTween = new Tween(this,"alpha",Regular.easeInOut,1,0,1,true);
         this.m_Displayed = false;
      }
      
      private function clearTween() : void
      {
         // method body index: 2006 method index: 2006
         if(this.m_FadeTween != null)
         {
            this.m_FadeTween.stop();
            this.m_FadeTween = null;
         }
      }
      
      private function endHideTimeout() : void
      {
         // method body index: 2007 method index: 2007
         if(this.m_HideTimeout != -1)
         {
            clearTimeout(this.m_HideTimeout);
            this.m_HideTimeout = -1;
         }
      }
      
      public function hide() : void
      {
         // method body index: 2008 method index: 2008
         this.m_Displayed = false;
         this.endHideTimeout();
         this.clearTween();
         this.visible = false;
      }
      
      private function sortDisplayedQuests(a:HUDQuestTrackerEntry, b:HUDQuestTrackerEntry) : Number
      {
         // method body index: 2009 method index: 2009
         if(a.isEvent && !b.isEvent)
         {
            return -1;
         }
         if(!a.isEvent && b.isEvent)
         {
            return 1;
         }
         if(!a.tempDisplay && b.tempDisplay)
         {
            return -1;
         }
         if(a.tempDisplay && !b.tempDisplay)
         {
            return 1;
         }
         return a.sortIndex - b.sortIndex;
      }
      
      private function eventQuestDividerVisible(aVisible:Boolean) : *
      {
         // method body index: 2010 method index: 2010
         if(aVisible)
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
      
      public function arrangeQuests(aAnimate:Boolean = false) : void
      {
         // method body index: 2011 method index: 2011
         var i:int = 0;
         var curClip:HUDQuestTrackerEntry = null;
         for(i = 0; i < this.m_DisplayedQuests.length; i++)
         {
            this.m_DisplayedQuests[i].sortIndex = i;
            if(this.m_DisplayedQuests[i].questDisplayType == GlobalFunc.QUEST_DISPLAY_TYPE_MISC)
            {
               this.m_DisplayedQuests[i].sortIndex = int.MAX_VALUE;
            }
         }
         this.m_DisplayedQuests.sort(this.sortDisplayedQuests);
         var showDivider:Boolean = false;
         var eventSection:Boolean = false;
         var posY:Number = 0;
         for(i = 0; i < this.m_DisplayedQuests.length; i++)
         {
            if(this.m_DisplayedQuests[i].isEvent)
            {
               eventSection = true;
            }
            else
            {
               if(eventSection)
               {
                  if(aAnimate)
                  {
                     this.eventQuestDividerPos(posY);
                  }
                  else
                  {
                     this.EventQuestDivider_mc.y = posY + QUEST_SPACING;
                  }
                  posY = posY + (this.EventQuestDivider_mc.Sizer_mc.height + QUEST_SPACING);
                  showDivider = true;
               }
               eventSection = false;
            }
            curClip = this.m_DisplayedQuests[i];
            curClip.setYPos(posY,aAnimate);
            posY = posY + curClip.fullHeight + QUEST_SPACING;
         }
         this.eventQuestDividerVisible(showDivider);
         this.m_EventQuestDividerVisible = showDivider;
      }
      
      private function initializeObjective(aObjectiveData:Object) : HUDQuestTrackerObjective
      {
         // method body index: 2012 method index: 2012
         var newObjective:HUDQuestTrackerObjective = new HUDQuestTrackerObjective();
         newObjective.title = aObjectiveData.title;
         newObjective.state = aObjectiveData.state;
         newObjective.isOptional = aObjectiveData.isOptional;
         newObjective.objectiveID = aObjectiveData.objectiveID;
         newObjective.isOrObjective = aObjectiveData.isOrObjective;
         newObjective.useProvider = true;
         newObjective.timer = aObjectiveData.timer;
         newObjective.progress = aObjectiveData.progressMeter;
         newObjective.alertMessage = aObjectiveData.announce;
         newObjective.alertState = aObjectiveData.announceState;
         newObjective.contextQuestID = aObjectiveData.contextQuestID;
         if(newObjective.isOrObjective)
         {
            newObjective.title = "$$QUEST_TRACKER_OBJECTIVE_OR_PREFIX " + newObjective.title;
         }
         newObjective.isMergedLeaderObjective = aObjectiveData.isMergedLeaderObj;
         return newObjective;
      }
      
      private function initializeQuest(aQuestData:Object, aAnimate:Boolean = false) : HUDQuestTrackerEntry
      {
         // method body index: 2013 method index: 2013
         var newObjective:HUDQuestTrackerObjective = null;
         var objectiveData:Object = null;
         var objectiveKey:* = undefined;
         var newQuest:HUDQuestTrackerEntry = new HUDQuestTrackerEntry();
         newQuest.tracker = this;
         newQuest.title = aQuestData.title;
         newQuest.questID = aQuestData.questID;
         newQuest.state = aQuestData.state;
         newQuest.isEvent = aQuestData.isEventQuest;
         newQuest.isDisplayedToTeam = aQuestData.isDisplayedToTeam;
         newQuest.questDisplayType = aQuestData.questDisplayType;
         newQuest.isShareable = aQuestData.isShareable;
         newQuest.useProvider = true;
         newQuest.timer = aQuestData.timer;
         for(objectiveKey in aQuestData.objectives)
         {
            objectiveData = aQuestData.objectives[objectiveKey];
            if(objectiveData.state == QUEST_STATE_INPROGRESS && objectiveData.isDisplayed && objectiveData.isActive)
            {
               newObjective = this.initializeObjective(objectiveData);
               newObjective.questID = newQuest.questID;
               newQuest.addObjective(newObjective);
               if(!aAnimate)
               {
                  newObjective.stateUpdate();
               }
            }
         }
         newQuest.arrangeObjectives();
         return newQuest;
      }
      
      private function populateFull() : void
      {
         // method body index: 2014 method index: 2014
         var tempQuest:HUDQuestTrackerEntry = null;
         var quest:Object = null;
         var newQuest:HUDQuestTrackerEntry = null;
         this.m_BusyAnimating = false;
         var displayedQuestCount:* = this.m_DisplayedQuests.length;
         while(displayedQuestCount > 0)
         {
            tempQuest = this.m_DisplayedQuests.pop();
            tempQuest.useProvider = false;
            removeChild(tempQuest);
            displayedQuestCount--;
         }
         this.setDisplayed(true);
         for(var i:uint = 0; i < this.m_QuestData.length; i++)
         {
            quest = this.m_QuestData[i];
            if(this.questDataValidForDisplay(quest))
            {
               newQuest = this.initializeQuest(quest);
               newQuest.stateUpdate();
               this.m_DisplayedQuests.push(newQuest);
               addChild(newQuest);
            }
         }
         this.arrangeQuests();
      }
      
      private function getQuestDataByID(aQuestID:uint) : Object
      {
         // method body index: 2015 method index: 2015
         for(var i:uint = 0; i < this.m_QuestData.length; i++)
         {
            if(this.m_QuestData[i].questID == aQuestID)
            {
               return this.m_QuestData[i];
            }
         }
         return null;
      }
      
      private function getQuestDataObjectiveByID(aQuest:Object, aObjectiveID:uint, aContextQuestID:uint) : *
      {
         // method body index: 2016 method index: 2016
         var i:uint = 0;
         if(aQuest != null)
         {
            for(i = 0; i < aQuest.objectives.length; i++)
            {
               if(aQuest.objectives[i].objectiveID == aObjectiveID && (aQuest.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || aQuest.objectives[i].contextQuestID == aContextQuestID))
               {
                  return aQuest.objectives[i];
               }
            }
         }
         return null;
      }
      
      private function getDisplayedQuestByID(aQuestID:uint) : HUDQuestTrackerEntry
      {
         // method body index: 2017 method index: 2017
         for(var i:uint = 0; i < this.m_DisplayedQuests.length; i++)
         {
            if(this.m_DisplayedQuests[i].questID == aQuestID)
            {
               return this.m_DisplayedQuests[i];
            }
         }
         return null;
      }
      
      private function getDisplayedObjectiveByID(aQuest:HUDQuestTrackerEntry, aObjectiveID:uint, aContextQuestID:uint) : HUDQuestTrackerObjective
      {
         // method body index: 2018 method index: 2018
         for(var i:uint = 0; i < aQuest.objectives.length; i++)
         {
            if(aQuest.objectives[i].objectiveID == aObjectiveID && (aQuest.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || aQuest.objectives[i].contextQuestID == aContextQuestID))
            {
               return aQuest.objectives[i];
            }
         }
         return null;
      }
      
      private function animateUpdatedObjectives(aUpdatedObjectives:Vector.<HUDQuestTrackerObjective>) : *
      {
         // method body index: 2019 method index: 2019
         for(var i:uint = 0; i < aUpdatedObjectives.length; i++)
         {
            aUpdatedObjectives[i].animateUpdate();
         }
      }
      
      private function fadeDeletedQuests() : void
      {
         // method body index: 2020 method index: 2020
         for(var i:int = this.m_DisplayedQuests.length - 1; i >= 0; i--)
         {
            if(this.m_DisplayedQuests[i].toRemove)
            {
               this.m_DisplayedQuests[i].fadeOut();
            }
         }
      }
      
      private function fadeDeletedObjectives(aDeletedObjectives:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 2021 method index: 2021
         for(var i:uint = 0; i < aDeletedObjectives.length; i++)
         {
            aDeletedObjectives[i].fadeOut();
         }
      }
      
      private function removeDeletedQuests() : void
      {
         // method body index: 2022 method index: 2022
         for(var i:int = this.m_DisplayedQuests.length - 1; i >= 0; i--)
         {
            if(this.m_DisplayedQuests[i].toRemove)
            {
               this.m_DisplayedQuests[i].useProvider = false;
               this.removeChild(this.m_DisplayedQuests[i]);
               this.m_DisplayedQuests.splice(i,1);
            }
         }
      }
      
      private function removeDeletedObjectives(aDeletedObjectives:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 2023 method index: 2023
         for(var i:uint = 0; i < aDeletedObjectives.length; i++)
         {
            (aDeletedObjectives[i].parent as HUDQuestTrackerEntry).deleteObjective(aDeletedObjectives[i]);
         }
      }
      
      private function animateCompletedQuests(aCompletedQuests:Vector.<HUDQuestTrackerEntry>) : void
      {
         // method body index: 2024 method index: 2024
         for(var i:uint = 0; i < aCompletedQuests.length; i++)
         {
            aCompletedQuests[i].stateUpdate(true);
         }
      }
      
      private function animateCompletedObjectives(aCompletedObjectives:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 2025 method index: 2025
         for(var i:uint = 0; i < aCompletedObjectives.length; i++)
         {
            aCompletedObjectives[i].stateUpdate(true);
         }
      }
      
      private function animateObjectivesWithMergeLeaderChange(aMergeChangeObjectives:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 2026 method index: 2026
         for(var i:uint = 0; i < aMergeChangeObjectives.length; i++)
         {
            aMergeChangeObjectives[i].mergeStateUpdate();
         }
      }
      
      private function fadeInQuests(aNewQuests:Vector.<HUDQuestTrackerEntry>) : *
      {
         // method body index: 2027 method index: 2027
         for(var i:uint = 0; i < aNewQuests.length; i++)
         {
            aNewQuests[i].fadeIn();
         }
      }
      
      private function fadeInObjectives(aNewObjectives:Vector.<HUDQuestTrackerObjective>) : *
      {
         // method body index: 2028 method index: 2028
         for(var i:uint = 0; i < aNewObjectives.length; i++)
         {
            aNewObjectives[i].fadeIn();
         }
      }
      
      private function focusQuestFade(aNonFocusAlpha:Number) : *
      {
         // method body index: 2029 method index: 2029
         if(this.m_FocusFadeTween != null)
         {
            this.m_FocusFadeTween.stop();
            this.m_FocusFadeTween = null;
         }
         this.m_FocusFadeTween = new Tween(this,"nonFocusOpacity",None.easeNone,this.m_LastNonFocusAlpha,aNonFocusAlpha,HUDQuestTracker.EVENT_DURATION_QUEST_FADEINOUT / 1000,true);
         this.m_LastNonFocusAlpha = aNonFocusAlpha;
      }
      
      private function arrangeQuestsObjectives() : void
      {
         // method body index: 2030 method index: 2030
         for(var i:uint = 0; i < this.m_DisplayedQuests.length; i++)
         {
            if(true || this.m_DisplayedQuests[i].needArrangeObjectives)
            {
               this.m_DisplayedQuests[i].arrangeObjectives(true);
            }
         }
      }
      
      private function clearQuestArrangeFlags() : void
      {
         // method body index: 2031 method index: 2031
         for(var i:uint = 0; i < this.m_DisplayedQuests.length; i++)
         {
            this.m_DisplayedQuests[i].needArrangeObjectives = false;
         }
      }
      
      private function clearQuestFocusFlags() : void
      {
         // method body index: 2032 method index: 2032
         for(var i:uint = 0; i < this.m_DisplayedQuests.length; i++)
         {
            this.m_DisplayedQuests[i].focusQuest = false;
         }
      }
      
      public function queueRemoveQuestObjectives(aQuest:HUDQuestTrackerEntry, aObjectivesToRemove:Vector.<HUDQuestTrackerObjective>) : void
      {
         // method body index: 2033 method index: 2033
         for(var i:* = 0; i < aQuest.objectives.length; i++)
         {
            if(!aQuest.objectives[i].toRemove)
            {
               aQuest.objectives[i].toRemove = true;
               aObjectivesToRemove.push(aQuest.objectives[i]);
            }
         }
      }
      
      private function queueRemoveObjectiveFromTracker(aTempObjective:HUDQuestTrackerObjective, aTempQuest:HUDQuestTrackerEntry) : void
      {
         // method body index: 2034 method index: 2034
         if(!aTempObjective.toRemove)
         {
            aTempObjective.toRemove = true;
            this.m_TempObjectivesToRemove.push(aTempObjective);
            aTempQuest.needArrangeObjectives = true;
            this.m_TempQuestObjectiveUpdates = true;
         }
      }
      
      private function queueAddNewQuestToTracker(aQuestData:Object, aNewQuestList:Vector.<HUDQuestTrackerEntry>, aNewObjectives:Vector.<HUDQuestTrackerObjective>, aTempDisplay:Boolean = false) : HUDQuestTrackerEntry
      {
         // method body index: 2035 method index: 2035
         var tempQuest:HUDQuestTrackerEntry = this.initializeQuest(aQuestData,true);
         tempQuest.tempDisplay = aTempDisplay;
         for(var j:int = 0; j < tempQuest.objectives.length; j++)
         {
            aNewObjectives.push(tempQuest.objectives[j]);
         }
         aNewQuestList.push(tempQuest);
         this.m_DisplayedQuests.push(tempQuest);
         addChild(tempQuest);
         return tempQuest;
      }
      
      private function initializeUpdateEventInfo(aQuestID:String, aQuestData:Object) : Object
      {
         // method body index: 2036 method index: 2036
         return {
            "questID":aQuestID,
            "data":aQuestData,
            "objectiveUpdates":new Array(),
            "tracked":(aQuestData != null?this.questDataValidForDisplay(aQuestData):false)
         };
      }
      
      private function processQuestUpdateEvents() : void
      {
         // method body index: 2038 method index: 2038
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
         setTimeout(function():// method body index: 2037 method index: 2037
         void
         {
            // method body index: 2037 method index: 2037
            m_BusyAnimating = false;
            if(CanAnimate() && m_EventsQueued)
            {
               processQuestUpdateEvents();
            }
         },delayMS);
      }
      
      private function doProcessQuestUpdateEvents() : uint
      {
         // method body index: 2052 method index: 2052
         var tempQuestData:Object = null;
         var tempObjectiveData:Object = null;
         var newQuests:Vector.<HUDQuestTrackerEntry> = null;
         var objectivesUpdated:Vector.<HUDQuestTrackerObjective> = null;
         var newObjectives:Vector.<HUDQuestTrackerObjective> = null;
         var questsCompleted:Vector.<HUDQuestTrackerEntry> = null;
         var tempDisplayQuests:Vector.<HUDQuestTrackerEntry> = null;
         var tempDisplayObjectives:Vector.<HUDQuestTrackerObjective> = null;
         var objectivesCompleted:Vector.<HUDQuestTrackerObjective> = null;
         var objectivesMergeChanged:Vector.<HUDQuestTrackerObjective> = null;
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
         var findQuestEventByID:* = function(item:*, index:int, array:Array):// method body index: 2039 method index: 2039
         Boolean
         {
            // method body index: 2039 method index: 2039
            if(item.questID == this.ID)
            {
               this.matchIndex = index;
               return true;
            }
            return false;
         };
         var findObjEventByID:* = function(item:*, index:int, array:Array):// method body index: 2040 method index: 2040
         Boolean
         {
            // method body index: 2040 method index: 2040
            if(item.objectiveID == this.ID && item.contextQuestID == this.contextQuestID)
            {
               this.matchIndex = index;
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
            setTimeout(function():// method body index: 2041 method index: 2041
            void
            {
               // method body index: 2041 method index: 2041
               if(tempDisplayObjectives.length > 0)
               {
                  arrangeQuestsObjectives();
               }
               arrangeQuests(true);
               clearQuestArrangeFlags();
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_REARRANGE;
            setTimeout(function():// method body index: 2042 method index: 2042
            void
            {
               // method body index: 2042 method index: 2042
               fadeInQuests(tempDisplayQuests);
               fadeInObjectives(tempDisplayObjectives);
            },delayMS);
            delayMS = delayMS + (EVENT_DURATION_QUEST_FADEINOUT + EVENT_DURATION_OBJECTIVE_UPDATE);
         }
         var questFocusAnim:* = focusQuestCount && focusQuestCount != this.m_DisplayedQuests.length;
         if(questFocusAnim)
         {
            setTimeout(function():// method body index: 2043 method index: 2043
            void
            {
               // method body index: 2043 method index: 2043
               focusQuestFade(0.5);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(objectivesUpdated.length > 0)
         {
            setTimeout(function():// method body index: 2044 method index: 2044
            void
            {
               // method body index: 2044 method index: 2044
               animateUpdatedObjectives(objectivesUpdated);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_OBJECTIVE_UPDATE;
         }
         if(questsCompleted.length > 0 || objectivesCompleted.length > 0)
         {
            setTimeout(function():// method body index: 2045 method index: 2045
            void
            {
               // method body index: 2045 method index: 2045
               animateCompletedQuests(questsCompleted);
               animateCompletedObjectives(objectivesCompleted);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(objectivesMergeChanged.length > 0)
         {
            setTimeout(function():// method body index: 2046 method index: 2046
            void
            {
               // method body index: 2046 method index: 2046
               animateObjectivesWithMergeLeaderChange(objectivesMergeChanged);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_OBJECTIVE_UPDATE;
         }
         if(questFocusAnim)
         {
            setTimeout(function():// method body index: 2047 method index: 2047
            void
            {
               // method body index: 2047 method index: 2047
               focusQuestFade(1);
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(questsToRemove || this.m_TempObjectivesToRemove.length > 0)
         {
            setTimeout(function():// method body index: 2048 method index: 2048
            void
            {
               // method body index: 2048 method index: 2048
               fadeDeletedObjectives(m_TempObjectivesToRemove);
               fadeDeletedQuests();
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_QUEST_FADEINOUT;
            this.m_NeedReposition = true;
         }
         if(questsToRemove || this.m_TempObjectivesToRemove.length > 0)
         {
            setTimeout(function():// method body index: 2049 method index: 2049
            void
            {
               // method body index: 2049 method index: 2049
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
            setTimeout(function():// method body index: 2050 method index: 2050
            void
            {
               // method body index: 2050 method index: 2050
               arrangeQuestsObjectives();
            },delayMS);
            delayMS = delayMS + EVENT_DURATION_REARRANGE;
         }
         if(this.m_NeedReposition || newQuests.length > 0 || newObjectives.length > 0)
         {
            setTimeout(function():// method body index: 2051 method index: 2051
            void
            {
               // method body index: 2051 method index: 2051
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
      
      private function test_onKeyDown(event:KeyboardEvent) : void
      {
         // method body index: 2053 method index: 2053
         switch(event.keyCode)
         {
            case 116:
               if(event.ctrlKey)
               {
                  if(event.shiftKey)
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
                  this.test_questComplete(event.shiftKey);
               }
               break;
            case 117:
               if(event.ctrlKey)
               {
                  if(event.shiftKey)
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
                  this.test_objectiveComplete(event.shiftKey);
               }
               break;
            case 118:
               if(event.shiftKey)
               {
                  this.test_questStateUpdate("isActive",false,QUEST_EVENT_INACTIVE);
               }
               else
               {
                  this.test_questStateUpdate("isActive",true,QUEST_EVENT_ACTIVE);
               }
               break;
            case 119:
               if(event.shiftKey)
               {
                  this.test_questStateUpdate("isDisplayedToTeam",false,QUEST_EVENT_UNDISPLAYEDTOTEAM);
               }
               else
               {
                  this.test_questStateUpdate("isDisplayedToTeam",true,QUEST_EVENT_DISPLAYEDTOTEAM);
               }
               break;
            case 123:
               if(event.shiftKey)
               {
                  this.test_objectiveTimerChange();
               }
               else
               {
                  this.test_questTimerChange();
               }
               break;
            case 114:
               if(event.ctrlKey)
               {
                  if(event.shiftKey)
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
                  this.test_objectiveCountUpdate(event.shiftKey);
               }
         }
      }
      
      private function registerTestFunctionality() : void
      {
         // method body index: 2054 method index: 2054
         this.m_testEnabled = true;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.test_onKeyDown);
      }
      
      private function test_forceQuestUpdateCallbacks() : *
      {
         // method body index: 2055 method index: 2055
         var displayedQuest:HUDQuestTrackerEntry = null;
         var displayedObjective:HUDQuestTrackerObjective = null;
         var j:uint = 0;
         for(var i:uint = 0; i < this.m_DisplayedQuests.length; i++)
         {
            displayedQuest = this.m_DisplayedQuests[i];
            displayedQuest.onQuestDataChange(this.m_QuestData);
            for(j = 0; j < displayedQuest.objectives.length; j++)
            {
               displayedObjective = displayedQuest.objectives[j];
               displayedObjective.onQuestDataChange(this.m_QuestData);
            }
         }
      }
      
      private function test_objectiveProgressChange() : *
      {
         // method body index: 2056 method index: 2056
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newProgress:Number = NaN;
         try
         {
            foundObjective = false;
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               questData = this.m_QuestData[i];
               for(j = 0; j < questData.objectives.length; j++)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.progressMax > 0)
                  {
                     foundObjective = true;
                  }
               }
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveTimerChange() : *
      {
         // method body index: 2057 method index: 2057
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newTimer:Number = NaN;
         try
         {
            foundObjective = false;
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               questData = this.m_QuestData[i];
               for(j = 0; j < questData.objectives.length; j++)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.timer > 0)
                  {
                     foundObjective = true;
                     break;
                  }
               }
               if(foundObjective)
               {
                  break;
               }
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_questTimerChange() : *
      {
         // method body index: 2058 method index: 2058
         var foundQuest:Boolean = false;
         var questData:Object = null;
         var i:uint = 0;
         var newTimer:Number = NaN;
         try
         {
            foundQuest = false;
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               questData = this.m_QuestData[i];
               if(questData.timer > 0)
               {
                  foundQuest = true;
                  break;
               }
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveAlertChange() : *
      {
         // method body index: 2059 method index: 2059
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newState:uint = 0;
         try
         {
            foundObjective = false;
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               questData = this.m_QuestData[i];
               for(j = 0; j < questData.objectives.length; j++)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.announce.length > 0)
                  {
                     foundObjective = true;
                     break;
                  }
               }
               if(foundObjective)
               {
                  break;
               }
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_questStateUpdate(aStateType:String, aStateEnabled:Boolean, aEventType:uint) : *
      {
         // method body index: 2060 method index: 2060
         var foundQuest:Boolean = false;
         var questID:String = null;
         var questData:Object = null;
         var i:uint = 0;
         try
         {
            foundQuest = false;
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               questData = this.m_QuestData[i];
               if(questData[aStateType] != aStateEnabled)
               {
                  questData[aStateType] = aStateEnabled;
                  foundQuest = true;
                  questID = questData.questID;
               }
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_questComplete(aFailed:Boolean = false) : *
      {
         // method body index: 2061 method index: 2061
         var foundQuest:Boolean = false;
         var questData:Object = null;
         var i:uint = 0;
         try
         {
            foundQuest = false;
            for(i = 0; i < this.m_QuestData.length; i++)
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_createObjective() : Object
      {
         // method body index: 2062 method index: 2062
         var objectiveCountMax:uint = Math.floor(1 + Math.random() * 19);
         var hasCount:* = Math.random() > 0.5;
         var newState:Number = QUEST_STATE_INPROGRESS;
         return {
            "title":"Test objective " + Math.floor(Math.random() * 256),
            "objectiveID":"tobj" + Math.floor(Math.random() * 256),
            "isOptional":(Math.random() > 0.9?true:false),
            "countMax":(!!hasCount?objectiveCountMax:0),
            "count":Math.floor(Math.random() * objectiveCountMax),
            "state":newState,
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
         // method body index: 2063 method index: 2063
         var questID:String = "tquest" + Math.floor(Math.random() * 256);
         var isShareable:* = Math.random() > 0.4?true:false;
         var isDisplayedToTeam:* = Math.random() > 0.4?isShareable:false;
         var newQuest:Object = {
            "title":"Test Quest " + Math.floor(Math.random() * 256),
            "questID":questID,
            "state":QUEST_STATE_INPROGRESS,
            "sharedByID":(Math.random() > 0.5?1234:ENTITY_ID_INVALID),
            "objectives":[],
            "stage":100,
            "rewardXP":Math.floor(Math.random() * 240) + 5,
            "rewardCaps":Math.floor(Math.random() * 200) + 1,
            "isActive":true,
            "isDisplayedToTeam":isDisplayedToTeam,
            "isEventQuest":(Math.random() > 0.4?true:false),
            "isShareable":isShareable,
            "timer":(Math.random() > 0.25?Math.floor(Math.random() * 250):false)
         };
         for(var i:uint = 0; i < Math.floor(Math.random() * 2) + 1; i++)
         {
            newQuest.objectives.push(this.test_createObjective());
         }
         this.m_TempNewQuestEventData = {
            "objectiveEvents":[],
            "questEvents":[]
         };
         for(i = 0; i < newQuest.objectives.length; i++)
         {
            this.m_TempNewQuestEventData.objectiveEvents.push({
               "eventType":OBJECTIVE_EVENT_UPDATE,
               "questID":newQuest.questID,
               "objectiveID":newQuest.objectives[i].objectiveID
            });
         }
         this.m_QuestData.push(newQuest);
         this.processNewQuestEventData();
      }
      
      private function test_questRemove() : void
      {
         // method body index: 2064 method index: 2064
         var removedQuest:Boolean = false;
         var quest:Object = null;
         var i:int = 0;
         try
         {
            removedQuest = false;
            for(i = this.m_QuestData.length - 1; i >= 0; i--)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest) && this.getDisplayedQuestByID(quest.questID) != null)
               {
                  trace("removing quest " + i + " : " + quest.title);
                  this.m_QuestData.splice(i,1);
                  removedQuest = true;
                  break;
               }
            }
            if(removedQuest)
            {
               trace("removed quest event....");
               this.m_TempNewQuestEventData = {
                  "objectiveEvents":[],
                  "questEvents":[]
               };
               for(i = 0; i < quest.objectives.length; i++)
               {
                  this.m_TempNewQuestEventData.objectiveEvents.push({
                     "eventType":OBJECTIVE_EVENT_REMOVE,
                     "questID":quest.questID,
                     "objectiveID":quest.objectives[i].objectiveID
                  });
               }
               this.processNewQuestEventData();
            }
            else
            {
               throw new Error("Unable to remove quest.");
            }
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveCountUpdate(aAdd:Boolean = true) : *
      {
         // method body index: 2065 method index: 2065
         var foundObjective:Boolean = false;
         var quest:Object = null;
         var objective:Object = null;
         var i:uint = 0;
         var oIndex:uint = 0;
         try
         {
            foundObjective = false;
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               quest = this.m_QuestData[i];
               if(quest.objectives.length > 0 && (quest.isActive || quest.isEventQuest || quest.isDisplayedToTeam))
               {
                  for(oIndex = 0; oIndex < quest.objectives.length; oIndex++)
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
                  }
                  if(foundObjective)
                  {
                     break;
                  }
               }
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveRemove() : *
      {
         // method body index: 2066 method index: 2066
         var foundObjective:Boolean = false;
         var quest:Object = null;
         var objectiveID:String = null;
         var i:uint = 0;
         try
         {
            foundObjective = false;
            for(i = 0; i < this.m_QuestData.length; i++)
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveAdd() : *
      {
         // method body index: 2067 method index: 2067
         var foundQuest:Boolean = false;
         var quest:Object = null;
         var objective:Object = null;
         var i:uint = 0;
         try
         {
            foundQuest = false;
            for(i = 0; i < this.m_QuestData.length; i++)
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveComplete(aFailed:Boolean = false) : *
      {
         // method body index: 2068 method index: 2068
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
            for(i = 0; i < this.m_QuestData.length; i++)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest) && quest.objectives.length > 0)
               {
                  newState = !!aFailed?Number(QUEST_STATE_FAILED):Number(QUEST_STATE_COMPLETE);
                  for(oIndex = 0; oIndex < quest.objectives.length; oIndex++)
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
                  }
                  if(foundQuest)
                  {
                     break;
                  }
               }
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
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
   }
}
