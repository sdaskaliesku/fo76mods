 
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
         // method body index: 2845 method index: 2845
         super();
         this.ClipHolderInternal_mc = new MovieClip();
         addChild(this.ClipHolderInternal_mc);
      }
      
      public function get ClipHolderInternal() : MovieClip
      {
         // method body index: 2846 method index: 2846
         return this.ClipHolderInternal_mc;
      }
      
      public function set statusLabel(param1:String) : void
      {
         // method body index: 2847 method index: 2847
         if(param1 != this.m_StatusLabel)
         {
            this.m_StatusLabel = param1;
            SetIsDirty();
         }
      }
      
      public function get statusLabel() : String
      {
         // method body index: 2848 method index: 2848
         return this.m_StatusLabel;
      }
      
      public function set statusColor(param1:uint) : void
      {
         // method body index: 2849 method index: 2849
         this.m_StatusColor = param1 == COLOR_GREEN?uint(uint(COLOR_GREEN)):uint(uint(COLOR_RED));
         SetIsDirty();
      }
      
      public function get statusColor() : uint
      {
         // method body index: 2850 method index: 2850
         return this.m_StatusColor;
      }
      
      public function get bInPowerArmorMode() : Boolean
      {
         // method body index: 2851 method index: 2851
         return this._bInPowerArmorMode;
      }
      
      public function set bInPowerArmorMode(param1:Boolean) : void
      {
         // method body index: 2852 method index: 2852
         if(this._bInPowerArmorMode != param1)
         {
            this._bInPowerArmorMode = param1;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 2853 method index: 2853
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
