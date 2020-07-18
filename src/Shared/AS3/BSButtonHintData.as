 
package Shared.AS3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public dynamic class BSButtonHintData extends EventDispatcher
   {
      
      public static const BUTTON_HINT_DATA_CHANGE:String = // method body index: 139 method index: 139
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
      
      private var _strDynamicMovieClipName:String;
      
      public var onAnnounceDataChange:Function;
      
      public var onTextClick:Function;
      
      public var onSecondaryButtonClick:Function;
      
      public function BSButtonHintData(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function)
      {
         // method body index: 140 method index: 140
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
      }
      
      public function get PCKey() : String
      {
         // method body index: 141 method index: 141
         return this._strPCKey;
      }
      
      public function get PSNButton() : String
      {
         // method body index: 142 method index: 142
         return this._strPSNButton;
      }
      
      public function get XenonButton() : String
      {
         // method body index: 143 method index: 143
         return this._strXenonButton;
      }
      
      public function get Justification() : uint
      {
         // method body index: 144 method index: 144
         return this._uiJustification;
      }
      
      public function get SecondaryPCKey() : String
      {
         // method body index: 145 method index: 145
         return this._strSecondaryPCKey;
      }
      
      public function get SecondaryPSNButton() : String
      {
         // method body index: 146 method index: 146
         return this._strSecondaryPSNButton;
      }
      
      public function get SecondaryXenonButton() : String
      {
         // method body index: 147 method index: 147
         return this._strSecondaryXenonButton;
      }
      
      public function get DynamicMovieClipName() : String
      {
         // method body index: 148 method index: 148
         return this._strDynamicMovieClipName;
      }
      
      public function set DynamicMovieClipName(param1:String) : void
      {
         // method body index: 149 method index: 149
         if(this._strDynamicMovieClipName != param1)
         {
            this._strDynamicMovieClipName = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get canHold() : Boolean
      {
         // method body index: 150 method index: 150
         return this.m_CanHold;
      }
      
      public function set canHold(param1:Boolean) : void
      {
         // method body index: 151 method index: 151
         if(this.m_CanHold != param1)
         {
            this.m_CanHold = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get holdPercent() : Number
      {
         // method body index: 152 method index: 152
         return this.m_HoldPercent;
      }
      
      public function set holdPercent(param1:Number) : void
      {
         // method body index: 153 method index: 153
         if(this.m_HoldPercent != param1)
         {
            this.m_HoldPercent = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonDisabled() : Boolean
      {
         // method body index: 154 method index: 154
         return this._bButtonDisabled;
      }
      
      public function set ButtonDisabled(param1:Boolean) : *
      {
         // method body index: 155 method index: 155
         if(this._bButtonDisabled != param1)
         {
            this._bButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonEnabled() : Boolean
      {
         // method body index: 156 method index: 156
         return !this.ButtonDisabled;
      }
      
      public function set ButtonEnabled(param1:Boolean) : void
      {
         // method body index: 157 method index: 157
         this.ButtonDisabled = !param1;
      }
      
      public function get SecondaryButtonDisabled() : Boolean
      {
         // method body index: 158 method index: 158
         return this._bSecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonDisabled(param1:Boolean) : *
      {
         // method body index: 159 method index: 159
         if(this._bSecondaryButtonDisabled != param1)
         {
            this._bSecondaryButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get SecondaryButtonEnabled() : Boolean
      {
         // method body index: 160 method index: 160
         return !this.SecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonEnabled(param1:Boolean) : void
      {
         // method body index: 161 method index: 161
         this.SecondaryButtonDisabled = !param1;
      }
      
      public function get ButtonText() : String
      {
         // method body index: 162 method index: 162
         return this._strButtonText;
      }
      
      public function set ButtonText(param1:String) : void
      {
         // method body index: 163 method index: 163
         if(this._strButtonText != param1)
         {
            this._strButtonText = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonVisible() : Boolean
      {
         // method body index: 164 method index: 164
         return this._bButtonVisible;
      }
      
      public function set ButtonVisible(param1:Boolean) : void
      {
         // method body index: 165 method index: 165
         if(this._bButtonVisible != param1)
         {
            this._bButtonVisible = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonFlashing() : Boolean
      {
         // method body index: 166 method index: 166
         return this._bButtonFlashing;
      }
      
      public function set ButtonFlashing(param1:Boolean) : void
      {
         // method body index: 167 method index: 167
         if(this._bButtonFlashing != param1)
         {
            this._bButtonFlashing = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get hasSecondaryButton() : Boolean
      {
         // method body index: 168 method index: 168
         return this._hasSecondaryButton;
      }
      
      private function AnnounceDataChange() : void
      {
         // method body index: 169 method index: 169
         dispatchEvent(new Event(BUTTON_HINT_DATA_CHANGE));
         if(this.onAnnounceDataChange is Function)
         {
            this.onAnnounceDataChange();
         }
      }
      
      private function onAnnounceDataChange_Impl() : void
      {
         // method body index: 170 method index: 170
      }
      
      public function SetButtons(param1:String, param2:String, param3:String) : *
      {
         // method body index: 171 method index: 171
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
         // method body index: 172 method index: 172
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
         // method body index: 173 method index: 173
         this._secondaryButtonCallback = param1;
      }
      
      private function onTextClick_Impl() : void
      {
         // method body index: 174 method index: 174
         if(this._callbackFunction is Function)
         {
            this._callbackFunction.call();
         }
      }
      
      private function onSecondaryButtonClick_Impl() : void
      {
         // method body index: 175 method index: 175
         if(this._secondaryButtonCallback is Function)
         {
            this._secondaryButtonCallback.call();
         }
      }
   }
}
