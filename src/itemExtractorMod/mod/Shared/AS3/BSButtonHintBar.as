 
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
      
      public static var BACKGROUND_COLOR:uint = // method body index: 701 method index: 701
      0;
      
      public static var BACKGROUND_ALPHA:Number = // method body index: 701 method index: 701
      0.4;
      
      public static var BACKGROUND_PAD:Number = // method body index: 701 method index: 701
      8;
      
      public static var BUTTON_SPACING:Number = // method body index: 701 method index: 701
      20;
      
      public static var BAR_Y_OFFSET:Number = // method body index: 701 method index: 701
      5;
      
      private static var ALIGN_CENTER = // method body index: 701 method index: 701
      0;
      
      private static var ALIGN_LEFT = // method body index: 701 method index: 701
      1;
      
      private static var ALIGN_RIGHT = // method body index: 701 method index: 701
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
         // method body index: 710 method index: 710
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
      
      public function set useBackground(param1:Boolean) : void
      {
         // method body index: 702 method index: 702
         this.m_UseBackground = param1;
         SetIsDirty();
      }
      
      public function get useBackground() : Boolean
      {
         // method body index: 703 method index: 703
         return this.m_UseBackground;
      }
      
      public function get bRedirectToButtonBarMenu_Inspectable() : Boolean
      {
         // method body index: 704 method index: 704
         return this._bRedirectToButtonBarMenu;
      }
      
      public function set bRedirectToButtonBarMenu_Inspectable(param1:Boolean) : void
      {
         // method body index: 705 method index: 705
         if(this._bRedirectToButtonBarMenu != param1)
         {
            this._bRedirectToButtonBarMenu = param1;
            SetIsDirty();
         }
      }
      
      public function get useVaultTecColor() : Boolean
      {
         // method body index: 706 method index: 706
         return this.m_UseVaultTecColor;
      }
      
      public function set useVaultTecColor(param1:Boolean) : void
      {
         // method body index: 707 method index: 707
         if(this.m_UseVaultTecColor != param1)
         {
            this.m_UseVaultTecColor = param1;
            SetIsDirty();
         }
      }
      
      public function set align(param1:uint) : void
      {
         // method body index: 708 method index: 708
         this.Alignment = param1;
         SetIsDirty();
      }
      
      private function CanBeVisible() : Boolean
      {
         // method body index: 709 method index: 709
         return !this.bRedirectToButtonBarMenu_Inspectable || !bAcquiredByNativeCode;
      }
      
      override public function onAcquiredByNativeCode() : *
      {
         // method body index: 711 method index: 711
         var _loc1_:Vector.<BSButtonHintData> = null;
         super.onAcquiredByNativeCode();
         if(this.bRedirectToButtonBarMenu_Inspectable)
         {
            this.SetButtonHintData(this._buttonHintDataV);
            _loc1_ = new Vector.<BSButtonHintData>();
            this.SetButtonHintData_Impl(_loc1_);
            SetIsDirty();
         }
      }
      
      private function SetButtonHintData_Impl(param1:Vector.<BSButtonHintData>) : void
      {
         // method body index: 714 method index: 714
         var abuttonHintDataV:Vector.<BSButtonHintData> = param1;
         this._buttonHintDataV.forEach(function(param1:BSButtonHintData, param2:int, param3:Vector.<BSButtonHintData>):// method body index: 712 method index: 712
         *
         {
            // method body index: 712 method index: 712
            if(param1)
            {
               param1.removeEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
            }
         },this);
         this._buttonHintDataV = abuttonHintDataV;
         this._buttonHintDataV.forEach(function(param1:BSButtonHintData, param2:int, param3:Vector.<BSButtonHintData>):// method body index: 713 method index: 713
         *
         {
            // method body index: 713 method index: 713
            if(param1)
            {
               param1.addEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
            }
         },this);
         this.CreateButtonHints();
      }
      
      public function onButtonHintDataDirtyEvent(param1:Event) : void
      {
         // method body index: 715 method index: 715
         SetIsDirty();
      }
      
      private function CreateButtonHints() : *
      {
         // method body index: 716 method index: 716
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
         var _loc1_:int = 0;
         while(_loc1_ < this.ButtonPoolV.length)
         {
            this.ButtonPoolV[_loc1_].ButtonHintData = _loc1_ < this._buttonHintDataV.length?this._buttonHintDataV[_loc1_]:null;
            _loc1_++;
         }
         SetIsDirty();
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 717 method index: 717
         super.onAddedToStage();
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 718 method index: 718
         var _loc4_:BSButtonHint = null;
         super.redrawUIComponent();
         var _loc1_:* = false;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         if(CompanionAppMode.isOn)
         {
            _loc3_ = stage.stageWidth - 75;
         }
         var _loc5_:int = -1;
         var _loc6_:Number = 0;
         while(_loc6_ < this.ButtonPoolV.length)
         {
            _loc4_ = this.ButtonPoolV[_loc6_];
            if(_loc4_.ButtonVisible && this.CanBeVisible())
            {
               _loc1_ = true;
               _loc5_ = _loc6_;
               if(!this.ButtonHintBarInternal_mc.contains(_loc4_))
               {
                  this.ButtonHintBarInternal_mc.addChild(_loc4_);
               }
               if(_loc4_.bIsDirty)
               {
                  _loc4_.redrawUIComponent();
               }
               if(CompanionAppMode.isOn && _loc4_.Justification == BSButtonHint.JUSTIFY_RIGHT)
               {
                  _loc3_ = _loc3_ - _loc4_.Sizer_mc.width;
                  _loc4_.x = _loc3_;
               }
               else
               {
                  _loc4_.x = _loc2_;
                  _loc2_ = _loc2_ + (_loc4_.Sizer_mc.width + BUTTON_SPACING);
               }
            }
            else if(this.ButtonHintBarInternal_mc.contains(_loc4_))
            {
               this.ButtonHintBarInternal_mc.removeChild(_loc4_);
            }
            _loc6_++;
         }
         if(this.ButtonPoolV.length > this._buttonHintDataV.length)
         {
            this.ButtonPoolV.splice(this._buttonHintDataV.length,this.ButtonPoolV.length - this._buttonHintDataV.length);
         }
         var _loc7_:Rectangle = new Rectangle(0,0,0,0);
         if(_loc5_ >= 0)
         {
            _loc7_.width = this.ButtonPoolV[_loc5_].x + this.ButtonPoolV[_loc5_].Sizer_mc.width;
            _loc7_.height = this.ButtonPoolV[_loc5_].y + this.ButtonPoolV[_loc5_].Sizer_mc.height;
         }
         if(this.Sizer_mc && this.ButtonHintBarInternal_mc.contains(this.Sizer_mc))
         {
            this.ButtonHintBarInternal_mc.removeChild(this.Sizer_mc);
         }
         this.Sizer_mc = new MovieClip();
         var _loc8_:Graphics = this.Sizer_mc.graphics;
         this.ButtonHintBarInternal_mc.addChildAt(this.Sizer_mc,0);
         _loc8_.clear();
         _loc8_.beginFill(BACKGROUND_COLOR,!!this.m_UseBackground?Number(BACKGROUND_ALPHA):Number(0));
         _loc8_.drawRect(0,0,_loc7_.width + BACKGROUND_PAD,_loc7_.height);
         _loc8_.endFill();
         this.Sizer_mc.x = BACKGROUND_PAD * -0.5;
         if(!CompanionAppMode.isOn)
         {
            this.ButtonHintBarInternal_mc.x = -_loc7_.width / 2;
         }
         visible = _loc1_;
         if(this.Alignment == ALIGN_LEFT)
         {
            this.x = this.StartingXPos + _loc7_.width / 2;
         }
         else if(this.Alignment != ALIGN_CENTER)
         {
            if(this.Alignment == ALIGN_RIGHT)
            {
               this.x = this.StartingXPos - _loc7_.width / 2;
            }
         }
      }
   }
}
