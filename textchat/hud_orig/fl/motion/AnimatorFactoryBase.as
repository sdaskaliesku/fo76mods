 
package fl.motion
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class AnimatorFactoryBase
   {
       
      
      private var _motion:MotionBase;
      
      private var _motionArray:Array;
      
      private var _animators:Dictionary;
      
      protected var _transformationPoint:Point;
      
      protected var _transformationPointZ:int;
      
      protected var _is3D:Boolean;
      
      protected var _sceneName:String;
      
      public function AnimatorFactoryBase(param1:MotionBase, param2:Array = null)
      {
         // method body index: 222 method index: 222
         super();
         this._motion = param1;
         this._motionArray = param2;
         this._animators = new Dictionary(true);
         this._transformationPoint = new Point(0.5,0.5);
         this._transformationPointZ = 0;
         this._is3D = false;
         this._sceneName = "";
      }
      
      public function get motion() : MotionBase
      {
         // method body index: 223 method index: 223
         return this._motion;
      }
      
      public function addTarget(param1:DisplayObject, param2:int = 0, param3:Boolean = true, param4:int = -1, param5:Boolean = false) : AnimatorBase
      {
         // method body index: 224 method index: 224
         if(param1)
         {
            return this.addTargetInfo(param1.parent,param1.name,param2,param3,param4,param5);
         }
         return null;
      }
      
      protected function getNewAnimator() : AnimatorBase
      {
         // method body index: 225 method index: 225
         return null;
      }
      
      public function addTargetInfo(param1:DisplayObject, param2:String, param3:int = 0, param4:Boolean = true, param5:int = -1, param6:Boolean = false, param7:Array = null, param8:int = -1, param9:String = null, param10:Class = null) : AnimatorBase
      {
         // method body index: 226 method index: 226
         var _loc14_:Class = null;
         if(!(param1 is DisplayObjectContainer) && !(param1 is SimpleButton))
         {
            return null;
         }
         var _loc11_:Dictionary = this._animators[param1];
         if(!_loc11_)
         {
            _loc11_ = new Dictionary();
            this._animators[param1] = _loc11_;
         }
         var _loc12_:AnimatorBase = _loc11_[param2];
         var _loc13_:Boolean = false;
         if(!_loc12_)
         {
            _loc12_ = this.getNewAnimator();
            _loc14_ = getDefinitionByName("flash.events.Event") as Class;
            if(_loc14_.hasOwnProperty("FRAME_CONSTRUCTED"))
            {
               _loc12_.frameEvent = "frameConstructed";
            }
            _loc11_[param2] = _loc12_;
            _loc13_ = true;
         }
         _loc12_.motion = this._motion;
         _loc12_.motionArray = this._motionArray;
         _loc12_.transformationPoint = this._transformationPoint;
         _loc12_.transformationPointZ = this._transformationPointZ;
         _loc12_.sceneName = this._sceneName;
         if(_loc13_)
         {
            if(param1 is MovieClip)
            {
               AnimatorBase.registerParentFrameHandler(param1 as MovieClip,_loc12_,param5,param3,param6);
            }
         }
         if(param1 is MovieClip)
         {
            _loc12_.targetParent = MovieClip(param1);
            _loc12_.targetName = param2;
            _loc12_.placeholderName = param9;
            _loc12_.instanceFactoryClass = param10;
         }
         else if(param1 is SimpleButton)
         {
            AnimatorBase.registerButtonState(param1 as SimpleButton,_loc12_,param5,param8,param2,param9,param10);
         }
         else if(param1 is Sprite)
         {
            AnimatorBase.registerSpriteParent(param1 as Sprite,_loc12_,param2,param9,param10);
         }
         if(param7)
         {
            _loc12_.initialPosition = param7;
         }
         if(param4)
         {
            AnimatorBase.processCurrentFrame(param1 as MovieClip,_loc12_,true,true);
         }
         return _loc12_;
      }
      
      public function set transformationPoint(param1:Point) : void
      {
         // method body index: 227 method index: 227
         this._transformationPoint = param1;
      }
      
      public function set transformationPointZ(param1:int) : void
      {
         // method body index: 228 method index: 228
         this._transformationPointZ = param1;
      }
      
      public function set sceneName(param1:String) : void
      {
         // method body index: 229 method index: 229
         this._sceneName = param1;
      }
   }
}
