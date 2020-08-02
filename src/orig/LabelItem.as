 
package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class LabelItem extends MovieClip
   {
      
      private static const MaxTextWidth = // method body index: 1162 method index: 1162
      130;
      
      private static const LABEL_BUFFER_X:Number = // method body index: 1162 method index: 1162
      8.35;
       
      
      private var DisplayText:String;
      
      private var AssociatedID:uint;
      
      public var Label_tf:TextField;
      
      protected var Selected:Boolean = false;
      
      protected var Enabled:Boolean = true;
      
      protected var Selectable:Boolean = true;
      
      protected var StringWidth:Number = 0.0;
      
      private var m_ForceUppercase:Boolean = true;
      
      public function LabelItem(aDisplayText:String, aID:uint, aForceUppercase:Boolean)
      {
         // method body index: 1163 method index: 1163
         super();
         this.m_ForceUppercase = aForceUppercase;
         this.AssociatedID = aID;
         this.DisplayText = GlobalFunc.LocalizeFormattedString(aDisplayText);
         this.DisplayText = !!this.m_ForceUppercase?this.DisplayText.toUpperCase():this.DisplayText;
         GlobalFunc.SetText(this.Label_tf,"<b>" + this.DisplayText + "</b>",true);
         if(this.textWidth > MaxTextWidth)
         {
            this.Label_tf.width = MaxTextWidth;
            TextFieldEx.setTextAutoSize(this.Label_tf,"shrink");
            GlobalFunc.SetText(this.Label_tf,"<b>" + this.DisplayText + "</b>",true);
         }
         this.Selected = false;
      }
      
      public function get forceUppercase() : Boolean
      {
         // method body index: 1164 method index: 1164
         return this.m_ForceUppercase;
      }
      
      public function set forceUppercase(aUpper:Boolean) : *
      {
         // method body index: 1165 method index: 1165
         this.m_ForceUppercase = aUpper;
      }
      
      public function get selectable() : Boolean
      {
         // method body index: 1166 method index: 1166
         return this.Selectable;
      }
      
      public function set selectable(aSelectable:Boolean) : *
      {
         // method body index: 1167 method index: 1167
         this.Selectable = aSelectable;
         this.selected = this.Selected;
      }
      
      public function get id() : uint
      {
         // method body index: 1168 method index: 1168
         return this.AssociatedID;
      }
      
      public function get text() : String
      {
         // method body index: 1169 method index: 1169
         return this.DisplayText;
      }
      
      public function get textWidth() : *
      {
         // method body index: 1170 method index: 1170
         return this.Label_tf.textWidth;
      }
      
      public function set selected(aSelected:Boolean) : *
      {
         // method body index: 1171 method index: 1171
         this.Selected = aSelected;
         this.colorUpdate();
      }
      
      public function set showAsEnabled(aEnabled:Boolean) : *
      {
         // method body index: 1172 method index: 1172
         this.Enabled = aEnabled;
         this.colorUpdate();
      }
      
      public function set maxWidth(aWidth:*) : *
      {
         // method body index: 1173 method index: 1173
         this.StringWidth = aWidth;
         this.Label_tf.width = this.maxWidth;
      }
      
      public function get maxWidth() : *
      {
         // method body index: 1174 method index: 1174
         return this.StringWidth + LABEL_BUFFER_X + LABEL_BUFFER_X;
      }
      
      private function colorUpdate() : *
      {
         // method body index: 1175 method index: 1175
         var clr:* = 0;
         if(!this.Selected)
         {
            clr = !!this.Enabled?16777163:5661031;
         }
         this.Label_tf.textColor = clr;
         this.Label_tf.alpha = !!this.Selectable?Number(1):Number(GlobalFunc.DIMMED_ALPHA);
      }
   }
}
