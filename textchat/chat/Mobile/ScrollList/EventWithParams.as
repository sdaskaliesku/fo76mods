 
package Mobile.ScrollList
{
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class EventWithParams extends Event
   {
       
      
      public var params:Object;
      
      public function EventWithParams(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         // method body index: 165 method index: 165
         super(param1,param3,param4);
         this.params = param2;
      }
      
      override public function clone() : Event
      {
         // method body index: 166 method index: 166
         return new EventWithParams(type,this.params,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         // method body index: 167 method index: 167
         return formatToString(getQualifiedClassName(this),"type","bubbles","cancelable","eventPhase","params");
      }
   }
}
