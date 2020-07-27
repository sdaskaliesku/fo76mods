 
package
{
   import flash.display.MovieClip;
   
   public class DamageNumberClip extends MovieClip
   {
       
      
      public var ParentObj:DamageNumbers;
      
      public var UniqueId:int;
      
      public var Base_mc:MovieClip;
      
      public var Crit_mc:MovieClip;
      
      public function DamageNumberClip()
      {
         // method body index: 772 method index: 772
         super();
      }
      
      public function Destroy() : *
      {
         // method body index: 773 method index: 773
         this.ParentObj.RemoveDamageNumber(this.UniqueId);
      }
   }
}
