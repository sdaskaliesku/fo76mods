 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public static const ACTION_HOVERCHARACTER:String = // method body index: 194 method index: 194
      "HoverCharacter";
       
      
      public var params:Object;
      
      public function CustomEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         // method body index: 195 method index: 195
         super(param1,param3,param4);
         this.params = param2;
      }
      
      override public function clone() : Event
      {
         // method body index: 196 method index: 196
         return new CustomEvent(type,this.params,bubbles,cancelable);
      }
   }
}
