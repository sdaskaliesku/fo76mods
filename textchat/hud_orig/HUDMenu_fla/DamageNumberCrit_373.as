 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class DamageNumberCrit_373 extends MovieClip
   {
       
      
      public var Number_mc:MovieClip;
      
      public function DamageNumberCrit_373()
      {
         // method body index: 1039 method index: 1039
         super();
         addFrameScript(0,this.frame1,49,this.frame50);
         this.__setTab_Number_mc_DamageNumberCrit_Number_mc_0();
      }
      
      function __setTab_Number_mc_DamageNumberCrit_Number_mc_0() : *
      {
         // method body index: 1036 method index: 1036
         this.Number_mc.tabIndex = 1;
      }
      
      function frame1() : *
      {
         // method body index: 1037 method index: 1037
         stop();
      }
      
      function frame50() : *
      {
         // method body index: 1038 method index: 1038
         DamageNumberClip(this.parent).Destroy();
      }
   }
}
