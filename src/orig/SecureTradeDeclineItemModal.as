 
package
{
   import Shared.AS3.BCBasicMenu;
   import Shared.AS3.BCBasicMenuItem;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class SecureTradeDeclineItemModal extends BCBasicMenu
   {
      
      public static const REJECT_REASONS:Array = // method body index: 1857 method index: 1857
      ["DontWant","DontWantType","NotEnoughCaps","PriceTooHigh","MoreOfThis","LessOfThis"];
      
      public static const CONFIRM:String = // method body index: 1857 method index: 1857
      "DeclineItemModal::declineConfirm";
      
      public static const ROWS:Number = // method body index: 1857 method index: 1857
      2;
      
      public static const COLUMNS:Number = // method body index: 1857 method index: 1857
      3;
       
      
      public var DeclineButtons_mc:MovieClip;
      
      public var Header_mc:MovieClip;
      
      public var Tooltip_mc:MovieClip;
      
      public var ItemServerHandleId:Number = 0;
      
      public function SecureTradeDeclineItemModal()
      {
         // method body index: 1865 method index: 1865
         mouseEnabled = false;
         mouseChildren = false;
         m_Horizontal = true;
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         super();
      }
      
      override protected function setActive(aActive:Boolean) : void
      {
         // method body index: 1858 method index: 1858
         super.setActive(aActive);
         if(aActive != _active)
         {
            if(aActive)
            {
               gotoAndPlay("rollOn");
            }
            else
            {
               gotoAndPlay("rollOff");
            }
            mouseEnabled = aActive;
            mouseChildren = aActive;
         }
      }
      
      override protected function onItemPress() : *
      {
         // method body index: 1859 method index: 1859
         dispatchEvent(new Event(CONFIRM,true,true));
      }
      
      override public function onKeyDown(event:KeyboardEvent) : *
      {
         // method body index: 1860 method index: 1860
         if(event.keyCode == Keyboard.UP)
         {
            this.selectVerticalDelta(-1);
            event.stopPropagation();
         }
         else if(event.keyCode == Keyboard.DOWN)
         {
            this.selectVerticalDelta(1);
            event.stopPropagation();
         }
         else if(event.keyCode == Keyboard.LEFT)
         {
            this.selectHorizontalDelta(-1);
            event.stopPropagation();
         }
         else if(event.keyCode == Keyboard.RIGHT)
         {
            this.selectHorizontalDelta(1);
            event.stopPropagation();
         }
      }
      
      private function selectVerticalDelta(delta:int) : void
      {
         // method body index: 1861 method index: 1861
         selectedIndex = this.clampIndex(selectedIndex + delta * COLUMNS);
      }
      
      private function selectHorizontalDelta(delta:int) : void
      {
         // method body index: 1862 method index: 1862
         selectedIndex = this.clampIndex(selectedIndex + delta);
      }
      
      private function clampIndex(index:int) : int
      {
         // method body index: 1863 method index: 1863
         var result:int = index;
         if(index < 0)
         {
            result = 0;
         }
         else if(index > m_Entries.length - 1)
         {
            result = selectedIndex;
         }
         return result;
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1864 method index: 1864
         super.onAddedToStage();
         this.Header_mc.textField.text = "$DeclineItem";
         this.Tooltip_mc.textField.text = "$DeclineItemSetReason";
         for(var i:uint = 0; i < REJECT_REASONS.length; i++)
         {
            addItem(this.DeclineButtons_mc["ReasonButton_" + REJECT_REASONS[i]] as BCBasicMenuItem);
         }
      }
   }
}
