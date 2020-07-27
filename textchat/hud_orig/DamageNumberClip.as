 
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

         super();
      }
      
      public function Destroy() : *
      {

         this.ParentObj.RemoveDamageNumber(this.UniqueId);
      }
   }
}
