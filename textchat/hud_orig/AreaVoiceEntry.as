 
package
{
   import Shared.AS3.BSScrollingListEntry;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class AreaVoiceEntry extends BSScrollingListEntry
   {
      
      public static var CLIP_SPACING:Number = // method body index: 2726 method index: 2726
      12;
      
      public static var CLIP_X_OFFSET:Number = // method body index: 2726 method index: 2726
      6;
       
      
      public var NameField_mc:MovieClip;
      
      public var LevelText_mc:MovieClip;
      
      public var SpeakerIcon_mc:MovieClip;
      
      public function AreaVoiceEntry()
      {

         super();
         Extensions.enabled = true;
         _HasDynamicHeight = false;
         TextFieldEx.setTextAutoSize(this.LevelText_mc.LevelText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      override public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {

         this.NameField_mc.textField.text = "$AREA_CHAT_SUFFIX";
         this.NameField_mc.textField.text = this.NameField_mc.textField.text.replace("{1}",aEntryObject.displayName);
         this.LevelText_mc.LevelText_tf.text = aEntryObject.level;
         GlobalFunc.updateVoiceIndicator(this.SpeakerIcon_mc,true,true,aEntryObject.isSpeakingInSameChannel,false,false);
         var nameElements:Array = [this.LevelText_mc,this.NameField_mc,this.SpeakerIcon_mc];
         GlobalFunc.arrangeItems(nameElements,false,GlobalFunc.ALIGN_LEFT,CLIP_SPACING,false,CLIP_X_OFFSET);
      }
   }
}
