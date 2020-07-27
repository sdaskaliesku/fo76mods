 
package HUDMenu_fla
{
   import Shared.AS3.BSButtonHintBar;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class AnnounceActiveQuestNew_270 extends MovieClip
   {
       
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var Desc_mc:MovieClip;
      
      public var Name_mc:MovieClip;
      
      public var Prompt_mc:MovieClip;
      
      public var QuestVaultBoy_mc:QuestUpdateVaultBoy;
      
      public var Title_mc:MovieClip;
      
      public function AnnounceActiveQuestNew_270()
      {
         // method body index: 899 method index: 899
         super();
         addFrameScript(0,this.frame1,29,this.frame30,229,this.frame230,259,this.frame260);
         this.__setProp_QuestVaultBoy_mc_AnnounceActiveQuestNew_QuestVaultBoy_mc_0();
      }
      
      function __setProp_QuestVaultBoy_mc_AnnounceActiveQuestNew_QuestVaultBoy_mc_0() : *
      {
         // method body index: 900 method index: 900
         try
         {
            this.QuestVaultBoy_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.QuestVaultBoy_mc.bPlayClipOnce = false;
         this.QuestVaultBoy_mc.bracketCornerLength = 6;
         this.QuestVaultBoy_mc.bracketLineWidth = 1;
         this.QuestVaultBoy_mc.bracketPaddingX = 6;
         this.QuestVaultBoy_mc.bracketPaddingY = 2;
         this.QuestVaultBoy_mc.BracketStyle = "horizontal";
         this.QuestVaultBoy_mc.bShowBrackets = false;
         this.QuestVaultBoy_mc.bUseFixedQuestStageSize = false;
         this.QuestVaultBoy_mc.bUseShadedBackground = false;
         this.QuestVaultBoy_mc.ClipAlignment = "TopLeft";
         this.QuestVaultBoy_mc.DefaultBoySwfName = "Components/Quest Vault Boys/Miscellaneous Quests/DefaultBoy.swf";
         this.QuestVaultBoy_mc.maxClipHeight = 160;
         this.QuestVaultBoy_mc.questAnimStageHeight = 400;
         this.QuestVaultBoy_mc.questAnimStageWidth = 550;
         this.QuestVaultBoy_mc.ShadedBackgroundMethod = "Shader";
         this.QuestVaultBoy_mc.ShadedBackgroundType = "normal";
         try
         {
            this.QuestVaultBoy_mc["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function frame1() : *
      {
         // method body index: 901 method index: 901
         stop();
      }
      
      function frame30() : *
      {
         // method body index: 902 method index: 902
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame230() : *
      {
         // method body index: 903 method index: 903
         stop();
      }
      
      function frame260() : *
      {
         // method body index: 904 method index: 904
         stop();
      }
   }
}
