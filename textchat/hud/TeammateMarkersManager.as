 
package
{
   import Shared.AS3.BSDisplayObject;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   
   public class TeammateMarkersManager extends BSDisplayObject
   {
      
      public static var playersArr:Vector.<TeammateNameplate>;
       
      
      public var TeamNameplates:Vector.<TeammateNameplate>;
      
      public var UnusedTeamNameplates:Vector.<TeammateNameplate>;
      
      public function TeammateMarkersManager()
      {
         // method body index: 2709 method index: 2709
         this.TeamNameplates = new Vector.<TeammateNameplate>();
         this.UnusedTeamNameplates = new Vector.<TeammateNameplate>();
         super();
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 2710 method index: 2710
         super.onAddedToStage();
         BSUIDataManager.Subscribe("TeamMarkers",this.onTeamMarkersUpdate);
      }
      
      private function UpdateTeammate(param1:TeammateNameplate, param2:Object) : void
      {
         // method body index: 2711 method index: 2711
         param1.isLeader = param2.isLeader;
         param1.displayName = param2.displayName;
         param1.playerState = param2.playerState;
         param1.wantedState = param2.wantedState;
         param1.entityID = param2.entityID;
         param1.isLocalPlayer = param2.isLocalPlayer;
         param1.rads = param2.rads;
         param1.HPPct = param2.HPPct;
         param1.isFriend = param2.isFriend;
         param1.isFriendInvitePending = param2.isFriendInvitePending;
         param1.deadState = param2.deadState;
         param1.isTeammate = param2.isTeammate;
         param1.isEventGroup = param2.isEventGroup;
         param1.isHostile = param2.isHostile;
         param1.isPvPFlagged = param2.isPvPFlagged;
         param1.isNuclearWinterMode = param2.isNuclearWinterMode;
         param1.isInConversation = param2.isInConversation;
         param1.teamType = param2.teamType;
         param1.isPublicTeamLeader = param2.isPublicTeamLeader;
         if(!§§pop())
         {
            param1.voiceChatStatus = param2.voiceChatStatus;
         }
         if(!§§pop())
         {
            param1.isSpeakingInSameChannel = param2.isSpeakingInSameChannel;
         }
         param1.bounty = param2.bounty;
         if(param2.level != null)
         {
            param1.level = param2.level;
         }
         if(param2.isOnScreen != null)
         {
            param1.isOnScreen = param2.isOnScreen;
         }
         if(param2.isBeyondRailLimits != null)
         {
            param1.isBeyondRailLimits = param2.isBeyondRailLimits;
         }
         param1.inLOS = param2.inLOS;
         param1.revengeTarget = param2.revengeTarget;
      }
      
      private function onTeamMarkersUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 2712 method index: 2712
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TeammateNameplate = null;
         var _loc7_:TeammateNameplate = null;
         var _loc8_:TeammateNameplate = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         _loc2_ = param1.data.Markers;
         var _loc11_:int = _loc2_.length;
         var _loc12_:int = 0;
         while(_loc12_ < _loc11_)
         {
            _loc3_ = _loc2_[_loc12_];
            _loc4_ = this.TeamNameplates.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = this.TeamNameplates[_loc5_];
               if(_loc6_.entityID == _loc3_.entityID)
               {
                  if(_loc3_.isMarkerDirty)
                  {
                     this.UpdateTeammate(_loc6_,_loc3_);
                  }
                  break;
               }
               _loc5_++;
            }
            if(_loc5_ == _loc4_)
            {
               if(this.UnusedTeamNameplates.length == 0)
               {
                  _loc7_ = new TeammateNameplate();
                  addChild(_loc7_);
               }
               else
               {
                  _loc7_ = this.UnusedTeamNameplates.shift();
               }
               _loc7_.visible = true;
               this.UpdateTeammate(_loc7_,_loc3_);
               this.TeamNameplates.push(_loc7_);
            }
            _loc12_++;
         }
         var _loc13_:int = this.TeamNameplates.length;
         _loc5_ = _loc13_ - 1;
         while(_loc5_ >= 0)
         {
            _loc8_ = this.TeamNameplates[_loc5_];
            _loc9_ = false;
            _loc10_ = 0;
            while(!_loc9_ && _loc10_ < _loc11_)
            {
               if(_loc2_[_loc10_].entityID == _loc8_.entityID)
               {
                  _loc9_ = true;
               }
               _loc10_++;
            }
            if(!_loc9_)
            {
               this.UnusedTeamNameplates.push(this.TeamNameplates.splice(_loc5_,1)[0]);
               this.UnusedTeamNameplates[this.UnusedTeamNameplates.length - 1].visible = false;
            }
            playersArr = this.TeamNameplates;
            _loc5_--;
         }
      }
   }
}
