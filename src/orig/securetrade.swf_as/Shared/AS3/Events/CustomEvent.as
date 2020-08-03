package Shared.AS3.Events 
{
    import flash.events.*;
    
    public class CustomEvent extends flash.events.Event
    {
        public function CustomEvent(arg1:String, arg2:Object, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.params = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new Shared.AS3.Events.CustomEvent(type, this.params, bubbles, cancelable);
        }

        public static const ACTION_HOVERCHARACTER:String="HoverCharacter";

        public var params:Object;
    }
}
