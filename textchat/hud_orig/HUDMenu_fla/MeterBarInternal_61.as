 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class MeterBarInternal_61 extends MovieClip
   {
       
      
      public var Contents:MovieClip;
      
      public function MeterBarInternal_61()
      {
         // method body index: 1177 method index: 1177
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,39,this.frame40);
      }
      
      function frame1() : *
      {
         // method body index: 1168 method index: 1168
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1169 method index: 1169
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1170 method index: 1170
         this["onBarFlashedDark"]();
      }
      
      function frame16() : *
      {
         // method body index: 1171 method index: 1171
         this["onBarFlashedBright"]();
      }
      
      function frame21() : *
      {
         // method body index: 1172 method index: 1172
         this["onBarFlashedDark"]();
      }
      
      function frame26() : *
      {
         // method body index: 1173 method index: 1173
         this["onBarFlashedBright"]();
      }
      
      function frame31() : *
      {
         // method body index: 1174 method index: 1174
         this["onBarFlashedDark"]();
      }
      
      function frame36() : *
      {
         // method body index: 1175 method index: 1175
         this["onBarFlashedBright"]();
      }
      
      function frame40() : *
      {
         // method body index: 1176 method index: 1176
         this["onBarFlashingDone"]();
      }
   }
}
