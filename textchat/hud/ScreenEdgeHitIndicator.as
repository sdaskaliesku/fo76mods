 
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
         // method body index: 2237 method index: 2237
         super();
         BSUIDataManager.Subscribe("HitIndicators",this.onHitIndicatorsUpdate);
      }
      
      private function onHitIndicatorsUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 2238 method index: 2238
         var _loc2_:Array = param1.data.hits;
         var _loc3_:uint = 0;
         var _loc4_:Number = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc2_[_loc5_].isNew && !_loc2_[_loc5_].reducedPvpDamage)
            {
               _loc3_++;
               _loc4_ = _loc4_ + _loc2_[_loc5_].theta;
            }
            _loc5_++;
         }
         var _loc6_:Number = _loc4_ / _loc3_;
         _loc6_ = (_loc6_ + 90) % 360;
         if(_loc6_ < 0)
         {
            _loc6_ = 360 - Math.abs(_loc6_);
         }
         var _loc7_:Boolean = _loc6_ <= 45 || _loc6_ >= 315;
         var _loc8_:Boolean = _loc6_ >= 135 && _loc6_ <= 225;
         var _loc9_:Boolean = _loc6_ >= 225 && _loc6_ <= 315;
         var _loc10_:Boolean = _loc6_ >= 45 && _loc6_ <= 135;
         if(_loc7_)
         {
            this.Top_mc.gotoAndPlay("hit");
         }
         if(_loc8_)
         {
            this.Bottom_mc.gotoAndPlay("hit");
         }
         if(_loc9_)
         {
            this.Left_mc.gotoAndPlay("hit");
         }
         if(_loc10_)
         {
            this.Right_mc.gotoAndPlay("hit");
         }
      }
   }
}
