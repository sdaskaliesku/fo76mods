 
package Shared.AS3
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   
   public class PerkVaultBoyContainer extends BSDisplayObject
   {
      
      private static const ANIM_FRAME_NAME:String = // method body index: 2756 method index: 2756
      "animated";
      
      private static const STATIC_FRAME_NAME:String = // method body index: 2756 method index: 2756
      "static";
      
      private static const ANIM_END_AS_EVENT:String = // method body index: 2756 method index: 2756
      "AnimComplete";
      
      private static const ANIM_END_NATIVE_EVENT:String = // method body index: 2756 method index: 2756
      "PerkVaultBoyAnimComplete";
       
      
      private var CurrentClip:MovieClip = null;
      
      private var Loop:Boolean = false;
      
      private var RemoveOnComplete:Boolean = true;
      
      private var _defaultVaultBoyName:String = "Default";
      
      public function PerkVaultBoyContainer()
      {

         super();
         addEventListener(ANIM_END_AS_EVENT,this.OnAnimComplete);
      }
      
      public function get DefaultBoySwfName_Inspectable() : String
      {

         return this._defaultVaultBoyName;
      }
      
      public function set DefaultBoySwfName_Inspectable(param1:String) : *
      {

         this._defaultVaultBoyName = param1;
      }
      
      private function OnAnimComplete(param1:Event) : *
      {

         if(!this.Loop)
         {
            this.CurrentClip.stop();
            if(this.RemoveOnComplete)
            {
               removeChild(this.CurrentClip);
               this.CurrentClip = null;
            }
            BSUIDataManager.dispatchEvent(new CustomEvent(ANIM_END_NATIVE_EVENT,{}));
         }
      }
      
      public function DisplayPerkVaultBoy(param1:String, param2:Boolean, param3:Boolean, param4:Boolean) : *
      {

         var aPerkName:String = param1;
         var abAnimate:Boolean = param2;
         var abLoop:Boolean = param3;
         var abRemoveOnComplete:Boolean = param4;
         var clipType:Object = null;
         var frameName:String = null;
         var begin:* = aPerkName.lastIndexOf("/") + 1;
         var end:* = aPerkName.lastIndexOf(".");
         if(begin > 0 && end > 0)
         {
            aPerkName = aPerkName.slice(begin,end);
            aPerkName = aPerkName.replace(/ /gi,"");
         }
         try
         {
            clipType = getDefinitionByName(aPerkName);
         }
         catch(error:Error)
         {
            try
            {
               clipType = getDefinitionByName(DefaultBoySwfName_Inspectable);
            }
            catch(error:Error)
            {
               trace("Error: Could not find the " + aPerkName + " class nor the " + DefaultBoySwfName_Inspectable + " class in library. Can\'t display a perk animation.");
               return;
            }
         }
         var newClip:MovieClip = new clipType();
         if(newClip)
         {
            frameName = !!abAnimate?ANIM_FRAME_NAME:STATIC_FRAME_NAME;
            newClip.gotoAndStop(frameName);
            if(this.CurrentClip)
            {
               removeChild(this.CurrentClip);
            }
            addChild(newClip);
            this.Loop = abLoop;
            this.RemoveOnComplete = abRemoveOnComplete;
            this.CurrentClip = newClip;
         }
      }
   }
}
