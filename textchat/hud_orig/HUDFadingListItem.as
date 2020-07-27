 
package
{
   import Shared.AS3.BSUIComponent;
   
   public dynamic class HUDFadingListItem extends BSUIComponent
   {
      
      private static const FADE_STATE_OUT:int = // method body index: 3158 method index: 3158
      0;
      
      private static const FADE_STATE_IN:int = // method body index: 3158 method index: 3158
      1;
       
      
      private var _fadeInStarted:Boolean = false;
      
      private var _fullyFadedIn:Boolean = false;
      
      private var _fadeOutStarted:Boolean = false;
      
      private var _fastFadeOutStarted:Boolean = false;
      
      private var _fullyFadedOut:Boolean = false;
      
      private var _requestedFadeState:int = 0;
      
      private var m_EndAnimFrame:int = 1;
      
      public function HUDFadingListItem()
      {
         // method body index: 3160 method index: 3160
         var i:int = 0;
         super();
         this._fadeInStarted = false;
         this._fullyFadedIn = false;
         this._fastFadeOutStarted = false;
         this._fadeOutStarted = false;
         this._fullyFadedOut = false;
         for(this.m_EndAnimFrame = this.totalFrames; i < this.currentLabels.length; )
         {
            if(this.currentLabels[i].name == "endAnim")
            {
               this.m_EndAnimFrame = this.currentLabels[i].frame;
               break;
            }
            i++;
         }
      }
      
      public function get endAnimFrame() : int
      {
         // method body index: 3159 method index: 3159
         return this.m_EndAnimFrame;
      }
      
      public function FadeIn() : *
      {
         // method body index: 3161 method index: 3161
         if(!this._fadeInStarted)
         {
            visible = true;
            this._fadeInStarted = true;
            gotoAndPlay("FadeIn");
         }
      }
      
      public function FastFadeOut() : *
      {
         // method body index: 3162 method index: 3162
         this._fadeOutStarted = true;
         this._fastFadeOutStarted = true;
         gotoAndPlay("FastFadeOut");
      }
      
      public function FadeOut() : *
      {
         // method body index: 3163 method index: 3163
         this._fadeOutStarted = true;
         gotoAndPlay("FadeOut");
      }
      
      public function get fadeInStarted() : Boolean
      {
         // method body index: 3164 method index: 3164
         return this._fadeInStarted;
      }
      
      public function get fadeOutStarted() : Boolean
      {
         // method body index: 3165 method index: 3165
         return this._fadeOutStarted;
      }
      
      public function get fullyFadedIn() : Boolean
      {
         // method body index: 3166 method index: 3166
         return this._fullyFadedIn;
      }
      
      public function get fullyFadedOut() : Boolean
      {
         // method body index: 3167 method index: 3167
         return this._fullyFadedOut;
      }
      
      public function ResetFadeState() : *
      {
         // method body index: 3168 method index: 3168
         gotoAndPlay("Reset");
         visible = false;
         this._fadeInStarted = false;
         this._fullyFadedIn = false;
         this._fastFadeOutStarted = false;
         this._fadeOutStarted = false;
         this._fullyFadedOut = false;
      }
      
      public function CanFadeIn() : Boolean
      {
         // method body index: 3169 method index: 3169
         return !this.fadeInStarted && !bIsDirty;
      }
      
      public function CanFastFadeOut() : Boolean
      {
         // method body index: 3170 method index: 3170
         return this._fullyFadedIn && !this._fastFadeOutStarted && !bIsDirty;
      }
      
      public function CanFadeOut() : Boolean
      {
         // method body index: 3171 method index: 3171
         return this._fullyFadedIn && !this._fadeOutStarted && !bIsDirty;
      }
      
      protected function OnFastFadeOutStarted() : *
      {
         // method body index: 3172 method index: 3172
         this._fastFadeOutStarted = true;
      }
      
      protected function OnFadeInComplete() : *
      {
         // method body index: 3173 method index: 3173
         this._fullyFadedIn = true;
      }
      
      protected function OnFadeOutComplete() : *
      {
         // method body index: 3174 method index: 3174
         visible = false;
         this._fullyFadedOut = true;
      }
   }
}
