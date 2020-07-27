 
package
{
   import flash.geom.ColorTransform;
   
   public dynamic class EnemyHealthMeter extends HealthMeter
   {
       
      
      public function EnemyHealthMeter()
      {

         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11);
      }
      
      function frame1() : *
      {

         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(0.96,0.46,0.46,1,0,0,0,0);
      }
      
      function frame6() : *
      {

         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      }
      
      function frame11() : *
      {

         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(0.97,0.8,0.46,1,0,0,0,0);
      }
   }
}
