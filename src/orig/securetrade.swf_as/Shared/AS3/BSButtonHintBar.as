package Shared.AS3 
{
    import Shared.AS3.COMPANIONAPP.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    public dynamic class BSButtonHintBar extends Shared.AS3.BSUIComponent
    {
        public function BSButtonHintBar()
        {
            this.SetButtonHintData = this.SetButtonHintData_Impl;
            super();
            visible = false;
            this.ButtonHintBarInternal_mc = new flash.display.MovieClip();
            this.ButtonHintBarInternal_mc.y = BAR_Y_OFFSET;
            addChild(this.ButtonHintBarInternal_mc);
            this._buttonHintDataV = new Vector.<Shared.AS3.BSButtonHintData>();
            this.ButtonPoolV = new Vector.<Shared.AS3.BSButtonHint>();
            this.StartingXPos = this.x;
            return;
        }

        public function set align(arg1:uint):*
        {
            this.Alignment = arg1;
            SetIsDirty();
            return;
        }

        internal function CanBeVisible():Boolean
        {
            return !this.bRedirectToButtonBarMenu_Inspectable || !bAcquiredByNativeCode;
        }

        public override function onAcquiredByNativeCode():*
        {
            var loc1:*=null;
            super.onAcquiredByNativeCode();
            if (this.bRedirectToButtonBarMenu_Inspectable) 
            {
                this.SetButtonHintData(this._buttonHintDataV);
                loc1 = new Vector.<Shared.AS3.BSButtonHintData>();
                this.SetButtonHintData_Impl(loc1);
                SetIsDirty();
            }
            return;
        }

        internal function SetButtonHintData_Impl(arg1:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>):void
        {
            var abuttonHintDataV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;

            var loc1:*;
            abuttonHintDataV = arg1;
            this._buttonHintDataV.forEach(function (arg1:Shared.AS3.BSButtonHintData, arg2:int, arg3:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>):*
            {
                if (arg1) 
                {
                    arg1.removeEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
                }
                return;
            }, this)
            this._buttonHintDataV = abuttonHintDataV;
            this._buttonHintDataV.forEach(function (arg1:Shared.AS3.BSButtonHintData, arg2:int, arg3:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>):*
            {
                if (arg1) 
                {
                    arg1.addEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
                }
                return;
            }, this)
            this.CreateButtonHints();
            return;
        }

        public function onButtonHintDataDirtyEvent(arg1:flash.events.Event):void
        {
            SetIsDirty();
            return;
        }

        internal function CreateButtonHints():*
        {
            visible = false;
            while (this.ButtonPoolV.length < this._buttonHintDataV.length) 
            {
                if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
                {
                    this.ButtonPoolV.push(new Shared.AS3.COMPANIONAPP.MobileButtonHint());
                    continue;
                }
                this.ButtonPoolV.push(new Shared.AS3.BSButtonHint());
            }
            var loc1:*=0;
            while (loc1 < this.ButtonPoolV.length) 
            {
                this.ButtonPoolV[loc1].ButtonHintData = loc1 < this._buttonHintDataV.length ? this._buttonHintDataV[loc1] : null;
                ++loc1;
            }
            SetIsDirty();
            return;
        }

        public override function onAddedToStage():void
        {
            super.onAddedToStage();
            return;
        }

        public override function redrawUIComponent():void
        {
            var loc4:*=null;
            super.redrawUIComponent();
            var loc1:*=false;
            var loc2:*=0;
            var loc3:*=0;
            if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                loc3 = stage.stageWidth - 75;
            }
            var loc5:*=-1;
            var loc6:*=0;
            while (loc6 < this.ButtonPoolV.length) 
            {
                if ((loc4 = this.ButtonPoolV[loc6]).ButtonVisible && this.CanBeVisible()) 
                {
                    loc1 = true;
                    loc4.useVaultTecColor = this.useVaultTecColor;
                    loc5 = loc6;
                    if (!this.ButtonHintBarInternal_mc.contains(loc4)) 
                    {
                        this.ButtonHintBarInternal_mc.addChild(loc4);
                    }
                    if (loc4.bIsDirty) 
                    {
                        loc4.redrawUIComponent();
                    }
                    if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn && loc4.Justification == Shared.AS3.BSButtonHint.JUSTIFY_RIGHT) 
                    {
                        loc3 = loc3 - loc4.Sizer_mc.width;
                        loc4.x = loc3;
                    }
                    else 
                    {
                        loc4.x = loc2;
                        loc2 = loc2 + (loc4.Sizer_mc.width + BUTTON_SPACING);
                    }
                }
                else if (this.ButtonHintBarInternal_mc.contains(loc4)) 
                {
                    this.ButtonHintBarInternal_mc.removeChild(loc4);
                }
                ++loc6;
            }
            if (this.ButtonPoolV.length > this._buttonHintDataV.length) 
            {
                this.ButtonPoolV.splice(this._buttonHintDataV.length, this.ButtonPoolV.length - this._buttonHintDataV.length);
            }
            var loc7:*=new flash.geom.Rectangle(0, 0, 0, 0);
            if (loc5 >= 0) 
            {
                loc7.width = this.ButtonPoolV[loc5].x + this.ButtonPoolV[loc5].Sizer_mc.width;
                loc7.height = this.ButtonPoolV[loc5].y + this.ButtonPoolV[loc5].Sizer_mc.height;
            }
            if (this.Sizer_mc && this.ButtonHintBarInternal_mc.contains(this.Sizer_mc)) 
            {
                this.ButtonHintBarInternal_mc.removeChild(this.Sizer_mc);
            }
            this.Sizer_mc = new flash.display.MovieClip();
            var loc8:*=this.Sizer_mc.graphics;
            this.ButtonHintBarInternal_mc.addChildAt(this.Sizer_mc, 0);
            loc8.clear();
            loc8.beginFill(BACKGROUND_COLOR, this.m_UseBackground ? BACKGROUND_ALPHA : 0);
            loc8.drawRect(0, 0, loc7.width + BACKGROUND_PAD, loc7.height);
            loc8.endFill();
            this.Sizer_mc.x = BACKGROUND_PAD * -0.5;
            if (!Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                this.ButtonHintBarInternal_mc.x = (-loc7.width) / 2;
            }
            visible = loc1;
            if (this.Alignment != ALIGN_LEFT) 
            {
                if (this.Alignment != ALIGN_CENTER) 
                {
                    if (this.Alignment == ALIGN_RIGHT) 
                    {
                        this.x = this.StartingXPos - loc7.width / 2;
                    }
                }
            }
            else 
            {
                this.x = this.StartingXPos + loc7.width / 2;
            }
            return;
        }

        
        {
            BACKGROUND_COLOR = 0;
            BACKGROUND_ALPHA = 0.4;
            BACKGROUND_PAD = 8;
            BUTTON_SPACING = 20;
            BAR_Y_OFFSET = 5;
            ALIGN_CENTER = 0;
            ALIGN_LEFT = 1;
            ALIGN_RIGHT = 2;
        }

        public function set useBackground(arg1:Boolean):void
        {
            this.m_UseBackground = arg1;
            SetIsDirty();
            return;
        }

        public function get useBackground():Boolean
        {
            return this.m_UseBackground;
        }

        public function get bRedirectToButtonBarMenu_Inspectable():Boolean
        {
            return this._bRedirectToButtonBarMenu;
        }

        public function set bRedirectToButtonBarMenu_Inspectable(arg1:Boolean):*
        {
            if (this._bRedirectToButtonBarMenu != arg1) 
            {
                this._bRedirectToButtonBarMenu = arg1;
                SetIsDirty();
            }
            return;
        }

        public function get useVaultTecColor():Boolean
        {
            return this.m_UseVaultTecColor;
        }

        public function set useVaultTecColor(arg1:Boolean):void
        {
            if (this.m_UseVaultTecColor != arg1) 
            {
                this.m_UseVaultTecColor = arg1;
                SetIsDirty();
            }
            return;
        }

        public var Sizer_mc:flash.display.MovieClip;

        internal var Alignment:int=0;

        internal var StartingXPos:int=0;

        internal var m_UseBackground:Boolean=true;

        internal var ButtonHintBarInternal_mc:flash.display.MovieClip;

        internal var _buttonHintDataV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;

        internal var ButtonPoolV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHint>;

        internal var m_UseVaultTecColor:Boolean=true;

        internal var _bRedirectToButtonBarMenu:Boolean=true;

        public static var BACKGROUND_COLOR:uint=0;

        public static var BACKGROUND_ALPHA:Number=0.4;

        public static var BACKGROUND_PAD:Number=8;

        public static var BUTTON_SPACING:Number=20;

        public static var BAR_Y_OFFSET:Number=5;

        internal static var ALIGN_CENTER:*=0;

        internal static var ALIGN_LEFT:*=1;

        internal static var ALIGN_RIGHT:*=2;

        public var SetButtonHintData:Function;
    }
}
