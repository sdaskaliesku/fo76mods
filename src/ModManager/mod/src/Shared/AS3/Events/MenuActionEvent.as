package Shared.AS3.Events
{
import flash.events.Event;

public class MenuActionEvent extends Event
{

    public static const MENU_HOVER:String = "MenuHover";

    public static const MENU_ACCEPT:String = "MenuAccept";

    public static const MENU_CANCEL:String = "MenuCancel";

    public static const ACTION_MULTIACTION:String = "MultiAction";

    public static const ACTION_OPENSUBMENU:String = "OpenSubMenu";

    public static const ACTION_OPENSECONDARYSUBMENU:String = "OpenSecondarySubMenu";

    public static const ACTION_OPENWORLDCARD:String = "OpenWorldCard";

    public static const ACTION_JOINFRIENDWORLD:String = "JoinFriendWorld";

    public static const ACTION_SENDEVENT:String = "Event";

    public static const ACTION_PREVIEWFRIENDLIST:String = "PreviewFriendList";

    public static const ACTION_OPENPARTYDROPOUTMENU:String = "OpenPartyDropoutMenu";

    public static const ACTION_OPENFRIENDLIST:String = "OpenFriendList";

    public static const ACTION_OPENSERVERLIST:String = "OpenServerList";

    public static const ACTION_OPENDEBUGBOX:String = "OpenDebugBox";

    public static const ACTION_SELECTCHARACTER:String = "CharacterMenu::SelectCharacter";

    public static const ACTION_DELETECHARACTER:String = "CharacterMenu::Delete";

    public static const ACTION_DELETECHARACTERCONFIRM:String = "CharacterMenu::ConfirmDelete";

    public static const ACTION_HOVERCHARACTER:String = "HoverCharacter";

    public static const ACTION_OPENQUICKPLAY:String = "OpenQuickPlay";

    public static const ACTION_OPENPLAYMODESMENU:String = "OpenPlayModesMenu";

    public static const ACTION_OPENCHARACTERMENU:String = "OpenCharacterMenu";

    public static const ACTION_OPENSTORE:String = "OpenStore";

    public static const ACTION_OPENSEASONMENU:String = "OpenSeasonMenu";

    public static const ACTION_OPENPHOTOMODE:String = "OpenPhotoMode";

    public static const ACTION_OPENPHOTOGALLERY:String = "OpenPhotoGallery";

    public static const ACTION_CHANGEAPPEARANCE:String = "ChangeAppearance";

    public static const ACTION_OPENSOCIALMENU:String = "OpenSocial";

    public static const ACTION_OPENCHALLENGESMENU:String = "OpenChallengesMenu";

    public static const ACTION_NEEDATOMSFORITEM:String = "NeedAtomsForItem";

    public static const ACTION_NEEDATOMSFORITEMCONFIRM:String = "NeedAtomsForItemConfirm";

    public static const SHOW_SETTINGS:String = "ShowSettings";


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

    public function set Action(param1:String) : void
    {
        this._action = param1;
    }

    public function get Data() : *
    {
        return this._data;
    }

    public function set Data(param1:String) : void
    {
        this._data = param1;
    }

    public function get Index() : *
    {
        return this._index;
    }

    public function set Index(param1:Number) : void
    {
        this._index = param1;
    }

    public function get Tooltip() : *
    {
        return this._tooltip;
    }

    public function set Tooltip(param1:String) : void
    {
        this._tooltip = param1;
    }

    public function get EntryObject() : *
    {
        return this._entryObject;
    }

    public function set EntryObject(param1:Object) : void
    {
        this._entryObject = param1;
    }

    override public function clone() : Event
    {
        return new MenuActionEvent(type,this._action,this._data,this._index,this._tooltip,this._entryObject,bubbles,cancelable);
    }
}
}
