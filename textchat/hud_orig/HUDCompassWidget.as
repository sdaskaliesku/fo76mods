 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import flash.display.MovieClip;
   
   public dynamic class HUDCompassWidget extends BSUIComponent
   {
       
      
      public var CompassBar_mc:MovieClip;
      
      public var QuestMask_mc:MovieClip;
      
      public var QuestMarkerHolder_mc:MovieClip;
      
      public var OtherMask_mc:MovieClip;
      
      public var OtherMarkerHolder_mc:MovieClip;
      
      public var CompassBGHolder_mc:MovieClip;
      
      public var CenterMarker_mc:MovieClip;
      
      public var AreaQuest_WithinClip_mc:MovieClip;
      
      public var AreaQuest_WithinClipPA_mc:MovieClip;
      
      public var WithinClipVisibility:Boolean;
      
      private var m_IsPowerArmor:Boolean = false;
      
      private var _bNuclearWinterMode:Boolean = false;
      
      public function HUDCompassWidget()
      {

         this.WithinClipVisibility = false;
         super();
         this.AreaQuest_WithinClipPA_mc.visible = false;
         this.CenterMarker_mc.visible = false;
         BSUIDataManager.Subscribe("CompassData",this.onDataChanged);
      }
      
      public function get bNuclearWinterMode() : Boolean
      {

         return this._bNuclearWinterMode;
      }
      
      public function set bNuclearWinterMode(aToggle:Boolean) : *
      {

         this._bNuclearWinterMode = aToggle;
         this.OnNuclearWinterModeChange();
      }
      
      public function set isPowerArmor(aVal:Boolean) : *
      {

         this.m_IsPowerArmor = aVal;
         this.AreaQuest_WithinClip_mc.visible = !this.m_IsPowerArmor;
         this.AreaQuest_WithinClipPA_mc.visible = this.m_IsPowerArmor;
         if(this.m_IsPowerArmor)
         {
            this.QuestMarkerHolder_mc.scaleX = 1;
            this.OtherMarkerHolder_mc.scaleX = 1;
            this.QuestMarkerHolder_mc.x = -this.QuestMarkerHolder_mc.width * 1.5;
            this.OtherMarkerHolder_mc.x = -this.OtherMarkerHolder_mc.width * 1.5;
         }
      }
      
      private function OnNuclearWinterModeChange() : *
      {

         this.CenterMarker_mc.visible = this.bNuclearWinterMode;
      }
      
      private function onDataChanged(aEvent:FromClientDataEvent) : *
      {

         if(aEvent.fromClient.data.withinAreaMarker)
         {
            if(!this.WithinClipVisibility)
            {
               if(this.m_IsPowerArmor)
               {
                  this.AreaQuest_WithinClipPA_mc.gotoAndPlay("rollOn");
               }
               else
               {
                  this.AreaQuest_WithinClip_mc.gotoAndPlay("rollOn");
               }
            }
            this.WithinClipVisibility = true;
         }
         else
         {
            if(this.WithinClipVisibility)
            {
               if(this.m_IsPowerArmor)
               {
                  this.AreaQuest_WithinClipPA_mc.gotoAndPlay("rollOut");
               }
               else
               {
                  this.AreaQuest_WithinClip_mc.gotoAndPlay("rollOut");
               }
            }
            this.WithinClipVisibility = false;
         }
         BSUIDataManager.Subscribe("CompassData",this.onDataChanged);
      }
   }
}
