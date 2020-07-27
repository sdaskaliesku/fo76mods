 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class DamageNumberCrit_373 extends MovieClip
   {
       
      
      public var Number_mc:MovieClip;
      
      public function DamageNumberCrit_373()
      {

         super();
         addFrameScript(0,this.frame1,49,this.frame50);
         this.__setTab_Number_mc_DamageNumberCrit_Number_mc_0();
      }
      
      function __setTab_Number_mc_DamageNumberCrit_Number_mc_0() : *
      {

         this.Number_mc.tabIndex = 1;
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame50() : *
      {

         DamageNumberClip(this.parent).Destroy();
      }
   }
}
