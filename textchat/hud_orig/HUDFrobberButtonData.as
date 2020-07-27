 
package
{
   import Shared.AS3.BSButtonHintData;
   import flash.events.EventDispatcher;
   
   public class HUDFrobberButtonData extends EventDispatcher
   {
      
      public static const HOLD_TIME_DEFAULT:Number = // method body index: 704 method index: 704
      250;
       
      
      private var m_HoldTimeStart:Number = 0;
      
      private var m_HoldTime:Number = 250;
      
      private var m_IsHolding:Boolean = false;
      
      private var m_CanHold:Boolean = false;
      
      private var m_CanTap:Boolean = false;
      
      private var m_Data:Object;
      
      private var m_HintDataHold:BSButtonHintData;
      
      private var m_HintDataTap:BSButtonHintData;
      
      public function HUDFrobberButtonData()
      {

         super();
      }
      
      public function get canHold() : Boolean
      {

         return this.m_CanHold;
      }
      
      public function get canTap() : Boolean
      {

         return this.m_CanTap;
      }
      
      public function setInfo(aHold:Boolean, aInfo:Object, aHintData:BSButtonHintData) : *
      {

         if(aHold)
         {
            this.m_HintDataHold = aHintData;
            this.m_CanHold = true;
            if(aInfo.holdDuration > 0)
            {
               this.m_HoldTime = aInfo.holdDuration;
            }
            else
            {
               this.m_HoldTime = HOLD_TIME_DEFAULT;
            }
         }
         else
         {
            this.m_CanTap = true;
            this.m_HintDataTap = aHintData;
         }
      }
      
      public function updateHoldPercent() : void
      {

         if(this.m_CanHold)
         {
            this.m_HintDataHold.holdPercent = this.heldPercent;
         }
      }
      
      public function get heldPercent() : Number
      {

         var timeHeld:Number = this.holdTimeElapsed;
         if(timeHeld > 0)
         {
            return timeHeld / this.m_HoldTime;
         }
         return 0;
      }
      
      public function get holdTimeElapsed() : Number
      {

         var curTime:* = undefined;
         if(this.m_CanHold && this.m_IsHolding)
         {
            curTime = new Date().getTime();
            return curTime - this.m_HoldTimeStart;
         }
         return 0;
      }
      
      public function get holdTimeMet() : Boolean
      {

         if(this.m_CanHold && this.m_IsHolding)
         {
            return this.holdTimeElapsed > this.m_HoldTime;
         }
         return false;
      }
      
      public function set isHolding(aHolding:Boolean) : void
      {

         if(aHolding != this.m_IsHolding)
         {
            if(aHolding)
            {
               this.m_HoldTimeStart = new Date().getTime();
            }
            else
            {
               this.m_HoldTimeStart = 0;
            }
         }
         this.m_IsHolding = aHolding;
      }
      
      public function get isHolding() : Boolean
      {

         return this.m_IsHolding;
      }
   }
}
