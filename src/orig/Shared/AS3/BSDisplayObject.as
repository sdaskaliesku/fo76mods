 
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
         // method body index: 862 method index: 862
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
         // method body index: 859 method index: 859
         return this._bIsDirty;
      }
      
      public function SetIsDirty() : void
      {
         // method body index: 860 method index: 860
         this._bIsDirty = true;
         this.requestRedraw();
      }
      
      private final function ClearIsDirty() : void
      {
         // method body index: 861 method index: 861
         this._bIsDirty = false;
      }
      
      private final function onLoadedInitEvent(arEvent:Event) : void
      {
         // method body index: 863 method index: 863
         if(loaderInfo is LoaderInfo)
         {
            loaderInfo.removeEventListener(Event.INIT,this.onLoadedInitEvent);
         }
         this.onLoadedInit();
      }
      
      private final function onAddedToStageEvent(arEvent:Event) : void
      {
         // method body index: 864 method index: 864
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
         // method body index: 865 method index: 865
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
         // method body index: 866 method index: 866
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
         // method body index: 867 method index: 867
         if(stage)
         {
            stage.addEventListener(Event.RENDER,this.onRenderEvent);
            stage.invalidate();
         }
      }
      
      public function onLoadedInit() : void
      {
         // method body index: 868 method index: 868
      }
      
      public function redrawDisplayObject() : void
      {
         // method body index: 869 method index: 869
      }
      
      public function onAddedToStage() : void
      {
         // method body index: 870 method index: 870
      }
      
      public function onRemovedFromStage() : void
      {
         // method body index: 871 method index: 871
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         // method body index: 872 method index: 872
         var returnChild:DisplayObject = super.addChild(child);
         if(this.onAddChild is Function)
         {
            this.onAddChild(child,getQualifiedClassName(child));
         }
         return returnChild;
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         // method body index: 873 method index: 873
         var returnChild:DisplayObject = super.removeChild(child);
         if(this.onRemoveChild is Function)
         {
            this.onRemoveChild(child,getQualifiedClassName(child));
         }
         return returnChild;
      }
   }
}
