 
package
{
   import Shared.AS3.BSDisplayObject;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   
   public class TeammateMarkersManager extends BSDisplayObject
   {
       
      
      public var TeamNameplates:Vector.<TeammateNameplate>;
      
      public var UnusedTeamNameplates:Vector.<TeammateNameplate>;
      
      public function TeammateMarkersManager()
      {

         this.TeamNameplates = new Vector.<TeammateNameplate>();
         this.UnusedTeamNameplates = new Vector.<TeammateNameplate>();
         super();
      }
      
      override public function onAddedToStage() : void
      {

         super.onAddedToStage();
         BSUIDataManager.Subscribe("TeamMarkers",this.onTeamMarkersUpdate);
      }
      
      private function UpdateTeammate(namePlate:TeammateNameplate, marker:Object) : void
      {

         namePlate.isLeader = marker.isLeader;
         namePlate.displayName = marker.displayName;
         namePlate.playerState = marker.playerState;
         namePlate.wantedState = marker.wantedState;
         namePlate.entityID = marker.entityID;
         namePlate.isLocalPlayer = marker.isLocalPlayer;
         namePlate.rads = marker.rads;
         namePlate.HPPct = marker.HPPct;
         namePlate.isFriend = marker.isFriend;
         namePlate.isFriendInvitePending = marker.isFriendInvitePending;
         namePlate.deadState = marker.deadState;
         namePlate.isTeammate = marker.isTeammate;
         namePlate.isEventGroup = marker.isEventGroup;
         namePlate.isHostile = marker.isHostile;
         namePlate.isPvPFlagged = marker.isPvPFlagged;
         namePlate.isNuclearWinterMode = marker.isNuclearWinterMode;
         namePlate.isInConversation = marker.isInConversation;
         namePlate.teamType = marker.teamType;
         namePlate.isPublicTeamLeader = marker.isPublicTeamLeader;
         if(!§§pop())
         {
            namePlate.voiceChatStatus = marker.voiceChatStatus;
         }
         if(!§§pop())
         {
            namePlate.isSpeakingInSameChannel = marker.isSpeakingInSameChannel;
         }
         namePlate.bounty = marker.bounty;
         if(marker.level != null)
         {
            namePlate.level = marker.level;
         }
         if(marker.isOnScreen != null)
         {
            namePlate.isOnScreen = marker.isOnScreen;
         }
         if(marker.isBeyondRailLimits != null)
         {
            namePlate.isBeyondRailLimits = marker.isBeyondRailLimits;
         }
         namePlate.inLOS = marker.inLOS;
         namePlate.revengeTarget = marker.revengeTarget;
      }
      
      private function onTeamMarkersUpdate(event:FromClientDataEvent) : void
      {

         var teamMarkerData:Array = null;
         var marker:Object = null;
         var numNameplates:int = 0;
         var iNameplate:int = 0;
         var item:TeammateNameplate = null;
         var newNamePlate:TeammateNameplate = null;
         var plate:TeammateNameplate = null;
         var found:Boolean = false;
         var markerIndex:int = 0;
         teamMarkerData = event.data.Markers;
         var markerCount:int = teamMarkerData.length;
         for(var iMarker:int = 0; iMarker < markerCount; iMarker++)
         {
            marker = teamMarkerData[iMarker];
            numNameplates = this.TeamNameplates.length;
            for(iNameplate = 0; iNameplate < numNameplates; )
            {
               item = this.TeamNameplates[iNameplate];
               if(item.entityID == marker.entityID)
               {
                  if(marker.isMarkerDirty)
                  {
                     this.UpdateTeammate(item,marker);
                  }
                  break;
               }
               iNameplate++;
            }
            if(iNameplate == numNameplates)
            {
               if(this.UnusedTeamNameplates.length == 0)
               {
                  newNamePlate = new TeammateNameplate();
                  addChild(newNamePlate);
               }
               else
               {
                  newNamePlate = this.UnusedTeamNameplates.shift();
               }
               newNamePlate.visible = true;
               this.UpdateTeammate(newNamePlate,marker);
               this.TeamNameplates.push(newNamePlate);
            }
         }
         var plateCount:int = this.TeamNameplates.length;
         for(iNameplate = plateCount - 1; iNameplate >= 0; iNameplate--)
         {
            plate = this.TeamNameplates[iNameplate];
            found = false;
            markerIndex = 0;
            while(!found && markerIndex < markerCount)
            {
               if(teamMarkerData[markerIndex].entityID == plate.entityID)
               {
                  found = true;
               }
               markerIndex++;
            }
            if(!found)
            {
               this.UnusedTeamNameplates.push(this.TeamNameplates.splice(iNameplate,1)[0]);
               this.UnusedTeamNameplates[this.UnusedTeamNameplates.length - 1].visible = false;
            }
         }
      }
   }
}
