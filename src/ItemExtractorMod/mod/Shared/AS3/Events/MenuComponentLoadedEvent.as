 
package Shared.AS3.Events
{
   import Shared.AS3.IMenu;
   import Shared.AS3.MenuComponent;
   import flash.events.Event;
   
   public final class MenuComponentLoadedEvent extends Event
   {
      
      public static const MENU_COMPONENT_LOADED:String = // method body index: 167 method index: 167
      "MenuComponentLoaded";
       
      
      private var _sender:MenuComponent;
      
      public function MenuComponentLoadedEvent(param1:MenuComponent)
      {
         // method body index: 168 method index: 168
         super(MENU_COMPONENT_LOADED,true,false);
         this._sender = param1;
      }
      
      public function RespondToEvent(param1:IMenu) : *
      {
         // method body index: 169 method index: 169
         this._sender.SetParentMenu(param1);
      }
      
      override public function clone() : Event
      {
         // method body index: 170 method index: 170
         return new MenuComponentLoadedEvent(this._sender);
      }
   }
}
