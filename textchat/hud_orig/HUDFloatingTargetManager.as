 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class HUDFloatingTargetManager extends MovieClip
   {
      
      private static const AimMagnitudeThresholdPercent:Number = // method body index: 952 method index: 952
      0.1;
      
      private static const AimInnerDistanceThreshold:Number = // method body index: 952 method index: 952
      20;
       
      
      private var m_Targets:Array;
      
      private var HUDModes:Array;
      
      var m_CenterMostTarget:HUDFloatingTarget = null;
      
      private var m_AimOuterDistanceThreshold:Number = 100;
      
      public function HUDFloatingTargetManager()
      {

         super();
         this.m_Targets = new Array();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(e:Event) : *
      {

         this.HUDModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.WORKSHOP_MODE,HUDModes.CAMP_PLACEMENT,HUDModes.CROSSHAIR_AND_ACTIVATE_ONLY);
         BSUIDataManager.Subscribe("MapMenuDataChanges",this.onFloatingTargetChange);
         BSUIDataManager.Subscribe("HUDModeData",this.onHudModeDataChange);
         BSUIDataManager.Subscribe("ReconMarkerData",this.onReconMarkerData);
         BSUIDataManager.Subscribe("BabylonMarkersData",this.onBabylonMarkersData);
      }
      
      private function onHudModeDataChange(event:FromClientDataEvent) : *
      {

         this.visible = event.data.showFloatingMarkers == true && this.HUDModes.indexOf(event.data.hudMode) != -1;
      }
      
      private function onFloatingTargetChange(arEvent:FromClientDataEvent) : *
      {

         var changeIndex:* = undefined;
         var changeType:* = undefined;
         var changeMarkerID:* = undefined;
         var removeIdx:uint = 0;
         var targetData:* = undefined;
         var forceShow:Boolean = false;
         var midDistance:Boolean = false;
         var targetID:* = undefined;
         var matchIdx:uint = 0;
         var tmp:HUDFloatingTarget = null;
         var withinInnerThreshold:* = false;
         var withinOuterThreshold:* = false;
         var withinAimMagThreshold:* = false;
         var wit:* = false;
         var wot:* = false;
         var wamt:* = false;
         var markerDataArray:Array = BSUIDataManager.GetDataFromClient("MapMenuData").data.MarkerData;
         var markerChanges:Array = arEvent.data.MarkerChanges;
         this.m_AimOuterDistanceThreshold = BSUIDataManager.GetDataFromClient("MapMenuData").data.questMarkerDistance;
         var aimMagThreshhold:* = stage.stageHeight * AimMagnitudeThresholdPercent;
         var hasAnyInInnerThreshold:Boolean = false;
         var bestInnerTarget:HUDFloatingTarget = null;
         var bestOuterTarget:HUDFloatingTarget = null;
         if(this.m_CenterMostTarget != null)
         {
            this.m_CenterMostTarget.showLabel = false;
            this.m_CenterMostTarget.visible = false;
         }
         for(var i:uint = 0; i < markerChanges.length; i++)
         {
            changeIndex = markerChanges[i].index;
            changeType = markerChanges[i].type;
            changeMarkerID = markerChanges[i].markerID;
            if(changeType == "RemoveMarker")
            {
               removeIdx = this.getTargetByID(this.m_Targets,changeMarkerID);
               if(removeIdx != uint.MAX_VALUE)
               {
                  removeChild(this.m_Targets[removeIdx]);
                  this.m_Targets.splice(removeIdx,1);
               }
            }
            else if(changeIndex < markerDataArray.length)
            {
               targetData = markerDataArray[changeIndex];
               forceShow = false;
               midDistance = false;
               if(!(targetData.type != "ActiveQuest" && targetData.type != "InactiveQuest" && targetData.type != "SharedQuest" && targetData.type != "MainActiveQuest"))
               {
                  targetID = targetData.markerID;
                  matchIdx = this.getTargetByID(this.m_Targets,targetID);
                  if(matchIdx != uint.MAX_VALUE)
                  {
                     if(this.m_Targets[matchIdx].distanceFromPlayer > AimInnerDistanceThreshold && this.m_Targets[matchIdx].distanceFromPlayer < this.m_AimOuterDistanceThreshold && !targetData.isAI && targetData.onScreen)
                     {
                        forceShow = true;
                        midDistance = true;
                     }
                     this.m_Targets[matchIdx].forceShow = forceShow;
                     this.m_Targets[matchIdx].midDistance = midDistance;
                  }
                  switch(changeType)
                  {
                     case "AddMarker":
                        if(matchIdx != uint.MAX_VALUE)
                        {
                           this.updateTarget(this.m_Targets[matchIdx],targetData);
                        }
                        else
                        {
                           this.addTarget(targetData);
                        }
                        break;
                     case "UpdateMarker":
                     case "UpdateScreenCoords":
                        if(matchIdx != uint.MAX_VALUE)
                        {
                           this.updateTarget(this.m_Targets[matchIdx],targetData);
                        }
                  }
                  if(matchIdx != uint.MAX_VALUE && !targetData.isAI && targetData.showLabel)
                  {
                     tmp = this.m_Targets[matchIdx];
                     if(tmp != null)
                     {
                        withinInnerThreshold = tmp.distanceFromPlayer < AimInnerDistanceThreshold;
                        withinOuterThreshold = tmp.distanceFromPlayer < this.m_AimOuterDistanceThreshold;
                        withinAimMagThreshold = tmp.centerMagnitude < aimMagThreshhold;
                        if(withinAimMagThreshold)
                        {
                           if(withinInnerThreshold)
                           {
                              hasAnyInInnerThreshold = true;
                              if(bestInnerTarget == null || tmp.centerMagnitude < bestInnerTarget.centerMagnitude)
                              {
                                 bestInnerTarget = tmp;
                              }
                           }
                           else if(withinOuterThreshold)
                           {
                              if(bestOuterTarget == null || tmp.centerMagnitude < bestOuterTarget.centerMagnitude)
                              {
                                 bestOuterTarget = tmp;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         if(this.m_CenterMostTarget != null)
         {
            if(hasAnyInInnerThreshold || this.m_CenterMostTarget.distanceFromPlayer < AimInnerDistanceThreshold)
            {
               if(bestInnerTarget != null && bestInnerTarget.centerMagnitude < this.m_CenterMostTarget.centerMagnitude)
               {
                  this.m_CenterMostTarget = bestInnerTarget;
               }
            }
            else if(bestOuterTarget != null && bestOuterTarget.centerMagnitude < this.m_CenterMostTarget.centerMagnitude)
            {
               this.m_CenterMostTarget = bestOuterTarget;
            }
         }
         else if(bestInnerTarget != null)
         {
            this.m_CenterMostTarget = bestInnerTarget;
         }
         else if(bestOuterTarget != null)
         {
            this.m_CenterMostTarget = bestOuterTarget;
         }
         if(this.m_CenterMostTarget)
         {
            wit = this.m_CenterMostTarget.distanceFromPlayer < AimInnerDistanceThreshold;
            wot = this.m_CenterMostTarget.distanceFromPlayer < this.m_AimOuterDistanceThreshold;
            wamt = this.m_CenterMostTarget.centerMagnitude < aimMagThreshhold;
            if(!wamt || !wot || !this.m_CenterMostTarget.isOnScreen)
            {
               this.m_CenterMostTarget = null;
            }
         }
         if(this.m_CenterMostTarget)
         {
            this.m_CenterMostTarget.showLabel = true;
            this.m_CenterMostTarget.visible = true;
         }
      }
      
      private function FindCenterMostTarget() : HUDFloatingTarget
      {

         var target:HUDFloatingTarget = null;
         var result:HUDFloatingTarget = null;
         for(var i:uint = 0; i < this.m_Targets.length; i++)
         {
            target = this.m_Targets[i];
         }
         return result;
      }
      
      private function IsReconMarker(aTarget:HUDFloatingTarget) : Boolean
      {

         return aTarget.type == "Recon" || aTarget.type == "EnemyTargeted";
      }
      
      private function onReconMarkerData(arEvent:FromClientDataEvent) : *
      {

         var removed:Boolean = false;
         var reconIdx:uint = 0;
         var matchIdx:uint = 0;
         var reconArray:Array = arEvent.data.reconMarkers;
         var removeMarkers:Array = new Array();
         var i:uint = 0;
         while(i < this.m_Targets.length)
         {
            removed = false;
            if(this.IsReconMarker(this.m_Targets[i]))
            {
               reconIdx = this.getTargetByID(reconArray,this.m_Targets[i].markerID);
               if(reconIdx == uint.MAX_VALUE)
               {
                  removeChild(this.m_Targets[i]);
                  this.m_Targets.splice(i,1);
                  removed = true;
               }
            }
            if(!removed)
            {
               i++;
            }
         }
         for(i = 0; i < reconArray.length; i++)
         {
            matchIdx = this.getTargetByID(this.m_Targets,reconArray[i].markerID);
            if(matchIdx != uint.MAX_VALUE)
            {
               if(this.IsReconMarker(this.m_Targets[matchIdx]))
               {
                  this.updateTarget(this.m_Targets[matchIdx],reconArray[i]);
               }
            }
            else
            {
               this.addTarget(reconArray[i]);
            }
         }
      }
      
      private function onBabylonMarkersData(arEvent:FromClientDataEvent) : *
      {

         var removed:Boolean = false;
         var markerIdx:uint = 0;
         var matchIdx:uint = 0;
         var markerArray:Array = arEvent.data.babylonMarkers;
         var removeMarkers:Array = new Array();
         var i:uint = 0;
         while(i < this.m_Targets.length)
         {
            removed = false;
            markerIdx = this.getTargetByID(markerArray,this.m_Targets[i].markerID);
            if(markerIdx == uint.MAX_VALUE)
            {
               removeChild(this.m_Targets[i]);
               this.m_Targets.splice(i,1);
               removed = true;
            }
            if(!removed)
            {
               i++;
            }
         }
         for(i = 0; i < markerArray.length; i++)
         {
            matchIdx = this.getTargetByID(this.m_Targets,markerArray[i].markerID);
            if(matchIdx != uint.MAX_VALUE)
            {
               this.updateTarget(this.m_Targets[matchIdx],markerArray[i]);
            }
            else
            {
               this.addTarget(markerArray[i]);
            }
         }
      }
      
      private function getTargetByID(aData:Array, aMarkerID:uint) : uint
      {

         var foundMember:Boolean = false;
         var returnIdx:uint = uint.MAX_VALUE;
         var i:uint = 0;
         while(!foundMember && i < aData.length)
         {
            if(aData[i].markerID == aMarkerID)
            {
               returnIdx = i;
               foundMember = true;
            }
            i++;
         }
         return returnIdx;
      }
      
      private function updateTarget(aTarget:HUDFloatingTarget, aTargetData:Object) : *
      {

         var centerX:* = undefined;
         var centerY:* = undefined;
         var deltaX:* = undefined;
         var deltaY:* = undefined;
         var withinInnerDistance:* = false;
         var withinOuterDistance:Boolean = false;
         var magnitude:Number = Number.MAX_VALUE;
         if(aTargetData.onScreen)
         {
            withinInnerDistance = aTargetData.distanceFromPlayer < AimInnerDistanceThreshold;
            centerX = stage.stageWidth / 2;
            centerY = stage.stageHeight / 2;
            deltaX = aTargetData.screenX - centerX;
            deltaY = aTargetData.screenY - centerY;
            magnitude = Math.sqrt(Math.pow(deltaX,2) + Math.pow(deltaY,2));
         }
         aTarget.centerMagnitude = magnitude;
         aTarget.distanceFromPlayer = aTargetData.distanceFromPlayer;
         aTarget.isOnScreen = aTargetData.onScreen;
         aTarget.visible = aTargetData.onScreen && withinInnerDistance || aTarget.forceShow;
         aTarget.markerID = aTargetData.markerID;
         aTarget.x = aTargetData.screenX;
         aTarget.y = aTargetData.screenY;
         aTarget.type = aTargetData.type;
         aTarget.isAI = aTargetData.isAI;
         aTarget.label = aTargetData.text;
         aTarget.showMeter = aTargetData.showMeter;
         aTarget.showLabel = false;
         aTarget.meterValue = aTargetData.meterValue;
         aTarget.alertState = aTargetData.announceState;
         aTarget.alertMessage = aTargetData.announce;
         aTarget.questDisplayType = aTargetData.questDisplayType;
      }
      
      private function addTarget(aTargetData:Object) : HUDFloatingTarget
      {

         var newTarget:HUDFloatingTarget = new HUDFloatingTarget();
         addChild(newTarget);
         this.m_Targets.push(newTarget);
         this.updateTarget(newTarget,aTargetData);
         return newTarget;
      }
   }
}
