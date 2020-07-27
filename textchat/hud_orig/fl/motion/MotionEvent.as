 
package fl.motion
{
   import flash.events.Event;
   
   public class MotionEvent extends Event
   {
      
      public static const MOTION_START:String = // method body index: 432 method index: 432
      "motionStart";
      
      public static const MOTION_END:String = // method body index: 432 method index: 432
      "motionEnd";
      
      public static const MOTION_UPDATE:String = // method body index: 432 method index: 432
      "motionUpdate";
      
      public static const TIME_CHANGE:String = // method body index: 432 method index: 432
      "timeChange";
       
      
      public function MotionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {

         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {

         return new MotionEvent(this.type,this.bubbles,this.cancelable);
      }
   }
}
