 
package
{
   import Shared.AS3.ListFilterer;
   import flash.utils.Dictionary;
   
   public class ListFiltererEx extends ListFilterer
   {
      
      private static var FILTER_COUNT:uint = // method body index: 191 method index: 191
      0;
      
      public static const FILTER_WEAP_START:uint = // method body index: 191 method index: 191
      FILTER_COUNT;
      
      public static const FILTER_WEAP_RANGED:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_WEAP_MELEE:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_WEAP_THROWN:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_WEAP_END:uint = // method body index: 191 method index: 191
      FILTER_COUNT - 1;
      
      public static const FILTER_APPAREL_START:uint = // method body index: 191 method index: 191
      FILTER_COUNT;
      
      public static const FILTER_APPAREL_OUTFIT:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_APPAREL_ARMOR:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_APPAREL_ARMOR_CHEST:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_APPAREL_ARMOR_ARM_L:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_APPAREL_ARMOR_ARM_R:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_APPAREL_ARMOR_LEG_L:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_APPAREL_ARMOR_LEG_R:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_APPAREL_END:uint = // method body index: 191 method index: 191
      FILTER_COUNT - 1;
      
      public static const FILTER_AID_START:uint = // method body index: 191 method index: 191
      FILTER_COUNT;
      
      public static const FILTER_AID_FOOD:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_AID_WATER:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_AID_FOOD_COOKED:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_AID_WATER_COOKED:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_AID_CHEM:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_AID_END:uint = // method body index: 191 method index: 191
      FILTER_COUNT - 1;
      
      public static const FILTER_MISC_START:uint = // method body index: 191 method index: 191
      FILTER_COUNT;
      
      public static const FILTER_MISC_NON_KEYS:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_MISC_KEYS:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_MISC_END:uint = // method body index: 191 method index: 191
      FILTER_COUNT - 1;
      
      public static const FILTER_NOTES_START:uint = // method body index: 191 method index: 191
      FILTER_COUNT;
      
      public static const FILTER_NOTES_UNREAD:uint = // method body index: 191 method index: 191
      FILTER_COUNT++;
      
      public static const FILTER_NOTES_END:uint = // method body index: 191 method index: 191
      FILTER_COUNT - 1;
       
      
      public var infoMap:Dictionary;
      
      public var paperDollMap:Dictionary;
      
      public var extraFilterType:int = -1;
      
      public var ITEM_FILTER_MISC:uint;
      
      public function ListFiltererEx(param1:Dictionary, param2:Dictionary)
      {
         // method body index: 194 method index: 194
         this.ITEM_FILTER_MISC = 1 << 9;
         super();
         this.infoMap = param1;
         this.paperDollMap = param2;
      }
      
      public static function GetFilterIndexBoundaries(param1:int) : Array
      {
         // method body index: 192 method index: 192
         switch(param1)
         {
            case 0:
               return [FILTER_WEAP_START,FILTER_WEAP_END];
            case 1:
               return [FILTER_APPAREL_START,FILTER_APPAREL_END];
            case 2:
               return [FILTER_AID_START,FILTER_AID_END];
            case 3:
               return [FILTER_MISC_START,FILTER_MISC_END];
            case 5:
               return [FILTER_NOTES_START,FILTER_NOTES_END];
            default:
               return [-1,-1];
         }
      }
      
      public static function GetFilterText(param1:int) : String
      {
         // method body index: 193 method index: 193
         switch(param1)
         {
            case FILTER_WEAP_RANGED:
               return "RANGED";
            case FILTER_WEAP_MELEE:
               return "MELEE";
            case FILTER_WEAP_THROWN:
               return "THROWN";
            case FILTER_APPAREL_OUTFIT:
               return "OUTFITS";
            case FILTER_APPAREL_ARMOR:
               return "ARMOR";
            case FILTER_APPAREL_ARMOR_CHEST:
               return "ARMOR - CHEST";
            case FILTER_APPAREL_ARMOR_ARM_L:
               return "ARMOR - ARM - L";
            case FILTER_APPAREL_ARMOR_ARM_R:
               return "ARMOR - ARM - R";
            case FILTER_APPAREL_ARMOR_LEG_L:
               return "ARMOR - LEG - L";
            case FILTER_APPAREL_ARMOR_LEG_R:
               return "ARMOR - LEG - R";
            case FILTER_AID_FOOD:
               return "FOOD";
            case FILTER_AID_WATER:
               return "WATER";
            case FILTER_AID_FOOD_COOKED:
               return "FOOD*";
            case FILTER_AID_WATER_COOKED:
               return "WATER*";
            case FILTER_AID_CHEM:
               return "CHEM";
            case FILTER_MISC_NON_KEYS:
               return "*";
            case FILTER_MISC_KEYS:
               return "KEYS";
            case FILTER_NOTES_UNREAD:
               return "UNREAD";
            default:
               return "";
         }
      }
      
      override public function EntryMatchesFilter(param1:Object) : Boolean
      {
         // method body index: 195 method index: 195
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         if(this.extraFilterType == -1)
         {
            return param1 != null && (!param1.hasOwnProperty("filterFlag") || (param1.filterFlag & this.itemFilter) != 0);
         }
         if(param1 == null || param1.hasOwnProperty("filterFlag") && (param1.filterFlag & this.itemFilter) == 0)
         {
            return false;
         }
         _loc2_ = this.infoMap[param1.serverHandleID];
         if(_loc2_ == null)
         {
            return false;
         }
         switch(this.extraFilterType)
         {
            case FILTER_WEAP_RANGED:
               if(this.isRanged(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_WEAP_MELEE:
               if(this.isMelee(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_WEAP_THROWN:
               if(this.isThrown(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_APPAREL_OUTFIT:
               if(this.isOutfit(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_APPAREL_ARMOR:
               if(!this.isOutfit(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_APPAREL_ARMOR_CHEST:
            case FILTER_APPAREL_ARMOR_ARM_L:
            case FILTER_APPAREL_ARMOR_ARM_R:
            case FILTER_APPAREL_ARMOR_LEG_L:
            case FILTER_APPAREL_ARMOR_LEG_R:
               _loc3_ = this.paperDollMap[param1.serverHandleID];
               if(_loc3_ == null)
               {
                  return false;
               }
               if(!this.isOutfit(_loc2_) && this.occupiesApparelSlot(_loc3_,this.extraFilterType,true))
               {
                  return true;
               }
               break;
            case FILTER_AID_FOOD:
               if(this.isFood(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_AID_WATER:
               if(this.isWater(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_AID_FOOD_COOKED:
               if(this.isCookedFood(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_AID_WATER_COOKED:
               if(this.isCookedWater(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_AID_CHEM:
               if(this.isChem(_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_MISC_NON_KEYS:
               if(!this.isEntryKey(param1,_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_MISC_KEYS:
               if(this.isEntryKey(param1,_loc2_))
               {
                  return true;
               }
               break;
            case FILTER_NOTES_UNREAD:
               if(!this.hasBeenRead(param1))
               {
                  return true;
               }
               break;
         }
         return false;
      }
      
      private function isFood(param1:Array) : Boolean
      {
         // method body index: 196 method index: 196
         var _loc2_:* = undefined;
         for each(_loc2_ in param1)
         {
            if(_loc2_.text == "$Food" && parseInt(_loc2_.value) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isWater(param1:Array) : Boolean
      {
         // method body index: 197 method index: 197
         var _loc2_:* = undefined;
         for each(_loc2_ in param1)
         {
            if(_loc2_.text == "$Water" && parseInt(_loc2_.value) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isCookedFood(param1:Array) : Boolean
      {
         // method body index: 198 method index: 198
         var _loc3_:* = undefined;
         var _loc2_:int = 2;
         for each(_loc3_ in param1)
         {
            if(_loc3_.text == "$Food" && String(_loc3_.value).charAt(0) != "-")
            {
               _loc2_--;
            }
            if(_loc3_.text == "currentHealth" && int(_loc3_.value) == -1)
            {
               return false;
            }
            if(_loc3_.text == "maximumHealth" && int(_loc3_.value) > 0)
            {
               _loc2_--;
            }
            if(_loc3_.text == "Disease Chance")
            {
               return false;
            }
         }
         return _loc2_ == 0;
      }
      
      private function isCookedWater(param1:Array) : Boolean
      {
         // method body index: 199 method index: 199
         var _loc3_:* = undefined;
         var _loc2_:int = 2;
         for each(_loc3_ in param1)
         {
            if(_loc3_.text == "$Water" && String(_loc3_.value).charAt(0) != "-")
            {
               _loc2_--;
            }
            if(_loc3_.text == "currentHealth" && int(_loc3_.value) == -1)
            {
               return false;
            }
            if(_loc3_.text == "maximumHealth" && int(_loc3_.value) > 0)
            {
               _loc2_--;
            }
            if(_loc3_.text == "Disease Chance")
            {
               return false;
            }
         }
         return _loc2_ == 0;
      }
      
      private function isChem(param1:Array) : Boolean
      {
         // method body index: 200 method index: 200
         return !this.isWater(param1) && !this.isFood(param1);
      }
      
      private function isRanged(param1:Array) : Boolean
      {
         // method body index: 201 method index: 201
         var _loc2_:* = undefined;
         for each(_loc2_ in param1)
         {
            if(_loc2_.text == "$ROF" && Number(_loc2_.value) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isMelee(param1:Array) : Boolean
      {
         // method body index: 202 method index: 202
         var _loc2_:* = undefined;
         for each(_loc2_ in param1)
         {
            if(_loc2_.text == "$speed")
            {
               return true;
            }
         }
         return false;
      }
      
      private function isThrown(param1:Array) : Boolean
      {
         // method body index: 203 method index: 203
         var _loc3_:* = undefined;
         var _loc2_:Boolean = false;
         for each(_loc3_ in param1)
         {
            if(_loc3_.text == "$ROF" && Number(_loc3_.value) > 0)
            {
               return false;
            }
            if(_loc3_.text == "$acc" && Number(_loc3_.value) > 0)
            {
               return false;
            }
            if(_loc3_.text == "$rng" && Number(_loc3_.value) > 0)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function isOutfit(param1:Array) : Boolean
      {
         // method body index: 204 method index: 204
         var _loc2_:* = undefined;
         for each(_loc2_ in param1)
         {
            if(_loc2_.text == "currentHealth" && int(_loc2_.value) == -1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function occupiesApparelSlot(param1:Array, param2:uint, param3:Boolean = false) : Boolean
      {
         // method body index: 205 method index: 205
         if(param3)
         {
            if(param1[0])
            {
               return false;
            }
         }
         switch(param2)
         {
            case FILTER_APPAREL_ARMOR_LEG_L:
               return param1[1];
            case FILTER_APPAREL_ARMOR_LEG_R:
               return param1[2];
            case FILTER_APPAREL_ARMOR_ARM_L:
               return param1[3];
            case FILTER_APPAREL_ARMOR_ARM_R:
               return param1[4];
            case FILTER_APPAREL_ARMOR_CHEST:
               return param1[5];
            default:
               return false;
         }
      }
      
      private function isKey(param1:Array) : Boolean
      {
         // method body index: 206 method index: 206
         var _loc2_:* = undefined;
         for each(_loc2_ in param1)
         {
            if(_loc2_.text == "$wt")
            {
               return Number(_loc2_.value) == 0;
            }
         }
         return false;
      }
      
      private function isEntryKey(param1:Object, param2:Array) : Boolean
      {
         // method body index: 207 method index: 207
         return param1.filterFlag == this.ITEM_FILTER_MISC && this.isKey(param2);
      }
      
      private function hasBeenRead(param1:Object) : Boolean
      {
         // method body index: 208 method index: 208
         return param1.isLearned;
      }
   }
}
