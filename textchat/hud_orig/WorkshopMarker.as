 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   
   public class WorkshopMarker extends MovieClip
   {
       
      
      public var Name_tf:TextField;
      
      public var State_tf:TextField;
      
      public var MeterBar_mc:MeterBarWidget;
      
      public var Arrow:MovieClip;
      
      public var ArrowBorder:MovieClip;
      
      public var BG:MovieClip;
      
      public function WorkshopMarker()
      {

         super();
         Extensions.enabled = true;
         this.Arrow.visible = false;
      }
      
      public function Update(astrName:String, astrState:String, afCapturePct:Number, bIsOffScreen:Boolean, bPlayerInContestRadius:Boolean) : void
      {

         var xPct:Number = NaN;
         var yPct:Number = NaN;
         GlobalFunc.SetText(this.Name_tf,astrName,false);
         GlobalFunc.SetText(this.State_tf,astrState,false);
         this.MeterBar_mc.Percent = afCapturePct * 0.01;
         if(bIsOffScreen && !bPlayerInContestRadius)
         {
            this.Arrow.visible = true;
            xPct = (this.x - Extensions.visibleRect.left) / Extensions.visibleRect.width;
            yPct = (this.y - Extensions.visibleRect.top) / Extensions.visibleRect.height;
            this.Arrow.x = xPct * this.ArrowBorder.width;
            this.Arrow.y = yPct * this.ArrowBorder.height;
            this.Arrow.x = this.Arrow.x - this.ArrowBorder.width / 2;
            this.Arrow.y = this.Arrow.y - this.ArrowBorder.height / 2;
            this.Arrow.rotation = Math.atan2(this.Arrow.y,this.Arrow.x) * 180 / Math.PI;
         }
         else
         {
            this.Arrow.visible = false;
         }
         this.AdjustPosition(bPlayerInContestRadius);
      }
      
      private function AdjustPosition(bPlayerInContestRadius:Boolean) : void
      {

         var fRightOffset:Number = NaN;
         var fBottomOffset:Number = NaN;
         if(bPlayerInContestRadius)
         {
            this.x = Extensions.visibleRect.left + Extensions.visibleRect.width / 2;
            this.y = Extensions.visibleRect.top;
         }
         var visibleWidth:Number = this.ArrowBorder.width + this.Arrow.width;
         var visibleHeight:Number = this.ArrowBorder.height + this.Arrow.height;
         var fLeftOffset:Number = this.x - visibleWidth / 2;
         if(fLeftOffset < 0)
         {
            this.x = this.x - fLeftOffset;
         }
         else
         {
            fRightOffset = this.x + visibleWidth / 2 - Extensions.visibleRect.right;
            if(fRightOffset > 0)
            {
               this.x = this.x - fRightOffset;
            }
         }
         var fTopOffset:Number = this.y - visibleHeight / 2;
         if(fTopOffset < 0)
         {
            this.y = this.y - fTopOffset;
         }
         else
         {
            fBottomOffset = this.y + visibleHeight / 2 - Extensions.visibleRect.bottom;
            if(fBottomOffset > 0)
            {
               this.y = this.y - fBottomOffset;
            }
         }
      }
   }
}
