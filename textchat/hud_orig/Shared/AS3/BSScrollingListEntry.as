 
package Shared.AS3
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class BSScrollingListEntry extends MovieClip
   {
       
      
      public var border:MovieClip;
      
      public var textField:TextField;
      
      public var Sizer_mc:MovieClip;
      
      protected var _clipIndex:uint;
      
      protected var _clipRow:uint;
      
      protected var _clipCol:uint;
      
      protected var _itemIndex:uint;
      
      protected var _selected:Boolean;
      
      protected var _parentClip:MovieClip;
      
      public var ORIG_BORDER_HEIGHT:Number;
      
      public var ORIG_BORDER_WIDTH:Number;
      
      public var ORIG_TEXT_COLOR:Number;
      
      protected var _HasDynamicHeight:Boolean = false;
      
      public function BSScrollingListEntry()
      {

         super();
         Extensions.enabled = true;
         this.ORIG_BORDER_HEIGHT = this.border != null?Number(this.border.height):Number(0);
         this.ORIG_BORDER_WIDTH = this.border != null?Number(this.border.width):Number(0);
         this.ORIG_TEXT_COLOR = this.textField != null?Number(this.textField.textColor):Number(16777163);
         if(this.textField != null)
         {
            this.textField.mouseEnabled = false;
            if(this.textField.multiline)
            {
               this._HasDynamicHeight = true;
            }
         }
         if(this.Sizer_mc)
         {
            this.hitArea = this.Sizer_mc;
         }
      }
      
      public function Dtor() : *
      {

      }
      
      public function get parentClip() : MovieClip
      {

         return this._parentClip;
      }
      
      public function set parentClip(aClip:MovieClip) : *
      {

         this._parentClip = aClip;
      }
      
      public function get clipIndex() : uint
      {

         return this._clipIndex;
      }
      
      public function set clipIndex(newIndex:uint) : *
      {

         this._clipIndex = newIndex;
      }
      
      public function get clipRow() : uint
      {

         return this._clipRow;
      }
      
      public function set clipRow(aRow:uint) : *
      {

         this._clipRow = aRow;
      }
      
      public function get clipCol() : uint
      {

         return this._clipCol;
      }
      
      public function set clipCol(aCol:uint) : *
      {

         this._clipCol = aCol;
      }
      
      public function get itemIndex() : uint
      {

         return this._itemIndex;
      }
      
      public function set itemIndex(newIndex:uint) : *
      {

         this._itemIndex = newIndex;
      }
      
      public function get selected() : Boolean
      {

         return this._selected;
      }
      
      public function set selected(flag:Boolean) : *
      {

         this._selected = flag;
      }
      
      public function get hasDynamicHeight() : Boolean
      {

         return this._HasDynamicHeight;
      }
      
      public function get defaultHeight() : Number
      {

         return this.ORIG_BORDER_HEIGHT;
      }
      
      public function get defaultWidth() : Number
      {

         return this.ORIG_BORDER_WIDTH;
      }
      
      protected function SetColorTransform(aTarget:Object, abSelected:Boolean) : *
      {

         var colorTrans:ColorTransform = aTarget.transform.colorTransform;
         colorTrans.redOffset = !!abSelected?Number(-255):Number(0);
         colorTrans.greenOffset = !!abSelected?Number(-255):Number(0);
         colorTrans.blueOffset = !!abSelected?Number(-255):Number(0);
         aTarget.transform.colorTransform = colorTrans;
      }
      
      public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {

         var vertSpacing:Number = NaN;
         if(this.textField != null && aEntryObject != null && aEntryObject.hasOwnProperty("text"))
         {
            if(astrTextOption == BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT)
            {
               TextFieldEx.setTextAutoSize(this.textField,"shrink");
            }
            else if(astrTextOption == BSScrollingList.TEXT_OPTION_MULTILINE)
            {
               this.textField.autoSize = TextFieldAutoSize.LEFT;
               this.textField.multiline = true;
               this.textField.wordWrap = true;
            }
            if(aEntryObject.text != undefined)
            {
               GlobalFunc.SetText(this.textField,aEntryObject.text,true);
            }
            else
            {
               GlobalFunc.SetText(this.textField," ",true);
            }
            this.textField.textColor = !!this.selected?uint(0):uint(this.ORIG_TEXT_COLOR);
         }
         if(this.border != null)
         {
            this.border.alpha = !!this.selected?Number(GlobalFunc.SELECTED_RECT_ALPHA):Number(0);
            if(this.textField != null && astrTextOption == BSScrollingList.TEXT_OPTION_MULTILINE && this.textField.numLines > 1)
            {
               vertSpacing = this.textField.y - this.border.y;
               this.border.height = this.textField.textHeight + vertSpacing * 2 + 5;
            }
            else
            {
               this.border.height = this.ORIG_BORDER_HEIGHT;
            }
         }
      }
   }
}
