 
package Shared.AS3
{
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class StyleSheet
   {
       
      
      public function StyleSheet()
      {
         // method body index: 216 method index: 216
         super();
      }
      
      private static function aggregateSheetProperties(aTargObj:Object, aSheetObj:Object, aNewProperties:Object, aIgnoreWarnings:Boolean = false) : *
      {
         // method body index: 214 method index: 214
         var item:XML = null;
         var key:String = null;
         var sourceType:* = null;
         var targType:* = null;
         var sheetName:String = getQualifiedClassName(aSheetObj);
         var classInfo:XML = describeType(aSheetObj);
         var propertyList:XMLList = classInfo..variable;
         for each(item in propertyList)
         {
            key = item.@name;
            sourceType = typeof aSheetObj[key];
            targType = typeof aTargObj[key];
            if(aTargObj.hasOwnProperty(key))
            {
               if(sourceType == "function")
               {
                  throw new Error("StyleSheet:aggregateSheetProperties - Stylesheet " + sheetName + " contains function parameters (prohibited).");
               }
               if(sourceType == typeof aTargObj[key])
               {
                  aNewProperties[key] = aSheetObj[key];
               }
               else if(!aIgnoreWarnings)
               {
                  trace("WARNING: StyleSheet:aggregateSheetProperties - Stylesheet " + sheetName + " : Type mismatch between source (" + sourceType + ") and target (" + targType + ") for property " + key);
               }
            }
            else if(!aIgnoreWarnings)
            {
               trace("WARNING: SheetSheet:aggregateSheetProperties - Stylesheet " + sheetName + " contains property " + key + " which does not exist on target object.");
            }
         }
      }
      
      public static function apply(aTargObj:Object, aIgnoreWarnings:Boolean = false, ... args) : *
      {
         // method body index: 215 method index: 215
         var key:* = null;
         var newProperties:Object = new Object();
         for(var i:* = 0; i < args.length; i++)
         {
            aggregateSheetProperties(aTargObj,args[i],newProperties,aIgnoreWarnings);
         }
         for(key in newProperties)
         {
            aTargObj[key] = newProperties[key];
         }
      }
   }
}
