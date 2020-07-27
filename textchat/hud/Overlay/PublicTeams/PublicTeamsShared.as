 
package Overlay.PublicTeams
{
   public final class PublicTeamsShared
   {
      
      public static const EVENT_PUBLIC_TEAMS_DATA:String = // method body index: 202 method index: 202
      "PublicTeamsData";
      
      public static const EVENT_JOIN_PUBLIC_TEAM:String = // method body index: 202 method index: 202
      "SocialData::JoinPublicTeam";
      
      public static const EVENT_CREATE_PUBLIC_TEAM:String = // method body index: 202 method index: 202
      "SocialData::CreatePublicTeam";
      
      public static const EVENT_CHANGE_PUBLIC_TEAM_TYPE:String = // method body index: 202 method index: 202
      "SocialData::ChangePublicTeamType";
      
      public static const EVENT_CONVERT_TEAM_TO_PUBLIC:String = // method body index: 202 method index: 202
      "SocialData::ConvertTeamToPublic";
      
      public static const LINKAGE_PUBLIC_TEAMS_ENTRY:String = // method body index: 202 method index: 202
      "Overlay.PublicTeams.PublicTeamsEntry";
      
      public static const LINKAGE_PUBLIC_TEAMS_MODAL_ENTRY:String = // method body index: 202 method index: 202
      "Overlay.PublicTeams.PublicTeamsModalEntry";
      
      public static const LINKAGE_PUBLIC_TEAMS_BOND_ENTRY:String = // method body index: 202 method index: 202
      "Overlay.PublicTeams.PublicTeamsBondEntry";
      
      public static const TEAM_TYPE_NEW:uint = // method body index: 202 method index: 202
      99;
      
      public static const TEAM_TYPE_UNAVAILABLE:uint = // method body index: 202 method index: 202
      999;
      
      public static const TEAM_TYPE_PRIVATE:uint = // method body index: 202 method index: 202
      0;
      
      public static const TEAM_TYPE_HUNTERS:uint = // method body index: 202 method index: 202
      1;
      
      public static const TEAM_TYPE_ROLEPLAY:uint = // method body index: 202 method index: 202
      2;
      
      public static const TEAM_TYPE_EVENT:uint = // method body index: 202 method index: 202
      3;
      
      public static const TEAM_TYPE_EXPLORATION:uint = // method body index: 202 method index: 202
      4;
      
      public static const TEAM_TYPE_WORKSHOP:uint = // method body index: 202 method index: 202
      5;
      
      public static const TEAM_TYPE_CASUAL:uint = // method body index: 202 method index: 202
      6;
      
      public static const TEAM_TYPE_SPECIAL_EVENT:uint = // method body index: 202 method index: 202
      7;
      
      public static const TEAM_TYPE_EXTRATEAM:uint = // method body index: 202 method index: 202
      8;
      
      public static const TEAM_TYPE_TRADING:uint = // method body index: 202 method index: 202
      9;
      
      public static const TEAM_TYPE_WORKSHOP_RAID:uint = // method body index: 202 method index: 202
      10;
      
      public static const TEAM_TYPE_INVALID:uint = // method body index: 202 method index: 202
      11;
      
      public static const TEAM_STATUS_JOIN:uint = // method body index: 202 method index: 202
      0;
      
      public static const TEAM_STATUS_LEADER:uint = // method body index: 202 method index: 202
      1;
      
      public static const TEAM_STATUS_MEMBER:uint = // method body index: 202 method index: 202
      2;
      
      public static const TEAM_STATUS_FULL:uint = // method body index: 202 method index: 202
      3;
      
      public static const HIDE_BOND_METER:int = // method body index: 202 method index: 202
      -1;
       
      
      public function PublicTeamsShared()
      {
         // method body index: 205 method index: 205
         super();
      }
      
      public static function DecideTeamTypeString(param1:uint) : String
      {
         // method body index: 203 method index: 203
         switch(param1)
         {
            case TEAM_TYPE_NEW:
               return "CreateNew";
            case TEAM_TYPE_UNAVAILABLE:
               return "Unavailable";
            case TEAM_TYPE_EVENT:
               return "Event";
            case TEAM_TYPE_EXTRATEAM:
               return "ExtraTeam";
            case TEAM_TYPE_WORKSHOP:
               return "Workshop";
            case TEAM_TYPE_SPECIAL_EVENT:
               return "SpecialEvent";
            case TEAM_TYPE_ROLEPLAY:
               return "Roleplay";
            case TEAM_TYPE_TRADING:
               return "Trading";
            case TEAM_TYPE_CASUAL:
               return "Casual";
            case TEAM_TYPE_HUNTERS:
               return "Hunters";
            case TEAM_TYPE_EXPLORATION:
               return "Exploration";
            case TEAM_TYPE_WORKSHOP_RAID:
               return "WorkshopRaid";
            default:
               return "";
         }
      }
      
      public static function IsValidPublicTeamType(param1:uint) : Boolean
      {
         // method body index: 204 method index: 204
         var _loc2_:Boolean = false;
         if(param1 && param1 != TEAM_TYPE_PRIVATE && param1 != TEAM_TYPE_INVALID && param1 != TEAM_TYPE_UNAVAILABLE && param1 != TEAM_TYPE_NEW && DecideTeamTypeString(param1) != "")
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
   }
}
