 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public dynamic class BSButtonHintData extends EventDispatcher
   {
      
      public static const BUTTON_HINT_DATA_CHANGE:String = // method body index: 232 method index: 232
      "ButtonHintDataChange";
       
      
      private var _strButtonText:String;
      
      private var _strPCKey:String;
      
      private var _strPSNButton:String;
      
      private var _strXenonButton:String;
      
      private var _uiJustification:uint;
      
      private var _callbackFunction:Function;
      
      private var _bButtonDisabled:Boolean;
      
      private var _bSecondaryButtonDisabled:Boolean;
      
      private var _bButtonVisible:Boolean;
      
      private var _bButtonFlashing:Boolean;
      
      private var _hasSecondaryButton:Boolean;
      
      private var _strSecondaryPCKey:String;
      
      private var _strSecondaryXenonButton:String;
      
      private var _strSecondaryPSNButton:String;
      
      private var _secondaryButtonCallback:Function;
      
      private var m_CanHold:Boolean = false;
      
      private var m_HoldPercent:Number = 0.0;
      
      private var _isWarning:Boolean;
      
      private var _strDynamicMovieClipName:String;
      
      public var onAnnounceDataChange:Function;
      
      public var onTextClick:Function;
      
      public var onSecondaryButtonClick:Function;
      
      public function BSButtonHintData(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function)
      {
         // method body index: 265 method index: 265
         this.onAnnounceDataChange = this.onAnnounceDataChange_Impl;
         this.onTextClick = this.onTextClick_Impl;
         this.onSecondaryButtonClick = this.onSecondaryButtonClick_Impl;
         super();
         this._strPCKey = param2;
         this._strButtonText = param1;
         this._strXenonButton = param4;
         this._strPSNButton = param3;
         this._uiJustification = param5;
         this._callbackFunction = param6;
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
      }
      
      public function get PCKey() : String
      {
         // method body index: 233 method index: 233
         return this._strPCKey;
      }
      
      public function get PSNButton() : String
      {
         // method body index: 234 method index: 234
         return this._strPSNButton;
      }
      
      public function get XenonButton() : String
      {
         // method body index: 235 method index: 235
         return this._strXenonButton;
      }
      
      public function get Justification() : uint
      {
         // method body index: 236 method index: 236
         return this._uiJustification;
      }
      
      public function get SecondaryPCKey() : String
      {
         // method body index: 237 method index: 237
         return this._strSecondaryPCKey;
      }
      
      public function get SecondaryPSNButton() : String
      {
         // method body index: 238 method index: 238
         return this._strSecondaryPSNButton;
      }
      
      public function get SecondaryXenonButton() : String
      {
         // method body index: 239 method index: 239
         return this._strSecondaryXenonButton;
      }
      
      public function get DynamicMovieClipName() : String
      {
         // method body index: 240 method index: 240
         return this._strDynamicMovieClipName;
      }
      
      public function set DynamicMovieClipName(param1:String) : void
      {
         // method body index: 241 method index: 241
         if(this._strDynamicMovieClipName != param1)
         {
            this._strDynamicMovieClipName = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get canHold() : Boolean
      {
         // method body index: 242 method index: 242
         return this.m_CanHold;
      }
      
      public function set canHold(param1:Boolean) : void
      {
         // method body index: 243 method index: 243
         if(this.m_CanHold != param1)
         {
            this.m_CanHold = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get holdPercent() : Number
      {
         // method body index: 244 method index: 244
         return this.m_HoldPercent;
      }
      
      public function set holdPercent(param1:Number) : void
      {
         // method body index: 245 method index: 245
         if(this.m_HoldPercent != param1)
         {
            this.m_HoldPercent = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonDisabled() : Boolean
      {
         // method body index: 246 method index: 246
         return this._bButtonDisabled;
      }
      
      public function set ButtonDisabled(param1:Boolean) : void
      {
         // method body index: 247 method index: 247
         if(this._bButtonDisabled != param1)
         {
            this._bButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonEnabled() : Boolean
      {
         // method body index: 248 method index: 248
         return !this.ButtonDisabled;
      }
      
      public function set ButtonEnabled(param1:Boolean) : void
      {
         // method body index: 249 method index: 249
         this.ButtonDisabled = !param1;
      }
      
      public function get SecondaryButtonDisabled() : Boolean
      {
         // method body index: 250 method index: 250
         return this._bSecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonDisabled(param1:Boolean) : void
      {
         // method body index: 251 method index: 251
         if(this._bSecondaryButtonDisabled != param1)
         {
            this._bSecondaryButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get SecondaryButtonEnabled() : Boolean
      {
         // method body index: 252 method index: 252
         return !this.SecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonEnabled(param1:Boolean) : void
      {
         // method body index: 253 method index: 253
         this.SecondaryButtonDisabled = !param1;
      }
      
      public function get ButtonText() : String
      {
         // method body index: 254 method index: 254
         return this._strButtonText;
      }
      
      public function set ButtonText(param1:String) : void
      {
         // method body index: 255 method index: 255
         if(this._strButtonText != param1)
         {
            this._strButtonText = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonVisible() : Boolean
      {
         // method body index: 256 method index: 256
         return this._bButtonVisible;
      }
      
      public function set ButtonVisible(param1:Boolean) : void
      {
         // method body index: 257 method index: 257
         if(this._bButtonVisible != param1)
         {
            this._bButtonVisible = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonFlashing() : Boolean
      {
         // method body index: 258 method index: 258
         return this._bButtonFlashing;
      }
      
      public function set ButtonFlashing(param1:Boolean) : void
      {
         // method body index: 259 method index: 259
         if(this._bButtonFlashing != param1)
         {
            this._bButtonFlashing = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get hasSecondaryButton() : Boolean
      {
         // method body index: 260 method index: 260
         return this._hasSecondaryButton;
      }
      
      public function get IsWarning() : Boolean
      {
         // method body index: 261 method index: 261
         return this._isWarning;
      }
      
      public function set IsWarning(param1:Boolean) : void
      {
         // method body index: 262 method index: 262
         if(this._isWarning != param1)
         {
            this._isWarning = param1;
            this.AnnounceDataChange();
         }
      }
      
      private function AnnounceDataChange() : void
      {
         // method body index: 263 method index: 263
         dispatchEvent(new Event(BUTTON_HINT_DATA_CHANGE));
         if(this.onAnnounceDataChange is Function)
         {
            this.onAnnounceDataChange();
         }
      }
      
      private function onAnnounceDataChange_Impl() : void
      {
         // method body index: 264 method index: 264
      }
      
      public function SetButtons(param1:String, param2:String, param3:String) : *
      {
         // method body index: 266 method index: 266
         var _loc4_:Boolean = false;
         if(this._strPCKey != param1)
         {
            this._strPCKey = param1;
            _loc4_ = true;
         }
         if(this._strPSNButton != param2)
         {
            this._strPSNButton = param2;
            _loc4_ = true;
         }
         if(this._strXenonButton != param3)
         {
            this._strXenonButton = param3;
            _loc4_ = true;
         }
         if(_loc4_)
         {
            this.AnnounceDataChange();
         }
      }
      
      public function SetSecondaryButtons(param1:String, param2:String, param3:String) : *
      {
         // method body index: 267 method index: 267
         this._hasSecondaryButton = true;
         var _loc4_:Boolean = false;
         if(this._strSecondaryPCKey != param1)
         {
            this._strSecondaryPCKey = param1;
            _loc4_ = true;
         }
         if(this._strSecondaryPSNButton != param2)
         {
            this._strSecondaryPSNButton = param2;
            _loc4_ = true;
         }
         if(this._strSecondaryXenonButton != param3)
         {
            this._strSecondaryXenonButton = param3;
            _loc4_ = true;
         }
         if(_loc4_)
         {
            this.AnnounceDataChange();
         }
      }
      
      public function set secondaryButtonCallback(param1:Function) : void
      {
         // method body index: 268 method index: 268
         this._secondaryButtonCallback = param1;
      }
      
      private function onTextClick_Impl() : void
      {
         // method body index: 269 method index: 269
         if(this._callbackFunction is Function)
         {
            this._callbackFunction.call();
         }
      }
      
      private function onSecondaryButtonClick_Impl() : void
      {
         // method body index: 270 method index: 270
         if(this._secondaryButtonCallback is Function)
         {
            this._secondaryButtonCallback.call();
         }
      }
   }
}
