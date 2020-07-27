 
package Shared.AS3
{
   public class BSScrollingListFadeEntry extends BSScrollingListEntry
   {
       
      
      const fUnselectedBorderAlpha:Number = 0.5;
      
      public function BSScrollingListFadeEntry()
      {
         // method body index: 2732 method index: 2732
         super();
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {
         // method body index: 2731 method index: 2731
         super.SetEntryText(aEntryObject,astrTextOption);
         var focus:* = stage.focus == this.parent;
         if(!focus && this.parent != null)
         {
            focus = stage.focus == this.parent.parent;
         }
         if(!focus && this.selected)
         {
            border.alpha = this.fUnselectedBorderAlpha;
         }
      }
   }
}
