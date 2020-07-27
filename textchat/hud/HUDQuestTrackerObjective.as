 
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
      
      public static const ALERT_STATE_NONE:uint = // method body index: 2051 method index: 2051
      0;
      
      private static const METER_TYPE_DEFAULT:uint = // method body index: 2051 method index: 2051
      0;
      
      private static const METER_TYPE_TWO_WAY:uint = // method body index: 2051 method index: 2051
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
         // method body index: 2052 method index: 2052
         super();
         addFrameScript(0,this.frame1,15,this.frame16,38,this.frame39,43,this.frame44,115,this.frame116,167,this.frame168,171,this.frame172,204,this.frame205,238,this.frame239);
         this.m_TitleBaseX = this.Title_mc.textField.x;
         this.m_MeterFrames = this.Meter_mc.Internal_mc.totalFrames;
         this.Meter_mc.visible = false;
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.Title_mc.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.TitleCompleted_mc.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function onQuestDataChange(param1:Array) : void
      {
         // method body index: 2053 method index: 2053
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].questID == this.m_QuestID)
            {
               _loc3_ = 0;
               while(param1[_loc4_].objectives.length)
               {
                  _loc2_ = param1[_loc4_].objectives[_loc3_];
                  if(_loc2_.contextQuestID == this.m_ContextQuestID && _loc2_.objectiveID == this.m_ObjectiveID)
                  {
                     this.meterType = !!_loc2_.isTwoWayProgressMeter?uint(uint(METER_TYPE_TWO_WAY)):uint(uint(METER_TYPE_DEFAULT));
                     this.meterTextLeft = _loc2_.twoWayProgressMeterTextLeft;
                     this.meterTextRight = _loc2_.twoWayProgressMeterTextRight;
                     this.progress = _loc2_.progressMeter;
                     this.timer = _loc2_.timer;
                     this.alertState = _loc2_.announceState;
                     this.alertMessage = _loc2_.announce;
                     this.isMergedLeaderObjective = _loc2_.isMergedLeaderObj;
                     return;
                  }
                  _loc3_++;
               }
            }
            _loc4_++;
         }
      }
      
      private function onProviderUpdate(param1:FromClientDataEvent) : *
      {
         // method body index: 2054 method index: 2054
         var _loc2_:Array = param1.data.quests;
         this.onQuestDataChange(_loc2_);
      }
      
      public function set useProvider(param1:Boolean) : void
      {
         // method body index: 2055 method index: 2055
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
      
      public function set alertState(param1:int) : void
      {
         // method body index: 2056 method index: 2056
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         if(param1 != this.m_AlertState)
         {
            this.m_AlertState = param1;
            if(this.m_AlertState > ALERT_STATE_NONE)
            {
               this.Alert_mc.Internal_mc.visible = true;
               _loc2_ = this.Alert_mc.Internal_mc.currentLabels;
               _loc3_ = "AlertState1";
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  if(_loc2_[_loc4_].name == "AlertState" + this.m_AlertState)
                  {
                     _loc3_ = _loc2_[_loc4_].name;
                     break;
                  }
                  _loc4_++;
               }
               this.Alert_mc.Internal_mc.gotoAndPlay(_loc3_);
               this.updateAlertPos();
            }
            else
            {
               this.Alert_mc.Internal_mc.visible = false;
            }
         }
      }
      
      public function set alertMessage(param1:String) : void
      {
         // method body index: 2057 method index: 2057
         this.m_AlertMessage = param1;
         var _loc2_:TextField = this.Alert_mc.Internal_mc.AlertText_mc.AlertText_tf;
         _loc2_.text = this.m_AlertMessage;
      }
      
      public function set isMergedLeaderObjective(param1:Boolean) : void
      {
         // method body index: 2058 method index: 2058
         if(this.m_IsMergedLeaderObjective != param1)
         {
            this.m_IsMergedLeaderObjective = param1;
            this.MergedLeaderIcon_mc.Internal_mc.visible = this.m_IsMergedLeaderObjective;
         }
      }
      
      public function set timer(param1:Number) : void
      {
         // method body index: 2059 method index: 2059
         this.m_Timer = param1;
         this.updateTitle();
      }
      
      public function set meterType(param1:uint) : void
      {
         // method body index: 2060 method index: 2060
         if(param1 != this.m_MeterType)
         {
            this.m_MeterType = param1;
            switch(this.m_MeterType)
            {
               case METER_TYPE_TWO_WAY:
                  this.Meter_mc.gotoAndStop("twoWay");
                  break;
               default:
                  this.Meter_mc.gotoAndStop("plain");
            }
            this.updateProgress();
            if(param1 == METER_TYPE_TWO_WAY)
            {
               this.updateMeterText();
            }
         }
      }
      
      public function set meterTextLeft(param1:String) : void
      {
         // method body index: 2061 method index: 2061
         if(param1 != this.m_MeterTextLeft)
         {
            this.m_MeterTextLeft = param1;
            this.updateMeterText();
         }
      }
      
      public function set meterTextRight(param1:String) : void
      {
         // method body index: 2062 method index: 2062
         if(param1 != this.m_MeterTextRight)
         {
            this.m_MeterTextRight = param1;
            this.updateMeterText();
         }
      }
      
      private function updateMeterText() : void
      {
         // method body index: 2063 method index: 2063
         if(this.m_MeterType == METER_TYPE_TWO_WAY)
         {
            TextFieldEx.setTextAutoSize(this.Meter_mc.Internal_mc.LeftLabel_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            TextFieldEx.setTextAutoSize(this.Meter_mc.Internal_mc.RightLabel_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.Meter_mc.Internal_mc.LeftLabel_tf.text = this.m_MeterTextLeft;
            this.Meter_mc.Internal_mc.RightLabel_tf.text = this.m_MeterTextRight;
         }
      }
      
      public function set progress(param1:Number) : void
      {
         // method body index: 2064 method index: 2064
         this.m_Progress = param1;
         this.updateProgress();
      }
      
      private function updateProgress() : void
      {
         // method body index: 2065 method index: 2065
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
      
      public function set toRemove(param1:Boolean) : *
      {
         // method body index: 2066 method index: 2066
         this.m_ToRemove = param1;
      }
      
      public function get toRemove() : Boolean
      {
         // method body index: 2067 method index: 2067
         return this.m_ToRemove;
      }
      
      private function updateAlertPos() : void
      {
         // method body index: 2068 method index: 2068
         var _loc1_:Number = NaN;
         var _loc2_:MovieClip = null;
         if(this.m_AlertState > ALERT_STATE_NONE || this.m_IsMergedLeaderObjective == true)
         {
            _loc1_ = 0;
            if(this.m_State >= HUDQuestTracker.QUEST_STATE_COMPLETE)
            {
               _loc2_ = this.TitleCompleted_mc;
            }
            else
            {
               _loc2_ = this.Title_mc;
            }
            _loc1_ = _loc2_.textField.getLineMetrics(0).width;
            if(this.m_AlertState > ALERT_STATE_NONE)
            {
               this.Alert_mc.Internal_mc.x = _loc2_.x - _loc1_;
            }
         }
      }
      
      private function updateTitle() : void
      {
         // method body index: 2069 method index: 2069
         var _loc1_:* = "";
         var _loc2_:* = "";
         if(this.m_Timer > 0)
         {
            _loc2_ = GlobalFunc.FormatTimeString(this.m_Timer) + " ";
         }
         if(this.m_CountMax > 0)
         {
            _loc1_ = " (" + this.m_Count + "/" + this.m_CountMax + ")";
         }
         if(this.m_IsOptional)
         {
            this.Title_mc.textField.text = "$$QuestTrackerState_Optional " + _loc2_ + this.m_Title + _loc1_;
         }
         else
         {
            this.Title_mc.textField.text = _loc2_ + this.m_Title + _loc1_;
         }
         if(this.m_State == HUDQuestTracker.QUEST_STATE_FAILED)
         {
            this.TitleCompleted_mc.textField.text = "$$QuestTrackerState_Failed " + _loc2_ + this.m_Title + _loc1_;
         }
         else
         {
            this.TitleCompleted_mc.textField.text = "$$QuestTrackerState_Completed " + _loc2_ + this.m_Title + _loc1_;
         }
         this.updateAlertPos();
      }
      
      public function set questID(param1:uint) : void
      {
         // method body index: 2070 method index: 2070
         this.m_QuestID = param1;
      }
      
      public function get questID() : uint
      {
         // method body index: 2071 method index: 2071
         return this.m_QuestID;
      }
      
      public function set objectiveID(param1:uint) : void
      {
         // method body index: 2072 method index: 2072
         this.m_ObjectiveID = param1;
      }
      
      public function get objectiveID() : uint
      {
         // method body index: 2073 method index: 2073
         return this.m_ObjectiveID;
      }
      
      public function set isOrObjective(param1:Boolean) : void
      {
         // method body index: 2074 method index: 2074
         this.m_IsOrObjective = param1;
      }
      
      public function get isOrObjective() : Boolean
      {
         // method body index: 2075 method index: 2075
         return this.m_IsOrObjective;
      }
      
      public function set contextQuestID(param1:uint) : void
      {
         // method body index: 2076 method index: 2076
         this.m_ContextQuestID = param1;
      }
      
      public function get contextQuestID() : uint
      {
         // method body index: 2077 method index: 2077
         return this.m_ContextQuestID;
      }
      
      public function get count() : Number
      {
         // method body index: 2078 method index: 2078
         return this.m_Count;
      }
      
      public function set count(param1:Number) : void
      {
         // method body index: 2079 method index: 2079
         this.m_Count = param1;
         this.updateTitle();
      }
      
      public function set countMax(param1:Number) : void
      {
         // method body index: 2080 method index: 2080
         this.m_CountMax = param1;
         this.updateTitle();
      }
      
      public function set state(param1:Number) : *
      {
         // method body index: 2081 method index: 2081
         this.m_State = param1;
         this.updateTitle();
      }
      
      public function get state() : Number
      {
         // method body index: 2082 method index: 2082
         return this.m_State;
      }
      
      public function fadeIn() : void
      {
         // method body index: 2083 method index: 2083
         var _loc1_:Number = Math.floor(Math.random() * (5 - 0 + 1)) + 0;
         gotoAndPlay(2 + _loc1_);
      }
      
      public function fadeOut() : void
      {
         // method body index: 2084 method index: 2084
         if(this.m_State >= HUDQuestTracker.QUEST_STATE_COMPLETE)
         {
            gotoAndPlay("FadeOut");
         }
         else
         {
            gotoAndPlay("FadeOutIncomplete");
         }
      }
      
      public function stateUpdate(param1:Boolean = false) : void
      {
         // method body index: 2085 method index: 2085
         var _loc2_:Boolean = this.m_State == HUDQuestTracker.QUEST_STATE_COMPLETE || this.m_State == HUDQuestTracker.QUEST_STATE_FAILED;
         if(_loc2_)
         {
            if(param1)
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
         // method body index: 2086 method index: 2086
         gotoAndPlay("Update");
      }
      
      public function mergeStateUpdate() : void
      {
         // method body index: 2087 method index: 2087
         gotoAndPlay("MergeLeaderChange");
      }
      
      public function set isOptional(param1:Boolean) : *
      {
         // method body index: 2088 method index: 2088
         this.m_IsOptional = param1;
         this.updateTitle();
      }
      
      public function set title(param1:String) : *
      {
         // method body index: 2089 method index: 2089
         this.m_Title = param1;
         this.updateTitle();
      }
      
      public function get title() : String
      {
         // method body index: 2090 method index: 2090
         return this.m_Title;
      }
      
      function frame1() : *
      {
         // method body index: 2091 method index: 2091
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 2092 method index: 2092
         stop();
      }
      
      function frame39() : *
      {
         // method body index: 2093 method index: 2093
         stop();
      }
      
      function frame44() : *
      {
         // method body index: 2094 method index: 2094
         stop();
      }
      
      function frame116() : *
      {
         // method body index: 2095 method index: 2095
         stop();
      }
      
      function frame168() : *
      {
         // method body index: 2096 method index: 2096
         stop();
      }
      
      function frame172() : *
      {
         // method body index: 2097 method index: 2097
         stop();
      }
      
      function frame205() : *
      {
         // method body index: 2098 method index: 2098
         stop();
      }
      
      function frame239() : *
      {
         // method body index: 2099 method index: 2099
         stop();
      }
   }
}
