 
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
         // method body index: 2715 method index: 2715
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
         // method body index: 2716 method index: 2716
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 2717 method index: 2717
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 2718 method index: 2718
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 2719 method index: 2719
         return this._uiKeyboard;
      }
      
      public function get bAcquiredByNativeCode() : Boolean
      {
         // method body index: 2720 method index: 2720
         return this._bAcquiredByNativeCode;
      }
      
      public function onAcquiredByNativeCode() : *
      {
         // method body index: 2721 method index: 2721
         this._bAcquiredByNativeCode = true;
      }
      
      override public function redrawDisplayObject() : void
      {
         // method body index: 2722 method index: 2722
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
         // method body index: 2723 method index: 2723
         var _loc2_:PlatformChangeEvent = param1 as PlatformChangeEvent;
         this.SetPlatform(_loc2_.uiPlatform,_loc2_.bPS3Switch,_loc2_.uiController,_loc2_.uiKeyboard);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 2724 method index: 2724
         dispatchEvent(new PlatformRequestEvent(this));
         if(stage)
         {
            stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 2725 method index: 2725
         if(stage)
         {
            stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      public function redrawUIComponent() : void
      {
         // method body index: 2726 method index: 2726
      }
      
      public function SetPlatform(param1:uint, param2:Boolean, param3:uint, param4:uint) : void
      {
         // method body index: 2727 method index: 2727
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
