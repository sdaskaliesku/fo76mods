 
package scaleform.gfx
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   
   public final class TextFieldEx extends InteractiveObjectEx
   {
      
      public static const VALIGN_NONE:String = // method body index: 310 method index: 310
      "none";
      
      public static const VALIGN_TOP:String = // method body index: 310 method index: 310
      "top";
      
      public static const VALIGN_CENTER:String = // method body index: 310 method index: 310
      "center";
      
      public static const VALIGN_BOTTOM:String = // method body index: 310 method index: 310
      "bottom";
      
      public static const TEXTAUTOSZ_NONE:String = // method body index: 310 method index: 310
      "none";
      
      public static const TEXTAUTOSZ_SHRINK:String = // method body index: 310 method index: 310
      "shrink";
      
      public static const TEXTAUTOSZ_FIT:String = // method body index: 310 method index: 310
      "fit";
      
      public static const VAUTOSIZE_NONE:String = // method body index: 310 method index: 310
      "none";
      
      public static const VAUTOSIZE_TOP:String = // method body index: 310 method index: 310
      "top";
      
      public static const VAUTOSIZE_CENTER:String = // method body index: 310 method index: 310
      "center";
      
      public static const VAUTOSIZE_BOTTOM:String = // method body index: 310 method index: 310
      "bottom";
       
      
      public function TextFieldEx()
      {
         // method body index: 333 method index: 333
         super();
      }
      
      public static function appendHtml(param1:TextField, param2:String) : void
      {
         // method body index: 311 method index: 311
      }
      
      public static function setIMEEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 312 method index: 312
      }
      
      public static function setVerticalAlign(param1:TextField, param2:String) : void
      {
         // method body index: 313 method index: 313
      }
      
      public static function getVerticalAlign(param1:TextField) : String
      {
         // method body index: 314 method index: 314
         return "none";
      }
      
      public static function setVerticalAutoSize(param1:TextField, param2:String) : void
      {
         // method body index: 315 method index: 315
      }
      
      public static function getVerticalAutoSize(param1:TextField) : String
      {
         // method body index: 316 method index: 316
         return "none";
      }
      
      public static function setTextAutoSize(param1:TextField, param2:String) : void
      {
         // method body index: 317 method index: 317
      }
      
      public static function getTextAutoSize(param1:TextField) : String
      {
         // method body index: 318 method index: 318
         return "none";
      }
      
      public static function setImageSubstitutions(param1:TextField, param2:Object) : void
      {
         // method body index: 319 method index: 319
      }
      
      public static function updateImageSubstitution(param1:TextField, param2:String, param3:BitmapData) : void
      {
         // method body index: 320 method index: 320
      }
      
      public static function setNoTranslate(param1:TextField, param2:Boolean) : void
      {
         // method body index: 321 method index: 321
      }
      
      public static function getNoTranslate(param1:TextField) : Boolean
      {
         // method body index: 322 method index: 322
         return false;
      }
      
      public static function setBidirectionalTextEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 323 method index: 323
      }
      
      public static function getBidirectionalTextEnabled(param1:TextField) : Boolean
      {
         // method body index: 324 method index: 324
         return false;
      }
      
      public static function setSelectionTextColor(param1:TextField, param2:uint) : void
      {
         // method body index: 325 method index: 325
      }
      
      public static function getSelectionTextColor(param1:TextField) : uint
      {
         // method body index: 326 method index: 326
         return 4294967295;
      }
      
      public static function setSelectionBkgColor(param1:TextField, param2:uint) : void
      {
         // method body index: 327 method index: 327
      }
      
      public static function getSelectionBkgColor(param1:TextField) : uint
      {
         // method body index: 328 method index: 328
         return 4278190080;
      }
      
      public static function setInactiveSelectionTextColor(param1:TextField, param2:uint) : void
      {
         // method body index: 329 method index: 329
      }
      
      public static function getInactiveSelectionTextColor(param1:TextField) : uint
      {
         // method body index: 330 method index: 330
         return 4294967295;
      }
      
      public static function setInactiveSelectionBkgColor(param1:TextField, param2:uint) : void
      {
         // method body index: 331 method index: 331
      }
      
      public static function getInactiveSelectionBkgColor(param1:TextField) : uint
      {
         // method body index: 332 method index: 332
         return 4278190080;
      }
   }
}
