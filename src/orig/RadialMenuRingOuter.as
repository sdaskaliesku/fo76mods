 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   
   public class RadialMenuRingOuter extends RadialMenuRing
   {
       
      
      public function RadialMenuRingOuter()
      {
         // method body index: 1195 method index: 1195
         super();
         addFrameScript(5,this.frame6,11,this.frame12);
         ENTRY_MAX = 16;
         CreateEntries();
         BSUIDataManager.Subscribe("RadialMenuExpandedListData",onListUpdate);
      }
      
      override public function open() : *
      {
         // method body index: 1196 method index: 1196
         super.open();
      }
      
      override public function close() : *
      {
         // method body index: 1197 method index: 1197
         super.close();
      }
      
      function frame6() : *
      {
         // method body index: 1198 method index: 1198
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1199 method index: 1199
         stop();
      }
   }
}
