 
package
{
   import Shared.AS3.BSButtonHintData;
   import flash.events.EventDispatcher;
   
   public class HUDFrobberButtonData extends EventDispatcher
   {
      
      public static const HOLD_TIME_DEFAULT:Number = // method body index: 630 method index: 630
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
         // method body index: 631 method index: 631
         super();
      }
      
      public function get canHold() : Boolean
      {
         // method body index: 632 method index: 632
         return this.m_CanHold;
      }
      
      public function get canTap() : Boolean
      {
         // method body index: 633 method index: 633
         return this.m_CanTap;
      }
      
      public function setInfo(param1:Boolean, param2:Object, param3:BSButtonHintData) : *
      {
         // method body index: 634 method index: 634
         if(param1)
         {
            this.m_HintDataHold = param3;
            this.m_CanHold = true;
            if(param2.holdDuration > 0)
            {
               this.m_HoldTime = param2.holdDuration;
            }
            else
            {
               this.m_HoldTime = HOLD_TIME_DEFAULT;
            }
         }
         else
         {
            this.m_CanTap = true;
            this.m_HintDataTap = param3;
         }
      }
      
      public function updateHoldPercent() : void
      {
         // method body index: 635 method index: 635
         if(this.m_CanHold)
         {
            this.m_HintDataHold.holdPercent = this.heldPercent;
         }
      }
      
      public function get heldPercent() : Number
      {
         // method body index: 636 method index: 636
         var _loc1_:Number = this.holdTimeElapsed;
         if(_loc1_ > 0)
         {
            return _loc1_ / this.m_HoldTime;
         }
         return 0;
      }
      
      public function get holdTimeElapsed() : Number
      {
         // method body index: 637 method index: 637
         var _loc1_:* = undefined;
         if(this.m_CanHold && this.m_IsHolding)
         {
            _loc1_ = new Date().getTime();
            return _loc1_ - this.m_HoldTimeStart;
         }
         return 0;
      }
      
      public function get holdTimeMet() : Boolean
      {
         // method body index: 638 method index: 638
         if(this.m_CanHold && this.m_IsHolding)
         {
            return this.holdTimeElapsed > this.m_HoldTime;
         }
         return false;
      }
      
      public function set isHolding(param1:Boolean) : void
      {
         // method body index: 639 method index: 639
         if(param1 != this.m_IsHolding)
         {
            if(param1)
            {
               this.m_HoldTimeStart = new Date().getTime();
            }
            else
            {
               this.m_HoldTimeStart = 0;
            }
         }
         this.m_IsHolding = param1;
      }
      
      public function get isHolding() : Boolean
      {
         // method body index: 640 method index: 640
         return this.m_IsHolding;
      }
   }
}
