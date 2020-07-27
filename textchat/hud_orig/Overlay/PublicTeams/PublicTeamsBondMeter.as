 
package Overlay.PublicTeams
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PublicTeamsBondMeter extends MovieClip
   {
      
      public static var TIME_TO_FULL_BOND:Number;
      
      public static var LAST_BOND_UPDATE_TIME:Number;
      
      public static const BOND_METER_OFF:uint = // method body index: 2559 method index: 2559
      0;
      
      public static const BOND_METER_PAUSED:uint = // method body index: 2559 method index: 2559
      1;
      
      public static const BOND_METER_FILLING:uint = // method body index: 2559 method index: 2559
      2;
      
      public static const BOND_METER_COMPLETE:uint = // method body index: 2559 method index: 2559
      3;
      
      public static const EVENT_BOND_METER_COMPLETE = // method body index: 2559 method index: 2559
      "EventBondMeterComplete";
       
      
      public var BondIcon_mc:MovieClip;
      
      public var BondMeterFill_mc:MovieClip;
      
      public var BondMeterAnim_mc:MovieClip;
      
      public var BondMeterFrameBonded_mc:MovieClip;
      
      public var BondMeterCompleteAnim_mc:MovieClip;
      
      private var m_StartTime:Number = 0;
      
      private var m_BondMeterState:int = -1;
      
      public function PublicTeamsBondMeter()
      {

         super();
         if(isNaN(TIME_TO_FULL_BOND))
         {
            TIME_TO_FULL_BOND = 300;
         }
         if(isNaN(LAST_BOND_UPDATE_TIME))
         {
            LAST_BOND_UPDATE_TIME = 0;
         }
         BSUIDataManager.Subscribe(PublicTeamsShared.EVENT_PUBLIC_TEAMS_DATA,this.onPublicTeamsDataUpdate);
         this.bondMeterState = BOND_METER_OFF;
      }
      
      public function get bondMeterState() : int
      {

         return this.m_BondMeterState;
      }
      
      public function set bondMeterState(aState:int) : void
      {

         this.m_BondMeterState = aState;
         switch(aState)
         {
            case BOND_METER_OFF:
               this.BondIcon_mc.visible = false;
               this.BondMeterAnim_mc.gotoAndStop(1);
               this.setBondFillProgress(0);
               this.BondMeterFrameBonded_mc.visible = false;
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               break;
            case BOND_METER_PAUSED:
               this.BondIcon_mc.visible = false;
               this.BondMeterAnim_mc.gotoAndStop(1);
               this.setBondFillProgress(this.m_StartTime);
               this.BondMeterFrameBonded_mc.visible = false;
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               break;
            case BOND_METER_FILLING:
               this.BondIcon_mc.visible = false;
               this.BondMeterAnim_mc.gotoAndPlay(1);
               this.setBondFillProgress(this.elapsedTime);
               this.BondMeterFrameBonded_mc.visible = false;
               addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               break;
            case BOND_METER_COMPLETE:
               this.BondIcon_mc.visible = true;
               this.BondMeterAnim_mc.gotoAndStop(1);
               this.setBondFillProgress(this.elapsedTime);
               this.BondMeterFrameBonded_mc.visible = true;
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               dispatchEvent(new Event(EVENT_BOND_METER_COMPLETE,true,true));
         }
      }
      
      public function get elapsedTime() : Number
      {

         var deltaTime:Number = 0;
         if(LAST_BOND_UPDATE_TIME)
         {
            deltaTime = new Date().getTime() / 1000 - LAST_BOND_UPDATE_TIME;
         }
         return this.m_StartTime + deltaTime;
      }
      
      public function get isBonded() : Boolean
      {

         return this.bondMeterState == BOND_METER_COMPLETE;
      }
      
      public function resetBondMeter() : void
      {

         this.bondMeterState = BOND_METER_OFF;
      }
      
      public function startBondMeter(aStartTime:Number, aIsPaused:Boolean = false) : void
      {

         this.m_StartTime = aStartTime;
         if(this.m_StartTime >= 0)
         {
            if(aIsPaused)
            {
               if(this.m_StartTime >= TIME_TO_FULL_BOND)
               {
                  this.bondMeterState = BOND_METER_COMPLETE;
               }
               else
               {
                  this.bondMeterState = BOND_METER_PAUSED;
               }
            }
            else if(this.elapsedTime >= TIME_TO_FULL_BOND)
            {
               this.bondMeterState = BOND_METER_COMPLETE;
            }
            else
            {
               this.bondMeterState = BOND_METER_FILLING;
            }
         }
         else
         {
            this.bondMeterState = BOND_METER_OFF;
         }
      }
      
      private function setBondFillProgress(aTimeElapsed:Number) : void
      {

         var fillFrame:uint = 0;
         if(aTimeElapsed <= 0)
         {
            this.BondMeterFill_mc.gotoAndStop(1);
         }
         else if(aTimeElapsed <= TIME_TO_FULL_BOND)
         {
            fillFrame = this.BondMeterFill_mc.totalFrames * (aTimeElapsed / TIME_TO_FULL_BOND);
            this.BondMeterFill_mc.gotoAndStop(fillFrame);
         }
         else
         {
            this.BondMeterFill_mc.gotoAndStop(this.BondMeterFill_mc.totalFrames);
         }
      }
      
      private function onEnterFrame(aEvent:Event = null) : void
      {

         if(this.bondMeterState == BOND_METER_FILLING)
         {
            this.setBondFillProgress(this.elapsedTime);
            if(this.elapsedTime >= TIME_TO_FULL_BOND)
            {
               this.BondMeterCompleteAnim_mc.gotoAndPlay("complete");
               GlobalFunc.PlayMenuSound("UIMenuSocialTeamBonded");
               this.bondMeterState = BOND_METER_COMPLETE;
            }
         }
      }
      
      private function onPublicTeamsDataUpdate(aEvent:FromClientDataEvent) : void
      {

         if(aEvent && aEvent.data && aEvent.data.requiredBondTime)
         {
            TIME_TO_FULL_BOND = aEvent.data.requiredBondTime;
         }
      }
   }
}
