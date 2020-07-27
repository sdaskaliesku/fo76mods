 
package Shared.AS3
{
   import Shared.AS3.COMPANIONAPP.CompanionAppMode;
   import Shared.AS3.COMPANIONAPP.MobileButtonHint;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public dynamic class BSButtonHintBar extends BSUIComponent
   {
      
      public static var BACKGROUND_COLOR:uint = // method body index: 3206 method index: 3206
      0;
      
      public static var BACKGROUND_ALPHA:Number = // method body index: 3206 method index: 3206
      0.4;
      
      public static var BACKGROUND_PAD:Number = // method body index: 3206 method index: 3206
      8;
      
      public static var BUTTON_SPACING:Number = // method body index: 3206 method index: 3206
      20;
      
      public static var BAR_Y_OFFSET:Number = // method body index: 3206 method index: 3206
      5;
      
      private static var ALIGN_CENTER = // method body index: 3206 method index: 3206
      0;
      
      private static var ALIGN_LEFT = // method body index: 3206 method index: 3206
      1;
      
      private static var ALIGN_RIGHT = // method body index: 3206 method index: 3206
      2;
       
      
      public var Sizer_mc:MovieClip;
      
      private var Alignment:int = 0;
      
      private var StartingXPos:int = 0;
      
      private var m_UseBackground:Boolean = true;
      
      private var ButtonHintBarInternal_mc:MovieClip;
      
      private var _buttonHintDataV:Vector.<BSButtonHintData>;
      
      private var ButtonPoolV:Vector.<BSButtonHint>;
      
      private var m_UseVaultTecColor:Boolean = true;
      
      private var _bRedirectToButtonBarMenu:Boolean = true;
      
      public var SetButtonHintData:Function;
      
      public function BSButtonHintBar()
      {
         // method body index: 3215 method index: 3215
         this.SetButtonHintData = this.SetButtonHintData_Impl;
         super();
         visible = false;
         this.ButtonHintBarInternal_mc = new MovieClip();
         this.ButtonHintBarInternal_mc.y = BAR_Y_OFFSET;
         addChild(this.ButtonHintBarInternal_mc);
         this._buttonHintDataV = new Vector.<BSButtonHintData>();
         this.ButtonPoolV = new Vector.<BSButtonHint>();
         this.StartingXPos = this.x;
      }
      
      public function set useBackground(aUse:Boolean) : void
      {
         // method body index: 3207 method index: 3207
         this.m_UseBackground = aUse;
         SetIsDirty();
      }
      
      public function get useBackground() : Boolean
      {
         // method body index: 3208 method index: 3208
         return this.m_UseBackground;
      }
      
      public function get bRedirectToButtonBarMenu_Inspectable() : Boolean
      {
         // method body index: 3209 method index: 3209
         return this._bRedirectToButtonBarMenu;
      }
      
      public function set bRedirectToButtonBarMenu_Inspectable(abRedirectToButtonBarMenu:Boolean) : *
      {
         // method body index: 3210 method index: 3210
         if(this._bRedirectToButtonBarMenu != abRedirectToButtonBarMenu)
         {
            this._bRedirectToButtonBarMenu = abRedirectToButtonBarMenu;
            SetIsDirty();
         }
      }
      
      public function get useVaultTecColor() : Boolean
      {
         // method body index: 3211 method index: 3211
         return this.m_UseVaultTecColor;
      }
      
      public function set useVaultTecColor(aUseColor:Boolean) : void
      {
         // method body index: 3212 method index: 3212
         if(this.m_UseVaultTecColor != aUseColor)
         {
            this.m_UseVaultTecColor = aUseColor;
            SetIsDirty();
         }
      }
      
      public function set align(alignment:uint) : *
      {
         // method body index: 3213 method index: 3213
         this.Alignment = alignment;
         SetIsDirty();
      }
      
      private function CanBeVisible() : Boolean
      {
         // method body index: 3214 method index: 3214
         return !this.bRedirectToButtonBarMenu_Inspectable || !bAcquiredByNativeCode;
      }
      
      override public function onAcquiredByNativeCode() : *
      {
         // method body index: 3216 method index: 3216
         var emptyButtonHintDataV:Vector.<BSButtonHintData> = null;
         super.onAcquiredByNativeCode();
         if(this.bRedirectToButtonBarMenu_Inspectable)
         {
            this.SetButtonHintData(this._buttonHintDataV);
            emptyButtonHintDataV = new Vector.<BSButtonHintData>();
            this.SetButtonHintData_Impl(emptyButtonHintDataV);
            SetIsDirty();
         }
      }
      
      private function SetButtonHintData_Impl(abuttonHintDataV:Vector.<BSButtonHintData>) : void
      {
         // method body index: 3219 method index: 3219
         this._buttonHintDataV.forEach(function(item:BSButtonHintData, index:int, vector:Vector.<BSButtonHintData>):// method body index: 3217 method index: 3217
         *
         {
            // method body index: 3217 method index: 3217
            if(item)
            {
               item.removeEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
            }
         },this);
         this._buttonHintDataV = abuttonHintDataV;
         this._buttonHintDataV.forEach(function(item:BSButtonHintData, index:int, vector:Vector.<BSButtonHintData>):// method body index: 3218 method index: 3218
         *
         {
            // method body index: 3218 method index: 3218
            if(item)
            {
               item.addEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
            }
         },this);
         this.CreateButtonHints();
      }
      
      public function onButtonHintDataDirtyEvent(arEvent:Event) : void
      {
         // method body index: 3220 method index: 3220
         SetIsDirty();
      }
      
      private function CreateButtonHints() : *
      {
         // method body index: 3221 method index: 3221
         visible = false;
         while(this.ButtonPoolV.length < this._buttonHintDataV.length)
         {
            if(CompanionAppMode.isOn)
            {
               this.ButtonPoolV.push(new MobileButtonHint());
            }
            else
            {
               this.ButtonPoolV.push(new BSButtonHint());
            }
         }
         for(var i:int = 0; i < this.ButtonPoolV.length; i++)
         {
            this.ButtonPoolV[i].ButtonHintData = i < this._buttonHintDataV.length?this._buttonHintDataV[i]:null;
         }
         SetIsDirty();
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3222 method index: 3222
         super.onAddedToStage();
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3223 method index: 3223
         var curButtonHelp:BSButtonHint = null;
         super.redrawUIComponent();
         var bHasVisibleButtons:* = false;
         var nextX:Number = 0;
         var nextRightAlignedX:Number = 0;
         if(CompanionAppMode.isOn)
         {
            nextRightAlignedX = stage.stageWidth - 75;
         }
         var lastEntry:int = -1;
         for(var i:Number = 0; i < this.ButtonPoolV.length; i++)
         {
            curButtonHelp = this.ButtonPoolV[i];
            if(curButtonHelp.ButtonVisible && this.CanBeVisible())
            {
               bHasVisibleButtons = true;
               curButtonHelp.useVaultTecColor = this.useVaultTecColor;
               lastEntry = i;
               if(!this.ButtonHintBarInternal_mc.contains(curButtonHelp))
               {
                  this.ButtonHintBarInternal_mc.addChild(curButtonHelp);
               }
               if(curButtonHelp.bIsDirty)
               {
                  curButtonHelp.redrawUIComponent();
               }
               if(CompanionAppMode.isOn && curButtonHelp.Justification == BSButtonHint.JUSTIFY_RIGHT)
               {
                  nextRightAlignedX = nextRightAlignedX - curButtonHelp.Sizer_mc.width;
                  curButtonHelp.x = nextRightAlignedX;
               }
               else
               {
                  curButtonHelp.x = nextX;
                  nextX = nextX + (curButtonHelp.Sizer_mc.width + BUTTON_SPACING);
               }
            }
            else if(this.ButtonHintBarInternal_mc.contains(curButtonHelp))
            {
               this.ButtonHintBarInternal_mc.removeChild(curButtonHelp);
            }
         }
         if(this.ButtonPoolV.length > this._buttonHintDataV.length)
         {
            this.ButtonPoolV.splice(this._buttonHintDataV.length,this.ButtonPoolV.length - this._buttonHintDataV.length);
         }
         var ourBounds:Rectangle = new Rectangle(0,0,0,0);
         if(lastEntry >= 0)
         {
            ourBounds.width = this.ButtonPoolV[lastEntry].x + this.ButtonPoolV[lastEntry].Sizer_mc.width;
            ourBounds.height = this.ButtonPoolV[lastEntry].y + this.ButtonPoolV[lastEntry].Sizer_mc.height;
         }
         if(this.Sizer_mc && this.ButtonHintBarInternal_mc.contains(this.Sizer_mc))
         {
            this.ButtonHintBarInternal_mc.removeChild(this.Sizer_mc);
         }
         this.Sizer_mc = new MovieClip();
         var bgGraphics:Graphics = this.Sizer_mc.graphics;
         this.ButtonHintBarInternal_mc.addChildAt(this.Sizer_mc,0);
         bgGraphics.clear();
         bgGraphics.beginFill(BACKGROUND_COLOR,!!this.m_UseBackground?Number(BACKGROUND_ALPHA):Number(0));
         bgGraphics.drawRect(0,0,ourBounds.width + BACKGROUND_PAD,ourBounds.height);
         bgGraphics.endFill();
         this.Sizer_mc.x = BACKGROUND_PAD * -0.5;
         if(!CompanionAppMode.isOn)
         {
            this.ButtonHintBarInternal_mc.x = -ourBounds.width / 2;
         }
         visible = bHasVisibleButtons;
         if(this.Alignment == ALIGN_LEFT)
         {
            this.x = this.StartingXPos + ourBounds.width / 2;
         }
         else if(this.Alignment != ALIGN_CENTER)
         {
            if(this.Alignment == ALIGN_RIGHT)
            {
               this.x = this.StartingXPos - ourBounds.width / 2;
            }
         }
      }
   }
}
