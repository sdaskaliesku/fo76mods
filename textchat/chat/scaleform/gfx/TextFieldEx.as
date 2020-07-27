 
package scaleform.gfx
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   
   public final class TextFieldEx extends InteractiveObjectEx
   {
      
      public static const VALIGN_NONE:String = // method body index: 231 method index: 231
      "none";
      
      public static const VALIGN_TOP:String = // method body index: 231 method index: 231
      "top";
      
      public static const VALIGN_CENTER:String = // method body index: 231 method index: 231
      "center";
      
      public static const VALIGN_BOTTOM:String = // method body index: 231 method index: 231
      "bottom";
      
      public static const TEXTAUTOSZ_NONE:String = // method body index: 231 method index: 231
      "none";
      
      public static const TEXTAUTOSZ_SHRINK:String = // method body index: 231 method index: 231
      "shrink";
      
      public static const TEXTAUTOSZ_FIT:String = // method body index: 231 method index: 231
      "fit";
      
      public static const VAUTOSIZE_NONE:String = // method body index: 231 method index: 231
      "none";
      
      public static const VAUTOSIZE_TOP:String = // method body index: 231 method index: 231
      "top";
      
      public static const VAUTOSIZE_CENTER:String = // method body index: 231 method index: 231
      "center";
      
      public static const VAUTOSIZE_BOTTOM:String = // method body index: 231 method index: 231
      "bottom";
       
      
      public function TextFieldEx()
      {
         // method body index: 254 method index: 254
         super();
      }
      
      public static function appendHtml(param1:TextField, param2:String) : void
      {
         // method body index: 232 method index: 232
      }
      
      public static function setIMEEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 233 method index: 233
      }
      
      public static function setVerticalAlign(param1:TextField, param2:String) : void
      {
         // method body index: 234 method index: 234
      }
      
      public static function getVerticalAlign(param1:TextField) : String
      {
         // method body index: 235 method index: 235
         return "none";
      }
      
      public static function setVerticalAutoSize(param1:TextField, param2:String) : void
      {
         // method body index: 236 method index: 236
      }
      
      public static function getVerticalAutoSize(param1:TextField) : String
      {
         // method body index: 237 method index: 237
         return "none";
      }
      
      public static function setTextAutoSize(param1:TextField, param2:String) : void
      {
         // method body index: 238 method index: 238
      }
      
      public static function getTextAutoSize(param1:TextField) : String
      {
         // method body index: 239 method index: 239
         return "none";
      }
      
      public static function setImageSubstitutions(param1:TextField, param2:Object) : void
      {
         // method body index: 240 method index: 240
      }
      
      public static function updateImageSubstitution(param1:TextField, param2:String, param3:BitmapData) : void
      {
         // method body index: 241 method index: 241
      }
      
      public static function setNoTranslate(param1:TextField, param2:Boolean) : void
      {
         // method body index: 242 method index: 242
      }
      
      public static function getNoTranslate(param1:TextField) : Boolean
      {
         // method body index: 243 method index: 243
         return false;
      }
      
      public static function setBidirectionalTextEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 244 method index: 244
      }
      
      public static function getBidirectionalTextEnabled(param1:TextField) : Boolean
      {
         // method body index: 245 method index: 245
         return false;
      }
      
      public static function setSelectionTextColor(param1:TextField, param2:uint) : void
      {
         // method body index: 246 method index: 246
      }
      
      public static function getSelectionTextColor(param1:TextField) : uint
      {
         // method body index: 247 method index: 247
         return 4294967295;
      }
      
      public static function setSelectionBkgColor(param1:TextField, param2:uint) : void
      {
         // method body index: 248 method index: 248
      }
      
      public static function getSelectionBkgColor(param1:TextField) : uint
      {
         // method body index: 249 method index: 249
         return 4278190080;
      }
      
      public static function setInactiveSelectionTextColor(param1:TextField, param2:uint) : void
      {
         // method body index: 250 method index: 250
      }
      
      public static function getInactiveSelectionTextColor(param1:TextField) : uint
      {
         // method body index: 251 method index: 251
         return 4294967295;
      }
      
      public static function setInactiveSelectionBkgColor(param1:TextField, param2:uint) : void
      {
         // method body index: 252 method index: 252
      }
      
      public static function getInactiveSelectionBkgColor(param1:TextField) : uint
      {
         // method body index: 253 method index: 253
         return 4278190080;
      }
   }
}
