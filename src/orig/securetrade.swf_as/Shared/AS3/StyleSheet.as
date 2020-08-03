package Shared.AS3 
{
    import flash.utils.*;
    
    public class StyleSheet extends Object
    {
        public function StyleSheet()
        {
            super();
            return;
        }

        internal static function aggregateSheetProperties(arg1:Object, arg2:Object, arg3:Object, arg4:Boolean=false):*
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=flash.utils.getQualifiedClassName(arg2);
            var loc2:*;
            var loc3:*=loc2 = flash.utils.describeType(arg2);
            var loc8:*=0;
            var loc9:*=loc3;
            for each (loc4 in loc9) 
            {
                loc5 = loc4.@name;
                loc6 = typeof arg2[loc5];
                loc7 = typeof arg1[loc5];
                if (arg1.hasOwnProperty(loc5)) 
                {
                    if (loc6 == "function") 
                    {
                        throw new Error("StyleSheet:aggregateSheetProperties - Stylesheet " + loc1 + " contains function parameters (prohibited).");
                    }
                    if (loc6 != typeof arg1[loc5]) 
                    {
                        if (!arg4) 
                        {
                            trace("WARNING: StyleSheet:aggregateSheetProperties - Stylesheet " + loc1 + " : Type mismatch between source (" + loc6 + ") and target (" + loc7 + ") for property " + loc5);
                        }
                    }
                    else 
                    {
                        arg3[loc5] = arg2[loc5];
                    }
                    continue;
                }
                if (arg4) 
                {
                    continue;
                }
                trace("WARNING: SheetSheet:aggregateSheetProperties - Stylesheet " + loc1 + " contains property " + loc5 + " which does not exist on target object.");
            }
            return;
        }

        public static function apply(arg1:Object, arg2:Boolean=false, ... rest):*
        {
            var loc3:*=null;
            var loc1:*=new Object();
            var loc2:*=0;
            while (loc2 < rest.length) 
            {
                aggregateSheetProperties(arg1, rest[loc2], loc1, arg2);
                ++loc2;
            }
            var loc4:*=0;
            var loc5:*=loc1;
            for (loc3 in loc5) 
            {
                arg1[loc3] = loc1[loc3];
            }
            return;
        }
    }
}
