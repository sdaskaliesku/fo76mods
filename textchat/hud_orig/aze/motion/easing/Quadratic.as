 
package aze.motion.easing
{
   public final class Quadratic
   {
       
      
      public function Quadratic()
      {
         // method body index: 211 method index: 211
         super();
      }
      
      public static function easeIn(k:Number) : Number
      {
         // method body index: 208 method index: 208
         return k * k;
      }
      
      public static function easeOut(k:Number) : Number
      {
         // method body index: 209 method index: 209
         return -k * (k - 2);
      }
      
      public static function easeInOut(k:Number) : Number
      {
         // method body index: 210 method index: 210
         if((k = k * 2) < 1)
         {
            return 0.5 * k * k;
         }
         return -0.5 * (--k * (k - 2) - 1);
      }
   }
}
