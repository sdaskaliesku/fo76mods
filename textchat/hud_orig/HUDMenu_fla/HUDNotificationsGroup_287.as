 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class HUDNotificationsGroup_287 extends MovieClip
   {
       
      
      public var CurrencyUpdates_mc:HUDCurrencyUpdatesWidget;
      
      public var Messages_mc:Messages;
      
      public var ObjectiveUpdates_mc:HUDObjectiveUpdates;
      
      public var PromptMessageHolder_mc:PromptMessageWidget;
      
      public var TutorialText_mc:TutorialText;
      
      public var XPMeter_mc:MovieClip;
      
      public function HUDNotificationsGroup_287()
      {

         super();
         this.__setProp_ObjectiveUpdates_mc_HUDNotificationsGroup_ObjectiveUpdates_mc_0();
         this.__setProp_Messages_mc_HUDNotificationsGroup_Messages_mc_0();
         this.__setProp_PromptMessageHolder_mc_HUDNotificationsGroup_PromptMessageHolder_mc_0();
      }
      
      function __setProp_ObjectiveUpdates_mc_HUDNotificationsGroup_ObjectiveUpdates_mc_0() : *
      {

         try
         {
            this.ObjectiveUpdates_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.ObjectiveUpdates_mc.bracketCornerLength = 6;
         this.ObjectiveUpdates_mc.bracketLineWidth = 1.5;
         this.ObjectiveUpdates_mc.bracketPaddingX = 0;
         this.ObjectiveUpdates_mc.bracketPaddingY = 0;
         this.ObjectiveUpdates_mc.BracketStyle = "horizontal";
         this.ObjectiveUpdates_mc.bShowBrackets = false;
         this.ObjectiveUpdates_mc.bUseShadedBackground = false;
         this.ObjectiveUpdates_mc.maxClipHeight = 100;
         this.ObjectiveUpdates_mc.ShadedBackgroundMethod = "Shader";
         this.ObjectiveUpdates_mc.ShadedBackgroundType = "normal";
         try
         {
            this.ObjectiveUpdates_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_Messages_mc_HUDNotificationsGroup_Messages_mc_0() : *
      {

         try
         {
            this.Messages_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.Messages_mc.bracketCornerLength = 6;
         this.Messages_mc.bracketLineWidth = 2;
         this.Messages_mc.bracketPaddingX = 6;
         this.Messages_mc.bracketPaddingY = 2;
         this.Messages_mc.BracketStyle = "horizontal";
         this.Messages_mc.bShowBrackets = false;
         this.Messages_mc.bUseShadedBackground = false;
         this.Messages_mc.maxClipHeight = 160;
         this.Messages_mc.ShadedBackgroundMethod = "Shader";
         this.Messages_mc.ShadedBackgroundType = "normal";
         try
         {
            this.Messages_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_PromptMessageHolder_mc_HUDNotificationsGroup_PromptMessageHolder_mc_0() : *
      {

         try
         {
            this.PromptMessageHolder_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.PromptMessageHolder_mc.bracketCornerLength = 6;
         this.PromptMessageHolder_mc.bracketLineWidth = 2;
         this.PromptMessageHolder_mc.bracketPaddingX = 6;
         this.PromptMessageHolder_mc.bracketPaddingY = 2;
         this.PromptMessageHolder_mc.BracketStyle = "horizontal";
         this.PromptMessageHolder_mc.bShowBrackets = false;
         this.PromptMessageHolder_mc.bUseShadedBackground = false;
         this.PromptMessageHolder_mc.ShadedBackgroundMethod = "Shader";
         this.PromptMessageHolder_mc.ShadedBackgroundType = "normal";
         try
         {
            this.PromptMessageHolder_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
