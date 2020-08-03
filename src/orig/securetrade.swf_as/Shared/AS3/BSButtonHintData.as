package Shared.AS3 
{
    import flash.events.*;
    
    public dynamic class BSButtonHintData extends flash.events.EventDispatcher
    {
        public function BSButtonHintData(arg1:String, arg2:String, arg3:String, arg4:String, arg5:uint, arg6:Function)
        {
            this.onAnnounceDataChange = this.onAnnounceDataChange_Impl;
            this.onTextClick = this.onTextClick_Impl;
            this.onSecondaryButtonClick = this.onSecondaryButtonClick_Impl;
            super();
            this._strPCKey = arg2;
            this._strButtonText = arg1;
            this._strXenonButton = arg4;
            this._strPSNButton = arg3;
            this._uiJustification = arg5;
            this._callbackFunction = arg6;
            this._bButtonDisabled = false;
            this._bButtonVisible = true;
            this._bButtonFlashing = false;
            this._hasSecondaryButton = false;
            this._strSecondaryPCKey = "";
            this._strSecondaryPSNButton = "";
            this._strSecondaryXenonButton = "";
            this._secondaryButtonCallback = null;
            this._strDynamicMovieClipName = "";
            this._isWarning = false;
            return;
        }

        public function set SecondaryButtonDisabled(arg1:Boolean):*
        {
            if (this._bSecondaryButtonDisabled != arg1) 
            {
                this._bSecondaryButtonDisabled = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function get SecondaryButtonEnabled():Boolean
        {
            return !this.SecondaryButtonDisabled;
        }

        public function set SecondaryButtonEnabled(arg1:Boolean):void
        {
            this.SecondaryButtonDisabled = !arg1;
            return;
        }

        public function get ButtonText():String
        {
            return this._strButtonText;
        }

        public function set ButtonText(arg1:String):void
        {
            if (this._strButtonText != arg1) 
            {
                this._strButtonText = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function get ButtonVisible():Boolean
        {
            return this._bButtonVisible;
        }

        public function set canHold(arg1:Boolean):void
        {
            if (this.m_CanHold != arg1) 
            {
                this.m_CanHold = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function set ButtonVisible(arg1:Boolean):void
        {
            if (this._bButtonVisible != arg1) 
            {
                this._bButtonVisible = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function get ButtonFlashing():Boolean
        {
            return this._bButtonFlashing;
        }

        public function set ButtonFlashing(arg1:Boolean):void
        {
            if (this._bButtonFlashing != arg1) 
            {
                this._bButtonFlashing = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function get hasSecondaryButton():Boolean
        {
            return this._hasSecondaryButton;
        }

        public function get IsWarning():Boolean
        {
            return this._isWarning;
        }

        public function set IsWarning(arg1:Boolean):void
        {
            if (this._isWarning != arg1) 
            {
                this._isWarning = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        internal function AnnounceDataChange():void
        {
            dispatchEvent(new flash.events.Event(BUTTON_HINT_DATA_CHANGE));
            if (this.onAnnounceDataChange is Function) 
            {
                this.onAnnounceDataChange();
            }
            return;
        }

        internal function onAnnounceDataChange_Impl():void
        {
            return;
        }

        public function SetSecondaryButtons(arg1:String, arg2:String, arg3:String):*
        {
            this._hasSecondaryButton = true;
            var loc1:*=false;
            if (this._strSecondaryPCKey != arg1) 
            {
                this._strSecondaryPCKey = arg1;
                loc1 = true;
            }
            if (this._strSecondaryPSNButton != arg2) 
            {
                this._strSecondaryPSNButton = arg2;
                loc1 = true;
            }
            if (this._strSecondaryXenonButton != arg3) 
            {
                this._strSecondaryXenonButton = arg3;
                loc1 = true;
            }
            if (loc1) 
            {
                this.AnnounceDataChange();
            }
            return;
        }

        public function set secondaryButtonCallback(arg1:Function):*
        {
            this._secondaryButtonCallback = arg1;
            return;
        }

        internal function onTextClick_Impl():void
        {
            if (this._callbackFunction is Function) 
            {
                this._callbackFunction.call();
            }
            return;
        }

        internal function onSecondaryButtonClick_Impl():void
        {
            if (this._secondaryButtonCallback is Function) 
            {
                this._secondaryButtonCallback.call();
            }
            return;
        }

        public function get PCKey():String
        {
            return this._strPCKey;
        }

        public function get PSNButton():String
        {
            return this._strPSNButton;
        }

        public function get XenonButton():String
        {
            return this._strXenonButton;
        }

        public function get Justification():uint
        {
            return this._uiJustification;
        }

        public function get SecondaryPCKey():String
        {
            return this._strSecondaryPCKey;
        }

        public function get SecondaryPSNButton():String
        {
            return this._strSecondaryPSNButton;
        }

        public function get SecondaryXenonButton():String
        {
            return this._strSecondaryXenonButton;
        }

        public function get DynamicMovieClipName():String
        {
            return this._strDynamicMovieClipName;
        }

        public function set DynamicMovieClipName(arg1:String):void
        {
            if (this._strDynamicMovieClipName != arg1) 
            {
                this._strDynamicMovieClipName = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function get canHold():Boolean
        {
            return this.m_CanHold;
        }

        public function SetButtons(arg1:String, arg2:String, arg3:String):*
        {
            var loc1:*=false;
            if (this._strPCKey != arg1) 
            {
                this._strPCKey = arg1;
                loc1 = true;
            }
            if (this._strPSNButton != arg2) 
            {
                this._strPSNButton = arg2;
                loc1 = true;
            }
            if (this._strXenonButton != arg3) 
            {
                this._strXenonButton = arg3;
                loc1 = true;
            }
            if (loc1) 
            {
                this.AnnounceDataChange();
            }
            return;
        }

        public function get holdPercent():Number
        {
            return this.m_HoldPercent;
        }

        public function set holdPercent(arg1:Number):void
        {
            if (this.m_HoldPercent != arg1) 
            {
                this.m_HoldPercent = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function get ButtonDisabled():Boolean
        {
            return this._bButtonDisabled;
        }

        public function set ButtonDisabled(arg1:Boolean):*
        {
            if (this._bButtonDisabled != arg1) 
            {
                this._bButtonDisabled = arg1;
                this.AnnounceDataChange();
            }
            return;
        }

        public function get ButtonEnabled():Boolean
        {
            return !this.ButtonDisabled;
        }

        public function set ButtonEnabled(arg1:Boolean):void
        {
            this.ButtonDisabled = !arg1;
            return;
        }

        public function get SecondaryButtonDisabled():Boolean
        {
            return this._bSecondaryButtonDisabled;
        }

        public static const BUTTON_HINT_DATA_CHANGE:String="ButtonHintDataChange";

        internal var _strButtonText:String;

        internal var _strPCKey:String;

        internal var _strPSNButton:String;

        internal var _strXenonButton:String;

        internal var _uiJustification:uint;

        internal var _callbackFunction:Function;

        internal var _bSecondaryButtonDisabled:Boolean;

        internal var _bButtonVisible:Boolean;

        internal var _bButtonFlashing:Boolean;

        internal var _hasSecondaryButton:Boolean;

        internal var _strSecondaryPCKey:String;

        internal var _strSecondaryXenonButton:String;

        internal var _strSecondaryPSNButton:String;

        internal var _secondaryButtonCallback:Function;

        internal var m_CanHold:Boolean=false;

        internal var m_HoldPercent:Number=0;

        internal var _isWarning:Boolean;

        internal var _strDynamicMovieClipName:String;

        public var onTextClick:Function;

        public var onAnnounceDataChange:Function;

        public var onSecondaryButtonClick:Function;

        internal var _bButtonDisabled:Boolean;
    }
}
