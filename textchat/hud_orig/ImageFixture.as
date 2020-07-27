 
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
      
      private static const DEMAND_IMAGE:String = // method body index: 2750 method index: 2750
      "ImageFixtureManager::DemandImage";
      
      private static const REGISTER_IMAGE:String = // method body index: 2750 method index: 2750
      "ImageFixtureManager::RegisterImage";
      
      private static const UNREGISTER_IMAGE:String = // method body index: 2750 method index: 2750
      "ImageFixtureManager::UnregisterImage";
      
      private static const NONE_LOADED:int = // method body index: 2750 method index: 2750
      0;
      
      private static const SWF_LOADED:int = // method body index: 2750 method index: 2750
      1;
      
      private static const IN_LOADED:int = // method body index: 2750 method index: 2750
      2;
      
      private static const EX_LOADED:int = // method body index: 2750 method index: 2750
      3;
      
      public static const FT_INVALID:int = // method body index: 2750 method index: 2750
      -1;
      
      public static const FT_INTERNAL:int = // method body index: 2750 method index: 2750
      0;
      
      public static const FT_EXTERNAL:int = // method body index: 2750 method index: 2750
      1;
      
      public static const FT_SYMBOL:int = // method body index: 2750 method index: 2750
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
         // method body index: 2751 method index: 2751
         this.m_ImgLoader = new Loader();
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStageEvent);
      }
      
      public function set onLoadAttemptComplete(aFunc:Function) : void
      {
         // method body index: 2752 method index: 2752
         this.m_OnLoadAttemptComplete = aFunc;
      }
      
      public function set fixtureType(aType:int) : void
      {
         // method body index: 2753 method index: 2753
         this.m_FixtureType = aType;
      }
      
      public function get fixtureType() : int
      {
         // method body index: 2754 method index: 2754
         return this.m_FixtureType;
      }
      
      public function get clipInstance() : MovieClip
      {
         // method body index: 2755 method index: 2755
         return this.m_ClipInstance;
      }
      
      public function get bitmapInstance() : Bitmap
      {
         // method body index: 2756 method index: 2756
         return this.m_BitmapInstance;
      }
      
      public function LoadImageFixtureFromUIData(aObj:Object, aBufferName:String) : void
      {
         // method body index: 2757 method index: 2757
         this.fixtureType = aObj.fixtureType;
         switch(aObj.fixtureType)
         {
            case FT_INTERNAL:
               this.LoadInternal(aObj.directory + aObj.imageName,aBufferName);
               break;
            case FT_EXTERNAL:
               this.LoadExternal(aObj.directory + aObj.imageName,aBufferName);
               break;
            case FT_SYMBOL:
               this.LoadSymbol(aObj.imageName);
               break;
            default:
               trace("ImageFixture::LoadImageFixtureFromUIData: Fixture type is invalid, cannot load.");
         }
      }
      
      public function LoadSymbol(aImage:String) : void
      {
         // method body index: 2758 method index: 2758
         if(this.m_Image != aImage || this.m_State != SWF_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = aImage;
            this.m_State = SWF_LOADED;
            this.SymbolHelper(aImage);
         }
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function LoadInternal(aImage:String, aBufferName:String) : void
      {
         // method body index: 2759 method index: 2759
         if(this.m_Image != aImage || this.m_State != IN_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = aImage;
            this.m_State = IN_LOADED;
            this.m_BufferName = aBufferName;
            this.LoadBitmap();
         }
         else if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function LoadExternal(aImage:String, aBufferName:String) : void
      {
         // method body index: 2760 method index: 2760
         if(this.m_Image != aImage || this.m_State != EX_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = aImage;
            this.m_State = EX_LOADED;
            this.m_BufferName = aBufferName;
            this.LoadBitmap();
         }
         else if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function Unload() : *
      {
         // method body index: 2761 method index: 2761
         this.destroyCurrent();
      }
      
      private function destroyCurrent() : void
      {
         // method body index: 2762 method index: 2762
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
      
      private function SymbolHelper(aImage:String) : void
      {
         // method body index: 2763 method index: 2763
         this.m_ClipInstance = this.setContainerIconClip(aImage);
         if(!this.m_ClipInstance)
         {
            trace("ImageFixture: Load Symbol Failure [" + aImage + "]");
            this.destroyCurrent();
         }
      }
      
      private function LoadBitmap() : *
      {
         // method body index: 2764 method index: 2764
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
         // method body index: 2765 method index: 2765
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
      
      private function onBitmapLoadFailed(e:Event) : void
      {
         // method body index: 2766 method index: 2766
         trace("WARNING: ImageFixture:onBitmapLoadFailed | " + this.m_Image);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      private function onBitmapLoaded(e:Event) : void
      {
         // method body index: 2767 method index: 2767
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         BSUIDataManager.dispatchEvent(new CustomEvent(REGISTER_IMAGE,{
            "imageName":this.m_Image,
            "isExternal":this.m_State == EX_LOADED,
            "bufferName":this.m_BufferName
         }));
         this.m_BitmapInstance = e.target.content;
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
      
      private function onRemoveFromStageEvent(e:Event) : void
      {
         // method body index: 2768 method index: 2768
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStageEvent);
         this.destroyCurrent();
      }
   }
}
