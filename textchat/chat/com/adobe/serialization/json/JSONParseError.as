 
package com.adobe.serialization.json
{
   public class JSONParseError extends Error
   {
       
      
      private var _location:int;
      
      private var _text:String;
      
      public function JSONParseError(param1:String = "", param2:int = 0, param3:String = "")
      {
         // method body index: 175 method index: 175
         super(param1);
         name = "JSONParseError";
         this._location = param2;
         this._text = param3;
      }
      
      public function get location() : int
      {
         // method body index: 176 method index: 176
         return this._location;
      }
      
      public function get text() : String
      {
         // method body index: 177 method index: 177
         return this._text;
      }
   }
}
