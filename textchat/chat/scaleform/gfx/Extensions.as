 
package scaleform.gfx
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public final class Extensions
   {
      
      public static const EDGEAA_INHERIT:uint = // method body index: 0 method index: 0
      0;
      
      public static const EDGEAA_ON:uint = // method body index: 0 method index: 0
      1;
      
      public static const EDGEAA_OFF:uint = // method body index: 0 method index: 0
      2;
      
      public static const EDGEAA_DISABLE:uint = // method body index: 0 method index: 0
      3;
      
      public static var isGFxPlayer:Boolean = // method body index: 0 method index: 0
      false;
      
      public static var CLIK_addedToStageCallback:Function;
      
      public static var gfxProcessSound:Function;
       
      
      public function Extensions()
      {
         // method body index: 15 method index: 15
         super();
      }
      
      public static function set enabled(param1:Boolean) : void
      {
         // method body index: 1 method index: 1
      }
      
      public static function get enabled() : Boolean
      {
         // method body index: 2 method index: 2
         return false;
      }
      
      public static function set noInvisibleAdvance(param1:Boolean) : void
      {
         // method body index: 3 method index: 3
      }
      
      public static function get noInvisibleAdvance() : Boolean
      {
         // method body index: 4 method index: 4
         return false;
      }
      
      public static function getTopMostEntity(param1:Number, param2:Number, param3:Boolean = true) : DisplayObject
      {
         // method body index: 5 method index: 5
         return null;
      }
      
      public static function getMouseTopMostEntity(param1:Boolean = true, param2:uint = 0) : DisplayObject
      {
         // method body index: 6 method index: 6
         return null;
      }
      
      public static function setMouseCursorType(param1:String, param2:uint = 0) : void
      {
         // method body index: 7 method index: 7
      }
      
      public static function getMouseCursorType(param1:uint = 0) : String
      {
         // method body index: 8 method index: 8
         return "";
      }
      
      public static function get numControllers() : uint
      {
         // method body index: 9 method index: 9
         return 1;
      }
      
      public static function get visibleRect() : Rectangle
      {
         // method body index: 10 method index: 10
         return new Rectangle(0,0,0,0);
      }
      
      public static function getEdgeAAMode(param1:DisplayObject) : uint
      {
         // method body index: 11 method index: 11
         return EDGEAA_INHERIT;
      }
      
      public static function setEdgeAAMode(param1:DisplayObject, param2:uint) : void
      {
         // method body index: 12 method index: 12
      }
      
      public static function setIMEEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 13 method index: 13
      }
      
      public static function get isScaleform() : Boolean
      {
         // method body index: 14 method index: 14
         return false;
      }
   }
}
