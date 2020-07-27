 
package fl.transitions.easing
{
   public class None
   {
       
      
      public function None()
      {
         // method body index: 190 method index: 190
         super();
      }
      
      public static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 186 method index: 186
         return param3 * param1 / param4 + param2;
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 187 method index: 187
         return param3 * param1 / param4 + param2;
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 188 method index: 188
         return param3 * param1 / param4 + param2;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         // method body index: 189 method index: 189
         return param3 * param1 / param4 + param2;
      }
   }
}
