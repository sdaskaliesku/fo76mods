 
package
{
   import Shared.AS3.BSUIComponent;
   
   public dynamic class HUDObjectiveUpdates extends BSUIComponent
   {
      
      private static var POSITION_WHEN_SHOWING_XP:Number = // method body index: 2893 method index: 2893
      65;
      
      private static var MAX_SHOWN:Number = // method body index: 2893 method index: 2893
      4;
      
      private static var Y_SPACING:Number = // method body index: 2893 method index: 2893
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

         var _loc1_:HUDObjectiveItem = null;
         super();
         this.ObjectiveDataV = new Vector.<HUDObjectiveItemData>();
         this.ShownObjectivesV = new Vector.<HUDObjectiveItem>();
         this.ObjectiveItemPoolV = new Vector.<HUDObjectiveItem>();
         this.isShowingXP = false;
         var _loc2_:int = 0;
         while(_loc2_ < MAX_SHOWN)
         {
            _loc1_ = new HUDObjectiveItem();
            this.ObjectiveItemPoolV.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function get topYPosition() : Number
      {

         return this._topYPosition;
      }
      
      public function set topYPosition(param1:Number) : *
      {

         this._topYPosition = param1;
      }
      
      public function get MostRecentItem() : HUDObjectiveItem
      {

         return this.ShownObjectivesV[this.mostRecentIndex];
      }
      
      public function get BottomItem() : HUDObjectiveItem
      {

         return this.ShownObjectivesV[this.ShownObjectivesV.length - 1];
      }
      
      public function get maxClipHeight_Inspectable() : Number
      {

         return this._maxClipHeight;
      }
      
      public function set maxClipHeight_Inspectable(param1:Number) : void
      {

         this._maxClipHeight = param1;
      }
      
      public function get ObjectiveFadingIn() : Boolean
      {

         var _loc1_:* = false;
         if(this.ShownObjectivesV.length > 0)
         {
            _loc1_ = !this.MostRecentItem.fullyFadedIn;
         }
         return _loc1_;
      }
      
      public function get ObjectivesScrolling() : Boolean
      {

         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < this.ShownObjectivesV.length)
         {
            if(this.GetTargetYForIndex(_loc2_) - this.ShownObjectivesV[_loc2_].y > 0.5)
            {
               _loc1_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get CanFadeInMostRecent() : Boolean
      {

         var _loc1_:HUDObjectiveItem = null;
         var _loc2_:Number = NaN;
         var _loc3_:* = true;
         if(this.ShownObjectivesV.length > 0 && this.mostRecentIndex == this.ShownObjectivesV.length - 1)
         {
            _loc3_ = Boolean(this.MostRecentItem.CanFadeIn());
         }
         else if(this.ShownObjectivesV.length > 1)
         {
            _loc1_ = this.MostRecentItem;
            if(_loc1_.CanFadeIn())
            {
               _loc2_ = _loc1_.y + _loc1_.height + Y_SPACING;
               _loc3_ = this.ShownObjectivesV[this.mostRecentIndex + 1].y >= _loc2_;
            }
            else
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function AddObjectiveAtBottom() : *
      {

         var _loc1_:HUDObjectiveItem = this.ObjectiveItemPoolV.shift();
         _loc1_.data = this.ObjectiveDataV.shift();
         _loc1_.redrawUIComponent();
         this.ShownObjectivesV.push(_loc1_);
         this.mostRecentIndex = this.ShownObjectivesV.length - 1;
         _loc1_.y = this.GetTargetYForIndex(this.mostRecentIndex);
      }
      
      private function AddObjectiveBeforeIndex(param1:Number) : *
      {

         var _loc2_:HUDObjectiveItem = this.ObjectiveItemPoolV.shift();
         _loc2_.data = this.ObjectiveDataV.shift();
         _loc2_.redrawUIComponent();
         _loc2_.y = this.GetTargetYForIndex(param1);
         this.ShownObjectivesV.splice(param1,0,_loc2_);
         this.mostRecentIndex = param1;
      }
      
      private function RemoveObjective(param1:HUDObjectiveItem) : *
      {

         param1.data = null;
         param1.ResetFadeState();
         param1.visible = false;
         var _loc2_:int = this.ShownObjectivesV.indexOf(param1,0);
         this.ShownObjectivesV.splice(_loc2_,1);
         this.ObjectiveItemPoolV.push(param1);
      }
      
      public function get CanShowXP() : Boolean
      {

         return this.ShownObjectivesV.length == 0 || this.ShownObjectivesV[0].y >= POSITION_WHEN_SHOWING_XP;
      }
      
      public function ClearObjectives() : *
      {

         while(this.ShownObjectivesV.length > 0)
         {
            this.RemoveObjective(this.ShownObjectivesV[0]);
         }
         this.mostRecentIndex = -1;
      }
      
      public function get CanAddMessage() : Boolean
      {

         return !this.ObjectiveFadingIn && !this.ObjectivesScrolling;
      }
      
      public function get mostRecentIndex() : Number
      {

         return this.ShownObjectivesV.length > 0?Number(Number(this._mostRecentIndex)):Number(Number(-1));
      }
      
      public function set mostRecentIndex(param1:Number) : void
      {

         this._mostRecentIndex = param1;
      }
      
      public function get isShowingXP() : Boolean
      {

         return this._isShowingXP;
      }
      
      public function set isShowingXP(param1:Boolean) : void
      {

         this._isShowingXP = param1;
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
      
      public function GetTargetYForIndex(param1:int) : Number
      {

         var _loc2_:Number = this.topYPosition;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = _loc2_ + (this.ShownObjectivesV[_loc3_].height + Y_SPACING);
            _loc3_++;
         }
         return _loc2_;
      }
      
      function ScrollItems(param1:HUDObjectiveItem, param2:int, param3:Vector.<HUDObjectiveItem>) : Boolean
      {

         var _loc4_:Number = this.GetTargetYForIndex(param2);
         if(_loc4_ > param1.y)
         {
            param1.y = param1.y + 1;
            if(param1.y > _loc4_)
            {
               param1.y = _loc4_;
            }
         }
         return true;
      }
      
      public function Update() : void
      {

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
            this.topYPosition = !!this.isShowingXP?Number(Number(POSITION_WHEN_SHOWING_XP)):Number(Number(0));
         }
      }
   }
}
