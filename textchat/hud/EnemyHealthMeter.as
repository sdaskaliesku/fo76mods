 
package
{
   import flash.geom.ColorTransform;
   
   public dynamic class EnemyHealthMeter extends HealthMeter
   {
       
      
      public function EnemyHealthMeter()
      {
         // method body index: 3410 method index: 3410
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11);
      }
      
      function frame1() : *
      {
         // method body index: 3411 method index: 3411
         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(0.96,0.46,0.46,1,0,0,0,0);
      }
      
      function frame6() : *
      {
         // method body index: 3412 method index: 3412
         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      }
      
      function frame11() : *
      {
         // method body index: 3413 method index: 3413
         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(0.97,0.8,0.46,1,0,0,0,0);
      }
   }
}
