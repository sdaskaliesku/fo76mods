 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDFloatingTarget extends BSUIComponent
   {
      
      public static const ALERT_STATE_NONE = // method body index: 3127 method index: 3127
      0;
       
      
      public var Marker_mc:MovieClip;
      
      public var Alert_mc:MovieClip;
      
      public var Objective_mc:MovieClip;
      
      private var m_MeterFrames:int = 100;
      
      private const m_AlertSizeBuffer:Number = 6;
      
      private var m_ShowLabel:Boolean = false;
      
      private var m_Label:String = "";
      
      private var m_MeterValue:Number = 0.0;
      
      private var m_MarkerID:String;
      
      private var m_Type:String;
      
      private var m_MidDistance:Boolean = false;
      
      private var m_ForceShow:Boolean = false;
      
      private var m_IsAI:Boolean;
      
      private var m_AlertState:int = 0;
      
      private var m_AlertMessage:String = "";
      
      public var m_CenterMagnitude:Number = 1.7976931348623157E308;
      
      public var m_DistanceFromPlayer = 1.7976931348623157E308;
      
      public var m_IsOnScreen:Boolean = false;
      
      private var m_QuestDisplayType:uint = 0;
      
      public function HUDFloatingTarget()
      {

         super();
         this.Alert_mc.visible = false;
         SetIsDirty();
         TextFieldEx.setVerticalAlign(this.Objective_mc.Objective_tf,TextFieldEx.VALIGN_CENTER);
      }
      
      public function set questDisplayType(param1:uint) : void
      {

         if(this.m_QuestDisplayType != param1)
         {
            this.m_QuestDisplayType = param1;
            SetIsDirty();
         }
      }
      
      public function set centerMagnitude(param1:Number) : void
      {

         if(param1 != this.m_CenterMagnitude)
         {
            SetIsDirty();
         }
         this.m_CenterMagnitude = param1;
      }
      
      public function get centerMagnitude() : Number
      {

         return this.m_CenterMagnitude;
      }
      
      public function set midDistance(param1:Boolean) : void
      {

         if(param1 != this.m_MidDistance)
         {
            SetIsDirty();
         }
         this.m_MidDistance = param1;
      }
      
      public function get midDistance() : Boolean
      {

         return this.m_MidDistance;
      }
      
      public function set forceShow(param1:Boolean) : void
      {

         if(param1 != this.m_ForceShow)
         {
            SetIsDirty();
         }
         this.m_ForceShow = param1;
      }
      
      public function get forceShow() : Boolean
      {

         return this.m_ForceShow;
      }
      
      public function set isAI(param1:Boolean) : void
      {

         if(param1 != this.m_IsAI)
         {
            SetIsDirty();
         }
         this.m_IsAI = param1;
      }
      
      public function get isAI() : Boolean
      {

         return this.m_IsAI;
      }
      
      public function set distanceFromPlayer(param1:Number) : void
      {

         if(param1 != this.m_DistanceFromPlayer)
         {
            SetIsDirty();
         }
         this.m_DistanceFromPlayer = param1;
      }
      
      public function get distanceFromPlayer() : Number
      {

         return this.m_DistanceFromPlayer;
      }
      
      public function set isOnScreen(param1:Boolean) : void
      {

         if(param1 != this.m_IsOnScreen)
         {
            SetIsDirty();
         }
         this.m_IsOnScreen = param1;
      }
      
      public function get isOnScreen() : Boolean
      {

         return this.m_IsOnScreen;
      }
      
      public function set alertState(param1:int) : void
      {

         if(param1 != this.m_AlertState)
         {
            SetIsDirty();
         }
         this.m_AlertState = param1;
      }
      
      public function set alertMessage(param1:String) : void
      {

         if(param1 != this.m_AlertMessage)
         {
            SetIsDirty();
         }
         this.m_AlertMessage = param1;
      }
      
      public function set label(param1:String) : void
      {

         if(param1 != this.m_Label)
         {
            SetIsDirty();
         }
         this.m_Label = param1;
      }
      
      public function set markerID(param1:String) : void
      {

         this.m_MarkerID = param1;
      }
      
      public function get markerID() : String
      {

         return this.m_MarkerID;
      }
      
      public function set meterValue(param1:Number) : void
      {

         if(this.m_MeterValue != param1)
         {
            SetIsDirty();
         }
         this.m_MeterValue = param1;
      }
      
      public function get type() : String
      {

         return this.m_Type;
      }
      
      public function set type(param1:String) : void
      {

         if(this.m_Type != param1)
         {
            SetIsDirty();
         }
         this.m_Type = param1;
      }
      
      private function updateQuestTypeFrame() : void
      {

         if(this.Marker_mc.Internal_mc != null)
         {
            switch(this.m_QuestDisplayType)
            {
               case GlobalFunc.QUEST_DISPLAY_TYPE_MAIN:
                  this.Marker_mc.Internal_mc.gotoAndStop("Main");
                  break;
               case GlobalFunc.QUEST_DISPLAY_TYPE_SIDE:
                  this.Marker_mc.Internal_mc.gotoAndStop("Side");
                  break;
               default:
                  this.Marker_mc.Internal_mc.gotoAndStop("Misc");
            }
         }
      }
      
      private function setType() : void
      {

         var _loc1_:Array = this.Marker_mc.currentLabels;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(this.m_Type == _loc1_[_loc2_].name)
            {
               this.Marker_mc.gotoAndStop(this.m_Type);
               if(this.m_Type == "ActiveQuest" || this.m_Type == "InactiveQuest" || this.m_Type == "SharedQuest")
               {
                  if(this.m_MidDistance && !this.m_IsAI && !this.m_ShowLabel)
                  {
                     this.Marker_mc.gotoAndStop("QuestDistance");
                     if(this.m_Type == "ActiveQuest" || this.m_Type == "InactiveQuest")
                     {
                        this.updateQuestTypeFrame();
                     }
                  }
                  else if(this.m_IsAI)
                  {
                     this.Marker_mc.gotoAndStop("QuestNPC");
                  }
                  else if(this.m_Type == "ActiveQuest" || this.m_Type == "InactiveQuest")
                  {
                     this.updateQuestTypeFrame();
                  }
               }
               break;
            }
            _loc2_++;
         }
      }
      
      public function set showMeter(param1:Boolean) : void
      {

      }
      
      public function get showLabel() : Boolean
      {

         return this.m_ShowLabel;
      }
      
      public function set showLabel(param1:Boolean) : void
      {

         if(param1 != this.m_ShowLabel)
         {
            SetIsDirty();
         }
         this.m_ShowLabel = param1;
      }
      
      override public function redrawUIComponent() : void
      {

         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         if(this.m_AlertState > ALERT_STATE_NONE)
         {
            this.Alert_mc.visible = true;
            _loc1_ = this.Alert_mc.currentLabels;
            _loc2_ = "AlertState1";
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               if(_loc1_[_loc3_].name == "AlertState" + this.m_AlertState)
               {
                  _loc2_ = _loc1_[_loc3_].name;
                  break;
               }
               _loc3_++;
            }
            this.Alert_mc.gotoAndPlay(_loc2_);
         }
         else
         {
            this.Alert_mc.visible = false;
         }
         this.Objective_mc.visible = this.m_ShowLabel && this.m_Label.length > 0;
         this.Objective_mc.Objective_tf.text = this.m_Label;
         var _loc4_:TextField = this.Alert_mc.AlertText_mc.AlertText_tf;
         _loc4_.text = this.m_AlertMessage != null?this.m_AlertMessage:"";
         this.Alert_mc.Backer_mc.Box_mc.width = _loc4_.getLineMetrics(0).width + this.m_AlertSizeBuffer;
         this.setType();
      }
   }
}
