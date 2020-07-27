 
package aze.motion.specials
{
   import aze.motion.EazeTween;
   import flash.geom.Rectangle;
   
   public class PropertyRect extends EazeSpecial
   {
       
      
      private var original:Rectangle;
      
      private var targetRect:Rectangle;
      
      private var tmpRect:Rectangle;
      
      public function PropertyRect(target:Object, property:*, value:*, next:EazeSpecial)
      {
         // method body index: 505 method index: 505
         super(target,property,value,next);
         this.targetRect = value && value is Rectangle?value.clone():new Rectangle();
      }
      
      public static function register() : void
      {
         // method body index: 504 method index: 504
         EazeTween.specialProperties["__rect"] = PropertyRect;
      }
      
      override public function init(reverse:Boolean) : void
      {
         // method body index: 506 method index: 506
         this.original = target[property] is Rectangle?target[property].clone() as Rectangle:new Rectangle(0,0,target.width,target.height);
         if(reverse)
         {
            this.tmpRect = this.original;
            this.original = this.targetRect;
            this.targetRect = this.tmpRect;
         }
         this.tmpRect = new Rectangle();
      }
      
      override public function update(ke:Number, isComplete:Boolean) : void
      {
         // method body index: 507 method index: 507
         if(isComplete)
         {
            target.scrollRect = this.targetRect;
         }
         else
         {
            this.tmpRect.x = this.original.x + (this.targetRect.x - this.original.x) * ke;
            this.tmpRect.y = this.original.y + (this.targetRect.y - this.original.y) * ke;
            this.tmpRect.width = this.original.width + (this.targetRect.width - this.original.width) * ke;
            this.tmpRect.height = this.original.height + (this.targetRect.height - this.original.height) * ke;
            target[property] = this.tmpRect;
         }
      }
      
      override public function dispose() : void
      {
         // method body index: 508 method index: 508
         this.original = this.targetRect = this.tmpRect = null;
         super.dispose();
      }
   }
}
