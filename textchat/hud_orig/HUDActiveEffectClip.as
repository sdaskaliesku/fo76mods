 
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

         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function set iconID(aID:String) : void
      {

         this._IconID = aID;
      }
      
      public function get iconID() : String
      {

         return this._IconID;
      }
      
      public function get IconFrame() : String
      {

         return this._IconFrame;
      }
      
      public function set IconFrame(value:String) : void
      {

         if(this._IconFrame != value)
         {
            this._IconFrame = value;
            SetIsDirty();
         }
      }
      
      public function set IconColor(value:uint) : *
      {

         var newValue:* = value == this.COLOR_GREEN?this.COLOR_GREEN:this.COLOR_RED;
         if(this._IconColor != newValue)
         {
            this._IconColor = newValue;
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {

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

         stop();
      }
      
      function frame2() : *
      {

         stop();
      }
   }
}
