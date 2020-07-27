 
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
         // method body index: 3228 method index: 3228
         super();
         this._frameTextOffset = this.TutorialText_tf.y - this.TutorialMessageFrame_mc.y;
         this._minFrameHeight = this.TutorialHeads_mc.height + 2 * this._frameTextOffset;
         TextFieldEx.setNoTranslate(this.TutorialText_tf,true);
      }
      
      public function get numberOfHeads_Inspectable() : uint
      {
         // method body index: 3226 method index: 3226
         return this._numberOfHeads;
      }
      
      public function set numberOfHeads_Inspectable(aNumberOfHeads:uint) : void
      {
         // method body index: 3227 method index: 3227
         if(this._numberOfHeads != aNumberOfHeads)
         {
            this._numberOfHeads = aNumberOfHeads;
            SetIsDirty();
         }
      }
      
      public function SetText(acText:String) : *
      {
         // method body index: 3229 method index: 3229
         var uiimage:uint = Math.floor(Math.random() * this.numberOfHeads_Inspectable);
         this.TutorialHeads_mc.gotoAndPlay("Head_0" + uiimage);
         this.TutorialText_tf.autoSize = TextFieldAutoSize.LEFT;
         GlobalFunc.SetText(this.TutorialText_tf,acText,true);
         this.AdjustFrameToFitText();
         this.AlignVertically();
         SetIsDirty();
         GlobalFunc.PlayMenuSound("UITutorialPopUp");
      }
      
      private function AdjustFrameToFitText() : *
      {
         // method body index: 3230 method index: 3230
         var newHeight:Number = this.TutorialText_tf.textHeight + 2 * this._frameTextOffset;
         if(newHeight < this._minFrameHeight)
         {
            newHeight = this._minFrameHeight;
         }
         this.TutorialMessageFrame_mc.height = newHeight;
      }
      
      private function AlignVertically() : *
      {
         // method body index: 3231 method index: 3231
         this.TutorialText_tf.y = Math.round((this.TutorialMessageFrame_mc.height - this.TutorialText_tf.textHeight) / 2);
         this.TutorialHeads_mc.y = Math.round((this.TutorialMessageFrame_mc.height - this.TutorialHeads_mc.height) / 2);
      }
   }
}
