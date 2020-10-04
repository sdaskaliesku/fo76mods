 
package com.adobe.serialization.json
{
   public class JSONDecoder
   {
       
      
      private var strict:Boolean;
      
      private var value;
      
      private var tokenizer:JSONTokenizer;
      
      private var token:JSONToken;
      
      public function JSONDecoder(param1:String, param2:Boolean)
      {
         // method body index: 109 method index: 109
         super();
         this.strict = param2;
         this.tokenizer = new JSONTokenizer(param1,param2);
         this.nextToken();
         this.value = this.parseValue();
         if(param2 && this.nextToken() != null)
         {
            this.tokenizer.parseError("Unexpected characters left in input stream");
         }
      }
      
      public function getValue() : *
      {
         // method body index: 110 method index: 110
         return this.value;
      }
      
      private final function nextToken() : JSONToken
      {
         // method body index: 111 method index: 111
         return this.token = this.tokenizer.getNextToken();
      }
      
      private final function nextValidToken() : JSONToken
      {
         // method body index: 112 method index: 112
         this.token = this.tokenizer.getNextToken();
         this.checkValidToken();
         return this.token;
      }
      
      private final function checkValidToken() : void
      {
         // method body index: 113 method index: 113
         if(this.token == null)
         {
            this.tokenizer.parseError("Unexpected end of input");
         }
      }
      
      private final function parseArray() : Array
      {
         // method body index: 114 method index: 114
         var _loc1_:Array = new Array();
         this.nextValidToken();
         if(this.token.type == JSONTokenType.RIGHT_BRACKET)
         {
            return _loc1_;
         }
         if(!this.strict && this.token.type == JSONTokenType.COMMA)
         {
            this.nextValidToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
               return _loc1_;
            }
            this.tokenizer.parseError("Leading commas are not supported.  Expecting \']\' but found " + this.token.value);
         }
         while(true)
         {
            _loc1_.push(this.parseValue());
            this.nextValidToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
               break;
            }
            if(this.token.type == JSONTokenType.COMMA)
            {
               this.nextToken();
               if(!this.strict)
               {
                  this.checkValidToken();
                  if(this.token.type == JSONTokenType.RIGHT_BRACKET)
                  {
                     return _loc1_;
                  }
               }
            }
            else
            {
               this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
         }
         return _loc1_;
      }
      
      private final function parseObject() : Object
      {
         // method body index: 115 method index: 115
         var _loc2_:String = null;
         var _loc1_:Object = new Object();
         this.nextValidToken();
         if(this.token.type == JSONTokenType.RIGHT_BRACE)
         {
            return _loc1_;
         }
         if(!this.strict && this.token.type == JSONTokenType.COMMA)
         {
            this.nextValidToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACE)
            {
               return _loc1_;
            }
            this.tokenizer.parseError("Leading commas are not supported.  Expecting \'}\' but found " + this.token.value);
         }
         while(true)
         {
            if(this.token.type == JSONTokenType.STRING)
            {
               _loc2_ = String(this.token.value);
               this.nextValidToken();
               if(this.token.type == JSONTokenType.COLON)
               {
                  this.nextToken();
                  _loc1_[_loc2_] = this.parseValue();
                  this.nextValidToken();
                  if(this.token.type == JSONTokenType.RIGHT_BRACE)
                  {
                     break;
                  }
                  if(this.token.type == JSONTokenType.COMMA)
                  {
                     this.nextToken();
                     if(!this.strict)
                     {
                        this.checkValidToken();
                        if(this.token.type == JSONTokenType.RIGHT_BRACE)
                        {
                           return _loc1_;
                        }
                     }
                  }
                  else
                  {
                     this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                  }
               }
               else
               {
                  this.tokenizer.parseError("Expecting : but found " + this.token.value);
               }
            }
            else
            {
               this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
         }
         return _loc1_;
      }
      
      private final function parseValue() : Object
      {
         // method body index: 116 method index: 116
         this.checkValidToken();
         switch(this.token.type)
         {
            case JSONTokenType.LEFT_BRACE:
               return this.parseObject();
            case JSONTokenType.LEFT_BRACKET:
               return this.parseArray();
            case JSONTokenType.STRING:
            case JSONTokenType.NUMBER:
            case JSONTokenType.TRUE:
            case JSONTokenType.FALSE:
            case JSONTokenType.NULL:
               return this.token.value;
            case JSONTokenType.NAN:
               if(!this.strict)
               {
                  return this.token.value;
               }
               this.tokenizer.parseError("Unexpected " + this.token.value);
            default:
               this.tokenizer.parseError("Unexpected " + this.token.value);
               return null;
         }
      }
   }
}
