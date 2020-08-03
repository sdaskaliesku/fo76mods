package Shared.AS3 
{
    import Shared.*;
    import Shared.AS3.Data.*;
    import Shared.AS3.Events.*;
    import fl.motion.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    
    public class IMenu extends Shared.AS3.BSDisplayObject
    {
        public function IMenu()
        {
            this.textFieldSizeMap = new Object();
            this.colorFilter = new fl.motion.AdjustColor();
            this.mMatrix = [];
            super();
            this._uiPlatform = Shared.AS3.Events.PlatformChangeEvent.PLATFORM_INVALID;
            this._bPS3Switch = false;
            this._bRestoreLostFocus = false;
            this._bNuclearWinterMode = false;
            Shared.GlobalFunc.MaintainTextFormat();
            addEventListener(Shared.AS3.Events.PlatformRequestEvent.PLATFORM_REQUEST, this.onPlatformRequestEvent, true);
            return;
        }

        public override function onAddedToStage():void
        {
            var menu:*;

            var loc1:*;
            menu = undefined;
            stage.stageFocusRect = false;
            stage.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onFocusLostEvent);
            stage.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.onMouseFocusEvent);
            stage.addEventListener(Shared.AS3.Events.MenuComponentLoadedEvent.MENU_COMPONENT_LOADED, this.OnMenuComponentLoadedEvent);
            menu = this;
            Shared.AS3.Data.BSUIDataManager.Subscribe("HUDColors", function (arg1:Shared.AS3.Data.FromClientDataEvent):*
            {
                if (!overrideColors) 
                {
                    return;
                }
                var loc1:*=arg1.data;
                if (loc1.hue == 0 && loc1.saturation == 0 && loc1.value == 0 && loc1.contrast == 0) 
                {
                    menu.filters = null;
                }
                else 
                {
                    colorFilter = new fl.motion.AdjustColor();
                    colorFilter.hue = loc1.hue;
                    colorFilter.saturation = loc1.saturation;
                    colorFilter.brightness = loc1.value;
                    colorFilter.contrast = loc1.contrast;
                    mMatrix = colorFilter.CalculateFinalFlatArray();
                    mColorMatrix = new flash.filters.ColorMatrixFilter(mMatrix);
                    menu.filters = [mColorMatrix];
                }
                return;
            })
            return;
        }

        public override function onRemovedFromStage():void
        {
            stage.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onFocusLostEvent);
            stage.removeEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.onMouseFocusEvent);
            stage.removeEventListener(Shared.AS3.Events.MenuComponentLoadedEvent.MENU_COMPONENT_LOADED, this.OnMenuComponentLoadedEvent);
            return;
        }

        internal function OnMenuComponentLoadedEvent(arg1:Shared.AS3.Events.MenuComponentLoadedEvent):*
        {
            arg1.RespondToEvent(this);
            return;
        }

        public function SetPlatform(arg1:uint, arg2:Boolean, arg3:uint, arg4:uint):*
        {
            this._uiPlatform = arg1;
            this._bPS3Switch = this.bPS3Switch;
            this._uiController = arg3;
            this._uiKeyboard = arg4;
            dispatchEvent(new Shared.AS3.Events.PlatformChangeEvent(this.uiPlatform, this.bPS3Switch, this.uiController, this.uiKeyboard));
            return;
        }

        public function SetNuclearWinterMode(arg1:Boolean):*
        {
            this._bNuclearWinterMode = arg1;
            return;
        }

        public function SetSafeRect(arg1:Number, arg2:Number):*
        {
            this.safeX = arg1;
            this.safeY = arg2;
            this.onSetSafeRect();
            return;
        }

        protected function onSetSafeRect():void
        {
            return;
        }

        internal function onFocusLostEvent(arg1:flash.events.FocusEvent):*
        {
            if (this._bRestoreLostFocus) 
            {
                this._bRestoreLostFocus = false;
                stage.focus = arg1.target as flash.display.InteractiveObject;
            }
            this.onFocusLost(arg1);
            return;
        }

        public function onFocusLost(arg1:flash.events.FocusEvent):*
        {
            return;
        }

        protected function onMouseFocusEvent(arg1:flash.events.FocusEvent):*
        {
            if (arg1.target == null || !(arg1.target is flash.display.InteractiveObject)) 
            {
                stage.focus = null;
            }
            else 
            {
                this._bRestoreLostFocus = true;
            }
            return;
        }

        public function ShrinkFontToFit(arg1:flash.text.TextField, arg2:int):*
        {
            var loc3:*=0;
            var loc1:*=arg1.getTextFormat();
            if (this.textFieldSizeMap[arg1] == null) 
            {
                this.textFieldSizeMap[arg1] = loc1.size;
            }
            loc1.size = this.textFieldSizeMap[arg1];
            arg1.setTextFormat(loc1);
            var loc2:*=arg1.maxScrollV;
            while (loc2 > arg2 && loc1.size > 4) 
            {
                loc3 = loc1.size as int;
                loc1.size = (loc3 - 1);
                arg1.setTextFormat(loc1);
                loc2 = arg1.maxScrollV;
            }
            return;
        }

        public function get uiPlatform():uint
        {
            return this._uiPlatform;
        }

        public function get bPS3Switch():Boolean
        {
            return this._bPS3Switch;
        }

        public function get uiController():uint
        {
            return this._uiController;
        }

        public function get uiKeyboard():uint
        {
            return this._uiKeyboard;
        }

        public function get bNuclearWinterMode():Boolean
        {
            return this._bNuclearWinterMode;
        }

        public function get SafeX():Number
        {
            return this.safeX;
        }

        public function get SafeY():Number
        {
            return this.safeY;
        }

        public function get buttonHintBar():Shared.AS3.BSButtonHintBar
        {
            return this._ButtonHintBar;
        }

        public function set buttonHintBar(arg1:Shared.AS3.BSButtonHintBar):*
        {
            this._ButtonHintBar = arg1;
            return;
        }

        public function set overrideColors(arg1:Boolean):*
        {
            this.bOverrideColors = arg1;
            return;
        }

        public function get overrideColors():Boolean
        {
            return this.bOverrideColors;
        }

        protected function onPlatformRequestEvent(arg1:flash.events.Event):*
        {
            if (this.uiPlatform != Shared.AS3.Events.PlatformChangeEvent.PLATFORM_INVALID) 
            {
                (arg1 as Shared.AS3.Events.PlatformRequestEvent).RespondToRequest(this.uiPlatform, this.bPS3Switch, this.uiController, this.uiKeyboard);
            }
            return;
        }

        internal var _uiPlatform:uint;

        internal var _bPS3Switch:Boolean;

        internal var _uiController:uint;

        internal var _uiKeyboard:uint;

        internal var _bNuclearWinterMode:Boolean;

        internal var _bRestoreLostFocus:Boolean;

        internal var safeX:Number=0;

        internal var safeY:Number=0;

        internal var textFieldSizeMap:Object;

        internal var _ButtonHintBar:Shared.AS3.BSButtonHintBar;

        internal var bOverrideColors:*=true;

        var colorFilter:fl.motion.AdjustColor;

        var mColorMatrix:flash.filters.ColorMatrixFilter;

        var mMatrix:Array;
    }
}
