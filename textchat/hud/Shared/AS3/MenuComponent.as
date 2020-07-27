 
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

         this._ButtonData = new Vector.<BSButtonHintData>();
         super();
         this.buttonHintBarTarget_Inspectable = "ButtonHintBar_mc";
      }
      
      public function get Active() : Boolean
      {

         return this._active;
      }
      
      public function set Active(param1:*) : void
      {

         this._active = param1;
         this.connectButtonBar();
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {

         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(param1:BSButtonHintBar) : *
      {

         this._ButtonHintBar = param1;
      }
      
      public function get buttonData() : Vector.<BSButtonHintData>
      {

         return this._ButtonData;
      }
      
      public function set buttonData(param1:Vector.<BSButtonHintData>) : void
      {

         this._ButtonData = param1;
      }
      
      private function onEnterFrame(param1:Event) : *
      {

         stage.dispatchEvent(new MenuComponentLoadedEvent(this));
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      override public function onAddedToStage() : void
      {

         super.onAddedToStage();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function SetParentMenu(param1:IMenu) : *
      {

         this.buttonHintBar = param1.buttonHintBar;
         this.connectButtonBar();
      }
      
      public function get buttonHintBarTarget_Inspectable() : Object
      {

         return this._targetButtonHintBar;
      }
      
      public function set buttonHintBarTarget_Inspectable(param1:Object) : void
      {

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

         if(!this.HasButtonHintData(param1))
         {
            this.buttonData.splice(0,0,param1);
         }
      }
      
      public function RemoveButtonHintData(param1:BSButtonHintData) : *
      {

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

         if(this.buttonHintBar != null && this.buttonData != null && this._active)
         {
            this.buttonHintBar.SetButtonHintData(this.buttonData);
         }
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {

         return false;
      }
   }
}
