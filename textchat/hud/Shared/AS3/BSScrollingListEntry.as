 
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
         // method body index: 2290 method index: 2290
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
         // method body index: 2291 method index: 2291
      }
      
      public function get parentClip() : MovieClip
      {
         // method body index: 2292 method index: 2292
         return this._parentClip;
      }
      
      public function set parentClip(param1:MovieClip) : *
      {
         // method body index: 2293 method index: 2293
         this._parentClip = param1;
      }
      
      public function get clipIndex() : uint
      {
         // method body index: 2294 method index: 2294
         return this._clipIndex;
      }
      
      public function set clipIndex(param1:uint) : *
      {
         // method body index: 2295 method index: 2295
         this._clipIndex = param1;
      }
      
      public function get clipRow() : uint
      {
         // method body index: 2296 method index: 2296
         return this._clipRow;
      }
      
      public function set clipRow(param1:uint) : *
      {
         // method body index: 2297 method index: 2297
         this._clipRow = param1;
      }
      
      public function get clipCol() : uint
      {
         // method body index: 2298 method index: 2298
         return this._clipCol;
      }
      
      public function set clipCol(param1:uint) : *
      {
         // method body index: 2299 method index: 2299
         this._clipCol = param1;
      }
      
      public function get itemIndex() : uint
      {
         // method body index: 2300 method index: 2300
         return this._itemIndex;
      }
      
      public function set itemIndex(param1:uint) : *
      {
         // method body index: 2301 method index: 2301
         this._itemIndex = param1;
      }
      
      public function get selected() : Boolean
      {
         // method body index: 2302 method index: 2302
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : *
      {
         // method body index: 2303 method index: 2303
         this._selected = param1;
      }
      
      public function get hasDynamicHeight() : Boolean
      {
         // method body index: 2304 method index: 2304
         return this._HasDynamicHeight;
      }
      
      public function get defaultHeight() : Number
      {
         // method body index: 2305 method index: 2305
         return this.ORIG_BORDER_HEIGHT;
      }
      
      public function get defaultWidth() : Number
      {
         // method body index: 2306 method index: 2306
         return this.ORIG_BORDER_WIDTH;
      }
      
      protected function SetColorTransform(param1:Object, param2:Boolean) : *
      {
         // method body index: 2307 method index: 2307
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redOffset = !!param2?Number(Number(-255)):Number(Number(0));
         _loc3_.greenOffset = !!param2?Number(Number(-255)):Number(Number(0));
         _loc3_.blueOffset = !!param2?Number(Number(-255)):Number(Number(0));
         param1.transform.colorTransform = _loc3_;
      }
      
      public function SetEntryText(param1:Object, param2:String) : *
      {
         // method body index: 2308 method index: 2308
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
