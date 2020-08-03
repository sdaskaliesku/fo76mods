package Shared.AS3.Events 
{
    import flash.events.*;
    
    public class PlatformChangeEvent extends flash.events.Event
    {
        public function PlatformChangeEvent(arg1:uint, arg2:Boolean, arg3:uint, arg4:uint)
        {
            super(PLATFORM_CHANGE, true, true);
            this.uiPlatform = arg1;
            this.bPS3Switch = arg2;
            this.uiController = arg3;
            this.uiKeyboard = arg4;
            return;
        }

        public function get uiPlatform():*
        {
            return this._uiPlatform;
        }

        public function set uiPlatform(arg1:uint):*
        {
            this._uiPlatform = arg1;
            return;
        }

        public function get bPS3Switch():*
        {
            return this._bPS3Switch;
        }

        public function set bPS3Switch(arg1:Boolean):*
        {
            this._bPS3Switch = arg1;
            return;
        }

        public function get uiController():*
        {
            return this._uiController;
        }

        public function set uiController(arg1:uint):*
        {
            this._uiController = arg1;
            return;
        }

        public function get uiKeyboard():*
        {
            return this._uiKeyboard;
        }

        public function set uiKeyboard(arg1:uint):*
        {
            this._uiKeyboard = arg1;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new Shared.AS3.Events.PlatformChangeEvent(this.uiPlatform, this.bPS3Switch, this.uiController, this.uiKeyboard);
        }

        public static const PLATFORM_PC_KB_MOUSE:uint=0;

        public static const PLATFORM_PC_GAMEPAD:uint=1;

        public static const PLATFORM_XB1:uint=2;

        public static const PLATFORM_PS4:uint=3;

        public static const PLATFORM_MOBILE:uint=4;

        public static const PLATFORM_INVALID:uint=uint.MAX_VALUE;

        public static const PLATFORM_PC_KB_ENG:uint=0;

        public static const PLATFORM_PC_KB_FR:uint=1;

        public static const PLATFORM_PC_KB_BE:uint=2;

        public static const PLATFORM_CHANGE:String="SetPlatform";

        var _uiPlatform:uint=4294967295;

        var _bPS3Switch:Boolean=false;

        var _uiController:uint=4294967295;

        var _uiKeyboard:uint=4294967295;
    }
}
