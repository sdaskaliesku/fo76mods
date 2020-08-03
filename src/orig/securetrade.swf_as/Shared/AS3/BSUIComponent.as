package Shared.AS3 
{
    import Shared.AS3.Events.*;
    import flash.events.*;
    import scaleform.gfx.*;
    
    public dynamic class BSUIComponent extends Shared.AS3.BSDisplayObject
    {
        public function BSUIComponent()
        {
            super();
            this._uiPlatform = Shared.AS3.Events.PlatformChangeEvent.PLATFORM_INVALID;
            this._bPS3Switch = false;
            this._uiController = Shared.AS3.Events.PlatformChangeEvent.PLATFORM_INVALID;
            this._uiKeyboard = Shared.AS3.Events.PlatformChangeEvent.PLATFORM_INVALID;
            this._bAcquiredByNativeCode = false;
            scaleform.gfx.Extensions.enabled = true;
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

        public function get bAcquiredByNativeCode():Boolean
        {
            return this._bAcquiredByNativeCode;
        }

        public function onAcquiredByNativeCode():*
        {
            this._bAcquiredByNativeCode = true;
            return;
        }

        public override function redrawDisplayObject():void
        {
            var loc1:*;
            try 
            {
                this.redrawUIComponent();
            }
            catch (e:Error)
            {
                trace(this + " " + this.name + ": " + e.getStackTrace());
            }
            return;
        }

        internal final function onSetPlatformEvent(arg1:flash.events.Event):*
        {
            var loc1:*=arg1 as Shared.AS3.Events.PlatformChangeEvent;
            this.SetPlatform(loc1.uiPlatform, loc1.bPS3Switch, loc1.uiController, loc1.uiKeyboard);
            return;
        }

        public override function onAddedToStage():void
        {
            dispatchEvent(new Shared.AS3.Events.PlatformRequestEvent(this));
            if (stage) 
            {
                stage.addEventListener(Shared.AS3.Events.PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatformEvent);
            }
            return;
        }

        public override function onRemovedFromStage():void
        {
            if (stage) 
            {
                stage.removeEventListener(Shared.AS3.Events.PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatformEvent);
            }
            return;
        }

        public function redrawUIComponent():void
        {
            return;
        }

        public function SetPlatform(arg1:uint, arg2:Boolean, arg3:uint, arg4:uint):void
        {
            if (!(this._uiPlatform == arg1) || !(this._bPS3Switch == arg2) || !(this._uiController == arg3) || !(this._uiKeyboard == arg4)) 
            {
                this._uiPlatform = arg1;
                this._bPS3Switch = arg2;
                this._uiController = arg3;
                this._uiKeyboard = arg4;
                SetIsDirty();
            }
            return;
        }

        internal var _uiPlatform:uint;

        internal var _bPS3Switch:Boolean;

        internal var _uiController:uint;

        internal var _uiKeyboard:uint;

        internal var _bAcquiredByNativeCode:Boolean;
    }
}
