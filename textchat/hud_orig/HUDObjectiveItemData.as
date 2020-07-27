 
package
{
   import Shared.AS3.BSUIComponent;
   
   public class HUDObjectiveItemData extends BSUIComponent
   {
       
      
      private var _objectiveMessage:String;
      
      private var _isCompleted:Boolean;
      
      private var _orWithPrevious:Boolean;
      
      public function HUDObjectiveItemData(aObjectiveMessage:String, aIsCompleted:Boolean, aOrWithPrevious:Boolean)
      {
         // method body index: 3234 method index: 3234
         super();
         this._objectiveMessage = aObjectiveMessage;
         this._isCompleted = aIsCompleted;
         this._orWithPrevious = aOrWithPrevious;
      }
      
      public function get ObjectiveMessage() : String
      {
         // method body index: 3235 method index: 3235
         return this._objectiveMessage;
      }
      
      public function get isCompleted() : Boolean
      {
         // method body index: 3236 method index: 3236
         return this._isCompleted;
      }
      
      public function get orWithPrevious() : Boolean
      {
         // method body index: 3237 method index: 3237
         return this._orWithPrevious;
      }
   }
}
