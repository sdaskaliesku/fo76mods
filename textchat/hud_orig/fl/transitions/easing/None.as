 
package fl.transitions.easing
{
   public class None
   {
       
      
      public function None()
      {
         // method body index: 184 method index: 184
         super();
      }
      
      public static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 180 method index: 180
         return param3 * param1 / param4 + param2;
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 181 method index: 181
         return param3 * param1 / param4 + param2;
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 182 method index: 182
         return param3 * param1 / param4 + param2;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 183 method index: 183
         return param3 * param1 / param4 + param2;
      }
   }
}
