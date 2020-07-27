 
package aze.motion.specials
{
   public class EazeSpecial
   {
       
      
      protected var target:Object;
      
      protected var property:String;
      
      public var next:EazeSpecial;
      
      public function EazeSpecial(param1:Object, param2:*, param3:*, param4:EazeSpecial)
      {
         // method body index: 255 method index: 255
         super();
         this.target = param1;
         this.property = param2;
         this.next = param4;
      }
      
      public function init(param1:Boolean) : void
      {
         // method body index: 256 method index: 256
      }
      
      public function update(param1:Number, param2:Boolean) : void
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
