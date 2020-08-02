 
package Shared.AS3
{
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.AS3.Events.PlatformRequestEvent;
   import flash.events.Event;
   import scaleform.gfx.Extensions;
   
   public dynamic class BSUIComponent extends BSDisplayObject
   {
       
      
      private var _uiPlatform:uint;
      
      private var _bPS3Switch:Boolean;
      
      private var _uiController:uint;
      
      private var _uiKeyboard:uint;
      
      private var _bAcquiredByNativeCode:Boolean;
      
      public function BSUIComponent()
      {
         // method body index: 1234 method index: 1234
         super();
         this._uiPlatform = PlatformChangeEvent.PLATFORM_INVALID;
         this._bPS3Switch = false;
         this._uiController = PlatformChangeEvent.PLATFORM_INVALID;
         this._uiKeyboard = PlatformChangeEvent.PLATFORM_INVALID;
         this._bAcquiredByNativeCode = false;
         Extensions.enabled = true;
      }
      
      public function get uiPlatform() : uint
      {
         // method body index: 1229 method index: 1229
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 1230 method index: 1230
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 1231 method index: 1231
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 1232 method index: 1232
         return this._uiKeyboard;
      }
      
      public function get bAcquiredByNativeCode() : Boolean
      {
         // method body index: 1233 method index: 1233
         return this._bAcquiredByNativeCode;
      }
      
      public function onAcquiredByNativeCode() : *
      {
         // method body index: 1235 method index: 1235
         this._bAcquiredByNativeCode = true;
      }
      
      override public function redrawDisplayObject() : void
      {
         // method body index: 1236 method index: 1236
         try
         {
            this.redrawUIComponent();
         }
         catch(e:Error)
         {
            trace(this + " " + this.name + ": " + e.getStackTrace());
         }
      }
      
      private final function onSetPlatformEvent(event:Event) : *
      {
         // method body index: 1237 method index: 1237
         var e:PlatformChangeEvent = event as PlatformChangeEvent;
         this.SetPlatform(e.uiPlatform,e.bPS3Switch,e.uiController,e.uiKeyboard);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1238 method index: 1238
         dispatchEvent(new PlatformRequestEvent(this));
         if(stage)
         {
            stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 1239 method index: 1239
         if(stage)
         {
            stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      public function redrawUIComponent() : void
      {
         // method body index: 1240 method index: 1240
      }
      
      public function SetPlatform(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : void
      {
         // method body index: 1241 method index: 1241
         if(this._uiPlatform != auiPlatform || this._bPS3Switch != abPS3Switch || this._uiController != auiController || this._uiKeyboard != auiKeyboard)
         {
            this._uiPlatform = auiPlatform;
            this._bPS3Switch = abPS3Switch;
            this._uiController = auiController;
            this._uiKeyboard = auiKeyboard;
            SetIsDirty();
         }
      }
   }
}
