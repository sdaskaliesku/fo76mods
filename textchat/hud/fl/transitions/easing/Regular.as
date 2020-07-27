 
package fl.transitions.easing
{
   public class Regular
   {
       
      
      public function Regular()
      {
         // method body index: 183 method index: 183
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 180 method index: 180
         return param3 * (param1 = param1 / param4) * param1 + param2;
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 181 method index: 181
         return -param3 * (param1 = param1 / param4) * (param1 - 2) + param2;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 182 method index: 182
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 + param2;
         }
         return -param3 / 2 * (--param1 * (param1 - 2) - 1) + param2;
      }
   }
}
