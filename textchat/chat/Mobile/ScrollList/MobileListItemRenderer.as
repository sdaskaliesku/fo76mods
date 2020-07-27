 
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
         // method body index: 557 method index: 557
         super();
      }
      
      public function get data() : Object
      {
         // method body index: 558 method index: 558
         return this._data;
      }
      
      protected function get isClickable() : Boolean
      {
         // method body index: 559 method index: 559
         return this.data != null && !(this.data.clickable != null && !this.data.clickable);
      }
      
      public function reset() : void
      {
         // method body index: 560 method index: 560
         this._data = null;
         addEventListener(Event.REMOVED_FROM_STAGE,this.destroy,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler,false,0,true);
      }
      
      public function setData(param1:Object) : *
      {
         // method body index: 561 method index: 561
         this._data = param1;
         if(param1 != null)
         {
            this.setVisual();
         }
      }
      
      protected function setVisual() : void
      {
         // method body index: 562 method index: 562
      }
      
      protected function itemPressHandler(param1:MouseEvent) : void
      {
         // method body index: 563 method index: 563
         if(this.isClickable)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
            addEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler,false,0,true);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_SELECT,{"renderer":this}));
         }
      }
      
      protected function itemReleaseHandler(param1:MouseEvent) : void
      {
         // method body index: 564 method index: 564
         if(this.isClickable)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE,{"renderer":this}));
         }
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         // method body index: 565 method index: 565
         if(mouseY < 0 || mouseY > this.height || mouseX < 0 || mouseX > this.width)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE_OUTSIDE,{"renderer":this}));
         }
      }
      
      public function selectItem() : void
      {
         // method body index: 566 method index: 566
      }
      
      public function unselectItem() : void
      {
         // method body index: 567 method index: 567
      }
      
      public function pressItem() : void
      {
         // method body index: 568 method index: 568
      }
      
      protected function destroy(param1:Event) : void
      {
         // method body index: 569 method index: 569
         removeEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler);
      }
   }
}
