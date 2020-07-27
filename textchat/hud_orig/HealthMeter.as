 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HealthMeter extends BSUIComponent
   {
       
      
      public var MeterBar_mc:MovieClip;
      
      public var MeterBarEnemy_mc:MovieClip;
      
      public var MeterBarFriendly_mc:MovieClip;
      
      public var MeterFrame_mc:MovieClip;
      
      public var Optional_mc:MovieClip;
      
      public var DisplayText_mc:MovieClip;
      
      public var LegendaryIcon_mc:MovieClip;
      
      public var SkullIcon_mc:MovieClip;
      
      public var RadsBar_mc:MovieClip;
      
      public var LevelText_mc:MovieClip;
      
      public var BabylonAILevel_mc:MovieClip;
      
      public var OwnerInfo_mc:MovieClip;
      
      private var _IsHostile:Boolean = true;
      
      private var _IsFriendly:Boolean = true;
      
      private var _OwningPlayerName:String = "";
      
      private var _AvatarID:String = "";
      
      private var _IsBoss:Boolean = false;
      
      private var _IsAI:Boolean = false;
      
      private var _TargetLevel:int = 0;
      
      private var _Bounty:int = 0;
      
      private var _Wanted:Boolean = false;
      
      public function HealthMeter()
      {
         // method body index: 3144 method index: 3144
         super();
         Extensions.enabled = true;
         if(this.OwnerInfo_mc)
         {
            TextFieldEx.setTextAutoSize(this.OwnerInfo_mc.Name_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.OwnerInfo_mc.AccountIcon_mc.clipWidth = this.OwnerInfo_mc.AccountIcon_mc.width * (1 / this.OwnerInfo_mc.AccountIcon_mc.scaleX);
            this.OwnerInfo_mc.AccountIcon_mc.clipHeight = this.OwnerInfo_mc.AccountIcon_mc.height * (1 / this.OwnerInfo_mc.AccountIcon_mc.scaleY);
         }
         if(this.LevelText_mc && this.LevelText_mc.LevelText_tf)
         {
            TextFieldEx.setTextAutoSize(this.LevelText_mc.LevelText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         }
         if(this.DisplayText_mc && this.DisplayText_mc.DisplayText_tf)
         {
            TextFieldEx.setTextAutoSize(this.DisplayText_mc.DisplayText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         }
      }
      
      public function set IsHostile(value:Boolean) : *
      {
         // method body index: 3145 method index: 3145
         if(this._IsHostile != value)
         {
            this._IsHostile = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsFriendly(value:Boolean) : *
      {
         // method body index: 3146 method index: 3146
         if(this._IsFriendly != value)
         {
            this._IsFriendly = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set OwningPlayerName(aValue:String) : void
      {
         // method body index: 3147 method index: 3147
         if(aValue != this._OwningPlayerName)
         {
            this._OwningPlayerName = aValue;
            SetIsDirty();
         }
      }
      
      public function set AvatarID(aValue:String) : void
      {
         // method body index: 3148 method index: 3148
         if(aValue != this._AvatarID)
         {
            this._AvatarID = aValue;
            SetIsDirty();
         }
      }
      
      public function set IsBoss(value:Boolean) : *
      {
         // method body index: 3149 method index: 3149
         if(this._IsBoss != value)
         {
            this._IsBoss = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsAI(value:Boolean) : *
      {
         // method body index: 3150 method index: 3150
         if(this._IsAI != value)
         {
            this._IsAI = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set TargetLevel(value:int) : *
      {
         // method body index: 3151 method index: 3151
         if(this._TargetLevel != value)
         {
            this._TargetLevel = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Bounty(value:int) : *
      {
         // method body index: 3152 method index: 3152
         if(this._Bounty != value)
         {
            this._Bounty = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Wanted(value:Boolean) : *
      {
         // method body index: 3153 method index: 3153
         if(this._Wanted != value)
         {
            this._Wanted = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      private function UpdateBarFlag() : *
      {
         // method body index: 3154 method index: 3154
         if(this._IsHostile || this._Wanted)
         {
            gotoAndStop("Hostile");
         }
         else
         {
            gotoAndStop(!!this._IsFriendly?"Friendly":"Nonhostile");
         }
         if(this._IsAI)
         {
            this.BabylonAILevel_mc.visible = true;
            if(this._IsBoss)
            {
               this.BabylonAILevel_mc.gotoAndStop("EliteAI");
            }
            else
            {
               this.BabylonAILevel_mc.gotoAndStop("AI");
            }
         }
         else
         {
            this.BabylonAILevel_mc.visible = false;
         }
         this.LevelText_mc.gotoAndStop(!!this._IsBoss?"star":"square");
         this.LevelText_mc.LevelText_tf.text = this._TargetLevel.toString();
      }
      
      public function SetMeterPercent(afPercent:Number) : *
      {
         // method body index: 3155 method index: 3155
         this.MeterBar_mc.Percent = afPercent / 100;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3156 method index: 3156
         var displayTF:TextField = null;
         if(this.OwnerInfo_mc)
         {
            if(this._OwningPlayerName.length > 0)
            {
               this.OwnerInfo_mc.visible = true;
               this.OwnerInfo_mc.Name_tf.text = this._OwningPlayerName;
               (this.OwnerInfo_mc.AccountIcon_mc as ImageFixture).LoadExternal(GlobalFunc.GetAccountIconPath(this._AvatarID),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.OwnerInfo_mc.x = this.LevelText_mc.x - this.LevelText_mc.width - this.OwnerInfo_mc.width;
            }
            else
            {
               this.OwnerInfo_mc.visible = false;
            }
         }
         if(this.BabylonAILevel_mc)
         {
            displayTF = this.DisplayText_mc.DisplayText_tf;
            displayTF.autoSize = TextFieldAutoSize.CENTER;
            this.BabylonAILevel_mc.x = 0 - displayTF.textWidth / 2 - this.BabylonAILevel_mc.width;
         }
      }
   }
}
