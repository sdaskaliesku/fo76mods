 
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

         this.AltMenuName = new String();
         super();
         this.SWF = null;
         this.menuLoader = new Loader();
      }
      
      private function getIconClip(aIcon:String, aPathPrefix:String = "", defaultIcon:String = null) : MovieClip
      {

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

         this.ClipAlpha = aClipAlpha;
      }
      
      public function set clipScale(aClipScale:Number) : *
      {

         this.ClipScale = aClipScale;
      }
      
      public function set clipRotation(aClipRotation:Number) : *
      {

         this.ClipRotation = aClipRotation;
      }
      
      public function set clipWidth(aClipWidth:Number) : *
      {

         this.ClipWidth = aClipWidth;
      }
      
      public function set clipHeight(aClipHeight:Number) : *
      {

         this.ClipHeight = aClipHeight;
      }
      
      public function get clipWidth() : Number
      {

         return this.ClipWidth;
      }
      
      public function get clipHeight() : Number
      {

         return this.ClipHeight;
      }
      
      public function get clipScale() : Number
      {

         return this.ClipScale;
      }
      
      public function set clipYOffset(aOffset:Number) : *
      {

         this.ClipYOffset = aOffset;
      }
      
      public function get clipYOffset() : Number
      {

         return this.ClipYOffset;
      }
      
      public function set clipXOffset(aOffset:Number) : *
      {

         this.ClipXOffset = aOffset;
      }
      
      public function get clipXOffset() : Number
      {

         return this.ClipXOffset;
      }
      
      public function set centerClip(aCenterClip:Boolean) : *
      {

         this.CenterClip = aCenterClip;
      }
      
      public function get centerClip() : Boolean
      {

         return this.CenterClip;
      }
      
      public function forceUnload() : *
      {

         if(this.SWF)
         {
            this.SWFUnload(this.SWF);
         }
      }
      
      public function SWFLoad(astrMenuName:String) : void
      {

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

         this.AltMenuName = astrMenuName2;
         this.SWFLoad(astrMenuName1);
      }
      
      private function _ioErrorEventHandler(e:IOErrorEvent) : *
      {

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

         removeChild(arUnloadObj);
         arUnloadObj.loaderInfo.loader.unload();
         this.SWF = null;
      }
   }
}
