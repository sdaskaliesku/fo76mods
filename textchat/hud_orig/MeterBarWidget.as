 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   
   public dynamic class MeterBarWidget extends BSUIComponent
   {
       
      
      public var MeterBarInternal_mc:MovieClip;
      
      private var _percent:Number = 0;
      
      private var _previousPercent:Number = 0;
      
      private var _barAlpha:Number = 1;
      
      public function MeterBarWidget()
      {
         // method body index: 3117 method index: 3117
         super();
      }
      
      public function get Percent() : Number
      {
         // method body index: 3111 method index: 3111
         return this._percent;
      }
      
      public function set Percent(aPercent:Number) : *
      {
         // method body index: 3112 method index: 3112
         this._previousPercent = this._percent;
         if(this._percent != aPercent)
         {
            this._percent = aPercent;
            SetIsDirty();
         }
      }
      
      public function get BarAlpha() : Number
      {
         // method body index: 3113 method index: 3113
         return this._barAlpha;
      }
      
      public function set BarAlpha(aBarAlpha:Number) : *
      {
         // method body index: 3114 method index: 3114
         if(this._barAlpha != aBarAlpha)
         {
            this._barAlpha = aBarAlpha;
            SetIsDirty();
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3115 method index: 3115
         super.onAddedToStage();
         this.MeterBarInternal_mc.alpha = this.BarAlpha;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3116 method index: 3116
         super.redrawUIComponent();
         this.MeterBarInternal_mc.alpha = this.BarAlpha;
         this.MeterBarInternal_mc.Contents.Fill.gotoAndStop(this.Percent * 300 + 1);
         if(this.MeterBarInternal_mc.Contents.Fill.healthBarLeader != null)
         {
            if(this._previousPercent != this._percent)
            {
               this.MeterBarInternal_mc.Contents.Fill.healthBarLeader.visible = true;
            }
            else
            {
               this.MeterBarInternal_mc.Contents.Fill.healthBarLeader.visible = false;
            }
         }
      }
   }
}
