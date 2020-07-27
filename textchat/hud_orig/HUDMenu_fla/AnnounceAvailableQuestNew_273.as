 
package HUDMenu_fla
{
   import Shared.AS3.BSButtonHintBar;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class AnnounceAvailableQuestNew_273 extends MovieClip
   {
       
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var Desc_mc:MovieClip;
      
      public var Name_mc:MovieClip;
      
      public var Prompt_mc:MovieClip;
      
      public var QuestVaultBoy_mc:QuestUpdateVaultBoy;
      
      public var Title_mc:MovieClip;
      
      public function AnnounceAvailableQuestNew_273()
      {
         // method body index: 990 method index: 990
         super();
         addFrameScript(0,this.frame1,43,this.frame44,116,this.frame117,126,this.frame127);
         this.__setProp_QuestVaultBoy_mc_AnnounceAvailableQuestNew_QuestVaultBoy_mc_0();
      }
      
      function __setProp_QuestVaultBoy_mc_AnnounceAvailableQuestNew_QuestVaultBoy_mc_0() : *
      {
         // method body index: 985 method index: 985
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
         }
         catch(e:Error)
         {
         }
      }
      
      function frame1() : *
      {
         // method body index: 986 method index: 986
         stop();
      }
      
      function frame44() : *
      {
         // method body index: 987 method index: 987
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame117() : *
      {
         // method body index: 988 method index: 988
         stop();
      }
      
      function frame127() : *
      {
         // method body index: 989 method index: 989
         stop();
      }
   }
}
