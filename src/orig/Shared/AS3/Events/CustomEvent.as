 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public static const ACTION_HOVERCHARACTER:String = // method body index: 223 method index: 223
      "HoverCharacter";
       
      
      public var params:Object;
      
      public function CustomEvent(astrType:String, aParams:Object, abBubbles:Boolean = false, abCancelable:Boolean = false)
      {
         // method body index: 224 method index: 224
         super(astrType,abBubbles,abCancelable);
         this.params = aParams;
      }
      
      override public function clone() : Event
      {
         // method body index: 225 method index: 225
         return new CustomEvent(type,this.params,bubbles,cancelable);
      }
   }
}
