 
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
         // method body index: 2427 method index: 2427
         super();
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("PowerArmorInfoData",this.onPowerArmorInfoUpdate);
      }
      
      private function onHUDModeUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 2428 method index: 2428
         this.m_InPowerArmor = arEvent.data.inPowerArmor;
         this.m_PowerArmorHUDEnabled = arEvent.data.powerArmorHUDEnabled;
         this.m_PowerArmorExitButton = arEvent.data.powerArmorExitButton;
         this.updateWarning();
      }
      
      private function onPowerArmorInfoUpdate(arEvent:FromClientDataEvent) : void
      {
         // method body index: 2429 method index: 2429
         this.m_FusionCorePercent = arEvent.data.fusionCorePercent;
         this.m_FusionCoreWarnPercent = arEvent.data.fusionCoreWarnPercent;
         this.m_FusionCoreCount = arEvent.data.fusionCoreCount;
         this.updateWarning();
      }
      
      private function updateWarning() : void
      {
         // method body index: 2430 method index: 2430
         var warningString:String = null;
         var showWarning:Boolean = false;
         if(this.m_FusionCoreCount == 0 && this.m_FusionCorePercent < this.m_FusionCoreWarnPercent)
         {
            showWarning = true;
            if(this.m_FusionCorePercent > 0)
            {
               warningString = "$PowerArmorLowPowerWarning";
            }
            else
            {
               warningString = "$PowerArmorNoPowerPrompt";
            }
         }
         if(showWarning)
         {
            this.warningText = GlobalFunc.LocalizeFormattedString(warningString);
         }
         this.visible = this.m_InPowerArmor && showWarning;
      }
      
      public function set warningText(astrText:String) : *
      {
         // method body index: 2431 method index: 2431
         var split2:Array = null;
         var split1:Array = astrText.split("{");
         TextFieldEx.setNoTranslate(this.PowerArmorLowBatteryWarning_tf,true);
         if(split1.length > 1 && this.BGSCodeObj != null)
         {
            split2 = split1[1].split("}");
            GlobalFunc.SetText(this.PowerArmorLowBatteryWarning_tf,split1[0] + this.BGSCodeObj.GetButtonFromUserEvent("Activate") + split2[1],true);
         }
         else
         {
            GlobalFunc.SetText(this.PowerArmorLowBatteryWarning_tf,astrText,true);
         }
      }
      
      public function set codeObj(aCodeObj:Object) : *
      {
         // method body index: 2432 method index: 2432
         this.BGSCodeObj = aCodeObj;
      }
   }
}
