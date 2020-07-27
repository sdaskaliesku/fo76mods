 
package Mobile.ScrollList
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   
   public class FlashUtil
   {
      
      private static const BITMAP_DATA_CLASS_NAME:String = // method body index: 105 method index: 105
      getQualifiedClassName(BitmapData);
       
      
      public function FlashUtil()
      {
         // method body index: 108 method index: 108
         super();
      }
      
      public static function getLibraryItem(param1:MovieClip, param2:String) : DisplayObject
      {
         // method body index: 106 method index: 106
         var _loc3_:Class = getLibraryClass(param1,param2);
         if(getQualifiedSuperclassName(_loc3_) == BITMAP_DATA_CLASS_NAME)
         {
            return new Bitmap(new _loc3_(),"auto",true);
         }
         return new _loc3_();
      }
      
      public static function getLibraryClass(param1:MovieClip, param2:String) : Class
      {
         // method body index: 107 method index: 107
         var _loc3_:Class = param1.loaderInfo.applicationDomain.getDefinition(param2) as Class;
         return _loc3_;
      }
   }
}
