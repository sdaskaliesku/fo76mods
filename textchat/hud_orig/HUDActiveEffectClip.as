 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   
   public class HUDActiveEffectClip extends BSUIComponent
   {
       
      
      public var Icon_mc:MovieClip;
      
      private var _IconFrame:String;
      
      private const COLOR_GREEN:uint = 0;
      
      private const COLOR_RED:uint = 1;
      
      private var _IconColor:uint = 0;
      
      private var _IconID:String = "";
      
      public function HUDActiveEffectClip()
      {
         // method body index: 2904 method index: 2904
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function set iconID(aID:String) : void
      {
         // method body index: 2896 method index: 2896
         this._IconID = aID;
      }
      
      public function get iconID() : String
      {
         // method body index: 2897 method index: 2897
         return this._IconID;
      }
      
      public function get IconFrame() : String
      {
         // method body index: 2898 method index: 2898
         return this._IconFrame;
      }
      
      public function set IconFrame(value:String) : void
      {
         // method body index: 2899 method index: 2899
         if(this._IconFrame != value)
         {
            this._IconFrame = value;
            SetIsDirty();
         }
      }
      
      public function set IconColor(value:uint) : *
      {
         // method body index: 2900 method index: 2900
         var newValue:* = value == this.COLOR_GREEN?this.COLOR_GREEN:this.COLOR_RED;
         if(this._IconColor != newValue)
         {
            this._IconColor = newValue;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 2901 method index: 2901
         if(this._IconColor == this.COLOR_RED)
         {
            gotoAndStop("negative");
         }
         else
         {
            gotoAndStop("positive");
         }
         this.Icon_mc.gotoAndStop(this._IconFrame);
         visible = this._IconFrame != null && this._IconFrame.length > 0;
      }
      
      function frame1() : *
      {
         // method body index: 2902 method index: 2902
         stop();
      }
      
      function frame2() : *
      {
         // method body index: 2903 method index: 2903
         stop();
      }
   }
}
