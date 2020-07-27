 
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
         // method body index: 2871 method index: 2871
         super();
         this._starClips = new Vector.<MovieClip>();
      }
      
      public function SetCritStars(aCurrCount:uint, aMaxCount:uint) : *
      {
         // method body index: 2872 method index: 2872
         if(this._numStarsFilled != aCurrCount)
         {
            this._numStarsFilled = aCurrCount;
            SetIsDirty();
         }
         if(this._numStarsShown != aMaxCount)
         {
            this._numStarsShown = aMaxCount;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 2873 method index: 2873
         var newStar:CritMeterStar = null;
         var oldStar:* = undefined;
         super.redrawUIComponent();
         while(this._starClips.length < this._numStarsShown)
         {
            newStar = new CritMeterStar();
            addChild(newStar);
            newStar.x = this._starClips.length * this._starSpacingX;
            newStar.visible = true;
            this._starClips.push(newStar);
         }
         while(this._starClips.length > this._numStarsShown)
         {
            oldStar = this._starClips.pop();
            removeChild(oldStar);
         }
         for(var i:uint = 0; i < this._starClips.length; i++)
         {
            this._starClips[i].gotoAndStop(this._numStarsFilled > i?"full":"empty");
         }
      }
   }
}
