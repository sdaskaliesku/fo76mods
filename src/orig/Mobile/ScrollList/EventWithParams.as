 
package Mobile.ScrollList
{
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class EventWithParams extends Event
   {
       
      
      public var params:Object;
      
      public function EventWithParams(_type:String, _params:Object = null, _bubbles:Boolean = false, _cancelable:Boolean = false)
      {
         // method body index: 228 method index: 228
         super(_type,_bubbles,_cancelable);
         this.params = _params;
      }
      
      override public function clone() : Event
      {
         // method body index: 229 method index: 229
         return new EventWithParams(type,this.params,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         // method body index: 230 method index: 230
         return formatToString(getQualifiedClassName(this),"type","bubbles","cancelable","eventPhase","params");
      }
   }
}
