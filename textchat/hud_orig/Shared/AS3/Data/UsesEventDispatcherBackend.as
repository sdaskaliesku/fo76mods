 
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
      
      protected function set eventDispatcherBackend(value:BSUIEventDispatcherBackend) : void
      {

         this._eventDispatcherBackend = value;
         this.SendCachedEvents();
      }
      
      private function SendCachedEvents() : *
      {

         while(this._cachedEvents.length > 0)
         {
            this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
         }
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {

         this.m_Dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {

         this.m_Dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {

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

         return this.m_Dispatcher.hasEventListener(type);
      }
      
      public function willTrigger(type:String) : Boolean
      {

         return this.m_Dispatcher.willTrigger(type);
      }
   }
}
