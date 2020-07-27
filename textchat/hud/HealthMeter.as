 
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
         // method body index: 3095 method index: 3095
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
      
      public function set IsHostile(param1:Boolean) : *
      {
         // method body index: 3096 method index: 3096
         if(this._IsHostile != param1)
         {
            this._IsHostile = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsFriendly(param1:Boolean) : *
      {
         // method body index: 3097 method index: 3097
         if(this._IsFriendly != param1)
         {
            this._IsFriendly = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set OwningPlayerName(param1:String) : void
      {
         // method body index: 3098 method index: 3098
         if(param1 != this._OwningPlayerName)
         {
            this._OwningPlayerName = param1;
            SetIsDirty();
         }
      }
      
      public function set AvatarID(param1:String) : void
      {
         // method body index: 3099 method index: 3099
         if(param1 != this._AvatarID)
         {
            this._AvatarID = param1;
            SetIsDirty();
         }
      }
      
      public function set IsBoss(param1:Boolean) : *
      {
         // method body index: 3100 method index: 3100
         if(this._IsBoss != param1)
         {
            this._IsBoss = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsAI(param1:Boolean) : *
      {
         // method body index: 3101 method index: 3101
         if(this._IsAI != param1)
         {
            this._IsAI = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set TargetLevel(param1:int) : *
      {
         // method body index: 3102 method index: 3102
         if(this._TargetLevel != param1)
         {
            this._TargetLevel = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Bounty(param1:int) : *
      {
         // method body index: 3103 method index: 3103
         if(this._Bounty != param1)
         {
            this._Bounty = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Wanted(param1:Boolean) : *
      {
         // method body index: 3104 method index: 3104
         if(this._Wanted != param1)
         {
            this._Wanted = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      private function UpdateBarFlag() : *
      {
         // method body index: 3105 method index: 3105
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
      
      public function SetMeterPercent(param1:Number) : *
      {
         // method body index: 3106 method index: 3106
         this.MeterBar_mc.Percent = param1 / 100;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 3107 method index: 3107
         var _loc1_:TextField = null;
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
            _loc1_ = this.DisplayText_mc.DisplayText_tf;
            _loc1_.autoSize = TextFieldAutoSize.CENTER;
            this.BabylonAILevel_mc.x = 0 - _loc1_.textWidth / 2 - this.BabylonAILevel_mc.width;
         }
      }
   }
}
