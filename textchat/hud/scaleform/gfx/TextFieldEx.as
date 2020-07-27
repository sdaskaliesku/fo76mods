 
package scaleform.gfx
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   
   public final class TextFieldEx extends InteractiveObjectEx
   {
      
      public static const VALIGN_NONE:String = // method body index: 657 method index: 657
      "none";
      
      public static const VALIGN_TOP:String = // method body index: 657 method index: 657
      "top";
      
      public static const VALIGN_CENTER:String = // method body index: 657 method index: 657
      "center";
      
      public static const VALIGN_BOTTOM:String = // method body index: 657 method index: 657
      "bottom";
      
      public static const TEXTAUTOSZ_NONE:String = // method body index: 657 method index: 657
      "none";
      
      public static const TEXTAUTOSZ_SHRINK:String = // method body index: 657 method index: 657
      "shrink";
      
      public static const TEXTAUTOSZ_FIT:String = // method body index: 657 method index: 657
      "fit";
      
      public static const VAUTOSIZE_NONE:String = // method body index: 657 method index: 657
      "none";
      
      public static const VAUTOSIZE_TOP:String = // method body index: 657 method index: 657
      "top";
      
      public static const VAUTOSIZE_CENTER:String = // method body index: 657 method index: 657
      "center";
      
      public static const VAUTOSIZE_BOTTOM:String = // method body index: 657 method index: 657
      "bottom";
       
      
      public function TextFieldEx()
      {
         // method body index: 680 method index: 680
         super();
      }
      
      public static function appendHtml(param1:TextField, param2:String) : void
      {
         // method body index: 658 method index: 658
      }
      
      public static function setIMEEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 659 method index: 659
      }
      
      public static function setVerticalAlign(param1:TextField, param2:String) : void
      {
         // method body index: 660 method index: 660
      }
      
      public static function getVerticalAlign(param1:TextField) : String
      {
         // method body index: 661 method index: 661
         return "none";
      }
      
      public static function setVerticalAutoSize(param1:TextField, param2:String) : void
      {
         // method body index: 662 method index: 662
      }
      
      public static function getVerticalAutoSize(param1:TextField) : String
      {
         // method body index: 663 method index: 663
         return "none";
      }
      
      public static function setTextAutoSize(param1:TextField, param2:String) : void
      {
         // method body index: 664 method index: 664
      }
      
      public static function getTextAutoSize(param1:TextField) : String
      {
         // method body index: 665 method index: 665
         return "none";
      }
      
      public static function setImageSubstitutions(param1:TextField, param2:Object) : void
      {
         // method body index: 666 method index: 666
      }
      
      public static function updateImageSubstitution(param1:TextField, param2:String, param3:BitmapData) : void
      {
         // method body index: 667 method index: 667
      }
      
      public static function setNoTranslate(param1:TextField, param2:Boolean) : void
      {
         // method body index: 668 method index: 668
      }
      
      public static function getNoTranslate(param1:TextField) : Boolean
      {
         // method body index: 669 method index: 669
         return false;
      }
      
      public static function setBidirectionalTextEnabled(param1:TextField, param2:Boolean) : void
      {
         // method body index: 670 method index: 670
      }
      
      public static function getBidirectionalTextEnabled(param1:TextField) : Boolean
      {
         // method body index: 671 method index: 671
         return false;
      }
      
      public static function setSelectionTextColor(param1:TextField, param2:uint) : void
      {
         // method body index: 672 method index: 672
      }
      
      public static function getSelectionTextColor(param1:TextField) : uint
      {
         // method body index: 673 method index: 673
         return 4294967295;
      }
      
      public static function setSelectionBkgColor(param1:TextField, param2:uint) : void
      {
         // method body index: 674 method index: 674
      }
      
      public static function getSelectionBkgColor(param1:TextField) : uint
      {
         // method body index: 675 method index: 675
         return 4278190080;
      }
      
      public static function setInactiveSelectionTextColor(param1:TextField, param2:uint) : void
      {
         // method body index: 676 method index: 676
      }
      
      public static function getInactiveSelectionTextColor(param1:TextField) : uint
      {
         // method body index: 677 method index: 677
         return 4294967295;
      }
      
      public static function setInactiveSelectionBkgColor(param1:TextField, param2:uint) : void
      {
         // method body index: 678 method index: 678
      }
      
      public static function getInactiveSelectionBkgColor(param1:TextField) : uint
      {
         // method body index: 679 method index: 679
         return 4278190080;
      }
   }
}
