 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public dynamic class BSButtonHintData extends EventDispatcher
   {
      
      public static const BUTTON_HINT_DATA_CHANGE:String = // method body index: 555 method index: 555
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
         // method body index: 588 method index: 588
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
         // method body index: 556 method index: 556
         return this._strPCKey;
      }
      
      public function get PSNButton() : String
      {
         // method body index: 557 method index: 557
         return this._strPSNButton;
      }
      
      public function get XenonButton() : String
      {
         // method body index: 558 method index: 558
         return this._strXenonButton;
      }
      
      public function get Justification() : uint
      {
         // method body index: 559 method index: 559
         return this._uiJustification;
      }
      
      public function get SecondaryPCKey() : String
      {
         // method body index: 560 method index: 560
         return this._strSecondaryPCKey;
      }
      
      public function get SecondaryPSNButton() : String
      {
         // method body index: 561 method index: 561
         return this._strSecondaryPSNButton;
      }
      
      public function get SecondaryXenonButton() : String
      {
         // method body index: 562 method index: 562
         return this._strSecondaryXenonButton;
      }
      
      public function get DynamicMovieClipName() : String
      {
         // method body index: 563 method index: 563
         return this._strDynamicMovieClipName;
      }
      
      public function set DynamicMovieClipName(aDynamicMovieClipName:String) : void
      {
         // method body index: 564 method index: 564
         if(this._strDynamicMovieClipName != aDynamicMovieClipName)
         {
            this._strDynamicMovieClipName = aDynamicMovieClipName;
            this.AnnounceDataChange();
         }
      }
      
      public function get canHold() : Boolean
      {
         // method body index: 565 method index: 565
         return this.m_CanHold;
      }
      
      public function set canHold(aHold:Boolean) : void
      {
         // method body index: 566 method index: 566
         if(this.m_CanHold != aHold)
         {
            this.m_CanHold = aHold;
            this.AnnounceDataChange();
         }
      }
      
      public function get holdPercent() : Number
      {
         // method body index: 567 method index: 567
         return this.m_HoldPercent;
      }
      
      public function set holdPercent(aPercent:Number) : void
      {
         // method body index: 568 method index: 568
         if(this.m_HoldPercent != aPercent)
         {
            this.m_HoldPercent = aPercent;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonDisabled() : Boolean
      {
         // method body index: 569 method index: 569
         return this._bButtonDisabled;
      }
      
      public function set ButtonDisabled(abButtonDisabled:Boolean) : *
      {
         // method body index: 570 method index: 570
         if(this._bButtonDisabled != abButtonDisabled)
         {
            this._bButtonDisabled = abButtonDisabled;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonEnabled() : Boolean
      {
         // method body index: 571 method index: 571
         return !this.ButtonDisabled;
      }
      
      public function set ButtonEnabled(abButtonEnabled:Boolean) : void
      {
         // method body index: 572 method index: 572
         this.ButtonDisabled = !abButtonEnabled;
      }
      
      public function get SecondaryButtonDisabled() : Boolean
      {
         // method body index: 573 method index: 573
         return this._bSecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonDisabled(abSecondaryButtonDisabled:Boolean) : *
      {
         // method body index: 574 method index: 574
         if(this._bSecondaryButtonDisabled != abSecondaryButtonDisabled)
         {
            this._bSecondaryButtonDisabled = abSecondaryButtonDisabled;
            this.AnnounceDataChange();
         }
      }
      
      public function get SecondaryButtonEnabled() : Boolean
      {
         // method body index: 575 method index: 575
         return !this.SecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonEnabled(abSecondaryButtonEnabled:Boolean) : void
      {
         // method body index: 576 method index: 576
         this.SecondaryButtonDisabled = !abSecondaryButtonEnabled;
      }
      
      public function get ButtonText() : String
      {
         // method body index: 577 method index: 577
         return this._strButtonText;
      }
      
      public function set ButtonText(astrButtonText:String) : void
      {
         // method body index: 578 method index: 578
         if(this._strButtonText != astrButtonText)
         {
            this._strButtonText = astrButtonText;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonVisible() : Boolean
      {
         // method body index: 579 method index: 579
         return this._bButtonVisible;
      }
      
      public function set ButtonVisible(abButtonVisible:Boolean) : void
      {
         // method body index: 580 method index: 580
         if(this._bButtonVisible != abButtonVisible)
         {
            this._bButtonVisible = abButtonVisible;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonFlashing() : Boolean
      {
         // method body index: 581 method index: 581
         return this._bButtonFlashing;
      }
      
      public function set ButtonFlashing(abButtonFlashing:Boolean) : void
      {
         // method body index: 582 method index: 582
         if(this._bButtonFlashing != abButtonFlashing)
         {
            this._bButtonFlashing = abButtonFlashing;
            this.AnnounceDataChange();
         }
      }
      
      public function get hasSecondaryButton() : Boolean
      {
         // method body index: 583 method index: 583
         return this._hasSecondaryButton;
      }
      
      public function get IsWarning() : Boolean
      {
         // method body index: 584 method index: 584
         return this._isWarning;
      }
      
      public function set IsWarning(abIsWarning:Boolean) : void
      {
         // method body index: 585 method index: 585
         if(this._isWarning != abIsWarning)
         {
            this._isWarning = abIsWarning;
            this.AnnounceDataChange();
         }
      }
      
      private function AnnounceDataChange() : void
      {
         // method body index: 586 method index: 586
         dispatchEvent(new Event(BUTTON_HINT_DATA_CHANGE));
         if(this.onAnnounceDataChange is Function)
         {
            this.onAnnounceDataChange();
         }
      }
      
      private function onAnnounceDataChange_Impl() : void
      {
         // method body index: 587 method index: 587
      }
      
      public function SetButtons(astrPCKey:String, astrPSNButton:String, astrXenonButton:String) : *
      {
         // method body index: 589 method index: 589
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
         // method body index: 590 method index: 590
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
         // method body index: 591 method index: 591
         this._secondaryButtonCallback = aSecondaryFunction;
      }
      
      private function onTextClick_Impl() : void
      {
         // method body index: 592 method index: 592
         if(this._callbackFunction is Function)
         {
            this._callbackFunction.call();
         }
      }
      
      private function onSecondaryButtonClick_Impl() : void
      {
         // method body index: 593 method index: 593
         if(this._secondaryButtonCallback is Function)
         {
            this._secondaryButtonCallback.call();
         }
      }
   }
}
