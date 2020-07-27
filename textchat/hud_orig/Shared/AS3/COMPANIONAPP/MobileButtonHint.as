 
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
         // method body index: 3508 method index: 3508
         super();
         addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonPress);
      }
      
      private function onButtonPress(e:MouseEvent) : void
      {
         // method body index: 3509 method index: 3509
         if(!ButtonDisabled && ButtonVisible)
         {
            this.setPressState();
         }
      }
      
      override protected function onMouseOut(event:MouseEvent) : *
      {
         // method body index: 3510 method index: 3510
         super.onMouseOut(event);
         if(!ButtonDisabled && ButtonVisible)
         {
            this.setNormalState();
         }
      }
      
      override public function onTextClick(MouseEvent:Event) : void
      {
         // method body index: 3511 method index: 3511
         super.onTextClick(MouseEvent);
         if(!ButtonDisabled && ButtonVisible)
         {
            this.setNormalState();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3512 method index: 3512
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
         // method body index: 3513 method index: 3513
         this.background.gotoAndPlay("normal");
         var colorTrans:ColorTransform = textField_tf.transform.colorTransform;
         colorTrans.redOffset = 0;
         colorTrans.greenOffset = 0;
         colorTrans.blueOffset = 0;
         textField_tf.transform.colorTransform = colorTrans;
      }
      
      protected function setDisableState() : void
      {
         // method body index: 3514 method index: 3514
         this.setNormalState();
         this.background.gotoAndPlay("disabled");
      }
      
      protected function setPressState() : void
      {
         // method body index: 3515 method index: 3515
         this.background.gotoAndPlay("press");
         var colorTrans:ColorTransform = textField_tf.transform.colorTransform;
         colorTrans.redOffset = 255;
         colorTrans.greenOffset = 255;
         colorTrans.blueOffset = 255;
         textField_tf.transform.colorTransform = colorTrans;
      }
   }
}
