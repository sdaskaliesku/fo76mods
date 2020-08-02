 
package scaleform.gfx
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public final class Extensions
   {
      
      public static const EDGEAA_INHERIT:uint = // method body index: 55 method index: 55
      0;
      
      public static const EDGEAA_ON:uint = // method body index: 55 method index: 55
      1;
      
      public static const EDGEAA_OFF:uint = // method body index: 55 method index: 55
      2;
      
      public static const EDGEAA_DISABLE:uint = // method body index: 55 method index: 55
      3;
      
      public static var isGFxPlayer:Boolean = // method body index: 55 method index: 55
      false;
      
      public static var CLIK_addedToStageCallback:Function;
      
      public static var gfxProcessSound:Function;
       
      
      public function Extensions()
      {
         // method body index: 70 method index: 70
         super();
      }
      
      public static function set enabled(value:Boolean) : void
      {
         // method body index: 56 method index: 56
      }
      
      public static function get enabled() : Boolean
      {
         // method body index: 57 method index: 57
         return false;
      }
      
      public static function set noInvisibleAdvance(value:Boolean) : void
      {
         // method body index: 58 method index: 58
      }
      
      public static function get noInvisibleAdvance() : Boolean
      {
         // method body index: 59 method index: 59
         return false;
      }
      
      public static function getTopMostEntity(x:Number, y:Number, testAll:Boolean = true) : DisplayObject
      {
         // method body index: 60 method index: 60
         return null;
      }
      
      public static function getMouseTopMostEntity(testAll:Boolean = true, mouseIndex:uint = 0) : DisplayObject
      {
         // method body index: 61 method index: 61
         return null;
      }
      
      public static function setMouseCursorType(cursor:String, mouseIndex:uint = 0) : void
      {
         // method body index: 62 method index: 62
      }
      
      public static function getMouseCursorType(mouseIndex:uint = 0) : String
      {
         // method body index: 63 method index: 63
         return "";
      }
      
      public static function get numControllers() : uint
      {
         // method body index: 64 method index: 64
         return 1;
      }
      
      public static function get visibleRect() : Rectangle
      {
         // method body index: 65 method index: 65
         return new Rectangle(0,0,0,0);
      }
      
      public static function getEdgeAAMode(dispObj:DisplayObject) : uint
      {
         // method body index: 66 method index: 66
         return EDGEAA_INHERIT;
      }
      
      public static function setEdgeAAMode(dispObj:DisplayObject, mode:uint) : void
      {
         // method body index: 67 method index: 67
      }
      
      public static function setIMEEnabled(textField:TextField, isEnabled:Boolean) : void
      {
         // method body index: 68 method index: 68
      }
      
      public static function get isScaleform() : Boolean
      {
         // method body index: 69 method index: 69
         return false;
      }
   }
}
