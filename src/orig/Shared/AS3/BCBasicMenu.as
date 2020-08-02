 
package Shared.AS3
{
   import Shared.AS3.Events.MenuActionEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   
   public class BCBasicMenu extends MenuComponent
   {
      
      public static const SELECTION_CHANGE:String = // method body index: 1752 method index: 1752
      "BSScrollingList::selectionChange";
      
      public static const ITEM_PRESS:String = // method body index: 1752 method index: 1752
      "BSScrollingList::itemPress";
      
      public static const LIST_PRESS:String = // method body index: 1752 method index: 1752
      "BSScrollingList::listPress";
      
      public static const LIST_ITEMS_CREATED:String = // method body index: 1752 method index: 1752
      "BSScrollingList::listItemsCreated";
      
      public static const PLAY_FOCUS_SOUND:String = // method body index: 1752 method index: 1752
      "BSScrollingList::playFocusSound";
       
      
      public var Backer_mc:MovieClip;
      
      protected var m_Entries:Vector.<BCBasicMenuItem>;
      
      private var m_DisableInput:Boolean = false;
      
      private var m_DisableSelection:Boolean = false;
      
      private var m_SelectedIndex:int = -1;
      
      private var m_StoredSelectedIndex:int = 0;
      
      protected var m_Horizontal:Boolean = false;
      
      protected var m_SaveSelection:Boolean = false;
      
      private var m_ButtonPressAction:Function;
      
      private var m_AcceptButton:BSButtonHintData;
      
      private var m_CancelButton:BSButtonHintData;
      
      public function BCBasicMenu()
      {
         // method body index: 1773 method index: 1773
         this.m_AcceptButton = new BSButtonHintData("$ACCEPT","Enter","PSN_A","Xenon_A",1,this.onItemPress);
         this.m_CancelButton = new BSButtonHintData("$CANCEL","Esc","PSN_B","Xenon_B",1,this.onMenuCancel);
         super();
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         this.m_Entries = new Vector.<BCBasicMenuItem>();
      }
      
      protected function setActive(aActive:Boolean) : void
      {
         // method body index: 1753 method index: 1753
         if(aActive != _active)
         {
            if(aActive)
            {
               if(this.m_SaveSelection)
               {
                  this.selectedIndex = this.m_StoredSelectedIndex;
               }
               else
               {
                  this.selectedIndex = 0;
               }
            }
            else
            {
               this.m_StoredSelectedIndex = this.m_SelectedIndex;
               this.selectedIndex = -1;
            }
         }
      }
      
      override public function set Active(aActive:*) : void
      {
         // method body index: 1754 method index: 1754
         this.setActive(aActive);
         connectButtonBar();
         _active = aActive;
      }
      
      public function get selectedIndex() : int
      {
         // method body index: 1755 method index: 1755
         if(_active)
         {
            return this.m_SelectedIndex;
         }
         return this.m_StoredSelectedIndex;
      }
      
      public function set selectedIndex(aIndex:int) : void
      {
         // method body index: 1756 method index: 1756
         if(this.m_SelectedIndex != aIndex)
         {
            this.m_SelectedIndex = aIndex;
            this.updateSelection();
         }
      }
      
      private function clampIndex(aIndex:*) : int
      {
         // method body index: 1757 method index: 1757
         return Math.max(0,Math.min(aIndex,this.m_Entries.length - 1));
      }
      
      public function selectIncrease() : *
      {
         // method body index: 1758 method index: 1758
         this.selectedIndex = this.clampIndex(this.selectedIndex + 1);
      }
      
      public function selectDecrease() : *
      {
         // method body index: 1759 method index: 1759
         this.selectedIndex = this.clampIndex(this.selectedIndex - 1);
      }
      
      public function onKeyDown(event:KeyboardEvent) : *
      {
         // method body index: 1760 method index: 1760
         var keyPrev:uint = 0;
         var keyNext:uint = 0;
         if(!this.m_DisableInput)
         {
            keyPrev = Keyboard.UP;
            keyNext = Keyboard.DOWN;
            if(this.m_Horizontal)
            {
               keyPrev = Keyboard.LEFT;
               keyNext = Keyboard.RIGHT;
            }
            if(event.keyCode == keyPrev)
            {
               this.selectDecrease();
               event.stopPropagation();
            }
            else if(event.keyCode == keyNext)
            {
               this.selectIncrease();
               event.stopPropagation();
            }
         }
      }
      
      public function onKeyUp(event:KeyboardEvent) : *
      {
         // method body index: 1761 method index: 1761
         if(!this.m_DisableInput && !this.m_DisableSelection && event.keyCode == Keyboard.ENTER)
         {
            this.onItemPress();
            event.stopPropagation();
         }
      }
      
      private function updateSelection() : void
      {
         // method body index: 1762 method index: 1762
         for(var i:uint = 0; i < this.m_Entries.length; i++)
         {
            this.m_Entries[i].selected = this.m_SelectedIndex == i;
         }
      }
      
      public function onEntryRollover(event:Event) : *
      {
         // method body index: 1763 method index: 1763
         var prevSelection:* = undefined;
         if(!this.m_DisableInput && !this.m_DisableSelection)
         {
            prevSelection = this.m_SelectedIndex;
            this.selectedIndex = (event.currentTarget as BCBasicMenuItem).index;
            if(prevSelection != this.m_SelectedIndex)
            {
               dispatchEvent(new Event(PLAY_FOCUS_SOUND,true,true));
            }
         }
      }
      
      public function onEntryPress(event:MouseEvent) : *
      {
         // method body index: 1764 method index: 1764
         event.stopPropagation();
         this.onItemPress();
      }
      
      public function addItem(aItem:BCBasicMenuItem) : void
      {
         // method body index: 1765 method index: 1765
         aItem.addEventListener(MouseEvent.MOUSE_OVER,this.onEntryRollover);
         aItem.addEventListener(MouseEvent.CLICK,this.onEntryPress);
         aItem.index = this.m_Entries.length;
         this.m_Entries.push(aItem);
      }
      
      public function set buttonPressAction(aAction:Function) : *
      {
         // method body index: 1766 method index: 1766
         this.m_ButtonPressAction = aAction;
      }
      
      protected function onItemPress() : *
      {
         // method body index: 1767 method index: 1767
      }
      
      private function setFocusUnderMouse() : void
      {
         // method body index: 1768 method index: 1768
         var testPoint:Point = null;
         for(var i:uint = 0; i < this.m_Entries.length; i++)
         {
            testPoint = localToGlobal(new Point(mouseX,mouseY));
            if(this.m_Entries[i].hitTestPoint(testPoint.x,testPoint.y,false))
            {
               this.selectedIndex = i;
            }
         }
      }
      
      public function onMouseWheel(event:MouseEvent) : *
      {
         // method body index: 1769 method index: 1769
         if(event.delta < 0)
         {
            this.selectIncrease();
         }
         else if(event.delta > 0)
         {
            this.selectDecrease();
         }
         this.setFocusUnderMouse();
         event.stopPropagation();
      }
      
      public function onFocusIn(e:FocusEvent) : void
      {
         // method body index: 1770 method index: 1770
      }
      
      private function onMenuCancel(event:Event = null) : *
      {
         // method body index: 1771 method index: 1771
         if(this.m_CancelButton.ButtonVisible && this.m_CancelButton.ButtonEnabled)
         {
            dispatchEvent(new MenuActionEvent(MenuActionEvent.MENU_CANCEL,null,null));
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1772 method index: 1772
         super.onAddedToStage();
         this.focusRect = false;
         buttonData.push(this.m_AcceptButton);
         buttonData.push(this.m_CancelButton);
         connectButtonBar();
      }
      
      public function collapse() : void
      {
         // method body index: 1774 method index: 1774
      }
      
      public function expand() : void
      {
         // method body index: 1775 method index: 1775
      }
   }
}
