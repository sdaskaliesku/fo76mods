 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public dynamic class BSButtonHintData extends EventDispatcher
   {
      
      public static const BUTTON_HINT_DATA_CHANGE:String = // method body index: 490 method index: 490
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
         // method body index: 491 method index: 491
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
         // method body index: 492 method index: 492
         return this._strPCKey;
      }
      
      public function get PSNButton() : String
      {
         // method body index: 493 method index: 493
         return this._strPSNButton;
      }
      
      public function get XenonButton() : String
      {
         // method body index: 494 method index: 494
         return this._strXenonButton;
      }
      
      public function get Justification() : uint
      {
         // method body index: 495 method index: 495
         return this._uiJustification;
      }
      
      public function get SecondaryPCKey() : String
      {
         // method body index: 496 method index: 496
         return this._strSecondaryPCKey;
      }
      
      public function get SecondaryPSNButton() : String
      {
         // method body index: 497 method index: 497
         return this._strSecondaryPSNButton;
      }
      
      public function get SecondaryXenonButton() : String
      {
         // method body index: 498 method index: 498
         return this._strSecondaryXenonButton;
      }
      
      public function get DynamicMovieClipName() : String
      {
         // method body index: 499 method index: 499
         return this._strDynamicMovieClipName;
      }
      
      public function set DynamicMovieClipName(param1:String) : void
      {
         // method body index: 500 method index: 500
         if(this._strDynamicMovieClipName != param1)
         {
            this._strDynamicMovieClipName = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get canHold() : Boolean
      {
         // method body index: 501 method index: 501
         return this.m_CanHold;
      }
      
      public function set canHold(param1:Boolean) : void
      {
         // method body index: 502 method index: 502
         if(this.m_CanHold != param1)
         {
            this.m_CanHold = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get holdPercent() : Number
      {
         // method body index: 503 method index: 503
         return this.m_HoldPercent;
      }
      
      public function set holdPercent(param1:Number) : void
      {
         // method body index: 504 method index: 504
         if(this.m_HoldPercent != param1)
         {
            this.m_HoldPercent = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonDisabled() : Boolean
      {
         // method body index: 505 method index: 505
         return this._bButtonDisabled;
      }
      
      public function set ButtonDisabled(param1:Boolean) : *
      {
         // method body index: 506 method index: 506
         if(this._bButtonDisabled != param1)
         {
            this._bButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonEnabled() : Boolean
      {
         // method body index: 507 method index: 507
         return !this.ButtonDisabled;
      }
      
      public function set ButtonEnabled(param1:Boolean) : void
      {
         // method body index: 508 method index: 508
         this.ButtonDisabled = !param1;
      }
      
      public function get SecondaryButtonDisabled() : Boolean
      {
         // method body index: 509 method index: 509
         return this._bSecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonDisabled(param1:Boolean) : *
      {
         // method body index: 510 method index: 510
         if(this._bSecondaryButtonDisabled != param1)
         {
            this._bSecondaryButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get SecondaryButtonEnabled() : Boolean
      {
         // method body index: 511 method index: 511
         return !this.SecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonEnabled(param1:Boolean) : void
      {
         // method body index: 512 method index: 512
         this.SecondaryButtonDisabled = !param1;
      }
      
      public function get ButtonText() : String
      {
         // method body index: 513 method index: 513
         return this._strButtonText;
      }
      
      public function set ButtonText(param1:String) : void
      {
         // method body index: 514 method index: 514
         if(this._strButtonText != param1)
         {
            this._strButtonText = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonVisible() : Boolean
      {
         // method body index: 515 method index: 515
         return this._bButtonVisible;
      }
      
      public function set ButtonVisible(param1:Boolean) : void
      {
         // method body index: 516 method index: 516
         if(this._bButtonVisible != param1)
         {
            this._bButtonVisible = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonFlashing() : Boolean
      {
         // method body index: 517 method index: 517
         return this._bButtonFlashing;
      }
      
      public function set ButtonFlashing(param1:Boolean) : void
      {
         // method body index: 518 method index: 518
         if(this._bButtonFlashing != param1)
         {
            this._bButtonFlashing = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get hasSecondaryButton() : Boolean
      {
         // method body index: 519 method index: 519
         return this._hasSecondaryButton;
      }
      
      public function get IsWarning() : Boolean
      {
         // method body index: 520 method index: 520
         return this._isWarning;
      }
      
      public function set IsWarning(param1:Boolean) : void
      {
         // method body index: 521 method index: 521
         if(this._isWarning != param1)
         {
            this._isWarning = param1;
            this.AnnounceDataChange();
         }
      }
      
      private function AnnounceDataChange() : void
      {
         // method body index: 522 method index: 522
         dispatchEvent(new Event(BUTTON_HINT_DATA_CHANGE));
         if(this.onAnnounceDataChange is Function)
         {
            this.onAnnounceDataChange();
         }
      }
      
      private function onAnnounceDataChange_Impl() : void
      {
         // method body index: 523 method index: 523
      }
      
      public function SetButtons(param1:String, param2:String, param3:String) : *
      {
         // method body index: 524 method index: 524
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
         // method body index: 525 method index: 525
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
      
      public function set secondaryButtonCallback(param1:Function) : *
      {
         // method body index: 526 method index: 526
         this._secondaryButtonCallback = param1;
      }
      
      private function onTextClick_Impl() : void
      {
         // method body index: 527 method index: 527
         if(this._callbackFunction is Function)
         {
            this._callbackFunction.call();
         }
      }
      
      private function onSecondaryButtonClick_Impl() : void
      {
         // method body index: 528 method index: 528
         if(this._secondaryButtonCallback is Function)
         {
            this._secondaryButtonCallback.call();
         }
      }
   }
}
