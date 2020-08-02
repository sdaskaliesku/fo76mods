 
package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.AS3.IMenu;
   import Shared.AS3.SWFLoaderClip;
   import Shared.AS3.StyleSheet;
   import Shared.AS3.Styles.Radial_RadialInventoryListStyle;
   import Shared.GlobalFunc;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.utils.Timer;
   
   public class RadialMenu extends IMenu
   {
      
      public static const EVENT_SLOT_ITEM:String = // method body index: 1280 method index: 1280
      "Radial::SlotItem";
      
      public static const EVENT_USE_QUICK_CAMP:String = // method body index: 1280 method index: 1280
      "Radial::PlaceQuickCamp";
      
      public static var DPAD_STATE_NONE:int = // method body index: 1280 method index: 1280
      -1;
      
      public static var DPAD_STATE_UP:int = // method body index: 1280 method index: 1280
      0;
      
      public static var DPAD_STATE_DOWN:int = // method body index: 1280 method index: 1280
      1;
      
      public static var DPAD_STATE_LEFT:int = // method body index: 1280 method index: 1280
      2;
      
      public static var DPAD_STATE_RIGHT:int = // method body index: 1280 method index: 1280
      3;
      
      private static var TEST_MODE:Boolean = // method body index: 1280 method index: 1280
      false;
       
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var Empty_mc:MovieClip;
      
      public var CenterInfo_mc:MovieClip;
      
      public var Background_mc:MovieClip;
      
      public var BackgroundTier2_mc:MovieClip;
      
      public var radialTab:MovieClip;
      
      public var ActiveEffects_mc:RadialActiveEffects;
      
      public var PlayerInventory_mc:SecureTradePlayerInventory;
      
      private var m_SelectedList:SecureTradeInventory;
      
      private var m_TabMax = 0;
      
      private var m_TabMin = 0;
      
      private var m_SelectedTab:int = 1;
      
      private const REPEAT_INTERVAL:Number = 200;
      
      private var m_PlayerInventoryEmpty:Boolean = false;
      
      protected var ButtonHintMouseScrollNavigate:BSButtonHintData;
      
      protected var ButtonHintNavigate:BSButtonHintData;
      
      protected var ButtonHintSay:BSButtonHintData;
      
      protected var ButtonHintDrop:BSButtonHintData;
      
      protected var ButtonHintExpand:BSButtonHintData;
      
      protected var ButtonHintSurvivalTent:BSButtonHintData;
      
      protected var ButtonHintSlotItem:BSButtonHintData;
      
      protected var ButtonHintInspectItem:BSButtonHintData;
      
      public var SelectedImage_mc:SWFLoaderClip;
      
      public var SelectedImageInstance:MovieClip;
      
      public var OuterRing:RadialMenuRingOuter;
      
      public var InnerRing:RadialMenuRingInner;
      
      public var DpadMap_mc:MovieClip;
      
      public var DpadLine_mc:MovieClip;
      
      public var selectedMenuIndex:int = -1;
      
      private var showDpad:Boolean = true;
      
      private var m_testEnabled:Boolean = false;
      
      private var showInventory:Boolean = false;
      
      private var _ConditionMeterEnabled:Boolean = true;
      
      private var m_HasZeus:Boolean = false;
      
      private var m_CanPlaceQuickCamp:Boolean = false;
      
      private var m_QuickCampPlaceCost:uint = 0;
      
      private var m_ItemLevelColor;
      
      private var m_ThumbstickSpamTimer:Timer;
      
      private var m_ThumbstickSpamDisable:Boolean = false;
      
      private var m_LastCenterInfo = null;
      
      private var testStateData:Object;
      
      public function RadialMenu()
      {
         // method body index: 1293 method index: 1293
         this.m_SelectedList = this.PlayerInventory_mc;
         this.ButtonHintMouseScrollNavigate = new BSButtonHintData("$SCROLL","Mousewheel","","",1,null);
         this.ButtonHintNavigate = new BSButtonHintData("$SELECT","Space","PSN_RS","Xenon_RS",1,null);
         this.ButtonHintSay = new BSButtonHintData("$SAY","Space","PSN_A","Xenon_A",1,null);
         this.ButtonHintDrop = new BSButtonHintData("$DROP","R","PSN_X","Xenon_X",1,null);
         this.ButtonHintExpand = new BSButtonHintData("$EXPAND","Q","PSN_R1","Xenon_R1",1,null);
         this.ButtonHintSurvivalTent = new BSButtonHintData("$SURVIVALTENTZEUS","T","PSN_Y","Xenon_Y",1,this.onPlaceQuickCamp);
         this.ButtonHintSlotItem = new BSButtonHintData("$CHANGE","C","PSN_R1","Xenon_R1",1,this.onSlotItem);
         this.ButtonHintInspectItem = new BSButtonHintData("$INSPECT","X","PSN_R3","Xenon_R3",1,null);
         this.m_ItemLevelColor = new ColorTransform();
         this.m_ThumbstickSpamTimer = new Timer(125,-1);
         this.testStateData = {
            "innerSelectedIndex":-1,
            "outerSelectedIndex":-1,
            "innerExpanded":false,
            "menuIndex":-1
         };
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
         StyleSheet.apply(this.PlayerInventory_mc.ItemList_mc,false,Radial_RadialInventoryListStyle);
         this.SelectedImage_mc = this.CenterInfo_mc.IconContainer_mc.Body;
         this.CenterInfo_mc.emoteTitleText_tf.text = "";
         this.CenterInfo_mc.radialCategoryText_tf.text = "";
         this.CenterInfo_mc.ammoInfo_mc.ammoInfo_tf.text = "";
         this.CenterInfo_mc.visible = false;
         this.DpadMap_mc.visible = false;
         this.DpadLine_mc.visible = false;
         this.SelectedImage_mc.clipScale = 1.7;
         this.SelectedImage_mc.clipAlpha = 1;
         this.SelectedImage_mc.centerClip = true;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         if(TEST_MODE)
         {
            this.registerTestFunctionality();
         }
         this.populateButtonBar();
         addEventListener(FocusEvent.FOCUS_OUT,this.onFocusChange);
         addEventListener(BSScrollingList.ITEM_PRESS,this.onItemPress);
         addEventListener(BSScrollingList.SELECTION_CHANGE,this.onSelectionChange);
         addEventListener(SecureTradeInventory.MOUSE_OVER,this.onListMouseOver);
         addEventListener(RadialMenuEntry.MOUSE_OVER,this.onRadialMenuEntryMouseOver);
         this.ButtonHintNavigate.ButtonVisible = true;
         this.ButtonHintMouseScrollNavigate.ButtonVisible = false;
         this.ButtonHintSay.ButtonVisible = false;
         this.ButtonHintSlotItem.ButtonVisible = false;
         this.ButtonHintExpand.ButtonVisible = false;
         this.ButtonHintExpand.ButtonDisabled = true;
         this.ButtonHintSurvivalTent.ButtonEnabled = false;
         this.ButtonHintSurvivalTent.ButtonVisible = false;
         addEventListener(PlatformChangeEvent.PLATFORM_CHANGE,this.onPlatformChange);
      }
      
      public static function clearAllExcept(array:Array, propertyName:String, value:int, value2:int) : Array
      {
         // method body index: 1281 method index: 1281
         var item:Object = null;
         var newArray:Array = [];
         for(var index:int = 0; index < array.length; index++)
         {
            item = array[index];
            if(item && item.hasOwnProperty(propertyName))
            {
               if(item[propertyName] == value || item[propertyName] == value2)
               {
                  newArray.push(item);
               }
            }
         }
         return newArray;
      }
      
      private function populateButtonBar() : void
      {
         // method body index: 1282 method index: 1282
         var buttonHintDataV:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         buttonHintDataV.push(this.ButtonHintSurvivalTent);
         buttonHintDataV.push(this.ButtonHintMouseScrollNavigate);
         buttonHintDataV.push(this.ButtonHintNavigate);
         buttonHintDataV.push(this.ButtonHintSay);
         buttonHintDataV.push(this.ButtonHintDrop);
         buttonHintDataV.push(this.ButtonHintSlotItem);
         buttonHintDataV.push(this.ButtonHintInspectItem);
         buttonHintDataV.push(this.ButtonHintExpand);
         this.ButtonHintBar_mc.SetButtonHintData(buttonHintDataV);
      }
      
      override public function SetPlatform(auiPlatform:uint, abPS3Switch:Boolean, auiController:uint, auiKeyboard:uint) : *
      {
         // method body index: 1283 method index: 1283
         super.SetPlatform(auiPlatform,abPS3Switch,auiController,auiKeyboard);
         this.updateButtonBar();
         this.InnerRing.keyboardType = uiKeyboard;
         this.OuterRing.keyboardType = uiKeyboard;
      }
      
      override public function SetNuclearWinterMode(abNuclearWinterMode:Boolean) : *
      {
         // method body index: 1284 method index: 1284
         super.SetNuclearWinterMode(abNuclearWinterMode);
         this.ActiveEffects_mc.visible = bNuclearWinterMode;
         this.updateButtonBar();
      }
      
      private function updateButtonBar() : void
      {
         // method body index: 1285 method index: 1285
         var enableButton:Boolean = false;
         this.ButtonHintSurvivalTent.ButtonVisible = this.selectedMenuIndex == DPAD_STATE_UP && !this.showInventory && !bNuclearWinterMode;
         this.ButtonHintSurvivalTent.ButtonEnabled = this.m_CanPlaceQuickCamp;
         if(this.m_QuickCampPlaceCost > 0)
         {
            this.ButtonHintSurvivalTent.ButtonText = GlobalFunc.LocalizeFormattedString("$SURVIVALTENTZEUSCOST",this.m_QuickCampPlaceCost);
         }
         else
         {
            this.ButtonHintSurvivalTent.ButtonText = "$SURVIVALTENTZEUS";
         }
         if(this.selectedMenuIndex == DPAD_STATE_DOWN)
         {
            enableButton = !!this.InnerRing.selectedEntry?Boolean(this.InnerRing.selectedEntry.data.expandable):false;
            this.ButtonHintSay.ButtonText = "$SAY";
            this.ButtonHintDrop.ButtonVisible = false;
            this.ButtonHintExpand.ButtonVisible = true;
            this.ButtonHintExpand.ButtonEnabled = enableButton;
            this.ButtonHintSlotItem.ButtonVisible = false;
            this.ButtonHintInspectItem.ButtonVisible = false;
            if(this.OuterRing.selectedIndex > -1)
            {
               this.ButtonHintExpand.ButtonText = "$COLLAPSE";
            }
            else
            {
               this.ButtonHintExpand.ButtonText = "$EXPAND";
            }
         }
         else if(this.selectedMenuIndex == DPAD_STATE_UP)
         {
            this.ButtonHintSay.ButtonText = "$RADIAL_MENU_USE";
            this.ButtonHintDrop.ButtonVisible = bNuclearWinterMode;
            this.ButtonHintExpand.ButtonVisible = false;
            this.ButtonHintSlotItem.ButtonVisible = !this.showInventory;
            this.ButtonHintInspectItem.ButtonVisible = !this.showInventory;
            if(this.InnerRing.selectedEntry && this.InnerRing.selectedEntry.data.isRepairable)
            {
               this.ButtonHintInspectItem.ButtonText = "$INSPECT/REPAIR";
            }
            else
            {
               this.ButtonHintInspectItem.ButtonText = "$INSPECT";
            }
         }
         this.ButtonHintMouseScrollNavigate.ButtonVisible = uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && !this.showInventory;
      }
      
      public function updateDpad(aMenuIndex:int) : *
      {
         // method body index: 1286 method index: 1286
         var dpadFrame:String = null;
         switch(aMenuIndex)
         {
            case DPAD_STATE_LEFT:
               dpadFrame = "left";
               break;
            case DPAD_STATE_RIGHT:
               dpadFrame = "right";
               break;
            case DPAD_STATE_UP:
               dpadFrame = "up";
               this.radialTab.tabText_tf.text = "$FAVORITES";
               break;
            case DPAD_STATE_DOWN:
               dpadFrame = "down";
               this.radialTab.tabText_tf.text = "$EMOTES";
         }
         this.DpadMap_mc.gotoAndStop(dpadFrame);
      }
      
      public function onMenuSelect(aMenuIndex:int) : void
      {
         // method body index: 1287 method index: 1287
         if(aMenuIndex > DPAD_STATE_NONE)
         {
            if(this.showDpad)
            {
               this.DpadMap_mc.visible = true;
               this.updateDpad(aMenuIndex);
            }
            else
            {
               this.DpadMap_mc.visible = false;
            }
            this.DpadLine_mc.visible = true;
            this.Background_mc.gotoAndPlay("rollOn");
            this.InnerRing.open();
         }
         else
         {
            this.DpadMap_mc.visible = false;
            this.DpadLine_mc.visible = false;
            this.Background_mc.gotoAndPlay("rollOff");
            this.InnerRing.close();
         }
         this.selectedMenuIndex = aMenuIndex;
      }
      
      private function populateCenterInfo(aItemData:Object) : void
      {
         // method body index: 1288 method index: 1288
         this.m_LastCenterInfo = aItemData;
         if(this.SelectedImageInstance != null)
         {
            this.SelectedImage_mc.removeChild(this.SelectedImageInstance);
            this.SelectedImageInstance = null;
         }
         if(aItemData != null)
         {
            this.CenterInfo_mc.gotoAndPlay("rollOn");
            switch(this.selectedMenuIndex)
            {
               case DPAD_STATE_UP:
                  if(aItemData.count != null && aItemData.count > 1)
                  {
                     this.CenterInfo_mc.emoteTitleText_tf.text = aItemData.name + " (" + aItemData.count + ")";
                  }
                  else
                  {
                     this.CenterInfo_mc.emoteTitleText_tf.text = aItemData.name;
                  }
                  break;
               case DPAD_STATE_DOWN:
                  this.CenterInfo_mc.emoteTitleText_tf.text = aItemData.description;
            }
            if(aItemData.ammoName != null && aItemData.ammoName != "")
            {
               this.CenterInfo_mc.ammoInfo_mc.ammoInfo_tf.text = aItemData.ammoName + " (" + aItemData.ammoAvailable + ")";
            }
            else
            {
               this.CenterInfo_mc.ammoInfo_mc.ammoInfo_tf.text = "";
            }
            this.CenterInfo_mc.ConditionBar_mc.visible = aItemData.maximumHealth > 0 && this._ConditionMeterEnabled && !bNuclearWinterMode;
            GlobalFunc.updateConditionMeter(this.CenterInfo_mc.ConditionBar_mc.Bar_mc,aItemData.currentHealth,aItemData.maximumHealth,aItemData.durability);
            this.SelectedImageInstance = this.SelectedImage_mc.setContainerIconClip(aItemData.icon,"","radialIconEmpty");
            this.CenterInfo_mc.IconContainer_mc.transform.colorTransform = null;
            this.CenterInfo_mc.emoteTitleText_tf.textColor = GlobalFunc.COLOR_TEXT_HEADER;
            this.CenterInfo_mc.RarityColor_mc.visible = aItemData.rarity > -1;
            if(aItemData.rarity > -1)
            {
               if(aItemData.rarity == 0)
               {
                  this.m_ItemLevelColor.color = GlobalFunc.COLOR_RARITY_COMMON;
               }
               else if(aItemData.rarity == 1)
               {
                  this.m_ItemLevelColor.color = GlobalFunc.COLOR_RARITY_RARE;
               }
               else if(aItemData.rarity == 2)
               {
                  this.m_ItemLevelColor.color = GlobalFunc.COLOR_RARITY_EPIC;
               }
               else if(aItemData.rarity == 3)
               {
                  this.m_ItemLevelColor.color = GlobalFunc.COLOR_RARITY_LEGENDARY;
               }
               this.CenterInfo_mc.RarityColor_mc.transform.colorTransform = this.m_ItemLevelColor;
            }
         }
         else
         {
            this.CenterInfo_mc.gotoAndPlay("rollOff");
            this.CenterInfo_mc.ammoInfo_mc.ammoInfo_tf.text = "";
            this.CenterInfo_mc.emoteTitleText_tf.text = "";
            this.CenterInfo_mc.radialCategoryText_tf.text = "";
            this.CenterInfo_mc.ConditionBar_mc.visible = false;
            this.SelectedImageInstance = this.SelectedImage_mc.setContainerIconClip(null,"","radialIconEmpty");
         }
      }
      
      private function processStateUpdate(aNewData:Object) : *
      {
         // method body index: 1289 method index: 1289
         var newCenterInfo:* = undefined;
         var selectionChange:Boolean = false;
         var showCenterInfo:Boolean = false;
         var changedMenu:Boolean = false;
         this.m_CanPlaceQuickCamp = aNewData.canPlaceQuickCamp;
         this.m_QuickCampPlaceCost = aNewData.quickCampMoveCost;
         this.CenterInfo_mc.ConditionBar_mc.visible = false;
         if(aNewData.menuIndex != this.selectedMenuIndex)
         {
            this.InnerRing.expanded = false;
            this.onMenuSelect(aNewData.menuIndex);
            changedMenu = true;
         }
         if(aNewData.menuIndex > DPAD_STATE_NONE)
         {
            showCenterInfo = true;
         }
         if(this.InnerRing.selectedIndex != aNewData.innerSelectedIndex)
         {
            this.InnerRing.selectedIndex = aNewData.innerSelectedIndex;
            selectionChange = true;
         }
         if(aNewData.innerExpanded != this.InnerRing.expanded)
         {
            this.InnerRing.expanded = aNewData.innerExpanded;
            if(aNewData.innerExpanded)
            {
               this.OuterRing.open();
            }
            else
            {
               this.OuterRing.close();
            }
            if(this.showDpad && this.BackgroundTier2_mc != null)
            {
               if(aNewData.innerExpanded)
               {
                  this.BackgroundTier2_mc.gotoAndPlay("secondTierRollOn");
                  this.DpadLine_mc.gotoAndPlay("expand");
               }
               else
               {
                  this.BackgroundTier2_mc.gotoAndPlay("rollOff");
                  this.DpadLine_mc.gotoAndPlay("collapse");
               }
            }
            selectionChange = true;
         }
         if(this.OuterRing.selectedIndex != aNewData.outerSelectedIndex)
         {
            this.OuterRing.selectedIndex = aNewData.outerSelectedIndex;
            this.OuterRing.updateRotation(30 * (this.InnerRing.selectedIndex + 1));
            selectionChange = true;
         }
         selectionChange = true;
         if(selectionChange)
         {
            if(!aNewData.innerExpanded && (this.InnerRing.selectedEntry == null || !this.InnerRing.selectedEntry.exists))
            {
               showCenterInfo = false;
            }
            newCenterInfo = null;
            if(aNewData.innerExpanded && aNewData.outerSelectedIndex > -1 && this.OuterRing.selectedEntry != null)
            {
               newCenterInfo = this.OuterRing.selectedEntry.data;
            }
            else if(aNewData.innerSelectedIndex > -1 && this.InnerRing.selectedEntry != null)
            {
               newCenterInfo = this.InnerRing.selectedEntry.data;
            }
            if(newCenterInfo != this.m_LastCenterInfo && (newCenterInfo == null || newCenterInfo.visible))
            {
               this.populateCenterInfo(newCenterInfo);
            }
         }
         if(this.OuterRing.selectedIndex > -1)
         {
            this.InnerRing.FadeDown();
            this.OuterRing.FadeUp();
         }
         else
         {
            this.InnerRing.FadeUp();
            this.OuterRing.FadeDown();
         }
         this.CenterInfo_mc.visible = showCenterInfo;
         this.updateButtonBar();
         this.updateShowHotkeys();
      }
      
      private function onStateUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 1290 method index: 1290
         if(arEvent.data.testEnable == true && this.m_testEnabled == false)
         {
            this.registerTestFunctionality();
         }
         var newData:Object = arEvent.data;
         this.processStateUpdate(newData);
      }
      
      private function processMeterFillUpdate(aNewData:Object) : *
      {
         // method body index: 1291 method index: 1291
         if(this.InnerRing.selectedEntry != null)
         {
            (this.InnerRing.selectedEntry as RadialMenuEntryInner).fillPercent = aNewData.fillMeterPercent;
         }
      }
      
      private function onMeterFillUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 1292 method index: 1292
         var newData:Object = arEvent.data;
         this.processMeterFillUpdate(newData);
      }
      
      protected function onRadialMenuEntryMouseOver(event:Event) : void
      {
         // method body index: 1294 method index: 1294
         var isInnerRing:* = false;
         if(!this.showInventory)
         {
            isInnerRing = event.target is RadialMenuEntryInner;
            BSUIDataManager.dispatchEvent(new CustomEvent("RadialMenu::OnMouseHover",{
               "isInnerRing":isInnerRing,
               "selectedIndex":event.target.index
            }));
         }
      }
      
      private function onPlatformChange(aEvent:PlatformChangeEvent) : void
      {
         // method body index: 1295 method index: 1295
         this.updateShowHotkeys();
      }
      
      private function updateShowHotkeys() : void
      {
         // method body index: 1296 method index: 1296
         var showHotkeys:Boolean = uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && this.selectedMenuIndex == DPAD_STATE_UP;
         this.InnerRing.showKeyLabels = showHotkeys;
         this.OuterRing.showKeyLabels = showHotkeys;
         this.ButtonHintMouseScrollNavigate.ButtonVisible = uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && !this.showInventory;
      }
      
      public function onAdded(e:Event) : void
      {
         // method body index: 1297 method index: 1297
         BSUIDataManager.Subscribe("RadialMenuStateData",this.onStateUpdate);
         BSUIDataManager.Subscribe("RadialMenuExpandMeterData",this.onMeterFillUpdate);
         BSUIDataManager.Subscribe("PlayerInventoryData",this.onPlayerInventoryDataUpdate);
         BSUIDataManager.Subscribe("CharacterInfoData",this.onCharacterInfoDataUpdate);
         BSUIDataManager.Subscribe("ScreenResolutionData",this.onResolutionUpdate);
         BSUIDataManager.Subscribe("AccountInfoData",this.onAccountInfoUpdate);
         this.updateSelfInventory();
      }
      
      private function onAccountInfoUpdate(aEvent:FromClientDataEvent) : void
      {
         // method body index: 1298 method index: 1298
         this.m_HasZeus = aEvent.data.hasZeus;
         this.updateButtonBar();
      }
      
      private function onResolutionUpdate(arEvent:FromClientDataEvent) : *
      {
         // method body index: 1299 method index: 1299
         this.radialTab.gotoAndStop(arEvent.data.AspectRatio);
      }
      
      private function onListMouseOver(event:Event) : *
      {
         // method body index: 1300 method index: 1300
         if(event.target == this.PlayerInventory_mc && this.selectedList != this.PlayerInventory_mc)
         {
            this.selectedList = this.PlayerInventory_mc;
         }
      }
      
      private function onSelectionChange(event:Event) : *
      {
         // method body index: 1301 method index: 1301
         if(this.selectedList != null)
         {
            if(this.selectedListEntry != null)
            {
               if(event != null)
               {
                  GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_FOCUS_CHANGE);
               }
            }
         }
      }
      
      private function onItemPress(event:Event) : *
      {
         // method body index: 1302 method index: 1302
         if(this.showInventory)
         {
            this.onSlotItem();
            GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
         }
      }
      
      private function onFocusChange(event:FocusEvent) : *
      {
         // method body index: 1303 method index: 1303
         if(event.relatedObject != this.PlayerInventory_mc.ItemList_mc.List_mc)
         {
            stage.focus = event.target as InteractiveObject;
         }
      }
      
      private function SortListDataAlphabetically(aListData:Array) : void
      {
         // method body index: 1304 method index: 1304
         if(aListData != null)
         {
            aListData.sortOn("text");
         }
      }
      
      private function updateSelfInventory() : void
      {
         // method body index: 1305 method index: 1305
         var inventoryData:Array = null;
         var weaponData:Array = null;
         var aidData:Array = null;
         var clientData:Object = null;
         var weaponFlag:* = 1 << 1;
         var aidFlag:* = 1 << 3;
         this.PlayerInventory_mc.ItemList_mc.List_mc.filterer.itemFilter = weaponFlag + aidFlag;
         clientData = BSUIDataManager.GetDataFromClient("PlayerInventoryData").data;
         if(clientData != null && clientData.InventoryList != null)
         {
            weaponData = clientData.InventoryList.concat();
            weaponData = clearAllExcept(weaponData,"filterFlag",2,3);
            this.SortListDataAlphabetically(weaponData);
            aidData = clientData.InventoryList.concat();
            aidData = clearAllExcept(aidData,"filterFlag",8,9);
            this.SortListDataAlphabetically(aidData);
         }
         if(weaponData != null)
         {
            inventoryData = weaponData.concat(aidData);
         }
         this.PlayerInventory_mc.ItemList_mc.List_mc.MenuListData = inventoryData;
         this.PlayerInventory_mc.ItemList_mc.SetIsDirty();
         this.onSelectionChange(null);
      }
      
      private function IsInventoryEmpty(aInventoryMC:MovieClip) : Boolean
      {
         // method body index: 1306 method index: 1306
         return aInventoryMC.ItemList_mc.List_mc.MenuListData.length == 0;
      }
      
      private function onCharacterInfoDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1307 method index: 1307
         PlayerListEntry.playerLevel = arEvent.data.level;
      }
      
      private function onPlayerInventoryDataUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 1308 method index: 1308
         this.updateSelfInventory();
         if(this.selectedMenuIndex == DPAD_STATE_UP && this.InnerRing.selectedEntry != null && this.InnerRing.selectedEntry.exists)
         {
            this.m_LastCenterInfo = this.InnerRing.selectedEntry.data;
            this.populateCenterInfo(this.InnerRing.selectedEntry.data);
         }
         this.m_PlayerInventoryEmpty = this.IsInventoryEmpty(this.PlayerInventory_mc);
         if(this.selectedList == this.PlayerInventory_mc)
         {
            this.PlayerInventory_mc.selectedItemIndex = !!this.m_PlayerInventoryEmpty?Number(-1):Number(this.PlayerInventory_mc.ItemList_mc.List_mc.filterer.ClampIndex(this.PlayerInventory_mc.selectedItemIndex));
         }
      }
      
      public function ProcessUserEvent(strEventName:String, abPressed:Boolean) : Boolean
      {
         // method body index: 1309 method index: 1309
         var bhandled:Boolean = false;
         if(this.selectedMenuIndex == DPAD_STATE_DOWN)
         {
            if(strEventName == "PlaceQuickCamp")
            {
               bhandled = true;
            }
         }
         else if(this.selectedMenuIndex == DPAD_STATE_UP)
         {
            bhandled = this.showInventory;
            if(this.showInventory && strEventName == "ForceClose")
            {
               bhandled = false;
               this.onSlotItemCancel();
            }
            if(!abPressed)
            {
               if(!this.showInventory)
               {
                  if(strEventName == "ShowInventory" && this.InnerRing.selectedEntry != null)
                  {
                     this.onShowInventory();
                  }
                  if(strEventName == "PlaceQuickCamp")
                  {
                     this.onPlaceQuickCamp();
                  }
               }
               else if(this.showInventory)
               {
                  switch(strEventName)
                  {
                     case "Select":
                        this.onSlotItem();
                        break;
                     case "Cancel":
                        this.onSlotItemCancel();
                        break;
                     case "InventoryUp":
                        if(uiPlatform != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)
                        {
                           this.m_SelectedList.ItemList_mc.List_mc.moveSelectionUp();
                        }
                        break;
                     case "InventoryDown":
                        if(uiPlatform != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)
                        {
                           this.m_SelectedList.ItemList_mc.List_mc.moveSelectionDown();
                        }
                  }
               }
            }
         }
         this.updateButtonBar();
         return bhandled;
      }
      
      private function thumbstickSpamTimeout(e:TimerEvent) : void
      {
         // method body index: 1310 method index: 1310
         this.m_ThumbstickSpamTimer.stop();
         this.m_ThumbstickSpamDisable = false;
      }
      
      public function ProcessThumbstick(aPressDirection:int) : Boolean
      {
         // method body index: 1311 method index: 1311
         var bhandled:Boolean = this.showInventory;
         if(this.showInventory)
         {
            switch(aPressDirection)
            {
               case GlobalFunc.DIRECTION_UP:
                  this.m_SelectedList.ItemList_mc.List_mc.moveSelectionUp();
                  break;
               case GlobalFunc.DIRECTION_DOWN:
                  this.m_SelectedList.ItemList_mc.List_mc.moveSelectionDown();
            }
         }
         return bhandled;
      }
      
      private function onSlotItemCancel() : void
      {
         // method body index: 1312 method index: 1312
         this.gotoAndStop("radialOnly");
         this.showInventory = false;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_CANCEL);
      }
      
      private function onSlotItem() : void
      {
         // method body index: 1313 method index: 1313
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SLOT_ITEM,{
            "serverHandleId":this.selectedListEntry.serverHandleId,
            "slotId":this.InnerRing.selectedIndex
         }));
         this.gotoAndStop("radialOnly");
         this.showInventory = false;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function onPlaceQuickCamp() : void
      {
         // method body index: 1314 method index: 1314
         BSUIDataManager.dispatchEvent(new Event(EVENT_USE_QUICK_CAMP));
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      private function onShowInventory() : void
      {
         // method body index: 1315 method index: 1315
         this.gotoAndStop("radialInventory");
         this.showInventory = true;
         this.selectedList = this.PlayerInventory_mc;
         GlobalFunc.PlayMenuSound(GlobalFunc.MENU_SOUND_OK);
      }
      
      public function set selectedList(aList:SecureTradeInventory) : *
      {
         // method body index: 1316 method index: 1316
         if(aList != this.m_SelectedList)
         {
            this.m_SelectedList = aList;
            stage.focus = this.m_SelectedList.ItemList_mc.List_mc;
         }
      }
      
      public function get selectedList() : SecureTradeInventory
      {
         // method body index: 1317 method index: 1317
         return this.m_SelectedList;
      }
      
      public function get selectedListEntry() : Object
      {
         // method body index: 1318 method index: 1318
         return this.m_SelectedList.ItemList_mc.List_mc.selectedEntry;
      }
      
      public function get selectedListIndex() : int
      {
         // method body index: 1319 method index: 1319
         return this.m_SelectedList.ItemList_mc.List_mc.selectedIndex;
      }
      
      private function onTestKeyDown(event:KeyboardEvent) : void
      {
         // method body index: 1320 method index: 1320
         var moveDistance:int = 0;
         var menuIndex:int = 0;
         var innerIndex:int = 0;
         var outerIndex:int = 0;
         var fillPercent:Number = NaN;
         moveDistance = 1;
         if(event.shiftKey)
         {
            moveDistance = moveDistance * -1;
         }
         switch(event.keyCode)
         {
            case 116:
               menuIndex = this.testStateData.menuIndex + moveDistance;
               menuIndex = Math.max(DPAD_STATE_NONE,Math.min(menuIndex,DPAD_STATE_RIGHT));
               this.testStateData.menuIndex = menuIndex;
               this.processStateUpdate(this.testStateData);
               break;
            case 117:
               innerIndex = this.testStateData.innerSelectedIndex;
               innerIndex = innerIndex + moveDistance;
               innerIndex = Math.max(-1,Math.min(innerIndex,11));
               this.testStateData.innerSelectedIndex = innerIndex;
               this.processStateUpdate(this.testStateData);
               break;
            case 118:
               this.testStateData.innerExpanded = !this.testStateData.innerExpanded;
               this.processStateUpdate(this.testStateData);
               break;
            case 119:
               outerIndex = this.testStateData.outerSelectedIndex;
               outerIndex = outerIndex + moveDistance;
               outerIndex = Math.max(-1,Math.min(outerIndex,15));
               this.testStateData.outerSelectedIndex = outerIndex;
               this.processStateUpdate(this.testStateData);
               break;
            case 114:
               fillPercent = Math.random();
               this.processMeterFillUpdate({"fillMeterPercent":fillPercent});
         }
      }
      
      public function registerTestFunctionality() : void
      {
         // method body index: 1321 method index: 1321
         this.m_testEnabled = true;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onTestKeyDown);
      }
      
      public function DisableConditionMeter() : *
      {
         // method body index: 1322 method index: 1322
         this._ConditionMeterEnabled = false;
      }
      
      function frame1() : *
      {
         // method body index: 1323 method index: 1323
         stop();
      }
      
      function frame2() : *
      {
         // method body index: 1324 method index: 1324
         stop();
      }
   }
}
