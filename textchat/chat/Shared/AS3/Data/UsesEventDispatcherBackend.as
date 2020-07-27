 
package Shared.AS3.Data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class UsesEventDispatcherBackend implements IEventDispatcher
   {
       
      
      private var m_Dispatcher:EventDispatcher;
      
      private var _eventDispatcherBackend:BSUIEventDispatcherBackend;
      
      private var _cachedEvents:Vector.<Event>;
      
      public function UsesEventDispatcherBackend()
      {
         // method body index: 133 method index: 133
         super();
         this.m_Dispatcher = new EventDispatcher();
         this._cachedEvents = new Vector.<Event>();
      }
      
      protected function get eventDispatcherBackend() : BSUIEventDispatcherBackend
      {
         // method body index: 134 method index: 134
         return this._eventDispatcherBackend;
      }
      
      protected function set eventDispatcherBackend(param1:BSUIEventDispatcherBackend) : void
      {
         // method body index: 135 method index: 135
         this._eventDispatcherBackend = param1;
         this.SendCachedEvents();
      }
      
      private function SendCachedEvents() : *
      {
         // method body index: 136 method index: 136
         while(this._cachedEvents.length > 0)
         {
            this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         // method body index: 137 method index: 137
         this.m_Dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         // method body index: 138 method index: 138
         this.m_Dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         // method body index: 139 method index: 139
         var _loc2_:Boolean = false;
         if(this.eventDispatcherBackend is BSUIEventDispatcherBackend)
         {
            this.eventDispatcherBackend.DispatchEventToGame(param1);
         }
         else
         {
            this._cachedEvents.push(param1.clone());
         }
         _loc2_ = this.m_Dispatcher.dispatchEvent(param1);
         return _loc2_;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         // method body index: 140 method index: 140
         return this.m_Dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         // method body index: 141 method index: 141
         return this.m_Dispatcher.willTrigger(param1);
      }
   }
}
