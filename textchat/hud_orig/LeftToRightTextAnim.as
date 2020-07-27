 
package
{
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextLineMetrics;
   import flash.utils.Timer;
   
   public dynamic class LeftToRightTextAnim extends MovieClip
   {
       
      
      var DisplayText:String;
      
      public function LeftToRightTextAnim()
      {
         // method body index: 2228 method index: 2228
         super();
      }
      
      public function AnimateText(aDisplayText:String) : *
      {
         // method body index: 2229 method index: 2229
         this.DisplayText = aDisplayText;
         this["textField"].SetText("",true);
         var myTimer:Timer = new Timer(60,this.DisplayText.length - 1);
         myTimer.addEventListener(TimerEvent.TIMER,this.AddLetter);
         myTimer.start();
         this["BlinkCursor_mc"].gotoAndPlay("Blink");
      }
      
      public function AddLetter() : *
      {
         // method body index: 2230 method index: 2230
         var myTimer:Timer = null;
         this["textField"].SetText(this.DisplayText.substr(0,this["textField"].text.length + 1),true);
         var metrics:TextLineMetrics = this["textField"].getLineMetrics(0);
         this["BlinkCursor_mc"].x = this["textField"].x + metrics.width + 5;
         if(this["textField"].text.length == this.DisplayText.length)
         {
            myTimer = new Timer(4000,1);
            myTimer.addEventListener(TimerEvent.TIMER,this.StartAnimOut);
            myTimer.start();
         }
      }
      
      public function StartAnimOut() : *
      {
         // method body index: 2231 method index: 2231
         var myTimer:Timer = new Timer(60,this.DisplayText.length);
         myTimer.addEventListener(TimerEvent.TIMER,this.RemoveLetter);
         myTimer.start();
      }
      
      public function RemoveLetter() : *
      {
         // method body index: 2232 method index: 2232
         var bstopBlink:* = this["textField"].text.length - 1 == 0;
         this["textField"].SetText(this.DisplayText.substr(0,this["textField"].text.length - 1),true);
         var metrics:TextLineMetrics = this["textField"].getLineMetrics(0);
         this["BlinkCursor_mc"].x = this["textField"].x + metrics.width + 5;
         if(bstopBlink)
         {
            this["BlinkCursor_mc"].gotoAndStop("Hidden");
         }
      }
   }
}
