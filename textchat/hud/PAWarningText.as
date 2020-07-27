 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class PAWarningText extends MovieClip
   {
       
      
      public var PowerArmorLowBatteryWarning_tf:TextField;
      
      protected var BGSCodeObj:Object;
      
      private var m_FusionCorePercent:Number = 0;
      
      private var m_FusionCoreWarnPercent:Number = 0;
      
      private var m_FusionCoreCount:uint = 0;
      
      private var m_InPowerArmor:Boolean = false;
      
      private var m_PowerArmorHUDEnabled:Boolean = true;
      
      private var m_PowerArmorExitButton:String = "";
      
      public function PAWarningText()
      {

         super();
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("PowerArmorInfoData",this.onPowerArmorInfoUpdate);
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {

         this.m_InPowerArmor = param1.data.inPowerArmor;
         this.m_PowerArmorHUDEnabled = param1.data.powerArmorHUDEnabled;
         this.m_PowerArmorExitButton = param1.data.powerArmorExitButton;
         this.updateWarning();
      }
      
      private function onPowerArmorInfoUpdate(param1:FromClientDataEvent) : void
      {

         this.m_FusionCorePercent = param1.data.fusionCorePercent;
         this.m_FusionCoreWarnPercent = param1.data.fusionCoreWarnPercent;
         this.m_FusionCoreCount = param1.data.fusionCoreCount;
         this.updateWarning();
      }
      
      private function updateWarning() : void
      {

         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         if(this.m_FusionCoreCount == 0 && this.m_FusionCorePercent < this.m_FusionCoreWarnPercent)
         {
            _loc2_ = true;
            if(this.m_FusionCorePercent > 0)
            {
               _loc1_ = "$PowerArmorLowPowerWarning";
            }
            else
            {
               _loc1_ = "$PowerArmorNoPowerPrompt";
            }
         }
         if(_loc2_)
         {
            this.warningText = GlobalFunc.LocalizeFormattedString(_loc1_);
         }
         this.visible = this.m_InPowerArmor && _loc2_;
      }
      
      public function set warningText(param1:String) : *
      {

         var _loc2_:Array = null;
         var _loc3_:Array = param1.split("{");
         TextFieldEx.setNoTranslate(this.PowerArmorLowBatteryWarning_tf,true);
         if(_loc3_.length > 1 && this.BGSCodeObj != null)
         {
            _loc2_ = _loc3_[1].split("}");
            GlobalFunc.SetText(this.PowerArmorLowBatteryWarning_tf,_loc3_[0] + this.BGSCodeObj.GetButtonFromUserEvent("Activate") + _loc2_[1],true);
         }
         else
         {
            GlobalFunc.SetText(this.PowerArmorLowBatteryWarning_tf,param1,true);
         }
      }
      
      public function set codeObj(param1:Object) : *
      {

         this.BGSCodeObj = param1;
      }
   }
}
