 
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
         // method body index: 2648 method index: 2648
         super();
      }
      
      public function get data() : Object
      {
         // method body index: 2646 method index: 2646
         return this._data;
      }
      
      protected function get isClickable() : Boolean
      {
         // method body index: 2647 method index: 2647
         return this.data != null && !(this.data.clickable != null && !this.data.clickable);
      }
      
      public function reset() : void
      {
         // method body index: 2649 method index: 2649
         this._data = null;
         addEventListener(Event.REMOVED_FROM_STAGE,this.destroy,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler,false,0,true);
      }
      
      public function setData(data:Object) : *
      {
         // method body index: 2650 method index: 2650
         this._data = data;
         if(data != null)
         {
            this.setVisual();
         }
      }
      
      protected function setVisual() : void
      {
         // method body index: 2651 method index: 2651
      }
      
      protected function itemPressHandler(e:MouseEvent) : void
      {
         // method body index: 2652 method index: 2652
         if(this.isClickable)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
            addEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler,false,0,true);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_SELECT,{"renderer":this}));
         }
      }
      
      protected function itemReleaseHandler(e:MouseEvent) : void
      {
         // method body index: 2653 method index: 2653
         if(this.isClickable)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE,{"renderer":this}));
         }
      }
      
      protected function onEnterFrame(e:Event) : void
      {
         // method body index: 2654 method index: 2654
         if(mouseY < 0 || mouseY > this.height || mouseX < 0 || mouseX > this.width)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            removeEventListener(MouseEvent.MOUSE_UP,this.itemReleaseHandler);
            this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE_OUTSIDE,{"renderer":this}));
         }
      }
      
      public function selectItem() : void
      {
         // method body index: 2655 method index: 2655
      }
      
      public function unselectItem() : void
      {
         // method body index: 2656 method index: 2656
      }
      
      public function pressItem() : void
      {
         // method body index: 2657 method index: 2657
      }
      
      protected function destroy(e:Event) : void
      {
         // method body index: 2658 method index: 2658
         removeEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.itemPressHandler);
      }
   }
}
