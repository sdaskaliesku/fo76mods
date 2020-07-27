 
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
      
      public static const ITEM_SELECT:String = // method body index: 2530 method index: 2530
      "itemSelect";
      
      public static const ITEM_RELEASE:String = // method body index: 2530 method index: 2530
      "itemRelease";
      
      public static const ITEM_RELEASE_OUTSIDE:String = // method body index: 2530 method index: 2530
      "itemReleaseOutside";
      
      public static const HORIZONTAL:uint = // method body index: 2530 method index: 2530
      0;
      
      public static const VERTICAL:uint = // method body index: 2530 method index: 2530
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
         // method body index: 2531 method index: 2531
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
         // method body index: 2532 method index: 2532
         return this._data;
      }
      
      public function get renderers() : Vector.<MobileListItemRenderer>
      {
         // method body index: 2533 method index: 2533
         return this._renderers;
      }
      
      public function get selectedIndex() : int
      {
         // method body index: 2534 method index: 2534
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         // method body index: 2535 method index: 2535
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
         // method body index: 2536 method index: 2536
         return this.getRendererAt(this.selectedIndex);
      }
      
      public function get position() : Number
      {
         // method body index: 2537 method index: 2537
         return this._position;
      }
      
      public function set position(param1:Number) : void
      {
         // method body index: 2538 method index: 2538
         this._position = param1;
      }
      
      public function set needFullRefresh(param1:Boolean) : void
      {
         // method body index: 2539 method index: 2539
         if(param1)
         {
            this._selectedIndex = -1;
            this._position = NaN;
            this.setPosition();
         }
      }
      
      private function get canScroll() : Boolean
      {
         // method body index: 2540 method index: 2540
         var _loc1_:Boolean = this._direction == HORIZONTAL?this._scrollList.width < this._bounds.width:this._scrollList.height < this._bounds.height;
         if(!(this.noScrollShortList && _loc1_))
         {
            return true;
         }
         return false;
      }
      
      public function get itemRendererLinkageId() : String
      {
         // method body index: 2541 method index: 2541
         return this._itemRendererLinkageId;
      }
      
      public function set itemRendererLinkageId(param1:String) : void
      {
         // method body index: 2542 method index: 2542
         this._itemRendererLinkageId = param1;
      }
      
      public function get hasBackground() : Boolean
      {
         // method body index: 2543 method index: 2543
         return this._hasBackground;
      }
      
      public function set hasBackground(param1:Boolean) : void
      {
         // method body index: 2544 method index: 2544
         this._hasBackground = param1;
      }
      
      public function get backgroundColor() : int
      {
         // method body index: 2545 method index: 2545
         return this._backgroundColor;
      }
      
      public function set backgroundColor(param1:int) : void
      {
         // method body index: 2546 method index: 2546
         this._backgroundColor = param1;
      }
      
      public function get noScrollShortList() : Boolean
      {
         // method body index: 2547 method index: 2547
         return this._noScrollShortList;
      }
      
      public function set noScrollShortList(param1:Boolean) : void
      {
         // method body index: 2548 method index: 2548
         this._noScrollShortList = param1;
      }
      
      public function get clickable() : Boolean
      {
         // method body index: 2549 method index: 2549
         return this._clickable;
      }
      
      public function set clickable(param1:Boolean) : void
      {
         // method body index: 2550 method index: 2550
         this._clickable = param1;
      }
      
      public function get endListAlign() : Boolean
      {
         // method body index: 2551 method index: 2551
         return this._endListAlign;
      }
      
      public function set endListAlign(param1:Boolean) : void
      {
         // method body index: 2552 method index: 2552
         this._endListAlign = param1;
      }
      
      public function get textOption() : String
      {
         // method body index: 2553 method index: 2553
         return this._textOption;
      }
      
      public function set textOption(param1:String) : void
      {
         // method body index: 2554 method index: 2554
         this._textOption = param1;
      }
      
      public function get elasticity() : Boolean
      {
         // method body index: 2555 method index: 2555
         return this._elasticity;
      }
      
      public function set elasticity(param1:Boolean) : void
      {
         // method body index: 2556 method index: 2556
         this._elasticity = param1;
      }
      
      public function invalidateData() : void
      {
         // method body index: 2557 method index: 2557
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
         // method body index: 2558 method index: 2558
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
         // method body index: 2559 method index: 2559
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
         // method body index: 2560 method index: 2560
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
         // method body index: 2561 method index: 2561
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
         // method body index: 2562 method index: 2562
         param1.addEventListener(ITEM_SELECT,this.itemSelectHandler,false,0,true);
         param1.addEventListener(ITEM_RELEASE,this.itemReleaseHandler,false,0,true);
         param1.addEventListener(ITEM_RELEASE_OUTSIDE,this.itemReleaseOutsideHandler,false,0,true);
      }
      
      protected function removeRenderer(param1:int) : void
      {
         // method body index: 2563 method index: 2563
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
         // method body index: 2564 method index: 2564
         param1.removeEventListener(ITEM_SELECT,this.itemSelectHandler);
         param1.removeEventListener(ITEM_RELEASE,this.itemReleaseHandler);
         param1.removeEventListener(ITEM_RELEASE_OUTSIDE,this.itemReleaseOutsideHandler);
      }
      
      protected function getRendererAt(param1:int) : MobileListItemRenderer
      {
         // method body index: 2565 method index: 2565
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
         // method body index: 2566 method index: 2566
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
         // method body index: 2567 method index: 2567
         this._availableRenderers.push(param1);
      }
      
      protected function resetPressState(param1:MobileListItemRenderer) : void
      {
         // method body index: 2568 method index: 2568
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
         // method body index: 2569 method index: 2569
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
         // method body index: 2570 method index: 2570
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
         // method body index: 2571 method index: 2571
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
         // method body index: 2572 method index: 2572
         this._scrollMask = this.createSprite(16711935,new Rectangle(this._bounds.x,this._bounds.y,this._bounds.width,this._bounds.height));
         addChild(this._scrollMask);
         this._scrollMask.mouseEnabled = false;
         this._scrollList.mask = this._scrollMask;
      }
      
      protected function createBackground() : void
      {
         // method body index: 2573 method index: 2573
         this._background = this.createSprite(this.backgroundColor,new Rectangle(this._bounds.x,this._bounds.y,this._bounds.width,this._bounds.height));
         this._background.x = this._bounds.x;
         this._background.y = this._bounds.y;
         addChildAt(this._background,0);
      }
      
      protected function createSprite(param1:int, param2:Rectangle, param3:Number = 1) : Sprite
      {
         // method body index: 2574 method index: 2574
         var _loc4_:* = new Sprite();
         _loc4_.graphics.beginFill(param1,param3);
         _loc4_.graphics.drawRect(param2.x,param2.y,param2.width,param2.height);
         _loc4_.graphics.endFill();
         return _loc4_;
      }
      
      protected function enterFrameHandler(param1:Event) : void
      {
         // method body index: 2575 method index: 2575
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
         // method body index: 2576 method index: 2576
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
         // method body index: 2577 method index: 2577
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
         // method body index: 2578 method index: 2578
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
         // method body index: 2579 method index: 2579
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
         // method body index: 2580 method index: 2580
         param2.id = param3;
         param2.textOption = this._textOption;
         param1.setData(param2);
      }
      
      public function destroy() : void
      {
         // method body index: 2581 method index: 2581
         this.invalidateData();
      }
   }
}
