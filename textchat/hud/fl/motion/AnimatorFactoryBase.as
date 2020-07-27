 
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

         return this._motion;
      }
      
      public function addTarget(param1:DisplayObject, param2:int = 0, param3:Boolean = true, param4:int = -1, param5:Boolean = false) : AnimatorBase
      {

         if(param1)
         {
            return this.addTargetInfo(param1.parent,param1.name,param2,param3,param4,param5);
         }
         return null;
      }
      
      protected function getNewAnimator() : AnimatorBase
      {

         return null;
      }
      
      public function addTargetInfo(param1:DisplayObject, param2:String, param3:int = 0, param4:Boolean = true, param5:int = -1, param6:Boolean = false, param7:Array = null, param8:int = -1, param9:String = null, param10:Class = null) : AnimatorBase
      {

         var _loc11_:Class = null;
         if(!(param1 is DisplayObjectContainer) && !(param1 is SimpleButton))
         {
            return null;
         }
         var _loc12_:Dictionary = this._animators[param1];
         if(!_loc12_)
         {
            _loc12_ = new Dictionary();
            this._animators[param1] = _loc12_;
         }
         var _loc13_:AnimatorBase = _loc12_[param2];
         var _loc14_:Boolean = false;
         if(!_loc13_)
         {
            _loc13_ = this.getNewAnimator();
            _loc11_ = getDefinitionByName("flash.events.Event") as Class;
            if(_loc11_.hasOwnProperty("FRAME_CONSTRUCTED"))
            {
               _loc13_.frameEvent = "frameConstructed";
            }
            _loc12_[param2] = _loc13_;
            _loc14_ = true;
         }
         _loc13_.motion = this._motion;
         _loc13_.motionArray = this._motionArray;
         _loc13_.transformationPoint = this._transformationPoint;
         _loc13_.transformationPointZ = this._transformationPointZ;
         _loc13_.sceneName = this._sceneName;
         if(_loc14_)
         {
            if(param1 is MovieClip)
            {
               AnimatorBase.registerParentFrameHandler(param1 as MovieClip,_loc13_,param5,param3,param6);
            }
         }
         if(param1 is MovieClip)
         {
            _loc13_.targetParent = MovieClip(param1);
            _loc13_.targetName = param2;
            _loc13_.placeholderName = param9;
            _loc13_.instanceFactoryClass = param10;
         }
         else if(param1 is SimpleButton)
         {
            AnimatorBase.registerButtonState(param1 as SimpleButton,_loc13_,param5,param8,param2,param9,param10);
         }
         else if(param1 is Sprite)
         {
            AnimatorBase.registerSpriteParent(param1 as Sprite,_loc13_,param2,param9,param10);
         }
         if(param7)
         {
            _loc13_.initialPosition = param7;
         }
         if(param4)
         {
            AnimatorBase.processCurrentFrame(param1 as MovieClip,_loc13_,true,true);
         }
         return _loc13_;
      }
      
      public function set transformationPoint(param1:Point) : void
      {

         this._transformationPoint = param1;
      }
      
      public function set transformationPointZ(param1:int) : void
      {

         this._transformationPointZ = param1;
      }
      
      public function set sceneName(param1:String) : void
      {

         this._sceneName = param1;
      }
   }
}
