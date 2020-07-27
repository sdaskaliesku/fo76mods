 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class DamageNumberCrit_373 extends MovieClip
   {
       
      
      public var Number_mc:MovieClip;
      
      public function DamageNumberCrit_373()
      {
         // method body index: 962 method index: 962
         super();
         addFrameScript(0,this.frame1,49,this.frame50);
         this.__setTab_Number_mc_DamageNumberCrit_Number_mc_0();
      }
      
      function __setTab_Number_mc_DamageNumberCrit_Number_mc_0() : *
      {
         // method body index: 963 method index: 963
         this.Number_mc.tabIndex = 1;
      }
      
      function frame1() : *
      {
         // method body index: 964 method index: 964
         stop();
      }
      
      function frame50() : *
      {
         // method body index: 965 method index: 965
         DamageNumberClip(this.parent).Destroy();
      }
   }
}
