 
package com.adobe.serialization.json
{
   public final class JSONToken
   {
      
      static const token:JSONToken = // method body index: 332 method index: 332
      new JSONToken();
       
      
      public var type:int;
      
      public var value:Object;
      
      public function JSONToken(type:int = -1, value:Object = null)
      {
         // method body index: 334 method index: 334
         super();
         this.type = type;
         this.value = value;
      }
      
      static function create(type:int = -1, value:Object = null) : JSONToken
      {
         // method body index: 333 method index: 333
         token.type = type;
         token.value = value;
         return token;
      }
   }
}
