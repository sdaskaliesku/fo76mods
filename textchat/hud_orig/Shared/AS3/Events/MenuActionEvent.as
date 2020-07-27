 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class MenuActionEvent extends Event
   {
      
      public static const MENU_HOVER:String = // method body index: 418 method index: 418
      "MenuHover";
      
      public static const MENU_ACCEPT:String = // method body index: 418 method index: 418
      "MenuAccept";
      
      public static const MENU_CANCEL:String = // method body index: 418 method index: 418
      "MenuCancel";
      
      public static const ACTION_MULTIACTION:String = // method body index: 418 method index: 418
      "MultiAction";
      
      public static const ACTION_OPENSUBMENU:String = // method body index: 418 method index: 418
      "OpenSubMenu";
      
      public static const ACTION_OPENSECONDARYSUBMENU:String = // method body index: 418 method index: 418
      "OpenSecondarySubMenu";
      
      public static const ACTION_OPENWORLDCARD:String = // method body index: 418 method index: 418
      "OpenWorldCard";
      
      public static const ACTION_JOINFRIENDWORLD:String = // method body index: 418 method index: 418
      "JoinFriendWorld";
      
      public static const ACTION_SENDEVENT:String = // method body index: 418 method index: 418
      "Event";
      
      public static const ACTION_PREVIEWFRIENDLIST:String = // method body index: 418 method index: 418
      "PreviewFriendList";
      
      public static const ACTION_OPENPARTYDROPOUTMENU:String = // method body index: 418 method index: 418
      "OpenPartyDropoutMenu";
      
      public static const ACTION_OPENFRIENDLIST:String = // method body index: 418 method index: 418
      "OpenFriendList";
      
      public static const ACTION_OPENSERVERLIST:String = // method body index: 418 method index: 418
      "OpenServerList";
      
      public static const ACTION_OPENDEBUGBOX:String = // method body index: 418 method index: 418
      "OpenDebugBox";
      
      public static const ACTION_SELECTCHARACTER:String = // method body index: 418 method index: 418
      "CharacterMenu::SelectCharacter";
      
      public static const ACTION_DELETECHARACTER:String = // method body index: 418 method index: 418
      "CharacterMenu::Delete";
      
      public static const ACTION_DELETECHARACTERCONFIRM:String = // method body index: 418 method index: 418
      "CharacterMenu::ConfirmDelete";
      
      public static const ACTION_HOVERCHARACTER:String = // method body index: 418 method index: 418
      "HoverCharacter";
      
      public static const ACTION_OPENQUICKPLAY:String = // method body index: 418 method index: 418
      "OpenQuickPlay";
      
      public static const ACTION_OPENPLAYMODESMENU:String = // method body index: 418 method index: 418
      "OpenPlayModesMenu";
      
      public static const ACTION_OPENCHARACTERMENU:String = // method body index: 418 method index: 418
      "OpenCharacterMenu";
      
      public static const ACTION_OPENSTORE:String = // method body index: 418 method index: 418
      "OpenStore";
      
      public static const ACTION_OPENSEASONMENU:String = // method body index: 418 method index: 418
      "OpenSeasonMenu";
      
      public static const ACTION_OPENPHOTOMODE:String = // method body index: 418 method index: 418
      "OpenPhotoMode";
      
      public static const ACTION_OPENPHOTOGALLERY:String = // method body index: 418 method index: 418
      "OpenPhotoGallery";
      
      public static const ACTION_CHANGEAPPEARANCE:String = // method body index: 418 method index: 418
      "ChangeAppearance";
      
      public static const ACTION_OPENSOCIALMENU:String = // method body index: 418 method index: 418
      "OpenSocial";
      
      public static const ACTION_OPENCHALLENGESMENU:String = // method body index: 418 method index: 418
      "OpenChallengesMenu";
      
      public static const ACTION_NEEDATOMSFORITEM:String = // method body index: 418 method index: 418
      "NeedAtomsForItem";
      
      public static const ACTION_NEEDATOMSFORITEMCONFIRM:String = // method body index: 418 method index: 418
      "NeedAtomsForItemConfirm";
      
      public static const SHOW_SETTINGS:String = // method body index: 418 method index: 418
      "ShowSettings";
       
      
      private var _action:String = "";
      
      private var _data:String = "";
      
      private var _index:Number = 0;
      
      private var _tooltip:String = "";
      
      private var _entryObject:Object = "";
      
      public function MenuActionEvent(type:String, aAction:String, aData:String, aIndex:Number = 0, aTooltip:String = "", aEntry:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         // method body index: 429 method index: 429
         this._action = aAction;
         this._data = aData;
         this._index = aIndex;
         this._tooltip = aTooltip;
         this._entryObject = aEntry;
         super(type,bubbles,cancelable);
      }
      
      public function get Action() : *
      {
         // method body index: 419 method index: 419
         return this._action;
      }
      
      public function set Action(aAction:String) : *
      {
         // method body index: 420 method index: 420
         this._action = aAction;
      }
      
      public function get Data() : *
      {
         // method body index: 421 method index: 421
         return this._data;
      }
      
      public function set Data(aData:String) : *
      {
         // method body index: 422 method index: 422
         this._data = aData;
      }
      
      public function get Index() : *
      {
         // method body index: 423 method index: 423
         return this._index;
      }
      
      public function set Index(aIndex:Number) : *
      {
         // method body index: 424 method index: 424
         this._index = aIndex;
      }
      
      public function get Tooltip() : *
      {
         // method body index: 425 method index: 425
         return this._tooltip;
      }
      
      public function set Tooltip(aTooltip:String) : *
      {
         // method body index: 426 method index: 426
         this._tooltip = aTooltip;
      }
      
      public function get EntryObject() : *
      {
         // method body index: 427 method index: 427
         return this._entryObject;
      }
      
      public function set EntryObject(aEntry:Object) : *
      {
         // method body index: 428 method index: 428
         this._entryObject = aEntry;
      }
      
      override public function clone() : Event
      {
         // method body index: 430 method index: 430
         return new MenuActionEvent(type,this._action,this._data,this._index,this._tooltip,this._entryObject,bubbles,cancelable);
      }
   }
}
