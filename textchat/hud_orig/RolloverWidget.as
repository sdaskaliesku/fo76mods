 
package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public dynamic class RolloverWidget extends BSUIComponent
   {
       
      
      public var RolloverName_tf:TextField;
      
      public var RolloverName_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var LegendaryIcon_mc:MovieClip;
      
      public var TaggedForSearchIcon_mc:MovieClip;
      
      public var AButtonData:BSButtonHintData;
      
      public var XButtonData:BSButtonHintData;
      
      public var YButtonData:BSButtonHintData;
      
      public var BButtonData:BSButtonHintData;
      
      public function RolloverWidget()
      {

         this.AButtonData = new BSButtonHintData("","E","PSN_A","Xenon_A",1,null);
         this.XButtonData = new BSButtonHintData("","R","PSN_X","Xenon_X",1,null);
         this.YButtonData = new BSButtonHintData("","Space","PSN_Y","Xenon_Y",1,null);
         this.BButtonData = new BSButtonHintData("","Tab","PSN_B","Xenon_B",1,null);
         super();
         this.RolloverName_tf = this.RolloverName_mc.RolloverName_tf;
         this.ButtonHintBar_mc.useBackground = false;
         this.PopulateButtonBar();
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.RolloverName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.RolloverName_tf.text = " ";
         TextFieldEx.setVerticalAlign(this.RolloverName_tf,TextFieldEx.VALIGN_BOTTOM);
         this.AdjustRolloverPositions();
         this.ButtonHintBar_mc.useVaultTecColor = true;
         this.__setProp_ButtonHintBar_mc_RolloverWidget_ButtonHintBar_mc_0();
      }
      
      private function PopulateButtonBar() : void
      {

         var buttonHintDataV:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         buttonHintDataV.push(this.AButtonData);
         buttonHintDataV.push(this.XButtonData);
         buttonHintDataV.push(this.YButtonData);
         buttonHintDataV.push(this.BButtonData);
         this.AButtonData.ButtonVisible = false;
         this.XButtonData.ButtonVisible = false;
         this.YButtonData.ButtonVisible = false;
         this.BButtonData.ButtonVisible = false;
         this.ButtonHintBar_mc.SetButtonHintData(buttonHintDataV);
      }
      
      public function AdjustRolloverPositions() : *
      {

         var rolloverHeight:Number = this.RolloverName_tf.height;
         this.LegendaryIcon_mc.y = this.RolloverName_tf.y + 26;
         this.LegendaryIcon_mc.x = this.RolloverName_tf.getLineMetrics(0).x + this.RolloverName_tf.x - this.LegendaryIcon_mc.width - 5;
         this.TaggedForSearchIcon_mc.y = this.RolloverName_tf.y + 15;
         this.TaggedForSearchIcon_mc.x = this.RolloverName_tf.getLineMetrics(0).x + this.RolloverName_tf.x - this.TaggedForSearchIcon_mc.width - 5;
      }
      
      function __setProp_ButtonHintBar_mc_RolloverWidget_ButtonHintBar_mc_0() : *
      {

         try
         {
            this.ButtonHintBar_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.ButtonHintBar_mc.BackgroundAlpha = 1;
         this.ButtonHintBar_mc.BackgroundColor = 0;
         this.ButtonHintBar_mc.bracketCornerLength = 6;
         this.ButtonHintBar_mc.bracketLineWidth = 1.5;
         this.ButtonHintBar_mc.BracketStyle = "horizontal";
         this.ButtonHintBar_mc.bRedirectToButtonBarMenu = false;
         this.ButtonHintBar_mc.bShowBrackets = false;
         this.ButtonHintBar_mc.bUseShadedBackground = false;
         this.ButtonHintBar_mc.ShadedBackgroundMethod = "Shader";
         this.ButtonHintBar_mc.ShadedBackgroundType = "normal";
         try
         {
            this.ButtonHintBar_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
