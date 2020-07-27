 
package
{
   import flash.display.MovieClip;
   
   public class HUDMessageItemBase extends HUDFadingListItem
   {
       
      
      public var Internal_mc:MovieClip;
      
      protected var m_Data:HUDMessageItemData = null;
      
      public function HUDMessageItemBase()
      {
         // method body index: 3433 method index: 3433
         super();
      }
      
      public function get data() : HUDMessageItemData
      {
         // method body index: 3434 method index: 3434
         return this.m_Data;
      }
      
      public function set data(param1:HUDMessageItemData) : void
      {
         // method body index: 3435 method index: 3435
         this.m_Data = param1;
         SetIsDirty();
      }
   }
}
