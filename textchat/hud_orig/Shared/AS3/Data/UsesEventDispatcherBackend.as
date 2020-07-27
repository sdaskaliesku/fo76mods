 
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
         // method body index: 355 method index: 355
         super();
         this.m_Dispatcher = new EventDispatcher();
         this._cachedEvents = new Vector.<Event>();
      }
      
      protected function get eventDispatcherBackend() : BSUIEventDispatcherBackend
      {
         // method body index: 356 method index: 356
         return this._eventDispatcherBackend;
      }
      
      protected function set eventDispatcherBackend(value:BSUIEventDispatcherBackend) : void
      {
         // method body index: 357 method index: 357
         this._eventDispatcherBackend = value;
         this.SendCachedEvents();
      }
      
      private function SendCachedEvents() : *
      {
         // method body index: 358 method index: 358
         while(this._cachedEvents.length > 0)
         {
            this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
         }
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         // method body index: 359 method index: 359
         this.m_Dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         // method body index: 360 method index: 360
         this.m_Dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         // method body index: 361 method index: 361
         var success:Boolean = false;
         if(this.eventDispatcherBackend is BSUIEventDispatcherBackend)
         {
            this.eventDispatcherBackend.DispatchEventToGame(event);
         }
         else
         {
            this._cachedEvents.push(event.clone());
         }
         success = this.m_Dispatcher.dispatchEvent(event);
         return success;
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         // method body index: 362 method index: 362
         return this.m_Dispatcher.hasEventListener(type);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         // method body index: 363 method index: 363
         return this.m_Dispatcher.willTrigger(type);
      }
   }
}
