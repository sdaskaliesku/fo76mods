 
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
      
      public function set bUseFixedQuestStageSize_Inspectable(param1:Boolean) : *
      {

         this._bUseFixedQuestStageSize = param1;
      }
      
      public function get bPlayClipOnce_Inspectable() : Boolean
      {

         return this._bPlayClipOnce;
      }
      
      public function set bPlayClipOnce_Inspectable(param1:Boolean) : *
      {

         this._bPlayClipOnce = param1;
      }
      
      public function get ClipAlignment_Inspectable() : String
      {

         return this._clipAlignment;
      }
      
      public function set ClipAlignment_Inspectable(param1:String) : *
      {

         this._clipAlignment = param1;
      }
      
      public function get DefaultBoySwfName_Inspectable() : String
      {

         return this._defaultBoySwfName;
      }
      
      public function set DefaultBoySwfName_Inspectable(param1:String) : *
      {

         this._defaultBoySwfName = param1;
      }
      
      public function get questAnimStageWidth_Inspectable() : Number
      {

         return this._questAnimStageWidth;
      }
      
      public function set questAnimStageWidth_Inspectable(param1:Number) : void
      {

         this._questAnimStageWidth = param1;
      }
      
      public function get questAnimStageHeight_Inspectable() : Number
      {

         return this._questAnimStageHeight;
      }
      
      public function set questAnimStageHeight_Inspectable(param1:Number) : void
      {

         this._questAnimStageHeight = param1;
      }
      
      public function get maxClipHeight_Inspectable() : Number
      {

         return this._maxClipHeight;
      }
      
      public function set maxClipHeight_Inspectable(param1:Number) : void
      {

         this._maxClipHeight = param1;
      }
      
      public function SWFLoad(param1:String) : void
      {

         var aSwfLoaderURL:String = param1;
         this.VaultBoyImageInternal_mc.visible = false;
         if(this.menuLoader)
         {
            this.menuLoader.close();
         }
         this.SWFUnload();
         var loadCompleteCallback:Function = function(param1:Event):// method body index: 3086 method index: 3086
         *
         {
   
            onMenuLoadComplete(param1,aSwfLoaderURL);
         };
         var menuLoadRequest:URLRequest = new URLRequest(!!aSwfLoaderURL?aSwfLoaderURL:this.DefaultBoySwfName_Inspectable);
         this.menuLoader = new Loader();
         this.menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadCompleteCallback);
         this.menuLoader.load(menuLoadRequest);
         SetIsDirty();
      }
      
      public function onMenuLoadComplete(param1:Event, param2:String) : void
      {

         var _loc3_:MovieClip = null;
         if(param1 && param1.currentTarget && param1.currentTarget.content)
         {
            _loc3_ = param1.currentTarget.content as MovieClip;
            _loc3_.SwfLoaderURL = param2;
            this.SetQuestMovieClip(_loc3_);
         }
         else
         {
            this.SWFUnload();
         }
      }
      
      public function SetQuestMovieClip(param1:MovieClip) : void
      {

         var _loc2_:Graphics = null;
         this.VaultBoyImageInternal_mc.visible = true;
         this.SWF = param1;
         this.VaultBoyImageInternal_mc.addChild(this.SWF);
         if(this.bPlayClipOnce_Inspectable)
         {
            this.SWF.addEventListener(Event.ENTER_FRAME,this.onSWFEnterFrame);
         }
         if(this.bUseFixedQuestStageSize_Inspectable)
         {
            _loc2_ = this.SWF.graphics;
            _loc2_.clear();
            _loc2_.beginFill(0,0);
            _loc2_.drawRect(0,0,this.questAnimStageWidth_Inspectable,this.questAnimStageHeight_Inspectable);
            _loc2_.endFill();
         }
         var _loc3_:Number = this._maxClipHeight;
         var _loc4_:Number = _loc3_ / this.SWF.height;
         this.SWF.scaleX = _loc4_;
         this.SWF.scaleY = _loc4_;
         if(this.ClipAlignment_Inspectable == "Center")
         {
            this.SWF.x = -this.questAnimStageWidth_Inspectable * 0.5 * _loc4_;
            this.SWF.y = -this.questAnimStageHeight_Inspectable * 0.5 * _loc4_;
         }
         this.menuLoader = null;
         SetIsDirty();
      }
      
      public function onLastFrame_Impl(param1:String) : *
      {

      }
      
      public function onSWFEnterFrame(param1:Event) : *
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
