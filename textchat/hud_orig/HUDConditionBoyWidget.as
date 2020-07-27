 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.ConditionBoy;
   
   public dynamic class HUDConditionBoyWidget extends BSUIComponent
   {
       
      
      public var ConditionBoy_mc:ConditionBoy;
      
      public function HUDConditionBoyWidget()
      {
         // method body index: 2937 method index: 2937
         super();
         this.ConditionBoy_mc.x = -50;
         this.ConditionBoy_mc.y = 80;
         this.ConditionBoy_mc.scaleX = 0.65;
         this.ConditionBoy_mc.scaleY = this.ConditionBoy_mc.scaleX;
         this.ConditionBoy_mc.PreloadConditions();
      }
   }
}
