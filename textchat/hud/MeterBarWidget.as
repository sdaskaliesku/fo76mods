 
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
         // method body index: 3062 method index: 3062
         super();
      }
      
      public function get Percent() : Number
      {
         // method body index: 3063 method index: 3063
         return this._percent;
      }
      
      public function set Percent(param1:Number) : *
      {
         // method body index: 3064 method index: 3064
         this._previousPercent = this._percent;
         if(this._percent != param1)
         {
            this._percent = param1;
            SetIsDirty();
         }
      }
      
      public function get BarAlpha() : Number
      {
         // method body index: 3065 method index: 3065
         return this._barAlpha;
      }
      
      public function set BarAlpha(param1:Number) : *
      {
         // method body index: 3066 method index: 3066
         if(this._barAlpha != param1)
         {
            this._barAlpha = param1;
            SetIsDirty();
         }
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3067 method index: 3067
         super.onAddedToStage();
         this.MeterBarInternal_mc.alpha = this.BarAlpha;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3068 method index: 3068
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
