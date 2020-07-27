 
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
      
      public function Update(param1:String, param2:String, param3:Number, param4:Boolean, param5:Boolean) : void
      {

         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         GlobalFunc.SetText(this.Name_tf,param1,false);
         GlobalFunc.SetText(this.State_tf,param2,false);
         this.MeterBar_mc.Percent = param3 * 0.01;
         if(param4 && !param5)
         {
            this.Arrow.visible = true;
            _loc6_ = (this.x - Extensions.visibleRect.left) / Extensions.visibleRect.width;
            _loc7_ = (this.y - Extensions.visibleRect.top) / Extensions.visibleRect.height;
            this.Arrow.x = _loc6_ * this.ArrowBorder.width;
            this.Arrow.y = _loc7_ * this.ArrowBorder.height;
            this.Arrow.x = this.Arrow.x - this.ArrowBorder.width / 2;
            this.Arrow.y = this.Arrow.y - this.ArrowBorder.height / 2;
            this.Arrow.rotation = Math.atan2(this.Arrow.y,this.Arrow.x) * 180 / Math.PI;
         }
         else
         {
            this.Arrow.visible = false;
         }
         this.AdjustPosition(param5);
      }
      
      private function AdjustPosition(param1:Boolean) : void
      {

         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1)
         {
            this.x = Extensions.visibleRect.left + Extensions.visibleRect.width / 2;
            this.y = Extensions.visibleRect.top;
         }
         var _loc4_:Number = this.ArrowBorder.width + this.Arrow.width;
         var _loc5_:Number = this.ArrowBorder.height + this.Arrow.height;
         var _loc6_:Number = this.x - _loc4_ / 2;
         if(_loc6_ < 0)
         {
            this.x = this.x - _loc6_;
         }
         else
         {
            _loc2_ = this.x + _loc4_ / 2 - Extensions.visibleRect.right;
            if(_loc2_ > 0)
            {
               this.x = this.x - _loc2_;
            }
         }
         var _loc7_:Number = this.y - _loc5_ / 2;
         if(_loc7_ < 0)
         {
            this.y = this.y - _loc7_;
         }
         else
         {
            _loc3_ = this.y + _loc5_ / 2 - Extensions.visibleRect.bottom;
            if(_loc3_ > 0)
            {
               this.y = this.y - _loc3_;
            }
         }
      }
   }
}
