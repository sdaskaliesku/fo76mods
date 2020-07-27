 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   public dynamic class HUDActiveEffectsWidget extends BSUIComponent
   {
      
      private static const COLOR_GREEN:uint = // method body index: 2844 method index: 2844
      0;
      
      private static const COLOR_RED:uint = // method body index: 2844 method index: 2844
      1;
       
      
      public var ActiveEffectStatusLabel_mc:MovieClip;
      
      public var MAX_NUM_CLIPS:uint = 8;
      
      public var CLIP_HEIGHT:Number = 35;
      
      public var CLIP_SPACER:Number = 4;
      
      public var CLIP_FLASH_CLASS:String = "HUDActiveEffectClip";
      
      private var ClipHolderInternal_mc:MovieClip;
      
      private var m_StatusLabel:String = "";
      
      private const RedColorTransform:ColorTransform = // method body index: 2845 method index: 2845
      new ColorTransform(0,0,0,1,255,95,61,0);
      
      private var m_StatusColor:uint = 0;
      
      private var _bInPowerArmorMode:Boolean = false;
      
      public function HUDActiveEffectsWidget()
      {

         super();
         this.ClipHolderInternal_mc = new MovieClip();
         addChild(this.ClipHolderInternal_mc);
      }
      
      public function get ClipHolderInternal() : MovieClip
      {

         return this.ClipHolderInternal_mc;
      }
      
      public function set statusLabel(param1:String) : void
      {

         if(param1 != this.m_StatusLabel)
         {
            this.m_StatusLabel = param1;
            SetIsDirty();
         }
      }
      
      public function get statusLabel() : String
      {

         return this.m_StatusLabel;
      }
      
      public function set statusColor(param1:uint) : void
      {

         this.m_StatusColor = param1 == COLOR_GREEN?uint(uint(COLOR_GREEN)):uint(uint(COLOR_RED));
         SetIsDirty();
      }
      
      public function get statusColor() : uint
      {

         return this.m_StatusColor;
      }
      
      public function get bInPowerArmorMode() : Boolean
      {

         return this._bInPowerArmorMode;
      }
      
      public function set bInPowerArmorMode(param1:Boolean) : void
      {

         if(this._bInPowerArmorMode != param1)
         {
            this._bInPowerArmorMode = param1;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {

         if(this.bInPowerArmorMode)
         {
            this.ClipHolderInternal_mc.x = 50;
            this.ClipHolderInternal_mc.y = 15;
         }
         else
         {
            this.ClipHolderInternal_mc.x = 0;
            this.ClipHolderInternal_mc.y = 0;
         }
      }
   }
}
