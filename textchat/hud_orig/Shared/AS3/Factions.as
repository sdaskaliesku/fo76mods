 
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
      
      public static function updateFaceIcon(aClip:MovieClip, aFactionInfo:Object) : void
      {
         // method body index: 193 method index: 193
         aClip.gotoAndStop(aFactionInfo.code);
         aClip.Face_mc.gotoAndStop(getReputationFaceFromFromTier(aFactionInfo.tier));
         aClip.Backer_mc.gotoAndStop(getReputationBackerFrameFromTier(aFactionInfo.tier));
      }
      
      public static function getFactionByID(aFactionID:uint, aFactionInfoArray:Array) : Object
      {
         // method body index: 194 method index: 194
         for(var i:uint = 0; i < aFactionInfoArray.length; )
         {
            if(aFactionInfoArray[i].factionID == aFactionID)
            {
               return aFactionInfoArray[i];
            }
            i++;
         }
         return null;
      }
      
      public static function buildFactionInfo(aReputationData:Object) : Array
      {
         // method body index: 195 method index: 195
         var curFaction:Object = null;
         var curName:String = null;
         var curRep:int = 0;
         var curTier:uint = 0;
         var factionInfo:Array = new Array();
         var factionNames:Array = ["Crater","Foundation"];
         for(var factionIndex:uint = 0; factionIndex < factionNames.length; factionIndex++)
         {
            curName = factionNames[factionIndex];
            curFaction = aReputationData["factionData" + curName];
            curRep = aReputationData["playerRep" + curName];
            curTier = getReputationTier(curRep,curFaction.reputationTiers);
            factionInfo[factionIndex] = {
               "name":curFaction.szFactionName,
               "code":factionNames[factionIndex].toLowerCase(),
               "tier":curTier,
               "factionID":curFaction.uFactionID,
               "tierPercent":getNextReputationTierPercent(curRep,curTier,curFaction.reputationTiers)
            };
         }
         return factionInfo;
      }
      
      public static function getNextReputationTierPercent(aReputation:int, aCurrentTier:uint, aTierInfo:Array) : Number
      {
         // method body index: 196 method index: 196
         if(aCurrentTier + 1 >= aTierInfo.length)
         {
            return 1;
         }
         var tierInfoCur:Object = aTierInfo[aCurrentTier];
         var tierInfoNext:Object = aTierInfo[aCurrentTier + 1];
         var tierPercent:Number = (aReputation - tierInfoCur.fValue) / (tierInfoNext.fValue - tierInfoCur.fValue);
         return GlobalFunc.Clamp(tierPercent,0,1);
      }
      
      public static function getReputationTier(aReputation:int, aTierInfo:Array) : uint
      {
         // method body index: 197 method index: 197
         for(var i:uint = aTierInfo.length - 1; i > 0; i--)
         {
            if(aReputation >= aTierInfo[i].fValue)
            {
               break;
            }
         }
         return i;
      }
      
      public static function getReputationBackerFrameFromTier(aTier:uint) : String
      {
         // method body index: 198 method index: 198
         var useFrame:String = "";
         switch(aTier)
         {
            case THRESHOLD_TIER_HOSTILE:
               useFrame = "hostile";
               break;
            case THRESHOLD_TIER_ALLY:
               useFrame = "ally";
               break;
            default:
               useFrame = "neutral";
         }
         return useFrame;
      }
      
      public static function getReputationFaceFromFromTier(aTier:uint) : String
      {
         // method body index: 199 method index: 199
         var useFrame:String = "";
         switch(aTier)
         {
            case THRESHOLD_TIER_HOSTILE:
               useFrame = "hostile";
               break;
            case THRESHOLD_TIER_CAUTIOUS:
               useFrame = "cautious";
               break;
            case THRESHOLD_TIER_NEUTRAL:
               useFrame = "neutral";
               break;
            case THRESHOLD_TIER_COOPERATIVE:
               useFrame = "cooperative";
               break;
            case THRESHOLD_TIER_FRIENDLY:
               useFrame = "friendly";
               break;
            case THRESHOLD_TIER_NEIGHBORLY:
               useFrame = "neighborly";
               break;
            case THRESHOLD_TIER_ALLY:
               useFrame = "ally";
         }
         return useFrame;
      }
   }
}
