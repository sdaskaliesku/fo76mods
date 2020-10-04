 
package Shared.AS3.COMPANIONAPP
{
   import Shared.AS3.BSButtonHint;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public dynamic class MobileButtonHint extends BSButtonHint
   {
       
      
      public var background:MovieClip;
      
      private const BUTTON_MARGIN:Number = 4;
      
      public function MobileButtonHint()
      {
         // method body index: 782 method index: 782
         super();
         addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonPress);
      }
      
      private function onButtonPress(param1:MouseEvent) : void
      {
         // method body index: 783 method index: 783
         if(!ButtonDisabled && ButtonVisible)
         {
            this.setPressState();
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : *
      {
         // method body index: 784 method index: 784
         super.onMouseOut(param1);
         if(!ButtonDisabled && ButtonVisible)
         {
            this.setNormalState();
         }
      }
      
      override public function onTextClick(param1:Event) : void
      {
         // method body index: 785 method index: 785
         super.onTextClick(param1);
         if(!ButtonDisabled && ButtonVisible)
         {
            this.setNormalState();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 786 method index: 786
         this.background.width = 1;
         this.background.height = 1;
         super.redrawUIComponent();
         this.background.width = textField_tf.width + this.BUTTON_MARGIN;
         this.background.height = textField_tf.height + this.BUTTON_MARGIN;
         if(Justification == JUSTIFY_RIGHT)
         {
            this.background.x = 0;
            this.textField_tf.x = 0;
            if(hitArea)
            {
               hitArea.x = 0;
            }
         }
         if(hitArea)
         {
            hitArea.width = this.background.width;
            hitArea.height = this.background.height;
         }
         if(ButtonVisible)
         {
            if(ButtonDisabled)
            {
               this.setDisableState();
            }
            else
            {
               this.setNormalState();
            }
         }
      }
      
      protected function setNormalState() : void
      {
         // method body index: 787 method index: 787
         this.background.gotoAndPlay("normal");
         var _loc1_:ColorTransform = textField_tf.transform.colorTransform;
         _loc1_.redOffset = 0;
         _loc1_.greenOffset = 0;
         _loc1_.blueOffset = 0;
         textField_tf.transform.colorTransform = _loc1_;
      }
      
      protected function setDisableState() : void
      {
         // method body index: 788 method index: 788
         this.setNormalState();
         this.background.gotoAndPlay("disabled");
      }
      
      protected function setPressState() : void
      {
         // method body index: 789 method index: 789
         this.background.gotoAndPlay("press");
         var _loc1_:ColorTransform = textField_tf.transform.colorTransform;
         _loc1_.redOffset = 255;
         _loc1_.greenOffset = 255;
         _loc1_.blueOffset = 255;
         textField_tf.transform.colorTransform = _loc1_;
      }
   }
}
