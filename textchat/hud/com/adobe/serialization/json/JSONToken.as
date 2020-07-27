 
package com.adobe.serialization.json
{
   public final class JSONToken
   {
      
      static const token:JSONToken = // method body index: 329 method index: 329
      new JSONToken();
       
      
      public var type:int;
      
      public var value:Object;
      
      public function JSONToken(param1:int = -1, param2:Object = null)
      {
         // method body index: 331 method index: 331
         super();
         this.type = param1;
         this.value = param2;
      }
      
      static function create(param1:int = -1, param2:Object = null) : JSONToken
      {
         // method body index: 330 method index: 330
         token.type = param1;
         token.value = param2;
         return token;
      }
   }
}
