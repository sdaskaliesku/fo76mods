 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public dynamic class BSButtonHintData extends EventDispatcher
   {
      
      public static const BUTTON_HINT_DATA_CHANGE:String = // method body index: 279 method index: 279
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
      
      public function BSButtonHintData(astrButtonText:String, astrPCKey:String, astrPSNButton:String, astrXenonButton:String, auiJustification:uint, aFunction:Function)
      {
         // method body index: 312 method index: 312
         this.onAnnounceDataChange = this.onAnnounceDataChange_Impl;
         this.onTextClick = this.onTextClick_Impl;
         this.onSecondaryButtonClick = this.onSecondaryButtonClick_Impl;
         super();
         this._strPCKey = astrPCKey;
         this._strButtonText = astrButtonText;
         this._strXenonButton = astrXenonButton;
         this._strPSNButton = astrPSNButton;
         this._uiJustification = auiJustification;
         this._callbackFunction = aFunction;
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
         // method body index: 280 method index: 280
         return this._strPCKey;
      }
      
      public function get PSNButton() : String
      {
         // method body index: 281 method index: 281
         return this._strPSNButton;
      }
      
      public function get XenonButton() : String
      {
         // method body index: 282 method index: 282
         return this._strXenonButton;
      }
      
      public function get Justification() : uint
      {
         // method body index: 283 method index: 283
         return this._uiJustification;
      }
      
      public function get SecondaryPCKey() : String
      {
         // method body index: 284 method index: 284
         return this._strSecondaryPCKey;
      }
      
      public function get SecondaryPSNButton() : String
      {
         // method body index: 285 method index: 285
         return this._strSecondaryPSNButton;
      }
      
      public function get SecondaryXenonButton() : String
      {
         // method body index: 286 method index: 286
         return this._strSecondaryXenonButton;
      }
      
      public function get DynamicMovieClipName() : String
      {
         // method body index: 287 method index: 287
         return this._strDynamicMovieClipName;
      }
      
      public function set DynamicMovieClipName(aDynamicMovieClipName:String) : void
      {
         // method body index: 288 method index: 288
         if(this._strDynamicMovieClipName != aDynamicMovieClipName)
         {
            this._strDynamicMovieClipName = aDynamicMovieClipName;
            this.AnnounceDataChange();
         }
      }
      
      public function get canHold() : Boolean
      {
         // method body index: 289 method index: 289
         return this.m_CanHold;
      }
      
      public function set canHold(aHold:Boolean) : void
      {
         // method body index: 290 method index: 290
         if(this.m_CanHold != aHold)
         {
            this.m_CanHold = aHold;
            this.AnnounceDataChange();
         }
      }
      
      public function get holdPercent() : Number
      {
         // method body index: 291 method index: 291
         return this.m_HoldPercent;
      }
      
      public function set holdPercent(aPercent:Number) : void
      {
         // method body index: 292 method index: 292
         if(this.m_HoldPercent != aPercent)
         {
            this.m_HoldPercent = aPercent;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonDisabled() : Boolean
      {
         // method body index: 293 method index: 293
         return this._bButtonDisabled;
      }
      
      public function set ButtonDisabled(abButtonDisabled:Boolean) : *
      {
         // method body index: 294 method index: 294
         if(this._bButtonDisabled != abButtonDisabled)
         {
            this._bButtonDisabled = abButtonDisabled;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonEnabled() : Boolean
      {
         // method body index: 295 method index: 295
         return !this.ButtonDisabled;
      }
      
      public function set ButtonEnabled(abButtonEnabled:Boolean) : void
      {
         // method body index: 296 method index: 296
         this.ButtonDisabled = !abButtonEnabled;
      }
      
      public function get SecondaryButtonDisabled() : Boolean
      {
         // method body index: 297 method index: 297
         return this._bSecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonDisabled(abSecondaryButtonDisabled:Boolean) : *
      {
         // method body index: 298 method index: 298
         if(this._bSecondaryButtonDisabled != abSecondaryButtonDisabled)
         {
            this._bSecondaryButtonDisabled = abSecondaryButtonDisabled;
            this.AnnounceDataChange();
         }
      }
      
      public function get SecondaryButtonEnabled() : Boolean
      {
         // method body index: 299 method index: 299
         return !this.SecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonEnabled(abSecondaryButtonEnabled:Boolean) : void
      {
         // method body index: 300 method index: 300
         this.SecondaryButtonDisabled = !abSecondaryButtonEnabled;
      }
      
      public function get ButtonText() : String
      {
         // method body index: 301 method index: 301
         return this._strButtonText;
      }
      
      public function set ButtonText(astrButtonText:String) : void
      {
         // method body index: 302 method index: 302
         if(this._strButtonText != astrButtonText)
         {
            this._strButtonText = astrButtonText;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonVisible() : Boolean
      {
         // method body index: 303 method index: 303
         return this._bButtonVisible;
      }
      
      public function set ButtonVisible(abButtonVisible:Boolean) : void
      {
         // method body index: 304 method index: 304
         if(this._bButtonVisible != abButtonVisible)
         {
            this._bButtonVisible = abButtonVisible;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonFlashing() : Boolean
      {
         // method body index: 305 method index: 305
         return this._bButtonFlashing;
      }
      
      public function set ButtonFlashing(abButtonFlashing:Boolean) : void
      {
         // method body index: 306 method index: 306
         if(this._bButtonFlashing != abButtonFlashing)
         {
            this._bButtonFlashing = abButtonFlashing;
            this.AnnounceDataChange();
         }
      }
      
      public function get hasSecondaryButton() : Boolean
      {
         // method body index: 307 method index: 307
         return this._hasSecondaryButton;
      }
      
      public function get IsWarning() : Boolean
      {
         // method body index: 308 method index: 308
         return this._isWarning;
      }
      
      public function set IsWarning(abIsWarning:Boolean) : void
      {
         // method body index: 309 method index: 309
         if(this._isWarning != abIsWarning)
         {
            this._isWarning = abIsWarning;
            this.AnnounceDataChange();
         }
      }
      
      private function AnnounceDataChange() : void
      {
         // method body index: 310 method index: 310
         dispatchEvent(new Event(BUTTON_HINT_DATA_CHANGE));
         if(this.onAnnounceDataChange is Function)
         {
            this.onAnnounceDataChange();
         }
      }
      
      private function onAnnounceDataChange_Impl() : void
      {
         // method body index: 311 method index: 311
      }
      
      public function SetButtons(astrPCKey:String, astrPSNButton:String, astrXenonButton:String) : *
      {
         // method body index: 313 method index: 313
         var buttonChange:Boolean = false;
         if(this._strPCKey != astrPCKey)
         {
            this._strPCKey = astrPCKey;
            buttonChange = true;
         }
         if(this._strPSNButton != astrPSNButton)
         {
            this._strPSNButton = astrPSNButton;
            buttonChange = true;
         }
         if(this._strXenonButton != astrXenonButton)
         {
            this._strXenonButton = astrXenonButton;
            buttonChange = true;
         }
         if(buttonChange)
         {
            this.AnnounceDataChange();
         }
      }
      
      public function SetSecondaryButtons(astrSecondaryPCKey:String, astrSecondaryPSNButton:String, astrSecondaryXenonButton:String) : *
      {
         // method body index: 314 method index: 314
         this._hasSecondaryButton = true;
         var buttonChange:Boolean = false;
         if(this._strSecondaryPCKey != astrSecondaryPCKey)
         {
            this._strSecondaryPCKey = astrSecondaryPCKey;
            buttonChange = true;
         }
         if(this._strSecondaryPSNButton != astrSecondaryPSNButton)
         {
            this._strSecondaryPSNButton = astrSecondaryPSNButton;
            buttonChange = true;
         }
         if(this._strSecondaryXenonButton != astrSecondaryXenonButton)
         {
            this._strSecondaryXenonButton = astrSecondaryXenonButton;
            buttonChange = true;
         }
         if(buttonChange)
         {
            this.AnnounceDataChange();
         }
      }
      
      public function set secondaryButtonCallback(aSecondaryFunction:Function) : *
      {
         // method body index: 315 method index: 315
         this._secondaryButtonCallback = aSecondaryFunction;
      }
      
      private function onTextClick_Impl() : void
      {
         // method body index: 316 method index: 316
         if(this._callbackFunction is Function)
         {
            this._callbackFunction.call();
         }
      }
      
      private function onSecondaryButtonClick_Impl() : void
      {
         // method body index: 317 method index: 317
         if(this._secondaryButtonCallback is Function)
         {
            this._secondaryButtonCallback.call();
         }
      }
   }
}
