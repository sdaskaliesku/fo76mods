 
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
         // method body index: 624 method index: 624
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
         // method body index: 619 method index: 619
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 620 method index: 620
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 621 method index: 621
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 622 method index: 622
         return this._uiKeyboard;
      }
      
      public function get bAcquiredByNativeCode() : Boolean
      {
         // method body index: 623 method index: 623
         return this._bAcquiredByNativeCode;
      }
      
      public function onAcquiredByNativeCode() : *
      {
         // method body index: 625 method index: 625
         this._bAcquiredByNativeCode = true;
      }
      
      override public function redrawDisplayObject() : void
      {
         // method body index: 626 method index: 626
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
         // method body index: 627 method index: 627
         var _loc2_:PlatformChangeEvent = param1 as PlatformChangeEvent;
         this.SetPlatform(_loc2_.uiPlatform,_loc2_.bPS3Switch,_loc2_.uiController,_loc2_.uiKeyboard);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 628 method index: 628
         dispatchEvent(new PlatformRequestEvent(this));
         if(stage)
         {
            stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 629 method index: 629
         if(stage)
         {
            stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      public function redrawUIComponent() : void
      {
         // method body index: 630 method index: 630
      }
      
      public function SetPlatform(param1:uint, param2:Boolean, param3:uint, param4:uint) : void
      {
         // method body index: 631 method index: 631
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
