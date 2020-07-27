 
package
{
   import Shared.AS3.BSScrollingListEntry;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class AreaVoiceEntry extends BSScrollingListEntry
   {
      
      public static var CLIP_SPACING:Number = // method body index: 2664 method index: 2664
      12;
      
      public static var CLIP_X_OFFSET:Number = // method body index: 2664 method index: 2664
      6;
       
      
      public var NameField_mc:MovieClip;
      
      public var LevelText_mc:MovieClip;
      
      public var SpeakerIcon_mc:MovieClip;
      
      public function AreaVoiceEntry()
      {
         // method body index: 2665 method index: 2665
         super();
         Extensions.enabled = true;
         _HasDynamicHeight = false;
         TextFieldEx.setTextAutoSize(this.LevelText_mc.LevelText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         // method body index: 2666 method index: 2666
         this.NameField_mc.textField.text = "$AREA_CHAT_SUFFIX";
         this.NameField_mc.textField.text = this.NameField_mc.textField.text.replace("{1}",param1.displayName);
         this.LevelText_mc.LevelText_tf.text = param1.level;
         GlobalFunc.updateVoiceIndicator(this.SpeakerIcon_mc,true,true,param1.isSpeakingInSameChannel,false,false);
         var _loc3_:Array = [this.LevelText_mc,this.NameField_mc,this.SpeakerIcon_mc];
         GlobalFunc.arrangeItems(_loc3_,false,GlobalFunc.ALIGN_LEFT,CLIP_SPACING,false,CLIP_X_OFFSET);
      }
   }
}
