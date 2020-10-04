 
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
         // method body index: 157 method index: 157
         super();
         this.m_Dispatcher = new EventDispatcher();
         this._cachedEvents = new Vector.<Event>();
      }
      
      protected function get eventDispatcherBackend() : BSUIEventDispatcherBackend
      {
         // method body index: 158 method index: 158
         return this._eventDispatcherBackend;
      }
      
      protected function set eventDispatcherBackend(param1:BSUIEventDispatcherBackend) : void
      {
         // method body index: 159 method index: 159
         this._eventDispatcherBackend = param1;
         this.SendCachedEvents();
      }
      
      private function SendCachedEvents() : *
      {
         // method body index: 160 method index: 160
         while(this._cachedEvents.length > 0)
         {
            this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         // method body index: 161 method index: 161
         this.m_Dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         // method body index: 162 method index: 162
         this.m_Dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         // method body index: 163 method index: 163
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
         // method body index: 164 method index: 164
         return this.m_Dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         // method body index: 165 method index: 165
         return this.m_Dispatcher.willTrigger(param1);
      }
   }
}
