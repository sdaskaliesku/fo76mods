 
package
{
   import Shared.AS3.BSScrollingList;
   
   public class MessageBoxButtonList extends BSScrollingList
   {
       
      
      private var m_GreatestWidth:Number = 0;
      
      public function MessageBoxButtonList()
      {
         // method body index: 1270 method index: 1270
         super();
      }
      
      public function get greatestWidth() : Number
      {
         // method body index: 1271 method index: 1271
         return this.m_GreatestWidth;
      }
      
      override public function InvalidateData() : *
      {
         // method body index: 1272 method index: 1272
         super.InvalidateData();
         this.SetEntryBorderWidths();
      }
      
      private function SetEntryBorderWidths() : *
      {
         // method body index: 1273 method index: 1273
         var currClip:MessageBoxButtonEntry = null;
         var fborderWidth:Number = NaN;
         var currClip2:MessageBoxButtonEntry = null;
         this.m_GreatestWidth = 0;
         for(var uiclip:uint = 0; uiclip < uiNumListItems; uiclip++)
         {
            currClip = GetClipByIndex(uiclip) as MessageBoxButtonEntry;
            if(currClip && currClip.textField)
            {
               fborderWidth = currClip.CalculateBorderWidth();
               if(fborderWidth > this.m_GreatestWidth)
               {
                  this.m_GreatestWidth = fborderWidth;
               }
            }
         }
         for(var uiclip2:uint = 0; uiclip2 < uiNumListItems; uiclip2++)
         {
            currClip2 = GetClipByIndex(uiclip2) as MessageBoxButtonEntry;
            if(currClip2)
            {
               currClip2.SetBorderWidth(this.m_GreatestWidth);
            }
         }
         border.x = this.greatestWidth * -0.5;
         border.width = this.greatestWidth;
         if(ScrollUp != null)
         {
            ScrollUp.x = this.greatestWidth * -0.5 - 50;
         }
         if(ScrollDown != null)
         {
            ScrollDown.x = ScrollUp.x;
         }
         if(Mask_mc != null)
         {
            Mask_mc.x = border.x;
            Mask_mc.width = border.width;
         }
      }
      
      override protected function updateScrollPosition(aiPosition:uint) : *
      {
         // method body index: 1274 method index: 1274
         super.updateScrollPosition(aiPosition);
         this.SetEntryBorderWidths();
      }
   }
}
