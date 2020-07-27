 
package Shared.AS3
{
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class StyleSheet
   {
       
      
      public function StyleSheet()
      {

         super();
      }
      
      private static function aggregateSheetProperties(param1:Object, param2:Object, param3:Object, param4:Boolean = false) : *
      {

         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:String = getQualifiedClassName(param2);
         var _loc10_:XML = describeType(param2);
         var _loc11_:XMLList = _loc10_..variable;
         for each(_loc5_ in _loc11_)
         {
            _loc6_ = _loc5_.@name;
            _loc7_ = typeof param2[_loc6_];
            _loc8_ = typeof param1[_loc6_];
            if(param1.hasOwnProperty(_loc6_))
            {
               if(_loc7_ == "function")
               {
                  throw new Error("StyleSheet:aggregateSheetProperties - Stylesheet " + _loc9_ + " contains function parameters (prohibited).");
               }
               if(_loc7_ == typeof param1[_loc6_])
               {
                  param3[_loc6_] = param2[_loc6_];
               }
               else if(!param4)
               {
                  trace("WARNING: StyleSheet:aggregateSheetProperties - Stylesheet " + _loc9_ + " : Type mismatch between source (" + _loc7_ + ") and target (" + _loc8_ + ") for property " + _loc6_);
               }
            }
            else if(!param4)
            {
               trace("WARNING: SheetSheet:aggregateSheetProperties - Stylesheet " + _loc9_ + " contains property " + _loc6_ + " which does not exist on target object.");
            }
         }
      }
      
      public static function apply(param1:Object, param2:Boolean = false, ... rest) : *
      {

         var _loc4_:* = null;
         var _loc5_:Object = new Object();
         var _loc6_:* = 0;
         while(_loc6_ < rest.length)
         {
            aggregateSheetProperties(param1,rest[_loc6_],_loc5_,param2);
            _loc6_++;
         }
         for(_loc4_ in _loc5_)
         {
            param1[_loc4_] = _loc5_[_loc4_];
         }
      }
   }
}
