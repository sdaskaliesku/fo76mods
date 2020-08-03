package 
{
    import Shared.AS3.*;
    import __AS3__.vec.*;
    
    public class ItemCard extends Shared.AS3.BSUIComponent
    {
        public function ItemCard()
        {
            super();
            this._InfoObj = new Array();
            this._showItemDesc = true;
            this._showValueEntry = true;
            this.bItemHealthEnabled = true;
            return;
        }

        public function get entryCount():int
        {
            return this.m_EntryCount;
        }

        public function get entrySpacing():Number
        {
            return this.m_EntrySpacing;
        }

        public function set bottomUp(arg1:Boolean):*
        {
            this.m_BottomUp = arg1;
            return;
        }

        public function get bottomUp():Boolean
        {
            return this.m_BottomUp;
        }

        public function set currencyType(arg1:uint):*
        {
            this._currencyType = arg1;
            return;
        }

        public function get InfoObj():Array
        {
            return this._InfoObj;
        }

        public function set InfoObj(arg1:Array):*
        {
            this._InfoObj = arg1;
            return;
        }

        public function set showItemDesc(arg1:Boolean):*
        {
            this._showItemDesc = arg1;
            return;
        }

        public function get showItemDesc():Boolean
        {
            return this._showItemDesc;
        }

        public function set showValueEntry(arg1:Boolean):*
        {
            this._showValueEntry = arg1;
            return;
        }

        public function get showValueEntry():Boolean
        {
            return this._showValueEntry;
        }

        public function onDataChange():*
        {
            SetIsDirty();
            return;
        }

        public override function redrawUIComponent():void
        {
            var loc2:*=null;
            var loc7:*=null;
            var loc9:*=NaN;
            var loc11:*=NaN;
            var loc15:*=0;
            var loc16:*=null;
            var loc17:*=null;
            super.redrawUIComponent();
            while (this.numChildren > 0) 
            {
                this.removeChildAt(0);
            }
            var loc1:*=0;
            var loc3:*=new Vector.<ItemCard_Entry>();
            var loc4:*=false;
            var loc5:*=false;
            var loc6:*=new Array();
            var loc8:*=new Object();
            var loc10:*=0;
            var loc12:*=(this._InfoObj.length - 1);
            while (loc12 >= 0) 
            {
                var loc18:*=this._InfoObj[loc12].text;
                switch (loc18) 
                {
                    case ItemCard_MultiEntry.DMG_WEAP_ID:
                    {
                        loc4 = loc4 || ItemCard_MultiEntry.IsEntryValid(this._InfoObj[loc12]);
                        break;
                    }
                    case ItemCard_MultiEntry.DMG_ARMO_ID:
                    {
                        loc5 = loc5 || ItemCard_MultiEntry.IsEntryValid(this._InfoObj[loc12]);
                        break;
                    }
                    case "$health":
                    {
                        loc8.currentHealth = this._InfoObj[loc12].currentHealth;
                        loc8.maxMeterHealth = this._InfoObj[loc12].maximumHealth;
                        loc8.maximumHealth = this._InfoObj[loc12].maximumHealth;
                        break;
                    }
                    case "currentHealth":
                    {
                        loc8.currentHealth = this._InfoObj[loc12].value;
                        break;
                    }
                    case "maxMeterHealth":
                    {
                        loc8.maxMeterHealth = this._InfoObj[loc12].value;
                        break;
                    }
                    case "minMeterHealth":
                    {
                        loc8.minMeterHealth = this._InfoObj[loc12].value;
                        break;
                    }
                    case "healthPercent":
                    {
                        break;
                    }
                    case "maximumHealth":
                    {
                        loc8.maxMeterHealth = this._InfoObj[loc12].value;
                        loc8.maximumHealth = this._InfoObj[loc12].value;
                        break;
                    }
                    case "legendaryMods":
                    {
                        loc10 = this._InfoObj[loc12].value;
                        if (ItemCard_DurabilityEntry.IsEntryValid(this._InfoObj[loc12])) 
                        {
                            loc7 = this._InfoObj[loc12];
                        }
                        break;
                    }
                    case "$StatDurability":
                    case "durability":
                    {
                        loc8.durability = this._InfoObj[loc12].value;
                        break;
                    }
                    case "$StatLevel":
                    case "itemLevel":
                    {
                        loc11 = this._InfoObj[loc12].value;
                        break;
                    }
                    default:
                    {
                        if (this._InfoObj[loc12].showAsDescription != true) 
                        {
                            if (ItemCard_DurabilityEntry.IsEntryValid(this._InfoObj[loc12])) 
                            {
                                loc7 = this._InfoObj[loc12];
                            }
                            else 
                            {
                                loc15 = this.GetEntryType(this._InfoObj[loc12]);
                                loc2 = this.CreateEntry(loc15);
                                if (loc2 != null) 
                                {
                                    loc2.PopulateEntry(this._InfoObj[loc12]);
                                    loc3.push(loc2);
                                }
                            }
                        }
                        break;
                    }
                }
                --loc12;
            }
            if (this._showItemDesc) 
            {
                loc18 = 0;
                var loc19:*=this._InfoObj;
                for each (loc16 in loc19) 
                {
                    if (loc16.showAsDescription != true) 
                    {
                        continue;
                    }
                    loc6.push(loc16);
                }
            }
            if (loc11) 
            {
                loc7 = {"itemLevel":loc11, "legendaryMods":loc10};
            }
            if (loc4) 
            {
                loc2 = this.CreateEntry(this.ET_DMG_WEAP);
                if (loc2 != null) 
                {
                    (loc2 as ItemCard_MultiEntry).PopulateMultiEntry(this._InfoObj, ItemCard_MultiEntry.DMG_WEAP_ID);
                    loc3.push(loc2);
                }
            }
            if (loc5) 
            {
                loc2 = this.CreateEntry(this.ET_DMG_ARMO);
                if (loc2 != null) 
                {
                    (loc2 as ItemCard_MultiEntry).PopulateMultiEntry(this._InfoObj, ItemCard_MultiEntry.DMG_ARMO_ID);
                    loc3.push(loc2);
                }
            }
            if (loc8.maxMeterHealth > 0 && !(loc8.currentHealth == -1) && this.bItemHealthEnabled) 
            {
                loc2 = this.CreateEntry(this.ET_ITEM_HEALTH);
                if (loc2 != null) 
                {
                    (loc2 as ItemCard_ItemHealthEntry).PopulateEntry(loc8);
                    loc3.push(loc2);
                }
            }
            if (loc7 != null) 
            {
                loc2 = this.CreateEntry(this.ET_LEGENDARY_AND_LEVEL);
                if (loc2 != null) 
                {
                    (loc2 as ItemCard_DurabilityEntry).PopulateEntry(loc7);
                    loc3.push(loc2);
                }
            }
            if (loc6.length > 0) 
            {
                loc2 = this.CreateEntry(this.ET_ITEM_DESCRIPTION);
                if ((loc17 = loc2 as ItemCard_DescriptionEntry) != null) 
                {
                    loc17.PopulateEntries(loc6);
                    loc3.push(loc2);
                }
            }
            this.FillBlankEntries(loc3);
            var loc13:*=loc3.length;
            if (!this.m_BottomUp) 
            {
                loc3.reverse();
            }
            this.m_EntryCount = 0;
            var loc14:*=0;
            while (loc14 < loc13) 
            {
                addChild(loc3[loc14]);
                if (loc3[loc14] is ItemCard_MultiEntry) 
                {
                    this.m_EntryCount = this.m_EntryCount + (loc3[loc14] as ItemCard_MultiEntry).entryCount;
                }
                else if (loc3[loc14] is ItemCard_ComponentsEntry) 
                {
                    this.m_EntryCount = this.m_EntryCount + (loc3[loc14] as ItemCard_ComponentsEntry).entryCount;
                }
                else 
                {
                    loc19 = ((loc18 = this).m_EntryCount + 1);
                    loc18.m_EntryCount = loc19;
                }
                if (this.m_BottomUp) 
                {
                    if (loc1 < 0) 
                    {
                        loc1 = loc1 - this.m_EntrySpacing;
                    }
                    loc1 = loc1 - loc3[loc14].height;
                    loc3[loc14].y = loc1;
                }
                else 
                {
                    loc3[loc14].y = loc1;
                    loc1 = loc1 + (loc3[loc14].height + this.m_EntrySpacing);
                }
                ++loc14;
            }
            return;
        }

        internal function FillBlankEntries(arg1:__AS3__.vec.Vector.<ItemCard_Entry>):void
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=0;
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (arg1[loc3] is ItemCard_MultiEntry) 
                {
                    loc1 = loc1 + (arg1[loc3] as ItemCard_MultiEntry).entryCount;
                }
                else if (arg1[loc3] is ItemCard_ComponentsEntry) 
                {
                    loc1 = loc1 + (arg1[loc3] as ItemCard_ComponentsEntry).entryCount;
                }
                else 
                {
                    ++loc1;
                }
                ++loc3;
            }
            if (loc1 < this.m_BlankEntryFillTarget) 
            {
                loc5 = loc1;
                while (loc5 < this.m_BlankEntryFillTarget) 
                {
                    (loc4 = new ItemCard_StandardEntry()).PopulateEntry({"text":"", "value":""});
                    arg1.unshift(loc4);
                    ++loc5;
                }
            }
            return;
        }

        internal function GetEntryType(arg1:Object):uint
        {
            var loc1:*=this.ET_STANDARD;
            if (arg1.text != "$val") 
            {
                if (arg1.damageType != 10) 
                {
                    if (!(arg1.duration == null) && arg1.duration > 0) 
                    {
                        loc1 = this.ET_TIMED_EFFECT;
                    }
                    else if (arg1.components is Array && arg1.components.length > 0) 
                    {
                        loc1 = this.ET_COMPONENTS_LIST;
                    }
                }
                else 
                {
                    loc1 = this.ET_AMMO;
                }
            }
            else 
            {
                loc1 = this.ET_VALUE;
            }
            return loc1;
        }

        public function set blankEntryFillTarget(arg1:uint):void
        {
            this.m_BlankEntryFillTarget = arg1;
            return;
        }

        public function get blankEntryFillTarget():uint
        {
            return this.m_BlankEntryFillTarget;
        }

        internal function CreateEntry(arg1:uint):ItemCard_Entry
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case this.ET_VALUE:
                {
                    if (this._showValueEntry) 
                    {
                        loc1 = new ItemCard_ValueEntry();
                        (loc1 as ItemCard_ValueEntry).currencyType = this._currencyType;
                    }
                    break;
                }
                case this.ET_STANDARD:
                {
                    loc1 = new ItemCard_StandardEntry();
                    break;
                }
                case this.ET_AMMO:
                {
                    loc1 = new ItemCard_AmmoEntry();
                    break;
                }
                case this.ET_DMG_WEAP:
                case this.ET_DMG_ARMO:
                {
                    loc1 = new ItemCard_MultiEntry();
                    if (this.m_EntrySpacingChanged) 
                    {
                        (loc1 as ItemCard_MultiEntry).entrySpacing = this.m_EntrySpacing;
                    }
                    break;
                }
                case this.ET_TIMED_EFFECT:
                {
                    loc1 = new ItemCard_TimedEntry();
                    break;
                }
                case this.ET_COMPONENTS_LIST:
                {
                    loc1 = new ItemCard_ComponentsEntry();
                    break;
                }
                case this.ET_ITEM_DESCRIPTION:
                {
                    loc1 = new ItemCard_DescriptionEntry();
                    break;
                }
                case this.ET_LEGENDARY_AND_LEVEL:
                {
                    loc1 = new ItemCard_DurabilityEntry();
                    break;
                }
                case this.ET_ITEM_HEALTH:
                {
                    loc1 = new ItemCard_ItemHealthEntry();
                    break;
                }
            }
            return loc1;
        }

        public function HideItemHealth():*
        {
            this.bItemHealthEnabled = false;
            return;
        }

        public function set entrySpacing(arg1:Number):*
        {
            this.m_EntrySpacing = arg1;
            this.m_EntrySpacingChanged = true;
            return;
        }

        internal const ET_STANDARD:uint=0;

        internal const ET_AMMO:uint=1;

        internal const ET_DMG_WEAP:uint=2;

        internal const ET_DMG_ARMO:uint=3;

        internal const ET_TIMED_EFFECT:uint=4;

        internal const ET_COMPONENTS_LIST:uint=5;

        internal const ET_ITEM_DESCRIPTION:uint=6;

        internal const ET_LEGENDARY_AND_LEVEL:uint=7;

        internal const ET_ITEM_HEALTH:uint=8;

        internal const ET_VALUE:uint=9;

        internal var _InfoObj:Array;

        internal var _showItemDesc:Boolean;

        internal var _showValueEntry:Boolean;

        internal var bItemHealthEnabled:Boolean;

        internal var m_BlankEntryFillTarget:uint=0;

        internal var m_EntrySpacing:Number=-3.5;

        internal var m_EntrySpacingChanged:Boolean=false;

        internal var m_BottomUp:Boolean=true;

        internal var _currencyType:uint=0;

        internal var m_EntryCount:int=0;
    }
}
