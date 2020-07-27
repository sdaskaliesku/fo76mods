 
package
{
   import Shared.AS3.BSUIComponent;
   
   public dynamic class HUDObjectiveUpdates extends BSUIComponent
   {
      
      private static var POSITION_WHEN_SHOWING_XP:Number = // method body index: 2942 method index: 2942
      65;
      
      private static var MAX_SHOWN:Number = // method body index: 2942 method index: 2942
      4;
      
      private static var Y_SPACING:Number = // method body index: 2942 method index: 2942
      4;
       
      
      public var ObjectiveDataV:Vector.<HUDObjectiveItemData>;
      
      public var ShownObjectivesV:Vector.<HUDObjectiveItem>;
      
      public var ObjectiveItemPoolV:Vector.<HUDObjectiveItem>;
      
      private var _mostRecentIndex:Number = -1;
      
      private var _isShowingXP:Boolean = false;
      
      private var _topYPosition:Number = 0;
      
      private var _maxClipHeight:Number = 100;
      
      public function HUDObjectiveUpdates()
      {
         // method body index: 2949 method index: 2949
         var newObjective:HUDObjectiveItem = null;
         super();
         this.ObjectiveDataV = new Vector.<HUDObjectiveItemData>();
         this.ShownObjectivesV = new Vector.<HUDObjectiveItem>();
         this.ObjectiveItemPoolV = new Vector.<HUDObjectiveItem>();
         this.isShowingXP = false;
         for(var i:int = 0; i < MAX_SHOWN; i++)
         {
            newObjective = new HUDObjectiveItem();
            this.ObjectiveItemPoolV.push(newObjective);
            addChild(newObjective);
         }
      }
      
      public function get topYPosition() : Number
      {
         // method body index: 2943 method index: 2943
         return this._topYPosition;
      }
      
      public function set topYPosition(aValue:Number) : *
      {
         // method body index: 2944 method index: 2944
         this._topYPosition = aValue;
      }
      
      public function get MostRecentItem() : HUDObjectiveItem
      {
         // method body index: 2945 method index: 2945
         return this.ShownObjectivesV[this.mostRecentIndex];
      }
      
      public function get BottomItem() : HUDObjectiveItem
      {
         // method body index: 2946 method index: 2946
         return this.ShownObjectivesV[this.ShownObjectivesV.length - 1];
      }
      
      public function get maxClipHeight_Inspectable() : Number
      {
         // method body index: 2947 method index: 2947
         return this._maxClipHeight;
      }
      
      public function set maxClipHeight_Inspectable(aMaxClipHeight:Number) : void
      {
         // method body index: 2948 method index: 2948
         this._maxClipHeight = aMaxClipHeight;
      }
      
      public function get ObjectiveFadingIn() : Boolean
      {
         // method body index: 2950 method index: 2950
         var bfadingin:* = false;
         if(this.ShownObjectivesV.length > 0)
         {
            bfadingin = !this.MostRecentItem.fullyFadedIn;
         }
         return bfadingin;
      }
      
      public function get ObjectivesScrolling() : Boolean
      {
         // method body index: 2951 method index: 2951
         var bscrolling:Boolean = false;
         for(var i:int = 0; i < this.ShownObjectivesV.length; i++)
         {
            if(this.GetTargetYForIndex(i) - this.ShownObjectivesV[i].y > 0.5)
            {
               bscrolling = true;
               break;
            }
         }
         return bscrolling;
      }
      
      public function get CanFadeInMostRecent() : Boolean
      {
         // method body index: 2952 method index: 2952
         var mostRecent:HUDObjectiveItem = null;
         var mostRecentBottom:Number = NaN;
         var bcanfadein:* = true;
         if(this.ShownObjectivesV.length > 0 && this.mostRecentIndex == this.ShownObjectivesV.length - 1)
         {
            bcanfadein = Boolean(this.MostRecentItem.CanFadeIn());
         }
         else if(this.ShownObjectivesV.length > 1)
         {
            mostRecent = this.MostRecentItem;
            if(mostRecent.CanFadeIn())
            {
               mostRecentBottom = mostRecent.y + mostRecent.height + Y_SPACING;
               bcanfadein = this.ShownObjectivesV[this.mostRecentIndex + 1].y >= mostRecentBottom;
            }
            else
            {
               bcanfadein = false;
            }
         }
         return bcanfadein;
      }
      
      private function AddObjectiveAtBottom() : *
      {
         // method body index: 2953 method index: 2953
         var item:HUDObjectiveItem = this.ObjectiveItemPoolV.shift();
         item.data = this.ObjectiveDataV.shift();
         item.redrawUIComponent();
         this.ShownObjectivesV.push(item);
         this.mostRecentIndex = this.ShownObjectivesV.length - 1;
         item.y = this.GetTargetYForIndex(this.mostRecentIndex);
      }
      
      private function AddObjectiveBeforeIndex(arIndex:Number) : *
      {
         // method body index: 2954 method index: 2954
         var item:HUDObjectiveItem = this.ObjectiveItemPoolV.shift();
         item.data = this.ObjectiveDataV.shift();
         item.redrawUIComponent();
         item.y = this.GetTargetYForIndex(arIndex);
         this.ShownObjectivesV.splice(arIndex,0,item);
         this.mostRecentIndex = arIndex;
      }
      
      private function RemoveObjective(aObjective:HUDObjectiveItem) : *
      {
         // method body index: 2955 method index: 2955
         aObjective.data = null;
         aObjective.ResetFadeState();
         aObjective.visible = false;
         var objectiveIndex:int = this.ShownObjectivesV.indexOf(aObjective,0);
         this.ShownObjectivesV.splice(objectiveIndex,1);
         this.ObjectiveItemPoolV.push(aObjective);
      }
      
      public function get CanShowXP() : Boolean
      {
         // method body index: 2956 method index: 2956
         return this.ShownObjectivesV.length == 0 || this.ShownObjectivesV[0].y >= POSITION_WHEN_SHOWING_XP;
      }
      
      public function ClearObjectives() : *
      {
         // method body index: 2957 method index: 2957
         while(this.ShownObjectivesV.length > 0)
         {
            this.RemoveObjective(this.ShownObjectivesV[0]);
         }
         this.mostRecentIndex = -1;
      }
      
      public function get CanAddMessage() : Boolean
      {
         // method body index: 2958 method index: 2958
         return !this.ObjectiveFadingIn && !this.ObjectivesScrolling;
      }
      
      public function get mostRecentIndex() : Number
      {
         // method body index: 2959 method index: 2959
         return this.ShownObjectivesV.length > 0?Number(this._mostRecentIndex):Number(-1);
      }
      
      public function set mostRecentIndex(value:Number) : void
      {
         // method body index: 2960 method index: 2960
         this._mostRecentIndex = value;
      }
      
      public function get isShowingXP() : Boolean
      {
         // method body index: 2961 method index: 2961
         return this._isShowingXP;
      }
      
      public function set isShowingXP(value:Boolean) : void
      {
         // method body index: 2962 method index: 2962
         this._isShowingXP = value;
         if(this._isShowingXP)
         {
            this.topYPosition = POSITION_WHEN_SHOWING_XP;
         }
         else if(this.ShownObjectivesV.length == 0)
         {
            this.topYPosition = 0;
         }
         else
         {
            this.topYPosition = this.ShownObjectivesV[0].y;
         }
      }
      
      public function GetTargetYForIndex(index:int) : Number
      {
         // method body index: 2963 method index: 2963
         var outval:Number = this.topYPosition;
         for(var i:int = 0; i < index; i++)
         {
            outval = outval + (this.ShownObjectivesV[i].height + Y_SPACING);
         }
         return outval;
      }
      
      function ScrollItems(item:HUDObjectiveItem, index:int, vector:Vector.<HUDObjectiveItem>) : Boolean
      {
         // method body index: 2964 method index: 2964
         var target:Number = this.GetTargetYForIndex(index);
         if(target > item.y)
         {
            item.y = item.y + 1;
            if(item.y > target)
            {
               item.y = target;
            }
         }
         return true;
      }
      
      public function Update() : void
      {
         // method body index: 2965 method index: 2965
         if(this.CanAddMessage && this.ObjectiveDataV.length > 0 && this.ObjectiveItemPoolV.length > 0)
         {
            if(this.ObjectiveDataV[0].orWithPrevious)
            {
               if(this.mostRecentIndex == this.ShownObjectivesV.length - 1)
               {
                  this.AddObjectiveAtBottom();
               }
               else
               {
                  this.AddObjectiveBeforeIndex(this.mostRecentIndex + 1);
               }
            }
            else
            {
               this.AddObjectiveBeforeIndex(0);
            }
         }
         if(this.ShownObjectivesV.length > 0)
         {
            this.ShownObjectivesV.forEach(this.ScrollItems);
            if(!this.MostRecentItem.fadeInStarted && this.CanFadeInMostRecent)
            {
               this.MostRecentItem.FadeIn();
            }
            if(!this.ObjectivesScrolling)
            {
               if(this.BottomItem.CanFastFadeOut() && this.ObjectiveItemPoolV.length == 0 && this.ObjectiveDataV.length > 0)
               {
                  this.BottomItem.FastFadeOut();
               }
            }
            if(this.BottomItem.fullyFadedOut)
            {
               this.RemoveObjective(this.BottomItem);
            }
         }
         else
         {
            this.topYPosition = !!this.isShowingXP?Number(POSITION_WHEN_SHOWING_XP):Number(0);
         }
      }
   }
}
