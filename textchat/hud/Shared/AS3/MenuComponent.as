 
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
         // method body index: 3191 method index: 3191
         this._ButtonData = new Vector.<BSButtonHintData>();
         super();
         this.buttonHintBarTarget_Inspectable = "ButtonHintBar_mc";
      }
      
      public function get Active() : Boolean
      {
         // method body index: 3192 method index: 3192
         return this._active;
      }
      
      public function set Active(param1:*) : void
      {
         // method body index: 3193 method index: 3193
         this._active = param1;
         this.connectButtonBar();
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {
         // method body index: 3194 method index: 3194
         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(param1:BSButtonHintBar) : *
      {
         // method body index: 3195 method index: 3195
         this._ButtonHintBar = param1;
      }
      
      public function get buttonData() : Vector.<BSButtonHintData>
      {
         // method body index: 3196 method index: 3196
         return this._ButtonData;
      }
      
      public function set buttonData(param1:Vector.<BSButtonHintData>) : void
      {
         // method body index: 3197 method index: 3197
         this._ButtonData = param1;
      }
      
      private function onEnterFrame(param1:Event) : *
      {
         // method body index: 3198 method index: 3198
         stage.dispatchEvent(new MenuComponentLoadedEvent(this));
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3199 method index: 3199
         super.onAddedToStage();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function SetParentMenu(param1:IMenu) : *
      {
         // method body index: 3200 method index: 3200
         this.buttonHintBar = param1.buttonHintBar;
         this.connectButtonBar();
      }
      
      public function get buttonHintBarTarget_Inspectable() : Object
      {
         // method body index: 3201 method index: 3201
         return this._targetButtonHintBar;
      }
      
      public function set buttonHintBarTarget_Inspectable(param1:Object) : void
      {
         // method body index: 3202 method index: 3202
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
         // method body index: 3203 method index: 3203
         if(!this.HasButtonHintData(param1))
         {
            this.buttonData.splice(0,0,param1);
         }
      }
      
      public function RemoveButtonHintData(param1:BSButtonHintData) : *
      {
         // method body index: 3204 method index: 3204
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
         // method body index: 3205 method index: 3205
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
         // method body index: 3206 method index: 3206
         if(this.buttonHintBar != null && this.buttonData != null && this._active)
         {
            this.buttonHintBar.SetButtonHintData(this.buttonData);
         }
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         // method body index: 3207 method index: 3207
         return false;
      }
   }
}
