 
package com.adobe.serialization.json
{
   public final class JSONToken
   {
      
      static const token:JSONToken = // method body index: 110 method index: 110
      new JSONToken();
       
      
      public var type:int;
      
      public var value:Object;
      
      public function JSONToken(param1:int = -1, param2:Object = null)
      {
         // method body index: 112 method index: 112
         super();
         this.type = param1;
         this.value = param2;
      }
      
      static function create(param1:int = -1, param2:Object = null) : JSONToken
      {
         // method body index: 111 method index: 111
         token.type = param1;
         token.value = param2;
         return token;
      }
   }
}
