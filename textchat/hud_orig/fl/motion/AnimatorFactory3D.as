 
package fl.motion
{
   public class AnimatorFactory3D extends AnimatorFactoryBase
   {
       
      
      public function AnimatorFactory3D(param1:MotionBase, param2:Array = null)
      {
         // method body index: 457 method index: 457
         super(param1,param2);
         this._is3D = true;
      }
      
      override protected function getNewAnimator() : AnimatorBase
      {
         // method body index: 458 method index: 458
         return new Animator3D(null,null);
      }
   }
}
