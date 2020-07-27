 
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

         super();
         this.m_Dispatcher = new EventDispatcher();
         this._cachedEvents = new Vector.<Event>();
      }
      
      protected function get eventDispatcherBackend() : BSUIEventDispatcherBackend
      {

         return this._eventDispatcherBackend;
      }
      
      protected function set eventDispatcherBackend(param1:BSUIEventDispatcherBackend) : void
      {

         this._eventDispatcherBackend = param1;
         this.SendCachedEvents();
      }
      
      private function SendCachedEvents() : *
      {

         while(this._cachedEvents.length > 0)
         {
            this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {

         this.m_Dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {

         this.m_Dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {

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

         return this.m_Dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {

         return this.m_Dispatcher.willTrigger(param1);
      }
   }
}
