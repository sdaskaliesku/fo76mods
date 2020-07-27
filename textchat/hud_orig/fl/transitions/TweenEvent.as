 
package fl.transitions
{
   import flash.events.Event;
   
   public class TweenEvent extends Event
   {
      
      public static const MOTION_START:String = // method body index: 370 method index: 370
      "motionStart";
      
      public static const MOTION_STOP:String = // method body index: 370 method index: 370
      "motionStop";
      
      public static const MOTION_FINISH:String = // method body index: 370 method index: 370
      "motionFinish";
      
      public static const MOTION_CHANGE:String = // method body index: 370 method index: 370
      "motionChange";
      
      public static const MOTION_RESUME:String = // method body index: 370 method index: 370
      "motionResume";
      
      public static const MOTION_LOOP:String = // method body index: 370 method index: 370
      "motionLoop";
       
      
      public var time:Number = NaN;
      
      public var position:Number = NaN;
      
      public function TweenEvent(param1:String, param2:Number, param3:Number, param4:Boolean = false, param5:Boolean = false)
      {

         super(param1,param4,param5);
         this.time = param2;
         this.position = param3;
      }
      
      override public function clone() : Event
      {

         return new TweenEvent(this.type,this.time,this.position,this.bubbles,this.cancelable);
      }
   }
}
