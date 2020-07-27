 
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
         // method body index: 2782 method index: 2782
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
         // method body index: 2777 method index: 2777
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 2778 method index: 2778
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 2779 method index: 2779
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 2780 method index: 2780
         return this._uiKeyboard;
      }
      
      public function get bAcquiredByNativeCode() : Boolean
      {
         // method body index: 2781 method index: 2781
         return this._bAcquiredByNativeCode;
      }
      
      public function onAcquiredByNativeCode() : *
      {
         // method body index: 2783 method index: 2783
         this._bAcquiredByNativeCode = true;
      }
      
      override public function redrawDisplayObject() : void
      {
         // method body index: 2784 method index: 2784
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
         // method body index: 2785 method index: 2785
         var e:PlatformChangeEvent = event as PlatformChangeEvent;
         this.SetPlatform(e.uiPlatform,e.bPS3Switch,e.uiController,e.uiKeyboard);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 2786 method index: 2786
         dispatchEvent(new PlatformRequestEvent(this));
         if(stage)
         {
            stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 2787 method index: 2787
         if(stage)
         {
            stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onSetPlatformEvent);
         }
      }
      
      public function redrawUIComponent() : void
      {
         // method body index: 2788 method index: 2788
      }
      
      public function SetPlatform(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : void
      {
         // method body index: 2789 method index: 2789
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
