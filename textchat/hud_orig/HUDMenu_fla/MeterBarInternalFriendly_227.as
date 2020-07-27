 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class MeterBarInternalFriendly_227 extends MovieClip
   {
       
      
      public var Contents:MovieClip;
      
      public function MeterBarInternalFriendly_227()
      {
         // method body index: 1165 method index: 1165
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,39,this.frame40);
      }
      
      function frame1() : *
      {
         // method body index: 1156 method index: 1156
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1157 method index: 1157
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1158 method index: 1158
         this["onBarFlashedDark"]();
      }
      
      function frame16() : *
      {
         // method body index: 1159 method index: 1159
         this["onBarFlashedBright"]();
      }
      
      function frame21() : *
      {
         // method body index: 1160 method index: 1160
         this["onBarFlashedDark"]();
      }
      
      function frame26() : *
      {
         // method body index: 1161 method index: 1161
         this["onBarFlashedBright"]();
      }
      
      function frame31() : *
      {
         // method body index: 1162 method index: 1162
         this["onBarFlashedDark"]();
      }
      
      function frame36() : *
      {
         // method body index: 1163 method index: 1163
         this["onBarFlashedBright"]();
      }
      
      function frame40() : *
      {
         // method body index: 1164 method index: 1164
         this["onBarFlashingDone"]();
      }
   }
}
