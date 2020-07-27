 
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
         // method body index: 3246 method index: 3246
         this._ButtonData = new Vector.<BSButtonHintData>();
         super();
         this.buttonHintBarTarget_Inspectable = "ButtonHintBar_mc";
      }
      
      public function get Active() : Boolean
      {
         // method body index: 3240 method index: 3240
         return this._active;
      }
      
      public function set Active(aActive:*) : void
      {
         // method body index: 3241 method index: 3241
         this._active = aActive;
         this.connectButtonBar();
      }
      
      public function get buttonHintBar() : BSButtonHintBar
      {
         // method body index: 3242 method index: 3242
         return this._ButtonHintBar;
      }
      
      public function set buttonHintBar(aObj:BSButtonHintBar) : *
      {
         // method body index: 3243 method index: 3243
         this._ButtonHintBar = aObj;
      }
      
      public function get buttonData() : Vector.<BSButtonHintData>
      {
         // method body index: 3244 method index: 3244
         return this._ButtonData;
      }
      
      public function set buttonData(value:Vector.<BSButtonHintData>) : void
      {
         // method body index: 3245 method index: 3245
         this._ButtonData = value;
      }
      
      private function onEnterFrame(e:Event) : *
      {
         // method body index: 3247 method index: 3247
         stage.dispatchEvent(new MenuComponentLoadedEvent(this));
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      override public function onAddedToStage() : void
      {
         // method body index: 3248 method index: 3248
         super.onAddedToStage();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function SetParentMenu(arParentMenu:IMenu) : *
      {
         // method body index: 3249 method index: 3249
         this.buttonHintBar = arParentMenu.buttonHintBar;
         this.connectButtonBar();
      }
      
      public function get buttonHintBarTarget_Inspectable() : Object
      {
         // method body index: 3250 method index: 3250
         return this._targetButtonHintBar;
      }
      
      public function set buttonHintBarTarget_Inspectable(newBar:Object) : void
      {
         // method body index: 3251 method index: 3251
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
         // method body index: 3252 method index: 3252
         if(!this.HasButtonHintData(aButtonData))
         {
            this.buttonData.splice(0,0,aButtonData);
         }
      }
      
      public function RemoveButtonHintData(aButtonData:BSButtonHintData) : *
      {
         // method body index: 3253 method index: 3253
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
         // method body index: 3254 method index: 3254
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
         // method body index: 3255 method index: 3255
         if(this.buttonHintBar != null && this.buttonData != null && this._active)
         {
            this.buttonHintBar.SetButtonHintData(this.buttonData);
         }
      }
      
      public function ProcessUserEvent(strEventName:String, abPressed:Boolean) : Boolean
      {
         // method body index: 3256 method index: 3256
         return false;
      }
   }
}
