 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import flash.display.MovieClip;
   
   public class RadialMenuRing extends MovieClip
   {
       
      
      public var RadialEntry0_mc:MovieClip;
      
      public var RadialEntry1_mc:MovieClip;
      
      public var RadialEntry2_mc:MovieClip;
      
      public var RadialEntry3_mc:MovieClip;
      
      public var RadialEntry4_mc:MovieClip;
      
      public var RadialEntry5_mc:MovieClip;
      
      public var RadialEntry6_mc:MovieClip;
      
      public var RadialEntry7_mc:MovieClip;
      
      public var RadialEntry8_mc:MovieClip;
      
      public var RadialEntry9_mc:MovieClip;
      
      public var RadialEntry10_mc:MovieClip;
      
      public var RadialEntry11_mc:MovieClip;
      
      public var RadialEntry12_mc:MovieClip;
      
      public var RadialEntry13_mc:MovieClip;
      
      public var RadialEntry14_mc:MovieClip;
      
      public var RadialEntry15_mc:MovieClip;
      
      protected var ENTRY_MAX = 12;
      
      private var m_SelectedIndex:int = -1;
      
      private var m_Entries:Vector.<RadialMenuEntry>;
      
      private var m_Data:Object;
      
      private var m_Keyboard:uint = 0;
      
      protected var m_SelectedEntry:RadialMenuEntry;
      
      protected var m_ShowKeyLabels:Boolean = false;
      
      public function RadialMenuRing()
      {
         // method body index: 856 method index: 856
         super();
         this.visible = false;
      }
      
      protected function setSelectedIndex(aSelectedIndex:int) : void
      {
         // method body index: 839 method index: 839
         this.m_SelectedIndex = aSelectedIndex;
         if(this.m_SelectedIndex >= 0)
         {
            this.m_SelectedEntry = this.m_Entries[aSelectedIndex];
         }
         else
         {
            this.m_SelectedEntry = null;
         }
         for(var i:int = 0; i < this.m_Entries.length; i++)
         {
            this.m_Entries[i].selected = i == this.m_SelectedIndex;
         }
      }
      
      public function set showKeyLabels(aShow:Boolean) : void
      {
         // method body index: 840 method index: 840
         var i:int = 0;
         if(aShow != this.m_ShowKeyLabels)
         {
            this.m_ShowKeyLabels = aShow;
            for(i = 0; i < this.m_Entries.length; i++)
            {
               this.m_Entries[i].showKeyLabel = this.m_ShowKeyLabels;
            }
         }
      }
      
      public function set keyboardType(aKeyboardType:uint) : void
      {
         // method body index: 841 method index: 841
         this.m_Keyboard = aKeyboardType;
         for(var i:int = 0; i < this.m_Entries.length; i++)
         {
            this.m_Entries[i].updateIndexAndHotkeys(i,this.m_Keyboard);
         }
      }
      
      public function get keyboardType() : uint
      {
         // method body index: 842 method index: 842
         return this.m_Keyboard;
      }
      
      public function set selectedIndex(aSelectedIndex:int) : void
      {
         // method body index: 843 method index: 843
         this.setSelectedIndex(aSelectedIndex);
      }
      
      public function get selectedIndex() : int
      {
         // method body index: 844 method index: 844
         return this.m_SelectedIndex;
      }
      
      public function get selectedEntry() : RadialMenuEntry
      {
         // method body index: 845 method index: 845
         return this.m_SelectedEntry;
      }
      
      public function open() : *
      {
         // method body index: 846 method index: 846
         this.visible = true;
      }
      
      public function close() : *
      {
         // method body index: 847 method index: 847
         this.visible = false;
      }
      
      public function updateRotation(newRotation:Number) : *
      {
         // method body index: 848 method index: 848
         var radialEntry:RadialMenuEntry = null;
         this.rotation = newRotation;
         for(var i:int = 0; i < this.ENTRY_MAX; i++)
         {
            radialEntry = this.getChildByName("RadialEntry" + i + "_mc") as RadialMenuEntry;
            if(radialEntry != null)
            {
               radialEntry.updateRotation();
            }
         }
      }
      
      private function onStateUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 849 method index: 849
         var newData:Object = arEvent.data;
         if(newData.selectedIndex != this.m_SelectedIndex)
         {
            this.selectedIndex = newData.selectedIndex;
         }
      }
      
      protected function onListUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 850 method index: 850
         var dataItem:Object = null;
         var radialEntry:RadialMenuEntry = null;
         var newData:Object = arEvent.data;
         for(var i:int = 0; i < newData.items.length; i++)
         {
            dataItem = newData.items[i];
            radialEntry = this.m_Entries[i];
            radialEntry.itemVisible = dataItem.visible;
            radialEntry.exists = dataItem.exists;
            radialEntry.icon = dataItem.icon;
            radialEntry.data = dataItem;
            radialEntry.level = dataItem.itemLevel;
            radialEntry.currentHealth = dataItem.currentHealth;
            radialEntry.maximumHealth = dataItem.maximumHealth;
            radialEntry.ammoAvailable = dataItem.ammoAvailable;
            radialEntry.ammoName = dataItem.ammoName;
         }
         this.m_Data = newData;
      }
      
      public function subscribeList(aListProvider:String) : *
      {
         // method body index: 851 method index: 851
         BSUIDataManager.Subscribe(aListProvider,this.onListUpdate);
      }
      
      public function subscribeState(aStateProvider:String) : *
      {
         // method body index: 852 method index: 852
         BSUIDataManager.Subscribe(aStateProvider,this.onStateUpdate);
      }
      
      protected function CreateEntries() : *
      {
         // method body index: 853 method index: 853
         var radialEntry:RadialMenuEntry = null;
         this.m_Entries = new Vector.<RadialMenuEntry>();
         for(var i:int = 0; i < this.ENTRY_MAX; i++)
         {
            radialEntry = this.getChildByName("RadialEntry" + i + "_mc") as RadialMenuEntry;
            if(radialEntry != null)
            {
               radialEntry.updateIndexAndHotkeys(i,this.m_Keyboard);
               this.m_Entries.push(radialEntry);
            }
         }
      }
      
      public function FadeDown() : *
      {
         // method body index: 854 method index: 854
         var radialEntry:RadialMenuEntry = null;
         if(this.currentFrame < 10)
         {
            this.gotoAndPlay("cold");
         }
         for(var i:int = 0; i < this.ENTRY_MAX; i++)
         {
            radialEntry = this.getChildByName("RadialEntry" + i + "_mc") as RadialMenuEntry;
            if(radialEntry != null)
            {
               radialEntry.Backer_mc.alpha = 0.3;
            }
         }
      }
      
      public function FadeUp() : *
      {
         // method body index: 855 method index: 855
         var radialEntry:RadialMenuEntry = null;
         if(this.currentFrame >= 10)
         {
            this.gotoAndPlay("hot");
         }
         for(var i:int = 0; i < this.ENTRY_MAX; i++)
         {
            radialEntry = this.getChildByName("RadialEntry" + i + "_mc") as RadialMenuEntry;
            if(radialEntry != null)
            {
               radialEntry.Backer_mc.alpha = 0.8;
            }
         }
      }
   }
}
