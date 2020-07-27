 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import flash.display.MovieClip;
   
   public class ScreenEdgeHitIndicator extends MovieClip
   {
       
      
      public var Top_mc:MovieClip;
      
      public var Bottom_mc:MovieClip;
      
      public var Left_mc:MovieClip;
      
      public var Right_mc:MovieClip;
      
      public function ScreenEdgeHitIndicator()
      {

         super();
         BSUIDataManager.Subscribe("HitIndicators",this.onHitIndicatorsUpdate);
      }
      
      private function onHitIndicatorsUpdate(arEvent:FromClientDataEvent) : void
      {

         var hitsArray:Array = arEvent.data.hits;
         var hitCount:uint = 0;
         var thetaSum:Number = 0;
         for(var i:uint = 0; i < hitsArray.length; i++)
         {
            if(hitsArray[i].isNew && !hitsArray[i].reducedPvpDamage)
            {
               hitCount++;
               thetaSum = thetaSum + hitsArray[i].theta;
            }
         }
         var thetaAverage:Number = thetaSum / hitCount;
         thetaAverage = (thetaAverage + 90) % 360;
         if(thetaAverage < 0)
         {
            thetaAverage = 360 - Math.abs(thetaAverage);
         }
         var topVis:Boolean = thetaAverage <= 45 || thetaAverage >= 315;
         var botVis:Boolean = thetaAverage >= 135 && thetaAverage <= 225;
         var leftVis:Boolean = thetaAverage >= 225 && thetaAverage <= 315;
         var rightVis:Boolean = thetaAverage >= 45 && thetaAverage <= 135;
         if(topVis)
         {
            this.Top_mc.gotoAndPlay("hit");
         }
         if(botVis)
         {
            this.Bottom_mc.gotoAndPlay("hit");
         }
         if(leftVis)
         {
            this.Left_mc.gotoAndPlay("hit");
         }
         if(rightVis)
         {
            this.Right_mc.gotoAndPlay("hit");
         }
      }
   }
}
