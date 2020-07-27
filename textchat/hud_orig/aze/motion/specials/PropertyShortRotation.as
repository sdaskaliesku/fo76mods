 
package aze.motion.specials
{
   import aze.motion.EazeTween;
   
   public class PropertyShortRotation extends EazeSpecial
   {
       
      
      private var fvalue:Number;
      
      private var radius:Number;
      
      private var start:Number;
      
      private var delta:Number;
      
      public function PropertyShortRotation(target:Object, property:*, value:*, next:EazeSpecial)
      {
         // method body index: 486 method index: 486
         super(target,property,value,next);
         this.fvalue = value[0];
         this.radius = !!value[1]?Number(Math.PI):Number(180);
      }
      
      public static function register() : void
      {
         // method body index: 485 method index: 485
         EazeTween.specialProperties["__short"] = PropertyShortRotation;
      }
      
      override public function init(reverse:Boolean) : void
      {
         // method body index: 487 method index: 487
         var end:Number = NaN;
         this.start = target[property];
         if(reverse)
         {
            end = this.start;
            target[property] = this.start = this.fvalue;
         }
         else
         {
            end = this.fvalue;
         }
         while(end - this.start > this.radius)
         {
            this.start = this.start + this.radius * 2;
         }
         while(end - this.start < -this.radius)
         {
            this.start = this.start - this.radius * 2;
         }
         this.delta = end - this.start;
      }
      
      override public function update(ke:Number, isComplete:Boolean) : void
      {
         // method body index: 488 method index: 488
         target[property] = this.start + ke * this.delta;
      }
   }
}
