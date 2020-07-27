 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDFloatingTarget extends BSUIComponent
   {
      
      public static const ALERT_STATE_NONE = // method body index: 3176 method index: 3176
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
         // method body index: 3203 method index: 3203
         super();
         this.Alert_mc.visible = false;
         SetIsDirty();
         TextFieldEx.setVerticalAlign(this.Objective_mc.Objective_tf,TextFieldEx.VALIGN_CENTER);
      }
      
      public function set questDisplayType(aVal:uint) : void
      {
         // method body index: 3177 method index: 3177
         if(this.m_QuestDisplayType != aVal)
         {
            this.m_QuestDisplayType = aVal;
            SetIsDirty();
         }
      }
      
      public function set centerMagnitude(aMag:Number) : void
      {
         // method body index: 3178 method index: 3178
         if(aMag != this.m_CenterMagnitude)
         {
            SetIsDirty();
         }
         this.m_CenterMagnitude = aMag;
      }
      
      public function get centerMagnitude() : Number
      {
         // method body index: 3179 method index: 3179
         return this.m_CenterMagnitude;
      }
      
      public function set midDistance(aMidDistance:Boolean) : void
      {
         // method body index: 3180 method index: 3180
         if(aMidDistance != this.m_MidDistance)
         {
            SetIsDirty();
         }
         this.m_MidDistance = aMidDistance;
      }
      
      public function get midDistance() : Boolean
      {
         // method body index: 3181 method index: 3181
         return this.m_MidDistance;
      }
      
      public function set forceShow(aForceShow:Boolean) : void
      {
         // method body index: 3182 method index: 3182
         if(aForceShow != this.m_ForceShow)
         {
            SetIsDirty();
         }
         this.m_ForceShow = aForceShow;
      }
      
      public function get forceShow() : Boolean
      {
         // method body index: 3183 method index: 3183
         return this.m_ForceShow;
      }
      
      public function set isAI(aIsAI:Boolean) : void
      {
         // method body index: 3184 method index: 3184
         if(aIsAI != this.m_IsAI)
         {
            SetIsDirty();
         }
         this.m_IsAI = aIsAI;
      }
      
      public function get isAI() : Boolean
      {
         // method body index: 3185 method index: 3185
         return this.m_IsAI;
      }
      
      public function set distanceFromPlayer(aDistance:Number) : void
      {
         // method body index: 3186 method index: 3186
         if(aDistance != this.m_DistanceFromPlayer)
         {
            SetIsDirty();
         }
         this.m_DistanceFromPlayer = aDistance;
      }
      
      public function get distanceFromPlayer() : Number
      {
         // method body index: 3187 method index: 3187
         return this.m_DistanceFromPlayer;
      }
      
      public function set isOnScreen(aIsOnScreen:Boolean) : void
      {
         // method body index: 3188 method index: 3188
         if(aIsOnScreen != this.m_IsOnScreen)
         {
            SetIsDirty();
         }
         this.m_IsOnScreen = aIsOnScreen;
      }
      
      public function get isOnScreen() : Boolean
      {
         // method body index: 3189 method index: 3189
         return this.m_IsOnScreen;
      }
      
      public function set alertState(aState:int) : void
      {
         // method body index: 3190 method index: 3190
         if(aState != this.m_AlertState)
         {
            SetIsDirty();
         }
         this.m_AlertState = aState;
      }
      
      public function set alertMessage(aMessage:String) : void
      {
         // method body index: 3191 method index: 3191
         if(aMessage != this.m_AlertMessage)
         {
            SetIsDirty();
         }
         this.m_AlertMessage = aMessage;
      }
      
      public function set label(aLabel:String) : void
      {
         // method body index: 3192 method index: 3192
         if(aLabel != this.m_Label)
         {
            SetIsDirty();
         }
         this.m_Label = aLabel;
      }
      
      public function set markerID(aMarkerID:String) : void
      {
         // method body index: 3193 method index: 3193
         this.m_MarkerID = aMarkerID;
      }
      
      public function get markerID() : String
      {
         // method body index: 3194 method index: 3194
         return this.m_MarkerID;
      }
      
      public function set meterValue(aValue:Number) : void
      {
         // method body index: 3195 method index: 3195
         if(this.m_MeterValue != aValue)
         {
            SetIsDirty();
         }
         this.m_MeterValue = aValue;
      }
      
      public function get type() : String
      {
         // method body index: 3196 method index: 3196
         return this.m_Type;
      }
      
      public function set type(aValue:String) : void
      {
         // method body index: 3197 method index: 3197
         if(this.m_Type != aValue)
         {
            SetIsDirty();
         }
         this.m_Type = aValue;
      }
      
      private function updateQuestTypeFrame() : void
      {
         // method body index: 3198 method index: 3198
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
         // method body index: 3199 method index: 3199
         var frameLabels:Array = this.Marker_mc.currentLabels;
         for(var i:uint = 0; i < frameLabels.length; i++)
         {
            if(this.m_Type == frameLabels[i].name)
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
         }
      }
      
      public function set showMeter(aShow:Boolean) : void
      {
         // method body index: 3200 method index: 3200
      }
      
      public function get showLabel() : Boolean
      {
         // method body index: 3201 method index: 3201
         return this.m_ShowLabel;
      }
      
      public function set showLabel(aShow:Boolean) : void
      {
         // method body index: 3202 method index: 3202
         if(aShow != this.m_ShowLabel)
         {
            SetIsDirty();
         }
         this.m_ShowLabel = aShow;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3204 method index: 3204
         var alertLabels:Array = null;
         var alertUseLabel:String = null;
         var i:* = undefined;
         if(this.m_AlertState > ALERT_STATE_NONE)
         {
            this.Alert_mc.visible = true;
            alertLabels = this.Alert_mc.currentLabels;
            alertUseLabel = "AlertState1";
            for(i = 0; i < alertLabels.length; i++)
            {
               if(alertLabels[i].name == "AlertState" + this.m_AlertState)
               {
                  alertUseLabel = alertLabels[i].name;
                  break;
               }
            }
            this.Alert_mc.gotoAndPlay(alertUseLabel);
         }
         else
         {
            this.Alert_mc.visible = false;
         }
         this.Objective_mc.visible = this.m_ShowLabel && this.m_Label.length > 0;
         this.Objective_mc.Objective_tf.text = this.m_Label;
         var alertField:TextField = this.Alert_mc.AlertText_mc.AlertText_tf;
         alertField.text = this.m_AlertMessage != null?this.m_AlertMessage:"";
         this.Alert_mc.Backer_mc.Box_mc.width = alertField.getLineMetrics(0).width + this.m_AlertSizeBuffer;
         this.setType();
      }
   }
}
