 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.SWFLoaderClip;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class ImageFixture extends SWFLoaderClip
   {
      
      private static const DEMAND_IMAGE:String = // method body index: 2688 method index: 2688
      "ImageFixtureManager::DemandImage";
      
      private static const REGISTER_IMAGE:String = // method body index: 2688 method index: 2688
      "ImageFixtureManager::RegisterImage";
      
      private static const UNREGISTER_IMAGE:String = // method body index: 2688 method index: 2688
      "ImageFixtureManager::UnregisterImage";
      
      private static const NONE_LOADED:int = // method body index: 2688 method index: 2688
      0;
      
      private static const SWF_LOADED:int = // method body index: 2688 method index: 2688
      1;
      
      private static const IN_LOADED:int = // method body index: 2688 method index: 2688
      2;
      
      private static const EX_LOADED:int = // method body index: 2688 method index: 2688
      3;
      
      public static const FT_INVALID:int = // method body index: 2688 method index: 2688
      -1;
      
      public static const FT_INTERNAL:int = // method body index: 2688 method index: 2688
      0;
      
      public static const FT_EXTERNAL:int = // method body index: 2688 method index: 2688
      1;
      
      public static const FT_SYMBOL:int = // method body index: 2688 method index: 2688
      2;
       
      
      private var m_State:int = 0;
      
      private var m_ClipInstance:MovieClip = null;
      
      private var m_BitmapInstance:Bitmap = null;
      
      private var m_ImgLoader:Loader;
      
      private var m_Image:String = "";
      
      private var m_BufferName:String = "";
      
      private var m_FixtureType:int = -1;
      
      private var m_OnLoadAttemptComplete:Function;
      
      public function ImageFixture()
      {
         // method body index: 2689 method index: 2689
         this.m_ImgLoader = new Loader();
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStageEvent);
      }
      
      public function set onLoadAttemptComplete(param1:Function) : void
      {
         // method body index: 2690 method index: 2690
         this.m_OnLoadAttemptComplete = param1;
      }
      
      public function set fixtureType(param1:int) : void
      {
         // method body index: 2691 method index: 2691
         this.m_FixtureType = param1;
      }
      
      public function get fixtureType() : int
      {
         // method body index: 2692 method index: 2692
         return this.m_FixtureType;
      }
      
      public function get clipInstance() : MovieClip
      {
         // method body index: 2693 method index: 2693
         return this.m_ClipInstance;
      }
      
      public function get bitmapInstance() : Bitmap
      {
         // method body index: 2694 method index: 2694
         return this.m_BitmapInstance;
      }
      
      public function LoadImageFixtureFromUIData(param1:Object, param2:String) : void
      {
         // method body index: 2695 method index: 2695
         this.fixtureType = param1.fixtureType;
         switch(param1.fixtureType)
         {
            case FT_INTERNAL:
               this.LoadInternal(param1.directory + param1.imageName,param2);
               break;
            case FT_EXTERNAL:
               this.LoadExternal(param1.directory + param1.imageName,param2);
               break;
            case FT_SYMBOL:
               this.LoadSymbol(param1.imageName);
               break;
            default:
               trace("ImageFixture::LoadImageFixtureFromUIData: Fixture type is invalid, cannot load.");
         }
      }
      
      public function LoadSymbol(param1:String) : void
      {
         // method body index: 2696 method index: 2696
         if(this.m_Image != param1 || this.m_State != SWF_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = param1;
            this.m_State = SWF_LOADED;
            this.SymbolHelper(param1);
         }
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function LoadInternal(param1:String, param2:String) : void
      {
         // method body index: 2697 method index: 2697
         if(this.m_Image != param1 || this.m_State != IN_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = param1;
            this.m_State = IN_LOADED;
            this.m_BufferName = param2;
            this.LoadBitmap();
         }
         else if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function LoadExternal(param1:String, param2:String) : void
      {
         // method body index: 2698 method index: 2698
         if(this.m_Image != param1 || this.m_State != EX_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = param1;
            this.m_State = EX_LOADED;
            this.m_BufferName = param2;
            this.LoadBitmap();
         }
         else if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function Unload() : *
      {
         // method body index: 2699 method index: 2699
         this.destroyCurrent();
      }
      
      private function destroyCurrent() : void
      {
         // method body index: 2700 method index: 2700
         if(this.m_ClipInstance != null)
         {
            this.removeChild(this.m_ClipInstance);
            this.m_ClipInstance = null;
         }
         this.UnloadBitmap();
         this.m_Image = "";
         this.m_State = NONE_LOADED;
         this.m_BufferName = "";
      }
      
      private function SymbolHelper(param1:String) : void
      {
         // method body index: 2701 method index: 2701
         this.m_ClipInstance = this.setContainerIconClip(param1);
         if(!this.m_ClipInstance)
         {
            trace("ImageFixture: Load Symbol Failure [" + param1 + "]");
            this.destroyCurrent();
         }
      }
      
      private function LoadBitmap() : *
      {
         // method body index: 2702 method index: 2702
         BSUIDataManager.dispatchEvent(new CustomEvent(DEMAND_IMAGE,{
            "imageName":this.m_Image,
            "isExternal":this.m_State == EX_LOADED,
            "bufferName":this.m_BufferName
         }));
         this.m_ImgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         this.m_ImgLoader.load(new URLRequest("img://" + this.m_Image));
      }
      
      private function UnloadBitmap() : *
      {
         // method body index: 2703 method index: 2703
         if(this.m_BitmapInstance != null)
         {
            this.removeChild(this.m_BitmapInstance);
            this.m_BitmapInstance = null;
            BSUIDataManager.dispatchEvent(new CustomEvent(UNREGISTER_IMAGE,{
               "imageName":this.m_Image,
               "isExternal":this.m_State == EX_LOADED,
               "bufferName":this.m_BufferName
            }));
         }
      }
      
      private function onBitmapLoadFailed(param1:Event) : void
      {
         // method body index: 2704 method index: 2704
         trace("WARNING: ImageFixture:onBitmapLoadFailed | " + this.m_Image);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      private function onBitmapLoaded(param1:Event) : void
      {
         // method body index: 2705 method index: 2705
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         BSUIDataManager.dispatchEvent(new CustomEvent(REGISTER_IMAGE,{
            "imageName":this.m_Image,
            "isExternal":this.m_State == EX_LOADED,
            "bufferName":this.m_BufferName
         }));
         this.m_BitmapInstance = param1.target.content;
         if(this.m_BitmapInstance != null)
         {
            this.m_BitmapInstance.smoothing = true;
         }
         this.addChild(this.m_BitmapInstance);
         this.m_BitmapInstance.scaleX = ClipScale;
         this.m_BitmapInstance.scaleY = ClipScale;
         if(ClipWidth != 0)
         {
            this.m_BitmapInstance.width = ClipWidth;
         }
         if(ClipHeight != 0)
         {
            this.m_BitmapInstance.height = ClipHeight;
         }
         if(CenterClip)
         {
            this.m_BitmapInstance.x = this.m_BitmapInstance.x - ClipWidth / 2;
            this.m_BitmapInstance.y = this.m_BitmapInstance.y - ClipHeight / 2;
         }
         this.m_BitmapInstance.x = this.m_BitmapInstance.x + ClipXOffset;
         this.m_BitmapInstance.y = this.m_BitmapInstance.y + ClipYOffset;
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      private function onRemoveFromStageEvent(param1:Event) : void
      {
         // method body index: 2706 method index: 2706
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStageEvent);
         this.destroyCurrent();
      }
   }
}
