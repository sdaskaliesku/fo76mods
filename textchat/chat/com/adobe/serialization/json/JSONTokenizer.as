 
package com.adobe.serialization.json
{
   public class JSONTokenizer
   {
       
      
      private var strict:Boolean;
      
      private var obj:Object;
      
      private var jsonString:String;
      
      private var loc:int;
      
      private var ch:String;
      
      private const controlCharsRegExp:RegExp = // method body index: 115 method index: 115
      /[\x00-\x1F]/;
      
      public function JSONTokenizer(param1:String, param2:Boolean)
      {
         // method body index: 115 method index: 115
         super();
         this.jsonString = param1;
         this.strict = param2;
         this.loc = 0;
         this.nextChar();
      }
      
      public function getNextToken() : JSONToken
      {
         // method body index: 116 method index: 116
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:JSONToken = null;
         this.skipIgnored();
         switch(this.ch)
         {
            case "{":
               _loc5_ = JSONToken.create(JSONTokenType.LEFT_BRACE,this.ch);
               this.nextChar();
               break;
            case "}":
               _loc5_ = JSONToken.create(JSONTokenType.RIGHT_BRACE,this.ch);
               this.nextChar();
               break;
            case "[":
               _loc5_ = JSONToken.create(JSONTokenType.LEFT_BRACKET,this.ch);
               this.nextChar();
               break;
            case "]":
               _loc5_ = JSONToken.create(JSONTokenType.RIGHT_BRACKET,this.ch);
               this.nextChar();
               break;
            case ",":
               _loc5_ = JSONToken.create(JSONTokenType.COMMA,this.ch);
               this.nextChar();
               break;
            case ":":
               _loc5_ = JSONToken.create(JSONTokenType.COLON,this.ch);
               this.nextChar();
               break;
            case "t":
               _loc1_ = "t" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_loc1_ == "true")
               {
                  _loc5_ = JSONToken.create(JSONTokenType.TRUE,true);
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'true\' but found " + _loc1_);
               }
               break;
            case "f":
               _loc2_ = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
               if(_loc2_ == "false")
               {
                  _loc5_ = JSONToken.create(JSONTokenType.FALSE,false);
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'false\' but found " + _loc2_);
               }
               break;
            case "n":
               _loc3_ = "n" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_loc3_ == "null")
               {
                  _loc5_ = JSONToken.create(JSONTokenType.NULL,null);
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'null\' but found " + _loc3_);
               }
               break;
            case "N":
               _loc4_ = "N" + this.nextChar() + this.nextChar();
               if(_loc4_ == "NaN")
               {
                  _loc5_ = JSONToken.create(JSONTokenType.NAN,NaN);
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'NaN\' but found " + _loc4_);
               }
               break;
            case "\"":
               _loc5_ = this.readString();
               break;
            default:
               if(this.isDigit(this.ch) || this.ch == "-")
               {
                  _loc5_ = this.readNumber();
               }
               else if(this.ch == "")
               {
                  _loc5_ = null;
               }
               else
               {
                  this.parseError("Unexpected " + this.ch + " encountered");
               }
         }
         return _loc5_;
      }
      
      private final function readString() : JSONToken
      {
         // method body index: 117 method index: 117
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = this.loc;
         while(true)
         {
            _loc3_ = this.jsonString.indexOf("\"",_loc3_);
            if(_loc3_ >= 0)
            {
               _loc1_ = 0;
               _loc2_ = _loc3_ - 1;
               while(this.jsonString.charAt(_loc2_) == "\\")
               {
                  _loc1_++;
                  _loc2_--;
               }
               if((_loc1_ & 1) == 0)
               {
                  break;
               }
               _loc3_++;
            }
            else
            {
               this.parseError("Unterminated string literal");
            }
         }
         var _loc4_:JSONToken = JSONToken.create(JSONTokenType.STRING,this.unescapeString(this.jsonString.substr(this.loc,_loc3_ - this.loc)));
         this.loc = _loc3_ + 1;
         this.nextChar();
         return _loc4_;
      }
      
      public function unescapeString(param1:String) : String
      {
         // method body index: 118 method index: 118
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(this.strict && this.controlCharsRegExp.test(param1))
         {
            this.parseError("String contains unescaped control character (0x00-0x1F)");
         }
         var _loc8_:* = "";
         var _loc9_:int = 0;
         _loc2_ = 0;
         var _loc10_:int = param1.length;
         while(true)
         {
            _loc9_ = param1.indexOf("\\",_loc2_);
            if(_loc9_ >= 0)
            {
               _loc8_ = _loc8_ + param1.substr(_loc2_,_loc9_ - _loc2_);
               _loc2_ = _loc9_ + 2;
               _loc3_ = param1.charAt(_loc9_ + 1);
               switch(_loc3_)
               {
                  case "\"":
                     _loc8_ = _loc8_ + _loc3_;
                     break;
                  case "\\":
                     _loc8_ = _loc8_ + _loc3_;
                     break;
                  case "n":
                     _loc8_ = _loc8_ + "\n";
                     break;
                  case "r":
                     _loc8_ = _loc8_ + "\r";
                     break;
                  case "t":
                     _loc8_ = _loc8_ + "\t";
                     break;
                  case "u":
                     _loc4_ = "";
                     _loc5_ = _loc2_ + 4;
                     if(_loc5_ > _loc10_)
                     {
                        this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                     }
                     _loc6_ = _loc2_;
                     while(_loc6_ < _loc5_)
                     {
                        _loc7_ = param1.charAt(_loc6_);
                        if(!this.isHexDigit(_loc7_))
                        {
                           this.parseError("Excepted a hex digit, but found: " + _loc7_);
                        }
                        _loc4_ = _loc4_ + _loc7_;
                        _loc6_++;
                     }
                     _loc8_ = _loc8_ + String.fromCharCode(parseInt(_loc4_,16));
                     _loc2_ = _loc5_;
                     break;
                  case "f":
                     _loc8_ = _loc8_ + "\f";
                     break;
                  case "/":
                     _loc8_ = _loc8_ + "/";
                     break;
                  case "b":
                     _loc8_ = _loc8_ + "\b";
                     break;
                  default:
                     _loc8_ = _loc8_ + ("\\" + _loc3_);
               }
               if(_loc2_ >= _loc10_)
               {
                  break;
               }
               continue;
            }
            _loc8_ = _loc8_ + param1.substr(_loc2_);
            break;
         }
         return _loc8_;
      }
      
      private final function readNumber() : JSONToken
      {
         // method body index: 119 method index: 119
         var _loc1_:* = "";
         if(this.ch == "-")
         {
            _loc1_ = _loc1_ + "-";
            this.nextChar();
         }
         if(!this.isDigit(this.ch))
         {
            this.parseError("Expecting a digit");
         }
         if(this.ch == "0")
         {
            _loc1_ = _loc1_ + this.ch;
            this.nextChar();
            if(this.isDigit(this.ch))
            {
               this.parseError("A digit cannot immediately follow 0");
            }
            else if(!this.strict && this.ch == "x")
            {
               _loc1_ = _loc1_ + this.ch;
               this.nextChar();
               if(this.isHexDigit(this.ch))
               {
                  _loc1_ = _loc1_ + this.ch;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Number in hex format require at least one hex digit after \"0x\"");
               }
               while(this.isHexDigit(this.ch))
               {
                  _loc1_ = _loc1_ + this.ch;
                  this.nextChar();
               }
            }
         }
         else
         {
            while(this.isDigit(this.ch))
            {
               _loc1_ = _loc1_ + this.ch;
               this.nextChar();
            }
         }
         if(this.ch == ".")
         {
            _loc1_ = _loc1_ + ".";
            this.nextChar();
            if(!this.isDigit(this.ch))
            {
               this.parseError("Expecting a digit");
            }
            while(this.isDigit(this.ch))
            {
               _loc1_ = _loc1_ + this.ch;
               this.nextChar();
            }
         }
         if(this.ch == "e" || this.ch == "E")
         {
            _loc1_ = _loc1_ + "e";
            this.nextChar();
            if(this.ch == "+" || this.ch == "-")
            {
               _loc1_ = _loc1_ + this.ch;
               this.nextChar();
            }
            if(!this.isDigit(this.ch))
            {
               this.parseError("Scientific notation number needs exponent value");
            }
            while(this.isDigit(this.ch))
            {
               _loc1_ = _loc1_ + this.ch;
               this.nextChar();
            }
         }
         var _loc2_:Number = Number(_loc1_);
         if(isFinite(_loc2_) && !isNaN(_loc2_))
         {
            return JSONToken.create(JSONTokenType.NUMBER,_loc2_);
         }
         this.parseError("Number " + _loc2_ + " is not valid!");
         return null;
      }
      
      private final function nextChar() : String
      {
         // method body index: 120 method index: 120
         return this.ch = this.jsonString.charAt(this.loc++);
      }
      
      private final function skipIgnored() : void
      {
         // method body index: 121 method index: 121
         var _loc1_:int = 0;
         do
         {
            _loc1_ = this.loc;
            this.skipWhite();
            this.skipComments();
         }
         while(_loc1_ != this.loc);
         
      }
      
      private function skipComments() : void
      {
         // method body index: 122 method index: 122
         if(this.ch == "/")
         {
            this.nextChar();
            switch(this.ch)
            {
               case "/":
                  do
                  {
                     this.nextChar();
                  }
                  while(this.ch != "\n" && this.ch != "");
                  
                  this.nextChar();
                  break;
               case "*":
                  this.nextChar();
                  while(true)
                  {
                     if(this.ch == "*")
                     {
                        this.nextChar();
                        if(this.ch == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        this.nextChar();
                     }
                     if(this.ch == "")
                     {
                        this.parseError("Multi-line comment not closed");
                     }
                  }
                  this.nextChar();
                  break;
               default:
                  this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }
      
      private final function skipWhite() : void
      {
         // method body index: 123 method index: 123
         while(this.isWhiteSpace(this.ch))
         {
            this.nextChar();
         }
      }
      
      private final function isWhiteSpace(param1:String) : Boolean
      {
         // method body index: 124 method index: 124
         if(param1 == " " || param1 == "\t" || param1 == "\n" || param1 == "\r")
         {
            return true;
         }
         if(!this.strict && param1.charCodeAt(0) == 160)
         {
            return true;
         }
         return false;
      }
      
      private final function isDigit(param1:String) : Boolean
      {
         // method body index: 125 method index: 125
         return param1 >= "0" && param1 <= "9";
      }
      
      private final function isHexDigit(param1:String) : Boolean
      {
         // method body index: 126 method index: 126
         return this.isDigit(param1) || param1 >= "A" && param1 <= "F" || param1 >= "a" && param1 <= "f";
      }
      
      public final function parseError(param1:String) : void
      {
         // method body index: 127 method index: 127
         throw new JSONParseError(param1,this.loc,this.jsonString);
      }
   }
}
