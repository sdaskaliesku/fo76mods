 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class DamageNumber_375 extends MovieClip
   {
       
      
      public var Number_mc:MovieClip;
      
      public function DamageNumber_375()
      {

         super();
         addFrameScript(0,this.frame1,39,this.frame40);
         this.__setTab_Number_mc_DamageNumber_Number_mc_0();
      }
      
      function __setTab_Number_mc_DamageNumber_Number_mc_0() : *
      {

         this.Number_mc.tabIndex = 1;
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame40() : *
      {

         DamageNumberClip(this.parent).Destroy();
      }
   }
}
