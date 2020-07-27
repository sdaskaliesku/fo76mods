 
package Shared.AS3
{
   public class BSScrollingListFadeEntry extends BSScrollingListEntry
   {
       
      
      const fUnselectedBorderAlpha:Number = 0.5;
      
      public function BSScrollingListFadeEntry()
      {
         // method body index: 2669 method index: 2669
         super();
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         // method body index: 2670 method index: 2670
         super.SetEntryText(param1,param2);
         var _loc3_:* = stage.focus == this.parent;
         if(!_loc3_ && this.parent != null)
         {
            _loc3_ = stage.focus == this.parent.parent;
         }
         if(!_loc3_ && this.selected)
         {
            border.alpha = this.fUnselectedBorderAlpha;
         }
      }
   }
}
