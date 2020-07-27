 
package
{
   import Shared.AS3.BSUIComponent;
   
   public class HUDObjectiveItemData extends BSUIComponent
   {
       
      
      private var _objectiveMessage:String;
      
      private var _isCompleted:Boolean;
      
      private var _orWithPrevious:Boolean;
      
      public function HUDObjectiveItemData(param1:String, param2:Boolean, param3:Boolean)
      {
         // method body index: 3185 method index: 3185
         super();
         this._objectiveMessage = param1;
         this._isCompleted = param2;
         this._orWithPrevious = param3;
      }
      
      public function get ObjectiveMessage() : String
      {
         // method body index: 3186 method index: 3186
         return this._objectiveMessage;
      }
      
      public function get isCompleted() : Boolean
      {
         // method body index: 3187 method index: 3187
         return this._isCompleted;
      }
      
      public function get orWithPrevious() : Boolean
      {
         // method body index: 3188 method index: 3188
         return this._orWithPrevious;
      }
   }
}
