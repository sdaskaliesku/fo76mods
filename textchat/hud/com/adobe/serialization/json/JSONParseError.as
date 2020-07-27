 
package com.adobe.serialization.json
{
   public class JSONParseError extends Error
   {
       
      
      private var _location:int;
      
      private var _text:String;
      
      public function JSONParseError(param1:String = "", param2:int = 0, param3:String = "")
      {
         // method body index: 449 method index: 449
         super(param1);
         name = "JSONParseError";
         this._location = param2;
         this._text = param3;
      }
      
      public function get location() : int
      {
         // method body index: 450 method index: 450
         return this._location;
      }
      
      public function get text() : String
      {
         // method body index: 451 method index: 451
         return this._text;
      }
   }
}
