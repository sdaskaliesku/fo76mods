
{
   // method body index: 2 method index: 2
   PropertyTint.register();
   PropertyFrame.register();
   PropertyFilter.register();
   PropertyVolume.register();
   PropertyColorMatrix.register();
   PropertyBezier.register();
   PropertyShortRotation.register();
   var _loc1_:* = PropertyRect.register();
   return _loc1_;
}

package aze.motion
{
   public function eaze(target:Object) : EazeTween
   {
      // method body index: 1 method index: 1
      return new EazeTween(target);
   }
}
