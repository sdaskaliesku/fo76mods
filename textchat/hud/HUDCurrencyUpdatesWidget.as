 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.SWFLoaderClip;
   import Shared.AS3.SecureTradeShared;
   import Shared.GlobalFunc;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class HUDCurrencyUpdatesWidget extends MovieClip
   {
      
      public static const FRAME_BEGIN:String = // method body index: 857 method index: 857
      "rollOn";
      
      public static const FRAME_ROLL:String = // method body index: 857 method index: 857
      "rollNumber";
      
      public static const FRAME_FADEOUT:String = // method body index: 857 method index: 857
      "rollOut";
      
      public static const TYPE_GENERIC:uint = // method body index: 857 method index: 857
      0;
      
      public static const TYPE_KILL:uint = // method body index: 857 method index: 857
      1;
      
      public static const BREAKDOWN_LINES:uint = // method body index: 857 method index: 857
      3;
      
      public static const EVENT_PULL:String = // method body index: 857 method index: 857
      "Currency::DiscardTransaction";
       
      
      public var CurrencyIcon_mc:SWFLoaderClip;
      
      public var CurrencyChange_mc:MovieClip;
      
      public var CurrencyBase_mc:MovieClip;
      
      public var Breakdown_mc:MovieClip;
      
      private var m_IsBusy:Boolean = false;
      
      private var m_Transactions:UIDataFromClient;
      
      private var m_CurTransaction:Object;
      
      private var m_CurrencyIconInstance:MovieClip;
      
      private var m_RollAnimStart:int = 0;
      
      private var m_RollAnimEnd:int = 1;
      
      public function HUDCurrencyUpdatesWidget()
      {

         super();
         addFrameScript(0,this.frame1,38,this.frame39,50,this.frame51,58,this.frame59,68,this.frame69);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.CurrencyIcon_mc.clipWidth = this.CurrencyIcon_mc.width * (1 / this.CurrencyIcon_mc.scaleX);
         this.CurrencyIcon_mc.clipHeight = this.CurrencyIcon_mc.height * (1 / this.CurrencyIcon_mc.scaleY);
      }
      
      private function onDataUpdate(param1:FromClientDataEvent) : void
      {

         this.evaluateQueue();
      }
      
      private function evaluateQueue() : void
      {

         var _loc1_:Array = null;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:MergedTransaction = null;
         if(!this.m_IsBusy)
         {
            _loc1_ = this.m_Transactions.data.currencyTransactions;
            if(_loc1_.length > 0)
            {
               _loc2_ = _loc1_[0];
               _loc3_ = _loc2_.currencyType;
               _loc4_ = _loc2_.currencyID;
               if(_loc2_.type == TYPE_KILL)
               {
                  this.animateTransaction(_loc2_);
                  GlobalFunc.BSASSERT(_loc2_.transactionID >= 0,"Invalid caps transaction ID, " + _loc2_.transactionID);
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PULL,{
                     "currencyID":_loc2_.currencyID,
                     "transactionID":_loc2_.transactionID
                  }));
               }
               else
               {
                  _loc5_ = new MergedTransaction();
                  _loc5_.currencyType = _loc3_;
                  for each(_loc2_ in _loc1_)
                  {
                     GlobalFunc.BSASSERT(_loc2_.transactionID >= 0,"Invalid currency transaction ID, " + _loc2_.transactionID);
                     if(_loc2_.type == TYPE_KILL)
                     {
                        break;
                     }
                     if(_loc4_ != _loc2_.currencyID)
                     {
                        break;
                     }
                     _loc5_.Merge(_loc2_);
                     BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PULL,{
                        "currencyID":_loc2_.currencyID,
                        "transactionID":_loc2_.transactionID
                     }));
                  }
                  this.animateTransaction(_loc5_);
               }
            }
         }
      }
      
      private function animateTransaction(param1:Object) : void
      {

         this.m_IsBusy = true;
         this.m_CurTransaction = param1;
         if(this.m_CurrencyIconInstance != null)
         {
            this.CurrencyIcon_mc.removeChild(this.m_CurrencyIconInstance);
            this.m_CurrencyIconInstance = null;
         }
         this.m_CurrencyIconInstance = SecureTradeShared.setCurrencyIcon(this.CurrencyIcon_mc,param1.currencyType,true);
         if(!param1.isMaxStart || !param1.isMaxEnd)
         {
            this.CurrencyChange_mc.CurrencyChange_tf.text = Math.abs(param1.currencyChange);
            if(param1.currencyChange > 0)
            {
               this.CurrencyChange_mc.Sign_tf.text = "+";
            }
            else
            {
               this.CurrencyChange_mc.Sign_tf.text = "-";
            }
            this.CurrencyBase_mc.CurrencyBase_tf.text = param1.startingAmount;
            this.CurrencyChange_mc.visible = true;
         }
         else
         {
            this.CurrencyBase_mc.CurrencyBase_tf.text = "$Max";
            this.CurrencyChange_mc.visible = false;
         }
         gotoAndPlay(FRAME_BEGIN);
         GlobalFunc.PlayMenuSound("UICapsAppear");
         var _loc2_:uint = 0;
         if(param1.type == TYPE_KILL)
         {
            this.Breakdown_mc.Header_mc.Header_tf.text = param1.headerText;
            _loc2_ = 0;
            while(_loc2_ < BREAKDOWN_LINES)
            {
               if(param1.details[_loc2_] != null)
               {
                  this.Breakdown_mc["Detail" + _loc2_ + "_mc"].Label_tf.text = param1.details[_loc2_].label;
                  this.Breakdown_mc["Detail" + _loc2_ + "_mc"].Value_tf.text = param1.details[_loc2_].value;
               }
               else
               {
                  this.Breakdown_mc["Detail" + _loc2_ + "_mc"].Label_tf.text = "";
                  this.Breakdown_mc["Detail" + _loc2_ + "_mc"].Value_tf.text = "";
               }
               _loc2_++;
            }
            this.Breakdown_mc.gotoAndPlay(FRAME_BEGIN);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < BREAKDOWN_LINES)
            {
               this.Breakdown_mc["Detail" + _loc2_ + "_mc"].Label_tf.text = "";
               this.Breakdown_mc["Detail" + _loc2_ + "_mc"].Value_tf.text = "";
               _loc2_++;
            }
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {

         var _loc2_:FrameLabel = null;
         this.m_Transactions = BSUIDataManager.GetDataFromClient("CurrencyData");
         var _loc3_:uint = 0;
         while(_loc3_ < currentLabels.length)
         {
            _loc2_ = currentLabels[_loc3_];
            if(_loc2_.name == FRAME_ROLL)
            {
               this.m_RollAnimStart = _loc2_.frame;
            }
            else if(_loc2_.name == FRAME_FADEOUT)
            {
               this.m_RollAnimEnd = _loc2_.frame;
            }
            _loc3_++;
         }
         BSUIDataManager.Subscribe("CurrencyData",this.onDataUpdate);
      }
      
      private function rollAnimationUpdate(param1:Event) : *
      {

         var _loc2_:Number = NaN;
         if(this.m_CurTransaction != null)
         {
            if(!this.m_CurTransaction.isMaxEnd)
            {
               _loc2_ = Math.floor(this.m_CurTransaction.startingAmount + this.m_CurTransaction.currencyChange * ((currentFrame - this.m_RollAnimStart) / (this.m_RollAnimEnd - this.m_RollAnimStart)));
               this.CurrencyBase_mc.CurrencyBase_tf.text = String(_loc2_);
            }
            else
            {
               this.CurrencyBase_mc.CurrencyBase_tf.text = "$Max";
            }
         }
      }
      
      public function onNewCapsFadeOut() : void
      {

         GlobalFunc.PlayMenuSound("UICapsDisappear");
      }
      
      public function onBeginRollAnimation() : void
      {

         addEventListener(Event.ENTER_FRAME,this.rollAnimationUpdate);
      }
      
      public function onFadeout() : void
      {

         removeEventListener(Event.ENTER_FRAME,this.rollAnimationUpdate);
         if(!this.m_CurTransaction.isMaxEnd)
         {
            this.CurrencyBase_mc.CurrencyBase_tf.text = this.m_CurTransaction.startingAmount + this.m_CurTransaction.currencyChange;
         }
         else
         {
            this.CurrencyBase_mc.CurrencyBase_tf.text = "$Max";
         }
         if(this.m_CurTransaction.type == TYPE_KILL)
         {
            this.Breakdown_mc.gotoAndPlay(FRAME_FADEOUT);
         }
      }
      
      public function onAnimEnd() : void
      {

         this.m_IsBusy = false;
         this.evaluateQueue();
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame39() : *
      {

         this.onNewCapsFadeOut();
      }
      
      function frame51() : *
      {

         this.onBeginRollAnimation();
      }
      
      function frame59() : *
      {

         this.onFadeout();
      }
      
      function frame69() : *
      {

         stop();
         this.onAnimEnd();
      }
   }
}

class MergedTransaction
{
    
   
   public var isMaxStart:Boolean = false;
   
   public var isMaxEnd:Boolean = false;
   
   public var currencyChange:int = 0;
   
   public var startingAmount:int = 2147483647;
   
   public var currencyType:uint = 0;
   
   public var currencyID:uint = 0;
   
   function MergedTransaction()
   {
      // method body index: 874 method index: 874
      super();
   }
   
   public function Transaction(param1:Object) : *
   {
      // method body index: 875 method index: 875
      this.Merge(param1);
   }
   
   public function Merge(param1:Object) : *
   {
      // method body index: 876 method index: 876
      this.isMaxStart = this.isMaxStart || param1.isMaxStart;
      this.isMaxEnd = this.isMaxEnd || param1.isMaxEnd;
      this.currencyChange = this.currencyChange + param1.currencyChange;
      this.startingAmount = Math.min(this.startingAmount,param1.startingAmount);
   }
}
