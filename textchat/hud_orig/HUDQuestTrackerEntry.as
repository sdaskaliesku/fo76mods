 
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
      
      public static const TIMER_CRITICAL_THRESHOLD:Number = // method body index: 2070 method index: 2070
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
         // method body index: 2116 method index: 2116
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
      
      public function set timerCritical(aCritical:Boolean) : void
      {
         // method body index: 2071 method index: 2071
         if(aCritical != this.m_TimerCritical)
         {
            this.m_TimerCritical = aCritical;
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
      
      public function set tracker(aTracker:HUDQuestTracker) : void
      {
         // method body index: 2072 method index: 2072
         this.m_Tracker = aTracker;
      }
      
      public function onQuestDataChange(aQuest:Array) : void
      {
         // method body index: 2073 method index: 2073
         for(var i:uint = 0; i < aQuest.length; i++)
         {
            if(aQuest[i].questID == this.m_QuestID)
            {
               this.timer = aQuest[i].timer;
               return;
            }
         }
      }
      
      private function onProviderUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 2074 method index: 2074
         var quests:Array = arEvent.data.quests;
         this.onQuestDataChange(quests);
      }
      
      public function set useProvider(aUse:Boolean) : void
      {
         // method body index: 2075 method index: 2075
         if(aUse != this.m_UseProvider)
         {
            this.m_UseProvider = aUse;
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
      
      public function set useTimer(aUse:Boolean) : void
      {
         // method body index: 2076 method index: 2076
         if(aUse != this.m_UseTimer)
         {
            this.m_UseTimer = aUse;
            this.needArrangeObjectives = true;
            this.Timer_mc.Text_mc.visible = this.m_UseTimer;
            this.m_Tracker.requestRearrange();
         }
      }
      
      public function get useTimer() : Boolean
      {
         // method body index: 2077 method index: 2077
         return this.m_UseTimer;
      }
      
      public function set timer(aTimer:Number) : void
      {
         // method body index: 2078 method index: 2078
         this.m_Timer = aTimer;
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
         // method body index: 2079 method index: 2079
         var heightTotal:Number = this.Sizer_mc.height;
         for(var i:uint = 0; i < this.m_Objectives.length; i++)
         {
            heightTotal = heightTotal + this.m_Objectives[i].Sizer_mc.height;
            if(this.m_Objectives[i].Meter_mc.visible)
            {
               heightTotal = heightTotal + this.m_Objectives[i].Meter_mc.Internal_mc.Sizer_mc.height;
            }
         }
         return heightTotal;
      }
      
      public function set needArrangeObjectives(aArrange:Boolean) : void
      {
         // method body index: 2080 method index: 2080
         this.m_NeedArrangeObjectives = aArrange;
      }
      
      public function get needArrangeObjectives() : Boolean
      {
         // method body index: 2081 method index: 2081
         return this.m_NeedArrangeObjectives;
      }
      
      public function set sortIndex(aIndex:int) : void
      {
         // method body index: 2082 method index: 2082
         this.m_SortIndex = aIndex;
      }
      
      public function get sortIndex() : int
      {
         // method body index: 2083 method index: 2083
         return this.m_SortIndex;
      }
      
      public function set tempDisplay(aDislpay:Boolean) : void
      {
         // method body index: 2084 method index: 2084
         this.m_TempDisplay = aDislpay;
      }
      
      public function get tempDisplay() : Boolean
      {
         // method body index: 2085 method index: 2085
         return this.m_TempDisplay;
      }
      
      public function set toRemove(aRemove:Boolean) : void
      {
         // method body index: 2086 method index: 2086
         this.m_ToRemove = aRemove;
      }
      
      public function get toRemove() : Boolean
      {
         // method body index: 2087 method index: 2087
         return this.m_ToRemove;
      }
      
      public function set isShareable(aShareable:Boolean) : void
      {
         // method body index: 2088 method index: 2088
         this.m_IsShareable = aShareable;
      }
      
      public function get isShareable() : Boolean
      {
         // method body index: 2089 method index: 2089
         return this.m_IsShareable;
      }
      
      public function set questDisplayType(aType:uint) : void
      {
         // method body index: 2090 method index: 2090
         this.m_QuestDisplayType = aType;
         this.updateQuestIconState();
      }
      
      public function get questDisplayType() : uint
      {
         // method body index: 2091 method index: 2091
         return this.m_QuestDisplayType;
      }
      
      public function set isDisplayedToTeam(aDisplayed:Boolean) : void
      {
         // method body index: 2092 method index: 2092
         this.m_IsDisplayedToTeam = aDisplayed;
         this.updateQuestIconState();
      }
      
      public function get isDisplayedToTeam() : Boolean
      {
         // method body index: 2093 method index: 2093
         return this.m_IsDisplayedToTeam;
      }
      
      public function updateQuestIconState() : void
      {
         // method body index: 2094 method index: 2094
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
      
      public function set isEvent(aEvent:Boolean) : void
      {
         // method body index: 2095 method index: 2095
         this.m_IsEvent = aEvent;
      }
      
      public function get isEvent() : Boolean
      {
         // method body index: 2096 method index: 2096
         return this.m_IsEvent;
      }
      
      public function set focusQuest(aFocus:Boolean) : void
      {
         // method body index: 2097 method index: 2097
         this.m_focusQuest = aFocus;
      }
      
      public function get focusQuest() : Boolean
      {
         // method body index: 2098 method index: 2098
         return this.m_focusQuest;
      }
      
      public function get state() : Number
      {
         // method body index: 2099 method index: 2099
         return this.m_State;
      }
      
      public function stateUpdate(aAnimate:Boolean = false) : void
      {
         // method body index: 2100 method index: 2100
         var completed:Boolean = this.m_State == HUDQuestTracker.QUEST_STATE_COMPLETE || this.m_State == HUDQuestTracker.QUEST_STATE_FAILED;
         if(completed)
         {
            if(aAnimate)
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
      
      public function set state(aState:Number) : void
      {
         // method body index: 2101 method index: 2101
         this.m_State = aState;
      }
      
      public function get objectives() : Vector.<HUDQuestTrackerObjective>
      {
         // method body index: 2102 method index: 2102
         return this.m_Objectives;
      }
      
      public function set questID(aQuestID:uint) : void
      {
         // method body index: 2103 method index: 2103
         this.m_QuestID = aQuestID;
      }
      
      public function get questID() : uint
      {
         // method body index: 2104 method index: 2104
         return this.m_QuestID;
      }
      
      public function set title(aTitle:String) : void
      {
         // method body index: 2105 method index: 2105
         this.m_Title = aTitle;
         this.UpdateTitleText();
      }
      
      public function UpdateTitleText() : void
      {
         // method body index: 2106 method index: 2106
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
         // method body index: 2107 method index: 2107
         return this.m_Title;
      }
      
      private function clearTween() : void
      {
         // method body index: 2108 method index: 2108
         if(this.m_posTween != null)
         {
            this.m_posTween.stop();
            this.m_posTween = null;
         }
      }
      
      public function fadeIn() : void
      {
         // method body index: 2109 method index: 2109
         this.m_Displayed = true;
         gotoAndPlay("FadeIn");
      }
      
      public function fadeOut() : void
      {
         // method body index: 2110 method index: 2110
         gotoAndPlay("FadeOut");
      }
      
      public function addObjective(newObjective:HUDQuestTrackerObjective) : void
      {
         // method body index: 2111 method index: 2111
         addChild(newObjective);
         newObjective.questID = this.m_QuestID;
         this.m_Objectives.push(newObjective);
      }
      
      public function deleteObjective(aObjective:HUDQuestTrackerObjective) : void
      {
         // method body index: 2112 method index: 2112
         this.objectives.splice(this.objectives.indexOf(aObjective),1);
         aObjective.useProvider = false;
         this.removeChild(aObjective);
      }
      
      public function setYPos(aPos:Number, aAnimate:Boolean = false) : void
      {
         // method body index: 2113 method index: 2113
         this.clearTween();
         if(aAnimate && this.m_Displayed)
         {
            this.m_posTween = new Tween(this,"y",Regular.easeInOut,this.y,aPos,HUDQuestTracker.EVENT_DURATION_REARRANGE / 1000,true);
         }
         else
         {
            this.y = aPos;
         }
      }
      
      public function arrangeObjectives(aAnimate:Boolean = false) : void
      {
         // method body index: 2115 method index: 2115
         var curClip:HUDQuestTrackerObjective = null;
         var posY:Number = this.Sizer_mc.height;
         this.m_Objectives.sort(function(a:HUDQuestTrackerObjective, b:HUDQuestTrackerObjective):// method body index: 2114 method index: 2114
         *
         {
            // method body index: 2114 method index: 2114
            return Number(a.objectiveID) - Number(b.objectiveID);
         });
         for(var i:int = 0; i < this.m_Objectives.length; i++)
         {
            curClip = this.m_Objectives[i];
            curClip.y = posY;
            posY = posY + curClip.Sizer_mc.height;
            if(curClip.Meter_mc.visible)
            {
               posY = posY + curClip.Meter_mc.Internal_mc.Sizer_mc.height;
            }
         }
      }
      
      function frame1() : *
      {
         // method body index: 2117 method index: 2117
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 2118 method index: 2118
         stop();
      }
      
      function frame17() : *
      {
         // method body index: 2119 method index: 2119
         stop();
      }
      
      function frame21() : *
      {
         // method body index: 2120 method index: 2120
         stop();
      }
      
      function frame26() : *
      {
         // method body index: 2121 method index: 2121
         stop();
      }
      
      function frame31() : *
      {
         // method body index: 2122 method index: 2122
         stop();
      }
      
      function frame57() : *
      {
         // method body index: 2123 method index: 2123
         stop();
      }
   }
}
