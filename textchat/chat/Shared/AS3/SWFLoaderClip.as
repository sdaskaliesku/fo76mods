 
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
         // method body index: 317 method index: 317
         this.AltMenuName = new String();
         super();
         this.SWF = null;
         this.menuLoader = new Loader();
      }
      
      private function getIconClip(param1:String, param2:String = "", param3:String = null) : MovieClip
      {
         // method body index: 318 method index: 318
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
         // method body index: 319 method index: 319
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
         // method body index: 320 method index: 320
         this.ClipAlpha = param1;
      }
      
      public function set clipScale(param1:Number) : *
      {
         // method body index: 321 method index: 321
         this.ClipScale = param1;
      }
      
      public function set clipRotation(param1:Number) : *
      {
         // method body index: 322 method index: 322
         this.ClipRotation = param1;
      }
      
      public function set clipWidth(param1:Number) : *
      {
         // method body index: 323 method index: 323
         this.ClipWidth = param1;
      }
      
      public function set clipHeight(param1:Number) : *
      {
         // method body index: 324 method index: 324
         this.ClipHeight = param1;
      }
      
      public function get clipWidth() : Number
      {
         // method body index: 325 method index: 325
         return this.ClipWidth;
      }
      
      public function get clipHeight() : Number
      {
         // method body index: 326 method index: 326
         return this.ClipHeight;
      }
      
      public function get clipScale() : Number
      {
         // method body index: 327 method index: 327
         return this.ClipScale;
      }
      
      public function set clipYOffset(param1:Number) : *
      {
         // method body index: 328 method index: 328
         this.ClipYOffset = param1;
      }
      
      public function get clipYOffset() : Number
      {
         // method body index: 329 method index: 329
         return this.ClipYOffset;
      }
      
      public function set clipXOffset(param1:Number) : *
      {
         // method body index: 330 method index: 330
         this.ClipXOffset = param1;
      }
      
      public function get clipXOffset() : Number
      {
         // method body index: 331 method index: 331
         return this.ClipXOffset;
      }
      
      public function set centerClip(param1:Boolean) : *
      {
         // method body index: 332 method index: 332
         this.CenterClip = param1;
      }
      
      public function get centerClip() : Boolean
      {
         // method body index: 333 method index: 333
         return this.CenterClip;
      }
      
      public function forceUnload() : *
      {
         // method body index: 334 method index: 334
         if(this.SWF)
         {
            this.SWFUnload(this.SWF);
         }
      }
      
      public function SWFLoad(param1:String) : void
      {
         // method body index: 335 method index: 335
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
         // method body index: 336 method index: 336
         this.AltMenuName = param2;
         this.SWFLoad(param1);
      }
      
      private function _ioErrorEventHandler(param1:IOErrorEvent) : *
      {
         // method body index: 337 method index: 337
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
         // method body index: 338 method index: 338
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
         // method body index: 339 method index: 339
         removeChild(param1);
         param1.loaderInfo.loader.unload();
         this.SWF = null;
      }
   }
}
