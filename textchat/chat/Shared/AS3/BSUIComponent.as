 
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
         // method body index: 572 method index: 572
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
         // method body index: 573 method index: 573
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 574 method index: 574
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 575 method index: 575
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 576 method index: 576
         return this._uiKeyboard;
      }
      
      public function get bAcquiredByNativeCode() : Boolean
      {
         // method body index: 577 method index: 577
         return this._bAcquiredByNativeCode;
      }
      
      public function onAcquiredByNativeCode() : *
      {
         // method body index: 578 method index: 578
         this._bAcquiredByNativeCode = true;
      }
      
      override public function redrawDisplayObject() : void
      {
         // method body index: 579 method index: 579
         try
         {
            this.redrawUIComponent();
            return;
         }
         catch(e:Error)
         {
            trace(this + " " + this.name + ": " + e.getStackTrace());
            return;
         }
      }
      
      private final function onSetPlatformEvent(param1:Event) : *
      {
         // method body index: 580 method index: 580
         var _loc2_:PlatformChangeEvent = param1 as PlatformChangeEvent;
         this.SetPlatform(_loc2_.uiPlatform,_loc2_.bPS3Switch,_loc2_.uiController,_loc2_.uiKeyboard);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 581 method index: 581
         dispatchEvent(new PlatformRequestEvent(this));
         if(stage)
         {
            stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 582 method index: 582
         if(stage)
         {
            stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      public function redrawUIComponent() : void
      {
         // method body index: 583 method index: 583
      }
      
      public function SetPlatform(param1:uint, param2:Boolean, param3:uint, param4:uint) : void
      {
         // method body index: 584 method index: 584
         if(this._uiPlatform != param1 || this._bPS3Switch != param2 || this._uiController != param3 || this._uiKeyboard != param4)
         {
            this._uiPlatform = param1;
            this._bPS3Switch = param2;
            this._uiController = param3;
            this._uiKeyboard = param4;
            SetIsDirty();
         }
      }
   }
}
