 
package com.adobe.serialization.json
{
   public class JSONParseError extends Error
   {
       
      
      private var _location:int;
      
      private var _text:String;
      
      public function JSONParseError(message:String = "", location:int = 0, text:String = "")
      {
         // method body index: 251 method index: 251
         super(message);
         name = "JSONParseError";
         this._location = location;
         this._text = text;
      }
      
      public function get location() : int
      {
         // method body index: 252 method index: 252
         return this._location;
      }
      
      public function get text() : String
      {
         // method body index: 253 method index: 253
         return this._text;
      }
   }
}
