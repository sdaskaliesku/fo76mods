 
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
      
      public function set Active(aActive:*) : void
      {

         this._active = aActive;
         this.connectButtonBar();
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {

         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(aObj:BSButtonHintBar) : *
      {

         this._ButtonHintBar = aObj;
      }
      
      public function get buttonData() : Vector.<BSButtonHintData>
      {

         return this._ButtonData;
      }
      
      public function set buttonData(value:Vector.<BSButtonHintData>) : void
      {

         this._ButtonData = value;
      }
      
      private function onEnterFrame(e:Event) : *
      {

         stage.dispatchEvent(new MenuComponentLoadedEvent(this));
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      override public function onAddedToStage() : void
      {

         super.onAddedToStage();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function SetParentMenu(arParentMenu:IMenu) : *
      {

         this.buttonHintBar = arParentMenu.buttonHintBar;
         this.connectButtonBar();
      }
      
      public function get buttonHintBarTarget_Inspectable() : Object
      {

         return this._targetButtonHintBar;
      }
      
      public function set buttonHintBarTarget_Inspectable(newBar:Object) : void
      {

         var newbarObject:* = Object;
         if(newBar is String)
         {
            if(newBar.toString() == "" || parent == null)
            {
               return;
            }
            newbarObject = parent.getChildByName(newBar.toString()) as Object;
            if(newbarObject == null)
            {
               if(parent.parent)
               {
                  newbarObject = parent.parent.getChildByName(newBar.toString());
                  if(newbarObject == null)
                  {
                     return;
                  }
               }
            }
         }
         else
         {
            newbarObject = newBar;
         }
         this._targetButtonHintBar = newbarObject;
         this.buttonHintBar = this._targetButtonHintBar as BSButtonHintBar;
      }
      
      public function AddButtonHintData(aButtonData:BSButtonHintData) : void
      {

         if(!this.HasButtonHintData(aButtonData))
         {
            this.buttonData.splice(0,0,aButtonData);
         }
      }
      
      public function RemoveButtonHintData(aButtonData:BSButtonHintData) : *
      {

         for(var i:uint = 0; i < this.buttonData.length; i++)
         {
            if(this.buttonData[i] == aButtonData)
            {
               this.buttonData.splice(i,1);
               break;
            }
         }
      }
      
      public function HasButtonHintData(aButtonData:BSButtonHintData) : Boolean
      {

         for(var i:uint = 0; i < this.buttonData.length; i++)
         {
            if(this.buttonData[i] == aButtonData)
            {
               return true;
            }
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
      
      public function ProcessUserEvent(strEventName:String, abPressed:Boolean) : Boolean
      {

         return false;
      }
   }
}
