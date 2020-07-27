 
package Mobile.ScrollList
{
   import Shared.AS3.BGSExternalInterface;
   import Shared.AS3.BSScrollingList;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MobileScrollList extends MovieClip
   {
      
      public static const ITEM_SELECT:String = // method body index: 503 method index: 503
      "itemSelect";
      
      public static const ITEM_RELEASE:String = // method body index: 503 method index: 503
      "itemRelease";
      
      public static const ITEM_RELEASE_OUTSIDE:String = // method body index: 503 method index: 503
      "itemReleaseOutside";
      
      public static const HORIZONTAL:uint = // method body index: 503 method index: 503
      0;
      
      public static const VERTICAL:uint = // method body index: 503 method index: 503
      1;
       
      
      private var _availableRenderers:Vector.<MobileListItemRenderer>;
      
      protected var _data:Vector.<Object>;
      
      protected var _rendererRect:Rectangle;
      
      protected var _bounds:Rectangle;
      
      protected var _scrollDim:Number;
      
      protected var _deltaBetweenButtons:Number;
      
      protected var _renderers:Vector.<MobileListItemRenderer>;
      
      protected var _tempSelectedIndex:int;
      
      protected var _selectedIndex:int;
      
      protected var _position:Number;
      
      protected var _direction:uint;
      
      private var _itemRendererLinkageId:String = "MobileListItemRendererMc";
      
      protected var _background:Sprite;
      
      protected var _scrollList:Sprite;
      
      protected var _scrollMask:Sprite;
      
      protected var _touchZone:Sprite;
      
      protected var _prevIndicator:MovieClip;
      
      protected var _nextIndicator:MovieClip;
      
      protected var _mouseDown:Boolean = false;
      
      protected var _velocity:Number = 0;
      
      protected const EPSILON:Number = 0.01;
      
      protected const VELOCITY_MOVE_FACTOR:Number = 0.4;
      
      protected const VELOCITY_MOUSE_DOWN_FACTOR:Number = 0.5;
      
      protected const VELOCITY_MOUSE_UP_FACTOR:Number = 0.8;
      
      protected const RESISTANCE_OUT_BOUNDS:Number = 0.15;
      
      protected const BOUNCE_FACTOR:Number = 0.6;
      
      protected var _mouseDownPos:Number = 0;
      
      protected var _mouseDownPoint:Point;
      
      protected var _prevMouseDownPoint:Point;
      
      private var _mousePressPos:Number;
      
      private const DELTA_MOUSE_POS:int = 15;
      
      protected var _hasBackground:Boolean = false;
      
      protected var _backgroundColor:int = 15658734;
      
      protected var _noScrollShortList:Boolean = false;
      
      protected var _clickable:Boolean = true;
      
      protected var _endListAlign:Boolean = false;
      
      protected var _textOption:String;
      
      private var _elasticity:Boolean = true;
      
      public function MobileScrollList(param1:Number, param2:Number = 0, param3:uint = 1)
      {
         // method body index: 504 method index: 504
         this._mouseDownPoint = new Point();
         this._prevMouseDownPoint = new Point();
         super();
         this._scrollDim = param1;
         this._deltaBetweenButtons = param2;
         this._direction = param3;
         this._selectedIndex = -1;
         this._tempSelectedIndex = -1;
         this._position = NaN;
         this.hasBackground = false;
         this.noScrollShortList = false;
         this._clickable = true;
         this.endListAlign = false;
         this._availableRenderers = new Vector.<MobileListItemRenderer>();
      }
      
      public function get data() : Vector.<Object>
      {
         // method body index: 505 method index: 505
         return this._data;
      }
      
      public function get renderers() : Vector.<MobileListItemRenderer>
      {
         // method body index: 506 method index: 506
         return this._renderers;
      }
      
      public function get selectedIndex() : int
      {
         // method body index: 507 method index: 507
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         // method body index: 508 method index: 508
         var _loc2_:MobileListItemRenderer = this.getRendererAt(this._selectedIndex);
         if(_loc2_ != null)
         {
            _loc2_.unselectItem();
         }
         this._selectedIndex = param1;
         var _loc3_:MobileListItemRenderer = this.getRendererAt(this._selectedIndex);
         if(_loc3_ != null)
         {
            _loc3_.selectItem();
         }
         this.setPosition();
      }
      
      public function get selectedRenderer() : MobileListItemRenderer
      {
         // method body index: 509 method index: 509
         return this.getRendererAt(this.selectedIndex);
      }
      
      public function get position() : Number
      {
         // method body index: 510 method index: 510
         return this._position;
      }
      
      public function set position(param1:Number) : void
      {
         // method body index: 511 method index: 511
         this._position = param1;
      }
      
      public function set needFullRefresh(param1:Boolean) : void
      {
         // method body index: 512 method index: 512
         if(param1)
         {
            this._selectedIndex = -1;
            this._position = NaN;
            this.setPosition();
         }
      }
      
      private function get canScroll() : Boolean
      {
         // method body index: 513 method index: 513
         var _loc1_:Boolean = this._direction == HORIZONTAL?this._scrollList.width < this._bounds.width:this._scrollList.height < this._bounds.height;
         if(!(this.noScrollShortList && _loc1_))
         {
            return true;
         }
         return false;
      }
      
      public function get itemRendererLinkageId() : String
      {
         // method body index: 514 method index: 514
         return this._itemRendererLinkageId;
      }
      
      public function set itemRendererLinkageId(param1:String) : void
      {
         // method body index: 515 method index: 515
         this._itemRendererLinkageId = param1;
      }
      
      public function get hasBackground() : Boolean
      {
         // method body index: 516 method index: 516
         return this._hasBackground;
      }
      
      public function set hasBackground(param1:Boolean) : void
      {
         // method body index: 517 method index: 517
         this._hasBackground = param1;
      }
      
      public function get backgroundColor() : int
      {
         // method body index: 518 method index: 518
         return this._backgroundColor;
      }
      
      public function set backgroundColor(param1:int) : void
      {
         // method body index: 519 method index: 519
         this._backgroundColor = param1;
      }
      
      public function get noScrollShortList() : Boolean
      {
         // method body index: 520 method index: 520
         return this._noScrollShortList;
      }
      
      public function set noScrollShortList(param1:Boolean) : void
      {
         // method body index: 521 method index: 521
         this._noScrollShortList = param1;
      }
      
      public function get clickable() : Boolean
      {
         // method body index: 522 method index: 522
         return this._clickable;
      }
      
      public function set clickable(param1:Boolean) : void
      {
         // method body index: 523 method index: 523
         this._clickable = param1;
      }
      
      public function get endListAlign() : Boolean
      {
         // method body index: 524 method index: 524
         return this._endListAlign;
      }
      
      public function set endListAlign(param1:Boolean) : void
      {
         // method body index: 525 method index: 525
         this._endListAlign = param1;
      }
      
      public function get textOption() : String
      {
         // method body index: 526 method index: 526
         return this._textOption;
      }
      
      public function set textOption(param1:String) : void
      {
         // method body index: 527 method index: 527
         this._textOption = param1;
      }
      
      public function get elasticity() : Boolean
      {
         // method body index: 528 method index: 528
         return this._elasticity;
      }
      
      public function set elasticity(param1:Boolean) : void
      {
         // method body index: 529 method index: 529
         this._elasticity = param1;
      }
      
      public function invalidateData() : void
      {
         // method body index: 530 method index: 530
         var _loc1_:int = 0;
         if(this._data != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._data.length)
            {
               this.removeRenderer(_loc1_);
               _loc1_++;
            }
         }
         if(this._scrollMask != null)
         {
            removeChild(this._scrollMask);
            this._scrollMask = null;
         }
         if(this._background != null)
         {
            removeChild(this._background);
            this._background = null;
         }
         if(this._touchZone != null)
         {
            this._scrollList.removeChild(this._touchZone);
            this._touchZone = null;
         }
         if(this._scrollList != null)
         {
            if(this._scrollList.stage != null)
            {
               this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
               this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
            }
            this._scrollList.mask = null;
         }
         this._tempSelectedIndex = -1;
         this._bounds = null;
         this._data = null;
         this._renderers = null;
         this._mouseDown = false;
      }
      
      public function setData(param1:Vector.<Object>) : void
      {
         // method body index: 531 method index: 531
         var _loc2_:int = 0;
         this.invalidateData();
         this._data = param1;
         if(this.endListAlign)
         {
            this._data.reverse();
         }
         this._renderers = new Vector.<MobileListItemRenderer>();
         if(this._scrollList == null)
         {
            this._scrollList = new Sprite();
            addChild(this._scrollList);
            this._scrollList.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,false,0,true);
            this._scrollList.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler,false,0,true);
         }
         _loc2_ = 0;
         while(_loc2_ < this._data.length)
         {
            this._renderers.push(this.addRenderer(_loc2_,this._data[_loc2_]));
            _loc2_++;
         }
         if(this._deltaBetweenButtons > 0)
         {
            this._touchZone = this.createSprite(16776960,new Rectangle(0,0,this._scrollList.width,this._scrollList.height),0);
            this._scrollList.addChildAt(this._touchZone,0);
         }
         this._bounds = this._direction == HORIZONTAL?new Rectangle(0,0,this._scrollDim,this._rendererRect.height):new Rectangle(0,0,this._rendererRect.width,this._scrollDim);
         this.createMask();
         if(this.hasBackground)
         {
            this.createBackground();
         }
         this.selectedIndex = this._selectedIndex;
         if(!this.canScroll)
         {
            if(this._prevIndicator)
            {
               this._prevIndicator.visible = false;
            }
            if(this._nextIndicator)
            {
               this._nextIndicator.visible = false;
            }
         }
         this.setDataOnVisibleRenderers();
      }
      
      public function setScrollIndicators(param1:MovieClip, param2:MovieClip) : void
      {
         // method body index: 532 method index: 532
         this._prevIndicator = param1;
         this._nextIndicator = param2;
         if(this._prevIndicator)
         {
            this._prevIndicator.visible = false;
         }
         if(this._nextIndicator)
         {
            this._nextIndicator.visible = false;
         }
      }
      
      protected function setPosition() : void
      {
         // method body index: 533 method index: 533
         var _loc1_:Number = NaN;
         if(this._data == null)
         {
            return;
         }
         var _loc2_:Number = this._direction == HORIZONTAL?Number(Number(this._scrollList.width)):Number(Number(this._scrollList.height));
         var _loc3_:Number = this._direction == HORIZONTAL?Number(Number(this._bounds.width)):Number(Number(this._bounds.height));
         var _loc4_:Number = this._direction == HORIZONTAL?Number(Number(this._scrollList.x)):Number(Number(this._scrollList.y));
         if(isNaN(this.position))
         {
            if(this.selectedIndex != -1)
            {
               _loc1_ = this._direction == HORIZONTAL?Number(Number(this.selectedRenderer.x)):Number(Number(this.selectedRenderer.y));
               if(this.canScroll)
               {
                  if(_loc2_ - _loc1_ < _loc3_)
                  {
                     this._position = _loc3_ - _loc2_;
                  }
                  else
                  {
                     this._position = -_loc1_;
                  }
               }
               else
               {
                  this._position = !!this.endListAlign?Number(Number(_loc3_ - _loc2_)):Number(Number(0));
               }
            }
            else
            {
               if(this._direction == HORIZONTAL)
               {
                  this._scrollList.x = !!this.endListAlign?Number(Number(_loc3_ - _loc2_)):Number(Number(0));
               }
               else
               {
                  this._scrollList.y = !!this.endListAlign?Number(Number(_loc3_ - _loc2_)):Number(Number(0));
               }
               this.setDataOnVisibleRenderers();
               return;
            }
         }
         else if(this.canScroll)
         {
            if(this._position + _loc2_ < _loc3_)
            {
               this._position = _loc3_ - _loc2_;
            }
            else if(this._position > 0)
            {
               this._position = 0;
            }
         }
         else
         {
            this._position = !!this.endListAlign?Number(Number(_loc3_ - _loc2_)):Number(Number(0));
         }
         if(this._direction == HORIZONTAL)
         {
            this._scrollList.x = this._position;
         }
         else
         {
            this._scrollList.y = this._position;
         }
         this.setDataOnVisibleRenderers();
      }
      
      protected function addRenderer(param1:int, param2:Object) : MobileListItemRenderer
      {
         // method body index: 534 method index: 534
         var _loc3_:MobileListItemRenderer = null;
         var _loc4_:MobileListItemRenderer = this.acquireRenderer();
         _loc4_.reset();
         var _loc5_:Number = 0;
         if(param1 > 0)
         {
            _loc3_ = this.getRendererAt(param1 - 1);
            _loc5_ = _loc3_.y + _loc3_.height + this._deltaBetweenButtons;
         }
         _loc4_.y = _loc5_;
         if(this._textOption === BSScrollingList.TEXT_OPTION_MULTILINE)
         {
            this.setRendererData(_loc4_,param2,param1);
         }
         _loc4_.visible = true;
         return _loc4_;
      }
      
      protected function addRendererListeners(param1:MobileListItemRenderer) : void
      {
         // method body index: 535 method index: 535
         param1.addEventListener(ITEM_SELECT,this.itemSelectHandler,false,0,true);
         param1.addEventListener(ITEM_RELEASE,this.itemReleaseHandler,false,0,true);
         param1.addEventListener(ITEM_RELEASE_OUTSIDE,this.itemReleaseOutsideHandler,false,0,true);
      }
      
      protected function removeRenderer(param1:int) : void
      {
         // method body index: 536 method index: 536
         var _loc2_:MobileListItemRenderer = this._renderers[param1];
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
            _loc2_.y = 0;
            this.releaseRenderer(_loc2_);
         }
      }
      
      protected function removeRendererListeners(param1:MobileListItemRenderer) : void
      {
         // method body index: 537 method index: 537
         param1.removeEventListener(ITEM_SELECT,this.itemSelectHandler);
         param1.removeEventListener(ITEM_RELEASE,this.itemReleaseHandler);
         param1.removeEventListener(ITEM_RELEASE_OUTSIDE,this.itemReleaseOutsideHandler);
      }
      
      protected function getRendererAt(param1:int) : MobileListItemRenderer
      {
         // method body index: 538 method index: 538
         if(this._data == null || this._renderers == null || param1 > this._data.length - 1 || param1 < 0)
         {
            return null;
         }
         if(this.endListAlign)
         {
            return this._renderers[this._data.length - 1 - param1];
         }
         return this._renderers[param1];
      }
      
      private function acquireRenderer() : MobileListItemRenderer
      {
         // method body index: 539 method index: 539
         var _loc1_:MobileListItemRenderer = null;
         if(this._availableRenderers.length > 0)
         {
            return this._availableRenderers.pop();
         }
         _loc1_ = FlashUtil.getLibraryItem(this,this._itemRendererLinkageId) as MobileListItemRenderer;
         this._scrollList.addChild(_loc1_);
         if(this._rendererRect === null)
         {
            this._rendererRect = new Rectangle(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height);
         }
         this.addRendererListeners(_loc1_);
         return _loc1_;
      }
      
      private function releaseRenderer(param1:MobileListItemRenderer) : void
      {
         // method body index: 540 method index: 540
         this._availableRenderers.push(param1);
      }
      
      protected function resetPressState(param1:MobileListItemRenderer) : void
      {
         // method body index: 541 method index: 541
         if(param1 != null && param1.data != null)
         {
            if(this.selectedIndex == param1.data.id)
            {
               param1.selectItem();
            }
            else
            {
               param1.unselectItem();
            }
         }
      }
      
      protected function itemSelectHandler(param1:EventWithParams) : void
      {
         // method body index: 542 method index: 542
         var _loc2_:MobileListItemRenderer = null;
         var _loc3_:int = 0;
         if(this.clickable)
         {
            _loc2_ = param1.params.renderer as MobileListItemRenderer;
            _loc3_ = _loc2_.data.id;
            this._mousePressPos = this._direction == MobileScrollList.HORIZONTAL?Number(Number(stage.mouseX)):Number(Number(stage.mouseY));
            this._tempSelectedIndex = _loc3_;
            _loc2_.pressItem();
         }
      }
      
      protected function itemReleaseHandler(param1:EventWithParams) : void
      {
         // method body index: 543 method index: 543
         var _loc2_:MobileListItemRenderer = null;
         var _loc3_:int = 0;
         if(this.clickable)
         {
            _loc2_ = param1.params.renderer as MobileListItemRenderer;
            _loc3_ = _loc2_.data.id;
            if(this._tempSelectedIndex == _loc3_)
            {
               this.selectedIndex = _loc3_;
               this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_SELECT,{"renderer":_loc2_}));
            }
         }
      }
      
      protected function itemReleaseOutsideHandler(param1:EventWithParams) : void
      {
         // method body index: 544 method index: 544
         var _loc2_:MobileListItemRenderer = null;
         if(this.clickable)
         {
            _loc2_ = param1.params.renderer as MobileListItemRenderer;
            this.resetPressState(_loc2_);
            this._tempSelectedIndex = -1;
         }
      }
      
      protected function createMask() : void
      {
         // method body index: 545 method index: 545
         this._scrollMask = this.createSprite(16711935,new Rectangle(this._bounds.x,this._bounds.y,this._bounds.width,this._bounds.height));
         addChild(this._scrollMask);
         this._scrollMask.mouseEnabled = false;
         this._scrollList.mask = this._scrollMask;
      }
      
      protected function createBackground() : void
      {
         // method body index: 546 method index: 546
         this._background = this.createSprite(this.backgroundColor,new Rectangle(this._bounds.x,this._bounds.y,this._bounds.width,this._bounds.height));
         this._background.x = this._bounds.x;
         this._background.y = this._bounds.y;
         addChildAt(this._background,0);
      }
      
      protected function createSprite(param1:int, param2:Rectangle, param3:Number = 1) : Sprite
      {
         // method body index: 547 method index: 547
         var _loc4_:* = new Sprite();
         _loc4_.graphics.beginFill(param1,param3);
         _loc4_.graphics.drawRect(param2.x,param2.y,param2.width,param2.height);
         _loc4_.graphics.endFill();
         return _loc4_;
      }
      
      protected function enterFrameHandler(param1:Event) : void
      {
         // method body index: 548 method index: 548
         var _loc2_:* = undefined;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._bounds != null && this.canScroll)
         {
            _loc2_ = !!this._mouseDown?this.VELOCITY_MOUSE_DOWN_FACTOR:this.VELOCITY_MOUSE_UP_FACTOR;
            this._velocity = this._velocity * _loc2_;
            _loc3_ = this._direction == HORIZONTAL?Number(Number(this._scrollList.width)):Number(Number(this._scrollList.height));
            _loc4_ = this._direction == HORIZONTAL?Number(Number(this._bounds.width)):Number(Number(this._bounds.height));
            _loc5_ = this._direction == HORIZONTAL?Number(Number(this._scrollList.x)):Number(Number(this._scrollList.y));
            if(!this._mouseDown)
            {
               _loc6_ = 0;
               if(_loc5_ >= 0 || _loc3_ <= _loc4_)
               {
                  if(this.elasticity)
                  {
                     _loc6_ = -_loc5_ * this.BOUNCE_FACTOR;
                     this._position = _loc5_ + this._velocity + _loc6_;
                  }
                  else
                  {
                     this._position = 0;
                  }
               }
               else if(_loc5_ + _loc3_ <= _loc4_)
               {
                  if(this.elasticity)
                  {
                     _loc6_ = (_loc4_ - _loc3_ - _loc5_) * this.BOUNCE_FACTOR;
                     this._position = _loc5_ + this._velocity + _loc6_;
                  }
                  else
                  {
                     this._position = _loc4_ - _loc3_;
                  }
               }
               else
               {
                  this._position = _loc5_ + this._velocity;
               }
               if(Math.abs(this._velocity) > this.EPSILON || _loc6_ != 0)
               {
                  if(this._direction == HORIZONTAL)
                  {
                     this._scrollList.x = this._position;
                  }
                  else
                  {
                     this._scrollList.y = this._position;
                  }
                  this.setDataOnVisibleRenderers();
               }
            }
            if(this._prevIndicator)
            {
               this._prevIndicator.visible = _loc5_ < 0;
            }
            if(this._nextIndicator)
            {
               this._nextIndicator.visible = _loc5_ > _loc4_ - _loc3_;
            }
         }
      }
      
      protected function mouseDownHandler(param1:MouseEvent) : void
      {
         // method body index: 549 method index: 549
         if(!this._mouseDown && this.canScroll)
         {
            this._mouseDownPoint = new Point(param1.stageX,param1.stageY);
            this._prevMouseDownPoint = new Point(param1.stageX,param1.stageY);
            this._mouseDown = true;
            this._mouseDownPos = this._direction == HORIZONTAL?Number(Number(this._scrollList.x)):Number(Number(this._scrollList.y));
            this._scrollList.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,false,0,true);
            this._scrollList.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,false,0,true);
            BGSExternalInterface.call(null,"OnScrollingStarted");
         }
      }
      
      protected function mouseMoveHandler(param1:MouseEvent) : void
      {
         // method body index: 550 method index: 550
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         if(this._mouseDown && this.canScroll)
         {
            if(!isNaN(param1.stageX) && !isNaN(param1.stageY))
            {
               _loc2_ = new Point(param1.stageX,param1.stageY);
               if(this._direction == HORIZONTAL)
               {
                  _loc3_ = _loc2_.x - this._prevMouseDownPoint.x;
                  if(this._scrollList.x >= this._bounds.x || this._scrollList.x <= this._bounds.x - (this._scrollList.width - this._bounds.width))
                  {
                     if(this.elasticity)
                     {
                        this._scrollList.x = this._scrollList.x + _loc3_ * this.RESISTANCE_OUT_BOUNDS;
                     }
                     else if(!(this._scrollList.x >= this._bounds.x && _loc3_ > 0 || this._scrollList.x <= this._bounds.x - (this._scrollList.width - this._bounds.width) && _loc3_ < 0))
                     {
                        this._scrollList.x = this._scrollList.x + _loc3_;
                     }
                  }
                  else
                  {
                     this._scrollList.x = this._scrollList.x + _loc3_;
                  }
                  this._position = this._scrollList.x;
                  if(Math.abs(_loc2_.x - this._mousePressPos) > this.DELTA_MOUSE_POS)
                  {
                     this.resetPressState(this.getRendererAt(this._tempSelectedIndex));
                     this._tempSelectedIndex = -1;
                  }
                  this._velocity = this._velocity + (_loc2_.x - this._prevMouseDownPoint.x) * this.VELOCITY_MOVE_FACTOR;
               }
               else
               {
                  _loc3_ = _loc2_.y - this._prevMouseDownPoint.y;
                  if(this._scrollList.y >= this._bounds.y || this._scrollList.y <= this._bounds.y - (this._scrollList.height - this._bounds.height))
                  {
                     if(this.elasticity)
                     {
                        this._scrollList.y = this._scrollList.y + _loc3_ * this.RESISTANCE_OUT_BOUNDS;
                     }
                     else if(!(this._scrollList.y >= this._bounds.y && _loc3_ > 0 || this._scrollList.y <= this._bounds.y - (this._scrollList.height - this._bounds.height) && _loc3_ < 0))
                     {
                        this._scrollList.y = this._scrollList.y + _loc3_;
                     }
                  }
                  else
                  {
                     this._scrollList.y = this._scrollList.y + _loc3_;
                  }
                  this._position = this._scrollList.y;
                  if(Math.abs(_loc2_.y - this._mousePressPos) > this.DELTA_MOUSE_POS)
                  {
                     this.resetPressState(this.getRendererAt(this._tempSelectedIndex));
                     this._tempSelectedIndex = -1;
                  }
                  this._velocity = this._velocity + (_loc2_.y - this._prevMouseDownPoint.y) * this.VELOCITY_MOVE_FACTOR;
               }
               this._prevMouseDownPoint = _loc2_;
            }
            if(isNaN(this.mouseX) || isNaN(this.mouseY) || this.mouseY < this._bounds.y || this.mouseY > this._bounds.height + this._bounds.y || this.mouseX < this._bounds.x || this.mouseX > this._bounds.width + this._bounds.x)
            {
               this.mouseUpHandler(null);
            }
            this.setDataOnVisibleRenderers();
         }
      }
      
      protected function mouseUpHandler(param1:MouseEvent) : void
      {
         // method body index: 551 method index: 551
         if(this._mouseDown && this.canScroll)
         {
            this._mouseDown = false;
            this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
            this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
            BGSExternalInterface.call(null,"OnScrollingStopped");
         }
      }
      
      private function setDataOnVisibleRenderers() : void
      {
         // method body index: 552 method index: 552
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < this._renderers.length)
         {
            if(this._renderers[_loc2_].data === null)
            {
               _loc1_ = this._scrollList.y + this._renderers[_loc2_].y;
               if(_loc1_ < this._bounds.y + this._bounds.height && _loc1_ + this._renderers[_loc2_].height > this._bounds.y)
               {
                  this.setRendererData(this._renderers[_loc2_],this.data[_loc2_],_loc2_);
               }
            }
            _loc2_++;
         }
      }
      
      private function setRendererData(param1:MobileListItemRenderer, param2:Object, param3:int) : void
      {
         // method body index: 553 method index: 553
         param2.id = param3;
         param2.textOption = this._textOption;
         param1.setData(param2);
      }
      
      public function destroy() : void
      {
         // method body index: 554 method index: 554
         this.invalidateData();
      }
   }
}
