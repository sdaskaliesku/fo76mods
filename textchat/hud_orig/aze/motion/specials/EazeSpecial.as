 
package aze.motion.specials
{
   public class EazeSpecial
   {
       
      
      protected var target:Object;
      
      protected var property:String;
      
      public var next:EazeSpecial;
      
      public function EazeSpecial(target:Object, property:*, value:*, next:EazeSpecial)
      {
         // method body index: 255 method index: 255
         super();
         this.target = target;
         this.property = property;
         this.next = next;
      }
      
      public function init(reverse:Boolean) : void
      {
         // method body index: 256 method index: 256
      }
      
      public function update(ke:Number, isComplete:Boolean) : void
      {
         // method body index: 257 method index: 257
      }
      
      public function dispose() : void
      {
         // method body index: 258 method index: 258
         this.target = null;
         if(this.next)
         {
            this.next.dispose();
         }
         this.next = null;
      }
   }
}
