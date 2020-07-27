 
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
      
      private static const CONDITION_DISPLAY_TIME:uint = // method body index: 3044 method index: 3044
      5000;
      
      private static const CLIP_BODY_TEMPLATE_PATH:String = // method body index: 3044 method index: 3044
      "Components/ConditionClips/Condition_Body_";
      
      private static const CLIP_BODY_HUNGER_ID:int = // method body index: 3044 method index: 3044
      16;
      
      private static const CLIP_BODY_THIRST_ID:int = // method body index: 3044 method index: 3044
      18;
      
      private static const CLIP_BODY_DISEASE_ID:int = // method body index: 3044 method index: 3044
      17;
      
      private static const CLIP_BODY_MUTATION_ID:int = // method body index: 3044 method index: 3044
      19;
      
      private static const NUM_BODY_CLIPS:int = // method body index: 3044 method index: 3044
      20;
      
      private static const HEAD_NORMAL_FRAME:uint = // method body index: 3044 method index: 3044
      1;
      
      private static const HEAD_GENERAL_NEGATIVE_FRAME:uint = // method body index: 3044 method index: 3044
      4;
      
      private static const HEAD_GENERAL_NEGATIVE_DAMAGED_FRAME:uint = // method body index: 3044 method index: 3044
      33;
      
      private static const HEAD_DRUGGED_FRAME:uint = // method body index: 3044 method index: 3044
      5;
      
      private static const HEAD_DRUGGED_DAMAGED_FRAME:uint = // method body index: 3044 method index: 3044
      37;
      
      private static const HEAD_IRRADIATED_FRAME:uint = // method body index: 3044 method index: 3044
      17;
      
      private static const HEAD_IRRADIATED_DAMAGED_FRAME:uint = // method body index: 3044 method index: 3044
      49;
      
      private static const HEAD_DISEASED_FRAME:uint = // method body index: 3044 method index: 3044
      65;
      
      private static const HEAD_DISEASED_DAMAGED_FRAME:uint = // method body index: 3044 method index: 3044
      67;
      
      private static const HEAD_MUTATED_FRAME:uint = // method body index: 3044 method index: 3044
      71;
      
      private static const HEAD_MUTATED_DAMAGED_FRAME:uint = // method body index: 3044 method index: 3044
      76;
      
      private static const HEAD_HUNGER_FRAME:uint = // method body index: 3044 method index: 3044
      HEAD_DRUGGED_FRAME;
      
      private static const HEAD_THIRST_FRAME:uint = // method body index: 3044 method index: 3044
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
         // method body index: 3048 method index: 3048
         this.ColorFileText = new String();
         this.PrimaryCondition = {};
         this.SecondaryConditions = new Vector.<Object>();
         this.CurrentlyShownCondition = {};
         super();
         this.LoadHead();
      }
      
      public function set monochrome(abSingleColor:Boolean) : *
      {
         // method body index: 3045 method index: 3045
      }
      
      public function get monochrome() : *
      {
         // method body index: 3046 method index: 3046
         return this.Monochrome;
      }
      
      public function set isMenuInstance(aIsMenuInstance:Boolean) : *
      {
         // method body index: 3047 method index: 3047
         this.IsMenuInstance = aIsMenuInstance;
      }
      
      public function PreloadConditions() : *
      {
         // method body index: 3049 method index: 3049
         var id:* = undefined;
         var cachedBodyLoader:PipboyLoader = null;
         var bodyLoadRequest:URLRequest = null;
         if(!this.PreloadedBodyClips)
         {
            this.PreloadedBodyClips = new Vector.<PipboyLoader>(NUM_BODY_CLIPS,true);
            for(id in this.PreloadedBodyClips)
            {
               cachedBodyLoader = new PipboyLoader();
               this.PreloadedBodyClips[id] = cachedBodyLoader;
               bodyLoadRequest = new URLRequest(this.GetPathForCondition(id));
               cachedBodyLoader.load(bodyLoadRequest);
            }
         }
      }
      
      private function GetPathForCondition(aBodyId:int) : *
      {
         // method body index: 3050 method index: 3050
         return CLIP_BODY_TEMPLATE_PATH + this.ColorFileText + aBodyId + ".swf";
      }
      
      public function SetData(data:Object) : *
      {
         // method body index: 3051 method index: 3051
         this.UpdatePrimaryCondition(data);
         if(!this.IsMenuInstance)
         {
            this.UpdateSecondaryConditions(data);
         }
         if(this.IsReadyForNextCondition)
         {
            this.ShowNextCondition();
         }
      }
      
      private function UpdatePrimaryCondition(data:Object) : *
      {
         // method body index: 3052 method index: 3052
         var isHeadDamaged:Boolean = data.isHeadDamaged;
         var headFrame:uint = HEAD_NORMAL_FRAME;
         if(data.isIrradiated)
         {
            headFrame = !!isHeadDamaged?uint(HEAD_IRRADIATED_DAMAGED_FRAME):uint(HEAD_IRRADIATED_FRAME);
         }
         else if(data.isDrugged)
         {
            headFrame = !!isHeadDamaged?uint(HEAD_DRUGGED_DAMAGED_FRAME):uint(HEAD_DRUGGED_FRAME);
         }
         else if(data.isAddicted || isHeadDamaged || data.bodyFlags != 0)
         {
            headFrame = !!isHeadDamaged?uint(HEAD_GENERAL_NEGATIVE_DAMAGED_FRAME):uint(HEAD_GENERAL_NEGATIVE_FRAME);
         }
         this.PrimaryCondition.isPersistent = isHeadDamaged || data.bodyFlags != 0;
         if(this.PrimaryCondition.headFrame != headFrame || this.PrimaryCondition.bodyId != data.bodyFlags)
         {
            this.PrimaryCondition.headFrame = headFrame;
            this.PrimaryCondition.bodyId = data.bodyFlags;
            this.PrimaryConditionChanged = true;
         }
      }
      
      private function UpdateSecondaryConditions(data:Object) : *
      {
         // method body index: 3053 method index: 3053
         var isHeadDamaged:Boolean = data.isHeadDamaged;
         if(!this.IsMutated && data.isMutated)
         {
            this.SecondaryConditions.push({
               "headFrame":(!!isHeadDamaged?HEAD_MUTATED_DAMAGED_FRAME:HEAD_MUTATED_FRAME),
               "bodyId":CLIP_BODY_MUTATION_ID
            });
         }
         this.IsMutated = data.isMutated;
         if(!this.IsDiseased && data.isDiseased)
         {
            this.SecondaryConditions.push({
               "headFrame":(!!isHeadDamaged?HEAD_DISEASED_DAMAGED_FRAME:HEAD_DISEASED_FRAME),
               "bodyId":CLIP_BODY_DISEASE_ID
            });
         }
         this.IsDiseased = data.isDiseased;
         if(data.isThirstStateNegative && !this.IsThirstStateNegative)
         {
            this.SecondaryConditions.push({
               "headFrame":HEAD_THIRST_FRAME,
               "bodyId":CLIP_BODY_THIRST_ID
            });
         }
         this.IsThirstStateNegative = data.isThirstStateNegative;
         if(data.isHungerStateNegative && !this.IsHungerStateNegative)
         {
            this.SecondaryConditions.push({
               "headFrame":HEAD_HUNGER_FRAME,
               "bodyId":CLIP_BODY_HUNGER_ID
            });
         }
         this.IsHungerStateNegative = data.isHungerStateNegative;
      }
      
      private function ShowNextCondition() : *
      {
         // method body index: 3054 method index: 3054
         var showingPersistentCondition:Boolean = false;
         var bodyLoadRequest:URLRequest = null;
         var conditionData:Object = null;
         if(this.SecondaryConditions.length > 0)
         {
            conditionData = this.SecondaryConditions.pop();
         }
         else if(this.PrimaryConditionChanged || this.PrimaryCondition.isPersistent)
         {
            conditionData = this.PrimaryCondition;
            this.PrimaryConditionChanged = false;
         }
         if(conditionData)
         {
            showingPersistentCondition = this.IsShowingCondition(conditionData) && conditionData.isPersistent;
            if(!showingPersistentCondition)
            {
               this.UnloadBody();
               this.CurrentlyShownCondition.headFrame = conditionData.headFrame;
               this.CurrentlyShownCondition.bodyId = conditionData.bodyId;
               if(this.PreloadedBodyClips != null)
               {
                  this.onConditionBodyLoadComplete(null);
               }
               else
               {
                  this.BodyLoader = new PipboyLoader();
                  this.BodyLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
                  this.BodyLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
                  bodyLoadRequest = new URLRequest(this.GetPathForCondition(conditionData.bodyId));
                  this.BodyLoader.load(bodyLoadRequest);
               }
            }
         }
         else if(!this.IsMenuInstance)
         {
            visible = false;
            this.UnloadBody();
         }
      }
      
      private function IsShowingCondition(conditionData:Object) : *
      {
         // method body index: 3055 method index: 3055
         return conditionData && this.CurrentlyShownCondition && conditionData.headFrame == this.CurrentlyShownCondition.headFrame && conditionData.bodyId == this.CurrentlyShownCondition.bodyId;
      }
      
      private function LoadHead() : *
      {
         // method body index: 3056 method index: 3056
         if(this.HeadLoader)
         {
            this.HeadLoader.unloadAndStop();
         }
         this.HeadLoader = new PipboyLoader();
         var loadRequest:URLRequest = new URLRequest(!!this.monochrome?"Components/ConditionClips/Condition_Head_Mono.swf":"Components/ConditionClips/Condition_Head.swf");
         this.HeadLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onConditionHeadLoadComplete);
         this.HeadLoader.load(loadRequest);
      }
      
      private function UnloadBody() : *
      {
         // method body index: 3057 method index: 3057
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
         // method body index: 3059 method index: 3059
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
               setTimeout(function():// method body index: 3058 method index: 3058
               void
               {
                  // method body index: 3058 method index: 3058
                  IsReadyForNextCondition = true;
                  ShowNextCondition();
               },CONDITION_DISPLAY_TIME);
            }
         }
      }
      
      private function onConditionBodyLoadComplete(loadCompleteEvent:Event) : *
      {
         // method body index: 3060 method index: 3060
         if(this.BodyLoader)
         {
            loadCompleteEvent.target.removeEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
            loadCompleteEvent.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
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
      
      private function onConditionBodyLoadFailed(event:IOErrorEvent) : *
      {
         // method body index: 3061 method index: 3061
         event.target.removeEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
         trace("failed to load body: " + this.GetPathForCondition(this.CurrentlyShownCondition.bodyId));
         this.UnloadBody();
      }
      
      private function onConditionHeadLoadComplete(loadCompleteEvent:Event) : *
      {
         // method body index: 3062 method index: 3062
         if(this.HeadLoader)
         {
            loadCompleteEvent.target.removeEventListener(Event.COMPLETE,this.onConditionHeadLoadComplete);
            this.HeadClip = this.HeadLoader.contentLoaderInfo.content as MovieClip;
            this.HeadLoader = null;
         }
      }
   }
}
