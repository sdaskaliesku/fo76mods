 
package Shared.AS3
{
   public class BGSExternalInterface
   {
       
      
      public function BGSExternalInterface()
      {
         // method body index: 140 method index: 140
         super();
      }
      
      public static function call(param1:Object, ... rest) : void
      {
         // method body index: 139 method index: 139
         var _loc3_:String = null;
         var _loc4_:Function = null;
         if(param1 != null)
         {
            _loc3_ = rest.shift();
            _loc4_ = param1[_loc3_];
            if(_loc4_ != null)
            {
               _loc4_.apply(null,rest);
            }
            else
            {
               trace("BGSExternalInterface::call -- Can\'t call function \'" + _loc3_ + "\' on BGSCodeObj. This function doesn\'t exist!");
            }
         }
         else
         {
            trace("BGSExternalInterface::call -- Can\'t call function \'" + _loc3_ + "\' on BGSCodeObj. BGSCodeObj is null!");
         }
      }
   }
}
