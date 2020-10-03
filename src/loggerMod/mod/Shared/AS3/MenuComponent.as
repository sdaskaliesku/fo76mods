 
package Shared.AS3
{
   import Shared.AS3.Events.MenuComponentLoadedEvent;
   import flash.events.Event;
   
   public dynamic class MenuComponent extends BSUIComponent
   {
       
      
      private var _ButtonData:Vector.<BSButtonHintData>;
      
      private var _ButtonHintBar:BSButtonHintBar;
      
      protected var _active:Boolean = false;
      
      private var _targetButtonHintBar:Object;
      
      public function MenuComponent()
      {
         // method body index: 727 method index: 727
         this._ButtonData = new Vector.<BSButtonHintData>();
         super();
         this.buttonHintBarTarget_Inspectable = "ButtonHintBar_mc";
      }
      
      public function get Active() : Boolean
      {
         // method body index: 721 method index: 721
         return this._active;
      }
      
      public function set Active(param1:*) : void
      {
         // method body index: 722 method index: 722
         this._active = param1;
         this.connectButtonBar();
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {
         // method body index: 723 method index: 723
         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(param1:BSButtonHintBar) : *
      {
         // method body index: 724 method index: 724
         this._ButtonHintBar = param1;
      }
      
      public function get buttonData() : Vector.<BSButtonHintData>
      {
         // method body index: 725 method index: 725
         return this._ButtonData;
      }
      
      public function set buttonData(param1:Vector.<BSButtonHintData>) : void
      {
         // method body index: 726 method index: 726
         this._ButtonData = param1;
      }
      
      private function onEnterFrame(param1:Event) : *
      {
         // method body index: 728 method index: 728
         stage.dispatchEvent(new MenuComponentLoadedEvent(this));
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 729 method index: 729
         super.onAddedToStage();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function SetParentMenu(param1:IMenu) : *
      {
         // method body index: 730 method index: 730
         this.buttonHintBar = param1.buttonHintBar;
         this.connectButtonBar();
      }
      
      public function get buttonHintBarTarget_Inspectable() : Object
      {
         // method body index: 731 method index: 731
         return this._targetButtonHintBar;
      }
      
      public function set buttonHintBarTarget_Inspectable(param1:Object) : void
      {
         // method body index: 732 method index: 732
         var _loc2_:* = Object;
         if(param1 is String)
         {
            if(param1.toString() == "" || parent == null)
            {
               return;
            }
            _loc2_ = parent.getChildByName(param1.toString()) as Object;
            if(_loc2_ == null)
            {
               if(parent.parent)
               {
                  _loc2_ = parent.parent.getChildByName(param1.toString());
                  if(_loc2_ == null)
                  {
                     return;
                  }
               }
            }
         }
         else
         {
            _loc2_ = param1;
         }
         this._targetButtonHintBar = _loc2_;
         this.buttonHintBar = this._targetButtonHintBar as BSButtonHintBar;
      }
      
      public function AddButtonHintData(param1:BSButtonHintData) : void
      {
         // method body index: 733 method index: 733
         if(!this.HasButtonHintData(param1))
         {
            this.buttonData.splice(0,0,param1);
         }
      }
      
      public function RemoveButtonHintData(param1:BSButtonHintData) : *
      {
         // method body index: 734 method index: 734
         var _loc2_:uint = 0;
         while(_loc2_ < this.buttonData.length)
         {
            if(this.buttonData[_loc2_] == param1)
            {
               this.buttonData.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function HasButtonHintData(param1:BSButtonHintData) : Boolean
      {
         // method body index: 735 method index: 735
         var _loc2_:uint = 0;
         while(_loc2_ < this.buttonData.length)
         {
            if(this.buttonData[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function connectButtonBar() : *
      {
         // method body index: 736 method index: 736
         if(this.buttonHintBar != null && this.buttonData != null && this._active)
         {
            this.buttonHintBar.SetButtonHintData(this.buttonData);
         }
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         // method body index: 737 method index: 737
         return false;
      }
   }
}
