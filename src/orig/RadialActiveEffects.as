 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.IMenu;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class RadialActiveEffects extends IMenu
   {
      
      public static const ACTIVE_EFFECT_PADDING:int = // method body index: 1276 method index: 1276
      7;
      
      public static const ACTIVE_EFFECT_BUFFER:int = // method body index: 1276 method index: 1276
      12;
       
      
      public var Header_tf:TextField;
      
      public var EntryList_mc:MovieClip;
      
      public var BG_mc:MovieClip;
      
      private var bgHeight:Number = 0;
      
      public function RadialActiveEffects()
      {
         // method body index: 1277 method index: 1277
         super();
         BSUIDataManager.Subscribe("RadialMenuActiveEffectListData",this.onActiveEffectsUpdate);
      }
      
      private function onActiveEffectsUpdate(aEvent:FromClientDataEvent) : void
      {
         // method body index: 1278 method index: 1278
         var entries:Object = null;
         var i:int = 0;
         var entriesHeight:Number = NaN;
         var effectEntry:RadialActiveEffectEntry = null;
         this.EntryList_mc.removeChildren();
         if(aEvent.data != null)
         {
            entries = aEvent.data.activeEffectItems;
            for(i = 0; i < entries.length; i++)
            {
               if(entries[i].effectName != "")
               {
                  effectEntry = new RadialActiveEffectEntry();
                  effectEntry.UpdateEffectEntry(entries[i]);
                  effectEntry.y = this.EntryList_mc.numChildren * (effectEntry.height + ACTIVE_EFFECT_PADDING);
                  this.EntryList_mc.addChild(effectEntry);
               }
            }
            entriesHeight = 0;
            if(this.EntryList_mc.numChildren > 0)
            {
               entriesHeight = this.EntryList_mc.numChildren * (effectEntry.height + ACTIVE_EFFECT_PADDING) + ACTIVE_EFFECT_BUFFER * 2;
            }
            this.bgHeight = entriesHeight;
            this.BG_mc.height = this.bgHeight;
         }
      }
   }
}
