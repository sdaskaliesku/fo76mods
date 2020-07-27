 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public dynamic class HUDObjectiveItem extends HUDFadingListItem
   {
       
      
      public var HUDObjectiveItemInternal_mc:MovieClip;
      
      private var _data:HUDObjectiveItemData = null;
      
      public function HUDObjectiveItem()
      {
         // method body index: 3421 method index: 3421
         super();
         addFrameScript(4,this.frame5,64,this.frame65,261,this.frame262,284,this.frame285);
         this.ObjectiveMessage_tf.autoSize = TextFieldAutoSize.LEFT;
         this.ObjectiveMessage_tf.multiline = true;
         this.ObjectiveMessage_tf.wordWrap = true;
      }
      
      public function get data() : HUDObjectiveItemData
      {
         // method body index: 3422 method index: 3422
         return this._data;
      }
      
      public function set data(param1:HUDObjectiveItemData) : void
      {
         // method body index: 3423 method index: 3423
         this._data = param1;
         SetIsDirty();
      }
      
      private function get ObjectiveMessage_tf() : TextField
      {
         // method body index: 3424 method index: 3424
         return this.HUDObjectiveItemInternal_mc.ObjectiveMessage_tf as TextField;
      }
      
      private function get ObjectiveIcons_mc() : MovieClip
      {
         // method body index: 3425 method index: 3425
         return this.HUDObjectiveItemInternal_mc.ObjectiveIcons_mc as MovieClip;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3426 method index: 3426
         if(this.data)
         {
            visible = fadeInStarted;
            this.ObjectiveIcons_mc.visible = this.data.isCompleted;
            if(this.data.isCompleted)
            {
               this.ObjectiveIcons_mc.gotoAndPlay("Completed");
            }
            GlobalFunc.SetText(this.ObjectiveMessage_tf,this.data.ObjectiveMessage,true);
         }
         else
         {
            visible = false;
         }
      }
      
      function frame5() : *
      {
         // method body index: 3427 method index: 3427
         stop();
      }
      
      function frame65() : *
      {
         // method body index: 3428 method index: 3428
         OnFadeInComplete();
         stop();
      }
      
      function frame262() : *
      {
         // method body index: 3429 method index: 3429
         OnFastFadeOutStarted();
      }
      
      function frame285() : *
      {
         // method body index: 3430 method index: 3430
         OnFadeOutComplete();
         stop();
      }
   }
}
