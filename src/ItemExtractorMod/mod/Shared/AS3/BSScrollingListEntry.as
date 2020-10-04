 
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
         // method body index: 530 method index: 530
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
         // method body index: 531 method index: 531
      }
      
      public function get parentClip() : MovieClip
      {
         // method body index: 532 method index: 532
         return this._parentClip;
      }
      
      public function set parentClip(param1:MovieClip) : *
      {
         // method body index: 533 method index: 533
         this._parentClip = param1;
      }
      
      public function get clipIndex() : uint
      {
         // method body index: 534 method index: 534
         return this._clipIndex;
      }
      
      public function set clipIndex(param1:uint) : *
      {
         // method body index: 535 method index: 535
         this._clipIndex = param1;
      }
      
      public function get clipRow() : uint
      {
         // method body index: 536 method index: 536
         return this._clipRow;
      }
      
      public function set clipRow(param1:uint) : *
      {
         // method body index: 537 method index: 537
         this._clipRow = param1;
      }
      
      public function get clipCol() : uint
      {
         // method body index: 538 method index: 538
         return this._clipCol;
      }
      
      public function set clipCol(param1:uint) : *
      {
         // method body index: 539 method index: 539
         this._clipCol = param1;
      }
      
      public function get itemIndex() : uint
      {
         // method body index: 540 method index: 540
         return this._itemIndex;
      }
      
      public function set itemIndex(param1:uint) : *
      {
         // method body index: 541 method index: 541
         this._itemIndex = param1;
      }
      
      public function get selected() : Boolean
      {
         // method body index: 542 method index: 542
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : *
      {
         // method body index: 543 method index: 543
         this._selected = param1;
      }
      
      public function get hasDynamicHeight() : Boolean
      {
         // method body index: 544 method index: 544
         return this._HasDynamicHeight;
      }
      
      public function get defaultHeight() : Number
      {
         // method body index: 545 method index: 545
         return this.ORIG_BORDER_HEIGHT;
      }
      
      public function get defaultWidth() : Number
      {
         // method body index: 546 method index: 546
         return this.ORIG_BORDER_WIDTH;
      }
      
      protected function SetColorTransform(param1:Object, param2:Boolean) : *
      {
         // method body index: 547 method index: 547
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redOffset = !!param2?Number(-255):Number(0);
         _loc3_.greenOffset = !!param2?Number(-255):Number(0);
         _loc3_.blueOffset = !!param2?Number(-255):Number(0);
         param1.transform.colorTransform = _loc3_;
      }
      
      public function SetEntryText(param1:Object, param2:String) : *
      {
         // method body index: 548 method index: 548
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
            this.textField.textColor = !!this.selected?uint(0):uint(this.ORIG_TEXT_COLOR);
         }
         if(this.border != null)
         {
            this.border.alpha = !!this.selected?Number(GlobalFunc.SELECTED_RECT_ALPHA):Number(0);
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
