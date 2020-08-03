package Shared.AS3 
{
    import Shared.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class BSDisplayObject extends flash.display.MovieClip
    {
        public function BSDisplayObject()
        {
            super();
            this._bIsDirty = false;
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            if (loaderInfo is flash.display.LoaderInfo) 
            {
                loaderInfo.addEventListener(flash.events.Event.INIT, this.onLoadedInitEvent);
            }
            return;
        }

        public function get bIsDirty():Boolean
        {
            return this._bIsDirty;
        }

        public function SetIsDirty():void
        {
            this._bIsDirty = true;
            this.requestRedraw();
            return;
        }

        internal final function ClearIsDirty():void
        {
            this._bIsDirty = false;
            return;
        }

        internal final function onLoadedInitEvent(arg1:flash.events.Event):void
        {
            if (loaderInfo is flash.display.LoaderInfo) 
            {
                loaderInfo.removeEventListener(flash.events.Event.INIT, this.onLoadedInitEvent);
            }
            this.onLoadedInit();
            return;
        }

        internal final function onAddedToStageEvent(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            this.onAddedToStage();
            if (this.bIsDirty) 
            {
                this.requestRedraw();
            }
            addEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStageEvent);
            return;
        }

        internal final function onRemovedFromStageEvent(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStageEvent);
            if (stage) 
            {
                stage.removeEventListener(flash.events.Event.RENDER, this.onRenderEvent);
            }
            this.onRemovedFromStage();
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            return;
        }

        internal final function onRenderEvent(arg1:flash.events.Event):void
        {
            if (stage) 
            {
                stage.removeEventListener(flash.events.Event.RENDER, this.onRenderEvent);
            }
            if (this.bIsDirty) 
            {
                this.ClearIsDirty();
                this.redrawDisplayObject();
            }
            Shared.GlobalFunc.BSASSERT(!this.bIsDirty, "BSDisplayObject: " + flash.utils.getQualifiedClassName(this) + ": " + this.name + ": redrawDisplayObject caused the object to be dirtied. This should never happen as it wont be rendered for that change until it changes for yet another reason later.");
            return;
        }

        internal function requestRedraw():void
        {
            if (stage) 
            {
                stage.addEventListener(flash.events.Event.RENDER, this.onRenderEvent);
                stage.invalidate();
            }
            return;
        }

        public function onLoadedInit():void
        {
            return;
        }

        public function redrawDisplayObject():void
        {
            return;
        }

        public function onAddedToStage():void
        {
            return;
        }

        public function onRemovedFromStage():void
        {
            return;
        }

        public override function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            var loc1:*=super.addChild(arg1);
            if (this.onAddChild is Function) 
            {
                this.onAddChild(arg1, flash.utils.getQualifiedClassName(arg1));
            }
            return loc1;
        }

        public override function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            var loc1:*=super.removeChild(arg1);
            if (this.onRemoveChild is Function) 
            {
                this.onRemoveChild(arg1, flash.utils.getQualifiedClassName(arg1));
            }
            return loc1;
        }

        internal var _bIsDirty:Boolean;

        public var onAddChild:Function;

        public var onRemoveChild:Function;
    }
}
