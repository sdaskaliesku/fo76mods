 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class HUDFloatingTargetManager extends MovieClip
   {
      
      private static const AimMagnitudeThresholdPercent:Number = // method body index: 878 method index: 878
      0.1;
      
      private static const AimInnerDistanceThreshold:Number = // method body index: 878 method index: 878
      20;
       
      
      private var m_Targets:Array;
      
      private var m_HudModes:Array;
      
      var m_CenterMostTarget:HUDFloatingTarget = null;
      
      private var m_AimOuterDistanceThreshold:Number = 100;
      
      public function HUDFloatingTargetManager()
      {
         // method body index: 879 method index: 879
         super();
         this.m_Targets = new Array();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : *
      {
         // method body index: 880 method index: 880
         this.m_HudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.WORKSHOP_MODE,HUDModes.CAMP_PLACEMENT,HUDModes.CROSSHAIR_AND_ACTIVATE_ONLY);
         BSUIDataManager.Subscribe("MapMenuDataChanges",this.onFloatingTargetChange);
         BSUIDataManager.Subscribe("HUDModeData",this.onHudModeDataChange);
         BSUIDataManager.Subscribe("ReconMarkerData",this.onReconMarkerData);
         BSUIDataManager.Subscribe("BabylonMarkersData",this.onBabylonMarkersData);
      }
      
      private function onHudModeDataChange(param1:FromClientDataEvent) : *
      {
         // method body index: 881 method index: 881
         this.visible = param1.data.showFloatingMarkers == true && this.m_HudModes.indexOf(param1.data.hudMode) != -1;
      }
      
      private function onFloatingTargetChange(param1:FromClientDataEvent) : *
      {
         // method body index: 882 method index: 882
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:* = undefined;
         var _loc10_:uint = 0;
         var _loc11_:HUDFloatingTarget = null;
         var _loc12_:* = false;
         var _loc13_:* = false;
         var _loc14_:* = false;
         var _loc15_:* = false;
         var _loc16_:* = false;
         var _loc17_:* = false;
         var _loc18_:Array = BSUIDataManager.GetDataFromClient("MapMenuData").data.MarkerData;
         var _loc19_:Array = param1.data.MarkerChanges;
         this.m_AimOuterDistanceThreshold = BSUIDataManager.GetDataFromClient("MapMenuData").data.questMarkerDistance;
         var _loc20_:* = stage.stageHeight * AimMagnitudeThresholdPercent;
         var _loc21_:Boolean = false;
         var _loc22_:HUDFloatingTarget = null;
         var _loc23_:HUDFloatingTarget = null;
         if(this.m_CenterMostTarget != null)
         {
            this.m_CenterMostTarget.showLabel = false;
            this.m_CenterMostTarget.visible = false;
         }
         var _loc24_:uint = 0;
         while(_loc24_ < _loc19_.length)
         {
            _loc2_ = _loc19_[_loc24_].index;
            _loc3_ = _loc19_[_loc24_].type;
            _loc4_ = _loc19_[_loc24_].markerID;
            if(_loc3_ == "RemoveMarker")
            {
               _loc5_ = this.getTargetByID(this.m_Targets,_loc4_);
               if(_loc5_ != uint.MAX_VALUE)
               {
                  removeChild(this.m_Targets[_loc5_]);
                  this.m_Targets.splice(_loc5_,1);
               }
            }
            else if(_loc2_ < _loc18_.length)
            {
               _loc6_ = _loc18_[_loc2_];
               _loc7_ = false;
               _loc8_ = false;
               if(!(_loc6_.type != "ActiveQuest" && _loc6_.type != "InactiveQuest" && _loc6_.type != "SharedQuest" && _loc6_.type != "MainActiveQuest"))
               {
                  _loc9_ = _loc6_.markerID;
                  _loc10_ = this.getTargetByID(this.m_Targets,_loc9_);
                  if(_loc10_ != uint.MAX_VALUE)
                  {
                     if(this.m_Targets[_loc10_].distanceFromPlayer > AimInnerDistanceThreshold && this.m_Targets[_loc10_].distanceFromPlayer < this.m_AimOuterDistanceThreshold && !_loc6_.isAI && _loc6_.onScreen)
                     {
                        _loc7_ = true;
                        _loc8_ = true;
                     }
                     this.m_Targets[_loc10_].forceShow = _loc7_;
                     this.m_Targets[_loc10_].midDistance = _loc8_;
                  }
                  switch(_loc3_)
                  {
                     case "AddMarker":
                        if(_loc10_ != uint.MAX_VALUE)
                        {
                           this.updateTarget(this.m_Targets[_loc10_],_loc6_);
                        }
                        else
                        {
                           this.addTarget(_loc6_);
                        }
                        break;
                     case "UpdateMarker":
                     case "UpdateScreenCoords":
                        if(_loc10_ != uint.MAX_VALUE)
                        {
                           this.updateTarget(this.m_Targets[_loc10_],_loc6_);
                        }
                  }
                  if(_loc10_ != uint.MAX_VALUE && !_loc6_.isAI && _loc6_.showLabel)
                  {
                     _loc11_ = this.m_Targets[_loc10_];
                     if(_loc11_ != null)
                     {
                        _loc12_ = _loc11_.distanceFromPlayer < AimInnerDistanceThreshold;
                        _loc13_ = _loc11_.distanceFromPlayer < this.m_AimOuterDistanceThreshold;
                        _loc14_ = _loc11_.centerMagnitude < _loc20_;
                        if(_loc14_)
                        {
                           if(_loc12_)
                           {
                              _loc21_ = true;
                              if(_loc22_ == null || _loc11_.centerMagnitude < _loc22_.centerMagnitude)
                              {
                                 _loc22_ = _loc11_;
                              }
                           }
                           else if(_loc13_)
                           {
                              if(_loc23_ == null || _loc11_.centerMagnitude < _loc23_.centerMagnitude)
                              {
                                 _loc23_ = _loc11_;
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc24_++;
         }
         if(this.m_CenterMostTarget != null)
         {
            if(_loc21_ || this.m_CenterMostTarget.distanceFromPlayer < AimInnerDistanceThreshold)
            {
               if(_loc22_ != null && _loc22_.centerMagnitude < this.m_CenterMostTarget.centerMagnitude)
               {
                  this.m_CenterMostTarget = _loc22_;
               }
            }
            else if(_loc23_ != null && _loc23_.centerMagnitude < this.m_CenterMostTarget.centerMagnitude)
            {
               this.m_CenterMostTarget = _loc23_;
            }
         }
         else if(_loc22_ != null)
         {
            this.m_CenterMostTarget = _loc22_;
         }
         else if(_loc23_ != null)
         {
            this.m_CenterMostTarget = _loc23_;
         }
         if(this.m_CenterMostTarget)
         {
            _loc15_ = this.m_CenterMostTarget.distanceFromPlayer < AimInnerDistanceThreshold;
            _loc16_ = this.m_CenterMostTarget.distanceFromPlayer < this.m_AimOuterDistanceThreshold;
            _loc17_ = this.m_CenterMostTarget.centerMagnitude < _loc20_;
            if(!_loc17_ || !_loc16_ || !this.m_CenterMostTarget.isOnScreen)
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
         // method body index: 883 method index: 883
         var _loc1_:HUDFloatingTarget = null;
         var _loc2_:HUDFloatingTarget = null;
         var _loc3_:uint = 0;
         while(_loc3_ < this.m_Targets.length)
         {
            _loc1_ = this.m_Targets[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function IsReconMarker(param1:HUDFloatingTarget) : Boolean
      {
         // method body index: 884 method index: 884
         return param1.type == "Recon" || param1.type == "EnemyTargeted";
      }
      
      private function onReconMarkerData(param1:FromClientDataEvent) : *
      {
         // method body index: 885 method index: 885
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Array = param1.data.reconMarkers;
         var _loc6_:Array = new Array();
         var _loc7_:uint = 0;
         while(_loc7_ < this.m_Targets.length)
         {
            _loc2_ = false;
            if(this.IsReconMarker(this.m_Targets[_loc7_]))
            {
               _loc3_ = this.getTargetByID(_loc5_,this.m_Targets[_loc7_].markerID);
               if(_loc3_ == uint.MAX_VALUE)
               {
                  removeChild(this.m_Targets[_loc7_]);
                  this.m_Targets.splice(_loc7_,1);
                  _loc2_ = true;
               }
            }
            if(!_loc2_)
            {
               _loc7_++;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc4_ = this.getTargetByID(this.m_Targets,_loc5_[_loc7_].markerID);
            if(_loc4_ != uint.MAX_VALUE)
            {
               if(this.IsReconMarker(this.m_Targets[_loc4_]))
               {
                  this.updateTarget(this.m_Targets[_loc4_],_loc5_[_loc7_]);
               }
            }
            else
            {
               this.addTarget(_loc5_[_loc7_]);
            }
            _loc7_++;
         }
      }
      
      private function onBabylonMarkersData(param1:FromClientDataEvent) : *
      {
         // method body index: 886 method index: 886
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Array = param1.data.babylonMarkers;
         var _loc6_:Array = new Array();
         var _loc7_:uint = 0;
         while(_loc7_ < this.m_Targets.length)
         {
            _loc2_ = false;
            _loc3_ = this.getTargetByID(_loc5_,this.m_Targets[_loc7_].markerID);
            if(_loc3_ == uint.MAX_VALUE)
            {
               removeChild(this.m_Targets[_loc7_]);
               this.m_Targets.splice(_loc7_,1);
               _loc2_ = true;
            }
            if(!_loc2_)
            {
               _loc7_++;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc4_ = this.getTargetByID(this.m_Targets,_loc5_[_loc7_].markerID);
            if(_loc4_ != uint.MAX_VALUE)
            {
               this.updateTarget(this.m_Targets[_loc4_],_loc5_[_loc7_]);
            }
            else
            {
               this.addTarget(_loc5_[_loc7_]);
            }
            _loc7_++;
         }
      }
      
      private function getTargetByID(param1:Array, param2:uint) : uint
      {
         // method body index: 887 method index: 887
         var _loc3_:Boolean = false;
         var _loc4_:uint = uint.MAX_VALUE;
         var _loc5_:uint = 0;
         while(!_loc3_ && _loc5_ < param1.length)
         {
            if(param1[_loc5_].markerID == param2)
            {
               _loc4_ = _loc5_;
               _loc3_ = true;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function updateTarget(param1:HUDFloatingTarget, param2:Object) : *
      {
         // method body index: 888 method index: 888
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = false;
         var _loc8_:Boolean = false;
         var _loc9_:Number = Number.MAX_VALUE;
         if(param2.onScreen)
         {
            _loc7_ = param2.distanceFromPlayer < AimInnerDistanceThreshold;
            _loc3_ = stage.stageWidth / 2;
            _loc4_ = stage.stageHeight / 2;
            _loc5_ = param2.screenX - _loc3_;
            _loc6_ = param2.screenY - _loc4_;
            _loc9_ = Math.sqrt(Math.pow(_loc5_,2) + Math.pow(_loc6_,2));
         }
         param1.centerMagnitude = _loc9_;
         param1.distanceFromPlayer = param2.distanceFromPlayer;
         param1.isOnScreen = param2.onScreen;
         param1.visible = param2.onScreen && _loc7_ || param1.forceShow;
         param1.markerID = param2.markerID;
         param1.x = param2.screenX;
         param1.y = param2.screenY;
         param1.type = param2.type;
         param1.isAI = param2.isAI;
         param1.label = param2.text;
         param1.showMeter = param2.showMeter;
         param1.showLabel = false;
         param1.meterValue = param2.meterValue;
         param1.alertState = param2.announceState;
         param1.alertMessage = param2.announce;
         param1.questDisplayType = param2.questDisplayType;
      }
      
      private function addTarget(param1:Object) : HUDFloatingTarget
      {
         // method body index: 889 method index: 889
         var _loc2_:HUDFloatingTarget = new HUDFloatingTarget();
         addChild(_loc2_);
         this.m_Targets.push(_loc2_);
         this.updateTarget(_loc2_,param1);
         return _loc2_;
      }
   }
}
