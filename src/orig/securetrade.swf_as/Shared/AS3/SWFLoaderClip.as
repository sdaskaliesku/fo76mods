package Shared.AS3 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class SWFLoaderClip extends flash.display.MovieClip
    {
        public function SWFLoaderClip()
        {
            this.AltMenuName = new String();
            super();
            this.SWF = null;
            this.menuLoader = new flash.display.Loader();
            return;
        }

        public function get clipYOffset():Number
        {
            return this.ClipYOffset;
        }

        public function set clipXOffset(arg1:Number):*
        {
            this.ClipXOffset = arg1;
            return;
        }

        public function get clipXOffset():Number
        {
            return this.ClipXOffset;
        }

        public function set centerClip(arg1:Boolean):*
        {
            this.CenterClip = arg1;
            return;
        }

        public function get centerClip():Boolean
        {
            return this.CenterClip;
        }

        public function forceUnload():*
        {
            if (this.SWF) 
            {
                this.SWFUnload(this.SWF);
            }
            return;
        }

        public function SWFLoad(arg1:String):void
        {
            try 
            {
                this.menuLoader.close();
            }
            catch (e:Error)
            {
            };
            if (this.SWF) 
            {
                this.SWFUnload(this.SWF);
            }
            var loc1:*=new flash.net.URLRequest(arg1 + ".swf");
            this.menuLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.onMenuLoadComplete);
            this.menuLoader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this._ioErrorEventHandler, false, 0, true);
            this.menuLoader.load(loc1);
            return;
        }

        public function SWFLoadAlt(arg1:String, arg2:String):*
        {
            this.AltMenuName = arg2;
            this.SWFLoad(arg1);
            return;
        }

        internal function _ioErrorEventHandler(arg1:flash.events.IOErrorEvent):*
        {
            if (this.AltMenuName.length > 0) 
            {
                this.SWFLoad(this.AltMenuName);
            }
            else 
            {
                trace("Failed to load .swf. " + new Error().getStackTrace());
            }
            return;
        }

        public function onMenuLoadComplete(arg1:flash.events.Event):void
        {
            this.SWF = arg1.currentTarget.content;
            addChild(this.SWF);
            this.SWF.scaleX = this.ClipScale;
            this.SWF.scaleY = this.ClipScale;
            this.SWF.alpha = this.ClipAlpha;
            if (this.ClipWidth != 0) 
            {
                this.SWF.width = this.ClipWidth;
            }
            if (this.ClipHeight != 0) 
            {
                this.SWF.height = this.ClipHeight;
            }
            if (this.CenterClip) 
            {
                this.SWF.x = this.SWF.width * -0.5;
                this.SWF.y = this.SWF.height * -0.5;
            }
            this.SWF.x = this.SWF.x + this.ClipXOffset;
            this.SWF.y = this.SWF.y + this.ClipYOffset;
            return;
        }

        public function SWFUnload(arg1:flash.display.DisplayObject):void
        {
            removeChild(arg1);
            arg1.loaderInfo.loader.unload();
            this.SWF = null;
            return;
        }

        internal function getIconClip(arg1:String, arg2:String="", arg3:String=null):flash.display.MovieClip
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!(arg3 == null) && (arg1 == null || arg1.length <= 0)) 
            {
                arg1 = arg3;
            }
            if (!(arg1 == null) && arg1.length > 0) 
            {
                this.forceUnload();
                if (flash.system.ApplicationDomain.currentDomain.hasDefinition(arg1)) 
                {
                    if ((loc1 = flash.utils.getDefinitionByName(arg1) as Class) != null) 
                    {
                        return loc2 = new loc1() as flash.display.MovieClip;
                    }
                }
                else 
                {
                    this.SWFLoad(arg2 + arg1);
                }
            }
            return null;
        }

        public function setContainerIconClip(arg1:String, arg2:String="", arg3:String=null):flash.display.MovieClip
        {
            var loc1:*;
            if ((loc1 = this.getIconClip(arg1, arg2, arg3)) == null) 
            {
                trace("Invalid Icon: Could not find image for path \'" + arg1 + "\'");
            }
            else 
            {
                addChild(loc1);
                loc1.scaleX = this.ClipScale;
                loc1.scaleY = this.ClipScale;
                if (this.ClipWidth != 0) 
                {
                    loc1.width = this.ClipWidth;
                }
                if (this.ClipHeight != 0) 
                {
                    loc1.height = this.ClipHeight;
                }
            }
            return loc1;
        }

        public function set clipAlpha(arg1:Number):*
        {
            this.ClipAlpha = arg1;
            return;
        }

        public function set clipScale(arg1:Number):*
        {
            this.ClipScale = arg1;
            return;
        }

        public function set clipRotation(arg1:Number):*
        {
            this.ClipRotation = arg1;
            return;
        }

        public function set clipWidth(arg1:Number):*
        {
            this.ClipWidth = arg1;
            return;
        }

        public function set clipHeight(arg1:Number):*
        {
            this.ClipHeight = arg1;
            return;
        }

        public function get clipWidth():Number
        {
            return this.ClipWidth;
        }

        public function get clipHeight():Number
        {
            return this.ClipHeight;
        }

        public function get clipScale():Number
        {
            return this.ClipScale;
        }

        public function set clipYOffset(arg1:Number):*
        {
            this.ClipYOffset = arg1;
            return;
        }

        var SWF:flash.display.DisplayObject;

        var menuLoader:flash.display.Loader;

        protected var ClipAlpha:Number=0.65;

        protected var ClipScale:Number=0.5;

        protected var ClipRotation:Number=0;

        protected var ClipWidth:Number=0;

        protected var ClipHeight:Number=0;

        protected var ClipXOffset:Number=0;

        protected var ClipYOffset:Number=0;

        protected var CenterClip:Boolean=false;

        var AltMenuName:String;
    }
}
