 
package
{
   import Shared.AS3.SWFLoaderClip;
   import fl.transitions.Tween;
   import fl.transitions.easing.None;
   import fl.transitions.easing.Regular;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class EmoteContainer extends MovieClip
   {
      
      public static const MOD_SAY:int = // method body index: 2571 method index: 2571
      0;
      
      public static const MOD_SHOUT:int = // method body index: 2571 method index: 2571
      1;
      
      public static const MOD_ASK:int = // method body index: 2571 method index: 2571
      2;
      
      public static const MOD_BOAST:int = // method body index: 2571 method index: 2571
      3;
      
      public static const MOD_THOUGHT:int = // method body index: 2571 method index: 2571
      4;
      
      public static const MOD_PROMPT:int = // method body index: 2571 method index: 2571
      5;
      
      private static const ANIM_TIME:Number = // method body index: 2571 method index: 2571
      150;
       
      
      public var Image_mc:SWFLoaderClip;
      
      public var Mod_mc:SWFLoaderClip;
      
      private var m_ImageInstance:MovieClip;
      
      private var m_ModInstance:MovieClip;
      
      private var m_SlideTween:Tween;
      
      private var m_FadeTween:Tween;
      
      private var m_InitialPos:Boolean = false;
      
      private var m_Removed:Boolean = false;
      
      private var m_ShowMod:Boolean = true;
      
      private var m_HideModTween:Tween;
      
      private var m_VisAlpha:Number = 1;
      
      private var m_Image:String;
      
      private var m_Mod:int;
      
      private var m_Timeout:int = -1;
      
      private var m_ParentWidget:EmoteWidget;
      
      private var m_RemoveFromTimer:Boolean = false;
      
      public function EmoteContainer()
      {

         super();
         this.Image_mc.clipScale = 1;
      }
      
      public static function getModPath(aModIndex:int) : String
      {

         var emoteModPath:String = "";
         switch(aModIndex)
         {
            case MOD_SAY:
               emoteModPath = "modSay";
               break;
            case MOD_SHOUT:
               emoteModPath = "modShout";
               break;
            case MOD_ASK:
               emoteModPath = "modAsk";
               break;
            case MOD_BOAST:
               emoteModPath = "modBoast";
               break;
            case MOD_THOUGHT:
               emoteModPath = "modThought";
         }
         return emoteModPath;
      }
      
      public function set visAlpha(aAlpha:Number) : void
      {

         this.m_VisAlpha = aAlpha;
         if(this.m_FadeTween != null)
         {
            this.m_FadeTween.stop();
         }
         if(this.m_ImageInstance != null)
         {
            this.m_FadeTween = new Tween(this,"imageAlpha",None.easeNone,this.m_ImageInstance.alpha,this.m_VisAlpha,ANIM_TIME / 1000,true);
         }
      }
      
      public function set removed(aRemoved:Boolean) : void
      {

         this.m_Removed = aRemoved;
      }
      
      public function get realWidth() : Number
      {

         if(this.m_ImageInstance != null)
         {
            if(this.m_ImageInstance.Sizer_mc != null)
            {
               return this.m_ImageInstance.Sizer_mc.width;
            }
            return this.m_ImageInstance.width;
         }
         return this.Image_mc.width;
      }
      
      public function get realHeight() : Number
      {

         if(this.m_ImageInstance != null)
         {
            if(this.m_ImageInstance.Sizer_mc != null)
            {
               return this.m_ImageInstance.Sizer_mc.height;
            }
            return this.m_ImageInstance.height;
         }
         return this.Image_mc.height;
      }
      
      public function set showMod(aShow:Boolean) : void
      {

         if(!aShow && aShow != this.m_ShowMod)
         {
            this.m_HideModTween = new Tween(this.m_ModInstance,"alpha",None.easeNone,this.m_VisAlpha,0,ANIM_TIME / 1000,true);
         }
         this.m_ShowMod = aShow;
      }
      
      public function get removed() : Boolean
      {

         return this.m_Removed;
      }
      
      private function set imageAlpha(aAlpha:Number) : void
      {

         if(this.m_ImageInstance != null)
         {
            this.m_ImageInstance.alpha = aAlpha;
         }
         if(this.m_ShowMod && this.m_ModInstance != null)
         {
            this.m_ModInstance.alpha = aAlpha;
         }
      }
      
      public function clearTweens(aSetPos:Boolean = false) : void
      {

         if(this.m_SlideTween != null)
         {
            this.m_SlideTween.stop();
            this.x = this.m_SlideTween.finish;
            this.m_SlideTween = null;
         }
         if(this.m_FadeTween != null)
         {
            this.m_FadeTween.stop();
            this.imageAlpha = this.m_FadeTween.finish;
            this.m_FadeTween = null;
         }
      }
      
      public function slideX(newX:Number) : void
      {

         if(!this.m_InitialPos)
         {
            this.x = newX;
            this.m_InitialPos = true;
         }
         else
         {
            this.clearTweens();
            this.m_SlideTween = new Tween(this,"x",Regular.easeInOut,this.x,newX,ANIM_TIME / 1000,true);
         }
      }
      
      public function set image(aImage:String) : void
      {

         this.m_Image = aImage;
         if(this.m_ImageInstance != null)
         {
            this.Image_mc.removeChild(this.m_ImageInstance);
            this.m_ImageInstance = null;
         }
         this.m_ImageInstance = this.Image_mc.setContainerIconClip(aImage,"Components\\Emotes");
         if(this.m_ImageInstance != null)
         {
            this.m_ImageInstance.alpha = 0;
         }
      }
      
      public function get image() : String
      {

         return this.m_Image;
      }
      
      public function set mod(aMod:int) : void
      {

         this.m_Mod = aMod;
         if(this.m_ModInstance != null)
         {
            this.Mod_mc.removeChild(this.m_ModInstance);
            this.m_ModInstance = null;
         }
         this.m_ModInstance = this.Mod_mc.setContainerIconClip(getModPath(aMod),"Components\\Emotes");
         if(this.m_ModInstance != null)
         {
            this.m_ModInstance.alpha = 0;
         }
      }
      
      public function get mod() : int
      {

         return this.m_Mod;
      }
      
      public function set parentWidget(aWidget:EmoteWidget) : void
      {

         this.m_ParentWidget = aWidget;
      }
      
      public function requestRemoval() : void
      {

         this.m_ParentWidget.removeEntry(this,!this.m_RemoveFromTimer);
      }
      
      public function hide(aFromTimer:Boolean = true) : void
      {

         this.m_RemoveFromTimer = aFromTimer;
         if(this.m_Timeout != -1)
         {
            clearTimeout(this.m_Timeout);
         }
         this.clearTweens();
         this.m_Removed = true;
         this.m_Timeout = setTimeout(this.requestRemoval,ANIM_TIME);
         this.m_FadeTween = new Tween(this,"imageAlpha",None.easeNone,this.m_VisAlpha,0,ANIM_TIME / 1000,true);
      }
      
      public function set timeout(aTimeout:int) : void
      {

         if(this.m_Timeout != -1)
         {
            clearTimeout(this.m_Timeout);
         }
         this.m_Timeout = setTimeout(this.hide,aTimeout * 1000);
      }
   }
}
