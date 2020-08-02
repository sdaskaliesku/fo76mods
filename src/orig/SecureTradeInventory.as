 
package
{
   import Shared.AS3.MenuComponent;
   import Shared.AS3.SWFLoaderClip;
   import Shared.AS3.SecureTradeShared;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class SecureTradeInventory extends MenuComponent
   {
      
      public static const MOUSE_OVER:String = // method body index: 1694 method index: 1694
      "SecureTradeInventory::MouseOver";
       
      
      public var ItemList_mc:MenuListComponent;
      
      public var Header_mc:MovieClip;
      
      public var CurrencyIcon_mc:SWFLoaderClip;
      
      private var m_CurrencyIconInstance:MovieClip;
      
      public function SecureTradeInventory()
      {
         // method body index: 1696 method index: 1696
         super();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         TextFieldEx.setTextAutoSize(this.Header_mc.Header_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.CurrencyIcon_mc.clipWidth = this.CurrencyIcon_mc.width * (1 / this.CurrencyIcon_mc.scaleX);
         this.CurrencyIcon_mc.clipHeight = this.CurrencyIcon_mc.height * (1 / this.CurrencyIcon_mc.scaleY);
      }
      
      public function set header(aHeader:String) : void
      {
         // method body index: 1695 method index: 1695
         this.Header_mc.Header_tf.text = aHeader;
      }
      
      private function onMouseOver(event:MouseEvent) : *
      {
         // method body index: 1697 method index: 1697
         dispatchEvent(new Event(MOUSE_OVER,true,true));
      }
      
      override public function set Active(aActive:*) : void
      {
         // method body index: 1698 method index: 1698
         connectButtonBar();
         _active = aActive;
         this.ItemList_mc.Active = aActive;
      }
      
      public function get selectedItemIndex() : Number
      {
         // method body index: 1699 method index: 1699
         return this.ItemList_mc.selectedIndex;
      }
      
      public function set selectedItemIndex(aIndex:Number) : *
      {
         // method body index: 1700 method index: 1700
         this.ItemList_mc.setSelectedIndex(aIndex);
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1701 method index: 1701
         var secureTradeParent:SecureTrade = this.parent as SecureTrade;
         var currencyType:uint = SecureTradeShared.CURRENCY_CAPS;
         if(secureTradeParent)
         {
            currencyType = secureTradeParent.currencyType;
            if(this.m_CurrencyIconInstance != null)
            {
               this.CurrencyIcon_mc.removeChild(this.m_CurrencyIconInstance);
               this.m_CurrencyIconInstance = null;
            }
            this.m_CurrencyIconInstance = SecureTradeShared.setCurrencyIcon(this.CurrencyIcon_mc,currencyType);
         }
      }
   }
}
