 
package
{
   import Shared.AS3.BSUIComponent;
   
   public dynamic class HUDFadingListItem extends BSUIComponent
   {
      
      private static const FADE_STATE_OUT:int = // method body index: 3109 method index: 3109
      0;
      
      private static const FADE_STATE_IN:int = // method body index: 3109 method index: 3109
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
         // method body index: 3110 method index: 3110
         var _loc1_:int = 0;
         super();
         this._fadeInStarted = false;
         this._fullyFadedIn = false;
         this._fastFadeOutStarted = false;
         this._fadeOutStarted = false;
         this._fullyFadedOut = false;
         this.m_EndAnimFrame = this.totalFrames;
         while(_loc1_ < this.currentLabels.length)
         {
            if(this.currentLabels[_loc1_].name == "endAnim")
            {
               this.m_EndAnimFrame = this.currentLabels[_loc1_].frame;
               break;
            }
            _loc1_++;
         }
      }
      
      public function get endAnimFrame() : int
      {
         // method body index: 3111 method index: 3111
         return this.m_EndAnimFrame;
      }
      
      public function FadeIn() : *
      {
         // method body index: 3112 method index: 3112
         if(!this._fadeInStarted)
         {
            visible = true;
            this._fadeInStarted = true;
            gotoAndPlay("FadeIn");
         }
      }
      
      public function FastFadeOut() : *
      {
         // method body index: 3113 method index: 3113
         this._fadeOutStarted = true;
         this._fastFadeOutStarted = true;
         gotoAndPlay("FastFadeOut");
      }
      
      public function FadeOut() : *
      {
         // method body index: 3114 method index: 3114
         this._fadeOutStarted = true;
         gotoAndPlay("FadeOut");
      }
      
      public function get fadeInStarted() : Boolean
      {
         // method body index: 3115 method index: 3115
         return this._fadeInStarted;
      }
      
      public function get fadeOutStarted() : Boolean
      {
         // method body index: 3116 method index: 3116
         return this._fadeOutStarted;
      }
      
      public function get fullyFadedIn() : Boolean
      {
         // method body index: 3117 method index: 3117
         return this._fullyFadedIn;
      }
      
      public function get fullyFadedOut() : Boolean
      {
         // method body index: 3118 method index: 3118
         return this._fullyFadedOut;
      }
      
      public function ResetFadeState() : *
      {
         // method body index: 3119 method index: 3119
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
         // method body index: 3120 method index: 3120
         return !this.fadeInStarted && !bIsDirty;
      }
      
      public function CanFastFadeOut() : Boolean
      {
         // method body index: 3121 method index: 3121
         return this._fullyFadedIn && !this._fastFadeOutStarted && !bIsDirty;
      }
      
      public function CanFadeOut() : Boolean
      {
         // method body index: 3122 method index: 3122
         return this._fullyFadedIn && !this._fadeOutStarted && !bIsDirty;
      }
      
      protected function OnFastFadeOutStarted() : *
      {
         // method body index: 3123 method index: 3123
         this._fastFadeOutStarted = true;
      }
      
      protected function OnFadeInComplete() : *
      {
         // method body index: 3124 method index: 3124
         this._fullyFadedIn = true;
      }
      
      protected function OnFadeOutComplete() : *
      {
         // method body index: 3125 method index: 3125
         visible = false;
         this._fullyFadedOut = true;
      }
   }
}
