 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.AS3.SWFLoaderClip;
   import Shared.GlobalFunc;
   import fl.transitions.Tween;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   
   public class RadialMenuEntry extends BSUIComponent
   {
      
      public static var UNUSABLE_ALPHA:Number = // method body index: 1451 method index: 1451
      0.25;
      
      public static const PC_HOTKEYS_EN:String = // method body index: 1451 method index: 1451
      "1234567890-=";
      
      public static const PC_HOTKEYS_FR:String = // method body index: 1451 method index: 1451
      "1234567890)=";
      
      public static const PC_HOTKEYS_BE:String = // method body index: 1451 method index: 1451
      "1234567890)-";
      
      public static const MOUSE_OVER:String = // method body index: 1451 method index: 1451
      "RadialMenuEntry::mouse_over";
       
      
      public var Icon_mc:MovieClip;
      
      public var BackgroundHighlight_mc:MovieClip;
      
      public var Backer_mc:MovieClip;
      
      public var Hotkey_mc:MovieClip;
      
      public var HitArea_mc:MovieClip;
      
      public var RarityColor_mc:MovieClip;
      
      protected var m_IconClip:SWFLoaderClip;
      
      protected var m_IconInstance:MovieClip;
      
      protected var m_Index:int;
      
      private var m_Exists:Boolean = false;
      
      protected var m_Selected:Boolean = false;
      
      private var m_Hotkeys:String = "";
      
      private var m_Data:Object;
      
      private var m_Icon:String;
      
      private var m_Level:uint;
      
      private var m_CurrentHealth:Number;
      
      private var m_MaximumHealth:Number;
      
      private var m_AmmoAvailable:Number;
      
      private var m_AmmoName:String = "";
      
      private var m_Rarity:uint;
      
      protected var m_ShowKeyLabel:Boolean = false;
      
      protected var m_ItemVisible:Boolean = true;
      
      public var RarityIndicator_mc:MovieClip;
      
      public var RarityBorder_mc:MovieClip;
      
      private var m_IconAlphaTween:Tween;
      
      public function RadialMenuEntry()
      {
         // method body index: 1452 method index: 1452
         super();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      
      protected function onMouseOver(event:MouseEvent) : void
      {
         // method body index: 1453 method index: 1453
         dispatchEvent(new Event(MOUSE_OVER,true,true));
      }
      
      public function set currentHealth(aHealth:Number) : void
      {
         // method body index: 1454 method index: 1454
         this.m_CurrentHealth = aHealth;
         SetIsDirty();
      }
      
      public function set showKeyLabel(aShow:Boolean) : void
      {
         // method body index: 1455 method index: 1455
         if(aShow != this.m_ShowKeyLabel)
         {
            this.m_ShowKeyLabel = aShow;
            SetIsDirty();
         }
      }
      
      public function set maximumHealth(aHealth:Number) : void
      {
         // method body index: 1456 method index: 1456
         this.m_MaximumHealth = aHealth;
         SetIsDirty();
      }
      
      public function set ammoAvailable(aAvailable:Number) : void
      {
         // method body index: 1457 method index: 1457
         this.m_AmmoAvailable = aAvailable;
         SetIsDirty();
      }
      
      public function set ammoName(aName:String) : void
      {
         // method body index: 1458 method index: 1458
         this.m_AmmoName = aName;
         SetIsDirty();
      }
      
      public function set level(aLevel:uint) : void
      {
         // method body index: 1459 method index: 1459
         this.m_Level = aLevel;
         SetIsDirty();
      }
      
      public function set itemVisible(aVisible:Boolean) : void
      {
         // method body index: 1460 method index: 1460
         this.m_ItemVisible = aVisible;
      }
      
      public function set rarity(aRarity:uint) : void
      {
         // method body index: 1461 method index: 1461
         this.m_Rarity = aRarity;
         SetIsDirty();
      }
      
      public function updateIconState() : void
      {
         // method body index: 1462 method index: 1462
         if(this.m_Selected)
         {
            this.Icon_mc.gotoAndPlay("selected");
         }
         else
         {
            this.Icon_mc.gotoAndPlay("unselected");
         }
      }
      
      public function updateRotation() : *
      {
         // method body index: 1463 method index: 1463
         this.Icon_mc.Body.parent.rotation = -this.rotation - this.parent.rotation;
      }
      
      public function updateIndexAndHotkeys(aIndex:uint, aKeyboardType:uint) : void
      {
         // method body index: 1464 method index: 1464
         switch(aKeyboardType)
         {
            case PlatformChangeEvent.PLATFORM_PC_KB_BE:
               this.m_Hotkeys = PC_HOTKEYS_BE;
               break;
            case PlatformChangeEvent.PLATFORM_PC_KB_FR:
               this.m_Hotkeys = PC_HOTKEYS_FR;
               break;
            case PlatformChangeEvent.PLATFORM_PC_KB_ENG:
            default:
               this.m_Hotkeys = PC_HOTKEYS_EN;
         }
         this.m_Index = aIndex;
         (this.Hotkey_mc.Hotkey_tf as TextField).text = this.m_Hotkeys.charAt(aIndex);
      }
      
      public function get index() : int
      {
         // method body index: 1465 method index: 1465
         return this.m_Index;
      }
      
      public function set data(aData:Object) : *
      {
         // method body index: 1466 method index: 1466
         this.m_Data = aData;
      }
      
      public function get data() : Object
      {
         // method body index: 1467 method index: 1467
         return this.m_Data;
      }
      
      public function set selected(aSelected:Boolean) : *
      {
         // method body index: 1468 method index: 1468
         this.m_Selected = aSelected;
         this.updateIconState();
      }
      
      public function get selected() : Boolean
      {
         // method body index: 1469 method index: 1469
         return this.m_Selected;
      }
      
      public function set exists(aExists:Boolean) : *
      {
         // method body index: 1470 method index: 1470
         this.m_Exists = aExists;
      }
      
      public function get exists() : Boolean
      {
         // method body index: 1471 method index: 1471
         return this.m_Exists;
      }
      
      public function set icon(aIcon:String) : *
      {
         // method body index: 1472 method index: 1472
         if(aIcon != this.m_Icon)
         {
            this.m_Icon = aIcon;
            if(this.m_Icon == "radialIconEmpty" || this.m_Icon == "" || this.m_Icon == null)
            {
               this.Backer_mc.gotoAndStop(2);
            }
            else
            {
               this.Backer_mc.gotoAndStop(1);
            }
            if(this.m_IconInstance != null)
            {
               this.m_IconClip.removeChild(this.m_IconInstance);
               this.m_IconInstance = null;
            }
            this.m_IconInstance = this.m_IconClip.setContainerIconClip(this.m_Icon,"","radialIconEmpty");
            if(this.HitArea_mc != null)
            {
               this.hitArea = this.HitArea_mc;
            }
            this.mouseChildren = false;
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1473 method index: 1473
         var itemLevelColor:* = undefined;
         var characterData:* = BSUIDataManager.GetDataFromClient("CharacterInfoData").data;
         if(this.m_Level <= characterData.level && (this.m_AmmoName.length == 0 || this.m_AmmoAvailable > 0) && (this.m_MaximumHealth == 0 || this.m_CurrentHealth > 0))
         {
            this.m_IconInstance.alpha = 1;
         }
         else
         {
            this.m_IconInstance.alpha = UNUSABLE_ALPHA;
         }
         if(this.RarityColor_mc != null)
         {
            this.RarityColor_mc.visible = this.data.rarity > -1;
            this.RarityIndicator_mc.visible = this.RarityColor_mc.visible;
            if(this.RarityColor_mc.visible)
            {
               itemLevelColor = new ColorTransform();
               if(this.data.rarity == 0)
               {
                  itemLevelColor.color = GlobalFunc.COLOR_RARITY_COMMON;
                  this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_COMMON);
               }
               else if(this.data.rarity == 1)
               {
                  itemLevelColor.color = GlobalFunc.COLOR_RARITY_RARE;
                  this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_RARE);
               }
               else if(this.data.rarity == 2)
               {
                  itemLevelColor.color = GlobalFunc.COLOR_RARITY_EPIC;
                  this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_EPIC);
               }
               else if(this.data.rarity == 3)
               {
                  itemLevelColor.color = GlobalFunc.COLOR_RARITY_LEGENDARY;
                  this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_LEGENDARY);
               }
               else
               {
                  itemLevelColor.color = GlobalFunc.COLOR_TEXT_BODY;
                  this.RarityIndicator_mc.gotoAndStop(GlobalFunc.FRAME_RARITY_NONE);
               }
               this.RarityColor_mc.transform.colorTransform = itemLevelColor;
               this.RarityIndicator_mc.transform.colorTransform = itemLevelColor;
            }
         }
      }
   }
}
