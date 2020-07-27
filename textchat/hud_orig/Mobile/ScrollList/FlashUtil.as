 
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
      
      private static const BITMAP_DATA_CLASS_NAME:String = // method body index: 327 method index: 327
      getQualifiedClassName(BitmapData);
       
      
      public function FlashUtil()
      {
         // method body index: 330 method index: 330
         super();
      }
      
      public static function getLibraryItem(mc:MovieClip, className:String) : DisplayObject
      {
         // method body index: 328 method index: 328
         var classRef:Class = getLibraryClass(mc,className);
         if(getQualifiedSuperclassName(classRef) == BITMAP_DATA_CLASS_NAME)
         {
            return new Bitmap(new classRef(),"auto",true);
         }
         return new classRef();
      }
      
      public static function getLibraryClass(mc:MovieClip, className:String) : Class
      {
         // method body index: 329 method index: 329
         var classRef:Class = mc.loaderInfo.applicationDomain.getDefinition(className) as Class;
         return classRef;
      }
   }
}
