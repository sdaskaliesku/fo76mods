 
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

         return this._bIsDirty;
      }
      
      public function SetIsDirty() : void
      {

         this._bIsDirty = true;
         this.requestRedraw();
      }
      
      private final function ClearIsDirty() : void
      {

         this._bIsDirty = false;
      }
      
      private final function onLoadedInitEvent(param1:Event) : void
      {

         if(loaderInfo is LoaderInfo)
         {
            loaderInfo.removeEventListener(Event.INIT,this.onLoadedInitEvent);
         }
         this.onLoadedInit();
      }
      
      private final function onAddedToStageEvent(param1:Event) : void
      {

         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
         this.onAddedToStage();
         if(this.bIsDirty)
         {
            this.requestRedraw();
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStageEvent);
      }
      
      private final function onRemovedFromStageEvent(param1:Event) : void
      {

         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStageEvent);
         if(stage)
         {
            stage.removeEventListener(Event.RENDER,this.onRenderEvent);
         }
         this.onRemovedFromStage();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
      }
      
      private final function onRenderEvent(param1:Event) : void
      {

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

         if(stage)
         {
            stage.addEventListener(Event.RENDER,this.onRenderEvent);
            stage.invalidate();
         }
      }
      
      public function onLoadedInit() : void
      {

      }
      
      public function redrawDisplayObject() : void
      {

      }
      
      public function onAddedToStage() : void
      {

      }
      
      public function onRemovedFromStage() : void
      {

      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {

         var _loc2_:DisplayObject = super.addChild(param1);
         if(this.onAddChild is Function)
         {
            this.onAddChild(param1,getQualifiedClassName(param1));
         }
         return _loc2_;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {

         var _loc2_:DisplayObject = super.removeChild(param1);
         if(this.onRemoveChild is Function)
         {
            this.onRemoveChild(param1,getQualifiedClassName(param1));
         }
         return _loc2_;
      }
   }
}
