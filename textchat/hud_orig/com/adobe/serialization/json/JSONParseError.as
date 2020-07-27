 
package com.adobe.serialization.json
{
   public class JSONParseError extends Error
   {
       
      
      private var _location:int;
      
      private var _text:String;
      
      public function JSONParseError(message:String = "", location:int = 0, text:String = "")
      {
         // method body index: 452 method index: 452
         super(message);
         name = "JSONParseError";
         this._location = location;
         this._text = text;
      }
      
      public function get location() : int
      {
         // method body index: 453 method index: 453
         return this._location;
      }
      
      public function get text() : String
      {
         // method body index: 454 method index: 454
         return this._text;
      }
   }
}
