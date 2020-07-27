 
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
         // method body index: 2803 method index: 2803
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
         // method body index: 2792 method index: 2792
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 2793 method index: 2793
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 2794 method index: 2794
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 2795 method index: 2795
         return this._uiKeyboard;
      }
      
      public function get bNuclearWinterMode() : Boolean
      {
         // method body index: 2796 method index: 2796
         return this._bNuclearWinterMode;
      }
      
      public function get SafeX() : Number
      {
         // method body index: 2797 method index: 2797
         return this.safeX;
      }
      
      public function get SafeY() : Number
      {
         // method body index: 2798 method index: 2798
         return this.safeY;
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {
         // method body index: 2799 method index: 2799
         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(aObj:BSButtonHintBar) : *
      {
         // method body index: 2800 method index: 2800
         this._ButtonHintBar = aObj;
      }
      
      public function set overrideColors(aOverride:Boolean) : *
      {
         // method body index: 2801 method index: 2801
         this.bOverrideColors = aOverride;
      }
      
      public function get overrideColors() : Boolean
      {
         // method body index: 2802 method index: 2802
         return this.bOverrideColors;
      }
      
      protected function onPlatformRequestEvent(arEvent:Event) : *
      {
         // method body index: 2804 method index: 2804
         if(this.uiPlatform != PlatformChangeEvent.PLATFORM_INVALID)
         {
            (arEvent as PlatformRequestEvent).RespondToRequest(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 2806 method index: 2806
         var menu:* = undefined;
         stage.stageFocusRect = false;
         stage.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusLostEvent);
         stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusEvent);
         stage.addEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED,this.OnMenuComponentLoadedEvent);
         menu = this;
         BSUIDataManager.Subscribe("HUDColors",function(arEvent:FromClientDataEvent):// method body index: 2805 method index: 2805
         *
         {
            // method body index: 2805 method index: 2805
            if(!overrideColors)
            {
               return;
            }
            var colors:* = arEvent.data;
            if(colors.hue == 0 && colors.saturation == 0 && colors.value == 0 && colors.contrast == 0)
            {
               menu.filters = null;
            }
            else
            {
               colorFilter = new AdjustColor();
               colorFilter.hue = colors.hue;
               colorFilter.saturation = colors.saturation;
               colorFilter.brightness = colors.value;
               colorFilter.contrast = colors.contrast;
               mMatrix = colorFilter.CalculateFinalFlatArray();
               mColorMatrix = new ColorMatrixFilter(mMatrix);
               menu.filters = [mColorMatrix];
            }
         });
      }
      
      override public function onRemovedFromStage() : void
      {
         // method body index: 2807 method index: 2807
         stage.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusLostEvent);
         stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusEvent);
         stage.removeEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED,this.OnMenuComponentLoadedEvent);
      }
      
      private function OnMenuComponentLoadedEvent(arEvent:MenuComponentLoadedEvent) : *
      {
         // method body index: 2808 method index: 2808
         arEvent.RespondToEvent(this);
      }
      
      public function SetPlatform(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : *
      {
         // method body index: 2809 method index: 2809
         this._uiPlatform = auiPlatform;
         this._bPS3Switch = this.bPS3Switch;
         this._uiController = auiController;
         this._uiKeyboard = auiKeyboard;
         dispatchEvent(new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard));
      }
      
      public function SetNuclearWinterMode(abNuclearWinterMode:Boolean) : *
      {
         // method body index: 2810 method index: 2810
         this._bNuclearWinterMode = abNuclearWinterMode;
      }
      
      public function SetSafeRect(aSafeX:Number, aSafeY:Number) : *
      {
         // method body index: 2811 method index: 2811
         this.safeX = aSafeX;
         this.safeY = aSafeY;
         this.onSetSafeRect();
      }
      
      protected function onSetSafeRect() : void
      {
         // method body index: 2812 method index: 2812
      }
      
      private function onFocusLostEvent(event:FocusEvent) : *
      {
         // method body index: 2813 method index: 2813
         if(this._bRestoreLostFocus)
         {
            this._bRestoreLostFocus = false;
            stage.focus = event.target as InteractiveObject;
         }
         this.onFocusLost(event);
      }
      
      public function onFocusLost(event:FocusEvent) : *
      {
         // method body index: 2814 method index: 2814
      }
      
      protected function onMouseFocusEvent(event:FocusEvent) : *
      {
         // method body index: 2815 method index: 2815
         if(event.target == null || !(event.target is InteractiveObject))
         {
            stage.focus = null;
         }
         else
         {
            this._bRestoreLostFocus = true;
         }
      }
      
      public function ShrinkFontToFit(textField:TextField, amaxScrollV:int) : *
      {
         // method body index: 2816 method index: 2816
         var tfSize:int = 0;
         var textFormat:TextFormat = textField.getTextFormat();
         if(this.textFieldSizeMap[textField] == null)
         {
            this.textFieldSizeMap[textField] = textFormat.size;
         }
         textFormat.size = this.textFieldSizeMap[textField];
         textField.setTextFormat(textFormat);
         var maxVScroll:int = textField.maxScrollV;
         while(maxVScroll > amaxScrollV && textFormat.size > 4)
         {
            tfSize = textFormat.size as int;
            textFormat.size = tfSize - 1;
            textField.setTextFormat(textFormat);
            maxVScroll = textField.maxScrollV;
         }
      }
   }
}
