 
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
         // method body index: 364 method index: 364
         this.AltMenuName = new String();
         super();
         this.SWF = null;
         this.menuLoader = new Loader();
      }
      
      private function getIconClip(param1:String, param2:String = "", param3:String = null) : MovieClip
      {
         // method body index: 365 method index: 365
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
         // method body index: 366 method index: 366
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
         // method body index: 367 method index: 367
         this.ClipAlpha = param1;
      }
      
      public function set clipScale(param1:Number) : *
      {
         // method body index: 368 method index: 368
         this.ClipScale = param1;
      }
      
      public function set clipRotation(param1:Number) : *
      {
         // method body index: 369 method index: 369
         this.ClipRotation = param1;
      }
      
      public function set clipWidth(param1:Number) : *
      {
         // method body index: 370 method index: 370
         this.ClipWidth = param1;
      }
      
      public function set clipHeight(param1:Number) : *
      {
         // method body index: 371 method index: 371
         this.ClipHeight = param1;
      }
      
      public function get clipWidth() : Number
      {
         // method body index: 372 method index: 372
         return this.ClipWidth;
      }
      
      public function get clipHeight() : Number
      {
         // method body index: 373 method index: 373
         return this.ClipHeight;
      }
      
      public function get clipScale() : Number
      {
         // method body index: 374 method index: 374
         return this.ClipScale;
      }
      
      public function set clipYOffset(param1:Number) : *
      {
         // method body index: 375 method index: 375
         this.ClipYOffset = param1;
      }
      
      public function get clipYOffset() : Number
      {
         // method body index: 376 method index: 376
         return this.ClipYOffset;
      }
      
      public function set clipXOffset(param1:Number) : *
      {
         // method body index: 377 method index: 377
         this.ClipXOffset = param1;
      }
      
      public function get clipXOffset() : Number
      {
         // method body index: 378 method index: 378
         return this.ClipXOffset;
      }
      
      public function set centerClip(param1:Boolean) : *
      {
         // method body index: 379 method index: 379
         this.CenterClip = param1;
      }
      
      public function get centerClip() : Boolean
      {
         // method body index: 380 method index: 380
         return this.CenterClip;
      }
      
      public function forceUnload() : *
      {
         // method body index: 381 method index: 381
         if(this.SWF)
         {
            this.SWFUnload(this.SWF);
         }
      }
      
      public function SWFLoad(param1:String) : void
      {
         // method body index: 382 method index: 382
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
         // method body index: 383 method index: 383
         this.AltMenuName = param2;
         this.SWFLoad(param1);
      }
      
      private function _ioErrorEventHandler(param1:IOErrorEvent) : *
      {
         // method body index: 384 method index: 384
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
         // method body index: 385 method index: 385
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
         // method body index: 386 method index: 386
         removeChild(param1);
         param1.loaderInfo.loader.unload();
         this.SWF = null;
      }
   }
}
