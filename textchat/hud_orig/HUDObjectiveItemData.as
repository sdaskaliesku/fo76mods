 
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

         super();
         this._objectiveMessage = aObjectiveMessage;
         this._isCompleted = aIsCompleted;
         this._orWithPrevious = aOrWithPrevious;
      }
      
      public function get ObjectiveMessage() : String
      {

         return this._objectiveMessage;
      }
      
      public function get isCompleted() : Boolean
      {

         return this._isCompleted;
      }
      
      public function get orWithPrevious() : Boolean
      {

         return this._orWithPrevious;
      }
   }
}
