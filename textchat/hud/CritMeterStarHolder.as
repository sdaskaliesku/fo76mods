 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   
   public class CritMeterStarHolder extends BSUIComponent
   {
       
      
      private var _starClips:Vector.<MovieClip>;
      
      private var _numStarsFilled:uint = 0;
      
      private var _numStarsShown:uint = 0;
      
      private var _starSpacingX:uint = 22;
      
      public function CritMeterStarHolder()
      {

         super();
         this._starClips = new Vector.<MovieClip>();
      }
      
      public function SetCritStars(param1:uint, param2:uint) : *
      {

         if(this._numStarsFilled != param1)
         {
            this._numStarsFilled = param1;
            SetIsDirty();
         }
         if(this._numStarsShown != param2)
         {
            this._numStarsShown = param2;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {

         var _loc1_:CritMeterStar = null;
         _loc1_ = null;
         var _loc2_:* = undefined;
         super.redrawUIComponent();
         while(this._starClips.length < this._numStarsShown)
         {
            _loc1_ = new CritMeterStar();
            addChild(_loc1_);
            _loc1_.x = this._starClips.length * this._starSpacingX;
            _loc1_.visible = true;
            this._starClips.push(_loc1_);
         }
         while(this._starClips.length > this._numStarsShown)
         {
            _loc2_ = this._starClips.pop();
            removeChild(_loc2_);
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._starClips.length)
         {
            this._starClips[_loc3_].gotoAndStop(this._numStarsFilled > _loc3_?"full":"empty");
            _loc3_++;
         }
      }
   }
}
