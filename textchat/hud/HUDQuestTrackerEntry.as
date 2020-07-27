 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import fl.transitions.Tween;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDQuestTrackerEntry extends MovieClip
   {
      
      public static const TIMER_CRITICAL_THRESHOLD:Number = // method body index: 1996 method index: 1996
      60;
       
      
      public var Marker_mc:MovieClip;
      
      public var Icon_mc:MovieClip;
      
      public var LinkedRewardsIcon_mc:MovieClip;
      
      public var Title_mc:MovieClip;
      
      public var Sizer_mc:MovieClip;
      
      public var Timer_mc:MovieClip;
      
      public var QuestTrackerEntryTitleDummy:MovieClip;
      
      private var m_Objectives:Vector.<HUDQuestTrackerObjective>;
      
      private var m_Title:String;
      
      private var m_QuestID:uint;
      
      private var m_State:Number;
      
      private var m_posTween:Tween;
      
      private var m_focusQuest:Boolean = false;
      
      private var m_IsEvent:Boolean = false;
      
      private var m_IsDisplayedToTeam:Boolean = false;
      
      private var m_ToRemove:Boolean = false;
      
      private var m_TempDisplay:Boolean = false;
      
      private var m_SortIndex:int = 0;
      
      private var m_NeedArrangeObjectives:Boolean = false;
      
      private var m_Timer:Number = -1.0;
      
      private var m_UseProvider:Boolean = false;
      
      private var m_UseTimer:Boolean = false;
      
      private var m_ProviderCallback:Function;
      
      private var m_Displayed:Boolean = false;
      
      private var m_Tracker:HUDQuestTracker;
      
      private var m_TimerCritical:Boolean = false;
      
      private var m_IsShareable:Boolean = false;
      
      private var m_QuestDisplayType:uint = 0;
      
      public function HUDQuestTrackerEntry()
      {
         // method body index: 1997 method index: 1997
         super();
         addFrameScript(0,this.frame1,15,this.frame16,16,this.frame17,20,this.frame21,25,this.frame26,30,this.frame31,56,this.frame57);
         this.Timer_mc.Text_mc.visible = false;
         this.m_Objectives = new Vector.<HUDQuestTrackerObjective>();
         Extensions.enabled = true;
         if(this.Title_mc.textField != null)
         {
            TextFieldEx.setTextAutoSize(this.Title_mc.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
         }
      }
      
      public function set timerCritical(param1:Boolean) : void
      {
         // method body index: 1998 method index: 1998
         if(param1 != this.m_TimerCritical)
         {
            this.m_TimerCritical = param1;
            if(this.m_TimerCritical)
            {
               this.Timer_mc.gotoAndPlay("warning");
            }
            else
            {
               this.Timer_mc.gotoAndStop("idle");
            }
         }
      }
      
      public function set tracker(param1:HUDQuestTracker) : void
      {
         // method body index: 1999 method index: 1999
         this.m_Tracker = param1;
      }
      
      public function onQuestDataChange(param1:Array) : void
      {
         // method body index: 2000 method index: 2000
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].questID == this.m_QuestID)
            {
               this.timer = param1[_loc2_].timer;
               return;
            }
            _loc2_++;
         }
      }
      
      private function onProviderUpdate(param1:FromClientDataEvent) : *
      {
         // method body index: 2001 method index: 2001
         var _loc2_:Array = param1.data.quests;
         this.onQuestDataChange(_loc2_);
      }
      
      public function set useProvider(param1:Boolean) : void
      {
         // method body index: 2002 method index: 2002
         if(param1 != this.m_UseProvider)
         {
            this.m_UseProvider = param1;
            if(this.m_ProviderCallback != null)
            {
               BSUIDataManager.Unsubscribe("QuestTrackerData",this.m_ProviderCallback);
            }
            if(this.m_UseProvider)
            {
               this.m_ProviderCallback = BSUIDataManager.Subscribe("QuestTrackerData",this.onProviderUpdate);
            }
         }
      }
      
      public function set useTimer(param1:Boolean) : void
      {
         // method body index: 2003 method index: 2003
         if(param1 != this.m_UseTimer)
         {
            this.m_UseTimer = param1;
            this.needArrangeObjectives = true;
            this.Timer_mc.Text_mc.visible = this.m_UseTimer;
            this.m_Tracker.requestRearrange();
         }
      }
      
      public function get useTimer() : Boolean
      {
         // method body index: 2004 method index: 2004
         return this.m_UseTimer;
      }
      
      public function set timer(param1:Number) : void
      {
         // method body index: 2005 method index: 2005
         this.m_Timer = param1;
         if(this.m_Timer >= 0)
         {
            this.useTimer = true;
            this.Timer_mc.Text_mc.Text_tf.text = "TIME REMAINING - " + GlobalFunc.FormatTimeString(this.m_Timer);
            this.timerCritical = this.m_Timer < TIMER_CRITICAL_THRESHOLD;
            this.UpdateTitleText();
         }
         else
         {
            this.useTimer = false;
            this.timerCritical = false;
         }
      }
      
      public function get fullHeight() : Number
      {
         // method body index: 2006 method index: 2006
         var _loc1_:Number = this.Sizer_mc.height;
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_Objectives.length)
         {
            _loc1_ = _loc1_ + this.m_Objectives[_loc2_].Sizer_mc.height;
            if(this.m_Objectives[_loc2_].Meter_mc.visible)
            {
               _loc1_ = _loc1_ + this.m_Objectives[_loc2_].Meter_mc.Internal_mc.Sizer_mc.height;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function set needArrangeObjectives(param1:Boolean) : void
      {
         // method body index: 2007 method index: 2007
         this.m_NeedArrangeObjectives = param1;
      }
      
      public function get needArrangeObjectives() : Boolean
      {
         // method body index: 2008 method index: 2008
         return this.m_NeedArrangeObjectives;
      }
      
      public function set sortIndex(param1:int) : void
      {
         // method body index: 2009 method index: 2009
         this.m_SortIndex = param1;
      }
      
      public function get sortIndex() : int
      {
         // method body index: 2010 method index: 2010
         return this.m_SortIndex;
      }
      
      public function set tempDisplay(param1:Boolean) : void
      {
         // method body index: 2011 method index: 2011
         this.m_TempDisplay = param1;
      }
      
      public function get tempDisplay() : Boolean
      {
         // method body index: 2012 method index: 2012
         return this.m_TempDisplay;
      }
      
      public function set toRemove(param1:Boolean) : void
      {
         // method body index: 2013 method index: 2013
         this.m_ToRemove = param1;
      }
      
      public function get toRemove() : Boolean
      {
         // method body index: 2014 method index: 2014
         return this.m_ToRemove;
      }
      
      public function set isShareable(param1:Boolean) : void
      {
         // method body index: 2015 method index: 2015
         this.m_IsShareable = param1;
      }
      
      public function get isShareable() : Boolean
      {
         // method body index: 2016 method index: 2016
         return this.m_IsShareable;
      }
      
      public function set questDisplayType(param1:uint) : void
      {
         // method body index: 2017 method index: 2017
         this.m_QuestDisplayType = param1;
         this.updateQuestIconState();
      }
      
      public function get questDisplayType() : uint
      {
         // method body index: 2018 method index: 2018
         return this.m_QuestDisplayType;
      }
      
      public function set isDisplayedToTeam(param1:Boolean) : void
      {
         // method body index: 2019 method index: 2019
         this.m_IsDisplayedToTeam = param1;
         this.updateQuestIconState();
      }
      
      public function get isDisplayedToTeam() : Boolean
      {
         // method body index: 2020 method index: 2020
         return this.m_IsDisplayedToTeam;
      }
      
      public function updateQuestIconState() : void
      {
         // method body index: 2021 method index: 2021
         if(this.m_IsDisplayedToTeam)
         {
            this.Icon_mc.gotoAndStop("sharedQuestTracker");
         }
         else
         {
            switch(this.m_QuestDisplayType)
            {
               case GlobalFunc.QUEST_DISPLAY_TYPE_MAIN:
                  this.Icon_mc.gotoAndStop("MainQuestTracker");
                  break;
               case GlobalFunc.QUEST_DISPLAY_TYPE_SIDE:
                  this.Icon_mc.gotoAndStop("questTracker");
                  break;
               case GlobalFunc.QUEST_DISPLAY_TYPE_MISC:
                  this.Icon_mc.gotoAndStop("questTracker");
                  break;
               case GlobalFunc.QUEST_DISPLAY_TYPE_EVENT:
                  this.Icon_mc.gotoAndStop("questTracker");
                  break;
               case GlobalFunc.QUEST_DISPLAY_TYPE_OTHER:
                  this.Icon_mc.gotoAndStop("questTracker");
                  break;
               default:
                  this.Icon_mc.gotoAndStop("questTracker");
                  trace("Quest Tracker: Quest is not defined as Main/Side/Misc/Shared. Setting to Side/Misc by default");
            }
         }
      }
      
      public function set isEvent(param1:Boolean) : void
      {
         // method body index: 2022 method index: 2022
         this.m_IsEvent = param1;
      }
      
      public function get isEvent() : Boolean
      {
         // method body index: 2023 method index: 2023
         return this.m_IsEvent;
      }
      
      public function set focusQuest(param1:Boolean) : void
      {
         // method body index: 2024 method index: 2024
         this.m_focusQuest = param1;
      }
      
      public function get focusQuest() : Boolean
      {
         // method body index: 2025 method index: 2025
         return this.m_focusQuest;
      }
      
      public function get state() : Number
      {
         // method body index: 2026 method index: 2026
         return this.m_State;
      }
      
      public function stateUpdate(param1:Boolean = false) : void
      {
         // method body index: 2027 method index: 2027
         var _loc2_:Boolean = this.m_State == HUDQuestTracker.QUEST_STATE_COMPLETE || this.m_State == HUDQuestTracker.QUEST_STATE_FAILED;
         if(_loc2_)
         {
            if(param1)
            {
               gotoAndPlay("Completed");
            }
            else
            {
               gotoAndPlay("CompleteIdle");
            }
         }
         else
         {
            gotoAndPlay("Idle");
         }
         this.m_Displayed = true;
      }
      
      public function set state(param1:Number) : void
      {
         // method body index: 2028 method index: 2028
         this.m_State = param1;
      }
      
      public function get objectives() : Vector.<HUDQuestTrackerObjective>
      {
         // method body index: 2029 method index: 2029
         return this.m_Objectives;
      }
      
      public function set questID(param1:uint) : void
      {
         // method body index: 2030 method index: 2030
         this.m_QuestID = param1;
      }
      
      public function get questID() : uint
      {
         // method body index: 2031 method index: 2031
         return this.m_QuestID;
      }
      
      public function set title(param1:String) : void
      {
         // method body index: 2032 method index: 2032
         this.m_Title = param1;
         this.UpdateTitleText();
      }
      
      public function UpdateTitleText() : void
      {
         // method body index: 2033 method index: 2033
         if(this.useTimer)
         {
            this.Title_mc.textField.text = this.m_Title.toUpperCase() + " [" + GlobalFunc.FormatTimeString(this.m_Timer) + "]";
         }
         else
         {
            this.Title_mc.textField.text = this.m_Title.toUpperCase();
         }
      }
      
      public function get title() : String
      {
         // method body index: 2034 method index: 2034
         return this.m_Title;
      }
      
      private function clearTween() : void
      {
         // method body index: 2035 method index: 2035
         if(this.m_posTween != null)
         {
            this.m_posTween.stop();
            this.m_posTween = null;
         }
      }
      
      public function fadeIn() : void
      {
         // method body index: 2036 method index: 2036
         this.m_Displayed = true;
         gotoAndPlay("FadeIn");
      }
      
      public function fadeOut() : void
      {
         // method body index: 2037 method index: 2037
         gotoAndPlay("FadeOut");
      }
      
      public function addObjective(param1:HUDQuestTrackerObjective) : void
      {
         // method body index: 2038 method index: 2038
         addChild(param1);
         param1.questID = this.m_QuestID;
         this.m_Objectives.push(param1);
      }
      
      public function deleteObjective(param1:HUDQuestTrackerObjective) : void
      {
         // method body index: 2039 method index: 2039
         this.objectives.splice(this.objectives.indexOf(param1),1);
         param1.useProvider = false;
         this.removeChild(param1);
      }
      
      public function setYPos(param1:Number, param2:Boolean = false) : void
      {
         // method body index: 2040 method index: 2040
         this.clearTween();
         if(param2 && this.m_Displayed)
         {
            this.m_posTween = new Tween(this,"y",Regular.easeInOut,this.y,param1,HUDQuestTracker.EVENT_DURATION_REARRANGE / 1000,true);
         }
         else
         {
            this.y = param1;
         }
      }
      
      public function arrangeObjectives(param1:Boolean = false) : void
      {
         // method body index: 2042 method index: 2042
         var aAnimate:Boolean = param1;
         var curClip:HUDQuestTrackerObjective = null;
         var posY:Number = this.Sizer_mc.height;
         this.m_Objectives.sort(function(param1:HUDQuestTrackerObjective, param2:HUDQuestTrackerObjective):// method body index: 2041 method index: 2041
         *
         {
            // method body index: 2041 method index: 2041
            return Number(param1.objectiveID) - Number(param2.objectiveID);
         });
         var i:int = 0;
         while(i < this.m_Objectives.length)
         {
            curClip = this.m_Objectives[i];
            curClip.y = posY;
            posY = posY + curClip.Sizer_mc.height;
            if(curClip.Meter_mc.visible)
            {
               posY = posY + curClip.Meter_mc.Internal_mc.Sizer_mc.height;
            }
            i++;
         }
      }
      
      function frame1() : *
      {
         // method body index: 2043 method index: 2043
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 2044 method index: 2044
         stop();
      }
      
      function frame17() : *
      {
         // method body index: 2045 method index: 2045
         stop();
      }
      
      function frame21() : *
      {
         // method body index: 2046 method index: 2046
         stop();
      }
      
      function frame26() : *
      {
         // method body index: 2047 method index: 2047
         stop();
      }
      
      function frame31() : *
      {
         // method body index: 2048 method index: 2048
         stop();
      }
      
      function frame57() : *
      {
         // method body index: 2049 method index: 2049
         stop();
      }
   }
}
