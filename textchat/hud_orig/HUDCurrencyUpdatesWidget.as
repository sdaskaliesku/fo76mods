 
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
      
      public static const FRAME_BEGIN:String = // method body index: 931 method index: 931
      "rollOn";
      
      public static const FRAME_ROLL:String = // method body index: 931 method index: 931
      "rollNumber";
      
      public static const FRAME_FADEOUT:String = // method body index: 931 method index: 931
      "rollOut";
      
      public static const TYPE_GENERIC:uint = // method body index: 931 method index: 931
      0;
      
      public static const TYPE_KILL:uint = // method body index: 931 method index: 931
      1;
      
      public static const BREAKDOWN_LINES:uint = // method body index: 931 method index: 931
      3;
      
      public static const EVENT_PULL:String = // method body index: 931 method index: 931
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
      
      private function onDataUpdate(arEvent:FromClientDataEvent) : void
      {

         this.evaluateQueue();
      }
      
      private function evaluateQueue() : void
      {

         var transactionArray:Array = null;
         var transaction:Object = null;
         var currencyType:uint = 0;
         var currencyID:uint = 0;
         var mergedTransaction:MergedTransaction = null;
         if(!this.m_IsBusy)
         {
            transactionArray = this.m_Transactions.data.currencyTransactions;
            if(transactionArray.length > 0)
            {
               transaction = transactionArray[0];
               currencyType = transaction.currencyType;
               currencyID = transaction.currencyID;
               if(transaction.type == TYPE_KILL)
               {
                  this.animateTransaction(transaction);
                  GlobalFunc.BSASSERT(transaction.transactionID >= 0,"Invalid caps transaction ID, " + transaction.transactionID);
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PULL,{
                     "currencyID":transaction.currencyID,
                     "transactionID":transaction.transactionID
                  }));
               }
               else
               {
                  mergedTransaction = new MergedTransaction();
                  mergedTransaction.currencyType = currencyType;
                  for each(transaction in transactionArray)
                  {
                     GlobalFunc.BSASSERT(transaction.transactionID >= 0,"Invalid currency transaction ID, " + transaction.transactionID);
                     if(transaction.type == TYPE_KILL)
                     {
                        break;
                     }
                     if(currencyID != transaction.currencyID)
                     {
                        break;
                     }
                     mergedTransaction.Merge(transaction);
                     BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PULL,{
                        "currencyID":transaction.currencyID,
                        "transactionID":transaction.transactionID
                     }));
                  }
                  this.animateTransaction(mergedTransaction);
               }
            }
         }
      }
      
      private function animateTransaction(aTransaction:Object) : void
      {

         this.m_IsBusy = true;
         this.m_CurTransaction = aTransaction;
         if(this.m_CurrencyIconInstance != null)
         {
            this.CurrencyIcon_mc.removeChild(this.m_CurrencyIconInstance);
            this.m_CurrencyIconInstance = null;
         }
         this.m_CurrencyIconInstance = SecureTradeShared.setCurrencyIcon(this.CurrencyIcon_mc,aTransaction.currencyType,true);
         if(!aTransaction.isMaxStart || !aTransaction.isMaxEnd)
         {
            this.CurrencyChange_mc.CurrencyChange_tf.text = Math.abs(aTransaction.currencyChange);
            if(aTransaction.currencyChange > 0)
            {
               this.CurrencyChange_mc.Sign_tf.text = "+";
            }
            else
            {
               this.CurrencyChange_mc.Sign_tf.text = "-";
            }
            this.CurrencyBase_mc.CurrencyBase_tf.text = aTransaction.startingAmount;
            this.CurrencyChange_mc.visible = true;
         }
         else
         {
            this.CurrencyBase_mc.CurrencyBase_tf.text = "$Max";
            this.CurrencyChange_mc.visible = false;
         }
         gotoAndPlay(FRAME_BEGIN);
         GlobalFunc.PlayMenuSound("UICapsAppear");
         var i:uint = 0;
         if(aTransaction.type == TYPE_KILL)
         {
            this.Breakdown_mc.Header_mc.Header_tf.text = aTransaction.headerText;
            for(i = 0; i < BREAKDOWN_LINES; i++)
            {
               if(aTransaction.details[i] != null)
               {
                  this.Breakdown_mc["Detail" + i + "_mc"].Label_tf.text = aTransaction.details[i].label;
                  this.Breakdown_mc["Detail" + i + "_mc"].Value_tf.text = aTransaction.details[i].value;
               }
               else
               {
                  this.Breakdown_mc["Detail" + i + "_mc"].Label_tf.text = "";
                  this.Breakdown_mc["Detail" + i + "_mc"].Value_tf.text = "";
               }
            }
            this.Breakdown_mc.gotoAndPlay(FRAME_BEGIN);
         }
         else
         {
            for(i = 0; i < BREAKDOWN_LINES; i++)
            {
               this.Breakdown_mc["Detail" + i + "_mc"].Label_tf.text = "";
               this.Breakdown_mc["Detail" + i + "_mc"].Value_tf.text = "";
            }
         }
      }
      
      private function onAddedToStage(e:Event) : void
      {

         var checkFrame:FrameLabel = null;
         this.m_Transactions = BSUIDataManager.GetDataFromClient("CurrencyData");
         for(var i:uint = 0; i < currentLabels.length; i++)
         {
            checkFrame = currentLabels[i];
            if(checkFrame.name == FRAME_ROLL)
            {
               this.m_RollAnimStart = checkFrame.frame;
            }
            else if(checkFrame.name == FRAME_FADEOUT)
            {
               this.m_RollAnimEnd = checkFrame.frame;
            }
         }
         BSUIDataManager.Subscribe("CurrencyData",this.onDataUpdate);
      }
      
      private function rollAnimationUpdate(e:Event) : *
      {

         var newValue:Number = NaN;
         if(this.m_CurTransaction != null)
         {
            if(!this.m_CurTransaction.isMaxEnd)
            {
               newValue = Math.floor(this.m_CurTransaction.startingAmount + this.m_CurTransaction.currencyChange * ((currentFrame - this.m_RollAnimStart) / (this.m_RollAnimEnd - this.m_RollAnimStart)));
               this.CurrencyBase_mc.CurrencyBase_tf.text = String(newValue);
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
      // method body index: 950 method index: 950
      super();
   }
   
   public function Transaction(aTransactionData:Object) : *
   {
      // method body index: 948 method index: 948
      this.Merge(aTransactionData);
   }
   
   public function Merge(aTransactionData:Object) : *
   {
      // method body index: 949 method index: 949
      this.isMaxStart = this.isMaxStart || aTransactionData.isMaxStart;
      this.isMaxEnd = this.isMaxEnd || aTransactionData.isMaxEnd;
      this.currencyChange = this.currencyChange + aTransactionData.currencyChange;
      this.startingAmount = Math.min(this.startingAmount,aTransactionData.startingAmount);
   }
}
