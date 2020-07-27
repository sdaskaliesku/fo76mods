 
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
         // method body index: 714 method index: 714
         super();
      }
      
      public function get canHold() : Boolean
      {
         // method body index: 705 method index: 705
         return this.m_CanHold;
      }
      
      public function get canTap() : Boolean
      {
         // method body index: 706 method index: 706
         return this.m_CanTap;
      }
      
      public function setInfo(aHold:Boolean, aInfo:Object, aHintData:BSButtonHintData) : *
      {
         // method body index: 707 method index: 707
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
         // method body index: 708 method index: 708
         if(this.m_CanHold)
         {
            this.m_HintDataHold.holdPercent = this.heldPercent;
         }
      }
      
      public function get heldPercent() : Number
      {
         // method body index: 709 method index: 709
         var timeHeld:Number = this.holdTimeElapsed;
         if(timeHeld > 0)
         {
            return timeHeld / this.m_HoldTime;
         }
         return 0;
      }
      
      public function get holdTimeElapsed() : Number
      {
         // method body index: 710 method index: 710
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
         // method body index: 711 method index: 711
         if(this.m_CanHold && this.m_IsHolding)
         {
            return this.holdTimeElapsed > this.m_HoldTime;
         }
         return false;
      }
      
      public function set isHolding(aHolding:Boolean) : void
      {
         // method body index: 712 method index: 712
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
         // method body index: 713 method index: 713
         return this.m_IsHolding;
      }
   }
}
