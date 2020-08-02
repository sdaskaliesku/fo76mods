 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   
   public class RadialMenuRingInner extends RadialMenuRing
   {
       
      
      private var m_Expanded:Boolean = false;
      
      public function RadialMenuRingInner()
      {
         // method body index: 1190 method index: 1190
         super();
         addFrameScript(5,this.frame6,11,this.frame12);
         CreateEntries();
         BSUIDataManager.Subscribe("RadialMenuListData",onListUpdate);
      }
      
      public function get expanded() : Boolean
      {
         // method body index: 1187 method index: 1187
         return this.m_Expanded;
      }
      
      public function set expanded(aExpanded:Boolean) : *
      {
         // method body index: 1188 method index: 1188
         this.m_Expanded = aExpanded;
         if(m_SelectedEntry != null)
         {
            (m_SelectedEntry as RadialMenuEntryInner).expanded = this.m_Expanded;
         }
      }
      
      override protected function setSelectedIndex(aSelectedIndex:int) : void
      {
         // method body index: 1189 method index: 1189
         super.setSelectedIndex(aSelectedIndex);
         if(m_SelectedEntry != null)
         {
            (m_SelectedEntry as RadialMenuEntryInner).expanded = this.m_Expanded;
         }
      }
      
      function frame6() : *
      {
         // method body index: 1191 method index: 1191
         stop();
      }
      
      function frame12() : *
      {
         // method body index: 1192 method index: 1192
         stop();
      }
   }
}
