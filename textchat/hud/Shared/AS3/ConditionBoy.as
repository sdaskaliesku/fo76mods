 
package Shared.AS3
{
   import Shared.AS3.COMPANIONAPP.PipboyLoader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.setTimeout;
   
   public dynamic class ConditionBoy extends BSUIComponent
   {
      
      private static const CONDITION_DISPLAY_TIME:uint = // method body index: 2995 method index: 2995
      5000;
      
      private static const CLIP_BODY_TEMPLATE_PATH:String = // method body index: 2995 method index: 2995
      "Components/ConditionClips/Condition_Body_";
      
      private static const CLIP_BODY_HUNGER_ID:int = // method body index: 2995 method index: 2995
      16;
      
      private static const CLIP_BODY_THIRST_ID:int = // method body index: 2995 method index: 2995
      18;
      
      private static const CLIP_BODY_DISEASE_ID:int = // method body index: 2995 method index: 2995
      17;
      
      private static const CLIP_BODY_MUTATION_ID:int = // method body index: 2995 method index: 2995
      19;
      
      private static const NUM_BODY_CLIPS:int = // method body index: 2995 method index: 2995
      20;
      
      private static const HEAD_NORMAL_FRAME:uint = // method body index: 2995 method index: 2995
      1;
      
      private static const HEAD_GENERAL_NEGATIVE_FRAME:uint = // method body index: 2995 method index: 2995
      4;
      
      private static const HEAD_GENERAL_NEGATIVE_DAMAGED_FRAME:uint = // method body index: 2995 method index: 2995
      33;
      
      private static const HEAD_DRUGGED_FRAME:uint = // method body index: 2995 method index: 2995
      5;
      
      private static const HEAD_DRUGGED_DAMAGED_FRAME:uint = // method body index: 2995 method index: 2995
      37;
      
      private static const HEAD_IRRADIATED_FRAME:uint = // method body index: 2995 method index: 2995
      17;
      
      private static const HEAD_IRRADIATED_DAMAGED_FRAME:uint = // method body index: 2995 method index: 2995
      49;
      
      private static const HEAD_DISEASED_FRAME:uint = // method body index: 2995 method index: 2995
      65;
      
      private static const HEAD_DISEASED_DAMAGED_FRAME:uint = // method body index: 2995 method index: 2995
      67;
      
      private static const HEAD_MUTATED_FRAME:uint = // method body index: 2995 method index: 2995
      71;
      
      private static const HEAD_MUTATED_DAMAGED_FRAME:uint = // method body index: 2995 method index: 2995
      76;
      
      private static const HEAD_HUNGER_FRAME:uint = // method body index: 2995 method index: 2995
      HEAD_DRUGGED_FRAME;
      
      private static const HEAD_THIRST_FRAME:uint = // method body index: 2995 method index: 2995
      HEAD_DRUGGED_FRAME;
       
      
      private var BodyClip:MovieClip = null;
      
      private var HeadClip:MovieClip = null;
      
      private var HeadLoader:PipboyLoader;
      
      private var BodyLoader:PipboyLoader;
      
      private var ColorFileText:String;
      
      private var PrimaryCondition:Object;
      
      private var SecondaryConditions:Vector.<Object>;
      
      private var CurrentlyShownCondition:Object;
      
      private var PreloadedBodyClips:Vector.<PipboyLoader>;
      
      private var ShouldUpdate:Boolean = false;
      
      private var PrimaryConditionChanged:Boolean = false;
      
      private var IsReadyForNextCondition:Boolean = true;
      
      private var IsMutated:Boolean = false;
      
      private var IsDiseased:Boolean = false;
      
      private var IsThirstStateNegative:Boolean = false;
      
      private var IsHungerStateNegative:Boolean = false;
      
      private var Monochrome:Boolean = false;
      
      private var IsMenuInstance:Boolean = false;
      
      public function ConditionBoy()
      {
         // method body index: 2996 method index: 2996
         this.ColorFileText = new String();
         this.PrimaryCondition = {};
         this.SecondaryConditions = new Vector.<Object>();
         this.CurrentlyShownCondition = {};
         super();
         this.LoadHead();
      }
      
      public function set monochrome(param1:Boolean) : *
      {
         // method body index: 2997 method index: 2997
      }
      
      public function get monochrome() : *
      {
         // method body index: 2998 method index: 2998
         return this.Monochrome;
      }
      
      public function set isMenuInstance(param1:Boolean) : *
      {
         // method body index: 2999 method index: 2999
         this.IsMenuInstance = param1;
      }
      
      public function PreloadConditions() : *
      {
         // method body index: 3000 method index: 3000
         var _loc1_:* = undefined;
         var _loc2_:PipboyLoader = null;
         var _loc3_:URLRequest = null;
         if(!this.PreloadedBodyClips)
         {
            this.PreloadedBodyClips = new Vector.<PipboyLoader>(NUM_BODY_CLIPS,true);
            for(_loc1_ in this.PreloadedBodyClips)
            {
               _loc2_ = new PipboyLoader();
               this.PreloadedBodyClips[_loc1_] = _loc2_;
               _loc3_ = new URLRequest(this.GetPathForCondition(_loc1_));
               _loc2_.load(_loc3_);
            }
         }
      }
      
      private function GetPathForCondition(param1:int) : *
      {
         // method body index: 3001 method index: 3001
         return CLIP_BODY_TEMPLATE_PATH + this.ColorFileText + param1 + ".swf";
      }
      
      public function SetData(param1:Object) : *
      {
         // method body index: 3002 method index: 3002
         this.UpdatePrimaryCondition(param1);
         if(!this.IsMenuInstance)
         {
            this.UpdateSecondaryConditions(param1);
         }
         if(this.IsReadyForNextCondition)
         {
            this.ShowNextCondition();
         }
      }
      
      private function UpdatePrimaryCondition(param1:Object) : *
      {
         // method body index: 3003 method index: 3003
         var _loc2_:Boolean = param1.isHeadDamaged;
         var _loc3_:uint = HEAD_NORMAL_FRAME;
         if(param1.isIrradiated)
         {
            _loc3_ = !!_loc2_?uint(uint(HEAD_IRRADIATED_DAMAGED_FRAME)):uint(uint(HEAD_IRRADIATED_FRAME));
         }
         else if(param1.isDrugged)
         {
            _loc3_ = !!_loc2_?uint(uint(HEAD_DRUGGED_DAMAGED_FRAME)):uint(uint(HEAD_DRUGGED_FRAME));
         }
         else if(param1.isAddicted || _loc2_ || param1.bodyFlags != 0)
         {
            _loc3_ = !!_loc2_?uint(uint(HEAD_GENERAL_NEGATIVE_DAMAGED_FRAME)):uint(uint(HEAD_GENERAL_NEGATIVE_FRAME));
         }
         this.PrimaryCondition.isPersistent = _loc2_ || param1.bodyFlags != 0;
         if(this.PrimaryCondition.headFrame != _loc3_ || this.PrimaryCondition.bodyId != param1.bodyFlags)
         {
            this.PrimaryCondition.headFrame = _loc3_;
            this.PrimaryCondition.bodyId = param1.bodyFlags;
            this.PrimaryConditionChanged = true;
         }
      }
      
      private function UpdateSecondaryConditions(param1:Object) : *
      {
         // method body index: 3004 method index: 3004
         var _loc2_:Boolean = param1.isHeadDamaged;
         if(!this.IsMutated && param1.isMutated)
         {
            this.SecondaryConditions.push({
               "headFrame":(!!_loc2_?HEAD_MUTATED_DAMAGED_FRAME:HEAD_MUTATED_FRAME),
               "bodyId":CLIP_BODY_MUTATION_ID
            });
         }
         this.IsMutated = param1.isMutated;
         if(!this.IsDiseased && param1.isDiseased)
         {
            this.SecondaryConditions.push({
               "headFrame":(!!_loc2_?HEAD_DISEASED_DAMAGED_FRAME:HEAD_DISEASED_FRAME),
               "bodyId":CLIP_BODY_DISEASE_ID
            });
         }
         this.IsDiseased = param1.isDiseased;
         if(param1.isThirstStateNegative && !this.IsThirstStateNegative)
         {
            this.SecondaryConditions.push({
               "headFrame":HEAD_THIRST_FRAME,
               "bodyId":CLIP_BODY_THIRST_ID
            });
         }
         this.IsThirstStateNegative = param1.isThirstStateNegative;
         if(param1.isHungerStateNegative && !this.IsHungerStateNegative)
         {
            this.SecondaryConditions.push({
               "headFrame":HEAD_HUNGER_FRAME,
               "bodyId":CLIP_BODY_HUNGER_ID
            });
         }
         this.IsHungerStateNegative = param1.isHungerStateNegative;
      }
      
      private function ShowNextCondition() : *
      {
         // method body index: 3005 method index: 3005
         var _loc1_:Boolean = false;
         var _loc2_:URLRequest = null;
         var _loc3_:Object = null;
         if(this.SecondaryConditions.length > 0)
         {
            _loc3_ = this.SecondaryConditions.pop();
         }
         else if(this.PrimaryConditionChanged || this.PrimaryCondition.isPersistent)
         {
            _loc3_ = this.PrimaryCondition;
            this.PrimaryConditionChanged = false;
         }
         if(_loc3_)
         {
            _loc1_ = this.IsShowingCondition(_loc3_) && _loc3_.isPersistent;
            if(!_loc1_)
            {
               this.UnloadBody();
               this.CurrentlyShownCondition.headFrame = _loc3_.headFrame;
               this.CurrentlyShownCondition.bodyId = _loc3_.bodyId;
               if(this.PreloadedBodyClips != null)
               {
                  this.onConditionBodyLoadComplete(null);
               }
               else
               {
                  this.BodyLoader = new PipboyLoader();
                  this.BodyLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
                  this.BodyLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
                  _loc2_ = new URLRequest(this.GetPathForCondition(_loc3_.bodyId));
                  this.BodyLoader.load(_loc2_);
               }
            }
         }
         else if(!this.IsMenuInstance)
         {
            visible = false;
            this.UnloadBody();
         }
      }
      
      private function IsShowingCondition(param1:Object) : *
      {
         // method body index: 3006 method index: 3006
         return param1 && this.CurrentlyShownCondition && param1.headFrame == this.CurrentlyShownCondition.headFrame && param1.bodyId == this.CurrentlyShownCondition.bodyId;
      }
      
      private function LoadHead() : *
      {
         // method body index: 3007 method index: 3007
         if(this.HeadLoader)
         {
            this.HeadLoader.unloadAndStop();
         }
         this.HeadLoader = new PipboyLoader();
         var _loc1_:URLRequest = new URLRequest(!!this.monochrome?"Components/ConditionClips/Condition_Head_Mono.swf":"Components/ConditionClips/Condition_Head.swf");
         this.HeadLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onConditionHeadLoadComplete);
         this.HeadLoader.load(_loc1_);
      }
      
      private function UnloadBody() : *
      {
         // method body index: 3008 method index: 3008
         if(this.BodyLoader)
         {
            try
            {
               this.BodyLoader.close();
            }
            catch(e:Error)
            {
            }
         }
         if(this.BodyClip)
         {
            removeChild(this.BodyClip);
            this.BodyClip.stop();
            this.BodyClip = null;
         }
         if(this.BodyLoader)
         {
            this.BodyLoader.unload();
            this.BodyLoader = null;
         }
         this.CurrentlyShownCondition = {};
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3010 method index: 3010
         super.redrawUIComponent();
         if(this.BodyClip && this.HeadClip && this.ShouldUpdate)
         {
            visible = true;
            this.ShouldUpdate = false;
            this.BodyClip.Head_mc.addChild(this.HeadClip);
            this.BodyClip.scaleX = 1.2;
            this.BodyClip.scaleY = this.BodyClip.scaleX;
            addChild(this.BodyClip);
            this.BodyClip.play();
            this.HeadClip.gotoAndStop(this.CurrentlyShownCondition.headFrame);
            if(!this.IsMenuInstance)
            {
               this.IsReadyForNextCondition = false;
               setTimeout(function():// method body index: 3009 method index: 3009
               void
               {
                  // method body index: 3009 method index: 3009
                  IsReadyForNextCondition = true;
                  ShowNextCondition();
               },CONDITION_DISPLAY_TIME);
            }
         }
      }
      
      private function onConditionBodyLoadComplete(param1:Event) : *
      {
         // method body index: 3011 method index: 3011
         if(this.BodyLoader)
         {
            param1.target.removeEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
            param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
            this.BodyClip = this.BodyLoader.contentLoaderInfo.content as MovieClip;
         }
         else if(this.PreloadedBodyClips)
         {
            this.BodyClip = this.PreloadedBodyClips[this.CurrentlyShownCondition.bodyId].contentLoaderInfo.content as MovieClip;
         }
         else
         {
            throw new Error("onConditionBodyLoadComplete called but there is no loader nor preloaded clip to get info from");
         }
         this.ShouldUpdate = true;
         SetIsDirty();
      }
      
      private function onConditionBodyLoadFailed(param1:IOErrorEvent) : *
      {
         // method body index: 3012 method index: 3012
         param1.target.removeEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
         trace("failed to load body: " + this.GetPathForCondition(this.CurrentlyShownCondition.bodyId));
         this.UnloadBody();
      }
      
      private function onConditionHeadLoadComplete(param1:Event) : *
      {
         // method body index: 3013 method index: 3013
         if(this.HeadLoader)
         {
            param1.target.removeEventListener(Event.COMPLETE,this.onConditionHeadLoadComplete);
            this.HeadClip = this.HeadLoader.contentLoaderInfo.content as MovieClip;
            this.HeadLoader = null;
         }
      }
   }
}
