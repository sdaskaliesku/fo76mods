 
package Shared.AS3.Events
{
   import Shared.AS3.IMenu;
   import Shared.AS3.MenuComponent;
   import flash.events.Event;
   
   public final class MenuComponentLoadedEvent extends Event
   {
      
      public static const MENU_COMPONENT_LOADED:String = // method body index: 371 method index: 371
      "MenuComponentLoaded";
       
      
      private var _sender:MenuComponent;
      
      public function MenuComponentLoadedEvent(param1:MenuComponent)
      {

         super(MENU_COMPONENT_LOADED,true,false);
         this._sender = param1;
      }
      
      public function RespondToEvent(param1:IMenu) : *
      {

         this._sender.SetParentMenu(param1);
      }
      
      override public function clone() : Event
      {

         return new MenuComponentLoadedEvent(this._sender);
      }
   }
}
