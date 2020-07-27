 
package fl.transitions.easing
{
   public class Regular
   {
       
      
      public function Regular()
      {
         // method body index: 190 method index: 190
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 187 method index: 187
         return param3 * (param1 = param1 / param4) * param1 + param2;
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 188 method index: 188
         return -param3 * (param1 = param1 / param4) * (param1 - 2) + param2;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 189 method index: 189
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 + param2;
         }
         return -param3 / 2 * (--param1 * (param1 - 2) - 1) + param2;
      }
   }
}
