 
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

         if(this._IsHostile != value)
         {
            this._IsHostile = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsFriendly(value:Boolean) : *
      {

         if(this._IsFriendly != value)
         {
            this._IsFriendly = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set OwningPlayerName(aValue:String) : void
      {

         if(aValue != this._OwningPlayerName)
         {
            this._OwningPlayerName = aValue;
            SetIsDirty();
         }
      }
      
      public function set AvatarID(aValue:String) : void
      {

         if(aValue != this._AvatarID)
         {
            this._AvatarID = aValue;
            SetIsDirty();
         }
      }
      
      public function set IsBoss(value:Boolean) : *
      {

         if(this._IsBoss != value)
         {
            this._IsBoss = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsAI(value:Boolean) : *
      {

         if(this._IsAI != value)
         {
            this._IsAI = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set TargetLevel(value:int) : *
      {

         if(this._TargetLevel != value)
         {
            this._TargetLevel = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Bounty(value:int) : *
      {

         if(this._Bounty != value)
         {
            this._Bounty = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Wanted(value:Boolean) : *
      {

         if(this._Wanted != value)
         {
            this._Wanted = value;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      private function UpdateBarFlag() : *
      {

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

         this.MeterBar_mc.Percent = afPercent / 100;
      }
      
      override public function redrawUIComponent() : void
      {

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
