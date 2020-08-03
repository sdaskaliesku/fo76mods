package Shared.AS3.Events 
{
    import flash.events.*;
    
    public class MenuActionEvent extends flash.events.Event
    {
        public function MenuActionEvent(arg1:String, arg2:String, arg3:String, arg4:Number=0, arg5:String="", arg6:Object=null, arg7:Boolean=false, arg8:Boolean=false)
        {
            this._action = arg2;
            this._data = arg3;
            this._index = arg4;
            this._tooltip = arg5;
            this._entryObject = arg6;
            super(arg1, arg7, arg8);
            return;
        }

        public function get Tooltip():*
        {
            return this._tooltip;
        }

        public function set Tooltip(arg1:String):*
        {
            this._tooltip = arg1;
            return;
        }

        public function get EntryObject():*
        {
            return this._entryObject;
        }

        public function set EntryObject(arg1:Object):*
        {
            this._entryObject = arg1;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new Shared.AS3.Events.MenuActionEvent(type, this._action, this._data, this._index, this._tooltip, this._entryObject, bubbles, cancelable);
        }

        public function get Action():*
        {
            return this._action;
        }

        public function set Action(arg1:String):*
        {
            this._action = arg1;
            return;
        }

        public function get Data():*
        {
            return this._data;
        }

        public function set Data(arg1:String):*
        {
            this._data = arg1;
            return;
        }

        public function get Index():*
        {
            return this._index;
        }

        public function set Index(arg1:Number):*
        {
            this._index = arg1;
            return;
        }

        public static const ACTION_OPENSOCIALMENU:String="OpenSocial";

        public static const ACTION_OPENCHALLENGESMENU:String="OpenChallengesMenu";

        public static const ACTION_NEEDATOMSFORITEM:String="NeedAtomsForItem";

        public static const ACTION_NEEDATOMSFORITEMCONFIRM:String="NeedAtomsForItemConfirm";

        public static const SHOW_SETTINGS:String="ShowSettings";

        public static const MENU_HOVER:String="MenuHover";

        public static const MENU_ACCEPT:String="MenuAccept";

        public static const MENU_CANCEL:String="MenuCancel";

        public static const ACTION_MULTIACTION:String="MultiAction";

        public static const ACTION_OPENSUBMENU:String="OpenSubMenu";

        public static const ACTION_OPENSECONDARYSUBMENU:String="OpenSecondarySubMenu";

        public static const ACTION_OPENWORLDCARD:String="OpenWorldCard";

        public static const ACTION_JOINFRIENDWORLD:String="JoinFriendWorld";

        public static const ACTION_SENDEVENT:String="Event";

        public static const ACTION_PREVIEWFRIENDLIST:String="PreviewFriendList";

        public static const ACTION_OPENPARTYDROPOUTMENU:String="OpenPartyDropoutMenu";

        public static const ACTION_OPENFRIENDLIST:String="OpenFriendList";

        public static const ACTION_OPENSERVERLIST:String="OpenServerList";

        public static const ACTION_OPENDEBUGBOX:String="OpenDebugBox";

        public static const ACTION_SELECTCHARACTER:String="CharacterMenu::SelectCharacter";

        public static const ACTION_DELETECHARACTER:String="CharacterMenu::Delete";

        public static const ACTION_DELETECHARACTERCONFIRM:String="CharacterMenu::ConfirmDelete";

        public static const ACTION_HOVERCHARACTER:String="HoverCharacter";

        public static const ACTION_OPENQUICKPLAY:String="OpenQuickPlay";

        public static const ACTION_OPENPLAYMODESMENU:String="OpenPlayModesMenu";

        public static const ACTION_OPENCHARACTERMENU:String="OpenCharacterMenu";

        public static const ACTION_OPENSTORE:String="OpenStore";

        public static const ACTION_OPENSEASONMENU:String="OpenSeasonMenu";

        public static const ACTION_OPENPHOTOMODE:String="OpenPhotoMode";

        public static const ACTION_OPENPHOTOGALLERY:String="OpenPhotoGallery";

        public static const ACTION_CHANGEAPPEARANCE:String="ChangeAppearance";

        internal var _action:String="";

        internal var _data:String="";

        internal var _index:Number=0;

        internal var _tooltip:String="";

        internal var _entryObject:Object="";
    }
}
