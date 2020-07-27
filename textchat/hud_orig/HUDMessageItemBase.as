 
package
{
   import flash.display.MovieClip;
   
   public class HUDMessageItemBase extends HUDFadingListItem
   {
       
      
      public var Internal_mc:MovieClip;
      
      protected var m_Data:HUDMessageItemData = null;
      
      public function HUDMessageItemBase()
      {
         // method body index: 3456 method index: 3456
         super();
      }
      
      public function get data() : HUDMessageItemData
      {
         // method body index: 3454 method index: 3454
         return this.m_Data;
      }
      
      public function set data(value:HUDMessageItemData) : void
      {
         // method body index: 3455 method index: 3455
         this.m_Data = value;
         SetIsDirty();
      }
   }
}
