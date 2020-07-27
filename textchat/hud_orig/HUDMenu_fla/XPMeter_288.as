 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class XPMeter_288 extends MovieClip
   {
       
      
      public var BG:MovieClip;
      
      public var CurrentLevelField:MovieClip;
      
      public var LeveUpTextClip:LevelUpClip;
      
      public var LevelUPBar:XPMeterBar;
      
      public var LevelUpBracket:MovieClip;
      
      public var NumberText:TextField;
      
      public var Optional_mc:XPMeterBar;
      
      public var PlusSign:TextField;
      
      public var xptext:TextField;
      
      public function XPMeter_288()
      {

         super();
         this.__setProp_Optional_mc_XPMeter_Optional_mc_0();
         this.__setProp_LevelUPBar_XPMeter_LevelUPBar_0();
      }
      
      function __setProp_Optional_mc_XPMeter_Optional_mc_0() : *
      {

         try
         {
            this.Optional_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.Optional_mc.BarAlpha = 0.5;
         this.Optional_mc.bracketCornerLength = 6;
         this.Optional_mc.bracketLineWidth = 1.5;
         this.Optional_mc.bracketPaddingX = 0;
         this.Optional_mc.bracketPaddingY = 0;
         this.Optional_mc.BracketStyle = "horizontal";
         this.Optional_mc.bShowBrackets = false;
         this.Optional_mc.bUseShadedBackground = false;
         this.Optional_mc.Justification = "left";
         this.Optional_mc.Percent = 0;
         this.Optional_mc.ShadedBackgroundMethod = "Shader";
         this.Optional_mc.ShadedBackgroundType = "normal";
         try
         {
            this.Optional_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_LevelUPBar_XPMeter_LevelUPBar_0() : *
      {

         try
         {
            this.LevelUPBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.LevelUPBar.BarAlpha = 1;
         this.LevelUPBar.bracketCornerLength = 6;
         this.LevelUPBar.bracketLineWidth = 1.5;
         this.LevelUPBar.bracketPaddingX = 0;
         this.LevelUPBar.bracketPaddingY = 0;
         this.LevelUPBar.BracketStyle = "horizontal";
         this.LevelUPBar.bShowBrackets = false;
         this.LevelUPBar.bUseShadedBackground = false;
         this.LevelUPBar.Justification = "left";
         this.LevelUPBar.Percent = 0;
         this.LevelUPBar.ShadedBackgroundMethod = "Shader";
         this.LevelUPBar.ShadedBackgroundType = "normal";
         try
         {
            this.LevelUPBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
