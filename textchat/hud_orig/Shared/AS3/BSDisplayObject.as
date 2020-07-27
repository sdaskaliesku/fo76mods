 
package Shared.AS3
{
   import Shared.GlobalFunc;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class BSDisplayObject extends MovieClip
   {
       
      
      private var _bIsDirty:Boolean;
      
      public var onAddChild:Function;
      
      public var onRemoveChild:Function;
      
      public function BSDisplayObject()
      {
         // method body index: 2413 method index: 2413
         super();
         this._bIsDirty = false;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
         if(loaderInfo is LoaderInfo)
         {
            loaderInfo.addEventListener(Event.INIT,this.onLoadedInitEvent);
         }
      }
      
      public function get bIsDirty() : Boolean
      {
         // method body index: 2410 method index: 2410
         return this._bIsDirty;
      }
      
      public function SetIsDirty() : void
      {
         // method body index: 2411 method index: 2411
         this._bIsDirty = true;
         this.requestRedraw();
      }
      
      private final function ClearIsDirty() : void
      {
         // method body index: 2412 method index: 2412
         this._bIsDirty = false;
      }
      
      private final function onLoadedInitEvent(arEvent:Event) : void
      {
         // method body index: 2414 method index: 2414
         if(loaderInfo is LoaderInfo)
         {
            loaderInfo.removeEventListener(Event.INIT,this.onLoadedInitEvent);
         }
         this.onLoadedInit();
      }
      
      private final function onAddedToStageEvent(arEvent:Event) : void
      {
         // method body index: 2415 method index: 2415
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
         this.onAddedToStage();
         if(this.bIsDirty)
         {
            this.requestRedraw();
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStageEvent);
      }
      
      private final function onRemovedFromStageEvent(arEvent:Event) : void
      {
         // method body index: 2416 method index: 2416
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStageEvent);
         if(stage)
         {
            stage.removeEventListener(Event.RENDER,this.onRenderEvent);
         }
         this.onRemovedFromStage();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
      }
      
      private final function onRenderEvent(arEvent:Event) : void
      {
         // method body index: 2417 method index: 2417
         if(stage)
         {
            stage.removeEventListener(Event.RENDER,this.onRenderEvent);
         }
         if(this.bIsDirty)
         {
            this.ClearIsDirty();
            this.redrawDisplayObject();
         }
         GlobalFunc.BSASSERT(!this.bIsDirty,"BSDisplayObject: " + getQualifiedClassName(this) + ": " + this.name + ": redrawDisplayObject caused the object to be dirtied. This should never happen as it wont be rendered for that change until it changes for yet another reason later.");
      }
      
      private function requestRedraw() : void
      {
         // method body index: 2418 method index: 2418
         if(stage)
         {
            stage.addEventListener(Event.RENDER,this.onRenderEvent);
            stage.invalidate();
         }
      }
      
      public function onLoadedInit() : void
      {
         // method body index: 2419 method index: 2419
      }
      
      public function redrawDisplayObject() : void
      {
         // method body index: 2420 method index: 2420
      }
      
      public function onAddedToStage() : void
      {
         // method body index: 2421 method index: 2421
      }
      
      public function onRemovedFromStage() : void
      {
         // method body index: 2422 method index: 2422
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         // method body index: 2423 method index: 2423
         var returnChild:DisplayObject = super.addChild(child);
         if(this.onAddChild is Function)
         {
            this.onAddChild(child,getQualifiedClassName(child));
         }
         return returnChild;
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         // method body index: 2424 method index: 2424
         var returnChild:DisplayObject = super.removeChild(child);
         if(this.onRemoveChild is Function)
         {
            this.onRemoveChild(child,getQualifiedClassName(child));
         }
         return returnChild;
      }
   }
}
