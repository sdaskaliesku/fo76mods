 
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
         this.ORIG_BORDER_HEIGHT = this.border != null?Number(Number(this.border.height)):Number(Number(0));
         this.ORIG_BORDER_WIDTH = this.border != null?Number(Number(this.border.width)):Number(Number(0));
         this.ORIG_TEXT_COLOR = this.textField != null?Number(Number(this.textField.textColor)):Number(Number(16777163));
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
      
      public function set parentClip(param1:MovieClip) : *
      {

         this._parentClip = param1;
      }
      
      public function get clipIndex() : uint
      {

         return this._clipIndex;
      }
      
      public function set clipIndex(param1:uint) : *
      {

         this._clipIndex = param1;
      }
      
      public function get clipRow() : uint
      {

         return this._clipRow;
      }
      
      public function set clipRow(param1:uint) : *
      {

         this._clipRow = param1;
      }
      
      public function get clipCol() : uint
      {

         return this._clipCol;
      }
      
      public function set clipCol(param1:uint) : *
      {

         this._clipCol = param1;
      }
      
      public function get itemIndex() : uint
      {

         return this._itemIndex;
      }
      
      public function set itemIndex(param1:uint) : *
      {

         this._itemIndex = param1;
      }
      
      public function get selected() : Boolean
      {

         return this._selected;
      }
      
      public function set selected(param1:Boolean) : *
      {

         this._selected = param1;
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
      
      protected function SetColorTransform(param1:Object, param2:Boolean) : *
      {

         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redOffset = !!param2?Number(Number(-255)):Number(Number(0));
         _loc3_.greenOffset = !!param2?Number(Number(-255)):Number(Number(0));
         _loc3_.blueOffset = !!param2?Number(Number(-255)):Number(Number(0));
         param1.transform.colorTransform = _loc3_;
      }
      
      public function SetEntryText(param1:Object, param2:String) : *
      {

         var _loc3_:Number = NaN;
         if(this.textField != null && param1 != null && param1.hasOwnProperty("text"))
         {
            if(param2 == BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT)
            {
               TextFieldEx.setTextAutoSize(this.textField,"shrink");
            }
            else if(param2 == BSScrollingList.TEXT_OPTION_MULTILINE)
            {
               this.textField.autoSize = TextFieldAutoSize.LEFT;
               this.textField.multiline = true;
               this.textField.wordWrap = true;
            }
            if(param1.text != undefined)
            {
               GlobalFunc.SetText(this.textField,param1.text,true);
            }
            else
            {
               GlobalFunc.SetText(this.textField," ",true);
            }
            this.textField.textColor = !!this.selected?uint(uint(0)):uint(uint(this.ORIG_TEXT_COLOR));
         }
         if(this.border != null)
         {
            this.border.alpha = !!this.selected?Number(Number(GlobalFunc.SELECTED_RECT_ALPHA)):Number(Number(0));
            if(this.textField != null && param2 == BSScrollingList.TEXT_OPTION_MULTILINE && this.textField.numLines > 1)
            {
               _loc3_ = this.textField.y - this.border.y;
               this.border.height = this.textField.textHeight + _loc3_ * 2 + 5;
            }
            else
            {
               this.border.height = this.ORIG_BORDER_HEIGHT;
            }
         }
      }
   }
}
