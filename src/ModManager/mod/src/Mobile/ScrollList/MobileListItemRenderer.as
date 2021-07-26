 
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
         // method body index: 601 method index: 601
         super();
      }
      
      public function get data() : Object
      {
         // method body index: 599 method index: 599
         return this._data;
      }
      
      protected function get isClickable() : Boolean
      {
         // method body index: 600 method index: 600
         return this.data != null && !(this.data.clickable != null && !this.data.clickable);
      }
      
      public function reset() : void
      {
         // method body index: 602 method index: 602
         this._data = null;
         addEventListener(Event.REMOVED_FROM_STAGE,this.destroy,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler,false,0,true);
      }
      
      public function setData(param1:Object) : *
      {
         // method body index: 603 method index: 603
         this._data = param1;
         if(param1 != null)
         {
            this.setVisual();
         }
      }
      
      protected function setVisual() : void
      {
         // method body index: 604 method index: 604
      }
      
      protected function itemPressHandler(param1:MouseEvent) : void
      {
         // method body index: 605 method index: 605
         if(this.isClickable)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
            addEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler,false,0,true);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_SELECT,{"renderer":this}));
         }
      }
      
      protected function itemReleaseHandler(param1:MouseEvent) : void
      {
         // method body index: 606 method index: 606
         if(this.isClickable)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE,{"renderer":this}));
         }
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         // method body index: 607 method index: 607
         if(mouseY < 0 || mouseY > this.height || mouseX < 0 || mouseX > this.width)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE_OUTSIDE,{"renderer":this}));
         }
      }
      
      public function selectItem() : void
      {
         // method body index: 608 method index: 608
      }
      
      public function unselectItem() : void
      {
         // method body index: 609 method index: 609
      }
      
      public function pressItem() : void
      {
         // method body index: 610 method index: 610
      }
      
      protected function destroy(param1:Event) : void
      {
         // method body index: 611 method index: 611
         removeEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler);
      }
   }
}
