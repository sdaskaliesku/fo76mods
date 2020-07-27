 
package aze.motion.easing
{
   public final class Quadratic
   {
       
      
      public function Quadratic()
      {
         // method body index: 211 method index: 211
         super();
      }
      
      public static function easeIn(param1:Number) : Number
      {
         // method body index: 208 method index: 208
         return param1 * param1;
      }
      
      public static function easeOut(param1:Number) : Number
      {
         // method body index: 209 method index: 209
         return -param1 * (param1 - 2);
      }
      
      public static function easeInOut(param1:Number) : Number
      {
         // method body index: 210 method index: 210
         if((param1 = param1 * 2) < 1)
         {
            return 0.5 * param1 * param1;
         }
         return -0.5 * (--param1 * (param1 - 2) - 1);
      }
   }
}
