package Shared.AS3 
{
    import Shared.AS3.Events.*;
    import __AS3__.vec.*;
    import flash.events.*;
    
    public dynamic class MenuComponent extends Shared.AS3.BSUIComponent
    {
        public function MenuComponent()
        {
            this._ButtonData = new Vector.<Shared.AS3.BSButtonHintData>();
            super();
            this.buttonHintBarTarget_Inspectable = "ButtonHintBar_mc";
            return;
        }

        public function get Active():Boolean
        {
            return this._active;
        }

        public function set Active(arg1:*):void
        {
            this._active = arg1;
            this.connectButtonBar();
            return;
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

        public function get buttonData():__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>
        {
            return this._ButtonData;
        }

        public function set buttonData(arg1:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>):void
        {
            this._ButtonData = arg1;
            return;
        }

        internal function onEnterFrame(arg1:flash.events.Event):*
        {
            stage.dispatchEvent(new Shared.AS3.Events.MenuComponentLoadedEvent(this));
            removeEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            addEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }

        public function SetParentMenu(arg1:Shared.AS3.IMenu):*
        {
            this.buttonHintBar = arg1.buttonHintBar;
            this.connectButtonBar();
            return;
        }

        public function get buttonHintBarTarget_Inspectable():Object
        {
            return this._targetButtonHintBar;
        }

        public function set buttonHintBarTarget_Inspectable(arg1:Object):void
        {
            var loc1:*=Object;
            if (arg1 is String) 
            {
                if (arg1.toString() == "" || parent == null) 
                {
                    return;
                }
                loc1 = parent.getChildByName(arg1.toString()) as Object;
                if (loc1 == null) 
                {
                    if (parent.parent) 
                    {
                        loc1 = parent.parent.getChildByName(arg1.toString());
                        if (loc1 == null) 
                        {
                            return;
                        }
                    }
                }
            }
            else 
            {
                loc1 = arg1;
            }
            this._targetButtonHintBar = loc1;
            this.buttonHintBar = this._targetButtonHintBar as Shared.AS3.BSButtonHintBar;
            return;
        }

        public function AddButtonHintData(arg1:Shared.AS3.BSButtonHintData):void
        {
            if (!this.HasButtonHintData(arg1)) 
            {
                this.buttonData.splice(0, 0, arg1);
            }
            return;
        }

        public function RemoveButtonHintData(arg1:Shared.AS3.BSButtonHintData):*
        {
            var loc1:*=0;
            while (loc1 < this.buttonData.length) 
            {
                if (this.buttonData[loc1] == arg1) 
                {
                    this.buttonData.splice(loc1, 1);
                    break;
                }
                ++loc1;
            }
            return;
        }

        public function HasButtonHintData(arg1:Shared.AS3.BSButtonHintData):Boolean
        {
            var loc1:*=0;
            while (loc1 < this.buttonData.length) 
            {
                if (this.buttonData[loc1] == arg1) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public function connectButtonBar():*
        {
            if (!(this.buttonHintBar == null) && !(this.buttonData == null) && this._active) 
            {
                this.buttonHintBar.SetButtonHintData(this.buttonData);
            }
            return;
        }

        public function ProcessUserEvent(arg1:String, arg2:Boolean):Boolean
        {
            return false;
        }

        internal var _ButtonData:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;

        internal var _ButtonHintBar:Shared.AS3.BSButtonHintBar;

        protected var _active:Boolean=false;

        internal var _targetButtonHintBar:Object;
    }
}
