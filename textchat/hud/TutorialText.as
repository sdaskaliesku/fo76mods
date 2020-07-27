 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.gfx.TextFieldEx;
   
   public dynamic class TutorialText extends BSUIComponent
   {
       
      
      public var TutorialHeads_mc:MovieClip;
      
      public var TutorialText_tf:TextField;
      
      public var TutorialMessageFrame_mc:MovieClip;
      
      private var _numberOfHeads:uint = 3;
      
      private var _minFrameHeight:Number = 0.0;
      
      private var _frameTextOffset:Number = 0.0;
      
      public function TutorialText()
      {
         // method body index: 3177 method index: 3177
         super();
         this._frameTextOffset = this.TutorialText_tf.y - this.TutorialMessageFrame_mc.y;
         this._minFrameHeight = this.TutorialHeads_mc.height + 2 * this._frameTextOffset;
         TextFieldEx.setNoTranslate(this.TutorialText_tf,true);
      }
      
      public function get numberOfHeads_Inspectable() : uint
      {
         // method body index: 3178 method index: 3178
         return this._numberOfHeads;
      }
      
      public function set numberOfHeads_Inspectable(param1:uint) : void
      {
         // method body index: 3179 method index: 3179
         if(this._numberOfHeads != param1)
         {
            this._numberOfHeads = param1;
            SetIsDirty();
         }
      }
      
      public function SetText(param1:String) : *
      {
         // method body index: 3180 method index: 3180
         var _loc2_:uint = Math.floor(Math.random() * this.numberOfHeads_Inspectable);
         this.TutorialHeads_mc.gotoAndPlay("Head_0" + _loc2_);
         this.TutorialText_tf.autoSize = TextFieldAutoSize.LEFT;
         GlobalFunc.SetText(this.TutorialText_tf,param1,true);
         this.AdjustFrameToFitText();
         this.AlignVertically();
         SetIsDirty();
         GlobalFunc.PlayMenuSound("UITutorialPopUp");
      }
      
      private function AdjustFrameToFitText() : *
      {
         // method body index: 3181 method index: 3181
         var _loc1_:Number = this.TutorialText_tf.textHeight + 2 * this._frameTextOffset;
         if(_loc1_ < this._minFrameHeight)
         {
            _loc1_ = this._minFrameHeight;
         }
         this.TutorialMessageFrame_mc.height = _loc1_;
      }
      
      private function AlignVertically() : *
      {
         // method body index: 3182 method index: 3182
         this.TutorialText_tf.y = Math.round((this.TutorialMessageFrame_mc.height - this.TutorialText_tf.textHeight) / 2);
         this.TutorialHeads_mc.y = Math.round((this.TutorialMessageFrame_mc.height - this.TutorialHeads_mc.height) / 2);
      }
   }
}
