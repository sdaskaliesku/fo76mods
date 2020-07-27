 
package Mobile.ScrollList
{
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class EventWithParams extends Event
   {
       
      
      public var params:Object;
      
      public function EventWithParams(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         // method body index: 411 method index: 411
         super(param1,param3,param4);
         this.params = param2;
      }
      
      override public function clone() : Event
      {
         // method body index: 412 method index: 412
         return new EventWithParams(type,this.params,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         // method body index: 413 method index: 413
         return formatToString(getQualifiedClassName(this),"type","bubbles","cancelable","eventPhase","params");
      }
   }
}
