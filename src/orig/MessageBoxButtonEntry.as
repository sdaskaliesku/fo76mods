 
package
{
   import Shared.AS3.BSScrollingListEntry;
   
   public class MessageBoxButtonEntry extends BSScrollingListEntry
   {
      
      public static const ENTRY_BORDER_PAD:Number = // method body index: 1246 method index: 1246
      30;
       
      
      private var m_BaseFilters:Array;
      
      public function MessageBoxButtonEntry()
      {
         // method body index: 1247 method index: 1247
         super();
         this.m_BaseFilters = textField.filters;
      }
      
      public function CalculateBorderWidth() : Number
      {
         // method body index: 1248 method index: 1248
         return textField.getLineMetrics(0).width + ENTRY_BORDER_PAD;
      }
      
      public function SetBorderWidth(afNewWidth:Number) : *
      {
         // method body index: 1249 method index: 1249
         border.width = afNewWidth;
         border.x = afNewWidth * -0.5;
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {
         // method body index: 1250 method index: 1250
         super.SetEntryText(aEntryObject,astrTextOption);
         if(selected)
         {
            textField.filters = [];
         }
         else
         {
            textField.filters = this.m_BaseFilters;
         }
      }
   }
}
