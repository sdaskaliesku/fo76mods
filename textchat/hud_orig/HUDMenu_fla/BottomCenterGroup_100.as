 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class BottomCenterGroup_100 extends MovieClip
   {
       
      
      public var CompassWidget_mc:HUDCompassWidget;
      
      public var CritMeter_mc:CritMeter;
      
      public var PerkVaultBoy_mc:PerkVaultBoy;
      
      public var SubtitleText_mc:Subtitles;
      
      public function BottomCenterGroup_100()
      {
         // method body index: 1026 method index: 1026
         super();
         this.__setProp_PerkVaultBoy_mc_BottomCenterGroup_PerkVaultBoy_mc_0();
      }
      
      function __setProp_PerkVaultBoy_mc_BottomCenterGroup_PerkVaultBoy_mc_0() : *
      {
         // method body index: 1025 method index: 1025
         try
         {
            this.PerkVaultBoy_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.PerkVaultBoy_mc.bPlayClipOnce = true;
         this.PerkVaultBoy_mc.bracketCornerLength = 6;
         this.PerkVaultBoy_mc.bracketLineWidth = 1.5;
         this.PerkVaultBoy_mc.bracketPaddingX = 0;
         this.PerkVaultBoy_mc.bracketPaddingY = 0;
         this.PerkVaultBoy_mc.BracketStyle = "horizontal";
         this.PerkVaultBoy_mc.bShowBrackets = false;
         this.PerkVaultBoy_mc.bUseFixedQuestStageSize = false;
         this.PerkVaultBoy_mc.bUseShadedBackground = false;
         this.PerkVaultBoy_mc.ClipAlignment = "Center";
         this.PerkVaultBoy_mc.DefaultBoySwfName = "Components/Quest Vault Boys/Miscellaneous Quests/DefaultBoy.swf";
         this.PerkVaultBoy_mc.maxClipHeight = 128;
         this.PerkVaultBoy_mc.questAnimStageHeight = 400;
         this.PerkVaultBoy_mc.questAnimStageWidth = 550;
         this.PerkVaultBoy_mc.ShadedBackgroundMethod = "Shader";
         this.PerkVaultBoy_mc.ShadedBackgroundType = "normal";
         try
         {
            this.PerkVaultBoy_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
