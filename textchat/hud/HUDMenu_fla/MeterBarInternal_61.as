 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class MeterBarInternal_61 extends MovieClip
   {
       
      
      public var Contents:MovieClip;
      
      public function MeterBarInternal_61()
      {
         // method body index: 1094 method index: 1094
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,39,this.frame40);
      }
      
      function frame1() : *
      {
         // method body index: 1095 method index: 1095
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1096 method index: 1096
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1097 method index: 1097
         this["onBarFlashedDark"]();
      }
      
      function frame16() : *
      {
         // method body index: 1098 method index: 1098
         this["onBarFlashedBright"]();
      }
      
      function frame21() : *
      {
         // method body index: 1099 method index: 1099
         this["onBarFlashedDark"]();
      }
      
      function frame26() : *
      {
         // method body index: 1100 method index: 1100
         this["onBarFlashedBright"]();
      }
      
      function frame31() : *
      {
         // method body index: 1101 method index: 1101
         this["onBarFlashedDark"]();
      }
      
      function frame36() : *
      {
         // method body index: 1102 method index: 1102
         this["onBarFlashedBright"]();
      }
      
      function frame40() : *
      {
         // method body index: 1103 method index: 1103
         this["onBarFlashingDone"]();
      }
   }
}
