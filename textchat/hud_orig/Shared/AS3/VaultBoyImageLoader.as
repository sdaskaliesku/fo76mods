 
package Shared.AS3
{
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public dynamic class VaultBoyImageLoader extends BSUIComponent
   {
       
      
      public var VaultBoyImageInternal_mc:BSUIComponent;
      
      private var SWF:MovieClip;
      
      private var menuLoader:Loader;
      
      private var _bUseFixedQuestStageSize:Boolean = true;
      
      private var _bPlayClipOnce:Boolean = false;
      
      private var _clipAlignment:String = "TopLeft";
      
      private var _defaultBoySwfName:String = "Components/Quest Vault Boys/Miscellaneous Quests/DefaultBoy.swf";
      
      private var _questAnimStageWidth:Number = 550;
      
      private var _questAnimStageHeight:Number = 400;
      
      private var _maxClipHeight:Number = 160;
      
      public var onLastFrame:Function;
      
      public function VaultBoyImageLoader()
      {

         this.onLastFrame = this.onLastFrame_Impl;
         super();
         this.SWF = null;
         this.menuLoader = null;
      }
      
      public function get bUseFixedQuestStageSize_Inspectable() : Boolean
      {

         return this._bUseFixedQuestStageSize;
      }
      
      public function set bUseFixedQuestStageSize_Inspectable(abUseFixedQuestStageSize:Boolean) : *
      {

         this._bUseFixedQuestStageSize = abUseFixedQuestStageSize;
      }
      
      public function get bPlayClipOnce_Inspectable() : Boolean
      {

         return this._bPlayClipOnce;
      }
      
      public function set bPlayClipOnce_Inspectable(abPlayClipOnce:Boolean) : *
      {

         this._bPlayClipOnce = abPlayClipOnce;
      }
      
      public function get ClipAlignment_Inspectable() : String
      {

         return this._clipAlignment;
      }
      
      public function set ClipAlignment_Inspectable(aClipAlignment:String) : *
      {

         this._clipAlignment = aClipAlignment;
      }
      
      public function get DefaultBoySwfName_Inspectable() : String
      {

         return this._defaultBoySwfName;
      }
      
      public function set DefaultBoySwfName_Inspectable(aDefaultBoySwfName:String) : *
      {

         this._defaultBoySwfName = aDefaultBoySwfName;
      }
      
      public function get questAnimStageWidth_Inspectable() : Number
      {

         return this._questAnimStageWidth;
      }
      
      public function set questAnimStageWidth_Inspectable(aQuestAnimStageWidth:Number) : void
      {

         this._questAnimStageWidth = aQuestAnimStageWidth;
      }
      
      public function get questAnimStageHeight_Inspectable() : Number
      {

         return this._questAnimStageHeight;
      }
      
      public function set questAnimStageHeight_Inspectable(aQuestAnimStageHeight:Number) : void
      {

         this._questAnimStageHeight = aQuestAnimStageHeight;
      }
      
      public function get maxClipHeight_Inspectable() : Number
      {

         return this._maxClipHeight;
      }
      
      public function set maxClipHeight_Inspectable(aMaxClipHeight:Number) : void
      {

         this._maxClipHeight = aMaxClipHeight;
      }
      
      public function SWFLoad(aSwfLoaderURL:String) : void
      {

         this.VaultBoyImageInternal_mc.visible = false;
         if(this.menuLoader)
         {
            this.menuLoader.close();
         }
         this.SWFUnload();
         var loadCompleteCallback:Function = function(loadCompleteEvent:Event):// method body index: 3135 method index: 3135
         *
         {

            onMenuLoadComplete(loadCompleteEvent,aSwfLoaderURL);
         };
         var menuLoadRequest:URLRequest = new URLRequest(!!aSwfLoaderURL?aSwfLoaderURL:this.DefaultBoySwfName_Inspectable);
         this.menuLoader = new Loader();
         this.menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadCompleteCallback);
         this.menuLoader.load(menuLoadRequest);
         SetIsDirty();
      }
      
      public function onMenuLoadComplete(loadCompleteEvent:Event, aSwfLoaderURL:String) : void
      {

         var nextQuestClip:MovieClip = null;
         if(loadCompleteEvent && loadCompleteEvent.currentTarget && loadCompleteEvent.currentTarget.content)
         {
            nextQuestClip = loadCompleteEvent.currentTarget.content as MovieClip;
            nextQuestClip.SwfLoaderURL = aSwfLoaderURL;
            this.SetQuestMovieClip(nextQuestClip);
         }
         else
         {
            this.SWFUnload();
         }
      }
      
      public function SetQuestMovieClip(nextQuestMovieClip:MovieClip) : void
      {

         var bgGraphics:Graphics = null;
         this.VaultBoyImageInternal_mc.visible = true;
         this.SWF = nextQuestMovieClip;
         this.VaultBoyImageInternal_mc.addChild(this.SWF);
         if(this.bPlayClipOnce_Inspectable)
         {
            this.SWF.addEventListener(Event.ENTER_FRAME,this.onSWFEnterFrame);
         }
         if(this.bUseFixedQuestStageSize_Inspectable)
         {
            bgGraphics = this.SWF.graphics;
            bgGraphics.clear();
            bgGraphics.beginFill(0,0);
            bgGraphics.drawRect(0,0,this.questAnimStageWidth_Inspectable,this.questAnimStageHeight_Inspectable);
            bgGraphics.endFill();
         }
         var allowedHeight:Number = this._maxClipHeight;
         var scaleToFit:Number = allowedHeight / this.SWF.height;
         this.SWF.scaleX = scaleToFit;
         this.SWF.scaleY = scaleToFit;
         if(this.ClipAlignment_Inspectable == "Center")
         {
            this.SWF.x = -this.questAnimStageWidth_Inspectable * 0.5 * scaleToFit;
            this.SWF.y = -this.questAnimStageHeight_Inspectable * 0.5 * scaleToFit;
         }
         this.menuLoader = null;
         SetIsDirty();
      }
      
      public function onLastFrame_Impl(aSwfName:String) : *
      {

      }
      
      public function onSWFEnterFrame(aEvent:Event) : *
      {

         if(this.bPlayClipOnce_Inspectable && this.SWF && this.SWF.currentFrame == this.SWF.totalFrames)
         {
            this.SWF.removeEventListener(Event.ENTER_FRAME,this.onSWFEnterFrame);
            this.SWF.stop();
            this.onLastFrame(this.SWF.SwfLoaderURL);
         }
      }
      
      public function SWFUnload() : void
      {

         if(this.SWF)
         {
            this.SWF.removeEventListener(Event.ENTER_FRAME,this.onSWFEnterFrame);
            if(this.VaultBoyImageInternal_mc.contains(this.SWF))
            {
               this.VaultBoyImageInternal_mc.removeChild(this.SWF);
            }
            if(this.SWF.loaderInfo)
            {
               this.SWF.loaderInfo.loader.unload();
            }
         }
         this.SWF = null;
         this.VaultBoyImageInternal_mc.SetIsDirty();
         this.VaultBoyImageInternal_mc.visible = false;
         SetIsDirty();
      }
   }
}
