 
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

         super();
      }
      
      public function get Percent() : Number
      {

         return this._percent;
      }
      
      public function set Percent(aPercent:Number) : *
      {

         this._previousPercent = this._percent;
         if(this._percent != aPercent)
         {
            this._percent = aPercent;
            SetIsDirty();
         }
      }
      
      public function get BarAlpha() : Number
      {

         return this._barAlpha;
      }
      
      public function set BarAlpha(aBarAlpha:Number) : *
      {

         if(this._barAlpha != aBarAlpha)
         {
            this._barAlpha = aBarAlpha;
            SetIsDirty();
         }
      }
      
      override public function onAddedToStage() : void
      {

         super.onAddedToStage();
         this.MeterBarInternal_mc.alpha = this.BarAlpha;
      }
      
      override public function redrawUIComponent() : void
      {

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
