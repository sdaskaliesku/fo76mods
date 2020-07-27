 
package Mobile.ScrollList
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MobileListItemRenderer extends MovieClip
   {
       
      
      public var textField:TextField;
      
      protected var _data:Object;
      
      private var _mouseDownPos:Number;
      
      private var _mouseUpPos:Number;
      
      private const DELTA_MOUSE_POS:int = 15;
      
      public function MobileListItemRenderer()
      {
         // method body index: 2584 method index: 2584
         super();
      }
      
      public function get data() : Object
      {
         // method body index: 2585 method index: 2585
         return this._data;
      }
      
      protected function get isClickable() : Boolean
      {
         // method body index: 2586 method index: 2586
         return this.data != null && !(this.data.clickable != null && !this.data.clickable);
      }
      
      public function reset() : void
      {
         // method body index: 2587 method index: 2587
         this._data = null;
         addEventListener(Event.REMOVED_FROM_STAGE,this.destroy,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler,false,0,true);
      }
      
      public function setData(param1:Object) : *
      {
         // method body index: 2588 method index: 2588
         this._data = param1;
         if(param1 != null)
         {
            this.setVisual();
         }
      }
      
      protected function setVisual() : void
      {
         // method body index: 2589 method index: 2589
      }
      
      protected function itemPressHandler(param1:MouseEvent) : void
      {
         // method body index: 2590 method index: 2590
         if(this.isClickable)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
            addEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler,false,0,true);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_SELECT,{"renderer":this}));
         }
      }
      
      protected function itemReleaseHandler(param1:MouseEvent) : void
      {
         // method body index: 2591 method index: 2591
         if(this.isClickable)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE,{"renderer":this}));
         }
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         // method body index: 2592 method index: 2592
         if(mouseY < 0 || mouseY > this.height || mouseX < 0 || mouseX > this.width)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE_OUTSIDE,{"renderer":this}));
         }
      }
      
      public function selectItem() : void
      {
         // method body index: 2593 method index: 2593
      }
      
      public function unselectItem() : void
      {
         // method body index: 2594 method index: 2594
      }
      
      public function pressItem() : void
      {
         // method body index: 2595 method index: 2595
      }
      
      protected function destroy(param1:Event) : void
      {
         // method body index: 2596 method index: 2596
         removeEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler);
      }
   }
}
