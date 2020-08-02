 
package
{
   import flash.display.MovieClip;
   
   public class RadialActiveEffectEntry extends MovieClip
   {
       
      
      public var Icon_mc:MovieClip;
      
      public var EffectName_mc:MovieClip;
      
      public function RadialActiveEffectEntry()
      {
         // method body index: 660 method index: 660
         super();
      }
      
      public function UpdateEffectEntry(aEntry:Object) : *
      {
         // method body index: 661 method index: 661
         this.EffectName_mc.title_tf.text = aEntry.effectName;
         this.Icon_mc.gotoAndStop(aEntry.effectIcon);
      }
   }
}
