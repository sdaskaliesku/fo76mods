 
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
      
      public static const MOD_SAY:int = // method body index: 2509 method index: 2509
      0;
      
      public static const MOD_SHOUT:int = // method body index: 2509 method index: 2509
      1;
      
      public static const MOD_ASK:int = // method body index: 2509 method index: 2509
      2;
      
      public static const MOD_BOAST:int = // method body index: 2509 method index: 2509
      3;
      
      public static const MOD_THOUGHT:int = // method body index: 2509 method index: 2509
      4;
      
      public static const MOD_PROMPT:int = // method body index: 2509 method index: 2509
      5;
      
      private static const ANIM_TIME:Number = // method body index: 2509 method index: 2509
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
      
      public static function getModPath(param1:int) : String
      {

         var _loc2_:String = "";
         switch(param1)
         {
            case MOD_SAY:
               _loc2_ = "modSay";
               break;
            case MOD_SHOUT:
               _loc2_ = "modShout";
               break;
            case MOD_ASK:
               _loc2_ = "modAsk";
               break;
            case MOD_BOAST:
               _loc2_ = "modBoast";
               break;
            case MOD_THOUGHT:
               _loc2_ = "modThought";
         }
         return _loc2_;
      }
      
      public function set visAlpha(param1:Number) : void
      {

         this.m_VisAlpha = param1;
         if(this.m_FadeTween != null)
         {
            this.m_FadeTween.stop();
         }
         if(this.m_ImageInstance != null)
         {
            this.m_FadeTween = new Tween(this,"imageAlpha",None.easeNone,this.m_ImageInstance.alpha,this.m_VisAlpha,ANIM_TIME / 1000,true);
         }
      }
      
      public function set removed(param1:Boolean) : void
      {

         this.m_Removed = param1;
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
      
      public function set showMod(param1:Boolean) : void
      {

         if(!param1 && param1 != this.m_ShowMod)
         {
            this.m_HideModTween = new Tween(this.m_ModInstance,"alpha",None.easeNone,this.m_VisAlpha,0,ANIM_TIME / 1000,true);
         }
         this.m_ShowMod = param1;
      }
      
      public function get removed() : Boolean
      {

         return this.m_Removed;
      }
      
      private function set imageAlpha(param1:Number) : void
      {

         if(this.m_ImageInstance != null)
         {
            this.m_ImageInstance.alpha = param1;
         }
         if(this.m_ShowMod && this.m_ModInstance != null)
         {
            this.m_ModInstance.alpha = param1;
         }
      }
      
      public function clearTweens(param1:Boolean = false) : void
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
      
      public function slideX(param1:Number) : void
      {

         if(!this.m_InitialPos)
         {
            this.x = param1;
            this.m_InitialPos = true;
         }
         else
         {
            this.clearTweens();
            this.m_SlideTween = new Tween(this,"x",Regular.easeInOut,this.x,param1,ANIM_TIME / 1000,true);
         }
      }
      
      public function set image(param1:String) : void
      {

         this.m_Image = param1;
         if(this.m_ImageInstance != null)
         {
            this.Image_mc.removeChild(this.m_ImageInstance);
            this.m_ImageInstance = null;
         }
         this.m_ImageInstance = this.Image_mc.setContainerIconClip(param1,"Components\\Emotes");
         if(this.m_ImageInstance != null)
         {
            this.m_ImageInstance.alpha = 0;
         }
      }
      
      public function get image() : String
      {

         return this.m_Image;
      }
      
      public function set mod(param1:int) : void
      {

         this.m_Mod = param1;
         if(this.m_ModInstance != null)
         {
            this.Mod_mc.removeChild(this.m_ModInstance);
            this.m_ModInstance = null;
         }
         this.m_ModInstance = this.Mod_mc.setContainerIconClip(getModPath(param1),"Components\\Emotes");
         if(this.m_ModInstance != null)
         {
            this.m_ModInstance.alpha = 0;
         }
      }
      
      public function get mod() : int
      {

         return this.m_Mod;
      }
      
      public function set parentWidget(param1:EmoteWidget) : void
      {

         this.m_ParentWidget = param1;
      }
      
      public function requestRemoval() : void
      {

         this.m_ParentWidget.removeEntry(this,!this.m_RemoveFromTimer);
      }
      
      public function hide(param1:Boolean = true) : void
      {

         this.m_RemoveFromTimer = param1;
         if(this.m_Timeout != -1)
         {
            clearTimeout(this.m_Timeout);
         }
         this.clearTweens();
         this.m_Removed = true;
         this.m_Timeout = setTimeout(this.requestRemoval,ANIM_TIME);
         this.m_FadeTween = new Tween(this,"imageAlpha",None.easeNone,this.m_VisAlpha,0,ANIM_TIME / 1000,true);
      }
      
      public function set timeout(param1:int) : void
      {

         if(this.m_Timeout != -1)
         {
            clearTimeout(this.m_Timeout);
         }
         this.m_Timeout = setTimeout(this.hide,param1 * 1000);
      }
   }
}
