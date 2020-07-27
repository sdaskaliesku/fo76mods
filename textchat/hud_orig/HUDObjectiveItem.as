 
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
         // method body index: 3442 method index: 3442
         super();
         addFrameScript(4,this.frame5,64,this.frame65,261,this.frame262,284,this.frame285);
         this.ObjectiveMessage_tf.autoSize = TextFieldAutoSize.LEFT;
         this.ObjectiveMessage_tf.multiline = true;
         this.ObjectiveMessage_tf.wordWrap = true;
      }
      
      public function get data() : HUDObjectiveItemData
      {
         // method body index: 3443 method index: 3443
         return this._data;
      }
      
      public function set data(value:HUDObjectiveItemData) : void
      {
         // method body index: 3444 method index: 3444
         this._data = value;
         SetIsDirty();
      }
      
      private function get ObjectiveMessage_tf() : TextField
      {
         // method body index: 3445 method index: 3445
         return this.HUDObjectiveItemInternal_mc.ObjectiveMessage_tf as TextField;
      }
      
      private function get ObjectiveIcons_mc() : MovieClip
      {
         // method body index: 3446 method index: 3446
         return this.HUDObjectiveItemInternal_mc.ObjectiveIcons_mc as MovieClip;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3447 method index: 3447
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
         // method body index: 3448 method index: 3448
         stop();
      }
      
      function frame65() : *
      {
         // method body index: 3449 method index: 3449
         OnFadeInComplete();
         stop();
      }
      
      function frame262() : *
      {
         // method body index: 3450 method index: 3450
         OnFastFadeOutStarted();
      }
      
      function frame285() : *
      {
         // method body index: 3451 method index: 3451
         OnFadeOutComplete();
         stop();
      }
   }
}
