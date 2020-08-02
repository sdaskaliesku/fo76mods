 
package com.adobe.serialization.json
{
   public final class JSONToken
   {
      
      static const token:JSONToken = // method body index: 137 method index: 137
      new JSONToken();
       
      
      public var type:int;
      
      public var value:Object;
      
      public function JSONToken(param1:int = -1, param2:Object = null)
      {
         // method body index: 139 method index: 139
         super();
         this.type = param1;
         this.value = param2;
      }
      
      static function create(param1:int = -1, param2:Object = null) : JSONToken
      {
         // method body index: 138 method index: 138
         token.type = param1;
         token.value = param2;
         return token;
      }
   }
}
