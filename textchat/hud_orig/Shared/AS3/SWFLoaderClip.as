 
package Shared.AS3
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.utils.getDefinitionByName;
   
   public class SWFLoaderClip extends MovieClip
   {
       
      
      var SWF:DisplayObject;
      
      var menuLoader:Loader;
      
      protected var ClipAlpha:Number = 0.65;
      
      protected var ClipScale:Number = 0.5;
      
      protected var ClipRotation:Number = 0;
      
      protected var ClipWidth:Number = 0;
      
      protected var ClipHeight:Number = 0;
      
      protected var ClipXOffset:Number = 0;
      
      protected var ClipYOffset:Number = 0;
      
      protected var CenterClip:Boolean = false;
      
      var AltMenuName:String;
      
      public function SWFLoaderClip()
      {
         // method body index: 2385 method index: 2385
         this.AltMenuName = new String();
         super();
         this.SWF = null;
         this.menuLoader = new Loader();
      }
      
      private function getIconClip(aIcon:String, aPathPrefix:String = "", defaultIcon:String = null) : MovieClip
      {
         // method body index: 2386 method index: 2386
         var iconObject:Object = null;
         var iconInstance:MovieClip = null;
         if(defaultIcon != null && (aIcon == null || aIcon.length <= 0))
         {
            aIcon = defaultIcon;
         }
         if(aIcon != null && aIcon.length > 0)
         {
            this.forceUnload();
            if(ApplicationDomain.currentDomain.hasDefinition(aIcon))
            {
               iconObject = getDefinitionByName(aIcon) as Class;
               if(iconObject != null)
               {
                  iconInstance = new iconObject() as MovieClip;
                  return iconInstance;
               }
            }
            else
            {
               this.SWFLoad(aPathPrefix + aIcon);
            }
         }
         return null;
      }
      
      public function setContainerIconClip(aIcon:String, aPathPrefix:String = "", aDefaultIcon:String = null) : MovieClip
      {
         // method body index: 2387 method index: 2387
         var iconInstance:MovieClip = this.getIconClip(aIcon,aPathPrefix,aDefaultIcon);
         if(iconInstance != null)
         {
            addChild(iconInstance);
            iconInstance.scaleX = this.ClipScale;
            iconInstance.scaleY = this.ClipScale;
            if(this.ClipWidth != 0)
            {
               iconInstance.width = this.ClipWidth;
            }
            if(this.ClipHeight != 0)
            {
               iconInstance.height = this.ClipHeight;
            }
         }
         else
         {
            trace("Invalid Icon: Could not find image for path \'" + aIcon + "\'");
         }
         return iconInstance;
      }
      
      public function set clipAlpha(aClipAlpha:Number) : *
      {
         // method body index: 2388 method index: 2388
         this.ClipAlpha = aClipAlpha;
      }
      
      public function set clipScale(aClipScale:Number) : *
      {
         // method body index: 2389 method index: 2389
         this.ClipScale = aClipScale;
      }
      
      public function set clipRotation(aClipRotation:Number) : *
      {
         // method body index: 2390 method index: 2390
         this.ClipRotation = aClipRotation;
      }
      
      public function set clipWidth(aClipWidth:Number) : *
      {
         // method body index: 2391 method index: 2391
         this.ClipWidth = aClipWidth;
      }
      
      public function set clipHeight(aClipHeight:Number) : *
      {
         // method body index: 2392 method index: 2392
         this.ClipHeight = aClipHeight;
      }
      
      public function get clipWidth() : Number
      {
         // method body index: 2393 method index: 2393
         return this.ClipWidth;
      }
      
      public function get clipHeight() : Number
      {
         // method body index: 2394 method index: 2394
         return this.ClipHeight;
      }
      
      public function get clipScale() : Number
      {
         // method body index: 2395 method index: 2395
         return this.ClipScale;
      }
      
      public function set clipYOffset(aOffset:Number) : *
      {
         // method body index: 2396 method index: 2396
         this.ClipYOffset = aOffset;
      }
      
      public function get clipYOffset() : Number
      {
         // method body index: 2397 method index: 2397
         return this.ClipYOffset;
      }
      
      public function set clipXOffset(aOffset:Number) : *
      {
         // method body index: 2398 method index: 2398
         this.ClipXOffset = aOffset;
      }
      
      public function get clipXOffset() : Number
      {
         // method body index: 2399 method index: 2399
         return this.ClipXOffset;
      }
      
      public function set centerClip(aCenterClip:Boolean) : *
      {
         // method body index: 2400 method index: 2400
         this.CenterClip = aCenterClip;
      }
      
      public function get centerClip() : Boolean
      {
         // method body index: 2401 method index: 2401
         return this.CenterClip;
      }
      
      public function forceUnload() : *
      {
         // method body index: 2402 method index: 2402
         if(this.SWF)
         {
            this.SWFUnload(this.SWF);
         }
      }
      
      public function SWFLoad(astrMenuName:String) : void
      {
         // method body index: 2403 method index: 2403
         try
         {
            this.menuLoader.close();
         }
         catch(e:Error)
         {
         }
         if(this.SWF)
         {
            this.SWFUnload(this.SWF);
         }
         var menuLoadRequest:URLRequest = new URLRequest(astrMenuName + ".swf");
         this.menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onMenuLoadComplete);
         this.menuLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this._ioErrorEventHandler,false,0,true);
         this.menuLoader.load(menuLoadRequest);
      }
      
      public function SWFLoadAlt(astrMenuName1:String, astrMenuName2:String) : *
      {
         // method body index: 2404 method index: 2404
         this.AltMenuName = astrMenuName2;
         this.SWFLoad(astrMenuName1);
      }
      
      private function _ioErrorEventHandler(e:IOErrorEvent) : *
      {
         // method body index: 2405 method index: 2405
         if(this.AltMenuName.length > 0)
         {
            this.SWFLoad(this.AltMenuName);
         }
         else
         {
            trace("Failed to load .swf. " + new Error().getStackTrace());
         }
      }
      
      public function onMenuLoadComplete(loadCompleteEvent:Event) : void
      {
         // method body index: 2406 method index: 2406
         this.SWF = loadCompleteEvent.currentTarget.content;
         addChild(this.SWF);
         this.SWF.scaleX = this.ClipScale;
         this.SWF.scaleY = this.ClipScale;
         this.SWF.alpha = this.ClipAlpha;
         if(this.ClipWidth != 0)
         {
            this.SWF.width = this.ClipWidth;
         }
         if(this.ClipHeight != 0)
         {
            this.SWF.height = this.ClipHeight;
         }
         if(this.CenterClip)
         {
            this.SWF.x = this.SWF.width * -0.5;
            this.SWF.y = this.SWF.height * -0.5;
         }
         this.SWF.x = this.SWF.x + this.ClipXOffset;
         this.SWF.y = this.SWF.y + this.ClipYOffset;
      }
      
      public function SWFUnload(arUnloadObj:DisplayObject) : void
      {
         // method body index: 2407 method index: 2407
         removeChild(arUnloadObj);
         arUnloadObj.loaderInfo.loader.unload();
         this.SWF = null;
      }
   }
}
