 
package Shared.AS3
{
   import flash.display.MovieClip;
   
   public class BCBasicMenuItem extends MovieClip
   {
       
      
      public var Sizer_mc:MovieClip;
      
      public var HitArea_mc:MovieClip;
      
      public var Text_mc:MovieClip;
      
      public var Image_mc:MovieClip;
      
      private var m_Selected:Boolean = false;
      
      private var m_Disabled:Boolean = false;
      
      private var m_Text:String;
      
      private var m_Index:uint = 0;
      
      public function BCBasicMenuItem()
      {
         // method body index: 1061 method index: 1061
         super();
         if(this.HitArea_mc != null)
         {
            this.hitArea = this.HitArea_mc;
         }
         else if(this.Sizer_mc != null)
         {
            this.hitArea = this.Sizer_mc;
         }
      }
      
      public function set text(aText:String) : void
      {
         // method body index: 1053 method index: 1053
         this.m_Text = aText;
         if(this.Text_mc != null)
         {
            this.Text_mc.Text_tf.text = this.m_Text;
         }
      }
      
      public function get text() : String
      {
         // method body index: 1054 method index: 1054
         return this.m_Text;
      }
      
      private function updateState() : void
      {
         // method body index: 1055 method index: 1055
         if(this.m_Disabled)
         {
            if(this.m_Selected)
            {
               gotoAndPlay("rollOnDisabled");
            }
            else
            {
               gotoAndPlay("offDisabled");
            }
         }
         else if(this.m_Selected)
         {
            gotoAndPlay("rollOn");
         }
         else
         {
            gotoAndPlay("off");
         }
      }
      
      public function set disabled(aDisabled:Boolean) : void
      {
         // method body index: 1056 method index: 1056
         if(aDisabled != this.m_Disabled)
         {
            this.m_Disabled = aDisabled;
            this.updateState();
         }
      }
      
      public function get disabled() : Boolean
      {
         // method body index: 1057 method index: 1057
         return this.m_Disabled;
      }
      
      public function set index(aIndex:uint) : void
      {
         // method body index: 1058 method index: 1058
         this.m_Index = aIndex;
      }
      
      public function get index() : uint
      {
         // method body index: 1059 method index: 1059
         return this.m_Index;
      }
      
      public function set selected(aSelected:Boolean) : void
      {
         // method body index: 1060 method index: 1060
         if(aSelected != this.m_Selected)
         {
            this.m_Selected = aSelected;
            this.updateState();
         }
      }
   }
}
