 
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
         // method body index: 2311 method index: 2311
         this.AltMenuName = new String();
         super();
         this.SWF = null;
         this.menuLoader = new Loader();
      }
      
      private function getIconClip(param1:String, param2:String = "", param3:String = null) : MovieClip
      {
         // method body index: 2312 method index: 2312
         var _loc4_:Object = null;
         var _loc5_:MovieClip = null;
         if(param3 != null && (param1 == null || param1.length <= 0))
         {
            param1 = param3;
         }
         if(param1 != null && param1.length > 0)
         {
            this.forceUnload();
            if(ApplicationDomain.currentDomain.hasDefinition(param1))
            {
               _loc4_ = getDefinitionByName(param1) as Class;
               if(_loc4_ != null)
               {
                  _loc5_ = new _loc4_() as MovieClip;
                  return _loc5_;
               }
            }
            else
            {
               this.SWFLoad(param2 + param1);
            }
         }
         return null;
      }
      
      public function setContainerIconClip(param1:String, param2:String = "", param3:String = null) : MovieClip
      {
         // method body index: 2313 method index: 2313
         var _loc4_:MovieClip = this.getIconClip(param1,param2,param3);
         if(_loc4_ != null)
         {
            addChild(_loc4_);
            _loc4_.scaleX = this.ClipScale;
            _loc4_.scaleY = this.ClipScale;
            if(this.ClipWidth != 0)
            {
               _loc4_.width = this.ClipWidth;
            }
            if(this.ClipHeight != 0)
            {
               _loc4_.height = this.ClipHeight;
            }
         }
         else
         {
            trace("Invalid Icon: Could not find image for path \'" + param1 + "\'");
         }
         return _loc4_;
      }
      
      public function set clipAlpha(param1:Number) : *
      {
         // method body index: 2314 method index: 2314
         this.ClipAlpha = param1;
      }
      
      public function set clipScale(param1:Number) : *
      {
         // method body index: 2315 method index: 2315
         this.ClipScale = param1;
      }
      
      public function set clipRotation(param1:Number) : *
      {
         // method body index: 2316 method index: 2316
         this.ClipRotation = param1;
      }
      
      public function set clipWidth(param1:Number) : *
      {
         // method body index: 2317 method index: 2317
         this.ClipWidth = param1;
      }
      
      public function set clipHeight(param1:Number) : *
      {
         // method body index: 2318 method index: 2318
         this.ClipHeight = param1;
      }
      
      public function get clipWidth() : Number
      {
         // method body index: 2319 method index: 2319
         return this.ClipWidth;
      }
      
      public function get clipHeight() : Number
      {
         // method body index: 2320 method index: 2320
         return this.ClipHeight;
      }
      
      public function get clipScale() : Number
      {
         // method body index: 2321 method index: 2321
         return this.ClipScale;
      }
      
      public function set clipYOffset(param1:Number) : *
      {
         // method body index: 2322 method index: 2322
         this.ClipYOffset = param1;
      }
      
      public function get clipYOffset() : Number
      {
         // method body index: 2323 method index: 2323
         return this.ClipYOffset;
      }
      
      public function set clipXOffset(param1:Number) : *
      {
         // method body index: 2324 method index: 2324
         this.ClipXOffset = param1;
      }
      
      public function get clipXOffset() : Number
      {
         // method body index: 2325 method index: 2325
         return this.ClipXOffset;
      }
      
      public function set centerClip(param1:Boolean) : *
      {
         // method body index: 2326 method index: 2326
         this.CenterClip = param1;
      }
      
      public function get centerClip() : Boolean
      {
         // method body index: 2327 method index: 2327
         return this.CenterClip;
      }
      
      public function forceUnload() : *
      {
         // method body index: 2328 method index: 2328
         if(this.SWF)
         {
            this.SWFUnload(this.SWF);
         }
      }
      
      public function SWFLoad(param1:String) : void
      {
         // method body index: 2329 method index: 2329
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
         var _loc2_:URLRequest = new URLRequest(param1 + ".swf");
         this.menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onMenuLoadComplete);
         this.menuLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this._ioErrorEventHandler,false,0,true);
         this.menuLoader.load(_loc2_);
      }
      
      public function SWFLoadAlt(param1:String, param2:String) : *
      {
         // method body index: 2330 method index: 2330
         this.AltMenuName = param2;
         this.SWFLoad(param1);
      }
      
      private function _ioErrorEventHandler(param1:IOErrorEvent) : *
      {
         // method body index: 2331 method index: 2331
         if(this.AltMenuName.length > 0)
         {
            this.SWFLoad(this.AltMenuName);
         }
         else
         {
            trace("Failed to load .swf. " + new Error().getStackTrace());
         }
      }
      
      public function onMenuLoadComplete(param1:Event) : void
      {
         // method body index: 2332 method index: 2332
         this.SWF = param1.currentTarget.content;
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
      
      public function SWFUnload(param1:DisplayObject) : void
      {
         // method body index: 2333 method index: 2333
         removeChild(param1);
         param1.loaderInfo.loader.unload();
         this.SWF = null;
      }
   }
}
