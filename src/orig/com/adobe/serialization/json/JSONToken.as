 
package com.adobe.serialization.json
{
   public final class JSONToken
   {
      
      static const token:JSONToken = // method body index: 178 method index: 178
      new JSONToken();
       
      
      public var type:int;
      
      public var value:Object;
      
      public function JSONToken(type:int = -1, value:Object = null)
      {
         // method body index: 180 method index: 180
         super();
         this.type = type;
         this.value = value;
      }
      
      static function create(type:int = -1, value:Object = null) : JSONToken
      {
         // method body index: 179 method index: 179
         token.type = type;
         token.value = value;
         return token;
      }
   }
}
