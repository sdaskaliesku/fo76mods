 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class StealthMeter extends MovieClip
   {
      
      private static const MODE_NOT_SNEAKING:uint = // method body index: 2326 method index: 2326
      0;
      
      private static const MODE_HIDDEN:uint = // method body index: 2326 method index: 2326
      1;
      
      private static const MODE_DETECTED:uint = // method body index: 2326 method index: 2326
      2;
      
      private static const MODE_CAUTION:uint = // method body index: 2326 method index: 2326
      3;
      
      private static const MODE_DANGER:uint = // method body index: 2326 method index: 2326
      4;
      
      private static const MODE_TO_FRAME_LABEL:Vector.<String> = // method body index: 2326 method index: 2326
      new <String>["detected","hidden","detected","caution","danger"];
       
      
      public var Internal_mc:MovieClip;
      
      private var StealthTextInstance:TextField;
      
      private var LastPercent:Number = 0;
      
      private var stealthStateFrames:int = 100;
      
      private var isRed:Boolean = false;
      
      private var lastText:String = "";
      
      private var LastMode:uint = 0;
      
      public function StealthMeter()
      {
         // method body index: 2327 method index: 2327
         super();
         addFrameScript(4,this.frame5,9,this.frame10);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(e:Event) : void
      {
         // method body index: 2328 method index: 2328
         this.Internal_mc.gotoAndPlay("green");
         this.StealthTextInstance = this.Internal_mc.stealthTextStates.stealthTextAnimStates.StealthTextInstance;
         this.StealthTextInstance.multiline = false;
         this.StealthTextInstance.autoSize = TextFieldAutoSize.CENTER;
      }
      
      private function UpdateMode(aeNewMode:uint) : *
      {
         // method body index: 2329 method index: 2329
         var stateName:String = MODE_TO_FRAME_LABEL[aeNewMode];
         this.Internal_mc.stealthTextStates.gotoAndPlay(stateName);
         if(aeNewMode == MODE_HIDDEN || aeNewMode == MODE_DETECTED)
         {
            if(this.isRed)
            {
               this.Internal_mc.gotoAndPlay("green");
               this.isRed = false;
            }
         }
         else if(!this.isRed)
         {
            this.Internal_mc.gotoAndPlay("red");
            this.isRed = true;
         }
      }
      
      public function SetStealthMeter(astrSneakText:String, aeSneakMode:uint, aPercent:Number, abForce:Boolean) : void
      {
         // method body index: 2330 method index: 2330
         var newPercent:* = aPercent - this.LastPercent;
         var speed:Number = Math.floor(Math.abs(newPercent) / 5) + 1;
         speed = Math.min(speed,4);
         if(Math.abs(newPercent) < 1 || abForce)
         {
            newPercent = aPercent;
         }
         else
         {
            newPercent = this.LastPercent + (newPercent > 0?speed:-speed);
         }
         if(this.LastMode != aeSneakMode)
         {
            this.LastMode = aeSneakMode;
            this.UpdateMode(aeSneakMode);
         }
         if(this.lastText != astrSneakText)
         {
            this.lastText = astrSneakText;
            GlobalFunc.SetText(this.StealthTextInstance,astrSneakText,true);
         }
         this.Internal_mc.BracketLeftInstance.x = -75 - newPercent - this.Internal_mc.BracketLeftInstance.width;
         this.Internal_mc.BracketRightInstance.x = -75 + 150 + newPercent;
         this.LastPercent = newPercent;
      }
      
      function frame5() : *
      {
         // method body index: 2331 method index: 2331
         stop();
      }
      
      function frame10() : *
      {
         // method body index: 2332 method index: 2332
         stop();
      }
   }
}
