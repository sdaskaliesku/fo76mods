 
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
         // method body index: 186 method index: 186
         super();
         this.m_Dispatcher = new EventDispatcher();
         this._cachedEvents = new Vector.<Event>();
      }
      
      protected function get eventDispatcherBackend() : BSUIEventDispatcherBackend
      {
         // method body index: 187 method index: 187
         return this._eventDispatcherBackend;
      }
      
      protected function set eventDispatcherBackend(value:BSUIEventDispatcherBackend) : void
      {
         // method body index: 188 method index: 188
         this._eventDispatcherBackend = value;
         this.SendCachedEvents();
      }
      
      private function SendCachedEvents() : *
      {
         // method body index: 189 method index: 189
         while(this._cachedEvents.length > 0)
         {
            this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
         }
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         // method body index: 190 method index: 190
         this.m_Dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         // method body index: 191 method index: 191
         this.m_Dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         // method body index: 192 method index: 192
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
         // method body index: 193 method index: 193
         return this.m_Dispatcher.hasEventListener(type);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         // method body index: 194 method index: 194
         return this.m_Dispatcher.willTrigger(type);
      }
   }
}
