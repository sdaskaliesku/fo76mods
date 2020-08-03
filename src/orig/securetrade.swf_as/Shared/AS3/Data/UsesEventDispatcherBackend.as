package Shared.AS3.Data 
{
    import __AS3__.vec.*;
    import flash.events.*;
    
    public class UsesEventDispatcherBackend extends Object implements flash.events.IEventDispatcher
    {
        public function UsesEventDispatcherBackend()
        {
            super();
            this.m_Dispatcher = new flash.events.EventDispatcher();
            this._cachedEvents = new Vector.<flash.events.Event>();
            return;
        }

        protected function get eventDispatcherBackend():Shared.AS3.Data.BSUIEventDispatcherBackend
        {
            return this._eventDispatcherBackend;
        }

        protected function set eventDispatcherBackend(arg1:Shared.AS3.Data.BSUIEventDispatcherBackend):void
        {
            this._eventDispatcherBackend = arg1;
            this.SendCachedEvents();
            return;
        }

        internal function SendCachedEvents():*
        {
            while (this._cachedEvents.length > 0) 
            {
                this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
            }
            return;
        }

        public function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            this.m_Dispatcher.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            this.m_Dispatcher.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            var loc1:*=false;
            if (this.eventDispatcherBackend is Shared.AS3.Data.BSUIEventDispatcherBackend) 
            {
                this.eventDispatcherBackend.DispatchEventToGame(arg1);
            }
            else 
            {
                this._cachedEvents.push(arg1.clone());
            }
            loc1 = this.m_Dispatcher.dispatchEvent(arg1);
            return loc1;
        }

        public function hasEventListener(arg1:String):Boolean
        {
            return this.m_Dispatcher.hasEventListener(arg1);
        }

        public function willTrigger(arg1:String):Boolean
        {
            return this.m_Dispatcher.willTrigger(arg1);
        }

        internal var m_Dispatcher:flash.events.EventDispatcher;

        internal var _eventDispatcherBackend:Shared.AS3.Data.BSUIEventDispatcherBackend;

        internal var _cachedEvents:__AS3__.vec.Vector.<flash.events.Event>;
    }
}
