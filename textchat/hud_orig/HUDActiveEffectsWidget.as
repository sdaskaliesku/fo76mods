 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   public dynamic class HUDActiveEffectsWidget extends BSUIComponent
   {
      
      private static const COLOR_GREEN:uint = // method body index: 2906 method index: 2906
      0;
      
      private static const COLOR_RED:uint = // method body index: 2906 method index: 2906
      1;
       
      
      public var ActiveEffectStatusLabel_mc:MovieClip;
      
      public var MAX_NUM_CLIPS:uint = 8;
      
      public var CLIP_HEIGHT:Number = 35;
      
      public var CLIP_SPACER:Number = 4;
      
      public var CLIP_FLASH_CLASS:String = "HUDActiveEffectClip";
      
      private var ClipHolderInternal_mc:MovieClip;
      
      private var m_StatusLabel:String = "";
      
      private const RedColorTransform:ColorTransform = // method body index: 2914 method index: 2914
      new ColorTransform(0,0,0,1,255,95,61,0);
      
      private var m_StatusColor:uint = 0;
      
      private var _bInPowerArmorMode:Boolean = false;
      
      public function HUDActiveEffectsWidget()
      {
         // method body index: 2914 method index: 2914
         super();
         this.ClipHolderInternal_mc = new MovieClip();
         addChild(this.ClipHolderInternal_mc);
      }
      
      public function get ClipHolderInternal() : MovieClip
      {
         // method body index: 2907 method index: 2907
         return this.ClipHolderInternal_mc;
      }
      
      public function set statusLabel(aLabel:String) : void
      {
         // method body index: 2908 method index: 2908
         if(aLabel != this.m_StatusLabel)
         {
            this.m_StatusLabel = aLabel;
            SetIsDirty();
         }
      }
      
      public function get statusLabel() : String
      {
         // method body index: 2909 method index: 2909
         return this.m_StatusLabel;
      }
      
      public function set statusColor(aColor:uint) : void
      {
         // method body index: 2910 method index: 2910
         this.m_StatusColor = aColor == COLOR_GREEN?uint(COLOR_GREEN):uint(COLOR_RED);
         SetIsDirty();
      }
      
      public function get statusColor() : uint
      {
         // method body index: 2911 method index: 2911
         return this.m_StatusColor;
      }
      
      public function get bInPowerArmorMode() : Boolean
      {
         // method body index: 2912 method index: 2912
         return this._bInPowerArmorMode;
      }
      
      public function set bInPowerArmorMode(value:Boolean) : void
      {
         // method body index: 2913 method index: 2913
         if(this._bInPowerArmorMode != value)
         {
            this._bInPowerArmorMode = value;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 2915 method index: 2915
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
