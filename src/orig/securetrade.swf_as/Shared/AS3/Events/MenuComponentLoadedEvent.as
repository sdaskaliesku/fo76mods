package Shared.AS3.Events 
{
    import Shared.AS3.*;
    import flash.events.*;
    
    public final class MenuComponentLoadedEvent extends flash.events.Event
    {
        public function MenuComponentLoadedEvent(arg1:Shared.AS3.MenuComponent)
        {
            super(MENU_COMPONENT_LOADED, true, false);
            this._sender = arg1;
            return;
        }

        public function RespondToEvent(arg1:Shared.AS3.IMenu):*
        {
            this._sender.SetParentMenu(arg1);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new Shared.AS3.Events.MenuComponentLoadedEvent(this._sender);
        }

        public static const MENU_COMPONENT_LOADED:String="MenuComponentLoaded";

        internal var _sender:Shared.AS3.MenuComponent;
    }
}
