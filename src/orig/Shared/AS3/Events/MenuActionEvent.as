 
package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class MenuActionEvent extends Event
   {
      
      public static const MENU_HOVER:String = // method body index: 236 method index: 236
      "MenuHover";
      
      public static const MENU_ACCEPT:String = // method body index: 236 method index: 236
      "MenuAccept";
      
      public static const MENU_CANCEL:String = // method body index: 236 method index: 236
      "MenuCancel";
      
      public static const ACTION_MULTIACTION:String = // method body index: 236 method index: 236
      "MultiAction";
      
      public static const ACTION_OPENSUBMENU:String = // method body index: 236 method index: 236
      "OpenSubMenu";
      
      public static const ACTION_OPENSECONDARYSUBMENU:String = // method body index: 236 method index: 236
      "OpenSecondarySubMenu";
      
      public static const ACTION_OPENWORLDCARD:String = // method body index: 236 method index: 236
      "OpenWorldCard";
      
      public static const ACTION_JOINFRIENDWORLD:String = // method body index: 236 method index: 236
      "JoinFriendWorld";
      
      public static const ACTION_SENDEVENT:String = // method body index: 236 method index: 236
      "Event";
      
      public static const ACTION_PREVIEWFRIENDLIST:String = // method body index: 236 method index: 236
      "PreviewFriendList";
      
      public static const ACTION_OPENPARTYDROPOUTMENU:String = // method body index: 236 method index: 236
      "OpenPartyDropoutMenu";
      
      public static const ACTION_OPENFRIENDLIST:String = // method body index: 236 method index: 236
      "OpenFriendList";
      
      public static const ACTION_OPENSERVERLIST:String = // method body index: 236 method index: 236
      "OpenServerList";
      
      public static const ACTION_OPENDEBUGBOX:String = // method body index: 236 method index: 236
      "OpenDebugBox";
      
      public static const ACTION_SELECTCHARACTER:String = // method body index: 236 method index: 236
      "CharacterMenu::SelectCharacter";
      
      public static const ACTION_DELETECHARACTER:String = // method body index: 236 method index: 236
      "CharacterMenu::Delete";
      
      public static const ACTION_DELETECHARACTERCONFIRM:String = // method body index: 236 method index: 236
      "CharacterMenu::ConfirmDelete";
      
      public static const ACTION_HOVERCHARACTER:String = // method body index: 236 method index: 236
      "HoverCharacter";
      
      public static const ACTION_OPENQUICKPLAY:String = // method body index: 236 method index: 236
      "OpenQuickPlay";
      
      public static const ACTION_OPENPLAYMODESMENU:String = // method body index: 236 method index: 236
      "OpenPlayModesMenu";
      
      public static const ACTION_OPENCHARACTERMENU:String = // method body index: 236 method index: 236
      "OpenCharacterMenu";
      
      public static const ACTION_OPENSTORE:String = // method body index: 236 method index: 236
      "OpenStore";
      
      public static const ACTION_OPENSEASONMENU:String = // method body index: 236 method index: 236
      "OpenSeasonMenu";
      
      public static const ACTION_OPENPHOTOMODE:String = // method body index: 236 method index: 236
      "OpenPhotoMode";
      
      public static const ACTION_OPENPHOTOGALLERY:String = // method body index: 236 method index: 236
      "OpenPhotoGallery";
      
      public static const ACTION_CHANGEAPPEARANCE:String = // method body index: 236 method index: 236
      "ChangeAppearance";
      
      public static const ACTION_OPENSOCIALMENU:String = // method body index: 236 method index: 236
      "OpenSocial";
      
      public static const ACTION_OPENCHALLENGESMENU:String = // method body index: 236 method index: 236
      "OpenChallengesMenu";
      
      public static const ACTION_NEEDATOMSFORITEM:String = // method body index: 236 method index: 236
      "NeedAtomsForItem";
      
      public static const ACTION_NEEDATOMSFORITEMCONFIRM:String = // method body index: 236 method index: 236
      "NeedAtomsForItemConfirm";
      
      public static const SHOW_SETTINGS:String = // method body index: 236 method index: 236
      "ShowSettings";
       
      
      private var _action:String = "";
      
      private var _data:String = "";
      
      private var _index:Number = 0;
      
      private var _tooltip:String = "";
      
      private var _entryObject:Object = "";
      
      public function MenuActionEvent(type:String, aAction:String, aData:String, aIndex:Number = 0, aTooltip:String = "", aEntry:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         // method body index: 247 method index: 247
         this._action = aAction;
         this._data = aData;
         this._index = aIndex;
         this._tooltip = aTooltip;
         this._entryObject = aEntry;
         super(type,bubbles,cancelable);
      }
      
      public function get Action() : *
      {
         // method body index: 237 method index: 237
         return this._action;
      }
      
      public function set Action(aAction:String) : *
      {
         // method body index: 238 method index: 238
         this._action = aAction;
      }
      
      public function get Data() : *
      {
         // method body index: 239 method index: 239
         return this._data;
      }
      
      public function set Data(aData:String) : *
      {
         // method body index: 240 method index: 240
         this._data = aData;
      }
      
      public function get Index() : *
      {
         // method body index: 241 method index: 241
         return this._index;
      }
      
      public function set Index(aIndex:Number) : *
      {
         // method body index: 242 method index: 242
         this._index = aIndex;
      }
      
      public function get Tooltip() : *
      {
         // method body index: 243 method index: 243
         return this._tooltip;
      }
      
      public function set Tooltip(aTooltip:String) : *
      {
         // method body index: 244 method index: 244
         this._tooltip = aTooltip;
      }
      
      public function get EntryObject() : *
      {
         // method body index: 245 method index: 245
         return this._entryObject;
      }
      
      public function set EntryObject(aEntry:Object) : *
      {
         // method body index: 246 method index: 246
         this._entryObject = aEntry;
      }
      
      override public function clone() : Event
      {
         // method body index: 248 method index: 248
         return new MenuActionEvent(type,this._action,this._data,this._index,this._tooltip,this._entryObject,bubbles,cancelable);
      }
   }
}
