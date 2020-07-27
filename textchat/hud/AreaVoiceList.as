 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class AreaVoiceList extends MovieClip
   {
       
      
      public var List_mc:MenuListComponent;
      
      public function AreaVoiceList()
      {
         // method body index: 732 method index: 732
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         // method body index: 733 method index: 733
         this.List_mc.itemRendererClassName_Inspectable = "AreaVoiceEntry";
         this.List_mc.disableSelection_Inspectable = true;
         this.List_mc.List_mc.disableInput_Inspectable = true;
         this.List_mc.verticalSpacing_Inspectable = 0;
         this.List_mc.numItems_Inspectable = 24;
         this.List_mc.reverseOrder = true;
         this.List_mc.useBackground = false;
         BSUIDataManager.Subscribe("VoiceChatAreaData",this.onAreaVoiceUpdate);
      }
      
      private function onAreaVoiceUpdate(param1:FromClientDataEvent) : void
      {
         // method body index: 734 method index: 734
         this.List_mc.List_mc.MenuListData = param1.data.participants;
         this.List_mc.SetIsDirty();
      }
   }
}
