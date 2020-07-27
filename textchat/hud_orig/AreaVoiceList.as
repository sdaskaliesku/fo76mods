 
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
         // method body index: 806 method index: 806
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(aEvent:Event) : void
      {
         // method body index: 807 method index: 807
         this.List_mc.itemRendererClassName_Inspectable = "AreaVoiceEntry";
         this.List_mc.disableSelection_Inspectable = true;
         this.List_mc.List_mc.disableInput_Inspectable = true;
         this.List_mc.verticalSpacing_Inspectable = 0;
         this.List_mc.numItems_Inspectable = 24;
         this.List_mc.reverseOrder = true;
         this.List_mc.useBackground = false;
         BSUIDataManager.Subscribe("VoiceChatAreaData",this.onAreaVoiceUpdate);
      }
      
      private function onAreaVoiceUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 808 method index: 808
         this.List_mc.List_mc.MenuListData = arEvent.data.participants;
         this.List_mc.SetIsDirty();
      }
   }
}
