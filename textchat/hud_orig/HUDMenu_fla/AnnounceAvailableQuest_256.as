 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class AnnounceAvailableQuest_256 extends MovieClip
   {
       
      
      public var Desc_mc:MovieClip;
      
      public var Name_mc:MovieClip;
      
      public var Prompt_mc:MovieClip;
      
      public var QuestVaultBoy_mc:QuestUpdateVaultBoy;
      
      public var Title_mc:MovieClip;
      
      public function AnnounceAvailableQuest_256()
      {
         // method body index: 1002 method index: 1002
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16);
         this.__setProp_QuestVaultBoy_mc_AnnounceAvailableQuest_QuestVaultBoy_mc_0();
      }
      
      function __setProp_QuestVaultBoy_mc_AnnounceAvailableQuest_QuestVaultBoy_mc_0() : *
      {
         // method body index: 997 method index: 997
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
         // method body index: 998 method index: 998
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 999 method index: 999
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1000 method index: 1000
         stop();
      }
      
      function frame16() : *
      {
         // method body index: 1001 method index: 1001
         stop();
      }
   }
}
