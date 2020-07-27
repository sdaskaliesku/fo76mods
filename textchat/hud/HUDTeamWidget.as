 
package
{
   import Overlay.PublicTeams.PublicTeamsBondMeter;
   import Overlay.PublicTeams.PublicTeamsIcon;
   import Overlay.PublicTeams.PublicTeamsShared;
   import Shared.AS3.BSScrollingListEntry;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.StyleSheet;
   import Shared.AS3.Styles.HUDPartyListStyle;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public dynamic class HUDTeamWidget extends BSUIComponent
   {
      
      public static const PUBLIC_TEAMS_HEADER_OFFSET:Number = // method body index: 2918 method index: 2918
      20;
      
      public static const PUBLIC_TEAMS_ICON_OFFSET:Number = // method body index: 2918 method index: 2918
      3;
      
      public static const AREA_VOICE_LIST_OFFSET:Number = // method body index: 2918 method index: 2918
      20;
      
      public static const TEAM_MAX_PLAYERS:uint = // method body index: 2918 method index: 2918
      4;
      
      public static var partyMembers:Array;
       
      
      public var PartyList:MenuListComponent;
      
      public var AreaVoiceList_mc:AreaVoiceList;
      
      public var PTPartyListHeader_mc:MovieClip;
      
      public var PTPartyHeaderTeamType_mc:MovieClip;
      
      public var PTPartyHeaderBonus_mc:MovieClip;
      
      public var PTHUDIcon_mc:PublicTeamsIcon;
      
      public var BonusMultiplier_tf:TextField;
      
      public var Bonus_tf:TextField;
      
      public var TeamType_tf:TextField;
      
      private var m_AreaVoiceListBaseY:Number;
      
      private var partyListData:Array;
      
      private var partyListMenuData:Array;
      
      private var m_HudMode:String = "All";
      
      private var m_TeamType = 0;
      
      public function HUDTeamWidget()
      {

         this.partyListData = new Array();
         this.partyListMenuData = new Array();
         super();
         StyleSheet.apply(this.PartyList,false,HUDPartyListStyle);
         this.m_AreaVoiceListBaseY = this.AreaVoiceList_mc.y;
         this.PTPartyListHeader_mc.visible = false;
         this.PTPartyHeaderTeamType_mc = this.PTPartyListHeader_mc.PTPartyHeaderTeamType_mc;
         this.PTPartyHeaderBonus_mc = this.PTPartyListHeader_mc.PTPartyHeaderBonus_mc;
         this.PTHUDIcon_mc = this.PTPartyListHeader_mc.PTHUDIcon_mc;
         this.BonusMultiplier_tf = this.PTPartyHeaderBonus_mc.BonusMultiplier_tf;
         this.Bonus_tf = this.PTPartyHeaderBonus_mc.Bonus_tf;
         this.TeamType_tf = this.PTPartyHeaderTeamType_mc.TeamType_tf;
         TextFieldEx.setTextAutoSize(this.TeamType_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.BonusMultiplier_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Bonus_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      override public function onAddedToStage() : void
      {

         BSUIDataManager.Subscribe("PartyMenuList",function(param1:FromClientDataEvent):// method body index: 2920 method index: 2920
         *
         {

            m_TeamType = param1.data.teamType;
            partyListData = param1.data.members;
            partyMembers = param1.data.members;
            var _loc2_:uint = partyListData.length;
            partyListMenuData.splice(0);
            var _loc3_:uint = 0;
            while(_loc3_ < TEAM_MAX_PLAYERS && _loc3_ < _loc2_)
            {
               if(partyListData[_loc3_] != null && partyListData[_loc3_].isVisible && partyListData[_loc3_].avatarId != "IconAddFriend" && partyListData[_loc3_].isOnServer)
               {
                  partyListMenuData.push(partyListData[_loc3_]);
               }
               _loc3_++;
            }
            PartyList.List_mc.MenuListData = partyListMenuData;
            PartyList.addEventListener(PublicTeamsBondMeter.EVENT_BOND_METER_COMPLETE,onBondComplete);
            PartyList.SetIsDirty();
            PublicTeamsBondMeter.LAST_BOND_UPDATE_TIME = new Date().getTime() / 1000;
            SetIsDirty();
         });
         BSUIDataManager.Subscribe("HUDModeData",function(param1:FromClientDataEvent):// method body index: 2921 method index: 2921
         *
         {

            m_HudMode = param1.data.hudMode;
            SetIsDirty();
         });
      }
      
      override public function redrawUIComponent() : void
      {

         var _loc1_:BSScrollingListEntry = null;
         var _loc2_:* = undefined;
         this.PartyList.visible = this.partyListMenuData.length > 0 && this.m_HudMode != HUDModes.INSPECT_MODE && this.m_HudMode != HUDModes.CONTAINER_MODE && this.m_HudMode != HUDModes.PERKS_MODE && this.m_HudMode != HUDModes.LEGENDARY_PERKS_MODE;
         var _loc3_:Boolean = this.m_HudMode == HUDModes.CONTAINER_MODE || this.m_HudMode == HUDModes.WORKSHOP_MODE || this.m_HudMode == HUDModes.PIPBOY || this.m_HudMode == HUDModes.TERMINAL_MODE;
         this.PartyList.alpha = !!_loc3_?Number(Number(0.5)):Number(Number(1));
         this.PTPartyListHeader_mc.alpha = !!_loc3_?Number(Number(0.5)):Number(Number(1));
         var _loc4_:uint = this.partyListMenuData.length;
         this.UpdatePublicTeamsHeader();
         if(_loc4_ > 0)
         {
            _loc1_ = this.PartyList.List_mc.GetClipByIndex(0);
            _loc2_ = !!_loc1_.Sizer_mc?_loc1_.Sizer_mc.height:_loc1_.height;
            this.AreaVoiceList_mc.y = this.m_AreaVoiceListBaseY - this.PTPartyListHeader_mc.height - _loc2_ * _loc4_ - AREA_VOICE_LIST_OFFSET;
         }
         else
         {
            this.AreaVoiceList_mc.y = this.m_AreaVoiceListBaseY;
         }
      }
      
      private function UpdatePublicTeamsHeader() : void
      {

         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:PartyListEntry = null;
         if(PublicTeamsShared.IsValidPublicTeamType(this.m_TeamType) && this.PartyList.visible)
         {
            _loc1_ = this.m_TeamType;
            _loc2_ = PublicTeamsShared.DecideTeamTypeString(_loc1_);
            this.TeamType_tf.text = GlobalFunc.LocalizeFormattedString("{1} {2}","$PT" + _loc2_,"$TEAM");
            this.PTHUDIcon_mc.setIconType(_loc1_);
            this.PTHUDIcon_mc.x = this.PTPartyHeaderTeamType_mc.x + this.TeamType_tf.textWidth + PUBLIC_TEAMS_ICON_OFFSET;
            _loc3_ = 0;
            _loc4_ = this.PartyList.List_mc.entryList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = this.PartyList.List_mc.GetClipByIndex(_loc5_) as PartyListEntry;
               if(_loc6_.BondMeter_mc.isBonded)
               {
                  _loc3_++;
               }
               _loc5_++;
            }
            this.PTPartyHeaderBonus_mc.visible = true;
            this.BonusMultiplier_tf.text = "X" + (_loc3_ + 1).toString();
            if(_loc4_ > 0)
            {
               this.PTPartyListHeader_mc.y = this.PartyList.List_mc.GetClipByIndex(_loc4_ - 1).y - this.PTPartyListHeader_mc.height - PUBLIC_TEAMS_HEADER_OFFSET;
               this.PTPartyListHeader_mc.visible = true;
            }
         }
         else
         {
            this.PTPartyListHeader_mc.visible = false;
         }
      }
      
      private function onBondComplete(param1:Event) : void
      {

         this.UpdatePublicTeamsHeader();
      }
   }
}
