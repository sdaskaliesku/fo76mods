 
package scaleform.gfx
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public final class Extensions
   {
      
      public static const EDGEAA_INHERIT:uint = // method body index: 156 method index: 156
      0;
      
      public static const EDGEAA_ON:uint = // method body index: 156 method index: 156
      1;
      
      public static const EDGEAA_OFF:uint = // method body index: 156 method index: 156
      2;
      
      public static const EDGEAA_DISABLE:uint = // method body index: 156 method index: 156
      3;
      
      public static var isGFxPlayer:Boolean = // method body index: 156 method index: 156
      false;
      
      public static var CLIK_addedToStageCallback:Function;
      
      public static var gfxProcessSound:Function;
       
      
      public function Extensions()
      {
         // method body index: 171 method index: 171
         super();
      }
      
      public static function set enabled(param1:Boolean) : void
      {
         // method body index: 157 method index: 157
      }
      
      public static function get enabled() : Boolean
      {
         // method body index: 158 method index: 158
         return false;
      }
      
      public static function set noInvisibleAdvance(param1:Boolean) : void
      {
         // method body index: 159 method index: 159
      }
      
      public static function get noInvisibleAdvance() : Boolean
      {
         // method body index: 160 method index: 160
         return false;
      }
      
      public static function getTopMostEntity(param1:Number, param2:Number, param3:Boolean = true) : DisplayObject
      {
         // method body index: 161 method index: 161
         return null;
      }
      
      public static function getMouseTopMostEntity(param1:Boolean = true, param2:uint = 0) : DisplayObject
      {
         // method body index: 162 method index: 162
         return null;
      }
      
      public static function setMouseCursorType(param1:String, param2:uint = 0) : void
      {
         // method body index: 163 method index: 163
      }
      
      public static function getMouseCursorType(param1:uint = 0) : String
      {
         // method body index: 164 method index: 164
         return "";
      }
      
      public static function get numControllers() : uint
      {
         // method body index: 165 method index: 165
         return 1;
      }
      
      public static function get visibleRect() : Rectangle
      {
         // method body index: 166 method index: 166
         return new Rectangle(0,0,0,0);
      }
      
      public static function getEdgeAAMode(param1:DisplayObject) : uint
      {
         // method body index: 167 method index: 167
         return EDGEAA_INHERIT;
      }
      
      public static function setEdgeAAMode(param1:DisplayObject, param2:uint) : void
      {
         // method body index: 168 method index: 168
      }
      
      public static function setIMEEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 169 method index: 169
      }
      
      public static function get isScaleform() : Boolean
      {
         // method body index: 170 method index: 170
         return false;
      }
   }
}
