 
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
         // method body index: 1213 method index: 1213
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
         // method body index: 1202 method index: 1202
         return this._uiPlatform;
      }
      
      public function get bPS3Switch() : Boolean
      {
         // method body index: 1203 method index: 1203
         return this._bPS3Switch;
      }
      
      public function get uiController() : uint
      {
         // method body index: 1204 method index: 1204
         return this._uiController;
      }
      
      public function get uiKeyboard() : uint
      {
         // method body index: 1205 method index: 1205
         return this._uiKeyboard;
      }
      
      public function get bNuclearWinterMode() : Boolean
      {
         // method body index: 1206 method index: 1206
         return this._bNuclearWinterMode;
      }
      
      public function get SafeX() : Number
      {
         // method body index: 1207 method index: 1207
         return this.safeX;
      }
      
      public function get SafeY() : Number
      {
         // method body index: 1208 method index: 1208
         return this.safeY;
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {
         // method body index: 1209 method index: 1209
         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(aObj:BSButtonHintBar) : *
      {
         // method body index: 1210 method index: 1210
         this._ButtonHintBar = aObj;
      }
      
      public function set overrideColors(aOverride:Boolean) : *
      {
         // method body index: 1211 method index: 1211
         this.bOverrideColors = aOverride;
      }
      
      public function get overrideColors() : Boolean
      {
         // method body index: 1212 method index: 1212
         return this.bOverrideColors;
      }
      
      protected function onPlatformRequestEvent(arEvent:Event) : *
      {
         // method body index: 1214 method index: 1214
         if(this.uiPlatform != PlatformChangeEvent.PLATFORM_INVALID)
         {
            (arEvent as PlatformRequestEvent).RespondToRequest(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 1216 method index: 1216
         var menu:* = undefined;
         stage.stageFocusRect = false;
         stage.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusLostEvent);
         stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusEvent);
         stage.addEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED,this.OnMenuComponentLoadedEvent);
         menu = this;
         BSUIDataManager.Subscribe("HUDColors",function(arEvent:FromClientDataEvent):// method body index: 1215 method index: 1215
         *
         {
            // method body index: 1215 method index: 1215
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
         // method body index: 1217 method index: 1217
         stage.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusLostEvent);
         stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusEvent);
         stage.removeEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED,this.OnMenuComponentLoadedEvent);
      }
      
      private function OnMenuComponentLoadedEvent(arEvent:MenuComponentLoadedEvent) : *
      {
         // method body index: 1218 method index: 1218
         arEvent.RespondToEvent(this);
      }
      
      public function SetPlatform(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : *
      {
         // method body index: 1219 method index: 1219
         this._uiPlatform = auiPlatform;
         this._bPS3Switch = this.bPS3Switch;
         this._uiController = auiController;
         this._uiKeyboard = auiKeyboard;
         dispatchEvent(new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard));
      }
      
      public function SetNuclearWinterMode(abNuclearWinterMode:Boolean) : *
      {
         // method body index: 1220 method index: 1220
         this._bNuclearWinterMode = abNuclearWinterMode;
      }
      
      public function SetSafeRect(aSafeX:Number, aSafeY:Number) : *
      {
         // method body index: 1221 method index: 1221
         this.safeX = aSafeX;
         this.safeY = aSafeY;
         this.onSetSafeRect();
      }
      
      protected function onSetSafeRect() : void
      {
         // method body index: 1222 method index: 1222
      }
      
      private function onFocusLostEvent(event:FocusEvent) : *
      {
         // method body index: 1223 method index: 1223
         if(this._bRestoreLostFocus)
         {
            this._bRestoreLostFocus = false;
            stage.focus = event.target as InteractiveObject;
         }
         this.onFocusLost(event);
      }
      
      public function onFocusLost(event:FocusEvent) : *
      {
         // method body index: 1224 method index: 1224
      }
      
      protected function onMouseFocusEvent(event:FocusEvent) : *
      {
         // method body index: 1225 method index: 1225
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
         // method body index: 1226 method index: 1226
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
