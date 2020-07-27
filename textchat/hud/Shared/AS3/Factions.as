 
package Shared.AS3
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   
   public class Factions
   {
      
      public static const THRESHOLD_TIER_HOSTILE:uint = // method body index: 192 method index: 192
      0;
      
      public static const THRESHOLD_TIER_CAUTIOUS:uint = // method body index: 192 method index: 192
      1;
      
      public static const THRESHOLD_TIER_NEUTRAL:uint = // method body index: 192 method index: 192
      2;
      
      public static const THRESHOLD_TIER_COOPERATIVE:uint = // method body index: 192 method index: 192
      3;
      
      public static const THRESHOLD_TIER_FRIENDLY:uint = // method body index: 192 method index: 192
      4;
      
      public static const THRESHOLD_TIER_NEIGHBORLY:uint = // method body index: 192 method index: 192
      5;
      
      public static const THRESHOLD_TIER_ALLY:uint = // method body index: 192 method index: 192
      6;
       
      
      public function Factions()
      {
         // method body index: 200 method index: 200
         super();
      }
      
      public static function updateFaceIcon(param1:MovieClip, param2:Object) : void
      {
         // method body index: 193 method index: 193
         param1.gotoAndStop(param2.code);
         param1.Face_mc.gotoAndStop(getReputationFaceFromFromTier(param2.tier));
         param1.Backer_mc.gotoAndStop(getReputationBackerFrameFromTier(param2.tier));
      }
      
      public static function getFactionByID(param1:uint, param2:Array) : Object
      {
         // method body index: 194 method index: 194
         var _loc3_:uint = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_].factionID == param1)
            {
               return param2[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function buildFactionInfo(param1:Object) : Array
      {
         // method body index: 195 method index: 195
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:Array = new Array();
         var _loc7_:Array = ["Crater","Foundation"];
         var _loc8_:uint = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc3_ = _loc7_[_loc8_];
            _loc2_ = param1["factionData" + _loc3_];
            _loc4_ = param1["playerRep" + _loc3_];
            _loc5_ = getReputationTier(_loc4_,_loc2_.reputationTiers);
            _loc6_[_loc8_] = {
               "name":_loc2_.szFactionName,
               "code":_loc7_[_loc8_].toLowerCase(),
               "tier":_loc5_,
               "factionID":_loc2_.uFactionID,
               "tierPercent":getNextReputationTierPercent(_loc4_,_loc5_,_loc2_.reputationTiers)
            };
            _loc8_++;
         }
         return _loc6_;
      }
      
      public static function getNextReputationTierPercent(param1:int, param2:uint, param3:Array) : Number
      {
         // method body index: 196 method index: 196
         if(param2 + 1 >= param3.length)
         {
            return 1;
         }
         var _loc4_:Object = param3[param2];
         var _loc5_:Object = param3[param2 + 1];
         var _loc6_:Number = (param1 - _loc4_.fValue) / (_loc5_.fValue - _loc4_.fValue);
         return GlobalFunc.Clamp(_loc6_,0,1);
      }
      
      public static function getReputationTier(param1:int, param2:Array) : uint
      {
         // method body index: 197 method index: 197
         var _loc3_:uint = param2.length - 1;
         while(_loc3_ > 0)
         {
            if(param1 >= param2[_loc3_].fValue)
            {
               break;
            }
            _loc3_--;
         }
         return _loc3_;
      }
      
      public static function getReputationBackerFrameFromTier(param1:uint) : String
      {
         // method body index: 198 method index: 198
         var _loc2_:String = "";
         switch(param1)
         {
            case THRESHOLD_TIER_HOSTILE:
               _loc2_ = "hostile";
               break;
            case THRESHOLD_TIER_ALLY:
               _loc2_ = "ally";
               break;
            default:
               _loc2_ = "neutral";
         }
         return _loc2_;
      }
      
      public static function getReputationFaceFromFromTier(param1:uint) : String
      {
         // method body index: 199 method index: 199
         var _loc2_:String = "";
         switch(param1)
         {
            case THRESHOLD_TIER_HOSTILE:
               _loc2_ = "hostile";
               break;
            case THRESHOLD_TIER_CAUTIOUS:
               _loc2_ = "cautious";
               break;
            case THRESHOLD_TIER_NEUTRAL:
               _loc2_ = "neutral";
               break;
            case THRESHOLD_TIER_COOPERATIVE:
               _loc2_ = "cooperative";
               break;
            case THRESHOLD_TIER_FRIENDLY:
               _loc2_ = "friendly";
               break;
            case THRESHOLD_TIER_NEIGHBORLY:
               _loc2_ = "neighborly";
               break;
            case THRESHOLD_TIER_ALLY:
               _loc2_ = "ally";
         }
         return _loc2_;
      }
   }
}
