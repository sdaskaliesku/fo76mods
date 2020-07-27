 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class StealthMeter extends MovieClip
   {
      
      private static const MODE_NOT_SNEAKING:uint = // method body index: 2252 method index: 2252
      0;
      
      private static const MODE_HIDDEN:uint = // method body index: 2252 method index: 2252
      1;
      
      private static const MODE_DETECTED:uint = // method body index: 2252 method index: 2252
      2;
      
      private static const MODE_CAUTION:uint = // method body index: 2252 method index: 2252
      3;
      
      private static const MODE_DANGER:uint = // method body index: 2252 method index: 2252
      4;
      
      private static const MODE_TO_FRAME_LABEL:Vector.<String> = // method body index: 2252 method index: 2252
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

         super();
         addFrameScript(4,this.frame5,9,this.frame10);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {

         this.Internal_mc.gotoAndPlay("green");
         this.StealthTextInstance = this.Internal_mc.stealthTextStates.stealthTextAnimStates.StealthTextInstance;
         this.StealthTextInstance.multiline = false;
         this.StealthTextInstance.autoSize = TextFieldAutoSize.CENTER;
      }
      
      private function UpdateMode(param1:uint) : *
      {

         var _loc2_:String = MODE_TO_FRAME_LABEL[param1];
         this.Internal_mc.stealthTextStates.gotoAndPlay(_loc2_);
         if(param1 == MODE_HIDDEN || param1 == MODE_DETECTED)
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
      
      public function SetStealthMeter(param1:String, param2:uint, param3:Number, param4:Boolean) : void
      {

         var _loc5_:* = param3 - this.LastPercent;
         var _loc6_:Number = Math.floor(Math.abs(_loc5_) / 5) + 1;
         _loc6_ = Math.min(_loc6_,4);
         if(Math.abs(_loc5_) < 1 || param4)
         {
            _loc5_ = param3;
         }
         else
         {
            _loc5_ = this.LastPercent + (_loc5_ > 0?_loc6_:-_loc6_);
         }
         if(this.LastMode != param2)
         {
            this.LastMode = param2;
            this.UpdateMode(param2);
         }
         if(this.lastText != param1)
         {
            this.lastText = param1;
            GlobalFunc.SetText(this.StealthTextInstance,param1,true);
         }
         this.Internal_mc.BracketLeftInstance.x = -75 - _loc5_ - this.Internal_mc.BracketLeftInstance.width;
         this.Internal_mc.BracketRightInstance.x = -75 + 150 + _loc5_;
         this.LastPercent = _loc5_;
      }
      
      function frame5() : *
      {

         stop();
      }
      
      function frame10() : *
      {

         stop();
      }
   }
}
