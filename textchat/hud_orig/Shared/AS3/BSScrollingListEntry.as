 
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
         // method body index: 2364 method index: 2364
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
         // method body index: 2365 method index: 2365
      }
      
      public function get parentClip() : MovieClip
      {
         // method body index: 2366 method index: 2366
         return this._parentClip;
      }
      
      public function set parentClip(aClip:MovieClip) : *
      {
         // method body index: 2367 method index: 2367
         this._parentClip = aClip;
      }
      
      public function get clipIndex() : uint
      {
         // method body index: 2368 method index: 2368
         return this._clipIndex;
      }
      
      public function set clipIndex(newIndex:uint) : *
      {
         // method body index: 2369 method index: 2369
         this._clipIndex = newIndex;
      }
      
      public function get clipRow() : uint
      {
         // method body index: 2370 method index: 2370
         return this._clipRow;
      }
      
      public function set clipRow(aRow:uint) : *
      {
         // method body index: 2371 method index: 2371
         this._clipRow = aRow;
      }
      
      public function get clipCol() : uint
      {
         // method body index: 2372 method index: 2372
         return this._clipCol;
      }
      
      public function set clipCol(aCol:uint) : *
      {
         // method body index: 2373 method index: 2373
         this._clipCol = aCol;
      }
      
      public function get itemIndex() : uint
      {
         // method body index: 2374 method index: 2374
         return this._itemIndex;
      }
      
      public function set itemIndex(newIndex:uint) : *
      {
         // method body index: 2375 method index: 2375
         this._itemIndex = newIndex;
      }
      
      public function get selected() : Boolean
      {
         // method body index: 2376 method index: 2376
         return this._selected;
      }
      
      public function set selected(flag:Boolean) : *
      {
         // method body index: 2377 method index: 2377
         this._selected = flag;
      }
      
      public function get hasDynamicHeight() : Boolean
      {
         // method body index: 2378 method index: 2378
         return this._HasDynamicHeight;
      }
      
      public function get defaultHeight() : Number
      {
         // method body index: 2379 method index: 2379
         return this.ORIG_BORDER_HEIGHT;
      }
      
      public function get defaultWidth() : Number
      {
         // method body index: 2380 method index: 2380
         return this.ORIG_BORDER_WIDTH;
      }
      
      protected function SetColorTransform(aTarget:Object, abSelected:Boolean) : *
      {
         // method body index: 2381 method index: 2381
         var colorTrans:ColorTransform = aTarget.transform.colorTransform;
         colorTrans.redOffset = !!abSelected?Number(-255):Number(0);
         colorTrans.greenOffset = !!abSelected?Number(-255):Number(0);
         colorTrans.blueOffset = !!abSelected?Number(-255):Number(0);
         aTarget.transform.colorTransform = colorTrans;
      }
      
      public function SetEntryText(aEntryObject:Object, astrTextOption:String) : *
      {
         // method body index: 2382 method index: 2382
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
