 
package Shared.AS3
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Events.MenuComponentLoadedEvent;
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.AS3.Events.PlatformRequestEvent;
   import Shared.GlobalFunc;
   import fl.motion.AdjustColor;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class IMenu extends BSDisplayObject
   {
       
      
      private var _uiPlatform:uint;
      
      private var _bPS3Switch:Boolean;
      
      private var _uiController:uint;
      
      private var _uiKeyboard:uint;
      
      private var _bNuclearWinterMode:Boolean;
      
      private var _bRestoreLostFocus:Boolean;
      
      private var safeX:Number = 0.0;
      
      private var safeY:Number = 0.0;
      
      private var textFieldSizeMap:Object;
      
      private var _ButtonHintBar:BSButtonHintBar;
      
      private var bOverrideColors = true;
      
      var colorFilter:AdjustColor;
      
      var mColorMatrix:ColorMatrixFilter;
      
      var mMatrix:Array;
      
      public function IMenu()
      {
         // method body index: 645 method index: 645
         this.textFieldSizeMap = new Object();
         this.colorFilter = new AdjustColor();
         this.mMatrix = [];
         super();
         this._uiPlatform = PlatformChangeEvent.PLATFORM_INVALID;
         this._bPS3Switch = false;
         this._bRestoreLostFocus = false;
         this._bNuclearWinterMode = false;
         GlobalFunc.MaintainTextFormat();
         addEventListener(PlatformRequestEvent.PLATFORM_REQUEST,this.onPlatformRequestEvent,true);
      }
      
      public function get uiPlatform() : uint
      {
         // method body index: 634 method index: 634
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 635 method index: 635
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 636 method index: 636
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 637 method index: 637
         return this._uiKeyboard;
      }
      
      public function get bNuclearWinterMode() : Boolean
      {
         // method body index: 638 method index: 638
         return this._bNuclearWinterMode;
      }
      
      public function get SafeX() : Number
      {
         // method body index: 639 method index: 639
         return this.safeX;
      }
      
      public function get SafeY() : Number
      {
         // method body index: 640 method index: 640
         return this.safeY;
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {
         // method body index: 641 method index: 641
         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(param1:BSButtonHintBar) : *
      {
         // method body index: 642 method index: 642
         this._ButtonHintBar = param1;
      }
      
      public function set overrideColors(param1:Boolean) : *
      {
         // method body index: 643 method index: 643
         this.bOverrideColors = param1;
      }
      
      public function get overrideColors() : Boolean
      {
         // method body index: 644 method index: 644
         return this.bOverrideColors;
      }
      
      protected function onPlatformRequestEvent(param1:Event) : *
      {
         // method body index: 646 method index: 646
         if(this.uiPlatform != PlatformChangeEvent.PLATFORM_INVALID)
         {
            (param1 as PlatformRequestEvent).RespondToRequest(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 648 method index: 648
         var menu:* = undefined;
         stage.stageFocusRect = false;
         stage.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusLostEvent);
         stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusEvent);
         stage.addEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED,this.OnMenuComponentLoadedEvent);
         menu = this;
         BSUIDataManager.Subscribe("HUDColors",function(param1:FromClientDataEvent):// method body index: 647 method index: 647
         *
         {
            // method body index: 647 method index: 647
            if(!overrideColors)
            {
               return;
            }
            var _loc2_:* = param1.data;
            if(_loc2_.hue == 0 && _loc2_.saturation == 0 && _loc2_.value == 0 && _loc2_.contrast == 0)
            {
               menu.filters = null;
            }
            else
            {
               colorFilter = new AdjustColor();
               colorFilter.hue = _loc2_.hue;
               colorFilter.saturation = _loc2_.saturation;
               colorFilter.brightness = _loc2_.value;
               colorFilter.contrast = _loc2_.contrast;
               mMatrix = colorFilter.CalculateFinalFlatArray();
               mColorMatrix = new ColorMatrixFilter(mMatrix);
               menu.filters = [mColorMatrix];
            }
         });
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 649 method index: 649
         stage.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusLostEvent);
         stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusEvent);
         stage.removeEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED,this.OnMenuComponentLoadedEvent);
      }
      
      private function OnMenuComponentLoadedEvent(param1:MenuComponentLoadedEvent) : *
      {
         // method body index: 650 method index: 650
         param1.RespondToEvent(this);
      }
      
      public function SetPlatform(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {
         // method body index: 651 method index: 651
         this._uiPlatform = param1;
         this._bPS3Switch = this.bPS3Switch;
         this._uiController = param3;
         this._uiKeyboard = param4;
         dispatchEvent(new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard));
      }
      
      public function SetNuclearWinterMode(param1:Boolean) : *
      {
         // method body index: 652 method index: 652
         this._bNuclearWinterMode = param1;
      }
      
      public function SetSafeRect(param1:Number, param2:Number) : *
      {
         // method body index: 653 method index: 653
         this.safeX = param1;
         this.safeY = param2;
         this.onSetSafeRect();
      }
      
      protected function onSetSafeRect() : void
      {
         // method body index: 654 method index: 654
      }
      
      private function onFocusLostEvent(param1:FocusEvent) : *
      {
         // method body index: 655 method index: 655
         if(this._bRestoreLostFocus)
         {
            this._bRestoreLostFocus = false;
            stage.focus = param1.target as InteractiveObject;
         }
         this.onFocusLost(param1);
      }
      
      public function onFocusLost(param1:FocusEvent) : *
      {
         // method body index: 656 method index: 656
      }
      
      protected function onMouseFocusEvent(param1:FocusEvent) : *
      {
         // method body index: 657 method index: 657
         if(param1.target == null || !(param1.target is InteractiveObject))
         {
            stage.focus = null;
         }
         else
         {
            this._bRestoreLostFocus = true;
         }
      }
      
      public function ShrinkFontToFit(param1:TextField, param2:int) : *
      {
         // method body index: 658 method index: 658
         var _loc5_:int = 0;
         var _loc3_:TextFormat = param1.getTextFormat();
         if(this.textFieldSizeMap[param1] == null)
         {
            this.textFieldSizeMap[param1] = _loc3_.size;
         }
         _loc3_.size = this.textFieldSizeMap[param1];
         param1.setTextFormat(_loc3_);
         var _loc4_:int = param1.maxScrollV;
         while(_loc4_ > param2 && _loc3_.size > 4)
         {
            _loc5_ = _loc3_.size as int;
            _loc3_.size = _loc5_ - 1;
            param1.setTextFormat(_loc3_);
            _loc4_ = param1.maxScrollV;
         }
      }
   }
}
