 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class MenuActionEvent extends Event
   {
      
      public static const MENU_HOVER:String = // method body index: 415 method index: 415
      "MenuHover";
      
      public static const MENU_ACCEPT:String = // method body index: 415 method index: 415
      "MenuAccept";
      
      public static const MENU_CANCEL:String = // method body index: 415 method index: 415
      "MenuCancel";
      
      public static const ACTION_MULTIACTION:String = // method body index: 415 method index: 415
      "MultiAction";
      
      public static const ACTION_OPENSUBMENU:String = // method body index: 415 method index: 415
      "OpenSubMenu";
      
      public static const ACTION_OPENSECONDARYSUBMENU:String = // method body index: 415 method index: 415
      "OpenSecondarySubMenu";
      
      public static const ACTION_OPENWORLDCARD:String = // method body index: 415 method index: 415
      "OpenWorldCard";
      
      public static const ACTION_JOINFRIENDWORLD:String = // method body index: 415 method index: 415
      "JoinFriendWorld";
      
      public static const ACTION_SENDEVENT:String = // method body index: 415 method index: 415
      "Event";
      
      public static const ACTION_PREVIEWFRIENDLIST:String = // method body index: 415 method index: 415
      "PreviewFriendList";
      
      public static const ACTION_OPENPARTYDROPOUTMENU:String = // method body index: 415 method index: 415
      "OpenPartyDropoutMenu";
      
      public static const ACTION_OPENFRIENDLIST:String = // method body index: 415 method index: 415
      "OpenFriendList";
      
      public static const ACTION_OPENSERVERLIST:String = // method body index: 415 method index: 415
      "OpenServerList";
      
      public static const ACTION_OPENDEBUGBOX:String = // method body index: 415 method index: 415
      "OpenDebugBox";
      
      public static const ACTION_SELECTCHARACTER:String = // method body index: 415 method index: 415
      "CharacterMenu::SelectCharacter";
      
      public static const ACTION_DELETECHARACTER:String = // method body index: 415 method index: 415
      "CharacterMenu::Delete";
      
      public static const ACTION_DELETECHARACTERCONFIRM:String = // method body index: 415 method index: 415
      "CharacterMenu::ConfirmDelete";
      
      public static const ACTION_HOVERCHARACTER:String = // method body index: 415 method index: 415
      "HoverCharacter";
      
      public static const ACTION_OPENQUICKPLAY:String = // method body index: 415 method index: 415
      "OpenQuickPlay";
      
      public static const ACTION_OPENPLAYMODESMENU:String = // method body index: 415 method index: 415
      "OpenPlayModesMenu";
      
      public static const ACTION_OPENCHARACTERMENU:String = // method body index: 415 method index: 415
      "OpenCharacterMenu";
      
      public static const ACTION_OPENSTORE:String = // method body index: 415 method index: 415
      "OpenStore";
      
      public static const ACTION_OPENSEASONMENU:String = // method body index: 415 method index: 415
      "OpenSeasonMenu";
      
      public static const ACTION_OPENPHOTOMODE:String = // method body index: 415 method index: 415
      "OpenPhotoMode";
      
      public static const ACTION_OPENPHOTOGALLERY:String = // method body index: 415 method index: 415
      "OpenPhotoGallery";
      
      public static const ACTION_CHANGEAPPEARANCE:String = // method body index: 415 method index: 415
      "ChangeAppearance";
      
      public static const ACTION_OPENSOCIALMENU:String = // method body index: 415 method index: 415
      "OpenSocial";
      
      public static const ACTION_OPENCHALLENGESMENU:String = // method body index: 415 method index: 415
      "OpenChallengesMenu";
      
      public static const ACTION_NEEDATOMSFORITEM:String = // method body index: 415 method index: 415
      "NeedAtomsForItem";
      
      public static const ACTION_NEEDATOMSFORITEMCONFIRM:String = // method body index: 415 method index: 415
      "NeedAtomsForItemConfirm";
      
      public static const SHOW_SETTINGS:String = // method body index: 415 method index: 415
      "ShowSettings";
       
      
      private var _action:String = "";
      
      private var _data:String = "";
      
      private var _index:Number = 0;
      
      private var _tooltip:String = "";
      
      private var _entryObject:Object = "";
      
      public function MenuActionEvent(param1:String, param2:String, param3:String, param4:Number = 0, param5:String = "", param6:Object = null, param7:Boolean = false, param8:Boolean = false)
      {

         this._action = param2;
         this._data = param3;
         this._index = param4;
         this._tooltip = param5;
         this._entryObject = param6;
         super(param1,param7,param8);
      }
      
      public function get Action() : *
      {

         return this._action;
      }
      
      public function set Action(param1:String) : *
      {

         this._action = param1;
      }
      
      public function get Data() : *
      {

         return this._data;
      }
      
      public function set Data(param1:String) : *
      {

         this._data = param1;
      }
      
      public function get Index() : *
      {

         return this._index;
      }
      
      public function set Index(param1:Number) : *
      {

         this._index = param1;
      }
      
      public function get Tooltip() : *
      {

         return this._tooltip;
      }
      
      public function set Tooltip(param1:String) : *
      {

         this._tooltip = param1;
      }
      
      public function get EntryObject() : *
      {

         return this._entryObject;
      }
      
      public function set EntryObject(param1:Object) : *
      {

         this._entryObject = param1;
      }
      
      override public function clone() : Event
      {

         return new MenuActionEvent(type,this._action,this._data,this._index,this._tooltip,this._entryObject,bubbles,cancelable);
      }
   }
}
