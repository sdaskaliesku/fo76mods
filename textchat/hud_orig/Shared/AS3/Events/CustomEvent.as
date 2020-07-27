 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public static const ACTION_HOVERCHARACTER:String = // method body index: 384 method index: 384
      "HoverCharacter";
       
      
      public var params:Object;
      
      public function CustomEvent(astrType:String, aParams:Object, abBubbles:Boolean = false, abCancelable:Boolean = false)
      {

         super(astrType,abBubbles,abCancelable);
         this.params = aParams;
      }
      
      override public function clone() : Event
      {

         return new CustomEvent(type,this.params,bubbles,cancelable);
      }
   }
}
