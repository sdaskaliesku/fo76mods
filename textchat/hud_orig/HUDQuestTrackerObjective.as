 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDQuestTrackerObjective extends MovieClip
   {
      
      public static const ALERT_STATE_NONE:uint = // method body index: 2125 method index: 2125
      0;
      
      private static const METER_TYPE_DEFAULT:uint = // method body index: 2125 method index: 2125
      0;
      
      private static const METER_TYPE_TWO_WAY:uint = // method body index: 2125 method index: 2125
      1;
       
      
      public var Icon_mc:MovieClip;
      
      public var CompletedIcon_mc:MovieClip;
      
      public var Sizer_mc:MovieClip;
      
      public var Title_mc:MovieClip;
      
      public var TitleCompleted_mc:MovieClip;
      
      public var Count_mc:MovieClip;
      
      public var Meter_mc:MovieClip;
      
      public var Alert_mc:MovieClip;
      
      public var MergedLeaderIcon_mc:MovieClip;
      
      private var m_State:Number;
      
      private var m_IsOptional:Boolean;
      
      private var m_Title:String;
      
      private var m_Count:Number = 0;
      
      private var m_CountMax:Number = 0;
      
      private var m_ObjectiveID:uint;
      
      private var m_IsOrObjective:Boolean;
      
      private var m_TitleBaseX:Number = 0;
      
      private var m_QuestID:uint;
      
      private var m_ToRemove:Boolean = false;
      
      private var m_Timer:Number = -1.0;
      
      private var m_Progress:Number = -1;
      
      private var m_MeterFrames:int = 100;
      
      private var m_AlertState:int = 0;
      
      private var m_AlertMessage:String = "";
      
      private var m_AlertSizeBuffer:Number = 0;
      
      private var m_IsMergedLeaderObjective:Boolean = false;
      
      private var m_UseProvider:Boolean = false;
      
      private var m_ProviderCallback:Function;
      
      private var m_ContextQuestID:uint;
      
      private var m_MeterType:uint = 0;
      
      private var m_MeterTextLeft:String = "";
      
      private var m_MeterTextRight:String = "";
      
      public function HUDQuestTrackerObjective()
      {
         // method body index: 2164 method index: 2164
         super();
         addFrameScript(0,this.frame1,15,this.frame16,38,this.frame39,43,this.frame44,115,this.frame116,167,this.frame168,171,this.frame172,204,this.frame205,238,this.frame239);
         this.m_TitleBaseX = this.Title_mc.textField.x;
         this.m_MeterFrames = this.Meter_mc.Internal_mc.totalFrames;
         this.Meter_mc.visible = false;
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.Title_mc.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.TitleCompleted_mc.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function onQuestDataChange(aQuests:Array) : void
      {
         // method body index: 2126 method index: 2126
         var objectiveData:Object = null;
         var obIndex:uint = 0;
         for(var quIndex:uint = 0; quIndex < aQuests.length; quIndex++)
         {
            if(aQuests[quIndex].questID == this.m_QuestID)
            {
               obIndex = 0;
               while(aQuests[quIndex].objectives.length)
               {
                  objectiveData = aQuests[quIndex].objectives[obIndex];
                  if(objectiveData.contextQuestID == this.m_ContextQuestID && objectiveData.objectiveID == this.m_ObjectiveID)
                  {
                     this.meterType = !!objectiveData.isTwoWayProgressMeter?uint(METER_TYPE_TWO_WAY):uint(METER_TYPE_DEFAULT);
                     this.meterTextLeft = objectiveData.twoWayProgressMeterTextLeft;
                     this.meterTextRight = objectiveData.twoWayProgressMeterTextRight;
                     this.progress = objectiveData.progressMeter;
                     this.timer = objectiveData.timer;
                     this.alertState = objectiveData.announceState;
                     this.alertMessage = objectiveData.announce;
                     this.isMergedLeaderObjective = objectiveData.isMergedLeaderObj;
                     return;
                  }
                  obIndex++;
               }
            }
         }
      }
      
      private function onProviderUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 2127 method index: 2127
         var quests:Array = arEvent.data.quests;
         this.onQuestDataChange(quests);
      }
      
      public function set useProvider(aUse:Boolean) : void
      {
         // method body index: 2128 method index: 2128
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
      
      public function set alertState(aState:int) : void
      {
         // method body index: 2129 method index: 2129
         var alertLabels:Array = null;
         var alertUseLabel:String = null;
         var i:* = undefined;
         if(aState != this.m_AlertState)
         {
            this.m_AlertState = aState;
            if(this.m_AlertState > ALERT_STATE_NONE)
            {
               this.Alert_mc.Internal_mc.visible = true;
               alertLabels = this.Alert_mc.Internal_mc.currentLabels;
               alertUseLabel = "AlertState1";
               for(i = 0; i < alertLabels.length; i++)
               {
                  if(alertLabels[i].name == "AlertState" + this.m_AlertState)
                  {
                     alertUseLabel = alertLabels[i].name;
                     break;
                  }
               }
               this.Alert_mc.Internal_mc.gotoAndPlay(alertUseLabel);
               this.updateAlertPos();
            }
            else
            {
               this.Alert_mc.Internal_mc.visible = false;
            }
         }
      }
      
      public function set alertMessage(aMessage:String) : void
      {
         // method body index: 2130 method index: 2130
         this.m_AlertMessage = aMessage;
         var alertField:TextField = this.Alert_mc.Internal_mc.AlertText_mc.AlertText_tf;
         alertField.text = this.m_AlertMessage;
      }
      
      public function set isMergedLeaderObjective(aFlag:Boolean) : void
      {
         // method body index: 2131 method index: 2131
         if(this.m_IsMergedLeaderObjective != aFlag)
         {
            this.m_IsMergedLeaderObjective = aFlag;
            this.MergedLeaderIcon_mc.Internal_mc.visible = this.m_IsMergedLeaderObjective;
         }
      }
      
      public function set timer(aTimer:Number) : void
      {
         // method body index: 2132 method index: 2132
         this.m_Timer = aTimer;
         this.updateTitle();
      }
      
      public function set meterType(aType:uint) : void
      {
         // method body index: 2133 method index: 2133
         if(aType != this.m_MeterType)
         {
            this.m_MeterType = aType;
            switch(this.m_MeterType)
            {
               case METER_TYPE_TWO_WAY:
                  this.Meter_mc.gotoAndStop("twoWay");
                  break;
               default:
                  this.Meter_mc.gotoAndStop("plain");
            }
            this.updateProgress();
            if(aType == METER_TYPE_TWO_WAY)
            {
               this.updateMeterText();
            }
         }
      }
      
      public function set meterTextLeft(aText:String) : void
      {
         // method body index: 2134 method index: 2134
         if(aText != this.m_MeterTextLeft)
         {
            this.m_MeterTextLeft = aText;
            this.updateMeterText();
         }
      }
      
      public function set meterTextRight(aText:String) : void
      {
         // method body index: 2135 method index: 2135
         if(aText != this.m_MeterTextRight)
         {
            this.m_MeterTextRight = aText;
            this.updateMeterText();
         }
      }
      
      private function updateMeterText() : void
      {
         // method body index: 2136 method index: 2136
         if(this.m_MeterType == METER_TYPE_TWO_WAY)
         {
            TextFieldEx.setTextAutoSize(this.Meter_mc.Internal_mc.LeftLabel_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            TextFieldEx.setTextAutoSize(this.Meter_mc.Internal_mc.RightLabel_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.Meter_mc.Internal_mc.LeftLabel_tf.text = this.m_MeterTextLeft;
            this.Meter_mc.Internal_mc.RightLabel_tf.text = this.m_MeterTextRight;
         }
      }
      
      public function set progress(aProgress:Number) : void
      {
         // method body index: 2137 method index: 2137
         this.m_Progress = aProgress;
         this.updateProgress();
      }
      
      private function updateProgress() : void
      {
         // method body index: 2138 method index: 2138
         if(this.m_Progress >= 0)
         {
            this.Meter_mc.visible = true;
            this.Meter_mc.Internal_mc.gotoAndStop(Math.floor(this.m_Progress * this.m_MeterFrames));
         }
         else
         {
            this.Meter_mc.visible = false;
         }
      }
      
      public function set toRemove(aRemove:Boolean) : *
      {
         // method body index: 2139 method index: 2139
         this.m_ToRemove = aRemove;
      }
      
      public function get toRemove() : Boolean
      {
         // method body index: 2140 method index: 2140
         return this.m_ToRemove;
      }
      
      private function updateAlertPos() : void
      {
         // method body index: 2141 method index: 2141
         var textWidth:Number = NaN;
         var useClip:MovieClip = null;
         if(this.m_AlertState > ALERT_STATE_NONE || this.m_IsMergedLeaderObjective == true)
         {
            textWidth = 0;
            if(this.m_State >= HUDQuestTracker.QUEST_STATE_COMPLETE)
            {
               useClip = this.TitleCompleted_mc;
            }
            else
            {
               useClip = this.Title_mc;
            }
            textWidth = useClip.textField.getLineMetrics(0).width;
            if(this.m_AlertState > ALERT_STATE_NONE)
            {
               this.Alert_mc.Internal_mc.x = useClip.x - textWidth;
            }
         }
      }
      
      private function updateTitle() : void
      {
         // method body index: 2142 method index: 2142
         var countSuffix:* = "";
         var timerPrefix:* = "";
         if(this.m_Timer > 0)
         {
            timerPrefix = GlobalFunc.FormatTimeString(this.m_Timer) + " ";
         }
         if(this.m_CountMax > 0)
         {
            countSuffix = " (" + this.m_Count + "/" + this.m_CountMax + ")";
         }
         if(this.m_IsOptional)
         {
            this.Title_mc.textField.text = "$$QuestTrackerState_Optional " + timerPrefix + this.m_Title + countSuffix;
         }
         else
         {
            this.Title_mc.textField.text = timerPrefix + this.m_Title + countSuffix;
         }
         if(this.m_State == HUDQuestTracker.QUEST_STATE_FAILED)
         {
            this.TitleCompleted_mc.textField.text = "$$QuestTrackerState_Failed " + timerPrefix + this.m_Title + countSuffix;
         }
         else
         {
            this.TitleCompleted_mc.textField.text = "$$QuestTrackerState_Completed " + timerPrefix + this.m_Title + countSuffix;
         }
         this.updateAlertPos();
      }
      
      public function set questID(aQuestID:uint) : void
      {
         // method body index: 2143 method index: 2143
         this.m_QuestID = aQuestID;
      }
      
      public function get questID() : uint
      {
         // method body index: 2144 method index: 2144
         return this.m_QuestID;
      }
      
      public function set objectiveID(aObjectiveID:uint) : void
      {
         // method body index: 2145 method index: 2145
         this.m_ObjectiveID = aObjectiveID;
      }
      
      public function get objectiveID() : uint
      {
         // method body index: 2146 method index: 2146
         return this.m_ObjectiveID;
      }
      
      public function set isOrObjective(aIsOrObjective:Boolean) : void
      {
         // method body index: 2147 method index: 2147
         this.m_IsOrObjective = aIsOrObjective;
      }
      
      public function get isOrObjective() : Boolean
      {
         // method body index: 2148 method index: 2148
         return this.m_IsOrObjective;
      }
      
      public function set contextQuestID(aContextQuestID:uint) : void
      {
         // method body index: 2149 method index: 2149
         this.m_ContextQuestID = aContextQuestID;
      }
      
      public function get contextQuestID() : uint
      {
         // method body index: 2150 method index: 2150
         return this.m_ContextQuestID;
      }
      
      public function get count() : Number
      {
         // method body index: 2151 method index: 2151
         return this.m_Count;
      }
      
      public function set count(aCount:Number) : void
      {
         // method body index: 2152 method index: 2152
         this.m_Count = aCount;
         this.updateTitle();
      }
      
      public function set countMax(aCount:Number) : void
      {
         // method body index: 2153 method index: 2153
         this.m_CountMax = aCount;
         this.updateTitle();
      }
      
      public function set state(aState:Number) : *
      {
         // method body index: 2154 method index: 2154
         this.m_State = aState;
         this.updateTitle();
      }
      
      public function get state() : Number
      {
         // method body index: 2155 method index: 2155
         return this.m_State;
      }
      
      public function fadeIn() : void
      {
         // method body index: 2156 method index: 2156
         var Offset:Number = Math.floor(Math.random() * (5 - 0 + 1)) + 0;
         gotoAndPlay(2 + Offset);
      }
      
      public function fadeOut() : void
      {
         // method body index: 2157 method index: 2157
         if(this.m_State >= HUDQuestTracker.QUEST_STATE_COMPLETE)
         {
            gotoAndPlay("FadeOut");
         }
         else
         {
            gotoAndPlay("FadeOutIncomplete");
         }
      }
      
      public function stateUpdate(aAnimate:Boolean = false) : void
      {
         // method body index: 2158 method index: 2158
         var completed:Boolean = this.m_State == HUDQuestTracker.QUEST_STATE_COMPLETE || this.m_State == HUDQuestTracker.QUEST_STATE_FAILED;
         if(completed)
         {
            if(aAnimate)
            {
               gotoAndPlay("Complete");
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
      }
      
      public function animateUpdate() : void
      {
         // method body index: 2159 method index: 2159
         gotoAndPlay("Update");
      }
      
      public function mergeStateUpdate() : void
      {
         // method body index: 2160 method index: 2160
         gotoAndPlay("MergeLeaderChange");
      }
      
      public function set isOptional(aIsOptional:Boolean) : *
      {
         // method body index: 2161 method index: 2161
         this.m_IsOptional = aIsOptional;
         this.updateTitle();
      }
      
      public function set title(aTitle:String) : *
      {
         // method body index: 2162 method index: 2162
         this.m_Title = aTitle;
         this.updateTitle();
      }
      
      public function get title() : String
      {
         // method body index: 2163 method index: 2163
         return this.m_Title;
      }
      
      function frame1() : *
      {
         // method body index: 2165 method index: 2165
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 2166 method index: 2166
         stop();
      }
      
      function frame39() : *
      {
         // method body index: 2167 method index: 2167
         stop();
      }
      
      function frame44() : *
      {
         // method body index: 2168 method index: 2168
         stop();
      }
      
      function frame116() : *
      {
         // method body index: 2169 method index: 2169
         stop();
      }
      
      function frame168() : *
      {
         // method body index: 2170 method index: 2170
         stop();
      }
      
      function frame172() : *
      {
         // method body index: 2171 method index: 2171
         stop();
      }
      
      function frame205() : *
      {
         // method body index: 2172 method index: 2172
         stop();
      }
      
      function frame239() : *
      {
         // method body index: 2173 method index: 2173
         stop();
      }
   }
}
