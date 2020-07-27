 
package fl.motion
{
   public class AnimatorFactory3D extends AnimatorFactoryBase
   {
       
      
      public function AnimatorFactory3D(param1:MotionBase, param2:Array = null)
      {
         // method body index: 454 method index: 454
         super(param1,param2);
         this._is3D = true;
      }
      
      override protected function getNewAnimator() : AnimatorBase
      {
         // method body index: 455 method index: 455
         return new Animator3D(null,null);
      }
   }
}
