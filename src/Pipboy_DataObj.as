 
package
{
   import flash.geom.Point;
   
   public class Pipboy_DataObj
   {
      
      public static const NUM_PAGES:uint = // method body index: 0 method index: 0
      4;
      
      public static const NUM_SPECIAL:uint = // method body index: 0 method index: 0
      7;
       
      
      private var _CurrentPage:uint;
      
      private var _StoredTabs:Vector.<uint>;
      
      private var _PlayerName:String;
      
      private var _ActiveEffects:Array;
      
      private var _IsInPowerArmor:Boolean;
      
      private var _StimpakCount:uint;
      
      private var _RadawayCount:uint;
      
      private var _CurrHP:Number;
      
      private var _MaxHP:Number;
      
      private var _CurrAP:Number;
      
      private var _MaxAP:Number;
      
      private var _CurrWeight:Number;
      
      private var _MaxWeight:Number;
      
      private var _AbsoluteWeightLimit:Number;
      
      private var _CurrentHPGain:Number;
      
      private var _SelectedItemHPGain:Number;
      
      private var _DamageTypes:Array;
      
      private var _ResistTypes:Array;
      
      private var _SlotResists:Array;
      
      private var _UnderwearType:uint;
      
      private var _Caps:uint;
      
      private var _DateMonth:uint;
      
      private var _DateDay:uint;
      
      private var _DateYear:uint;
      
      private var _TimeHour:Number;
      
      private var _CurrLocationName:String;
      
      private var _XPLevel:uint;
      
      private var _XPProgressPct:Number;
      
      private var _InvItems:Array;
      
      private var _InvComponents:Array;
      
      private var _InvFilter:int;
      
      private var _InvSelectedItems:Array;
      
      private var _HolotapePlaying:Boolean;
      
      private var _HolotapeHandle:uint;
      
      private var _SortMode:uint;
      
      private var _FavoritesList:Array;
      
      private var _HeadCondition:Number;
      
      private var _TorsoCondition:Number;
      
      private var _LArmCondition:Number;
      
      private var _RArmCondition:Number;
      
      private var _LLegCondition:Number;
      
      private var _RLegCondition:Number;
      
      public var ConditionBoyData:Object;
      
      private var _SPECIALList:Array;
      
      private var _PerksList:Array;
      
      private var _PerkPoints:uint;
      
      private var _NumCamps:uint;
      
      private var _FreeCampMoves:uint;
      
      private var _CanPlaceCamp:Boolean;
      
      private var _IsOnTeam:Boolean = false;
      
      private var _IsTeamLeader:Boolean = false;
      
      private var _QuestsList:Array;
      
      private var _GeneralStatsList:Array;
      
      private var _WorkshopsList:Array;
      
      private var _WorldMapMarkers:Array;
      
      private var _LocalMapMarkers:Array;
      
      private var _WorldMapTextureName:String;
      
      private var _WorldMapNWCorner:Point;
      
      private var _WorldMapNECorner:Point;
      
      private var _WorldMapSWCorner:Point;
      
      private var _LocalMapNWCorner:Point;
      
      private var _LocalMapNECorner:Point;
      
      private var _LocalMapSWCorner:Point;
      
      private var _RadioList:Array;
      
      private var _ReadOnlyMode:int;
      
      private var _RemovedMapMarkerIds:Array;
      
      private var _RemoveAllMapMarkers:Boolean;
      
      public function Pipboy_DataObj()
      {
         // method body index: 1 method index: 1
         this.ConditionBoyData = new Object();
         super();
         this._CurrentPage = 0;
         this._StoredTabs = new Vector.<uint>(NUM_PAGES,true);
         var _loc1_:int = 0;
         while(_loc1_ < this._StoredTabs.length)
         {
            this._StoredTabs[_loc1_] = 0;
            _loc1_++;
         }
         this._ActiveEffects = new Array();
         this._IsInPowerArmor = false;
         this._StimpakCount = 0;
         this._RadawayCount = 0;
         this._CurrHP = 0;
         this._MaxHP = 0;
         this._CurrAP = 0;
         this._MaxAP = 0;
         this._CurrWeight = 0;
         this._MaxWeight = 0;
         this._AbsoluteWeightLimit = 9999;
         this._CurrentHPGain = 0;
         this._SelectedItemHPGain = 0;
         this._DamageTypes = new Array();
         this._ResistTypes = new Array();
         this._SlotResists = new Array();
         this._UnderwearType = 0;
         this._Caps = 0;
         this._DateMonth = 0;
         this._DateDay = 0;
         this._DateYear = 0;
         this._TimeHour = 0;
         this._XPLevel = 1;
         this._XPProgressPct = 0;
         this._InvItems = new Array();
         this._InvComponents = new Array();
         this._InvFilter = 0;
         this._InvSelectedItems = new Array();
         this._HolotapePlaying = false;
         this._HolotapeHandle = uint.MAX_VALUE;
         this._SortMode = 0;
         this._FavoritesList = new Array();
         this._HeadCondition = 0;
         this._TorsoCondition = 0;
         this._LArmCondition = 0;
         this._RArmCondition = 0;
         this._LLegCondition = 0;
         this._RLegCondition = 0;
         this._SPECIALList = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < NUM_SPECIAL)
         {
            this._SPECIALList.push(new Object());
            _loc2_++;
         }
         this._PerksList = new Array();
         this._PerkPoints = 0;
         this._NumCamps = 0;
         this._FreeCampMoves = 0;
         this._CanPlaceCamp = false;
         this._QuestsList = new Array();
         this._GeneralStatsList = new Array();
         this._WorkshopsList = new Array();
         this._WorldMapMarkers = new Array();
         this._LocalMapMarkers = new Array();
         this._WorldMapNWCorner = new Point();
         this._WorldMapNECorner = new Point();
         this._WorldMapSWCorner = new Point();
         this._LocalMapNWCorner = new Point();
         this._LocalMapNECorner = new Point();
         this._LocalMapSWCorner = new Point();
         this._RadioList = new Array();
         this._ReadOnlyMode = 0;
         this._RemovedMapMarkerIds = new Array();
         this._RemoveAllMapMarkers = false;
      }
      
      public function get CurrentPage() : uint
      {
         // method body index: 2 method index: 2
         return this._CurrentPage;
      }
      
      public function get CurrentTab() : uint
      {
         // method body index: 3 method index: 3
         return this._StoredTabs[this._CurrentPage];
      }
      
      public function get PlayerName() : String
      {
         // method body index: 4 method index: 4
         return this._PlayerName;
      }
      
      public function get ActiveEffects() : Array
      {
         // method body index: 5 method index: 5
         return this._ActiveEffects;
      }
      
      public function get IsInPowerArmor() : Boolean
      {
         // method body index: 6 method index: 6
         return this._IsInPowerArmor;
      }
      
      public function get StimpakCount() : uint
      {
         // method body index: 7 method index: 7
         return this._StimpakCount;
      }
      
      public function get RadawayCount() : uint
      {
         // method body index: 8 method index: 8
         return this._RadawayCount;
      }
      
      public function get CurrHP() : Number
      {
         // method body index: 9 method index: 9
         return this._CurrHP;
      }
      
      public function get MaxHP() : Number
      {
         // method body index: 10 method index: 10
         return this._MaxHP;
      }
      
      public function get CurrAP() : Number
      {
         // method body index: 11 method index: 11
         return this._CurrAP;
      }
      
      public function get MaxAP() : Number
      {
         // method body index: 12 method index: 12
         return this._MaxAP;
      }
      
      public function get CurrWeight() : Number
      {
         // method body index: 13 method index: 13
         return this._CurrWeight;
      }
      
      public function get MaxWeight() : Number
      {
         // method body index: 14 method index: 14
         return this._MaxWeight;
      }
      
      public function get AbsoluteWeightLimit() : Number
      {
         // method body index: 15 method index: 15
         return this._AbsoluteWeightLimit;
      }
      
      public function get CurrentHPGain() : Number
      {
         // method body index: 16 method index: 16
         return this._CurrentHPGain;
      }
      
      public function get SelectedItemHPGain() : Number
      {
         // method body index: 17 method index: 17
         return this._SelectedItemHPGain;
      }
      
      public function get TotalDamages() : Array
      {
         // method body index: 18 method index: 18
         return this._DamageTypes;
      }
      
      public function get TotalResists() : Array
      {
         // method body index: 19 method index: 19
         return this._ResistTypes;
      }
      
      public function get SlotResists() : Array
      {
         // method body index: 20 method index: 20
         return this._SlotResists;
      }
      
      public function get UnderwearType() : uint
      {
         // method body index: 21 method index: 21
         return this._UnderwearType;
      }
      
      public function get Caps() : uint
      {
         // method body index: 22 method index: 22
         return this._Caps;
      }
      
      public function get DateMonth() : uint
      {
         // method body index: 23 method index: 23
         return this._DateMonth;
      }
      
      public function get DateDay() : uint
      {
         // method body index: 24 method index: 24
         return this._DateDay;
      }
      
      public function get DateYear() : uint
      {
         // method body index: 25 method index: 25
         return this._DateYear;
      }
      
      public function get TimeHour() : Number
      {
         // method body index: 26 method index: 26
         return this._TimeHour;
      }
      
      public function get CurrLocationName() : String
      {
         // method body index: 27 method index: 27
         return this._CurrLocationName;
      }
      
      public function get XPLevel() : uint
      {
         // method body index: 28 method index: 28
         return this._XPLevel;
      }
      
      public function get XPProgressPct() : Number
      {
         // method body index: 29 method index: 29
         return this._XPProgressPct;
      }
      
      public function get InvItems() : Array
      {
         // method body index: 30 method index: 30
         return this._InvItems;
      }
      
      public function get InvComponents() : Array
      {
         // method body index: 31 method index: 31
         return this._InvComponents;
      }
      
      public function get InvFilter() : int
      {
         // method body index: 32 method index: 32
         return this._InvFilter;
      }
      
      public function get InvSelectedItems() : Array
      {
         // method body index: 33 method index: 33
         return this._InvSelectedItems;
      }
      
      public function get HolotapePlaying() : Boolean
      {
         // method body index: 34 method index: 34
         return this._HolotapePlaying;
      }
      
      public function get HolotapeHandle() : uint
      {
         // method body index: 35 method index: 35
         return this._HolotapeHandle;
      }
      
      public function get isOnTeam() : Boolean
      {
         // method body index: 36 method index: 36
         return this._IsOnTeam;
      }
      
      public function get isTeamLeader() : Boolean
      {
         // method body index: 37 method index: 37
         return this._IsTeamLeader;
      }
      
      public function get SortMode() : uint
      {
         // method body index: 38 method index: 38
         return this._SortMode;
      }
      
      public function get FavoritesList() : Array
      {
         // method body index: 39 method index: 39
         return this._FavoritesList;
      }
      
      public function get HeadCondition() : Number
      {
         // method body index: 40 method index: 40
         return this._HeadCondition;
      }
      
      public function get TorsoCondition() : Number
      {
         // method body index: 41 method index: 41
         return this._TorsoCondition;
      }
      
      public function get LArmCondition() : Number
      {
         // method body index: 42 method index: 42
         return this._LArmCondition;
      }
      
      public function get RArmCondition() : Number
      {
         // method body index: 43 method index: 43
         return this._RArmCondition;
      }
      
      public function get LLegCondition() : Number
      {
         // method body index: 44 method index: 44
         return this._LLegCondition;
      }
      
      public function get RLegCondition() : Number
      {
         // method body index: 45 method index: 45
         return this._RLegCondition;
      }
      
      public function get SPECIALList() : Array
      {
         // method body index: 46 method index: 46
         return this._SPECIALList;
      }
      
      public function get PerksList() : Array
      {
         // method body index: 47 method index: 47
         return this._PerksList;
      }
      
      public function get PerkPoints() : uint
      {
         // method body index: 48 method index: 48
         return this._PerkPoints;
      }
      
      public function get NumCamps() : uint
      {
         // method body index: 49 method index: 49
         return this._NumCamps;
      }
      
      public function get FreeCampMoves() : uint
      {
         // method body index: 50 method index: 50
         return this._FreeCampMoves;
      }
      
      public function get CanPlaceCamp() : Boolean
      {
         // method body index: 51 method index: 51
         return this._CanPlaceCamp;
      }
      
      public function get QuestsList() : Array
      {
         // method body index: 52 method index: 52
         return this._QuestsList;
      }
      
      public function get GeneralStatsList() : Array
      {
         // method body index: 53 method index: 53
         return this._GeneralStatsList;
      }
      
      public function get WorkshopsList() : Array
      {
         // method body index: 54 method index: 54
         return this._WorkshopsList;
      }
      
      public function get WorldMapMarkers() : Array
      {
         // method body index: 55 method index: 55
         return this._WorldMapMarkers;
      }
      
      public function get LocalMapMarkers() : Array
      {
         // method body index: 56 method index: 56
         return this._LocalMapMarkers;
      }
      
      public function get WorldMapTextureName() : String
      {
         // method body index: 57 method index: 57
         return this._WorldMapTextureName;
      }
      
      public function get WorldMapNWCorner() : Point
      {
         // method body index: 58 method index: 58
         return this._WorldMapNWCorner;
      }
      
      public function get WorldMapNECorner() : Point
      {
         // method body index: 59 method index: 59
         return this._WorldMapNECorner;
      }
      
      public function get WorldMapSWCorner() : Point
      {
         // method body index: 60 method index: 60
         return this._WorldMapSWCorner;
      }
      
      public function get LocalMapNWCorner() : Point
      {
         // method body index: 61 method index: 61
         return this._LocalMapNWCorner;
      }
      
      public function get LocalMapNECorner() : Point
      {
         // method body index: 62 method index: 62
         return this._LocalMapNECorner;
      }
      
      public function get LocalMapSWCorner() : Point
      {
         // method body index: 63 method index: 63
         return this._LocalMapSWCorner;
      }
      
      public function get RadioList() : Array
      {
         // method body index: 64 method index: 64
         return this._RadioList;
      }
      
      public function get ReadOnlyMode() : int
      {
         // method body index: 65 method index: 65
         return this._ReadOnlyMode;
      }
      
      public function get RemovedMapMarkerIds() : Array
      {
         // method body index: 66 method index: 66
         return this._RemovedMapMarkerIds;
      }
      
      public function get RemoveAllMapMarkers() : Boolean
      {
         // method body index: 67 method index: 67
         return this._RemoveAllMapMarkers;
      }
      
      public function set CurrentPage(param1:uint) : *
      {
         // method body index: 68 method index: 68
         if(param1 < NUM_PAGES && param1 != this._CurrentPage)
         {
            this._CurrentPage = param1;
         }
      }
      
      public function set CurrentTab(param1:uint) : *
      {
         // method body index: 69 method index: 69
         if(param1 != this._StoredTabs[this._CurrentPage])
         {
            this._StoredTabs[this._CurrentPage] = param1;
         }
      }
      
      public function set PlayerName(param1:String) : *
      {
         // method body index: 70 method index: 70
         this._PlayerName = param1;
      }
      
      public function set IsInPowerArmor(param1:Boolean) : *
      {
         // method body index: 71 method index: 71
         this._IsInPowerArmor = param1;
      }
      
      public function set StimpakCount(param1:uint) : *
      {
         // method body index: 72 method index: 72
         this._StimpakCount = param1;
      }
      
      public function set RadawayCount(param1:uint) : *
      {
         // method body index: 73 method index: 73
         this._RadawayCount = param1;
      }
      
      public function set CurrHP(param1:Number) : *
      {
         // method body index: 74 method index: 74
         this._CurrHP = param1;
      }
      
      public function set MaxHP(param1:Number) : *
      {
         // method body index: 75 method index: 75
         this._MaxHP = param1;
      }
      
      public function set CurrAP(param1:Number) : *
      {
         // method body index: 76 method index: 76
         this._CurrAP = param1;
      }
      
      public function set MaxAP(param1:Number) : *
      {
         // method body index: 77 method index: 77
         this._MaxAP = param1;
      }
      
      public function set CurrWeight(param1:Number) : *
      {
         // method body index: 78 method index: 78
         this._CurrWeight = param1;
      }
      
      public function set MaxWeight(param1:Number) : *
      {
         // method body index: 79 method index: 79
         this._MaxWeight = param1;
      }
      
      public function set AbsoluteWeightLimit(param1:Number) : *
      {
         // method body index: 80 method index: 80
         this._AbsoluteWeightLimit = param1;
      }
      
      public function set CurrentHPGain(param1:Number) : *
      {
         // method body index: 81 method index: 81
         this._CurrentHPGain = param1;
      }
      
      public function set SelectedItemHPGain(param1:Number) : *
      {
         // method body index: 82 method index: 82
         this._SelectedItemHPGain = param1;
      }
      
      public function set DateMonth(param1:uint) : *
      {
         // method body index: 83 method index: 83
         this._DateMonth = param1;
      }
      
      public function set DateDay(param1:uint) : *
      {
         // method body index: 84 method index: 84
         this._DateDay = param1;
      }
      
      public function set DateYear(param1:uint) : *
      {
         // method body index: 85 method index: 85
         this._DateYear = param1;
      }
      
      public function set TimeHour(param1:Number) : *
      {
         // method body index: 86 method index: 86
         this._TimeHour = param1;
      }
      
      public function set CurrLocationName(param1:String) : *
      {
         // method body index: 87 method index: 87
         this._CurrLocationName = param1;
      }
      
      public function set UnderwearType(param1:uint) : *
      {
         // method body index: 88 method index: 88
         this._UnderwearType = param1;
      }
      
      public function set Caps(param1:uint) : *
      {
         // method body index: 89 method index: 89
         this._Caps = param1;
      }
      
      public function set XPLevel(param1:uint) : *
      {
         // method body index: 90 method index: 90
         this._XPLevel = param1;
      }
      
      public function set XPProgressPct(param1:Number) : *
      {
         // method body index: 91 method index: 91
         this._XPProgressPct = param1;
      }
      
      public function set InvItems(param1:Array) : *
      {
         // method body index: 92 method index: 92
         this._InvItems = param1;
      }
      
      public function set InvFilter(param1:int) : *
      {
         // method body index: 93 method index: 93
         this._InvFilter = param1;
      }
      
      public function set HolotapePlaying(param1:Boolean) : *
      {
         // method body index: 94 method index: 94
         this._HolotapePlaying = param1;
      }
      
      public function set HolotapeHandle(param1:uint) : *
      {
         // method body index: 95 method index: 95
         this._HolotapeHandle = param1;
      }
      
      public function set isOnTeam(param1:Boolean) : *
      {
         // method body index: 96 method index: 96
         this._IsOnTeam = param1;
      }
      
      public function set isTeamLeader(param1:Boolean) : *
      {
         // method body index: 97 method index: 97
         this._IsTeamLeader = param1;
      }
      
      public function set SortMode(param1:uint) : *
      {
         // method body index: 98 method index: 98
         this._SortMode = param1;
      }
      
      public function set HeadCondition(param1:Number) : *
      {
         // method body index: 99 method index: 99
         this._HeadCondition = param1;
      }
      
      public function set TorsoCondition(param1:Number) : *
      {
         // method body index: 100 method index: 100
         this._TorsoCondition = param1;
      }
      
      public function set LArmCondition(param1:Number) : *
      {
         // method body index: 101 method index: 101
         this._LArmCondition = param1;
      }
      
      public function set RArmCondition(param1:Number) : *
      {
         // method body index: 102 method index: 102
         this._RArmCondition = param1;
      }
      
      public function set LLegCondition(param1:Number) : *
      {
         // method body index: 103 method index: 103
         this._LLegCondition = param1;
      }
      
      public function set RLegCondition(param1:Number) : *
      {
         // method body index: 104 method index: 104
         this._RLegCondition = param1;
      }
      
      public function set PerkPoints(param1:uint) : *
      {
         // method body index: 105 method index: 105
         this._PerkPoints = param1;
      }
      
      public function set NumCamps(param1:uint) : *
      {
         // method body index: 106 method index: 106
         this._NumCamps = param1;
      }
      
      public function set FreeCampMoves(param1:uint) : *
      {
         // method body index: 107 method index: 107
         this._FreeCampMoves = param1;
      }
      
      public function set CanPlaceCamp(param1:Boolean) : *
      {
         // method body index: 108 method index: 108
         this._CanPlaceCamp = param1;
      }
      
      public function set WorldMapTextureName(param1:String) : *
      {
         // method body index: 109 method index: 109
         this._WorldMapTextureName = param1;
      }
      
      public function set ReadOnlyMode(param1:int) : *
      {
         // method body index: 110 method index: 110
         this._ReadOnlyMode = param1;
      }
      
      public function set RemoveAllMapMarkers(param1:Boolean) : *
      {
         // method body index: 111 method index: 111
         this._RemoveAllMapMarkers = param1;
      }
   }
}
