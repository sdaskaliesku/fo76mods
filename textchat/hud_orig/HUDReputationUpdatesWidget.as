 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.Factions;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class HUDReputationUpdatesWidget extends MovieClip
   {
      
      public static const EVENT_LEVELUP_VISIBLE:String = // method body index: 2474 method index: 2474
      "Reputation::LevelUpVisible";
      
      public static const EVENT_HIDDEN:String = // method body index: 2474 method index: 2474
      "Reputation::LevelUpHidden";
      
      public static const EVENT_CHANGE_VISIBLE:String = // method body index: 2474 method index: 2474
      "Reputation::ChangeVisible";
      
      public static const EVENT_FADEOUT_END:String = // method body index: 2474 method index: 2474
      "Reputation::FadeOutEnd";
      
      public static const TEST_MODE:Boolean = // method body index: 2474 method index: 2474
      false;
      
      public static const EVENT_PULL:String = // method body index: 2474 method index: 2474
      "Reputation::Consume";
       
      
      public var ReputationMeter_mc:HUDReputationUpdateMeter;
      
      public var LevelUpAnimation_mc:MovieClip;
      
      private var m_IsBusy:Boolean = false;
      
      private var m_ReputationData:UIDataFromClient;
      
      private var m_LastUpdate:Object;
      
      private var m_CurUpdate:Object;
      
      private var m_LastFullyShown:Boolean = false;
      
      public function HUDReputationUpdatesWidget()
      {

         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(EVENT_FADEOUT_END,this.onFadeOutEnd);
         addEventListener(HUDReputationUpdateMeter.DISPLAY_COMPLETE,this.onDisplayComplete);
      }
      
      private function onDataUpdate(arEvent:FromClientDataEvent) : void
      {

         this.evaluateQueue();
      }
      
      private function evaluateQueue() : void
      {

         var updateArray:Array = null;
         if(!this.m_IsBusy)
         {
            updateArray = this.m_ReputationData.data.reputationDeltaArray;
            if(updateArray.length > 0)
            {
               if(this.m_LastFullyShown)
               {
                  if(this.m_CurUpdate != null && updateArray[0].uFactionID == this.m_CurUpdate.factionID && updateArray[0].uTierStart == updateArray[0].uTierEnd && this.m_CurUpdate.tierStart == this.m_CurUpdate.tierEnd)
                  {
                     this.animateUpdate(updateArray[0]);
                  }
                  else
                  {
                     this.m_IsBusy = true;
                     this.ReputationMeter_mc.fadeOut();
                  }
               }
               else
               {
                  this.animateUpdate(updateArray[0]);
               }
            }
            else if(this.m_LastFullyShown)
            {
               this.ReputationMeter_mc.fadeOut();
            }
         }
      }
      
      private function animateUpdate(aUpdate:Object) : void
      {

         var updateArray:Array = null;
         if(TEST_MODE)
         {
            updateArray = this.m_ReputationData.data.reputationDeltaArray;
            updateArray.shift();
         }
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PULL,{"uDeltaID":aUpdate.uDeltaID},true));
         this.m_IsBusy = true;
         this.m_LastUpdate = this.m_CurUpdate;
         var processedUpdate:Object = this.buildDeltaInfo(aUpdate);
         this.m_CurUpdate = processedUpdate;
         if(processedUpdate.tierStart != processedUpdate.tierEnd)
         {
            if(processedUpdate.tierEnd > processedUpdate.tierStart)
            {
               this.LevelUpAnimation_mc.RepLevelUpBoy_mc.gotoAndStop(processedUpdate.factionCode);
               this.LevelUpAnimation_mc.gotoAndPlay("rollOn");
               dispatchEvent(new Event(EVENT_LEVELUP_VISIBLE,true));
            }
            else
            {
               this.m_IsBusy = false;
            }
         }
         else
         {
            if(!this.m_LastFullyShown)
            {
               this.ReputationMeter_mc.fadeIn();
               dispatchEvent(new Event(EVENT_CHANGE_VISIBLE,true));
            }
            this.ReputationMeter_mc.data = processedUpdate;
         }
      }
      
      public function buildDeltaInfo(aUpdate:Object) : Object
      {

         var curFaction:Object = null;
         var curName:String = null;
         var curRep:int = 0;
         var deltaInfo:Object = {};
         var factionNames:Array = ["Crater","Foundation"];
         for(var factionIndex:uint = 0; factionIndex < factionNames.length; factionIndex++)
         {
            curName = factionNames[factionIndex];
            curFaction = this.m_ReputationData.data["factionData" + curName];
            if(aUpdate.uFactionID == curFaction.uFactionID)
            {
               deltaInfo.factionID = curFaction.uFactionID;
               deltaInfo.factionName = curFaction.szFactionName;
               deltaInfo.factionCode = curName;
               deltaInfo.tierInfo = curFaction.reputationTiers;
               break;
            }
         }
         deltaInfo.tierStart = aUpdate.uTierStart;
         deltaInfo.tierEnd = aUpdate.uTierEnd;
         deltaInfo.percentStart = Factions.getNextReputationTierPercent(aUpdate.fAmountStart,aUpdate.uTierStart,curFaction.reputationTiers);
         if(aUpdate.uTierStart == aUpdate.uTierEnd)
         {
            deltaInfo.percentEnd = Factions.getNextReputationTierPercent(aUpdate.fAmountEnd,aUpdate.uTierStart,curFaction.reputationTiers);
         }
         else
         {
            deltaInfo.percentEnd = deltaInfo.percentStart;
         }
         return deltaInfo;
      }
      
      private function onAddedToStage(e:Event) : void
      {

         BSUIDataManager.Subscribe("ReputationData",this.onDataUpdate,TEST_MODE);
         this.m_ReputationData = BSUIDataManager.GetDataFromClient("ReputationData");
      }
      
      public function onDisplayComplete(aEvent:Event = null) : void
      {

         this.m_LastFullyShown = true;
         this.m_IsBusy = false;
         this.evaluateQueue();
      }
      
      public function onFadeOutEnd(aEvent:Event) : void
      {

         dispatchEvent(new Event(EVENT_HIDDEN,true));
         this.m_LastFullyShown = false;
         this.m_IsBusy = false;
         this.evaluateQueue();
      }
   }
}
