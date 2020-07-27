 
package scaleform.gfx
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   
   public final class TextFieldEx extends InteractiveObjectEx
   {
      
      public static const VALIGN_NONE:String = // method body index: 731 method index: 731
      "none";
      
      public static const VALIGN_TOP:String = // method body index: 731 method index: 731
      "top";
      
      public static const VALIGN_CENTER:String = // method body index: 731 method index: 731
      "center";
      
      public static const VALIGN_BOTTOM:String = // method body index: 731 method index: 731
      "bottom";
      
      public static const TEXTAUTOSZ_NONE:String = // method body index: 731 method index: 731
      "none";
      
      public static const TEXTAUTOSZ_SHRINK:String = // method body index: 731 method index: 731
      "shrink";
      
      public static const TEXTAUTOSZ_FIT:String = // method body index: 731 method index: 731
      "fit";
      
      public static const VAUTOSIZE_NONE:String = // method body index: 731 method index: 731
      "none";
      
      public static const VAUTOSIZE_TOP:String = // method body index: 731 method index: 731
      "top";
      
      public static const VAUTOSIZE_CENTER:String = // method body index: 731 method index: 731
      "center";
      
      public static const VAUTOSIZE_BOTTOM:String = // method body index: 731 method index: 731
      "bottom";
       
      
      public function TextFieldEx()
      {
         // method body index: 754 method index: 754
         super();
      }
      
      public static function appendHtml(textField:TextField, newHtml:String) : void
      {
         // method body index: 732 method index: 732
      }
      
      public static function setIMEEnabled(textField:TextField, isEnabled:Boolean) : void
      {
         // method body index: 733 method index: 733
      }
      
      public static function setVerticalAlign(textField:TextField, valign:String) : void
      {
         // method body index: 734 method index: 734
      }
      
      public static function getVerticalAlign(textField:TextField) : String
      {
         // method body index: 735 method index: 735
         return "none";
      }
      
      public static function setVerticalAutoSize(textField:TextField, vautoSize:String) : void
      {
         // method body index: 736 method index: 736
      }
      
      public static function getVerticalAutoSize(textField:TextField) : String
      {
         // method body index: 737 method index: 737
         return "none";
      }
      
      public static function setTextAutoSize(textField:TextField, autoSz:String) : void
      {
         // method body index: 738 method index: 738
      }
      
      public static function getTextAutoSize(textField:TextField) : String
      {
         // method body index: 739 method index: 739
         return "none";
      }
      
      public static function setImageSubstitutions(textField:TextField, substInfo:Object) : void
      {
         // method body index: 740 method index: 740
      }
      
      public static function updateImageSubstitution(textField:TextField, id:String, image:BitmapData) : void
      {
         // method body index: 741 method index: 741
      }
      
      public static function setNoTranslate(textField:TextField, noTranslate:Boolean) : void
      {
         // method body index: 742 method index: 742
      }
      
      public static function getNoTranslate(textField:TextField) : Boolean
      {
         // method body index: 743 method index: 743
         return false;
      }
      
      public static function setBidirectionalTextEnabled(textField:TextField, en:Boolean) : void
      {
         // method body index: 744 method index: 744
      }
      
      public static function getBidirectionalTextEnabled(textField:TextField) : Boolean
      {
         // method body index: 745 method index: 745
         return false;
      }
      
      public static function setSelectionTextColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 746 method index: 746
      }
      
      public static function getSelectionTextColor(textField:TextField) : uint
      {
         // method body index: 747 method index: 747
         return 4294967295;
      }
      
      public static function setSelectionBkgColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 748 method index: 748
      }
      
      public static function getSelectionBkgColor(textField:TextField) : uint
      {
         // method body index: 749 method index: 749
         return 4278190080;
      }
      
      public static function setInactiveSelectionTextColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 750 method index: 750
      }
      
      public static function getInactiveSelectionTextColor(textField:TextField) : uint
      {
         // method body index: 751 method index: 751
         return 4294967295;
      }
      
      public static function setInactiveSelectionBkgColor(textField:TextField, selColor:uint) : void
      {
         // method body index: 752 method index: 752
      }
      
      public static function getInactiveSelectionBkgColor(textField:TextField) : uint
      {
         // method body index: 753 method index: 753
         return 4278190080;
      }
   }
}
