 
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

         return this.m_EndAnimFrame;
      }
      
      public function FadeIn() : *
      {

         if(!this._fadeInStarted)
         {
            visible = true;
            this._fadeInStarted = true;
            gotoAndPlay("FadeIn");
         }
      }
      
      public function FastFadeOut() : *
      {

         this._fadeOutStarted = true;
         this._fastFadeOutStarted = true;
         gotoAndPlay("FastFadeOut");
      }
      
      public function FadeOut() : *
      {

         this._fadeOutStarted = true;
         gotoAndPlay("FadeOut");
      }
      
      public function get fadeInStarted() : Boolean
      {

         return this._fadeInStarted;
      }
      
      public function get fadeOutStarted() : Boolean
      {

         return this._fadeOutStarted;
      }
      
      public function get fullyFadedIn() : Boolean
      {

         return this._fullyFadedIn;
      }
      
      public function get fullyFadedOut() : Boolean
      {

         return this._fullyFadedOut;
      }
      
      public function ResetFadeState() : *
      {

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

         return !this.fadeInStarted && !bIsDirty;
      }
      
      public function CanFastFadeOut() : Boolean
      {

         return this._fullyFadedIn && !this._fastFadeOutStarted && !bIsDirty;
      }
      
      public function CanFadeOut() : Boolean
      {

         return this._fullyFadedIn && !this._fadeOutStarted && !bIsDirty;
      }
      
      protected function OnFastFadeOutStarted() : *
      {

         this._fastFadeOutStarted = true;
      }
      
      protected function OnFadeInComplete() : *
      {

         this._fullyFadedIn = true;
      }
      
      protected function OnFadeOutComplete() : *
      {

         visible = false;
         this._fullyFadedOut = true;
      }
   }
}
