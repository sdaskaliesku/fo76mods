 
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
         // method body index: 2834 method index: 2834
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function set iconID(param1:String) : void
      {
         // method body index: 2835 method index: 2835
         this._IconID = param1;
      }
      
      public function get iconID() : String
      {
         // method body index: 2836 method index: 2836
         return this._IconID;
      }
      
      public function get IconFrame() : String
      {
         // method body index: 2837 method index: 2837
         return this._IconFrame;
      }
      
      public function set IconFrame(param1:String) : void
      {
         // method body index: 2838 method index: 2838
         if(this._IconFrame != param1)
         {
            this._IconFrame = param1;
            SetIsDirty();
         }
      }
      
      public function set IconColor(param1:uint) : *
      {
         // method body index: 2839 method index: 2839
         var _loc2_:* = param1 == this.COLOR_GREEN?this.COLOR_GREEN:this.COLOR_RED;
         if(this._IconColor != _loc2_)
         {
            this._IconColor = _loc2_;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 2840 method index: 2840
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
         // method body index: 2841 method index: 2841
         stop();
      }
      
      function frame2() : *
      {
         // method body index: 2842 method index: 2842
         stop();
      }
   }
}
