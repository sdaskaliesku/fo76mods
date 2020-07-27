 
package Shared.AS3.Events
{
   import Shared.AS3.IMenu;
   import Shared.AS3.MenuComponent;
   import flash.events.Event;
   
   public final class MenuComponentLoadedEvent extends Event
   {
      
      public static const MENU_COMPONENT_LOADED:String = // method body index: 374 method index: 374
      "MenuComponentLoaded";
       
      
      private var _sender:MenuComponent;
      
      public function MenuComponentLoadedEvent(aSender:MenuComponent)
      {
         // method body index: 375 method index: 375
         super(MENU_COMPONENT_LOADED,true,false);
         this._sender = aSender;
      }
      
      public function RespondToEvent(aParentMenu:IMenu) : *
      {
         // method body index: 376 method index: 376
         this._sender.SetParentMenu(aParentMenu);
      }
      
      override public function clone() : Event
      {
         // method body index: 377 method index: 377
         return new MenuComponentLoadedEvent(this._sender);
      }
   }
}
