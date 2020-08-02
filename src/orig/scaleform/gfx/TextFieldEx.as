 
package scaleform.gfx
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   
   public final class TextFieldEx extends InteractiveObjectEx
   {
      
      public static const VALIGN_NONE:String = // method body index: 388 method index: 388
      "none";
      
      public static const VALIGN_TOP:String = // method body index: 388 method index: 388
      "top";
      
      public static const VALIGN_CENTER:String = // method body index: 388 method index: 388
      "center";
      
      public static const VALIGN_BOTTOM:String = // method body index: 388 method index: 388
      "bottom";
      
      public static const TEXTAUTOSZ_NONE:String = // method body index: 388 method index: 388
      "none";
      
      public static const TEXTAUTOSZ_SHRINK:String = // method body index: 388 method index: 388
      "shrink";
      
      public static const TEXTAUTOSZ_FIT:String = // method body index: 388 method index: 388
      "fit";
      
      public static const VAUTOSIZE_NONE:String = // method body index: 388 method index: 388
      "none";
      
      public static const VAUTOSIZE_TOP:String = // method body index: 388 method index: 388
      "top";
      
      public static const VAUTOSIZE_CENTER:String = // method body index: 388 method index: 388
      "center";
      
      public static const VAUTOSIZE_BOTTOM:String = // method body index: 388 method index: 388
      "bottom";
       
      
      public function TextFieldEx()
      {
         // method body index: 411 method index: 411
         super();
      }
      
      public static function appendHtml(textField:TextField, newHtml:String) : void
      {
         // method body index: 389 method index: 389
      }
      
      public static function setIMEEnabled(textField:TextField, isEnabled:Boolean) : void
      {
         // method body index: 390 method index: 390
      }
      
      public static function setVerticalAlign(textField:TextField, valign:String) : void
      {
         // method body index: 391 method index: 391
      }
      
      public static function getVerticalAlign(textField:TextField) : String
      {
         // method body index: 392 method index: 392
         return "none";
      }
      
      public static function setVerticalAutoSize(textField:TextField, vautoSize:String) : void
      {
         // method body index: 393 method index: 393
      }
      
      public static function getVerticalAutoSize(textField:TextField) : String
      {
         // method body index: 394 method index: 394
         return "none";
      }
      
      public static function setTextAutoSize(textField:TextField, autoSz:String) : void
      {
         // method body index: 395 method index: 395
      }
      
      public static function getTextAutoSize(textField:TextField) : String
      {
         // method body index: 396 method index: 396
         return "none";
      }
      
      public static function setImageSubstitutions(textField:TextField, substInfo:Object) : void
      {
         // method body index: 397 method index: 397
      }
      
      public static function updateImageSubstitution(textField:TextField, id:String, image:BitmapData) : void
      {
         // method body index: 398 method index: 398
      }
      
      public static function setNoTranslate(textField:TextField, noTranslate:Boolean) : void
      {
         // method body index: 399 method index: 399
      }
      
      public static function getNoTranslate(textField:TextField) : Boolean
      {
         // method body index: 400 method index: 400
         return false;
      }
      
      public static function setBidirectionalTextEnabled(textField:TextField, en:Boolean) : void
      {
         // method body index: 401 method index: 401
      }
      
      public static function getBidirectionalTextEnabled(textField:TextField) : Boolean
      {
         // method body index: 402 method index: 402
         return false;
      }
      
      public static function setSelectionTextColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 403 method index: 403
      }
      
      public static function getSelectionTextColor(textField:TextField) : uint
      {
         // method body index: 404 method index: 404
         return 4294967295;
      }
      
      public static function setSelectionBkgColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 405 method index: 405
      }
      
      public static function getSelectionBkgColor(textField:TextField) : uint
      {
         // method body index: 406 method index: 406
         return 4278190080;
      }
      
      public static function setInactiveSelectionTextColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 407 method index: 407
      }
      
      public static function getInactiveSelectionTextColor(textField:TextField) : uint
      {
         // method body index: 408 method index: 408
         return 4294967295;
      }
      
      public static function setInactiveSelectionBkgColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 409 method index: 409
      }
      
      public static function getInactiveSelectionBkgColor(textField:TextField) : uint
      {
         // method body index: 410 method index: 410
         return 4278190080;
      }
   }
}
