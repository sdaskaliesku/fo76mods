 
package Shared.AS3.Events
{
   import Shared.AS3.IMenu;
   import Shared.AS3.MenuComponent;
   import flash.events.Event;
   
   public final class MenuComponentLoadedEvent extends Event
   {
      
      public static const MENU_COMPONENT_LOADED:String = // method body index: 201 method index: 201
      "MenuComponentLoaded";
       
      
      private var _sender:MenuComponent;
      
      public function MenuComponentLoadedEvent(aSender:MenuComponent)
      {
         // method body index: 202 method index: 202
         super(MENU_COMPONENT_LOADED,true,false);
         this._sender = aSender;
      }
      
      public function RespondToEvent(aParentMenu:IMenu) : *
      {
         // method body index: 203 method index: 203
         this._sender.SetParentMenu(aParentMenu);
      }
      
      override public function clone() : Event
      {
         // method body index: 204 method index: 204
         return new MenuComponentLoadedEvent(this._sender);
      }
   }
}
