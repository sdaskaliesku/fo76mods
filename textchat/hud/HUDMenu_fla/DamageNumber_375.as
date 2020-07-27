 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class DamageNumber_375 extends MovieClip
   {
       
      
      public var Number_mc:MovieClip;
      
      public function DamageNumber_375()
      {
         // method body index: 968 method index: 968
         super();
         addFrameScript(0,this.frame1,39,this.frame40);
         this.__setTab_Number_mc_DamageNumber_Number_mc_0();
      }
      
      function __setTab_Number_mc_DamageNumber_Number_mc_0() : *
      {
         // method body index: 969 method index: 969
         this.Number_mc.tabIndex = 1;
      }
      
      function frame1() : *
      {
         // method body index: 970 method index: 970
         stop();
      }
      
      function frame40() : *
      {
         // method body index: 971 method index: 971
         DamageNumberClip(this.parent).Destroy();
      }
   }
}
