 
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
      
      public static const PUBLIC_TEAMS_HEADER_OFFSET:Number = // method body index: 2967 method index: 2967
      20;
      
      public static const PUBLIC_TEAMS_ICON_OFFSET:Number = // method body index: 2967 method index: 2967
      3;
      
      public static const AREA_VOICE_LIST_OFFSET:Number = // method body index: 2967 method index: 2967
      20;
      
      public static const TEAM_MAX_PLAYERS:uint = // method body index: 2967 method index: 2967
      4;
       
      
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
         // method body index: 2968 method index: 2968
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
         // method body index: 2971 method index: 2971
         BSUIDataManager.Subscribe("PartyMenuList",function(arEvent:FromClientDataEvent):// method body index: 2969 method index: 2969
         *
         {
            // method body index: 2969 method index: 2969
            m_TeamType = arEvent.data.teamType;
            partyListData = arEvent.data.members;
            var len:uint = partyListData.length;
            partyListMenuData.splice(0);
            var i:uint = 0;
            while(i < TEAM_MAX_PLAYERS && i < len)
            {
               if(partyListData[i] != null && partyListData[i].isVisible && partyListData[i].avatarId != "IconAddFriend" && partyListData[i].isOnServer)
               {
                  partyListMenuData.push(partyListData[i]);
               }
               i++;
            }
            PartyList.List_mc.MenuListData = partyListMenuData;
            PartyList.addEventListener(PublicTeamsBondMeter.EVENT_BOND_METER_COMPLETE,onBondComplete);
            PartyList.SetIsDirty();
            PublicTeamsBondMeter.LAST_BOND_UPDATE_TIME = new Date().getTime() / 1000;
            SetIsDirty();
         });
         BSUIDataManager.Subscribe("HUDModeData",function(arEvent:FromClientDataEvent):// method body index: 2970 method index: 2970
         *
         {
            // method body index: 2970 method index: 2970
            m_HudMode = arEvent.data.hudMode;
            SetIsDirty();
         });
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 2972 method index: 2972
         var partyListClip:BSScrollingListEntry = null;
         var clipHeight:* = undefined;
         this.PartyList.visible = this.partyListMenuData.length > 0 && this.m_HudMode != HUDModes.INSPECT_MODE && this.m_HudMode != HUDModes.CONTAINER_MODE && this.m_HudMode != HUDModes.PERKS_MODE && this.m_HudMode != HUDModes.LEGENDARY_PERKS_MODE;
         var fadeOut:Boolean = this.m_HudMode == HUDModes.CONTAINER_MODE || this.m_HudMode == HUDModes.WORKSHOP_MODE || this.m_HudMode == HUDModes.PIPBOY || this.m_HudMode == HUDModes.TERMINAL_MODE;
         this.PartyList.alpha = !!fadeOut?Number(0.5):Number(1);
         this.PTPartyListHeader_mc.alpha = !!fadeOut?Number(0.5):Number(1);
         var partyListLen:uint = this.partyListMenuData.length;
         this.UpdatePublicTeamsHeader();
         if(partyListLen > 0)
         {
            partyListClip = this.PartyList.List_mc.GetClipByIndex(0);
            clipHeight = !!partyListClip.Sizer_mc?partyListClip.Sizer_mc.height:partyListClip.height;
            this.AreaVoiceList_mc.y = this.m_AreaVoiceListBaseY - this.PTPartyListHeader_mc.height - clipHeight * partyListLen - AREA_VOICE_LIST_OFFSET;
         }
         else
         {
            this.AreaVoiceList_mc.y = this.m_AreaVoiceListBaseY;
         }
      }
      
      private function UpdatePublicTeamsHeader() : void
      {
         // method body index: 2973 method index: 2973
         var teamType:uint = 0;
         var typeString:String = null;
         var numOfBonds:int = 0;
         var numOfEntries:int = 0;
         var i:int = 0;
         var entry:PartyListEntry = null;
         if(PublicTeamsShared.IsValidPublicTeamType(this.m_TeamType) && this.PartyList.visible)
         {
            teamType = this.m_TeamType;
            typeString = PublicTeamsShared.DecideTeamTypeString(teamType);
            this.TeamType_tf.text = GlobalFunc.LocalizeFormattedString("{1} {2}","$PT" + typeString,"$TEAM");
            this.PTHUDIcon_mc.setIconType(teamType);
            this.PTHUDIcon_mc.x = this.PTPartyHeaderTeamType_mc.x + this.TeamType_tf.textWidth + PUBLIC_TEAMS_ICON_OFFSET;
            numOfBonds = 0;
            numOfEntries = this.PartyList.List_mc.entryList.length;
            for(i = 0; i < numOfEntries; i++)
            {
               entry = this.PartyList.List_mc.GetClipByIndex(i) as PartyListEntry;
               if(entry.BondMeter_mc.isBonded)
               {
                  numOfBonds++;
               }
            }
            this.PTPartyHeaderBonus_mc.visible = true;
            this.BonusMultiplier_tf.text = "X" + (numOfBonds + 1).toString();
            if(numOfEntries > 0)
            {
               this.PTPartyListHeader_mc.y = this.PartyList.List_mc.GetClipByIndex(numOfEntries - 1).y - this.PTPartyListHeader_mc.height - PUBLIC_TEAMS_HEADER_OFFSET;
               this.PTPartyListHeader_mc.visible = true;
            }
         }
         else
         {
            this.PTPartyListHeader_mc.visible = false;
         }
      }
      
      private function onBondComplete(aEvent:Event) : void
      {
         // method body index: 2974 method index: 2974
         this.UpdatePublicTeamsHeader();
      }
   }
}
