 
package fl.motion
{
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class KeyframeBase
   {
       
      
      private var _index:int = -1;
      
      public var x:Number = NaN;
      
      public var y:Number = NaN;
      
      public var scaleX:Number = NaN;
      
      public var scaleY:Number = NaN;
      
      public var skewX:Number = NaN;
      
      public var skewY:Number = NaN;
      
      public var rotationConcat:Number = NaN;
      
      public var useRotationConcat:Boolean = false;
      
      public var filters:Array;
      
      public var color:Color;
      
      public var label:String = "";
      
      public var loop:String;
      
      public var firstFrame:String;
      
      public var cacheAsBitmap:Boolean = false;
      
      public var opaqueBackground:Object = null;
      
      public var blendMode:String = "normal";
      
      public var visible:Boolean = true;
      
      public var rotateDirection:String = "auto";
      
      public var rotateTimes:uint = 0;
      
      public var orientToPath:Boolean = false;
      
      public var blank:Boolean = false;
      
      public var matrix3D:Object = null;
      
      public var matrix:Matrix = null;
      
      public var z:Number = NaN;
      
      public var rotationX:Number = NaN;
      
      public var rotationY:Number = NaN;
      
      public var adjustColorObjects:Dictionary = null;
      
      public function KeyframeBase(param1:XML = null)
      {

         super();
         this.filters = [];
         this.adjustColorObjects = new Dictionary();
      }
      
      public function get index() : int
      {

         return this._index;
      }
      
      public function set index(param1:int) : void
      {

         this._index = param1 < 0?0:int(int(param1));
         if(this._index == 0)
         {
            this.setDefaults();
         }
      }
      
      public function get rotation() : Number
      {

         return this.skewY;
      }
      
      public function set rotation(param1:Number) : void
      {

         if(isNaN(this.skewX) || isNaN(this.skewY))
         {
            this.skewX = param1;
         }
         else
         {
            this.skewX = this.skewX + (param1 - this.skewY);
         }
         this.skewY = param1;
      }
      
      private function setDefaults() : void
      {

         if(isNaN(this.x))
         {
            this.x = 0;
         }
         if(isNaN(this.y))
         {
            this.y = 0;
         }
         if(isNaN(this.z))
         {
            this.z = 0;
         }
         if(isNaN(this.scaleX))
         {
            this.scaleX = 1;
         }
         if(isNaN(this.scaleY))
         {
            this.scaleY = 1;
         }
         if(isNaN(this.skewX))
         {
            this.skewX = 0;
         }
         if(isNaN(this.skewY))
         {
            this.skewY = 0;
         }
         if(isNaN(this.rotationConcat))
         {
            this.rotationConcat = 0;
         }
         if(!this.color)
         {
            this.color = new Color();
         }
      }
      
      public function getValue(param1:String) : Number
      {

         return Number(this[param1]);
      }
      
      public function setValue(param1:String, param2:Number) : void
      {

         this[param1] = param2;
      }
      
      protected function hasTween() : Boolean
      {

         return false;
      }
      
      public function affectsTweenable(param1:String = "") : Boolean
      {

         return !param1 || !isNaN(this[param1]) || param1 == "color" && this.color || param1 == "filters" && this.filters.length || param1 == "matrix3D" && this.matrix3D || param1 == "matrix" && this.matrix || this.blank || this.hasTween();
      }
      
      public function setAdjustColorProperty(param1:int, param2:String, param3:*) : void
      {

         var _loc4_:ColorMatrixFilter = null;
         var _loc5_:Array = null;
         if(param1 >= this.filters.length)
         {
            return;
         }
         var _loc6_:AdjustColor = this.adjustColorObjects[param1];
         if(_loc6_ == null)
         {
            _loc6_ = new AdjustColor();
            this.adjustColorObjects[param1] = _loc6_;
         }
         switch(param2)
         {
            case "adjustColorBrightness":
               _loc6_.brightness = param3;
               break;
            case "adjustColorContrast":
               _loc6_.contrast = param3;
               break;
            case "adjustColorSaturation":
               _loc6_.saturation = param3;
               break;
            case "adjustColorHue":
               _loc6_.hue = param3;
         }
         if(_loc6_.AllValuesAreSet())
         {
            _loc4_ = this.filters[param1] as ColorMatrixFilter;
            if(_loc4_)
            {
               _loc5_ = _loc6_.CalculateFinalFlatArray();
               if(_loc5_)
               {
                  _loc4_.matrix = _loc5_;
               }
            }
         }
      }
      
      public function get tweensLength() : int
      {

         return 0;
      }
   }
}
