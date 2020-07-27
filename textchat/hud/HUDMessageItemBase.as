 
package
{
   import flash.display.MovieClip;
   
   public class HUDMessageItemBase extends HUDFadingListItem
   {
       
      
      public var Internal_mc:MovieClip;
      
      protected var m_Data:HUDMessageItemData = null;
      
      public function HUDMessageItemBase()
      {

         super();
      }
      
      public function get data() : HUDMessageItemData
      {

         return this.m_Data;
      }
      
      public function set data(param1:HUDMessageItemData) : void
      {

         this.m_Data = param1;
         SetIsDirty();
      }
   }
}
