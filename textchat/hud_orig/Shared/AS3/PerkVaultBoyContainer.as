 
package Shared.AS3
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   
   public class PerkVaultBoyContainer extends BSDisplayObject
   {
      
      private static const ANIM_FRAME_NAME:String = // method body index: 2818 method index: 2818
      "animated";
      
      private static const STATIC_FRAME_NAME:String = // method body index: 2818 method index: 2818
      "static";
      
      private static const ANIM_END_AS_EVENT:String = // method body index: 2818 method index: 2818
      "AnimComplete";
      
      private static const ANIM_END_NATIVE_EVENT:String = // method body index: 2818 method index: 2818
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
      
      public function set DefaultBoySwfName_Inspectable(aDefaultBoyName:String) : *
      {

         this._defaultVaultBoyName = aDefaultBoyName;
      }
      
      private function OnAnimComplete(e:Event) : *
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
      
      public function DisplayPerkVaultBoy(aPerkName:String, abAnimate:Boolean, abLoop:Boolean, abRemoveOnComplete:Boolean) : *
      {

         var clipType:Object = null;
         var frameName:String = null;
         var begin:* = aPerkName.lastIndexOf("/") + 1;
         var end:* = aPerkName.lastIndexOf(".");
         if(begin > 0 && end > 0)
         {
            var aPerkName:String = aPerkName.slice(begin,end);
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
